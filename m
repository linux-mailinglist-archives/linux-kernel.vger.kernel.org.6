Return-Path: <linux-kernel+bounces-169544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B448D8BCA27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57281C21AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1F1420B9;
	Mon,  6 May 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PDKE8Egb"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925071422BB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985985; cv=none; b=r4ESnZ+ratLpHHAPtqRltwaKKvUVm0KjsH61zvOzOmwRs5+8K1FnwIwWQVM5QOJpxI7FGI88/LMe4SH0czbbbv3z5VNLEC21M6bQVaP/1z6R56InCHN7d1CTfX0JhQ1yDmssMjjssNdTe3Ho7A1eVK6XeLWsPksMIA2faVgBMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985985; c=relaxed/simple;
	bh=zI9aKrE6NiMa73k6e2lcD5sd2ANI0ztCC+XSoAVmyY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc/jUmE9vU6I33XBI4TvK8JWJy4hzNML+KUxbrYvNWkpSXLHSdjMclpEixcgV6WvqE6G9HQGZy9+YdkqAUTNZEGu7zTJxmI+CkAaYHxq/XjFDKhNP1xg8ijprREocq8e9yPpP1HdeI/igcyXOHRVWZsPNhUZGxWTsAS7XbJkPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PDKE8Egb; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 119A61BF204;
	Mon,  6 May 2024 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714985981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLoumWwq12QqlpvmyZ6oFlX+y9BSSofQN7u2jFCOtaU=;
	b=PDKE8EgbLksMFP97qVMtx6poecdit3R82OTJQweQ2bJqnbujyZk+/pcORyzyP1UUWMRlbq
	05Y1ZDNkYGMsz5OUnU+ODdIo4ZCDxwIvOZZ778OwJHHC3vfiVftnyUm7wEcZ81yRR8eIxe
	mPlvhQPNe7r+xTt0d2y/uO0G/Thdl77yA4J1GouPLtIFG5qxszkA9/GPXxlXEFWEofqGiT
	Uaa3D/EXUhelQLkNKZP/rDPmbyGtb+WL07+yLSVKMxlVC7U9silYUf+4CGTESXUnueIT6u
	W0CXbThvRLGP48xY4/qXuGTZ7Ro7vbqSKPF+oZBiqpHGMageYRumhGNp960MPQ==
Date: Mon, 6 May 2024 10:59:40 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org (moderated
 list:SILVACO I3C DUAL-ROLE MASTER), linux-kernel@vger.kernel.org (open
 list), imx@lists.linux.dev
Subject: Re: [PATCH 2/2] i3c: master: svc: fix invalidate IBI type and miss
 call client IBI handler
Message-ID: <20240506105940.5d8d2308@xps-13>
In-Reply-To: <20240424190030.857632-2-Frank.Li@nxp.com>
References: <20240424190030.857632-1-Frank.Li@nxp.com>
	<20240424190030.857632-2-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 24 Apr 2024 15:00:30 -0400:

> In an In-Band Interrupt (IBI) handle, the code logic is as follows:
>=20
> 1: writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI | SVC_I3C_MCTRL_IBIRESP_AUTO,
> 	  master->regs + SVC_I3C_MCTRL);
>=20
> 2: ret =3D readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
>                                     SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
> 	...
> 3: ibitype =3D SVC_I3C_MSTATUS_IBITYPE(status);
>    ibiaddr =3D SVC_I3C_MSTATUS_IBIADDR(status);
>=20
> SVC_I3C_MSTATUS_IBIWON may be set before step 1. Thus, step 2 will return
> immediately, and the I3C controller has not sent out the 9th SCL yet.
> Consequently, ibitype and ibiaddr are 0, resulting in an unknown IBI type
> occurrence and missing call I3C client driver's IBI handler.
>=20
> A typical case is that SVC_I3C_MSTATUS_IBIWON is set when an IBI occurs
> during the controller send start frame in svc_i3c_master_xfer().
>=20
> Clear SVC_I3C_MSTATUS_IBIWON before issue SVC_I3C_MCTRL_REQUEST_AUTO_IBI
> to fix this issue.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI ha=
ppen during start frame")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index a2298ab460a37..3bfe8e694f840 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -415,6 +415,9 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  	int ret;
> =20
>  	mutex_lock(&master->lock);
> +	/* Clear the interrupt status */

Could you improve the comment to explain why this is needed here?

Otherwise seems okay, but I don't have any strong feelings here.

> +	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> +
>  	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
>  	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
>  	       SVC_I3C_MCTRL_IBIRESP_AUTO,
> @@ -429,9 +432,6 @@ static void svc_i3c_master_ibi_work(struct work_struc=
t *work)
>  		goto reenable_ibis;
>  	}
> =20
> -	/* Clear the interrupt status */
> -	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> -
>  	status =3D readl(master->regs + SVC_I3C_MSTATUS);
>  	ibitype =3D SVC_I3C_MSTATUS_IBITYPE(status);
>  	ibiaddr =3D SVC_I3C_MSTATUS_IBIADDR(status);

Thanks,
Miqu=C3=A8l

