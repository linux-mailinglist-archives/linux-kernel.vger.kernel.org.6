Return-Path: <linux-kernel+bounces-206752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A025B900D52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0319B21561
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8A153517;
	Fri,  7 Jun 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z4V6BUlx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95D17BB7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794395; cv=none; b=N65VEqTAs3q8bX1OM5dK92AylDyuMBZJNGNOVeDnUJHrwBoGk5rFTlxcU1dffK1N0HGzhGr6O8D0PoZ0JOTsEwDyhfOhb61NhprQIcIgrBkFyvTGdMuaZgvUG/zPO/X2NldIwWKQoMZGVfuEonjgxQoHI2xqXadVU59aSMBg2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794395; c=relaxed/simple;
	bh=FfmOQ0SEz0oZeAIt9uGGvSZlGF4ZcjxwOrMTrfzj4No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIasiZKQK7za0oZacSfeYk1PIDgSGqjFpdCtCHWu+SKvkgYPonWkG7NIalq+pPamZ+jTxIJp4qQN71bt0iXqIIDjgClXQdBwWhVRUxpFTzwfrE21yvKh1Wf2tFzmoKIWX2t6r3GCqNqVVYjzY59d59YmgJBdMJU/b4v4QL5EcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z4V6BUlx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so20197145ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717794392; x=1718399192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkuJ5y2BXOfgiCkdfrZemwCRLjr5y6B1I0+P3q4HRKI=;
        b=z4V6BUlxWG775y0wDw+Z2ED6WesUd5DpqEefEMiL1NFPQiiyhDv6NRynvqsQxB2DoG
         sWM6ys74otCoYAePqD2o9MSRpRW+GL52yQp0xPpsYIdrUFenc7PcxAT3ZB3BPcRlup8B
         2WVmEuTjbKOkSpySFIU0+lNkR85GhqgwfsgA4pRaIpVxDFvjso0r2KFBffeguFf6xXc2
         1q0Y6qqdkK8YMZudp3Qe5OnSnOR1igE/uK/Q7NnxWwAtH7ngsAGRHJWsuJ4x4p3ZUXSg
         9MDt0cLupc7bL6G9kaIru0UYw3cEJfNWc1lf24BRq397LucJx/ISc7r64kzzz/o4F3d8
         qFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794392; x=1718399192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkuJ5y2BXOfgiCkdfrZemwCRLjr5y6B1I0+P3q4HRKI=;
        b=uU//Xi+6xO3HxUXMda07f56/bfEjB3ncYrNq2rpTiQahh/5U7SixJri6sAHPhOIIm2
         UtmI5n35bgZE2a/S/t6zp1d9peaRfjTp6zQlmS+Z64HcqDXZdYAs1lSFBgzb6UxFHPFO
         REUqitGEQmPNZZZk498P6oRrmLRsdzgf17KeSLKy5dSioZt9FS+NTPor1J9HV/DGG7JL
         i12rg7yPzysS3OhfezTStLZCECr389xTUDu9Quf0UXou6UCFzjmSLkNKinwcgBkiab1u
         RLfXKGvEZewUtA7pZ4ImVuvIlbMUY/rA3tY25zsfFmgHLDMtqRTwE/yR6yG7A+iKSbcv
         tH9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1411E3TCFInuzdiK0PGn2Nyt/FmMXlPrCvKea0MuK5naHNrvyjwhVfl3yIMic2k7OG/gN89kMrJ8BG5iVT2NgTv18zGhp17C7qzNh
X-Gm-Message-State: AOJu0YxK+KtYo6ic7934Hj5MyC2pC4n67vQ/90VGQ6rR+uqMnKIb7cQL
	vM6qh3tGA6hTnMRG++PYbXAmFZuSu9JT6qnQZ/dLt32vdgglcpyW10qp1H84llM=
X-Google-Smtp-Source: AGHT+IGgP/wh7WxoJSrZapJRuwW6Mm4LQSDuUJGNYcN7mFjL71AM1SqBDopkG4DNJIVzpkSmRQ6qQg==
X-Received: by 2002:a17:903:41ca:b0:1f0:8c5e:ffdd with SMTP id d9443c01a7336-1f6d0113847mr54662875ad.4.1717794392065;
        Fri, 07 Jun 2024 14:06:32 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd819673sm38689705ad.297.2024.06.07.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:06:31 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:06:27 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
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
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
Message-ID: <ZmN2U6BDAYRXxHEi@ghost>
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606183215.416829-2-jesse@rivosinc.com>
 <ZmIqM3Cuui0HAwN1@ghost>
 <ZmJCq7bsglq7olSB@ghost>
 <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>

