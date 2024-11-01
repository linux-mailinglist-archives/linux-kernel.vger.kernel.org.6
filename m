Return-Path: <linux-kernel+bounces-391582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA139B88EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4CE1C217E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C054670;
	Fri,  1 Nov 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwzxVCaC"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6617BCE;
	Fri,  1 Nov 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426041; cv=none; b=mkGbSTVeOs3aKfM/fcYV5QuogpDu3eua3Ro2w5v4viLnwsm8K3R5YCVtpOMFRRnRA0MCGc97uN50D58rX1uRI60N87hTcWLSv45EQ4KlyZCLqjl6uyWEYXCERljyEyc9kWBbBHL4NYKwNT6ksr/PfMdxtekD2VM7t5bo7fzoLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426041; c=relaxed/simple;
	bh=DYXzLbNkX5We0MkfTIw9SDnFIwLhUmVUlIg+tLMebk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYVrWWVFI1bv27x2Z0jwIRSHT5rreYRkUMlVD9Z79mQj2W9QkUWtWVh+kfITesOXO6ErrUEOnE35tIggEHkFErbwyfJscUJL5TjQn4rqymYGk31yhMcLXL4uK/FRO8Y3v/oMQ8UHQuI0RToC7MtZDqHZo3wKkP4b90edtpg5x2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwzxVCaC; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5ffea2699so1324592b6e.1;
        Thu, 31 Oct 2024 18:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730426034; x=1731030834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6D1Wm3FMJcQXu9DNBHAKX/TsEgkUYA/96V4XySBVqQ=;
        b=jwzxVCaC4+hJST4FN9sbkOzvFDjVyhnTSeSNKm/MXN/UdQny5Ao/fFxDHhgVfpmpG7
         yfwd7lfdGxcAFsy0JtlniXbxpJdIdRh9rP0MYo2DmOx/t5deKkHaYMHMbwGTO3wf75jx
         8q98dnhwLOGjzxZ6vxs7qAHiuyIxHm/uSkfwrv6CXkkNAxCaFSyqoRKbfVYzvRcAe20M
         guqZNxIWCjK5rFlohP7AXCCla4zHNFo2pgWXRyBpA0O4h6rhR2obhXQ5f5GjOoWVzrt5
         6S+1AGZHB14xSRrXQLPyF9yZX0UkTuh40g4wG64Rkg8+7HN0CqFk6PP0khEZhnYn+57y
         cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730426034; x=1731030834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6D1Wm3FMJcQXu9DNBHAKX/TsEgkUYA/96V4XySBVqQ=;
        b=JfoYD5kpzKQq53ij1fhBOnpNmXt1+yNBabTo+LxxaNE7ytEO1YepGsCIGz1QrRHr5e
         Rv1rjg81asJDBQx4M79bz21T0+YCYAEze5N/onTY7fJQIzZMJc5BaMrSNxbvpLhnF7XD
         CfeEXPcg8d2+p5hq/pxQHVn8HoqviCSO2DjwNZeyEaIkIn7mRBv+Ab+fKP++eO+8Xql0
         Y4uGY4sjSmumf9KwThj71IrXNTPgINvgrxx3xFVeJUqtKtdq14zFi0dHjGVlUwRXN9wC
         1DJfPp79dI4dcYahltiEnUxqmRwYWP4IQGwdPlwSu0nNUy4TJ4HiHKpVxWOAceckv3/H
         VDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKDyvmyCt8rjmFoWxotMr9OLPFsbPs4hy14y852leWUqZER2gf6v4a7Hv8FF8dqczwONk2idgv70by@vger.kernel.org, AJvYcCW3pQgwtz8MweIqTFh7vJxnC0km719OTOcBGw0UKoME6H3HP7Dy8NvKmpKbAQzgXdHcxYZ678B0BRi4xjoE@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTntyqtGIbGMYkp3sg7MzagZqLo1cNoczowqqg8pajAKL7vy5
	ZGudFRu0NL6L5Ay0FAmkP/f/v6A9Dx20pExPaR5Q5oaod2hekIVjlM9YWFmEkf0LoHjV42xW+Gq
	aVuyeqZBWJh+DZ6zv00n25wjaQQ4=
X-Google-Smtp-Source: AGHT+IFZQ4NyGNMCDLgv6bCZyw5Zsw65CYGtv8tMY/DPPDyDLkJOAPDiCRinE+4bVOEGfk1xiPcwEU7dyPJOaeEVW6o=
X-Received: by 2002:a05:6808:21a0:b0:3e0:468f:7c5b with SMTP id
 5614622812f47-3e74c3d95c3mr1351262b6e.17.1730426034446; Thu, 31 Oct 2024
 18:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723716331.git.stano.jakubek@gmail.com> <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>
 <ZyMyJrSPTfFrSC-t@standask-GA-A55M-S2HP>
In-Reply-To: <ZyMyJrSPTfFrSC-t@standask-GA-A55M-S2HP>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 1 Nov 2024 09:53:18 +0800
Message-ID: <CAAfSe-uC+G8iEk_37vBr3+dQsv4a4tTTsz11hUguVRnU=r+4qQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: sprd: sc2731: fix bat-detect-gpios property
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 15:30, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> On Thu, Aug 15, 2024 at 12:13:18PM +0200, Stanislav Jakubek wrote:
> > According to DT bindings, the property is called bat-detect-gpios, not
> > bat-detect-gpio. Update the property as such.
> >
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >  arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> > index 12136e68dada..c8b30c0479fd 100644
> > --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> > +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> > @@ -97,7 +97,7 @@ pmic_adc: adc@480 {
> >               fuel-gauge@a00 {
> >                       compatible = "sprd,sc2731-fgu";
> >                       reg = <0xa00>;
> > -                     bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> > +                     bat-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> >                       io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
> >                       io-channel-names = "bat-temp", "charge-vol";
> >                       monitored-battery = <&bat>;
> > --
> > 2.34.1
> >
>
> Hi all,
>
> looking at this patch again, it seems there's some confusion going on.
> The bindings specify the property as "battery-detect-gpios", but the driver
> checks for "bat-detect" [1]. I assume the DTS was added with "bat-detect"
> to make it work, even though it's not conformant to bindings.
> It has been this way since the bindings/driver/DTS were introduced
> back in 2018/2019.
>
> What would be the correct way to fix this? Change the bindings to
> "bat-detect-gpios" or change the driver/DTS to "battery-detect-gpios"?

I would prefer the second, i.e. change to "battery-detect-gpios" in
the driver and DTS.

Thanks,
Chunyan

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/sc27xx_fuel_gauge.c?h=v6.11#n1186
>
> Regards,
> Stanislav

