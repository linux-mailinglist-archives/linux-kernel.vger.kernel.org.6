Return-Path: <linux-kernel+bounces-199416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E68D86F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C47E1F2283A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38682134414;
	Mon,  3 Jun 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ec1EpI/Z"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430EF12DDAF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431062; cv=none; b=PQPpi1Euo1ZlRZI4IKNxTRCS6lLxOz3Pitz9EjNV6siDQ0m3nBrPUPc/2VrEQSV2Dp2WwVNv7D/5HDg7xHiREe9tAucfDpga/ifLNeVtpubKn7RpORGPli1sOQ3KPUmzTyFdZf0l7HiW/2ZzqFedU4rwAyAsnr38kJKD9qJNdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431062; c=relaxed/simple;
	bh=a7HaajZH1onoF7BEaMl7LJMhcs+YBupE9HdQ0Tm2cnM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2IPVg2O7TOxnrf0VrOyaVw6RD+iBL7VIpktyWpSO3Ehk4Y3W2NVl79rIIL1P9ZQGd7XhWZDZuYtWsZtGwDcNevo+GPT1eWdSSm8s6lNaGuK6PnEC5NwYCrKI3r7uG0A9q41UKCmf6Q+YsxSfZeQPtnOLXCIcbXIL7hPufsQ8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ec1EpI/Z; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B10193FE68
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717431055;
	bh=vU5/sQdk1KvDzjQYZ2m7el5n+WnYafJy1tTstO9fsbo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ec1EpI/ZnZaNbFyYaw4OdNLdGqXvgn6mGAIQ1UC4SOr3yCDJptgd9SvQTRbaIP9tj
	 s5WJrzfcHSevqUltFPJMOJd0iNhnYx2/8U9lhvKrxtSRO70wGy+KCmY8IYVzRzmA1R
	 Ce9it4n46vEenC1MbmoAslYw2fJ9JYR7CzoTaDmByZOkw1xg7e4lzRDlIGBQPhO2s/
	 K/WqnohGFITONnOswA+BAtqtjfOr6l0663tkYKTBMuqsAhaEtYL/n0XxZFt79iz+jh
	 ioBUoEAjTrSbA3Uluu5YCkb/hHTGthcq+G7qp0mdQ9gXnl6V3xLfoXrZc6svUv3hq6
	 FsKmjGFoZhXRA==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5234e83c4a6so40237e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431055; x=1718035855;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vU5/sQdk1KvDzjQYZ2m7el5n+WnYafJy1tTstO9fsbo=;
        b=O5EoELR98MENI07WTPS5r5C5nzsvKPmTfNaMrdENsyKIgNbonHWOhAFh2QddgUmgUR
         +EcE+xvUW0ufTF5Ofg5ut6jTOrmciKtdcTUL5BdJImA89kLaGuRGyKDlSwQlapAnYtl4
         c5QKRWm+cPBdCrG+Tgr+mfojp5IJ/GtrwmeNMd0qKgOTsUp7MKtrnKrTihB4VF8TDAoD
         YPl+mlw9lNDQeMokdWdlLSevuy7Vg4lEOt/SJCjBqV4hnOwfYhvqbFQuA2iSTzrP6gm/
         kxBRBGO1QkpVM+AhmjHq+N/dNu+9o4hbapD4YJm0qIKwUf3mbxgTYSk8F5nOqY/qHHbR
         qdIg==
X-Forwarded-Encrypted: i=1; AJvYcCWFUaUb5/Q8SzAUxHBmN72BeNyyscexuK5rjLPN1hJvvzIxPd8JA9xFv8xrafZeuXNVsKEdaEAKSjU4vf59P1hydg1yL51LIeAwYTQ5
X-Gm-Message-State: AOJu0Yy43dyLnrNfAAQNRb6FzJaHkBIa/1ggsOMphcotC8RUMuR89Eqx
	ddHQLIhXykfnQjjxP/944QtQIyWZh1/wsAIZ7v4JufK+ZVydzAsH+ptPqyE1+lSyOf3DOxtdrhw
	5IIeTumLgzBATmG8hX8/A4E21fqu8tur2g1Blybj5ADL0X+0vfQlaZmyuSb4KgVoVwG6gH54OiX
	PFusB0LniJQkUWVAaxmskGOweRyXHApdTXuoOrtDOM83vaDM9k36x/
X-Received: by 2002:a19:7604:0:b0:529:b9ad:52b5 with SMTP id 2adb3069b0e04-52b896c1655mr5647289e87.41.1717431055148;
        Mon, 03 Jun 2024 09:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX6z4960cX+FBq7s+WxsbEO4lbLdIqqK/67kXSz/Vcjt4Ec0DAtIzwSWZ6eBsX3hWA66D8uBk/mSKdElTxnrs=
X-Received: by 2002:a19:7604:0:b0:529:b9ad:52b5 with SMTP id
 2adb3069b0e04-52b896c1655mr5647266e87.41.1717431054746; Mon, 03 Jun 2024
 09:10:54 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Jun 2024 16:10:52 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240603150759.9643-1-matthias.bgg@kernel.org>
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 3 Jun 2024 16:10:52 +0000
Message-ID: <CAJM55Z82+_RL1Z+DCW+_xgE7ZMmiWdPekCt6qtREPXg1jB+68g@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: Update flash partition layout
To: matthias.bgg@kernel.org, kernel@esmil.dk, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, aou@eecs.berkeley.edu, duwe@suse.de, 
	linux-kernel@vger.kernel.org, palmer@dabbelt.com, 
	heinrich.schuchardt@canonical.com, paul.walmsley@sifive.com, 
	linux-riscv@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"

matthias.bgg@ wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> Up to now, the describe flash partition layout has some gaps.
> Use the whole flash chip by getting rid of the gaps.
>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Hi Matthias,

Thanks for the patch.

>
> ---
>
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 8ff6ea64f0489..37b4c294ffcc5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -321,16 +321,13 @@ partitions {
>  			#size-cells = <1>;
>
>  			spl@0 {
> -				reg = <0x0 0x80000>;
> +				reg = <0x0 0xf0000>;

..this is definitely fine, but..

>  			};
>  			uboot-env@f0000 {
>  				reg = <0xf0000 0x10000>;
>  			};
>  			uboot@100000 {
> -				reg = <0x100000 0x400000>;
> -			};
> -			reserved-data@600000 {
> -				reg = <0x600000 0xa00000>;
> +				reg = <0x100000 0xf00000>;

Do we know that all of the VF2 1.2A, VF2 1.3B and Milk-V Mars boards have at
least 15kB SPI flash chips? In other words were there a reason this previously
ended at 10kB?

Also it looks like my Mars board and VF2 1.3B both report discovering a
"gd25lq128d" chip of 16kB, so why stop at 15kB?

/Emil