On Fri, Jun 07, 2024 at 03:53:23PM -0400, Jesse Taube wrote:
> 
> 
> On 6/6/24 19:13, Charlie Jenkins wrote:
> > On Thu, Jun 06, 2024 at 02:29:23PM -0700, Charlie Jenkins wrote:
> > > On Thu, Jun 06, 2024 at 02:32:14PM -0400, Jesse Taube wrote:
> > > > Run a unaligned vector access to test if the system supports
> > > > vector unaligned access. Add the result to a new key in hwprobe.
> > > > This is useful for usermode to know if vector misaligned accesses are
> > > > supported and if they are faster or slower than equivalent byte accesses.
> > > > 
> > > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > > ---
> > > >   arch/riscv/include/asm/cpufeature.h        |  2 +
> > > >   arch/riscv/include/asm/hwprobe.h           |  2 +-
> > > >   arch/riscv/include/asm/vector.h            |  1 +
> > > >   arch/riscv/include/uapi/asm/hwprobe.h      |  6 ++
> > > >   arch/riscv/kernel/sys_hwprobe.c            | 34 +++++++++
> > > >   arch/riscv/kernel/traps_misaligned.c       | 84 ++++++++++++++++++++--
> > > >   arch/riscv/kernel/unaligned_access_speed.c |  4 ++
> > > >   arch/riscv/kernel/vector.c                 |  2 +-
> > > >   8 files changed, 129 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > > index 347805446151..a012c8490a27 100644
> > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > @@ -35,9 +35,11 @@ void riscv_user_isa_enable(void);
> > > >   #if defined(CONFIG_RISCV_MISALIGNED)
> > > >   bool check_unaligned_access_emulated_all_cpus(void);
> > > > +bool check_vector_unaligned_access_all_cpus(void);
> > > >   void unaligned_emulation_finish(void);
> > > >   bool unaligned_ctl_available(void);
> > > >   DECLARE_PER_CPU(long, misaligned_access_speed);
> > > > +DECLARE_PER_CPU(long, vector_misaligned_access);
> > > >   #else
> > > >   static inline bool unaligned_ctl_available(void)
> > > >   {
> > > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> > > > index 630507dff5ea..150a9877b0af 100644
> > > > --- a/arch/riscv/include/asm/hwprobe.h
> > > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > > @@ -8,7 +8,7 @@
> > > >   #include <uapi/asm/hwprobe.h>
> > > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > > +#define RISCV_HWPROBE_MAX_KEY 7
> > > >   static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > > >   {
> > > > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> > > > index 731dcd0ed4de..776af9b37e23 100644
> > > > --- a/arch/riscv/include/asm/vector.h
> > > > +++ b/arch/riscv/include/asm/vector.h
> > > > @@ -21,6 +21,7 @@
> > > >   extern unsigned long riscv_v_vsize;
> > > >   int riscv_v_setup_vsize(void);
> > > > +bool insn_is_vector(u32 insn_buf);
> > > >   bool riscv_v_first_use_handler(struct pt_regs *regs);
> > > >   void kernel_vector_begin(void);
> > > >   void kernel_vector_end(void);
> > > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > index 060212331a03..ebacff86f134 100644
> > > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > > @@ -68,6 +68,12 @@ struct riscv_hwprobe {
> > > >   #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
> > > >   #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
> > > >   #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> > > > +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7
> > > > +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
> > > > +#define		RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED		1
> > > > +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
> > > > +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
> > > > +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
> > > >   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > > >   /* Flags */
> > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > index b286b73e763e..ce641cc6e47a 100644
> > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > >   }
> > > >   #endif
> > > > +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> > > > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > > > +{
> > > > +	int cpu;
> > > > +	u64 perf = -1ULL;
> > > > +
> > > > +	for_each_cpu(cpu, cpus) {
> > > > +		int this_perf = per_cpu(vector_misaligned_access, cpu);
> > > > +
> > > > +		if (perf == -1ULL)
> > > > +			perf = this_perf;
> > > > +
> > > > +		if (perf != this_perf) {
> > > > +			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (perf == -1ULL)
> > > > +		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > > +
> > > > +	return perf;
> > > > +}
> > > > +#else
> > > > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > > > +{
> > 
> > I meant to mention this in my last message!
> > 
> > The scalar version has cutouts for configs here like:
> > 
> > 	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> > 		return RISCV_HWPROBE_MISALIGNED_FAST;
> > 
> 
> Will add
> 
> > Having this functionality on vector as well would be much appreciated.
> > I don't think it's valid to assume that vector and scalar have the same
> > speed, so this would require a vector version of the RISCV_MISALIGNED
> > tree in arch/riscv/Kconfig.
> > 
> > - Charlie
> > 
> > > > +	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > > +}
> > > > +#endif
> > > > +
> > > >   static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > >   			     const struct cpumask *cpus)
> > > >   {
> > > > @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > >   		pair->value = hwprobe_misaligned(cpus);
> > > >   		break;
> > > > +	case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
> > > > +		pair->value = hwprobe_vec_misaligned(cpus);
> > > > +		break;
> > > > +
> > > >   	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> > > >   		pair->value = 0;
> > > >   		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> > > > index 2adb7c3e4dd5..8f26c3d92230 100644
> > > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > > @@ -16,6 +16,7 @@
> > > >   #include <asm/entry-common.h>
> > > >   #include <asm/hwprobe.h>
> > > >   #include <asm/cpufeature.h>
> > > > +#include <asm/vector.h>
> > > >   #define INSN_MATCH_LB			0x3
> > > >   #define INSN_MASK_LB			0x707f
> > > > @@ -413,10 +414,6 @@ int handle_misaligned_load(struct pt_regs *regs)
> > > >   	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > > > -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > > > -	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> > > > -#endif
> > > > -
> > > >   	if (!unaligned_enabled)
> > > >   		return -1;
> > > > @@ -426,6 +423,17 @@ int handle_misaligned_load(struct pt_regs *regs)
> > > >   	if (get_insn(regs, epc, &insn))
> > > >   		return -1;
> > > > +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > > > +	if (insn_is_vector(insn) &&
> > > > +	    *this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED) {
> > > > +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > > > +		regs->epc = epc + INSN_LEN(insn);
> > > > +		return 0;
> 
> There is a return before scalar speed is set.

Aww I missed that.

> 
> > > > +	}
> > > > +
> > > > +	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> > > 
> > > This unconditionally sets scalar unaligned accesses even if the
> > > unaligned access is caused by vector. Scalar unaligned accesses should
> > > only be set to emulated if this function is entered from a scalar
> > > unaligned load.
> > > 
> > > The rest of this function handles how scalar unaligned accesses are
> > > emulated, and the equivalent needs to happen for vector. You need to add
> > > routines that manually load the data from the memory address into the
> > > vector register. When Clément did this for scalar, he provided a test
> > > case to help reviewers [1]. Please add onto these test cases or make
> > > your own for vector.
> 
> I wansnt planing on adding emulation in this patch. I can if needed.

Emulation is required. Right now vector unaligned accesses trap into
this function and just return without setting the value in the vector
register so the value in the vector register is incorrect but the
program doesn't know because the trap is swallowed by this function.

> 
> > > 
> > > Link: https://github.com/clementleger/unaligned_test [1]
> > > 
> > > > +#endif
> > > > +
> > > >   	regs->epc = 0;
> > > >   	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
> > > > @@ -625,6 +633,74 @@ static bool check_unaligned_access_emulated(int cpu)
> > > >   	return misaligned_emu_detected;
> > > >   }
> > > > +#ifdef CONFIG_RISCV_ISA_V
> > > > +static void check_vector_unaligned_access(struct work_struct *unused)
> > > 
> > > Can you standardize this name with the scalar version by writing
> > > emulated in it?
> 
> We dont emulate it so that wouldn't make sence.
> 
> > > 
> > > "check_vector_unaligned_access_emulated_all_cpus"
> > > 
> > > > +{
> > > > +	int cpu = smp_processor_id();
> > > > +	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
> > > > +	unsigned long tmp_var;
> > > > +
> > > > +	if (!riscv_isa_extension_available(hart_isa[cpu].isa, v))
> > > > +		return;
> > > > +
> > > > +	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
> > > > +
> > > > +	local_irq_enable();
> > > > +	kernel_vector_begin();
> > > > +	__asm__ __volatile__ (
> > > > +		".balign 4\n\t"
> > > > +		".option push\n\t"
> > > > +		".option arch, +v\n\t"
> > > > +		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
> > > > +		"	vle16.v v0, (%[ptr])\n\t"		// Load bytes
> > > > +		".option pop\n\t"
> > > > +		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0", "memory");
> > > 
> > > memory is being read from, but not written to, so there is no need to
> > > have a memory clobber.
> 
> fixed.
> 
> > > 
> > > > +	kernel_vector_end();
> > > > +
> > > > +	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
> > > > +		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
> > > > +}
> > > > +
> > > > +bool check_vector_unaligned_access_all_cpus(void)
> > > > +{
> > > > +	int cpu;
> > > > +	bool ret = true;
> > > > +
> > > > +	for_each_online_cpu(cpu)
> > > > +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
> > > 
> > > zicclsm is not specific to vector so it can be extracted out of this
> > > vector specific function. Assuming that hardware properly reports the
> > > extension, if zicclsm is present then it is known that both vector and
> > > scalar unaligned accesses are supported.
> 
> Added so we don't need to waste cycles testing support.
> 

Yes exactly, that is why it should be added to the scalar version as
well :)

> > > > +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
> > > 
> > > Please use the exising UNKNOWN terminology instead of renaming to
> > > SUPPORTED. Any option that is not UNSUPPORTED implies that unaligned
> > > accesses are supported.
> 
> Conor didnt like using UNKNOWN a proxy for "SUPPORTED"
> Having SUPPORTED is better then assuing the speed to be slow.

The HWPROBE key is about misaligned access performance. UNKNOWN means
that the performance is unknown. The scalar and vector names need to
match up. UNKNOWN was already merged and is supported by linux so if you
want to use SUPPORTED here then you need to add a scalar SUPPORTED key
that is an alias of the UNKNOWN key. I would rather keep UNKNOWN as it
is, but that's up to you.

> 
> > > 
> > > > +		else
> > > > +			ret = false;
> > > > +
> > > > +
> > > > +	if (ret)
> > > > +		return true;
> > > > +	ret = true;
> > > > +
> > > > +	schedule_on_each_cpu(check_vector_unaligned_access);
> > > > +
> > > > +	for_each_online_cpu(cpu)
> > > > +		if (per_cpu(vector_misaligned_access, cpu)
> > > > +		    != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
> > > > +			return false;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +#else
> > > 
> > > If CONFIG_RISCV_ISA_V is not set, there is no value in checking if
> > > vector unaligned accesses are supported because userspace will not be
> > > allowed to use vector instructions anyway.
> 
> Oh I'm silly meant to be seting to all UNSUPPORTED.
> 
> 
> Thanks,
> Jesse Taube
> 
> > > 
> > > - Charlie
> > > 
> > > > +bool check_vector_unaligned_access_all_cpus(void)
> > > > +{
> > > > +	int cpu;
> > > > +
> > > > +	for_each_online_cpu(cpu)
> > > > +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
> > > > +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
> > > > +		else
> > > > +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >   bool check_unaligned_access_emulated_all_cpus(void)
> > > >   {
> > > >   	int cpu;
> > > > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> > > > index a9a6bcb02acf..92a84239beaa 100644
> > > > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > > > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > > > @@ -20,6 +20,7 @@
> > > >   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > > >   DEFINE_PER_CPU(long, misaligned_access_speed);
> > > > +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > > >   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > > >   static cpumask_t fast_misaligned_access;
> > > > @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
> > > >   {
> > > >   	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> > > > +	check_vector_unaligned_access_all_cpus();
> > > > +
> > > >   	if (!all_cpus_emulated)
> > > >   		return check_unaligned_access_speed_all_cpus();
> > > > @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
> > > >   static int check_unaligned_access_all_cpus(void)
> > > >   {
> > > >   	check_unaligned_access_emulated_all_cpus();
> > > > +	check_vector_unaligned_access_all_cpus();
> > > >   	return 0;
> > > >   }
> > > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > > > index 6727d1d3b8f2..2cceab739b2c 100644
> > > > --- a/arch/riscv/kernel/vector.c
> > > > +++ b/arch/riscv/kernel/vector.c
> > > > @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
> > > >   #endif
> > > >   }
> > > > -static bool insn_is_vector(u32 insn_buf)
> > > > +bool insn_is_vector(u32 insn_buf)
> > > >   {
> > > >   	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
> > > >   	u32 width, csr;
> > > > -- 
> > > > 2.43.0
> > > > 

