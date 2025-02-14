Return-Path: <linux-kernel+bounces-514802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0DA35BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645D016FC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1925A353;
	Fri, 14 Feb 2025 10:50:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24937253341
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530232; cv=none; b=TjaTatFwmLanl402K89u/OIk7sI5Qf6CKBS+KpVTVcwqz5VvITSueE43s0BnfD4GnkEAqS0iJvMOLlBPibavuXwh+lMZPZUashHErIwkZr+usAZN5o3mDmwivRBaxuHhoUXazHcu0aPUxGtzh7EAJX8y9NOpOp5RMCq6kURnam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530232; c=relaxed/simple;
	bh=/CH1TrjUT2cU5KmVgsPP8P1FDrNBDXDBWaxPmNq0yw8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ek6xCIxB8kKl9dt/sa2rSnvwJrGPpx992z3R3WjBMX+CQ/8MTWwba9HmgpzjHoc875E/+nzMyxpViWz7+bjpChWciybwRMK/n1GyPux7t35+95zwP+XbVGisPnNNz/5Jyv8rG3NUuKhfvs7+/zXOlA3Ojx2dfe46jyzayoCHGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1titGW-00054d-06; Fri, 14 Feb 2025 11:49:48 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1titGV-000u4C-0W;
	Fri, 14 Feb 2025 11:49:47 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1titGV-0004XM-0F;
	Fri, 14 Feb 2025 11:49:47 +0100
Message-ID: <067e9396ed8629efa7190c0103ac3a29d0c469d8.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] phy: qcom: pcie: Determine has_nocsr_reset
 dynamically
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wenbin Yao <quic_wenbyao@quicinc.com>, vkoul@kernel.org,
 kishon@kernel.org,  dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
 quic_qianyu@quicinc.com,  neil.armstrong@linaro.org,
 manivannan.sadhasivam@linaro.org,  quic_devipriy@quicinc.com,
 konrad.dybcio@oss.qualcomm.com,  linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org,  linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 11:49:46 +0100
In-Reply-To: <20250214104539.281846-2-quic_wenbyao@quicinc.com>
References: <20250214104539.281846-1-quic_wenbyao@quicinc.com>
	 <20250214104539.281846-2-quic_wenbyao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2025-02-14 at 18:45 +0800, Wenbin Yao wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> Decide the in-driver logic based on whether the nocsr reset is present
> and defer checking the appropriateness of that to dt-bindings to save
> on boilerplate.
>=20
> Reset controller APIs are fine consuming a nullptr, so no additional
> checks are necessary there.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

