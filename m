Return-Path: <linux-kernel+bounces-324077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AED9747AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941931F25E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84D18EB0;
	Wed, 11 Sep 2024 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHxwRuAL"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975A161
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017378; cv=none; b=LZ0nmbztgLVrhWLH9nQCNL7Jf0E2ktA5cDTBGEt2j9PVxduf9CbtE9HWlUTlnxqM9MaJLHpBRivZxVLKSTraLyV7EHfjE3gblSRk8qBMs3ZS+SvEGb16dCykdwj/7LP7PRl7cfxfRDaNRhq+mz4yujWn7RLOT/GJslqJSYd/Jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017378; c=relaxed/simple;
	bh=OPRRU0IyZEvPaU1HJdzDb9TPAO1MfmEqI8IwAu6B11U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/fgILkZqxL9BfN0x0uKAzWEd2JyvDV/Cgb/2tYT2b5jzCoiRQjC1eXBbauGNmxho4d3YgBuRLL1u3DL7lefwzOb/gLj0/HDGf7XKpuAW2VPjospZJtlq0nXluRLPh9iJDrZxGYFdAQ8ullF9JCgq1mDydWvlVteJmKn4kwVnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHxwRuAL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso4240357a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726017376; x=1726622176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVqiUxsVb7vxvZzrSiSeI8t+eG1EK/BxIDvzNolJKEU=;
        b=dHxwRuAL8U+qe6qPbmfoMPtzy29tUA34as7cx0ErwQchWgNxyrHbtSCQ4Vj6DCgUhq
         BYmM1+a81YJ56PllaOA52nTgnJv7MLRu+jtZ4Bnr9p963OJiq785dEyE3+UY7nPWE20a
         mz7PuzfRI8CxCsalNKMUZ0SQIPyk8zjxicT9i8Mrf5VxYTW5Xz79SfxUF+rsHOg3kDhS
         JyGJty312LcOuFh/NKUbYcXlvRJBKI2E6+wmES2mjqAE1KCk6NG7nVCik9iFtXQlolEs
         qQjeYOIhm5Rr90U8AHVkNEsxMJtd/zYa8K+H0QNXGCdBz0Rg43m75V9A0oyObU0VtmpO
         nwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726017376; x=1726622176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVqiUxsVb7vxvZzrSiSeI8t+eG1EK/BxIDvzNolJKEU=;
        b=DdLUbzzi4WUws1wvCZuoQOdtRKfKm3SaXuly3yT/LTCQnymLtPOYmafru/pQHpoofP
         hKFJa6rWhb35aiVcie6+rDqxVQlfCrDXtYNd3CPk7AMtrPrjVqMbmv8OUtQSN/urHDVZ
         X/nG+ZVKTLXT6RoXo6Jy5+1u7ZzSelfYJfYC2qw5tkQkXwRLy/TPP0LpC9TWJmzgYgo3
         k2BwqltweImBrdUVu32zWOvjHxkSFFQAOy4uV9z0hUH9YPCa2zRhjIzltldL+hS/1KG3
         mIYmd+L/X2v+vftkxp1YMAZJDTsvI1i9VbZVsYHko4UdPSUz+CZHt8PcL4XCnlPnNTtA
         tIew==
X-Forwarded-Encrypted: i=1; AJvYcCV8tHzTvXcnCo9h/NH4RuKHKdBojsbv3/OpzTPcxhkFfIGzjmVPvgwNsl88IlANdJoKIhyGec6c0iMC5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8sfO++M/hBfbJymN0r5BXvB+geYpz/PUlY+ENygN+erHFUf5
	iVfwP6vX/eOCcpXPLHZAkBsWm91Q1s0v5x3Cl/d1y2QGTVswBYK429qpwXez8qy6LDVFUZUw9Et
	cUymTMxN3cv63xIB8ZP4QhbytGh0=
X-Google-Smtp-Source: AGHT+IEjBGIyK0K/tjlnfxCBOZturPb0CoCSRIRBiEsDUZRqprFH60pRY1NoYuyXhwgkJFvimfZmeqCrXV4/Iak55mc=
X-Received: by 2002:a17:90b:2d92:b0:2d3:b438:725f with SMTP id
 98e67ed59e1d1-2db4211cacfmr9006083a91.24.1726017376028; Tue, 10 Sep 2024
 18:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910181544.214797-1-frieder@fris.de> <ZuDjAwPxHeJTvXAp@atmark-techno.com>
