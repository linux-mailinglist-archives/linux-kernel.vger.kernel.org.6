Return-Path: <linux-kernel+bounces-224012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F6911BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0F61F24DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395B15665D;
	Fri, 21 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c0oEOSZ/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7926AD5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951986; cv=none; b=UOCcez9+ECI8/Y+n2jIDiAa00amdq/sel9m3b1p9NIMeV/z+TzuhsIivYoYbQhHiGUNkig/Fbic0oNn+IQ5/9JLJ3yQ0uLT3/NA6vkV3icMyiRV1as4+0973vMcbENYHcxrS828IGPsxk3MYtkrUpabEUftSqfyXmgp+czUktfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951986; c=relaxed/simple;
	bh=buDn8Qrjs1Fu3evAktgCVTxk8i5CZvApHVrC5wYuo4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihKw2RY0LmM0I6sdqby9Yvk+HSFhJc4jmLUsdQ93dVmtfI70bfsLuQlI0AL840uLhxrS7UyXHt0+/Gyk0oTcsMaWjlEpP5uSIbaSUV5loLMu94sIy+3RJRIKMmNgAtFX98MMwvaVtKbYA7wTbJa28y89I0O5kBrnHYyqxbMvgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c0oEOSZ/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e4dbca52f0so1307982a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718951984; x=1719556784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIGjmxpD8vHtgswj1EvnHC+JKRATcoZKG+yQ94+3Xdg=;
        b=c0oEOSZ/cqM0MBXXiX+BUhN6FsEo+MDa4uD0gT0cWYoYI1MwGFtHxS4T2EUDKc6ZYu
         NUT2ft3n28UrQJf61/ofWwogbOCzk4/pGQLY3UtY7cVWd+22qMzjLKcPZeZyz4nei3q0
         SRMSC6uba7GzLkPOkyolgWE0fDYmkYBMgwlKbgiaT8C2WEh8JUgsMHHewr9hqakBxwQP
         rtqOGyqyLnx+MoHYujZWNlY4vmxTCL/Cc9mh/+pJJpFcVHJ4q46PxHhlWznFkndQ7k7g
         fjnk9ETdr+7mt9jFUL+Jah+GESpEs6acjENu/yy+oQkvbQ8oxGzYcqZ+g+tuY4UwyFVy
         rcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951984; x=1719556784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIGjmxpD8vHtgswj1EvnHC+JKRATcoZKG+yQ94+3Xdg=;
        b=V1Z0b8gMmCfxhJHY9sTmdlmAr+ode1QyIK0N28skt5SlIe/5Cp0yP/oKVFcARkQlLr
         dVPBLMAKZTX8leCeE0Td10OMd8U/rHDafoVs13m31wZ6QgVmITGxprgQ9tUTrRXGyMQG
         +L2DAY/qxAyiLPn2XDgcuzsxQ+P4rvgqUOwoGPYGtbqos75OxRFx/vhXtqjsqzhBGyHJ
         kuuLVyKYQGxS4Zn93pEvZeL1CFb+Qo26oaD7D3UGA6yprSKizQ2+LbS3HNPSOKtsIpg4
         /o0nsvV4fl9Ritx8Fy1CS73pbGNr9rRIjQR2z4sXC2X748Vo0HUoXQeEPfEdzpseNrI8
         3Csw==
X-Forwarded-Encrypted: i=1; AJvYcCVCGzKq2HYJf3DhtJN0ZLzrcWbnfpPhhyrPtUPB1pnhT7P7WAhnEdBTjS+F7k63Z/wcbYfCT+eTCzRmuOStovEwhDqHJ3WaTS6tz2xC
X-Gm-Message-State: AOJu0YylEc3axSEnqYmTGwsmwQGXQejbBbjt/bcj8s4oarVcSvSjPi9m
	91cIMLreEMfoDNBxMejv9pEBIiOmiTs90czHf9X53M9ZwSiDHbU97XiSfHp5kYRF87MWrIdMrOq
	a
X-Google-Smtp-Source: AGHT+IEMZS4cVoReUDY+Bpe+zsFKW+rFHNx/nrRypfyBZLh8aU4qRKL8sxg1cVYyWpJ9mX14g4671A==
X-Received: by 2002:a05:6a20:3b84:b0:1b5:cf9c:2936 with SMTP id adf61e73a8af0-1bcbb686f51mr7771982637.39.1718951984040;
        Thu, 20 Jun 2024 23:39:44 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:cfe:eaff:a05e:659d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a623bcsm792294a91.2.2024.06.20.23.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:39:43 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:39:41 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rppt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
	akpm@linux-foundation.org, bhe@redhat.com, dawei.li@shingroup.cn,
	jszhang@kernel.org, namcao@linutronix.de, bjorn@rivosinc.com,
	vishal.moola@gmail.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: cmdline: Add support for 'memmap'
 parameter
Message-ID: <ZnUgLZow2ODPH7vp@ghost>
References: <20240618120842.15159-1-cuiyunhui@bytedance.com>
 <ZnTRbptoowL+1GOP@ghost>
 <CAEEQ3wnNZJviirqWCAG7mXsbynC+=Gq5q4jh6b4yamm8cnzMAw@mail.gmail.com>
 <ZnTvArAQpfCm10tc@ghost>
 <CAEEQ3w=6EZMFsH2y7efZsX00CzytyMu+Be_RT8CicejMB6qAJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=6EZMFsH2y7efZsX00CzytyMu+Be_RT8CicejMB6qAJA@mail.gmail.com>

