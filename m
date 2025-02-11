Return-Path: <linux-kernel+bounces-510191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33880A31988
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2583A4C45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2902267AFF;
	Tue, 11 Feb 2025 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjOthoFE"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A6267AFD;
	Tue, 11 Feb 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316413; cv=none; b=cHy7cAJtAFUTYZpGtfV8epOYV4oKFCOV212L27S6yJNnu8PNnW/JnwU4TVfTUkQ/z3sGJCKUdVGJ9rGUtj5b9s9bp0PTLhM0xW8k2RA844vbHYIXru4aSPBw2T0tFnSMhaV0gf7SUD1hgPBsxFptAFgCrk+LG5+Ad79u/T7zLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316413; c=relaxed/simple;
	bh=am3HHZgqhhrukseYR/5fGOsbDNnRYelnnNaURmCA4f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqU80/JS+3/AROy9vfhUhlMGMRYHMvKhlGcKWEcGSPD/+uGBqhPQI+AskEfxbeSB9Xbkg/VnM/jm3dUWC1DAHTSiv4x5hij0ISjbbyo2RUvTZ1P7mLZ15fY7cxjnQzXyb7M7cTlKGzeKnWXbdRzLfV/JoWMBpdD5gLuzqW9vuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjOthoFE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46c8474d8daso49053651cf.3;
        Tue, 11 Feb 2025 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739316410; x=1739921210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LHbTjBhQMHeo18vkdg+R70RaCpRDyN0SUOpcR7vgLAk=;
        b=VjOthoFErlyW1EUfHtqApZ2qA/SC09+uFS/HAphOS3yrPurk7IxKSokVO0pfdtey7n
         FooyD+hPZMFIYu8CQ60rh/L9ZsBZgA3I8MUJktq63ozLGXQ0Z6vhVE73TH3mlWrF6rXe
         tZE0rh13tU5UBGtSSlQF+imtRsHa6KqcUOoJVfgL97E+oqqjRfQNoDAzhy0o9y5HtHcQ
         7ZG6J5DPhxKYMS1nThNL+260anZDgj41KDLeym03zsZIouQ9rzm0uRU3uTnTQqWVEDx7
         Z+Ydw/CtXlB2kXXVyPWO/0sCOwyEcmWhCsIjWR6q284Ppa3qnXG2Jry1J60+jSsqHm/v
         hVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739316410; x=1739921210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHbTjBhQMHeo18vkdg+R70RaCpRDyN0SUOpcR7vgLAk=;
        b=A2Wf6VbUCefnnPrmxG9Vmw4TybdH2b5zHyYR9dXEf2Mjma0uEI+qnesh5lIY+piC5c
         vyFmz+aDca7SUXIjY4NC2DFlauiRhBIcPZhr7Hw14mRb5l7CRXGuBeIg5NBrG+07+H6I
         Y7tA/P9nmgK3n1UHjw//UBvQqH42GyKwMKFzknRz9W0DCfROIVoE2h7R5HbgEe0xiHyQ
         FXBPbO+8Rm3I3Qi2vF0DVZ2QF4o3ynaTn3sjWvuvkmzw58ZLdqj/6IAc3ePdqpcweq2Z
         GUK0KH0zcr22OPe07Tgi7yOr0rJ3sji3EIss49srJKzIR+0iakR6vVoBdreLLgwqOEqa
         ve4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZdqZh2RSJQCJw4J2PSWqO7ws++5CNL0xfE6Ye/SUA70gMsk/eNTDkyjGG0AX67Niy72hzGVLc2kCR@vger.kernel.org, AJvYcCV4llET+1zmB0CHD8X6nWTYBT5U6h81VdBYajd/vyMXtTyLmtBzoJN+WiSn46ZQCb1ni72uuUsTbGzIx7ca@vger.kernel.org, AJvYcCWt6GuO2palf1a1txTN9uR9i2anqPRK8jNvBVbslj01MoYVJHO72CBgpX3ft6jFwJ7/NUOPD33FEv5Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx456qDpvCURUkdPzI3sqP1at5WHi5JvcpJliiezM5XokRAaH7N
	u6THalRZw/yPhk2HVKA8QneUmB/DPKMzWrTBUuYK/y0AzO8NYBU1
X-Gm-Gg: ASbGncvrqJWoS15twjD9bb3Id9VSBmgnvzqGKjT2HGA1zc1MRDanqtGTtxc0HFLcS1Q
	ckJXnMOXSxlY0jYn9mY7Z5DqkE//7FBFhgxe+g0WUM3VmraKUTmLPDEAeTjgI3OahP9IVKd1KDM
	rOM/GmZNl8NNb8ce2K2ksBsjt+s3st792Pz7wMtWkKRNuc+6FFECz86GzfYPa261DPYPE956ub/
	4uQCL4Z5QwNDm7bGLG/qqZNKnW3MFAqDYP2TO+Hn9yyHUBBeVjLSlRO1eZFdynLqBQ=
