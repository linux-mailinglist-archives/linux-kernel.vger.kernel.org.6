Return-Path: <linux-kernel+bounces-310987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E396839B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29AD284904
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8011D2F4A;
	Mon,  2 Sep 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lINQeVRN"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D101D1F6E;
	Mon,  2 Sep 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270599; cv=none; b=Xpk2EOtbWUhzTZ+JSz/p/QjgAXP/Ag2vQBs8eVtOLrYT7sL9yNn0M/LqgBV6RmqLSot4Tqh6k3bZH14ZZ1tEhP6zs9VxkNeo8W17wA+Xxp8rb4k622jswCtfLCHyWLuj2G6joTpT0w4L7Rqov8y/BDkeyAq3qrIdoRGdsesTI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270599; c=relaxed/simple;
	bh=jFHjFu8OGR+X1nKQI9GB8AQP8IsN/RDKODcixZL1viU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p69kdL/79k2rucULZ118doG+t5waqXIUzBW7NV4vus0sArx5dWFj0UgaFWhCHzI1a8KhzKWUipOUvHKlBlVU/ZmDGdQrKpsXrdsa5gPNM9/s5SbQfIdSEtUA6K8YRJsNSuCv+TUbdbFmh+8igFbgH8HUzglAJ5UQyRdhcRP+kXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lINQeVRN; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2705d31a35cso2442846fac.0;
        Mon, 02 Sep 2024 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725270597; x=1725875397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnD4+9wv7BvPMthmLDGvgHKWOoM9htmN91BFZMaDxRg=;
        b=lINQeVRN0JckycNNvjc9uj4bOefucA0uA3MZraAlUSqxOogWzNcvCVYkFiwK9Hn83x
         1eIVYa2kfsqt/tGJPHAVSwYxtmA71R3pctiFW5QXumfMTrDAsDTQJqXLD8Mri4nX4JvN
         66+QAwe4qcAC2z4pIRsIDEL4f/RNVCTHYHCoCHVBIC+VA2QvADWJY49XgLnqlpOobvFu
         lH8+i0AbpjcVTo7LMh6KlveC9rb+UVFSegOs2spHbJ7d8horULLhREcU3Gc+jxfaH1Pz
         XpAwoowynZsmqNgUOG1XXa+AhTUJBKq8/BKZwy8mVhpYrz01JZLfNd9F4MQeaxtSkzBO
         9kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270597; x=1725875397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnD4+9wv7BvPMthmLDGvgHKWOoM9htmN91BFZMaDxRg=;
        b=R885VzAIm5GhKGJRY+46xEjoVpRG9rIewwiKD/PUPjMIa9hl2IFXxA/SlTPNA9F9OX
         AiaZWsPVfi4dkkXgX8LzxH9IO/wEAmBy8KwXpJPqVtTdRPA75Xjt5slk68HbPRHmS8qr
         vgnpq5nCw3zrIbj+62wNtUP/8eke4gpaA33shwNZVG4yAbopO/ndkBBm29+5rbuLjBlY
         3lFXn3e+SE3Rwlz3hOaO/sMkfXi8osmEno6r37CzmQXyfmf9l59dEqYeUyHzDjTA9hVH
         tB/+YMx9Y7NQZyiyr4rOySanUMKGjQ9k1OAOyklDcaMGgA3UtBf1XIgq8jL0wTY+1L+t
         lIsw==
X-Forwarded-Encrypted: i=1; AJvYcCUfSgSuv/6yPo0waiQCZ+EVpnT4GJBd+lJ3GDeWO6Qv27qsS/tWdBTvRj6QQkEEHZz23KoWY2/8vkkl/MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxhqVIVzTf3zyJt+/v+1oozhOgzhjKvlERn98wEodmLL8VmN2
	Gr89woGGbmcooCVn/Mh5P7r7WkSVeidTkl6GNBuxcBHkJpShNjDmfVePHZdtRntvfe2oh+rWrsk
	SysANI1Bx+6Oq28YqR70wuFv3hW0NHQ==
X-Google-Smtp-Source: AGHT+IEsjdD9gLX+gRVkbNCE81bGcKyk6Pf74+ICFpx5fpusJwmwpdTLUmvV8GcNAGwmGQa2vCXsPAJQNj8svZKzlB4=
X-Received: by 2002:a05:6870:e2d4:b0:270:276d:fb54 with SMTP id
 586e51a60fabf-277ccc0ff6fmr7721591fac.21.1725270596893; Mon, 02 Sep 2024
 02:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806142902.224164-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20240806142902.224164-1-sergio.paracuellos@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 2 Sep 2024 11:49:45 +0200
Message-ID: <CAMhs-H_NS-n2tx5SZpCMiVZtBFzX_nTa_vnS8We0UevkwFq93Q@mail.gmail.com>
Subject: Re: [PATCH] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
To: linux-clk@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, tsbogend@alpha.franken.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Aug 6, 2024 at 4:29=E2=80=AFPM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Clock plan for Ralink SoC RT3883 needs an extra 'periph' clock to properl=
y
> set some peripherals that has this clock as their parent. When this drive=
r
> was mainlined we could not find any active users of this SoC so we cannot
> perform any real tests for it. Now, one user of a Belkin f9k1109 version =
1
> device which uses this SoC appear and reported some issues in openWRT:
> - https://github.com/openwrt/openwrt/issues/16054
> The peripherals that are wrong are 'uart', 'i2c', 'i2s' and 'uartlite' wh=
ich
> has a not defined 'periph' clock as parent. Hence, introduce it to have a
> properly working clock plan for this SoC.
>
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS =
SoCs")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/clk/ralink/clk-mtmips.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtm=
ips.c
> index 50a443bf79ec..787ff3e66b34 100644
> --- a/drivers/clk/ralink/clk-mtmips.c
> +++ b/drivers/clk/ralink/clk-mtmips.c
> @@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[]=
 =3D {
>         CLK_FIXED("xtal", NULL, 40000000)
>  };
>
> +static struct mtmips_clk_fixed rt3383_fixed_clocks[] =3D {
> +       CLK_FIXED("xtal", NULL, 40000000),
> +       CLK_FIXED("periph", "xtal", 40000000)
> +};
> +
>  static struct mtmips_clk_fixed rt3352_fixed_clocks[] =3D {
>         CLK_FIXED("periph", "xtal", 40000000)
>  };
> @@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data =
=3D {
>  static const struct mtmips_clk_data rt3883_clk_data =3D {
>         .clk_base =3D rt3883_clks_base,
>         .num_clk_base =3D ARRAY_SIZE(rt3883_clks_base),
> -       .clk_fixed =3D rt305x_fixed_clocks,
> -       .num_clk_fixed =3D ARRAY_SIZE(rt305x_fixed_clocks),
> +       .clk_fixed =3D rt3383_fixed_clocks,
> +       .num_clk_fixed =3D ARRAY_SIZE(rt3383_fixed_clocks),
>         .clk_factor =3D NULL,
>         .num_clk_factor =3D 0,
>         .clk_periph =3D rt5350_pherip_clks,
> --
> 2.25.1
>

Gentle ping on this patch :)

Thanks,
    Sergio Paracuellos

