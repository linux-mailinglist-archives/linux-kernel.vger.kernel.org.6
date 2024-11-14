Return-Path: <linux-kernel+bounces-408584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693A9C80C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E1281A75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB61F4FC4;
	Thu, 14 Nov 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="21nS5M3y"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BF1F26FF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551091; cv=none; b=VYPS/HSgiaDz+/UGeHSjpMHPhfRHDhZ92qZxgVV+kP0AxSthEVpJbgiNe6FguvUycwT3ZI/dkQ/6vWJQsvzDTdUvPfoqhKYQpuPb2KuaBFCj89p7c+cS3ghJ+Rq/+S/Jx1x6LsqDDLszJaxc6USyUWR1qLNBptdhzJdo2sj89GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551091; c=relaxed/simple;
	bh=04s8nDoCSLpivX7fgLAtuIRzvTm1jQi5mR5RZ+R6pjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4a6mqgT1tqb4u8GVEe9GKrRPYiGse6hOB3I0UsUat9OtVV7rseaFpHImU8ITHgwy/mjin0+JVQieOFbpvb7Hc60CAJ/11dYxHYTw412IJFkhHAn3oAq4sHIfT2VH1ijydDaOpbpXLZ2qW+qqwDQ9b1Xbo8LbypglCzEPJPbByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=21nS5M3y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so734455ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731551089; x=1732155889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bOcIjTHmkKYE/MldB59+Mp7THVJA1dMXMhLp3+u7Zpk=;
        b=21nS5M3yK54DmA6u12c/sYhRVsS3FkR5a8Z4vLDh4l8dUJekGhoLQnnwzu7jo59W5k
         EvH2nCnZFEHImJHRh6rtVhXHAYEW889rgpkqGpz2feN5brv9hbWxbMohk25IjerzyBpx
         q3jWzut7bOvJR7YHyLdtICzvbB3I/oQDIIZ1GRmNYk9XR9aTGfEHFBlKkkHfLZ1a29Ps
         sl7Yd+bGquFs5lGpYGLLvhuR9F3rOmNX9gV8EYe1tjEJjUvlyA1C1txcW+RHim9tm3ID
         t/y+vvl17Xn7aF5ssGFW5YkfM4lZXJ2YFKSwVuPGN8fRQQus5aqIv5YBl2mWikuSlvSZ
         RXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731551089; x=1732155889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOcIjTHmkKYE/MldB59+Mp7THVJA1dMXMhLp3+u7Zpk=;
        b=jcE4K+5NcpqtZ9YcIL7v4lg+VK5lKnWb5s+A5iQteTKn1V5j4bkjCF0ZJoS36LOiar
         ixU2JDPTTCyeLzITgA8+LBGQ/ixdYW5c97hvMOJdF1J4OAeUA64GcZlzJm8qoW8rMeho
         pBtveQrG//WidzjYam0IGbh75b+kwklFXvIoAYX4hkfqr2ucQABOQejSKesetSjrrxqF
         kZzmVnXVVRlpIMt7/FRiAb8Y0Sq7tekYDK14RJMat0KNktytcL72wOjjXmkR2huX6qLA
         X1AyNoy7S3FR0OAYCSGCYT3IfsItFOZFggcdLkyJ7NhxBdLiixeqNR2Lvjn3n6GgTOtZ
         g56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG32Jqnpb8aIXlvgraDBipeXiGZZXdy72jvwKKi4S8DG/QQzI4oNdWqkzjFG7CTBWQ7QpM/giBuXVrQpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Oda7JP6EUpP0xtcnyebY191fgNcwVJwv8OvIz8jN0oyqNFQn
	lRXybSO93tVnQ6R8yaY72lI9NfN/PEICMSCwQV0t97poZdtZU/KvEAuI3ph7O/A=
X-Google-Smtp-Source: AGHT+IFIy/N8ljrKihYLsmstk+E2hofbr+iVsyyNJcXN7lh1fccE1mzDgwapJOQoIdXEKN3f21A9eg==
X-Received: by 2002:a17:903:2a8e:b0:20b:6d71:4140 with SMTP id d9443c01a7336-211b5d2a3b4mr74048485ad.44.1731551089470;
        Wed, 13 Nov 2024 18:24:49 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c2d520sm439875ad.29.2024.11.13.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:24:48 -0800 (PST)
Date: Wed, 13 Nov 2024 18:24:45 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v10 05/14] riscv: vector: Use vlenb from DT for thead
Message-ID: <ZzVfbS8-NizjKkst@ghost>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
 <tencent_2EF88DF37C4B82B2DA0B8E49B85C312E2108@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2EF88DF37C4B82B2DA0B8E49B85C312E2108@qq.com>

