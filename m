Return-Path: <linux-kernel+bounces-559020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523CA5EE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C86189A312
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA42641E6;
	Thu, 13 Mar 2025 08:50:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9545263F32
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855809; cv=none; b=B87KuumIG7EhjH1LDVWK7IoSdLjMVCE9uO/y+YPHwAhSULkiFSv4mhKNwJuAfMVPT2sWSGsTQABv7O8ib0bCMp4BauknyGKX3WmWAVUvYO8r1w1OMYXEe9LQrGdct3yXyYU97oCJjZ7NwWUfxikMJEegxB6lm6JRu/i+mzM4zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855809; c=relaxed/simple;
	bh=FdXXR1xQ4bVnuZPsFcJ26VAmRweYc/ljX9b9eYfnA4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qr+sAxprAcBcOQdv4ohCuOKcBRVDmEgZvKnm1WOBeoK7jJdQ6s3oXLYH6mtWfXElPKfv3Z6+YX6CDKQW0h3KXE2Sus4kTR+DWSQdMr2E+JobUnS+fN3DLfkHBIX744JKYOFD9xmVWnkhO0sC/zv/LUkPsMO60Mkhj2m6oGg6S2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGP-0001HU-D8; Thu, 13 Mar 2025 09:50:01 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGP-005VRX-0Z;
	Thu, 13 Mar 2025 09:50:01 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseGP-0003wz-0J;
	Thu, 13 Mar 2025 09:50:01 +0100
Message-ID: <fa934fa74bf78cccf6a51cef20c294576e425810.camel@pengutronix.de>
Subject: Re: [PATCH v5 5/8] reset: imx8mp-audiomix: Prepare the code for
 more reset bits
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org,
 krzk+dt@kernel.org,  shawnguo@kernel.org, mathieu.poirier@linaro.org,
 devicetree@vger.kernel.org,  linux-remoteproc@vger.kernel.org
Cc: conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, andersson@kernel.org,
 Frank.Li@nxp.com,  peng.fan@nxp.com, laurentiu.mihalcea@nxp.com,
 iuliana.prodan@nxp.com,  shengjiu.wang@nxp.com
Date: Thu, 13 Mar 2025 09:50:01 +0100
In-Reply-To: <20250311085812.1296243-6-daniel.baluta@nxp.com>
References: <20250311085812.1296243-1-daniel.baluta@nxp.com>
	 <20250311085812.1296243-6-daniel.baluta@nxp.com>
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
> Current code supports EARC PHY Software Reset and EARC Software Reset
> but it is not easily extensible to more reset bits.
>=20
> So, refactor the code in order to easily allow more reset bits in the
> future.
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

