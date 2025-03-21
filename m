Return-Path: <linux-kernel+bounces-571284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D5A6BB58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AEC7A7E87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79238F80;
	Fri, 21 Mar 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxXfuQD6"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20371E87B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562118; cv=none; b=QrVVXHvtrgrzAnJKqw0cMhDdOuB220Cd6RA/YoF2BYOzYIcSNwnk3r/pKFXSaphGWZjxJgdj633EtFte54YErVsYZHiFmX90fPnTr6nEUpZ5UC1La7+JZ2GiI8PWybGGK5cWEqrFOGFMN9thy9MQ+spOTq/E7Vb02N+lNs8WWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562118; c=relaxed/simple;
	bh=z2u8qvqYz6lJqaLdrjTi7qjLknt9brw8deTZT/n1p3o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=IPALvVTuYbgFsD46MIvbDMee9cnku+6EziEMMSMG9gJiAAIr0BEEdRgPXlpdhtuuNE+VAUJF6WWK0qLMaIKyOuNBMiOaZ99LBzxIgrsz/ZkgpMrBg7JN8MihzdVF58nTTzLBqwq5/z8zZeFiwzWyqVAiPufUHOwu9osrbsAB2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxXfuQD6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72bbc03d436so1201384a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742562115; x=1743166915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2u8qvqYz6lJqaLdrjTi7qjLknt9brw8deTZT/n1p3o=;
        b=lxXfuQD6SQ/9xqlDONRvIVIpggxLn97v5ScdZ5IkMA1+Xv0b9g6IFGxx+MyGKnm4Nr
         W7X+8P8capwB4Mfb2lOAER4gZ3HJIEELLTqWVIRb/rcCJ+KKXGbiFWNnIbQRWSHmGmfk
         Egn/pDyWkhQnnH+UoYhP77Og2XOgbUZFkRtZje+K+m4hLcoNLCBjJIhtTCpvE2DCkbd9
         vlONpB8XqEa5MyIbCa6aiHgMjgF5LW6Tbm0H3xR3PDc89L9QiBkQ2hoqS+vuWGDwt9JJ
         70G7rVswg2gVdRuhCYZTSRZmcRusU1Oq4twkgWrdSTdTwoDUn2g/OsY0M8hFoqm7PVso
         PUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562115; x=1743166915;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2u8qvqYz6lJqaLdrjTi7qjLknt9brw8deTZT/n1p3o=;
        b=hqA3XjPNKbXfSib8xtgfN0JwLGPrmxm45ZMUoB/3eKYIrBjXS5K24eIbUfO3MciG0z
         OKV/qADlc/m0KbNKWJMxuPjqN4eJPxz9HLCDQW/BUQxetqjGnbIXbwEWtf1USi18XC5z
         KRVZ05VryCZPl27dIXsmhZIG16nCws5zNAX4WawvK/zSGqnW4j+YYH3v7iOiIRS31gJ6
         I+msJP6u59mLhPJWTVlA82ukMl5M3yHRXmHg65AtnIAs81vGsAe7rF3f+mbNyQL2UETE
         82e6TL+TUwmmg1tLD59pUIJtbVPfhTdqqssDWr6x4N4g75UIC3CZ1fHqiUllfk4s6Fv6
         ogIw==
X-Forwarded-Encrypted: i=1; AJvYcCUYPGwYXuL+1JG4C2kdI/PcKLH/il3nN8QKE6D8eyPA3XbH3trdllblNfi3EyolFtVg5YnHr735gO3Y0u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw4ctYLGg4/0EDG1Z2sPu0HAnb1D8+1kwkbV6Pbf8iJvQ0Tmk
	VhV1v8EaqaiEzl7xpt3zIIJ5HO53ro5zNmfzSDrQkATeiFitcWyN
