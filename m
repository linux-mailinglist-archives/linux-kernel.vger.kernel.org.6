Return-Path: <linux-kernel+bounces-218445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87A90BFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB44B21FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E38288BD;
	Mon, 17 Jun 2024 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nnTQ7oYZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C7190662
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668626; cv=none; b=qNirihQAxuFdNTHayyWcZUjRA+9mqO/irroX3zZ9v11NwAGZjJYmApm18XlTyFMTdSuTImiOqHYOZACRD7lsD7Ob9wI0hmStarFDGtUk/zXg/7e/17pd5wXRouZIbsartPlAnVtdOH2XbegQJqRdEa8Ds1cZV/yZbUOi14Wry+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668626; c=relaxed/simple;
	bh=nzBwBVqIm92hzymlIVx5EWehH89tPmsDDm0vrypcfxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmPN8/LKvQ+AlVEYAVLLUBzOmE8bMMI4BgTYrSzF5MtzYFvA8btciIKQ59KXAaCilniKJZzFp8FmchlkaDnfTrKSYXOrGuT3IF9shlb0jF4VwgkmJ7umbYCAR3T99ECQomo1EdU9/vyPAx3vFciSOEoLdAPmj3CVFcr8S3C9zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nnTQ7oYZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701b0b0be38so4399071b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718668623; x=1719273423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pv6YgUgx26x13lU94kELKKeYzK6q+bXz++7xQqcQ+U=;
        b=nnTQ7oYZQ/U/AI0IVFxZTylcSgm7y8xmGZTC+WTpHQXXZFcNiM+VtYlMtq0pvRQWHR
         m1AoTjkHcSpDbMsXpqiBioPkEZhtCeQylafBjaQjuIacWnMv/cU39ohhfBQsFd6ZXkeh
         MoYU/ghZCuhs3oWKVvbRiqy6JEg8KDmebpd87I/RpAim8tiMSALBvV6ravGmADL0MDax
         SKEoYgtbolvYWYFn1YLika12O6cZl8dHqzDKcMqFB1/L9NZbZPq1ltelY1t2Eo6V180B
         PFYHotwRXYGvt2bAA9E3rvpo72aZ00ES9Eu08NrsmZUNUj+cMUf/J4BAykhD5V3s9OIC
         Lm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668623; x=1719273423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Pv6YgUgx26x13lU94kELKKeYzK6q+bXz++7xQqcQ+U=;
        b=PU69QBh3nNddbt+CXD+K9OoCMILmrdm8qEsPeViavN1GKIB8EeZWvT0vgm4mdpukO5
         oy1Z+km90Y3HxBjZovsYBhXbZeMJgy/LGCtkM1gw3QyNGCJUS5p8HfXgeAnZqMfbqYkR
         a/ZgAsy7IHmFeXs4+2JEPEN7wqF92trKjyZmf2E5jbrNjoxXoxDJeJbPwrvoBaLbgBB2
         tHG0J5CYJ5mUO1/Kz1JAEssGbskkIqEvow8MhQvdtCYeIDIZlat9L0dEU8GRO+t+tmZ3
         jWfvDepH8cfCwJlYoZXu0rcRZscwIWpAS5Q27Lc1oV6MBIOqETWkCqKtFc+nVzrIxZth
         Bydg==
X-Forwarded-Encrypted: i=1; AJvYcCX7nswFvpxwOlM488MMXwd2fNnhjlpbw/Rg+a5zE8ElkwcA96PvdoBuNc2iY2VWvT/E7yoJxmR9/zE0DEyv1dwzjbIyzfdarI6OPC7Q
X-Gm-Message-State: AOJu0YypETndiTDA45ayKeRr9znKpq+c2+vOB+FSTWBULis64axSdmT2
	u9spP3J5exT2WfCMEtpaUX292ooyGitE8XGXZFIQ5xGWihmnhGViWAZd4LOUpgw=
X-Google-Smtp-Source: AGHT+IEiXrAB7cuxRppsU6GQJ6vHl6ukNvL8RrXB7zAYcQWc3ujHmluc9BRM9R7AWGZu0MBlcMUoWw==
X-Received: by 2002:aa7:9f4b:0:b0:705:d805:214c with SMTP id d2e1a72fcca58-705d8052532mr11634053b3a.3.1718668623238;
        Mon, 17 Jun 2024 16:57:03 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3b3e:f51e:252a:6811])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3c9ed1fsm5985863a12.83.2024.06.17.16.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:57:02 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:56:58 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] RISC-V: Check scalar unaligned access on all CPUs
