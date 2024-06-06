Return-Path: <linux-kernel+bounces-205110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8688FF788
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A9FB220A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731F13C8F9;
	Thu,  6 Jun 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YqkpmnOw"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A3487A9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711820; cv=none; b=sWzHvSXKNJAkZqHMeBKVBEjfTk819HtBdHF64NmbK9IVICmv6YjOjYlhbeQ4sZQhVdwMM7d83oy4D2oPqMfN+y/8+Jsh0Hy+DBs9UwE58dGoG52oQGlhgzJBTd7/L8KSCnmqYHV1SNQ5myYgB0DRykRMfSU8wu5X86qzl8DBinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711820; c=relaxed/simple;
	bh=eFsaU4eSsMIiwxDQvxkU6/iVZeYSlNg0j3AYHmAB86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSjmRBHO1LqV8vGq5MeVwsQWuNCecLvvraF7BqCl6S3nO1oyKOZf1eNDsvueoroqKCfmSwbvABK6Gpu8gFGlx0n6uApK1uwv2Ch9mMl+cVTvX0RLenYvFbbvl0Z839nEZgiXNNa3a2ptjaABKeaeCMUyR2j8jahh9bZcIlahJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YqkpmnOw; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f938c18725so921266a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717711817; x=1718316617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJTeyb0eINc0gwLURpfqtisGaEu72F/v9nDe3ziMfx8=;
        b=YqkpmnOwFCNHct23WRepxwi/TPsnorVKMTeq/nGLApb2C4cwY/2rTPU8HIuTkChiAz
         QedqsrY5IOAij1CJyYFeQH2BRB1kcjmwctKV6IDIIGjTNyEZgs8VTtG6ighr4ho6eLo9
         8MFrdILg+to3z0PSzBHX24MQuxLdbXvkoGZOtXaMPKlUZu4MomCpibBG6FZnJKj05ygS
         71sNqZIbNbMV4xyOOkft46cyjOGmHnjLGfNulzpYlDATmGov6jatzNC1V8EhgTu6VEjN
         jfOns+bcBJHjMhalNxVa2sr2QohPqd/mkECMPc62MrCJADNoj2T0n4wJIIN/4udr5z8t
         ABqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717711817; x=1718316617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJTeyb0eINc0gwLURpfqtisGaEu72F/v9nDe3ziMfx8=;
        b=WLxoM2T2Lgqg389RMf/5TDD7u3QFFXuaNztpFn+Go9+on4zfoL1U8l+ZVpnTnMAfC/
         B4AerXjsQF0r1senHF2Cau+FEE7R0LlUA5wjECjwa6i2OhlTptPq3QQDEqZvkC7yW9L2
         /Z91Rosvk4oNzDw9Yd6Vt41vw5rePiixm0h6bDIQVQbGj2u2pM2Yelwr5jNmGGrXhPYQ
         gQHVJhny5hr2XisSUrSJf25BKeC2162rTrL5V+ru/pLMMXdsthfOd8uz8cyI+rJg40mf
         W3V4K7o5vvO2Cm1wJc6SO9i5Imh4AgRdojJrR/8TIjDfQG/HJaz0AQvz/b4ofGJHkqlD
         ziWA==
X-Forwarded-Encrypted: i=1; AJvYcCWKiDel9DLtIoVzFodrk5lMyzneJTGS+I11Uz9ajZql/O7ew4IiMpTKLp8dCH4HRiAZ7Ha5iO5HDGv15wZqJrUceQYJzX6qNLoGeExR
X-Gm-Message-State: AOJu0YxDJf1hxXUxtFOlPhGuabeg/zUev5TMVDvGK7npTosqL1qhHqgm
	hSmGdXdyHTUbF1oRYus+PtpC91FaLoThVWmrv5CpaUHxMeAliF19jy7jqd/DV0A=
X-Google-Smtp-Source: AGHT+IHtnyWwXVrneu4BW4k4zNBmga8uhKsNdRgD+FGVHVTj0yCMQj+8zj2UHpYqSzUhz3bjsiIUww==
X-Received: by 2002:a05:6358:63a3:b0:199:a132:8aa with SMTP id e5c5f4694b2df-19f1fedc4b3mr123515855d.17.1717711817515;
        Thu, 06 Jun 2024 15:10:17 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de2017fc69sm1356840a12.17.2024.06.06.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:10:16 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:10:13 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Add Zicclsm to cpufeature and hwprobe
Message-ID: <ZmIzxcdUJftnxptc@ghost>
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606-acetone-whisking-af2ba796238f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-acetone-whisking-af2ba796238f@spud>

On Thu, Jun 06, 2024 at 07:43:52PM +0100, Conor Dooley wrote:
> On Thu, Jun 06, 2024 at 02:32:13PM -0400, Jesse Taube wrote:
> > > Zicclsm Misaligned loads and stores to main memory regions with both
> > > the cacheability and coherence PMAs must be supported.
> > > Note:
> > > This introduces a new extension name for this feature.
> > > This requires misaligned support for all regular load and store
> > > instructions (including scalar and vector) but not AMOs or other
> > > specialized forms of memory access. Even though mandated, misaligned
> > > loads and stores might execute extremely slowly. Standard software
> > > distributions should assume their existence only for correctness,
> > > not for performance.
> > 
> > Detecing zicclsm allows the kernel to report if the
> > hardware supports misaligned accesses even if support wasn't probed.
> > 
> > This is useful for usermode to know if vector misaligned accesses are
> > supported.
> > 
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h        | 1 +
> >  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
> >  arch/riscv/kernel/cpufeature.c        | 1 +
> >  arch/riscv/kernel/sys_hwprobe.c       | 1 +
> >  4 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index e17d0078a651..8c0d0b555a8e 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -81,6 +81,7 @@
> >  #define RISCV_ISA_EXT_ZTSO		72
> >  #define RISCV_ISA_EXT_ZACAS		73
> >  #define RISCV_ISA_EXT_XANDESPMU		74
> > +#define RISCV_ISA_EXT_ZICCLSM		75
> >  
> >  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >  
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 2902f68dc913..060212331a03 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -59,6 +59,7 @@ struct riscv_hwprobe {
> >  #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
> >  #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
> >  #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
> > +#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 36)
> 
> Missing an update to hwprobe.rst.
> 

"RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)" was also defined here in
6.10 so this key needs to be bumped down one.

- Charlie

> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3ed2359eae35..863c708f2f2e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -305,6 +305,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >  	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> > +	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
> 
> Please read the ordering comment above this structure!
> Also, you're missing dt-binding documentation for the extension.
> 
> >  };
> >  
> >  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index 8cae41a502dd..b286b73e763e 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -125,6 +125,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >  			EXT_KEY(ZVKT);
> >  			EXT_KEY(ZVFH);
> >  			EXT_KEY(ZVFHMIN);
> > +			EXT_KEY(ZICCLSM);
> 
> Order looks off here too, I think this should be added in in the same
> order as to riscv_isa_ext, although the requirement isn't hard here,
> just that adding to the end of a list means it's annoying to check for
> what's missing.
> 
> Thanks,
> Conor.
> 
> >  		}
> >  
> >  		if (has_fpu()) {
> > -- 
> > 2.43.0
> > 
> > 



