Return-Path: <linux-kernel+bounces-346606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC898C697
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CEF28276B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48B1CDA0D;
	Tue,  1 Oct 2024 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k9PwsBOX"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE11C7B83
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813756; cv=none; b=hFV6yEnOVaMADsN63cMcYuacz+IqTgOztWcKSg3Wy1G+cewq2ZoR3PTtxUh6UDvWpy1WTqLVLcOESpVS+w1iogsYO375Jq0gCi2R2KxmPf/CdtjUCp4NO4UiY1w+lUKQ2ccE82wO1w2aKaSG6U1JP5eCx79pXqJU9+MrAQLeRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813756; c=relaxed/simple;
	bh=BFEOQAY9BGca+ceIIsxbmpcSm62aqvxMDpxklJdYbd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQh6VwLGikHKuYwdULfA9jJJfsfjmob59DkvH+yzUylBdOs8QjNzb0mdqvK1KD6Ej1eGifiBXzGh/H8Mo4/Mz51jgHXM/l607sQu2jWww46wB+xM95mY5ygX1qblY15zrBvk83df9k/FLZlZ2C6Cyo/T/kAwQ97FRlkC7KceQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k9PwsBOX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12F7360002;
	Tue,  1 Oct 2024 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727813753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMCu9S88LmTnOV1hGWnst/c8TivrKNRNEF/23Xt/h18=;
	b=k9PwsBOXL/lyCjGDXNmyyVzLqsheJ/JP+CYlorocEKoO5U/wUuNCF6TtqzeloxkBo6dTgA
	uhU+m4wfslqxbRGYbUZ4lb0HwjUHH34wrzMOgPSioWHzDWNs03PK7rpdU1wdUTNY7+1zia
	VxR9CukznPbu6lFlgKNEE0GAOUbUuXqhG8UQRjkYYaCyMVgOMc0R2PL/yLHQNiLlxhAf7b
	OepbniovvKC3Wh1bPWdwqEBppmdwNDHWP0ijVwvXd9xBYH50OjVK7RNiMKysmP10vSw9Pi
	Je1ZutsHu/ugO90n377Zog2F4HTyurduFilaYdprhzmI/OAuy7mNjeB+ucqSbw==
Date: Tue, 1 Oct 2024 22:15:51 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 5/6] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Message-ID: <20241001221551.27dc2301@xps-13>
In-Reply-To: <20241001-svc-i3c-hj-v5-5-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
	<20241001-svc-i3c-hj-v5-5-480ab8aed849@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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

Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 12:02:54 -0400:

> Wait for the controller to complete emitting ACK/NACK, otherwise the next
> command may be omitted by the hardware.
>=20
> A "command done" check in svc_i3c_master_nack(ack)_ibi() and change the

Add a?

> return type to int to flag possible timeouts.
>=20
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - rework commit message
> - add miquel's review tag
> - directly return readl(...)
> ---
>  drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 1ee6ce186195c..3388c9af63fcc 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -388,10 +388,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c=
_master *master,
>  	return 0;
>  }
> =20
> -static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> +static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
>  				   bool mandatory_byte)
>  {
>  	unsigned int ibi_ack_nack;
> +	u32 reg;
> =20
>  	ibi_ack_nack =3D SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
>  	if (mandatory_byte)
> @@ -400,18 +401,30 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_m=
aster *master,
>  		ibi_ack_nack |=3D SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
> =20
>  	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
> +
> +	return readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
> +					 SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
> +
>  }
> =20
> -static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
> +static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
>  {
> +	int ret;
> +	u32 reg;
> +
>  	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
>  	       SVC_I3C_MCTRL_IBIRESP_NACK,
>  	       master->regs + SVC_I3C_MCTRL);
> +
> +	ret =3D readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
> +					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
> +	return ret;
>  }
> =20
>  static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, =
u32 mstatus)
>  {
>  	u32 ibitype;
> +	int ret =3D 0;
> =20
>  	ibitype =3D SVC_I3C_MSTATUS_IBITYPE(mstatus);
> =20
> @@ -421,10 +434,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc=
_i3c_master *master, u32 msta
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
>  	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
> -		svc_i3c_master_nack_ibi(master);
> +		ret =3D svc_i3c_master_nack_ibi(master);
>  	}
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static void svc_i3c_master_ibi_work(struct work_struct *work)
> @@ -935,7 +948,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3=
c_master *master,
>  			if (ret)
>  				break;
>  		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
> -			svc_i3c_master_handle_ibi_won(master, reg);
> +			ret =3D svc_i3c_master_handle_ibi_won(master, reg);
> +			if (ret)
> +				break;
>  			continue;
>  		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
>  			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
> @@ -1209,7 +1224,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_maste=
r *master,
>  		 * start.
>  		 */
>  		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
> -			svc_i3c_master_handle_ibi_won(master, reg);
> +			ret =3D svc_i3c_master_handle_ibi_won(master, reg);
> +			if (ret)
> +				goto emit_stop;
>  			continue;
>  		}
> =20
>=20


Thanks,
Miqu=C3=A8l