On Sun, Nov 10, 2024 at 03:34:54AM +0800, Yangyu Chen wrote:
> Hi Charlie,
> 
> I have tested this patchset with ghostwrite rebased to linux commit da4373fbcf ("Merge tag 'thermal-6.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") [1] on my D1 Nezha board, with defconfig + CONFIG_ERRATA_THEAD_GHOSTWRITE=n, I got this message during boot:
> 
> [    0.027584] Kernel panic - not syncing: __kmem_cache_create_args: Failed to create slab 'riscv_vector_ctx'. Error -22
> [    0.038057] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00310-gb276cf69df24-dirty #11
> [    0.047240] Hardware name: Allwinner D1 Nezha (DT)
> [    0.052007] Call Trace:
> [    0.054434] [<ffffffff80007172>] dump_backtrace+0x1c/0x24
> [    0.059806] [<ffffffff809f6834>] show_stack+0x2c/0x38
> [    0.064833] [<ffffffff80a040f0>] dump_stack_lvl+0x52/0x74
> [    0.070206] [<ffffffff80a04126>] dump_stack+0x14/0x1c
> [    0.075233] [<ffffffff809f6db6>] panic+0x10c/0x300
> [    0.080000] [<ffffffff8017b5a0>] __kmem_cache_create_args+0x24a/0x2b6
> [    0.086413] [<ffffffff80c04c68>] riscv_v_setup_ctx_cache+0x56/0x84
> [    0.092566] [<ffffffff80c04288>] arch_task_cache_init+0x10/0x1c
> [    0.098460] [<ffffffff80c07d02>] fork_init+0x68/0x1a8
> [    0.103486] [<ffffffff80c00ed2>] start_kernel+0x77e/0x822
> [    0.108870] ---[ end Kernel panic - not syncing: __kmem_cache_create_args: Failed to create slab 'riscv_vector_ctx'. Error -22 ]---
> 
> [1] https://github.com/cyyself/linux/tree/xtheadvector_20241110
> 
> On 9/12/24 13:55, Charlie Jenkins wrote:
> >  diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 682b3feee451..9775d6a9c8ee 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
> >  {
> >  	unsigned long this_vsize;
> >  -	/* There are 32 vector registers with vlenb length. */
> > +	/*
> > +	 * There are 32 vector registers with vlenb length.
> > +	 *
> > +	 * If the thead,vlenb property was provided by the firmware, use that
> > +	 * instead of probing the CSRs.
> > +	 */
> > +	if (thead_vlenb_of) {
> > +		this_vsize = thead_vlenb_of * 32;
> 
> Then, I patched here which replaces "this_vsize" with "riscv_v_vsize". The kernel boots normally and I can see “xtheadvector" in /proc/cpuinfo.
> 
> However, when I try to run the "v_exec_initval_nolibc" test, the kernel panics with these outputs:
> 
> [  978.788878] Oops - illegal instruction [#1]
> [  978.788897] Modules linked in:
> [  978.788908] CPU: 0 UID: 1000 PID: 461 Comm: v_exec_initval_ Not tainted 6.12.0-rc6-00310-gb276cf69df24-dirty #12
> [  978.788924] Hardware name: Allwinner D1 Nezha (DT)
> [  978.788929] epc : do_trap_ecall_u+0x56/0x20a
> [  978.788956]  ra : _new_vmalloc_restore_context_a0+0xc2/0xce
> [  978.788974] epc : ffffffff80a04afe ra : ffffffff80a0e742 sp : ffffffc6003fbeb0
> [  978.788983]  gp : ffffffff81717080 tp : ffffffd60723b300 t0 : ffffffff81001268
> [  978.788991]  t1 : ffffffff80a04aa8 t2 : ffffffff810012a8 s0 : ffffffc6003fbee0
> [  978.789000]  s1 : ffffffc6003fbee0 a0 : ffffffc6003fbee0 a1 : 000000000000005d
> [  978.789007]  a2 : 0000000000000000 a3 : ffffffffffffffda a4 : 0000000000000003
> [  978.789015]  a5 : 0000000000000000 a6 : 0000000002adb5fe a7 : 000000000000005d
> [  978.789022]  s2 : 00000000000108a8 s3 : 0000000000000000 s4 : 0000000000000008
> [  978.789030]  s5 : 0000003fb42ab780 s6 : 0000002adb5fe420 s7 : 0000002adb5fb9e0
> [  978.789038]  s8 : 0000002adb5fe440 s9 : 0000002adb5fe420 s10: 0000002adb572ad4
> [  978.789046]  s11: 0000002adb572ad0 t3 : 0000003fb43c5e3c t4 : 622f7273752f3d5f
> [  978.789053]  t5 : 0000002adb5fd5a1 t6 : 0000000002adb5ff
> [  978.789060] status: 8000000201800100 badaddr: 000000005e0fb057 cause: 0000000000000002
> [  978.789069] [<ffffffff80a04afe>] do_trap_ecall_u+0x56/0x20a
> [  978.789086] [<ffffffff80a0e742>] _new_vmalloc_restore_context_a0+0xc2/0xce
> [  978.789113] Code: a073 1007 006f 1a60 7057 0c30 57fd 17fe 77d7 0c30 (b057) 5e0f
> [  978.789123] ---[ end trace 0000000000000000 ]---
> [  978.789131] Kernel panic - not syncing: Fatal exception in interrupt
> [  978.937158] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> Is something wrong with my setup?

Thanks for reporting this! I just sent out a new version with the fix.
Something went wrong with the __riscv_v_vstate_discard() and was
triggering this failure. I have tested that this new version is able to
pass the testcase.

https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com/T/#t

- Charlie

> 
> Thanks,
> Yangyu Chen
> 
> > +		return 0;
> > +	}
> > +
> >  	riscv_v_enable();
> >  	this_vsize = csr_read(CSR_VLENB) * 32;
> >  	riscv_v_disable();
> > diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
> > index 0f27baf8d245..519dbf70710a 100644
> > --- a/arch/riscv/kernel/vendor_extensions/thead.c
> > +++ b/arch/riscv/kernel/vendor_extensions/thead.c
> > @@ -5,6 +5,7 @@
> >  #include <asm/vendor_extensions/thead.h>
> >    #include <linux/array_size.h>
> > +#include <linux/cpumask.h>
> >  #include <linux/types.h>
> >    /* All T-Head vendor extensions supported in Linux */
> > @@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
> >  	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
> >  	.ext_data = riscv_isa_vendor_ext_thead,
> >  };
> > +
> > +void disable_xtheadvector(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
> > +
> > +	clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap.isa);
> > +}
> 

