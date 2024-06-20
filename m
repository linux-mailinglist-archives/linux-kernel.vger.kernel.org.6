Return-Path: <linux-kernel+bounces-223558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCD9114D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8958C1C218AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E684A4D;
	Thu, 20 Jun 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9L0ONjq"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2B8288F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919561; cv=none; b=P6+GhL0MvxRWS+9tN6Z2tCGMIVEUA1ymwSzqYnkUGt4EarvcPKdEyOhZxLzgFyC9SypYmuSjg7JFhF9cA33Hjc0rsfgLCU0ocxANZ+lT873K2MS78fpT111W0j+Ao96FBWDHgOiq5AGPHI5RSdOCW7xObMw32MU5jr7cws8CEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919561; c=relaxed/simple;
	bh=GzGqxe0BB5cRnb5zU6DvWVaR1aOl5IzW/euKFXuh1E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax6k+Gd1p+vRz/e8H5jzw1wzSubV5r0rbmzXsTxYH245oNdVaGdQF3cdVCeSKMR8TwIonqAP/h2AzxVsA1dv4JzenjqgZPBH8igZuJZRt5y9mzHPHNO+/TwkEfIx8FTXNYX7gco1cX5YHePiVE5O4KYCXILIqNQoIuVNmjOC7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N9L0ONjq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-63bdb089ffdso11861017b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718919558; x=1719524358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG5oVmRocYyy3IzJSCKu3dOBsS/cU690fmgDh0CQkVQ=;
        b=N9L0ONjq4lC/w3BFjweZFJfk19faDZOLdjPP7R7HdH+rjyPZEVHG+xyA6WoLHxHP6y
         /ILDp3CArnK5xvFzCVkaRCixfWdXxTpMguMv5f/yvRq5FSEXeWJZzVwTHIQ3E6sJefUC
         MU9dvjjrOT8YbUEfj6gYM5SFdUi0Qpy/kKB7A0m4cjrKh4ZqpirCMmtMJgWFnJtdC2p9
         XUzPDv1jYbVE5Tf1EE0rS3J9kqAxICWkrCLTVIEmloNrkWaB6KrBjmrz/e+LyBgNV0GO
         i5PC62gS9eScG212lucSu9bKJfxXqEonzT2fdbg+Yvdi0wku/4gKY1/EC65xMTN1jHhJ
         bkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919559; x=1719524359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG5oVmRocYyy3IzJSCKu3dOBsS/cU690fmgDh0CQkVQ=;
        b=RCW8iW8K4jEpkTiTLNMT67a/EyiWweot4sIWMYSBVCHpb5ko031RuskZMi1bQPG17t
         q9Z2dlPkyHWJfxWnM0MzhGIjUHWpi0Fl9J52zhcgfaHYhSlMndRKK0EeUDwbnY+6jxhX
         +vZxJ+ngRKSJ/1yVxzq9qXFD8RrXO+FmcJa9Pt1WqU5eV/8V6FVNET/RXmpSZTWZ/q9K
         EcVEBaI4K1Dggw575LBuAfYxmQXrDGz8PHf1oSB+H3D51eFpw/s+dm6z95fLr4+mBXng
         rtcHuHpyEHVxxUFchVexdoZJvDd3FBDmkREQdrFMXZkEoDh6eXRcTvMc+i39gGDDKekU
         E2eg==
X-Forwarded-Encrypted: i=1; AJvYcCWgmUHtvOV/TqkPpxWiMxWPa+VxVKbwOOTFzAY30QpsjoqEQYpmOkROpeidtEMuQ1Il/iGo6Rr1FhTNtOvf/Zzly9RjbgPEf3bmKjPj
X-Gm-Message-State: AOJu0YzzLMnXPgaBQemSjiy+OLpDF153yMTk9aA31ZIpB24KGfirlN/Q
	NHrsNrS0KMQqowGzBzG6r2pLvk8wgyzsNJuFh++k4yNp79zy6NvV9P+tyLtWrlzxre+Z6b/zHXh
	Fv7WHQd5hsZNlv1g7KQ5cHemQvCjyON2+73RizQ==
