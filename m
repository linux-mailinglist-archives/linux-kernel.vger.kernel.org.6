Return-Path: <linux-kernel+bounces-194742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9AC8D4149
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9191C2207A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2A16E876;
	Wed, 29 May 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cSzXdvnF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5E15B11E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021275; cv=none; b=rKuP35taliQ7wnEYLdNYvv1wVxjHVHsuV52aYVZK2w1lANKXug95HuDdJ0mgGFOhV5/848fZn2kH7Jpvfqa/+BIttpG7BDLN0qtb2kgyIKyDK5FckDhs47+3QSE9l17S0L31UFjRpH3KAjWW4a772g6xAUFkq3duZURG6Ff/jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021275; c=relaxed/simple;
	bh=4BJG6CuqZgaW7Arz6k1E8rNnqlKsn97Py6v+FY/aJtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHG9MYc5RsCw1F59jmSCaQ+cikrmC1H6zchYjv8eVLj+8Vxzf/Btd2jJf0H9Ek6NQ8M9/daGR2hH5U227ovcTggKhcAtmFiaYPrH2gpcSEhcOxc0gsHQvIsx+A8IKvEh/FiVgna+U2dXNyRGvHT28kJJezNty39RXiagyQCqdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cSzXdvnF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70224f928edso292612b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717021272; x=1717626072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+33JepHINIVhbAh8qOzaJpAIf0uqs6BRQtkDENj6cbg=;
        b=cSzXdvnFbNAmqiliopKvnovDFLaoz8KmRb1PMiKqHImXns8EZcFEwCzU3031QdB8/Y
         RYJRMcTW9C3q0LfjiHxODmSXGVQXR9+Ko10oNaY1H3x3PpTa0NtZlm96/prK1eQytXrR
         XpcVSEvWVfLuZC1zECQj4Zhvy2npmAFdWdEOLyCfOGRQ0M4L6NyqSx4LfEsFl7PBiG/Z
         asiL9AsOXNQzM4NIzqmV3VJpv3yaldEJzDrLkF/u4aO0dRImHT/CixgZBU2S3Pk63jU6
         wEErUESGP31rxhPzSp2Vmt0Qlt122kEjdVZVPnkOJQ2n0l9f8k+Ob2m5MCrPtc+aRsBq
         lATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021272; x=1717626072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+33JepHINIVhbAh8qOzaJpAIf0uqs6BRQtkDENj6cbg=;
        b=P+Y/QKRfsi0v168NXIxnxK5NuQRgKGDjklpGUhKQI3ClMMC2szJpvHALqCIvTb521Q
         MfigSdweJHu+FQ14HUd5NUz2OcuK62YvP1r0F3GhiNm72Los8EP083ENIRMFr71XNzQx
         oNhgAfO8PL5UrUIK57nwtt4DqJ5AGQ1uK+Alg2Ek3MHDACz9QkeqcQRc13TyGY3jcPg0
         HGO2/Ju16goHUv7mMdhJM9PVeWrWWW/dqost4GLqBZyc79OV7rrhJsioG8io5O3fiOaI
         v3jcCUooVWnG/XY1X2qk7o2bAaTI0JpN/IKJ0za+lajx59jBQ7awu3pQAi/EONNXVda6
         Yaog==
X-Forwarded-Encrypted: i=1; AJvYcCXwf4FMmICPsQBoU6CuPK+tGjIVIA94OHrmrSF8rGY4tDNL7ZeVcvYCtgsZVAZASlU+jCPiwQHUFFSBCTrLlahQaHggQLLB2oAEZe5x
X-Gm-Message-State: AOJu0Yyp/j/yIYckCk9KSOa3/dLRtN7MCMajolM9RVd7IzFFDUgVxiTx
	8M356kqWu9+OoPz1JvyIcpBUsiPJodnijl4WbfsxQXtu2WzkbY5tZEhCnPLY288=
X-Google-Smtp-Source: AGHT+IGI+L6uEPqPqWpCYsDTU2d/epzJLqI8Fa4/v+SZQaArW3EwTo3rCZNunG+pitvTJAace7dG0A==
X-Received: by 2002:a05:6a20:5651:b0:1b1:e35f:3eeb with SMTP id adf61e73a8af0-1b26460d454mr361563637.46.1717021272535;
        Wed, 29 May 2024 15:21:12 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:32f9:8d5b:110a:1952])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7022ca54847sm533889b3a.183.2024.05.29.15.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:21:11 -0700 (PDT)
Date: Wed, 29 May 2024 15:21:09 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 02/16] riscv: add ISA extension parsing for Zimop
Message-ID: <ZleqVUhDW+xgiTwu@ghost>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-3-cleger@rivosinc.com>
 <ZlenZ+NvXxOxvqEO@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlenZ+NvXxOxvqEO@ghost>

On Wed, May 29, 2024 at 03:08:39PM -0700, Charlie Jenkins wrote:
> On Fri, May 17, 2024 at 04:52:42PM +0200, Clément Léger wrote:
> > Add parsing for Zimop ISA extension which was ratified in commit
> > 58220614a5f of the riscv-isa-manual.
> > 
> > Signed-off-by: Clément Léger <cleger@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 1f2d2599c655..b1896dade74c 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -80,6 +80,7 @@
> >  #define RISCV_ISA_EXT_ZFA		71
> >  #define RISCV_ISA_EXT_ZTSO		72
> >  #define RISCV_ISA_EXT_ZACAS		73
> > +#define RISCV_ISA_EXT_ZIMOP		74
> 
> Since my changes for removing xandespmu haven't landed here yet I think
> you should keep RISCV_ISA_EXT_XANDESPMU in the diff here and make
> RISCV_ISA_EXT_ZIMOP have a key of 75. Palmer can probably resolve the
> conflicting keys when these two series are merged.
> 
> - Charlie

I missed that other patches in this series were based off my
xtheadvector changes. It's not in the cover letter that there is a
dependency though. What do you need from that series for this series to
work?

- Charlie

> 
> >  
> >  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >  
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 2993318b8ea2..41f8ae22e7a0 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -241,6 +241,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
> >  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > +	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
> >  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> >  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

