Return-Path: <linux-kernel+bounces-249954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B192F21F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E23DB20E46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA301A01DF;
	Thu, 11 Jul 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H1NG4aKj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F319F497
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737527; cv=none; b=U3mgdCmylzjkK0Q2IkzgPj8BeNzPNWrEHjoNZlkFKmL9JoGhMi7s2BAIgDTkykqgCJSin5pis4fn2dw6zj1CkgxhoAw5FnURFx0c9aHj0Zp3AZzxfVLuF3K7OT7aUIrYyxJEwrfdVtNll4wGsTor3oy6evXE+LD3hMzJMMaJYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737527; c=relaxed/simple;
	bh=xrDCFC6/AGsAPx7fMgyIJyU4N8WTEyE5/DUMMxmCOI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH+d5atnat9GuRluOHtOj3wek3xxqimxKjIyKLn34rHG64XCxUOwQwsZ7MZnpQhYHhmjJ4+SznGbed+xe6iUL2SlYpjvi7owxSeZDV+BDw6vFuwIs55wdqD+nGp+OMRp1y3Q7KEVNUJbkriTTcjIBKFwa9CTLYNTuqoMO9iu7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H1NG4aKj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70aec66c936so1229056b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737524; x=1721342324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbNZF2S4J9drmyHueEsFFLhlbRMEBvhBMv4NoxbSMK8=;
        b=H1NG4aKjYll0gU8HnijOEFBq743zLm9VJoA7UL/EKT3SZhLugdCJiUkMyD+79SywWq
         GC6yn2nmiL4n5LmoRY7MzeFkCPgXRewdvplP3OGUuAUC9PBKlNIiTdkx73O+tVPF4Dq3
         pXBOPMqD82iDeiGy/7mrPU7S2GGQUsyqU7aohq7tGlFliooyMCAJA8AOMcAwqJiFhXXy
         voJbUI2yOAFBi4gHEpTQx/8AesdpEUItoYMmgyF3b+8fOv+UpfaNYOIGG/je5nc1R9pG
         t+0EXVcpUdKcO/iJxdQKM0zbAXbEKDJfXiLTRhVSGEZ6mAFjEaLpiSaxAc9sI7wHMBp7
         rYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720737524; x=1721342324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbNZF2S4J9drmyHueEsFFLhlbRMEBvhBMv4NoxbSMK8=;
        b=YQNuT/yqJoeQO7Ckue6Zv9hJljMbsdKsWeybBOSf6ClCgJOrXlGxw/4rp3anriAxbt
         aYHaxcnKAAS9+APOYeyzCiYmd+uPStbeFw2iveTOojHMsJTg+Y9PLCE3ks7qTNPrdbTE
         +Rb/T5wKQsuRe8Z4j36yEWQkrMPkr1G4c3o27cbTnVIFWcSjEK+l8/Y/FV8PVHNvszi4
         iDgQdllY9xF1v4yMOaSYDkfgQRfKVN+J0LUj7coRnwEdhyHxySZn6H7OOYwU6k6EeAln
         lHnye35PNAuRvIp+SRRN6UXZynv3ALm6HnhjOY1qOZdV+v0RKMZ9veja2mU3BAXbMPdJ
         MZBw==
X-Forwarded-Encrypted: i=1; AJvYcCVK4Z7j/nuo1D47TNyYo8BW5TCSOHLDXKiH2xAtmkrd4SnWYlmNrImJG8jdyTmbcBbQvfGkWoeojVGZt5d7Bt7BGmiEsQ/wbhQZ9kXa
X-Gm-Message-State: AOJu0Yz8dSgn7qC83iGM7rxEPAhltYx821E7LHAwjciUCCeJi3Im9JY+
	oH6fivDusmGODKiz1Gz/JM064uGGKfsJJTa9R2QQcZI+dZ+tzNovede4we5j+eu6yENNk5Bpxq5
	1
X-Google-Smtp-Source: AGHT+IHnc8Zv8sfbsAY4oLFXAWbmahrHaGEf23uvgOftBM0iIylqo5S8ACJ9AZUHYcZTecSZvb2vOA==
X-Received: by 2002:a05:6a00:3d08:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-70b43576a80mr9974899b3a.14.1720737523703;
        Thu, 11 Jul 2024 15:38:43 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b8594sm6197736b3a.192.2024.07.11.15.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:38:43 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:38:40 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/7] RISC-V: Check scalar unaligned access on all CPUs
Message-ID: <ZpBe8ECHxJ9QXVB2@ghost>
References: <20240711215846.834365-1-jesse@rivosinc.com>
 <20240711215846.834365-4-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711215846.834365-4-jesse@rivosinc.com>

On Thu, Jul 11, 2024 at 05:58:42PM -0400, Jesse Taube wrote:
> Originally, the check_unaligned_access_emulated_all_cpus function
> only checked the boot hart. This fixes the function to check all
> harts.
> 
> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Cc: stable@vger.kernel.org
> ---
> V1 -> V2:
>  - New patch
> V2 -> V3:
>  - Split patch
> V3 -> V4:
>  - Re-add check for a system where a heterogeneous
>     CPU is hotplugged into a previously homogenous
>     system.
> ---
>  arch/riscv/kernel/traps_misaligned.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index b62d5a2f4541..1a1bb41472ea 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -526,11 +526,11 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -static bool check_unaligned_access_emulated(int cpu)
> +static void check_unaligned_access_emulated(struct work_struct *unused)

Small change, can you give this a different name like "work" and instead
give it the attribute "__always_unused" like:

struct work_struct *work __always_unused

Otherwise,

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

>  {
> +	int cpu = smp_processor_id();
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
>  	unsigned long tmp_var, tmp_val;
> -	bool misaligned_emu_detected;
>  
>  	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>  
> @@ -538,19 +538,16 @@ static bool check_unaligned_access_emulated(int cpu)
>  		"       "REG_L" %[tmp], 1(%[ptr])\n"
>  		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
>  
> -	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
>  	/*
>  	 * If unaligned_ctl is already set, this means that we detected that all
>  	 * CPUS uses emulated misaligned access at boot time. If that changed
>  	 * when hotplugging the new cpu, this is something we don't handle.
>  	 */
> -	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> +	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_EMULATED))) {
>  		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
>  		while (true)
>  			cpu_relax();
>  	}
> -
> -	return misaligned_emu_detected;
>  }
>  
>  bool check_unaligned_access_emulated_all_cpus(void)
> @@ -562,8 +559,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> +	schedule_on_each_cpu(check_unaligned_access_emulated);
> +
>  	for_each_online_cpu(cpu)
> -		if (!check_unaligned_access_emulated(cpu))
> +		if (per_cpu(misaligned_access_speed, cpu)
> +		    != RISCV_HWPROBE_MISALIGNED_EMULATED)
>  			return false;
>  
>  	unaligned_ctl = true;
> -- 
> 2.45.2
> 

