Return-Path: <linux-kernel+bounces-559019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E7A5EE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CDD7AC0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F22263F21;
	Thu, 13 Mar 2025 08:50:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED2263C8A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855807; cv=none; b=Xe/XsGxHbOPUUshQSrDeomDDsueFU6VTUwxgEyYAMPAQwSCc6gnu87ZeFBNtJjyHcUBpR7LKs+sya+G51Mxpyb6k6tYLiEJNBjO4H2gx+riDMRRTcTUWnywd8Jpsevw0Hf1eWCbfZvN84kBMWKmAMGTV8nJ+J1/wLEi45+YTi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855807; c=relaxed/simple;
	bh=QlLHZIgUEXLJ1A4VhDTFiqfve7pfF8vpaw5UvbfUxiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDYYqXasdi0mHZuAUdU2g+KHAIYnu86nhOfykuQMBRIFc7CVSSM8ASOun/eAna1ZAlxF2EuZjy4tPsjWq1JzChNTt5fdTd9Kln00NU/5M9/4rGt2jeqr0Sw2/N6w/TAWgiDuVPb7CHdbNorLEelGHVA37GXKJ1F/TPePGDlpwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGN-0001Gu-AA; Thu, 13 Mar 2025 09:49:59 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGM-005VRT-2g;
	Thu, 13 Mar 2025 09:49:58 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGM-0003wf-2R;
	Thu, 13 Mar 2025 09:49:58 +0100
Message-ID: <d138f147c5df4091418ba8131cdc02c349c7d0ef.camel@pengutronix.de>
Subject: Re: [PATCH v5 7/8] reset: imx8mp-audiomix: Add support for DSP
 run/stall
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org,
 krzk+dt@kernel.org,  shawnguo@kernel.org, mathieu.poirier@linaro.org,
 devicetree@vger.kernel.org,  linux-remoteproc@vger.kernel.org
Cc: conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, andersson@kernel.org,
 Frank.Li@nxp.com,  peng.fan@nxp.com, laurentiu.mihalcea@nxp.com,
 iuliana.prodan@nxp.com,  shengjiu.wang@nxp.com
Date: Thu, 13 Mar 2025 09:49:58 +0100
In-Reply-To: <20250311085812.1296243-8-daniel.baluta@nxp.com>
References: <20250311085812.1296243-1-daniel.baluta@nxp.com>
	 <20250311085812.1296243-8-daniel.baluta@nxp.com>
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

On Di, 2025-03-11 at 10:58 +0200, Daniel Baluta wrote:
> We can Run/Stall the DSP via audio block control bits found in audiomix.
> Implement this functionality using the reset controller and use assert
> for Stall and deassert for Run.
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