In-Reply-To: <ZuDjAwPxHeJTvXAp@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 10 Sep 2024 20:16:04 -0500
Message-ID: <CAHCN7xJD8jsqyZX1JkWxrA84XkZ8YYN19hXW6KVe+jkOFugqrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Frieder Schrempf <frieder@fris.de>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:23=E2=80=AFPM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> Frieder Schrempf wrote on Tue, Sep 10, 2024 at 08:14:51PM +0200:
> > [2] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator/src/=
branch/main/pll.py
>
> Great work! Thanks!
>
> I was curious about the existing table entries, recomputing existing
> values doesn't yield the same values. For example, the first entry is
> {
>         .pixclk =3D 22250000,
>         .pll_div_regs =3D { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
> }
> but computing it yields
> {
>     .pixclk =3D 22250000,
>     .pll_div_regs =3D { 0xd1, 0x4a, 0xf0, 0xef, 0x10, 0x81, 0x40 },
> }
>
> I assume there just are multiple ways to generate the same frequencies,
> which is fine in itself, but it'd be great to be able to "back-compute"
> the entries as a sanity check.
>
> I've played a bit with your script and spent more time on it than I'd
> like to admit, but something like this seems to do the trick, plugging
> in the regs from the kernel:
>
> ---
> pll =3D FractionalNPLL(freq_ref)
>
> regs =3D [0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40]
> # assume fractional
> if not regs[0] & 0xD0:
>     print("reg[0] missing 0xD0")
>     sys.exit(1)
> pll.freq_frac =3D True
> pll.params["p"] =3D regs[0] & 0x2f
> pll.params["m"] =3D regs[1]
> pll.params["s"] =3D (regs[2] >> 4) + 1
> pll.params["n2"] =3D ((regs[2] >> 3) & 0x1) + 1
> pll.params["n"] =3D (regs[2] & 0x7) + 4
> pll.params["lc"] =3D regs[3] & 0x7f
> if regs[4] & 0x80:
>     pll.params["lc"] =3D - pll.params["lc"]
> pll.params["k"] =3D regs[4] & 0x7f
> pll.params["lc_s"] =3D regs[5] & 0x7f
> pll.params["k_s"] =3D regs[6] & 0xbf
>
>
> f_vco =3D int(pll.params["m"] * pll.f_ref / pll.params["p"])
> if f_vco < 750000000 or f_vco > 3000000000:
>     print(f"f_vco {f_vco} out of range")
>     sys.exit(1)
> f_calc =3D f_vco / pll.params["s"] / 5
> pll.freq_int =3D round(f_calc)
> print(f_calc)
> sdc =3D pll.calc_sdc(pll.params)
> frac =3D pll.calc_f_frac(sdc, pll.params)
> print(frac)
> freq =3D pll.freq_int + frac
> print(freq)
> pll.print_reg_driver_data(freq)
> exit(0);
> ---
> yields this back (comments added manually)
> ---
> 22500000.0 (integer part)
> -250000.0 (fractional part)
> 22250000.0 (summed)
>
> PHY Driver Table Entry:
> {
>     .pixclk =3D 22250000.0,
>     .pll_div_regs =3D { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x81, 0x40 },
> }
> ---
>
> so if I find some time I'll whip some loop to check all other values...
>
>
>
>
> That aside, I see no problem with this, just one meta-comment about
> adding a link to the script in an external repo: I see some other
> drivers have python scripts in their trees e.g.
> drivers/comedi/drivers/ni_routing/tools/*py
> drivers/gpu/drm/ci/xfails/update-xfails.py
> drivers/gpu/drm/msm/registers/gen_header.py
>
> would it make sense to commit the script here instead of linking to a
> repo that might be lost in the future?
>
> I'm not quite sure what policy the linux repo has here, so leaving that
> as an open question.

Is there a reason this couldn't be coded in C and used to expand my
integer calculator series?  With that, we could drop the lookup table.

adam
> --
> Dominique

