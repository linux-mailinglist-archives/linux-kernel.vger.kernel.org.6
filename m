Return-Path: <linux-kernel+bounces-389795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3E9B7168
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2B62825F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E7335C7;
	Thu, 31 Oct 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJl+28CR"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857A8F66;
	Thu, 31 Oct 2024 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730336125; cv=none; b=pfQSBEbyTQvMRm9FNCauKdx2xnPkOWEuMPlMBpym4eG7x3SgkPB7XUetGiJ8m+zC9i5C4yPqHXt7ZWswm8vtIvbqXnfsKWiTet81YGxPZ0lY8sFE9s9BNtre0by/fp9TBV2vNCIya9p7uE/AUE9VYQa2CYaln8fJxH3Mz3yMUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730336125; c=relaxed/simple;
	bh=Od7omPSz9BaN9sshYGoYt/Z4rS3IaFoQqbm3IyJQMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHsM3tMOzUiWNIqZvOaC6euD1D/u+5UGxy2HdWB41AwfEEQVR2aL+0HbpVQvLyAn4v8toGfDkv7qs2CEan3T3xJy/+P39Y5NrkB1FodNLA7+rrVIWjfearw8wrluJ9uybXgLDf8VcxF/4LpohlWRMMdgBYEbw5k2VaYzb8A9SAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJl+28CR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ede6803585so1160293a12.0;
        Wed, 30 Oct 2024 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730336123; x=1730940923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBeWV7tV4dhN+Dc0nHSthtw8S0qQfB2LgeDtw0O2Ou4=;
        b=fJl+28CRe8AEwLNyvw/5dP2pd0r5Ti1cNiV2lHbEg3cxNfdhKcnNxn4O1jT75PxdfS
         d1Lb7dTqorLaXdMfzNyBqTAFz6oXhHAoV3D+CUwWR3AgHPIemW6gID/JAC/cYOiB/obC
         KsFtp54Z7rxRAZ8a7x9xdi4NYSS0ry/L0jZghuhEvdCrzHVh0R6O0uPCzE1TIVinqGCY
         eejomTMIKnYms61niyqB8qO8G5hISU2L5+2FM2QX21eUBAl9Hcf0ww6ps9Urpreiq1L/
         jhKZfkjk0yOEuCCG6dF7+4mWbgbYlT7CmJiOh6abJl2IJQxv2G38DzpVPam4wqqwiCqS
         2jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730336123; x=1730940923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBeWV7tV4dhN+Dc0nHSthtw8S0qQfB2LgeDtw0O2Ou4=;
        b=MZY3IsUeRI1mLULyG5pi15KdopAWsh0joQV4m8txCwdAPL7iHNAdjUGMJ/bOuXCzI5
         3uPrXSAWsUDT3Sd7ibm0M53DS+RkJnsmr6TdvG59/m4AOaF1AD6YO1ZlIButGryCqufk
         WY/EXy3Evd/BN6SCwZuDM2oUWicjoIIQTMgCxqxtJ2zAUiEUgg8N9XLPj/PWsb+h2Qvq
         dsnPpaPxTjY6NRS2SPj44gigPGwT6fmQO684zsyGy43LAivvTOnH0/9P1+woAgSq88j/
         LBbPLWq6p88edAFD8PHMSAOoTWyJ3fU+gorUS5RSf03S5JmLzvF05uOti95+unxDKFJX
         oGfg==
X-Forwarded-Encrypted: i=1; AJvYcCU80GQudVDFEP8qpiK+0ZshthiSOWGJkDhIptrt7ywjxPmLdPR82bnnccz4UHiwKGcrzq8Lb51PG96H@vger.kernel.org, AJvYcCVFeCoeIpwSxUI2Vkxexnl6ShOj4Db5KsFgQBiwtn1ABw8hlqwX8bAxKuuM5KTAeE3VnTefw9axtxSHpM8E@vger.kernel.org
X-Gm-Message-State: AOJu0YxHP6f9sOIbm4WhP1kOOlY+jEphlmhsekykFCCNFLRpQny2Mkn7
	8anLdMDQwuWWbsteCOh+GAHJjWwB+xXIvaxqucVh1TlRZi0gcOS9
X-Google-Smtp-Source: AGHT+IFEX+rnRSyrXUDoHNwkx7LfXDM9G0tpm8ZaarJqa9LeRXsBMW4+d9L3dOaT+rDyULyvQszO8Q==
X-Received: by 2002:a05:6a21:99a7:b0:1d2:fad2:a537 with SMTP id adf61e73a8af0-1db95019e92mr1050310637.18.1730336122585;
        Wed, 30 Oct 2024 17:55:22 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5f5bsm261059b3a.55.2024.10.30.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 17:55:22 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:54:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Andy Chiu <andybnac@gmail.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: hwprobe: export bfloat16 ISA extension
Message-ID: <prcy6rwydyjz55uaw6rorqbjv64kxu2ibaq2dy3xeno4nzfr6e@akhf6btyc7lc>
References: <20241028071746.869740-1-inochiama@gmail.com>
 <20241028071746.869740-4-inochiama@gmail.com>
 <ca1cb4b8-e206-4bc3-adf3-3801fd05f8e8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca1cb4b8-e206-4bc3-adf3-3801fd05f8e8@rivosinc.com>

On Wed, Oct 30, 2024 at 10:48:47AM +0100, Clément Léger wrote:
> 
> 
> On 28/10/2024 08:17, Inochi Amaoto wrote:
> > Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 85b709257918..8c30dd06f3c0 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -239,6 +239,18 @@ The following keys are defined:
> >         ratified in commit 98918c844281 ("Merge pull request #1217 from
> >         riscv/zawrs") of riscv-isa-manual.
> >  
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
> >       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
> >       mistakenly classified as a bitmask rather than a value.
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 1e153cda57db..95d00a065b4e 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -72,6 +72,9 @@ struct riscv_hwprobe {
> >  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
> >  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> >  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> > +#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 49)
> > +#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 50)
> > +#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 51)
> 
> Hi Inochi,
> 
> These should be added as well in sys_hwprobe.c (see hwprobe_isa_ext0()).
> 
> Thanks,
> 
> Clément
> 

OK, I will add it, thanks for the reminder.

Regards,
Inochi