On Fri, Jun 21, 2024 at 02:02:18PM +0800, yunhui cui wrote:
> Hi Charlie，
> 
> On Fri, Jun 21, 2024 at 11:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 10:08:39AM +0800, yunhui cui wrote:
> > > Hi Charlie,
> > >
> > > On Fri, Jun 21, 2024 at 9:03 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> > > > > Implement support for parsing 'memmap' kernel command line parameter.
> > > > >
> > > > > This patch covers parsing of the following two formats for 'memmap'
> > > > > parameter values:
> > > > >
> > > > > - nn[KMG]@ss[KMG]
> > > > > - nn[KMG]$ss[KMG]
> > > > >
> > > > > ([KMG] = K M or G (kilo, mega, giga))
> > > > >
> > > > > These two allowed formats for parameter value are already documented
> > > > > in file kernel-parameters.txt in Documentation/admin-guide folder.
> > > > > Some architectures already support them, but Mips did not prior to
> > > >
> > > > Copy-paste from a Mips patch? Should say riscv :)
> > > >
> > > > It looks like this code is duplicated from xtensa and is effectively the
> > > > same as mips. Can this code be placed in a generic file so that the code
> > > > can be shared between mips, riscv, and xtensa -- maybe a new config that
> > > > gets selected by mips/riscv/xtensa?
> > >
> > > Yeah, that's actually what I was thinking. Which general file do you
> > > think would be more suitable to put it in?
> >
> > I am not sure the best place to put it. What do you think about
> > mm/memblock.c next to the "memblock" early param?
> 
> Is it inappropriate to put it in memblock? The implementation of mips
> is different from that of xtensa, and early_mem is also distributed in
> various archs, so we still put memmap in riscv/, and then I will
> modify the commit log.
> What do you think?

The mips implementation is very close to being the same, but I am not
sure if the differences would prevent standardization. xtensa and now
riscv would have identical implementations though so a generic memmap
implementation could be only applied to those two archs.

The "mem" early param is also scattered across archs as you point out,
but that looks more fragmented in how the different architectures have
implemented it.

I will copy Mike Rapoport to see if he has any comments since he is the
maintainer of memblock and memory management initialization.

> 
> >
> > >
> > > > - Charlie
> > > >
> > > > > this patch.
> > > > >
> > > > > Excerpt from Documentation/admin-guide/kernel-parameters.txt:
> > > > >
> > > > > memmap=nn[KMG]@ss[KMG]
> > > > > [KNL] Force usage of a specific region of memory.
> > > > > Region of memory to be used is from ss to ss+nn.
> > > > >
> > > > > memmap=nn[KMG]$ss[KMG]
> > > > > Mark specific memory as reserved.
> > > > > Region of memory to be reserved is from ss to ss+nn.
> > > > > Example: Exclude memory from 0x18690000-0x1869ffff
> > > > > memmap=64K$0x18690000
> > > > > or
> > > > > memmap=0x10000$0x18690000
> > > > >
> > > > > There is no need to update this documentation file with respect to
> > > > > this patch.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  arch/riscv/mm/init.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 50 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > index e3405e4b99af..7be7ec3092ad 100644
> > > > > --- a/arch/riscv/mm/init.c
> > > > > +++ b/arch/riscv/mm/init.c
> > > > > @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
> > > > >  }
> > > > >  early_param("mem", early_mem);
> > > > >
> > > > > +static void __init parse_memmap_one(char *p)
> > > > > +{
> > > > > +     char *oldp;
> > > > > +     unsigned long start_at, mem_size;
> > > > > +
> > > > > +     if (!p)
> > > > > +             return;
> > > > > +
> > > > > +     oldp = p;
> > > > > +     mem_size = memparse(p, &p);
> > > > > +     if (p == oldp)
> > > > > +             return;
> > > > > +
> > > > > +     switch (*p) {
> > > > > +     case '@':
> > > > > +             start_at = memparse(p + 1, &p);
> > > > > +             memblock_add(start_at, mem_size);
> > > > > +             break;
> > > > > +
> > > > > +     case '$':
> > > > > +             start_at = memparse(p + 1, &p);
> > > > > +             memblock_reserve(start_at, mem_size);
> > > > > +             break;
> > > > > +
> > > > > +     case 0:
> > > > > +             memblock_reserve(mem_size, -mem_size);
> > > > > +             break;
> > > > > +
> > > > > +     default:
> > > > > +             pr_warn("Unrecognized memmap syntax: %s\n", p);
> > > > > +             break;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static int __init parse_memmap_opt(char *str)
> > > > > +{
> > > > > +     while (str) {
> > > > > +             char *k = strchr(str, ',');
> > > > > +
> > > > > +             if (k)
> > > > > +                     *k++ = 0;
> > > > > +
> > > > > +             parse_memmap_one(str);
> > > > > +             str = k;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +early_param("memmap", parse_memmap_opt);
> > > > > +
> > > > >  static void __init setup_bootmem(void)
> > > > >  {
> > > > >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > Thanks,
> > > Yunhui
> 
> Thanks,
> Yunhui