X-Gm-Gg: ASbGnctu3tLUWhMahd6qcWeOVu7cQAa9DeYMLZYY7FJumT4NUqB1XRQITnVLaEUUUqk
	CRHgnm/+udaOeW3oUGIo+tCM70ZNqMeHAoWmOJyqdNBKmMrabRQL2/lD3n9UMZx9l8U/PD+l0fW
	gKyj7HcnlwPNFAPn9W+8aDP0OEE0e89FmdkRlb5tYgUJzOUSC54Q92OvJQetKjeg4O3lWXMLYdv
	WWMjZF4vOzZjCPSkhokf+XgLj1WlHG2euPZiRxmJqamLFfy2FzQYmoHBvMz8iZX7pXwrOpghIyY
	N9IHh8V5mnmApFFm/ivUpoTccnsA+eQHguguqDSTw8r7HkEmAjROeq9knA7KXO6lj9S1CVVdctq
	tc9JPuYHdv7tepFloyS3gMdbZVOigDL+A
X-Google-Smtp-Source: AGHT+IHsu1GyQ07inUssgB3XeNarkpCkGjPnlsxGq9UPMk+ecJRQXcIuvZ6NgBcp8NN0kEYe6a7NIA==
X-Received: by 2002:a05:6830:d0b:b0:727:24ab:3e4 with SMTP id 46e09a7af769-72c0ae529d0mr2427461a34.9.1742562114417;
        Fri, 21 Mar 2025 06:01:54 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abac228sm372760a34.14.2025.03.21.06.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 06:01:53 -0700 (PDT)
Message-ID: <7b3a0288-20f9-42cf-af81-e10ad2d04b27@gmail.com>
Date: Fri, 21 Mar 2025 08:01:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC] panic: reduce CPU consumption when finished handling panic
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: pmladek@suse.com, Andrew Morton <akpm@linux-foundation.org>,
 jani.nikula@intel.com, open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, takakura@valinux.co.jp,
 john.ogness@linutronix.de
References: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Content-Language: en-US
Cc: jglauber@digitalocean.com
In-Reply-To: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again,


