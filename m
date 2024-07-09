Return-Path: <linux-kernel+bounces-245127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B592AEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3E2845B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51E12D1FA;
	Tue,  9 Jul 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II3ze8gi"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738147F6B;
	Tue,  9 Jul 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495269; cv=none; b=k7u/LwFLrSgaVUnN6nwgr/lJQPdrZlgqHLEU7379A6LvAyq8dD6GNJX0FPJcrHVSUP5Z/sc0ilwoSpHG07f/UW0OQ5J9NFpXkBD5U/lDfayhH2Uvxr39j6m+q2DRGOYltXuwpB5jeBf0f3DJbqQJoAHI8Cd/Wl6LT3T/9ahG2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495269; c=relaxed/simple;
	bh=ao0yuvoGESK5ztONeHNNgZ2DK/RhVIQhcs2Jo2M4dqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMdpObxLiKPV+/VKVtLPVAYKfDOZlCM2SxgGFwmasjK7M+U84wp4YfBHyBFgz/1671PVYgXGQj9yWR00evHyg64tfRylHQnUbMm44lI43TG+tLZWPWipk18g4RZBnNpbgFOS79lj8EUPAoFjhofrKl2JkK+Hh+QU9ldxTQkjxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II3ze8gi; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375e96f5fddso18049545ab.1;
        Mon, 08 Jul 2024 20:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720495268; x=1721100068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5x3hUylQoog2uNJJGGlDPCeKvEn4xMplYTvm1tLAKE=;
        b=II3ze8giERMQckTjlIkQCdUfxkFMxfXbvMU/hHhZYeZmL7LIxp7DumGvOyXtSR3YE4
         /Yudnci5CVQeAoikHlfLluQmcom4KrydlgfVcfQNvN628e6/i6b0lYCNOdbwVjgxtsFj
         QZ9y4kQ2ewI4wK1aafE+kIv357NQPwyuF9EXX0Gz0AEzb9TR0WqbypRNEIKxSWAnLeTh
         DExCc9fUt3w/nYdP6F3rmRjl0s+3gW4xz27DFpUsdHJ6f5aWKE/7DcH50WEIlXFvb23X
         v5K7kmqZz9oW6jz7i2LzngFe1Ej49kqaCKhbktU8PC/XeRWv4YsFt9KMrwQXrJFCikfW
         z0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720495268; x=1721100068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5x3hUylQoog2uNJJGGlDPCeKvEn4xMplYTvm1tLAKE=;
        b=ZYjHxMM+HmF0ztCn7VT4bqq0+VN9zeEnMT+cb0YNSpnAlbC1+rLOblLyAYwVf6rsJi
         3/nUO5xakB3dU++EX3VQl0sPAmZVwqhkGkOvAmmzXbC2cbJ/1smkGLrn3AjmBaRIw3hn
         Tajqw3tEDx9HEiTcfgjA01A6+9XqdzTuJPIfY6UHVpSN9d7I/uOipYnTOrWKXjFV6qbC
         +bH+aQApk4wPGsZcovPS5znZ2Jz3HNmGhR3cQIY2WG7CkYKLrZSy96fxFeZJfIhTTZCT
         nCz3qKmtmQhNvOy1YhOTpjm+7+2k/yjI6OUDtez1NcfjmkGJcL0RF7dhyYZWQ4SpcFU6
         irOA==
X-Forwarded-Encrypted: i=1; AJvYcCVlYpyGY6SIbx3x23zyW21lB6sqEzqi0SIPHp6ryDgce8MEXsoF74iuVPcMNNFU1l2QJgcfuHpjGNbICxRSzm22XQfRPOozO1VJKQh/s+ffmuwwofeo/EYW2cck062Md6d4fCMOYjZo
X-Gm-Message-State: AOJu0Yz4s4Swz3QOGNiB2KBYaLGog4z1ugZxcqJsi6kEUt4CuoW+d1ai
	/4+TzwwcVug+UenSA5WRFMGSzfbvl3drEwo7pSbFPZBdcqnebIeWFK/FuTDpIwrgSkqXKMYpRn2
	qiu0QFGkjCOQflQzqgTla4SRwWfU=
X-Google-Smtp-Source: AGHT+IEDeHIw0M3dms9M1TQ7pOStsM6niLKah4sS4MXdNOsgiHYC/fBdJqkh52w8HlhM4gaopahy21Ep/QLxviGgtOo=
X-Received: by 2002:a05:6e02:18cd:b0:379:4564:1228 with SMTP id
 e9e14a558f8ab-38a598b3998mr15380945ab.30.1720495267594; Mon, 08 Jul 2024
 20:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com> <232c2342061b17b9f750c4ad52b0766e.sboyd@kernel.org>
In-Reply-To: <232c2342061b17b9f750c4ad52b0766e.sboyd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 9 Jul 2024 11:20:56 +0800
Message-ID: <CAA+D8APumdP97QQHObF6NEw6jwDJRb+0R=aAjqftrX1wR170Yw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8: Add .name for "acm_aud_clk0_sel" and "acm_aud_clk1_sel"
To: Stephen Boyd <sboyd@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, festevam@gmail.com, 
	imx@lists.linux.dev, kernel@pengutronix.de, mturquette@baylibre.com, 
	peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:45=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Shengjiu Wang (2024-07-03 01:52:51)
> > "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
> > driver, but they are the parent clocks for other clocks, in order to
> > use assigned-clock-parents in device tree, they need to have the
> > global name.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8-acm.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-=
acm.c
> > index 1bdb480cc96c..a1affcf6daff 100644
> > --- a/drivers/clk/imx/clk-imx8-acm.c
> > +++ b/drivers/clk/imx/clk-imx8-acm.c
> > @@ -114,8 +114,8 @@ static const struct clk_parent_data imx8qm_mclk_out=
_sels[] =3D {
> >  static const struct clk_parent_data imx8qm_mclk_sels[] =3D {
> >         { .fw_name =3D "aud_pll_div_clk0_lpcg_clk" },
> >         { .fw_name =3D "aud_pll_div_clk1_lpcg_clk" },
> > -       { .fw_name =3D "acm_aud_clk0_sel" },
> > -       { .fw_name =3D "acm_aud_clk1_sel" },
> > +       { .fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_sel"=
 },
> > +       { .fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_sel"=
 },
>
> This doesn't make any sense. Why are we adding fallback names?  Is
> "acm_aud_clk0_sel" not part of the DT binding for this clk controller?

It is not part of DT binding for this clk controller.  it is registered by =
this
clk controller itself.  As it is a parent clock, so my understanding
is that we need to add a fallback name,  or change "fw_name" to "name",
please correct me if I am wrong.

Best regards
Shengjiu Wang

