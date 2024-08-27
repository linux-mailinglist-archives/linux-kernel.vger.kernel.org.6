Return-Path: <linux-kernel+bounces-302866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F096046F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B41282E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE80194AEA;
	Tue, 27 Aug 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="B13coOHi"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B314A90
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747568; cv=pass; b=Ut81bjBee6joMCU6Zzdu4sqgT59hxi62lmTKawMSmno+otbwcgwJkEBItxhwCy047BV/jH8pZFR46tLK3QPwuiJr2Ru06oXSHs4+ViB/HiGrrM6BslTKJwpd4f9cRmhVDhyfXnsyWdYuVAjdPp6TiNTfdeTucIKNwF51jtUQyJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747568; c=relaxed/simple;
	bh=Nxynyt1Q6SOZtgkMCGN2TqPFH84psJalmDt8aE2sgns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d97XDRBRyhwIw37FrOT+Aa8NBJ7E1SZEN3Ej6PjZnXl/thqYBCPcVRwhhEDbCn2VjI0WkDsfOThK1H/yzRyoMjD7FcYh0dXkskSDok0mAvwBLo7/afrP1MGmAkyuXWErTOyTno6BAMeYb3s5q+QkUx+RElZUA28Jtpc/Q2/+hNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=B13coOHi; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724747559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L2vhdyX6PnpQyXK1G573ykyuuBp6UOj/3xsELWpwc1gdYQS/esYU5Z+bl7jFFZEFzC3G5zIQmneTvGInFs69oPbw12Sf1Kgr/yNAoBrR9/CWuAmqFwA6fqupj53hY7dXH4kagrJOr8feL7vhmYeh/FFTrinbwasfbmMB9IFspIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724747559; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rtkaGgVMFkcwOKpeR5VjeApvs8rDunb0Pv2Q4XT3R7U=; 
	b=A4h7UiTBs8g5E/T+VfcdPPS4UGUWu0fE/1NikQypL5UA1X53lv+ViTruwC9gpvmc/1gXMbaYToIZr2HeGht1+DDxRuKmkWTru+e1AzUMF+Vj0/VwQW5xZugF9EXULIAusrq8gRIOU8nyEpPAUdDqzNHcKFMrtbX+D1Xzuc5hVbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724747559;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=rtkaGgVMFkcwOKpeR5VjeApvs8rDunb0Pv2Q4XT3R7U=;
	b=B13coOHin/Qk6caKJSVfMWnRXCHaBMN4bt5fZnTep5d4QWod/i7miFhrqDCo2PRg
	QmlbCgJJZ6Wf91pI9VHJCCnSnobDXYnVLsfZ5viqbsvicZXV9lWInE+aruWCOfHMLZG
	VJtkEm60Vbat3eaY1DTJUdlbfB8HzYsPqa3clnbo=
Received: by mx.zohomail.com with SMTPS id 1724747557214338.5192769929447;
	Tue, 27 Aug 2024 01:32:37 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id F353C10604BD; Tue, 27 Aug 2024 10:32:33 +0200 (CEST)
Date: Tue, 27 Aug 2024 10:32:33 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Yang Ruibin <11162571@vivo.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:controllers:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <hbtcw4uyb7ew6codolx4hkr5eidlw3evyaibacsbiimtzyhqgv@t4noaezzl4jv>
References: <20240821073916.10165-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrm5abaxdpvehlsa"
Content-Disposition: inline
In-Reply-To: <20240821073916.10165-1-11162571@vivo.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.159.78
X-ZohoMailClient: External


--lrm5abaxdpvehlsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 21, 2024 at 03:39:14AM GMT, Yang Ruibin wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
>=20
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---

Please remove all error handling from that function instead. The
functions can cope with prior errors being passed to them.

Greetings,

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 3140990a6164..f85d56e85c0f 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -116,14 +116,14 @@ static int ssi_debug_add_ctrl(struct hsi_controller=
 *ssi)
> =20
>  	/* SSI controller */
>  	omap_ssi->dir =3D debugfs_create_dir(dev_name(&ssi->device), NULL);
> -	if (!omap_ssi->dir)
> +	if (IS_ERR(omap_ssi->dir))
>  		return -ENOMEM;
> =20
>  	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
>  								&ssi_regs_fops);
>  	/* SSI GDD (DMA) */
>  	dir =3D debugfs_create_dir("gdd", omap_ssi->dir);
> -	if (!dir)
> +	if (IS_ERR(dir))
>  		goto rback;
>  	debugfs_create_file("regs", S_IRUGO, dir, ssi, &ssi_gdd_regs_fops);
> =20
> --=20
> 2.34.1
>=20

--lrm5abaxdpvehlsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbNjx0ACgkQ2O7X88g7
+prDKRAAmQS0lE6ZD5QrJNww1AjPXR8c8xvaU7SiFJxd70l6vlCtGGJnghWMIoqa
AXqDgRIJ9UBjXsAFcYuGOykRmFfYUHhKD7XBP3FFTblnWsiRSlVPgb1wLSu9qkIv
oYWjkDScEf0dfbxnxA0xLl5iZE37x1c6TjCOVhcdT8TGjetkeRqX5OqB+a+KczfD
3ds9zXguwSEWaWq+HkHdh99YnzaA92RtAbM9ocNSqx5o0951exEXvBYzYQtcEBLh
L5HvNGWE/vzrg/A7N3+hoWIvKCNs5EtAPZufCGYnU5HDJZXf4wqzfa5iGAohD174
RWsjq3igFKjMZq/abDhhJr2oP2u1kLwRXJrZphEBmvWiQL1rGGoKKCVJGzhm6XPE
X11lB6oAmaHHh2H75TJDZBXxmGNQPO/rDa5WisWQuFW8ekSYNtG/eYlQ4uY0p9VF
Sonn5C8V4FiVwJS13lDpbr4etcAqFvYVGPvYhY473vhDGj3Ugf2UQ93rWzLw/R6H
N1H2tUin84VcQ0SevBn9KwOENuP/Nvl/+Q+LsCOEOcB6wCvO0z/MgTlXevyBgCnL
/FeB00KRbQmBvKDd7GeqZXd7gYKhlnPD1HVmZLO0TkoPc0Wc1VcynbzTKgyqsJMw
wfVk8E3zBRWExhG6oIPXh3PwtM8oUrRlG74isKtHvSTSyj4fpUQ=
=Lkvi
-----END PGP SIGNATURE-----

--lrm5abaxdpvehlsa--