I thought it would be helpful to share some numbers to support my claim
and a couple ideas to improve the patch. Below are the perf stats from
the hypervisor after triggering a panic on a guest running kernel v5.15
(I'll provide the details of the experiment afterward.)


Samples: 55K of event 'cycles:P', Event count (approx.): 36090772574
Overhead  Command          Shared Object            Symbol
  42.20%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vmexit
  19.07%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_spec_ctrl_restore_host
   9.73%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vcpu_enter_exit
   3.60%  CPU 5/KVM        [kernel.kallsyms]        [k] __flush_smp_call_function_queue
   2.91%  CPU 5/KVM        [kernel.kallsyms]        [k] vmx_vcpu_run
   2.85%  CPU 5/KVM        [kernel.kallsyms]        [k] native_irq_return_iret
   2.67%  CPU 5/KVM        [kernel.kallsyms]        [k] native_flush_tlb_one_user
   2.16%  CPU 5/KVM        [kernel.kallsyms]        [k] llist_reverse_order
   2.10%  CPU 5/KVM        [kernel.kallsyms]        [k] __srcu_read_lock
   2.08%  CPU 5/KVM        [kernel.kallsyms]        [k] flush_tlb_func
   1.52%  CPU 5/KVM        [kernel.kallsyms]        [k] vcpu_enter_guest.constprop.0
   1.50%  CPU 5/KVM        [kernel.kallsyms]        [k] native_apic_msr_eoi
   1.01%  CPU 5/KVM        [kernel.kallsyms]        [k] clear_bhb_loop
   0.66%  CPU 5/KVM        [kernel.kallsyms]        [k] sysvec_call_function_single


And here are the results from the guest VM after applying my patch:


Samples: 28  of event 'cycles:P', Event count (approx.): 28961952
Overhead  Command          Shared Object            Symbol
  11.03%  qemu-system-x86  [kernel.kallsyms]        [k] task_mm_cid_work
  11.03%  qemu-system-x86  qemu-system-x86_64       [.] 0x0000000000579944
   9.80%  qemu-system-x86  qemu-system-x86_64       [.] 0x000000000056512b
   8.45%  IO mon_iothread  libc.so.6                [.] 0x00000000000a3f12
   8.45%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_mutex_lock
   7.51%  IO mon_iothread  [kernel.kallsyms]        [k] avg_vruntime
   6.65%  IO mon_iothread  libc.so.6                [.] write
   5.93%  IO mon_iothread  [kernel.kallsyms]        [k] security_file_permission
   4.97%  qemu-system-x86  libglib-2.0.so.0.7200.4  [.] g_thread_self
   4.64%  IO mon_iothread  [kernel.kallsyms]        [k] aa_label_sk_perm.part.0
   4.13%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_main_context_release
   3.79%  IO mon_iothread  [kernel.kallsyms]        [k] seccomp_run_filters
   3.42%  IO mon_iothread  libglib-2.0.so.0.7200.4  [.] g_main_context_dispatch
   3.42%  IO mon_iothread  qemu-system-x86_64       [.] 0x00000000004edbab
   3.28%  IO mon_iothread  qemu-system-x86_64       [.] 0x00000000005999c8
   3.09%  IO mon_iothread  qemu-system-x86_64       [.] 0x00000000004e636b
   0.22%  qemu-system-x86  [kernel.kallsyms]        [k] __intel_pmu_enable_all.constprop.0


As you can see, CPU consumption is significantly reduced after applying the
proposed change during panic, with KVM-related functions (e.g.,
vmx_vmexit) dropping from more than 70% of CPU usage to virtually nothing.
Also, the num of samples decreased from 55K to 28, and the event count
dropped from 36.09 billion to 28.96 million.


Jan suggested that a better way to implement cpu_halt_end_panic() (perhaps
cpu_halt_after_panic() is a better name) would be to define it as a weak
function in asm-generic, allowing archs to overwrite it. What do you think?

Thank you in advance!

Regards,
Carlos

---

Details on the experiment:

- Linux kernel v5.15 (commit 8bb7eca)

-  VM guest CPU: Intel(R) Xeon(R) Gold 5318Y CPU @ 2.10GHz

- I executed to collect samples:
  /usr/bin/perf record -p 2618527 -a sleep 30

- Image Ubuntu 22.04 (LTS) x64, 8 vCPUs, 16GB / 100GB Disk


Thanks,

Carlos


On 3/17/25 17:01, Carlos Bilbao wrote:
> After the kernel has finished handling a panic, it enters a busy-wait loop.
> But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
> this negatively impacts the throughput of other VM guests running on the
> same hypervisor.
>
> I propose introducing a function cpu_halt_end_panic() to halt the CPU
> during this state while still allowing interrupts to be processed. See my
> commit below.
>
> Thanks in advance!
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
> ---
>  kernel/panic.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index fbc59b3b64d0..c00ccaa698d5 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -276,6 +276,21 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>          crash_smp_send_stop();
>  }
>  
> +static void cpu_halt_end_panic(void)
> +{
> +#ifdef CONFIG_X86
> +    native_safe_halt();
> +#elif defined(CONFIG_ARM)
> +    cpu_do_idle();
> +#else
> +    /*
> +     * Default to a simple busy-wait if no architecture-specific halt is
> +     * defined above
> +     */
> +    mdelay(PANIC_TIMER_STEP);
> +#endif
> +}
> +
>  /**
>   *    panic - halt the system
>   *    @fmt: The text string to print
> @@ -474,7 +489,7 @@ void panic(const char *fmt, ...)
>              i += panic_blink(state ^= 1);
>              i_next = i + 3600 / PANIC_BLINK_SPD;
>          }
> -        mdelay(PANIC_TIMER_STEP);
> +        cpu_halt_end_panic();
>      }
>  }
>  

