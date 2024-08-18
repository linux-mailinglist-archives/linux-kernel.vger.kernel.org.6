Return-Path: <linux-kernel+bounces-290886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B70955A81
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911E228218B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DD2CA9;
	Sun, 18 Aug 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvkQ3tsi"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4822F22
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723943248; cv=none; b=Yne2tPGgBQK4h7axLMZjdiSPQ2Y6uuUQk2XK11/HQ4YKHyhjc2Wa38NAKeV2NYXMJJgty8JrY4j9BvIH57JO3OYfd02SYXNRd3PDzbm454eawGH6+qUcPPCDVgWE9iMggNWr0XmiSU4DKzzqW32pkv05E75oQx3YEwGNWG57TA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723943248; c=relaxed/simple;
	bh=yuwmk9fzjq3JCGqI8zw/T0mJKhtKmEhCJ5Tpt63ajBw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3zouNXnqh/z06BWJTRz786PUmGEHgW6PMtZssIJ7eYLQlFuP2bI9AcAR43uyUHyuwZiKEmM69dXvFFrnT3uOx3s/eXSTIemVLJQhN/MRiysp841zY90cPCL1YGZ3FFNm2r53VxEdVaX8OVKg6d1+0O5LWyXer1Ee3ibYqbsgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvkQ3tsi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202146e9538so13044325ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723943246; x=1724548046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVafdg2t/5+Qku5YWqPbi83tW9PKa2T9DXlIflGUNRs=;
        b=jvkQ3tsiX9wVbcmz4qf6Ctn4pyAYXinb1l8RXrni56DScuKOesvVMEvO7klLOnAq4w
         +JJtQuVb6nde+s8gZSp3urJIH4mbjEeeAVR4ki8ocnEXPjFJXSZxyep1SBy8Rcl8qiiD
         aT0/wfLDQ3lGq99L52oRUFrMsS1+PRk7vnaeh+dRr31yNLnaishEFFClsRPddtdygjL/
         fGBp7LSFW7MaBAN/1lAb0wHfYwAo8LAjc9CMFkBTHByLDx2sGVWHqs+VLqC8sIMeYAXs
         jTRqrfy7XBk/NLhojg1aqSRgqH/tkhBsugt7t90Imvx9aFolHDRea+TNlMZJznkw5K11
         QdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723943246; x=1724548046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVafdg2t/5+Qku5YWqPbi83tW9PKa2T9DXlIflGUNRs=;
        b=oViCnvy8fB2cfak7yr2lPMN/zxPxFA2FaN/my+OMGMlewk/mq2NCAO0BALPwsl02eT
         zRFHGyzM2EFvvGYa+rER8lGmAsyykfArQFkW3/u9L0Pe9dbpVvOT4OC5Hgjgx5Cc0JTR
         7dYjV84bv5j90m1lIE7p7rMI/Wu88LAU2r9aLfyVMzB3RlvhbuwUsnrIouJzSjJUB2QX
         r2yxlP4BBlhYtWF4Sf01bfggy1GyhFzviFp1TuUeC1B+Qw/SGCOWBh8J8ParhomuZWUR
         TabIrpBHceDOEdGVgjn/z6KIXbfTs3OhUpzrVXBAXQm3noMH5k0jsJIqXEA/1S9cBJn5
         8M9g==
X-Forwarded-Encrypted: i=1; AJvYcCVgn9svFquKW/Qrm5E2jJgvfa24LPXCcf2O0+1kRr0ItujQp8VWEuZOiGhZJBjBSo2X7Nu3XM5vtGQnt3LOzVJq4hec5b9/WxIWyl/O
X-Gm-Message-State: AOJu0YziJsD95CEIJI6opXJYJJXOBElE1GmcKH11IKJT7aagUBXDgItP
	8Pk7MT6+Zve4NxW4yIb/CWG9tbU2IdrpAN+GpuApVDJ1epla5LSS
