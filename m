Return-Path: <linux-kernel+bounces-390091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DDE9B755F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F4E1C24223
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B16148850;
	Thu, 31 Oct 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq5i3TbZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101C10A3E;
	Thu, 31 Oct 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359852; cv=none; b=c8Kx59ZUyDn3hzYlmlTYqaPOpl6k6HEvHDFZLnpHDrjS7Z3rBy44HHGkbvQtsKeKAhTWLWT7s2Nd7QGusKPKH1k+JviXGyFhIZ8+kbvwVNsqAwIx/pYUYlgeo7RRl7y+khGg6bvnrmPQiMS46PDyCpU6aaEoFu5KYaXs+DTrokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359852; c=relaxed/simple;
	bh=zjxK4DTqZw9IhZIdod8GJ4JXuFeeFqZAEZ5JbU83ryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+7rMoXYV7FXrMxUVyRBNiJkiWwdMl1LqfyVjr47oij2qmAwz8Ekk2IOkNLVmGOLvCfzkCTOs9CBcIq1zTjCbjPXJAzy92AS8LuiiMECOcoklI0VO+ZI88fiYx2W5YlZNHA/4WgWFw8jiAPonolzQpmpAShvZNkPwltjbORkZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq5i3TbZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a628b68a7so84121666b.2;
        Thu, 31 Oct 2024 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359849; x=1730964649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/eLyIHEDLmnqKBkl9EZ/QS1fOPZWds5n1WBxINpUw5s=;
        b=nq5i3TbZhMj289A7RC0u+7E78XBFk67wAP8Zy8heDdalUruthxWSCm5ViqRs1KUdKj
         Gi3acAffUR1OKOMAx1KNZo2is4D6KqV7AIXlL2G3x64kTzjthZyH5XtaJYwesoYawbn4
         jd+JSEcLGMl4Zc9I81Rx6XrwHDxQrxva6KKs1zc7PHh8zu2J+J/cDtLWI99MgaVtN5/g
         9yApVkHDiyhx0vNty2m7th2Z+uWgmffyvV8xyBVj9g2L1lT+IaS7aREVx9ohug9Cz0YL
         QXFe73ETdWkFEDU6aPvVqF74P7bNVK/sqg6yGeTIFajiEwUQkY76V8uSldQDey0w6wAE
         hWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359849; x=1730964649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eLyIHEDLmnqKBkl9EZ/QS1fOPZWds5n1WBxINpUw5s=;
        b=Se2WTUVui3shmHuRMx6iaJyVdi6Ggeq83/SACfqNoxMItl/OOMiQZkYfAUWmF4RIKU
         xrYAgN2kL/AXJCyIr+m2bw15jghlcDyTUoS5auz9s3j0uYIKLAC4CaTSh4fwS3MbQubC
         KABo9j2Vx4RvvSVHH2fYa0t1JzHRyqK07b8MeuVF5TCdsAhSRJDh6I7iXdxKmreWyAs/
         EhhLJiHVMDH/FI8x0hgTl5IYeuQFUmKTMabJoLiAUu9lAma3RvjPJkd3//0PRny1ARWE
         GgrzTbqYRGqbygh1LLO+izs7aYnaFPq2ejsRTBDOEZWr4iw+H0o/Qq0PfNIOjcAKPv0j
         fBPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1GBtL2zgjANOJWdSUsaH7WjtbCd/hvSHl63BzZ4OGhSOzI9PsSQPoDak2W4sHN8dwfOPDadmGeAV83SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEme2pqQio5t+dRP9lUNEKx2XS4/IgkvtCynQvaDjbLze4EjsM
	FFHpf+HziXF81CwXYQ5ypKlgQY8Ytt142hnKCb2FAawjG+e/+Qro
X-Google-Smtp-Source: AGHT+IEc9E2xS94xaD1VTkOKzTYVeevxnLXidGIu1k9elFl5LfpBJ21mQ6g00F4tlmDxQntuwkCllQ==
X-Received: by 2002:a17:907:94c1:b0:a99:4ca4:4ff4 with SMTP id a640c23a62f3a-a9de5d98002mr1480023466b.23.1730359848554;
        Thu, 31 Oct 2024 00:30:48 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566797a7sm36034666b.190.2024.10.31.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:30:48 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:30:46 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: sprd: sc2731: fix bat-detect-gpios
 property
Message-ID: <ZyMyJrSPTfFrSC-t@standask-GA-A55M-S2HP>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
 <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>

On Thu, Aug 15, 2024 at 12:13:18PM +0200, Stanislav Jakubek wrote:
> According to DT bindings, the property is called bat-detect-gpios, not
> bat-detect-gpio. Update the property as such.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index 12136e68dada..c8b30c0479fd 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -97,7 +97,7 @@ pmic_adc: adc@480 {
>  		fuel-gauge@a00 {
>  			compatible = "sprd,sc2731-fgu";
>  			reg = <0xa00>;
> -			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +			bat-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
>  			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
>  			io-channel-names = "bat-temp", "charge-vol";
>  			monitored-battery = <&bat>;
> -- 
> 2.34.1
> 

Hi all,

looking at this patch again, it seems there's some confusion going on.
The bindings specify the property as "battery-detect-gpios", but the driver
checks for "bat-detect" [1]. I assume the DTS was added with "bat-detect"
to make it work, even though it's not conformant to bindings.
It has been this way since the bindings/driver/DTS were introduced
back in 2018/2019.

What would be the correct way to fix this? Change the bindings to
"bat-detect-gpios" or change the driver/DTS to "battery-detect-gpios"?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/sc27xx_fuel_gauge.c?h=v6.11#n1186

Regards,
Stanislav

