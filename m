Return-Path: <linux-kernel+bounces-169537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA108BCA14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A61C20FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495331420D4;
	Mon,  6 May 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ApPpNERI"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BA13774B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985696; cv=none; b=bfTGPR/NOPKYsfOZXpCYpXq88peujPhC4WNPW21uVIioqx0HBLsVn3GzhxuoO3G31fmTL6QfoGaAgvDhtq3KQfcditbF64brNFprhc7MaejaNNfEFVFi2/8BF2t5ldiKrAf2MHFXvOOwd9MDxiRfi9MH/aw5uWJe8A03ctTtkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985696; c=relaxed/simple;
	bh=fD2iXQIxQO1O7t0yL8276/zUtOXwPZze/133iLrLiNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYI8v69U2w6MsauRPwKJTYxBhMDYAP35vHjnr/rqXScw16aoZZshnCJgzhhGjJ1vpE4GoiEOPxWt3iN3O/zxd4DrAb8jF8/Ml1yTsGw0wDXDRsB9t2pbH9i6nC705PP9vBMCr1uiZWNSqKgLFHlyd01iyTp7G9zC/dud5F5zC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ApPpNERI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80946C0015;
	Mon,  6 May 2024 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714985693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXrjSateGikcCPRPsOAFErk3+6M1AzwYZKnymVg6nJw=;
	b=ApPpNERIDYb7v5HNNv2O3UmGLL3XrVpcmUG/KTbGeWUn0nSwFZ7Y1fOQG4eLDDMMLFXZjN
	IVNxqKtITNEsAIsD+5l1wCshGzNAszAec+sJVNetqbe/zDkUoR95xvspSzimcIBmE4AVX9
	bzBlCLmqpedbcg9BRsSLQ9G378ogtXYUTGg74IcaE5nsk/XIaDocF1jbTL+pwkbORC0/cB
	ci8mGZazK+SLG7XWnZsEMQarqfKQyNXGd3kHgCboKm/B0FNlxkSN37jt0vCU+qJnvfYCDC
	wVSkUHiUciz9ceslcnbEnu6PJanl0Int2TrGEnpGVpyqO+akReJJY/OyNKpSyQ==
Date: Mon, 6 May 2024 10:54:51 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org (moderated
 list:SILVACO I3C DUAL-ROLE MASTER), linux-kernel@vger.kernel.org (open
 list), imx@lists.linux.dev
Subject: Re: [PATCH 1/2] i3c: master: svc: change ENXIO to EAGAIN when IBI
 occurs during start frame
Message-ID: <20240506105451.26e40778@xps-13>
In-Reply-To: <20240424190030.857632-1-Frank.Li@nxp.com>
References: <20240424190030.857632-1-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Wed, 24 Apr 2024 15:00:29 -0400:

> svc_i3c_master_xfer() returns error ENXIO if an In-Band Interrupt (IBI)
> occurs when the host starts the frame.
>=20
> Change error code to EAGAIN to inform the client driver that this
> situation has occurred and to try again sometime later.

This changes slightly the user API, but feels legitimate at the same
time. Maybe a comment somewhere in the i3c headers to clarify this
possibility might be welcome?

> Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI ha=
ppen during start frame")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 5ee4db68988e2..a2298ab460a37 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1080,7 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_maste=
r *master,
>  	 * and yield the above events handler.
>  	 */
>  	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
> -		ret =3D -ENXIO;
> +		ret =3D -EAGAIN;
>  		*actual_len =3D 0;
>  		goto emit_stop;
>  	}


Thanks,
Miqu=C3=A8l