X-Google-Smtp-Source: AGHT+IEAfphMKk0cittpHUhF9Z2+KVnF1Z/LmCykzB4qWufXw1J88g7BJHY0myWdn/YJVukQMUdJRw==
X-Received: by 2002:a17:902:d4c9:b0:1fb:31c7:857b with SMTP id d9443c01a7336-20203e4c4c8mr83408755ad.1.1723943246030;
        Sat, 17 Aug 2024 18:07:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f022c72bsm44231915ad.0.2024.08.17.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 18:07:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 876B64A0EB88; Sun, 18 Aug 2024 08:07:21 +0700 (WIB)
Date: Sun, 18 Aug 2024 08:07:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: nerdopolis <bluescreen_avenger@verizon.net>, pmladek@suse.com,
	rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <ZsFJSYI3EVjC8p5W@archie.me>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2669238.7s5MMGUR32@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cQCHV6lEr+glpY4"
Content-Disposition: inline
In-Reply-To: <2669238.7s5MMGUR32@nerdopolis2>


--7cQCHV6lEr+glpY4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 08:09:20PM -0400, nerdopolis wrote:
> Hi
>=20
> I originally brought this up on linux-serial, but I think it makes more s=
ense
> that it's part of how printk console device selection works. Without VTs,=
 while
> most software is able to handle the situation, some userspace programs ex=
pect
> /dev/console to still be responsive. Namely systemd. It calls isatty() ag=
ainst
> /dev/console, and since /dev/console on VT-less systems currently default=
s to
> /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> refuses to write log messages to it.
>=20
> There doesn't seem to be a mailing list for printk, so I had to use
> get_maintainer.pl. Hopefully this is correct
>=20
>=20
> After some grepping and guessing and testing, and playing around Somethin=
g like
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index a45d423ad10f..f94a4632aab0 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -384,9 +384,12 @@ config NULL_TTY
> =20
>           In order to use this driver, you should redirect the console to=
 this
>           TTY, or boot the kernel with console=3Dttynull.
> -
>           If unsure, say N.
> =20
> +config NULL_TTY_CONSOLE
> +        bool "Supports /dev/ttynull as a console automatically"
> +        depends on NULL_TTY && !VT_CONSOLE
> +
>  config VCC
>         tristate "Sun Virtual Console Concentrator"
>         depends on SUN_LDOMS
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..c1554a789de8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3712,6 +3712,11 @@ void __init console_init(void)
>         initcall_t call;
>         initcall_entry_t *ce;
> =20
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +       if (!strstr(boot_command_line, "console=3D"))
> +               add_preferred_console("ttynull", 0, NULL);
> +#endif
> +
>         /* Setup the default TTY line discipline. */
>         n_tty_init();
> =20
>=20
>=20
>=20
> seems to work, it conflicts with CONFIG_VT_CONSOLE since it is effectively
> redundant, it is optional, so that it doesn't cause any changes to
> configurations, that historically had CONFIG_VT_CONSOLE turned off in the=
 past,
> and for bootloader configs, it won't change any behavior if the kernel co=
mmand
> line has a console device specified
>=20
> With ttynull as the console device, isatty() no longer fails on /dev/cons=
ole,
> systemd writes the log messages fine to /dev/console, and when Plymouth c=
alls
> TIOCCONS on its PTY, it is able to get the log messages.

Then what does /dev/ttynull do other than just to satisfy systemd? I expect
it to be like /dev/null, though.

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--7cQCHV6lEr+glpY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZsFJRAAKCRD2uYlJVVFO
o53YAP4/hY8R6X/D97RCBPdR5qrHavzywMGyHNuSrOL9E7iNfgEA0819XMx969QZ
2f1da8H8CkUckKVLP7Hao3mquIXXXQc=
=d3hk
-----END PGP SIGNATURE-----

--7cQCHV6lEr+glpY4--