X-Google-Smtp-Source: AGHT+IGdYvrbgZUnhsysZ3YIfofS/ssklt7oluXB0IbrtQlBkVELl0TihfQbvfT0rCsNxXdeOI4zuw==
X-Received: by 2002:ac8:7d8a:0:b0:471:91a8:d7f4 with SMTP id d75a77b69052e-471afe4c818mr14894221cf.24.1739316410424;
        Tue, 11 Feb 2025 15:26:50 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47198ee3fd8sm25855121cf.55.2025.02.11.15.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:26:49 -0800 (PST)
Date: Wed, 12 Feb 2025 07:26:42 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Jesse Taube <jesse@rivosinc.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andy Chiu <andybnac@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Jonathan Corbet <corbet@lwn.net>, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v3 2/3] riscv: add ISA extension parsing for bfloat16 ISA
 extension
Message-ID: <rjnohunxmhyz4sonz5atmirpprpfwihsv7uazgb74josjxghjm@ju255opl6m6e>
References: <20241206055829.1059293-1-inochiama@gmail.com>
 <20241206055829.1059293-3-inochiama@gmail.com>
 <374d3b07-e16c-4468-828a-a2a542cd88ac@rivosinc.com>
 <7qkfqzhytjq2qwo2wg3xtkoqu6id6wduckeeudbn2yt5p5p7xv@2gl5bcny26rk>
 <20250211-dizziness-eclair-2ef49cc5ad0e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211-dizziness-eclair-2ef49cc5ad0e@spud>

On Tue, Feb 11, 2025 at 01:45:06PM +0000, Conor Dooley wrote:
> On Tue, Feb 11, 2025 at 08:42:39AM +0800, Inochi Amaoto wrote:
> > On Mon, Feb 10, 2025 at 03:38:58PM +0100, Clément Léger wrote:
> > > 
> > > 
> > > On 06/12/2024 06:58, Inochi Amaoto wrote:
> > > > Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
> > > > were ratified in 4dc23d62 ("Added Chapter title to BF16") of
> > > > the riscv-isa-manual.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > >  arch/riscv/include/asm/hwcap.h | 3 +++
> > > >  arch/riscv/kernel/cpufeature.c | 3 +++
> > > >  2 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > index 869da082252a..14cc29f2a723 100644
> > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > @@ -100,6 +100,9 @@
> > > >  #define RISCV_ISA_EXT_ZICCRSE		91
> > > >  #define RISCV_ISA_EXT_SVADE		92
> > > >  #define RISCV_ISA_EXT_SVADU		93
> > > > +#define RISCV_ISA_EXT_ZFBFMIN		94
> > > > +#define RISCV_ISA_EXT_ZVFBFMIN		95
> > > > +#define RISCV_ISA_EXT_ZVFBFWMA		96
> > > >  
> > > >  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> > > >  
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index c0916ed318c2..5cfcab139568 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -341,6 +341,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > > >  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> > > >  	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
> > > >  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> > > > +	__RISCV_ISA_EXT_DATA(zfbfmin, RISCV_ISA_EXT_ZFBFMIN),
> > > 
> > > Hi Inochi,
> > > 
> > > You could add a validation callback to that extension:
> > > 
> > > static int riscv_ext_f_depends(const struct riscv_isa_ext_data *data,
> > > 			       const unsigned long *isa_bitmap)
> > > {
> > > 	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
> > > 		return 0;
> > > 
> > > 	return -EPROBE_DEFER;
> > > }
> > > 
> > >   ...
> > >   __RISCV_ISA_EXT_DATA_VALIDATE(zfbfmin, RISCV_ISA_EXT_ZFBFMIN,
> > > riscv_ext_f_depends),
> > > 
> > > 
> > > But I'm ok with the current state of that patch since I have the same
> > > thing coming for other extensions as well. 
> > 
> > 
> > I think it is good for me to add the check, and I wonder it is possible
> > to add the extra check for zvfbfmin and zvfbfwma like this:
> > 
> > static int riscv_ext_zvfbfmin_validate(const struct riscv_isa_ext_data *data,
> > 				       const unsigned long *isa_bitmap)
> > {
> > 	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_v))
> > 		return 0;
> 
> This is not needed I think, V "turns on" Zve32f. If anything, you should
> be checking for CONFIG_RISCV_ISA_V here ^^
> 

Thanks for pointing it. I will change the check.

> You /could/ call the resulting riscv_vector_f_validate(), since this is
> nothing specific to Zvfvfmin, and could be used for another extension
> that requires a Zve32f or Zve64 minimum base.
> 

It is OK for me, I will change its name.

Regards,
Inochi