Message-ID: <ZnDNSthEVSSXpJnC@ghost>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-4-jesse@rivosinc.com>
 <20240614-padded-mammal-d956735c1293@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-padded-mammal-d956735c1293@wendy>

On Fri, Jun 14, 2024 at 09:22:47AM +0100, Conor Dooley wrote:
> On Thu, Jun 13, 2024 at 03:16:12PM -0400, Jesse Taube wrote:
> > Originally, the check_unaligned_access_emulated_all_cpus function
> > only checked the boot hart. This fixes the function to check all
> > harts.
> 
> This seems like it should be split out and get a Fixes: tag & a cc:
> stable.

These changes are great Jesse! I agree with Conor, please split these
changes into two different patches with a fixes tag for
71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe").


- Charlie

> 
> > Check for Zicclsm before checking for unaligned access. This will
> > greatly reduce the boot up time as finding the access speed is no longer
> > necessary.
> > 
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - New patch
> > ---
> >  arch/riscv/kernel/traps_misaligned.c       | 23 ++++++----------------
> >  arch/riscv/kernel/unaligned_access_speed.c | 23 +++++++++++++---------
> >  2 files changed, 20 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> > index b62d5a2f4541..8fadbe00dd62 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -526,31 +526,17 @@ int handle_misaligned_store(struct pt_regs *regs)
> >  	return 0;
> >  }
> >  
> > -static bool check_unaligned_access_emulated(int cpu)
> > +static void check_unaligned_access_emulated(struct work_struct *unused)
> >  {
> > +	int cpu = smp_processor_id();
> >  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> >  	unsigned long tmp_var, tmp_val;
> > -	bool misaligned_emu_detected;
> >  
> >  	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> >  
> >  	__asm__ __volatile__ (
> >  		"       "REG_L" %[tmp], 1(%[ptr])\n"
> >  		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
> > -
> > -	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
> > -	/*
> > -	 * If unaligned_ctl is already set, this means that we detected that all
> > -	 * CPUS uses emulated misaligned access at boot time. If that changed
> > -	 * when hotplugging the new cpu, this is something we don't handle.
> > -	 */
> > -	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> > -		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
> > -		while (true)
> > -			cpu_relax();
> > -	}
> > -
> > -	return misaligned_emu_detected;
> >  }
> >  
> >  bool check_unaligned_access_emulated_all_cpus(void)
> > @@ -562,8 +548,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
> >  	 * accesses emulated since tasks requesting such control can run on any
> >  	 * CPU.
> >  	 */
> > +	schedule_on_each_cpu(check_unaligned_access_emulated);
> > +
> >  	for_each_online_cpu(cpu)
> > -		if (!check_unaligned_access_emulated(cpu))
> > +		if (per_cpu(misaligned_access_speed, cpu)
> > +		    != RISCV_HWPROBE_MISALIGNED_EMULATED)
> >  			return false;
> >  
> >  	unaligned_ctl = true;
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> > index a9a6bcb02acf..70c1588fc353 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -259,23 +259,28 @@ static int check_unaligned_access_speed_all_cpus(void)
> >  	kfree(bufs);
> >  	return 0;
> >  }
> > +#endif /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> >  
> >  static int check_unaligned_access_all_cpus(void)
> >  {
> > -	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> > +	bool all_cpus_emulated;
> > +	int cpu;
> >  
> > +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> > +		for_each_online_cpu(cpu) {
> > +			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> > +
> > +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> 
> Can we make this an IS_ENABLED() please?
> 
> 
> Thanks,
> Conor.
> 
> >  	if (!all_cpus_emulated)
> >  		return check_unaligned_access_speed_all_cpus();
> > +#endif
> >  
> >  	return 0;
> >  }
> > -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> > -static int check_unaligned_access_all_cpus(void)
> > -{
> > -	check_unaligned_access_emulated_all_cpus();
> > -
> > -	return 0;
> > -}
> > -#endif
> >  
> >  arch_initcall(check_unaligned_access_all_cpus);
> > -- 
> > 2.43.0
> > 