X-Google-Smtp-Source: AGHT+IHtwKXc9VjTxwTjE1WQPqo/nzCzyNk2L1W9UPMvQvq0zqX89g/JasxRk6Xfq7E9/GsSNsXqFPYAW5GA/xFzOvE=
X-Received: by 2002:a81:9186:0:b0:63c:416e:fc96 with SMTP id
 00721157ae682-63c416f1988mr33324357b3.24.1718919558585; Thu, 20 Jun 2024
 14:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240620134610eucas1p2fbcd7218bc220bf568ea117acf2f4781@eucas1p2.samsung.com>
 <20240618204523.9563-6-semen.protsenko@linaro.org> <oypijdbk3vu3qd.fsf%l.stelmach@samsung.com>
In-Reply-To: <oypijdbk3vu3qd.fsf%l.stelmach@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 20 Jun 2024 16:39:07 -0500
Message-ID: <CAPLW+4n52gHBcMA3EN7faJUj-7pQNLM=UEiEBL4jT9iWQkkKfw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] hwrng: exynos: Add SMC based TRNG operation
To: Lukasz Stelmach <l.stelmach@samsung.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Anand Moon <linux.amoon@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 8:46=E2=80=AFAM Lukasz Stelmach <l.stelmach@samsung=
.com> wrote:
>
> It was <2024-06-18 wto 15:45>, when Sam Protsenko wrote:
> > On some Exynos chips like Exynos850 the access to Security Sub System
> > (SSS) registers is protected with TrustZone, and therefore only possibl=
e
> > from EL3 monitor software. The Linux kernel is running in EL1, so the
> > only way for the driver to obtain TRNG data is via SMC calls to EL3
> > monitor. Implement such SMC operation and use it when EXYNOS_SMC flag i=
s
> > set in the corresponding chip driver data.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changes in v2:
> >   - Used the "reversed Christmas tree" style in the variable declaratio=
n
> >     block in exynos_trng_do_read_smc()
> >   - Renamed .quirks to .flags in the driver structure
> >   - Added Krzysztof's R-b tag
> >
> >  drivers/char/hw_random/exynos-trng.c | 133 +++++++++++++++++++++++++--
> >  1 file changed, 123 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_ran=
dom/exynos-trng.c
> > index 99a0b271ffb7..497d6018c6ba 100644
> > --- a/drivers/char/hw_random/exynos-trng.c
> > +++ b/drivers/char/hw_random/exynos-trng.c
> > @@ -10,6 +10,7 @@
> >   * Krzysztof Koz=C5=82owski <krzk@kernel.org>
> >   */
>
> [...]
>
> > +static int exynos_trng_init_smc(struct hwrng *rng)
> > +{
> > +     struct arm_smccc_res res;
> > +
> > +     arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_INIT, 0, 0, 0, 0, 0, 0, &res)=
;
> > +     if (res.a0 !=3D HWRNG_RET_OK)
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
>
> Does this driver requiers some vendor-specifig bootloading code?
> I am testing the code on a WinLink E850-96 board booted with the
> upstream u-boot and it fails during init (res0.a is -1).
>

This series was only tested (and works fine) with LittleKernel based
bootloader [1]. It's officially recommended and the only feature
complete bootloader at the moment. And you are right, the reason why
TRNG probe fails when you boot the kernel from U-Boot is that the LDFW
(Loadable Firmware) loading is not implemented in U-Boot right now,
which makes HWRNG_INIT SMC command fail and return -1. In fact, I'm
adding LDFW loading in U-Boot right now and expect it to be ready in 1
week or so. For now, can you please check with LK [1] instead? I'm
happy to help if you have any related questions.

> [    1.883413] exynos-trng 12081400.rng: Could not register hwrng device
> [    1.893394] exynos-trng 12081400.rng: probe with driver exynos-trng fa=
iled with error -5
>
> If an additional code outside the kernel is required for this to run,
> then maybe the error message should reflect that.
>

Good idea! Will send v3 soon, with proper error message added.

Thanks!

[1] https://gitlab.com/Linaro/96boards/e850-96/lk

> Kind regards,
> --
> =C5=81ukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics

