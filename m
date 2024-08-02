Return-Path: <linux-kernel+bounces-272940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8E946299
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373C4B2464F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603B13633C;
	Fri,  2 Aug 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzGOTKIe"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EE1AE02B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620148; cv=none; b=AXXnnQ9a0ib4Pz0EvfeLVo3Bd8P/KcusITMSjgItxVV7KAjHgXQAejjh5LvIMSESNGj1a6qJ2VTMGnvsbdjvA5RqzldBaW5tAlG0SUvdDkFJdOjYjapX6CawN0B4MXy6SdscQ3yDXKIDdJZWazq6AoEwmWCYjhYQcn3JRpjCdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620148; c=relaxed/simple;
	bh=jF9/Tz6cwAPSnrpApQ7Yu559zLvA98ey9pdr8UmSe88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+1sy+B37H+frCdf0RvDvSfy+Vhl0ydHOtQKpJuSHq/umm/TBPUw75HVe/YsJfrPGyKiHT43lo8teRQVbL/VnBMFAiC+cowxU2vY9BDTkLctpPy4Ea9wkMDBZenhHU1D7tyHrPgAx5jj8tqWMP1EMGXXc/CpVZ0wih6qhr+W9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzGOTKIe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso289361e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722620144; x=1723224944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQSE+Xl+pVUjM6NporntOIsDA4+1eMHnLwuSvO1to6c=;
        b=wzGOTKIeF1a+wjZ7hPRtqz2Vm51173VeDe2n47uVkynVb+lnlofjkQ+sSEyhLlTZ0E
         8y8Ka5Z1+YioZIFD2xwjDHsvGXOhtTFVlYzYh/w4Vss4MjM1KdcKMAkHbxgTMMStJEm0
         MTAlSgw4yiDt/ARPsqonjn/wGfdMmTwJyABY3WM0ddwBm6E56cQ6uMTZMCEGNd2hHLu7
         Q6hKD+vd1DS7Vkr/FcaLwxrmBmPkJVew419khszPtX/d4z4WOqVFQV7rvXkNtxJMFvzg
         r+N67KzMHyETZxs9rpc4yxT2KXRgCGX5bm0fQmZ5iF3h5Iwm5INvya/fUoK/Qet5sBN+
         fpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722620144; x=1723224944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQSE+Xl+pVUjM6NporntOIsDA4+1eMHnLwuSvO1to6c=;
        b=pwYjJd+wJ3ivtkFbciUtsm4b5Wu2s3/zPkNe1UxZuSFD3eqsHHNnwfTkRqeBuQzuIu
         NCqfGoz/GcFPT3SSIlXaKdaiU7RXe/XKJB5i7eHWvhE5hiWEvepnTyeaDNAAa0Fe4x95
         1xgPHwWPe4HlkCsi4GGZkGqho7O3NgOAZm8jWbY84GEcLHG8qXq7Ahk7ycnuVP66dOx8
         JaA6F4NAQyfq42+Fp5MXm23cIZVSHvAPJxTRAlxxYyV1mlKLBx84FBtRJL8qeETOrEIV
         eMj61ogiwUvMu3Go8r/Z5O4B7W/xKIFw+f9emToP9xviV84UBqM1oOlb5T6J8II5E52A
         8vRg==
X-Forwarded-Encrypted: i=1; AJvYcCXyyf2164BFIPRJybZCNfKh4ybXP4i+d8b6VgD4e9jiWJYqfhlnefnyTAGByF8K0HW+PBzGVMTUP+kKH9jI+nIH6Z+0GZkElmPeKHIt
X-Gm-Message-State: AOJu0YxdmRHt4ve+vIgJ6r9I2o4c/jiSE66jehXKTGJfFAqN8usiRQhs
	cGvogrmWuh+mYoC88baRp/+E2ODZwdko3CxrdO6OWRvIwNboIdd1gMgve3RdTxM8BgJb1VMrxiB
	hSY3MuT/SsKiyxkCwqbMMmlKp7SSrU+YX45Hw8iZuCFU6TtRyzBo=
X-Google-Smtp-Source: AGHT+IGn5g/eO45WsFTby2Ep7y09V5n5/cBU3x+lZtZbCw8eYB9SPj3t41HaFympNTDtMkIIOB0FshBBlNG2ksXI9OM=
X-Received: by 2002:ac2:4c47:0:b0:530:ae43:d7ef with SMTP id
 2adb3069b0e04-530bb39ff83mr2587036e87.48.1722620144305; Fri, 02 Aug 2024
 10:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
In-Reply-To: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 19:35:33 +0200
Message-ID: <CACRpkda_Y+M6_fapkxcPHNYSpd+0hicziFKcDTEyTqm_Fq+Svw@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:29=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> Failed tests:
>         arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:net=3Dd=
efault:versatile-pb:ext2
>         arm:versatilepb:versatile_defconfig:aeabi:pci:flash64:mem128:net=
=3Ddefault:versatile-pb:ext2
>         arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:net=3Ddefaul=
t:versatile-pb:initrd
>         arm:versatileab:versatile_defconfig:mem128:net=3Ddefault:versatil=
e-ab:initrd

I traced these fails down to:
commit 04f08ef291d4b8d76f8d198bf2929ad43b96eecf
"arm/arm64: dts: arm: Use generic clock and regulator nodenames"

The following oneliner fixes it:

diff --git a/arch/arm/boot/dts/arm/versatile-ab.dts
b/arch/arm/boot/dts/arm/versatile-ab.dts
index 6fe6b49f5d8e..289c3d093579 100644
--- a/arch/arm/boot/dts/arm/versatile-ab.dts
+++ b/arch/arm/boot/dts/arm/versatile-ab.dts
@@ -157,7 +157,7 @@ timclk: clock-1000000 {
                        clocks =3D <&xtal24mhz>;
                };

-               pclk: clock-24000000 {
+               pclk: pclk@24M {
                        #clock-cells =3D <0>;
                        compatible =3D "fixed-factor-clock";
                        clock-div =3D <1>;

(versatile-ab is included by versatile-pb hence it regresses)

The problem is: I don't know why.

Rob: any ideas? (Perhaps some uglyhack of mine, I don't know.)

If nothing comes up I'll send an "unknown cause" onliner revert.

Yours,
Linus Walleij

