Return-Path: <linux-kernel+bounces-263493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC893D6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0689CB23740
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DF17C7B9;
	Fri, 26 Jul 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nUs+t3rV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+4yH+js"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B617B42F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011166; cv=none; b=oiG2jPMaD6Rbwg3dtZYG5eEY2KwWe6rTHXu7qiaCp/zXob4sJKCgMjV9j40mSEGvf0k14cg3WBHCtaJdTaUyw8h9KT+6U0oMAYpUPOI9hTeuo0/lmkb85ELglX17TvJ5L1XckXgqmukaQX07kNHdqgOPKqPnom/QfeEpxxHbHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011166; c=relaxed/simple;
	bh=VS/Wdm7JJfmKhtGCX3NWy4+tlvuj14byjVjq/5nLy+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VTa5DGeSRWPkykiu/Bc2OFdIpilYtcDTm1aVtWvhMMqwR0FEgipp9fFEUWoR9c23iX85BXVGpDS4dGrZPUXIifUESG7xG7Vz5P1jGvw/VvPs3qe7xg7JhS1+xLweeHuBXE1zgADlLQz8ItZToFzuUcv5VCwQZRIscS79Mo9ZzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nUs+t3rV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+4yH+js; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722011162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoTw2oBJco+k8odnRLjjddu12/BJ3g3lZ54Pqub+t04=;
	b=nUs+t3rVdBR90l6Gck0IAwyaEV6q9OrMfuVVQJZjQTl0Vi4oqutSpJefgd/sOBJwQn4yr7
	bsd3ZQRGebL8U4voYRXdmrkowdKJPbPvDxjQCVQjx/UsWliB+C35HcbmkjRs2BDw2tsnOz
	Bg8YFQNQ7pnzrCdbYzYLBc+cPawO4ebrohDveyCet2BlVvk0qtN+6z+XfbmuuZUyADX6wi
	BH5g6VO8ZxraUjNOX54yvgkk+c8SD/Bn3WtzC0nv/uDli/jN7QKTMgQnhc4at7f2DtHLXs
	hdil2nJNCUehgLTZNaK2ga/+pFg6yiYnrUh+hHF2ZweCrgxVMbCEAMrldGR10Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722011162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoTw2oBJco+k8odnRLjjddu12/BJ3g3lZ54Pqub+t04=;
	b=t+4yH+jsgWgYPjhZHZsa+Ykrvkg/MecpL5Lv7QvawtHfdhq2TMYp9ZjYjYvTKED/boExoy
	j43wqfr6EmKeZsBQ==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, linuxarm@huawei.com
Cc: rafael.j.wysocki@intel.com, guohanjun@huawei.com, gshan@redhat.com,
 miguel.luis@oracle.com, catalin.marinas@arm.com, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Bowman, Terry" <Terry.bowman@amd.com>
Subject: Re: 6.11/regression/bisected - The commit c1385c1f0ba3 caused a new
 possible recursive locking detected warning at computer boot.
In-Reply-To: <20240725181354.000040bf@huawei.com>
References: <CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com>
 <20240723112456.000053b3@Huawei.com> <20240723181728.000026b3@huawei.com>
 <20240725181354.000040bf@huawei.com>
Date: Fri, 26 Jul 2024 18:26:01 +0200
Message-ID: <87le1ounl2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 25 2024 at 18:13, Jonathan Cameron wrote:
> On Tue, 23 Jul 2024 18:20:06 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> > This is an interesting corner and perhaps reflects a flawed
>> > assumption we were making that for this path anything that can happen for an
>> > initially present CPU can also happen for a hotplugged one. On the hotplugged
>> > path the lock was always held and hence the static_key_enable() would
>> > have failed.

No. The original code invoked this without cpus read locked via:

acpi_processor_driver.probe()
   __acpi_processor_start()
       ....

and the cpu hotplug callback finds it already set up, so it won't reach
the static_key_enable() anymore.

> One bit I need to check out tomorrow is to make sure this doesn't race with the
> workfn that is used to tear down the same static key on error.

There is a simpler solution for that. See the uncompiled below.

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index b3fa61d45352..0b69bfbf345d 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -306,7 +306,7 @@ static void freq_invariance_enable(void)
 		WARN_ON_ONCE(1);
 		return;
 	}
-	static_branch_enable(&arch_scale_freq_key);
+	static_branch_enable_cpuslocked(&arch_scale_freq_key);
 	register_freq_invariance_syscore_ops();
 	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 }
@@ -323,8 +323,10 @@ static void __init bp_init_freq_invariance(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (intel_set_max_freq_ratio())
+	if (intel_set_max_freq_ratio()) {
+		guard(cpus_read_lock)();
 		freq_invariance_enable();
+	}
 }
 
 static void disable_freq_invariance_workfn(struct work_struct *work)



