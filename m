Return-Path: <linux-kernel+bounces-438627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9BC9EA3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB28282DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A311CBA;
	Tue, 10 Dec 2024 00:34:45 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89737B67F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790885; cv=none; b=kkgx1oy1LtdL1owY+fwpyne1ktlNWJBNE7Q+C1w6xL0m7CQJIXuff6Uz7TqoPlzTXLiKjLe3hgkv69mxXNNMSKZHxyXO24qBe+sEoGliX+WzvFSx1WzQ2yWZ0Yt8Mt5pO/Mn8H+aTuINLSRRxhfs4CVm4o0xZGiA8KWATrSI3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790885; c=relaxed/simple;
	bh=oWpboKzOk0PvcQ4mIgriScaNZtaTuUq8Em7vAbwxpbw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsbRGV8ZLB2p1kkNSL5JwaUdJTtZfKoVDY6sGbE7EPcOKydMpGkv/5/9sB3HLTJy16AAMqLp30miN5cr22vVgC9AIACG3X7jAfU6VyzI6MOoq0fsBQtyU9BTHQ92rgsSDMvGHNoKeyPXyGLMadDg4VBr4Cwnmfd8/igQ+9ZlxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434f4ccddbdso20099385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733790880; x=1734395680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTvuZJMgIQP71e2LzeuwP91ejBbDqM7T9sjpudIcFbE=;
        b=lCVGBTP09GJ2aTX/uHxuVpg1uqUpCBFMqE7tUHIcV96F2d14ayd0ZzOCCEIkPIR5Z+
         3NO4zqulpYnlsLdGD9cKDhamAZjvfmLcDW9Njgwd+9mCB8kZHLJ1nN+7nwgOCYtazUEG
         8TeYDuMbh1/bnXWdmVsdEehp1aCuoflfkMI3NvkTIOpwie5YbvolKiLyFqjdREc4h/mm
         DMVKwnQDH5vQt43eXdF6cuGDbaDVQ9p6I6nPT2zVeEWH//J8g1LgX9/RM1HV+VBvIdFx
         BaW90fy6O13KonKegfllGk0H/DK/7mqitIhVp/srG6chflThqgJdxQSmhfuji5v3Uout
         QXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUtuZocZ4fWsTEb4padlhpVvYVCTer4g+DTHCWQDj0QL/OpHI0SZZf9L9EXE+dMhP0rELIEEjNVdBT9i7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1IYjmrjd3lBfe2hae2knADF60NrpycEoAz4SYqNqixyCK2wcI
	l85BVt4VPPMpLABIKL08rkgt2Qp5Fz0JDzoLDQGtzHUMYg9oWaxU
X-Gm-Gg: ASbGncuPrDS66unYyPUFW6ciXzagtjVa2AP3WedPn8fOle+2O0FfL5e65DJiHhJfQ4m
	mkHtvJM8KCvJeq50zaC+xzUcF6mYXcq37ZDImlQjfDh85+4+EEMx7qFp1g94qaGqswWRGd/lzNa
	vD7hYvflyV0yEkbhvGiCXm/YT/kf5EiWeErBgMcHXcLPgnO233tlHwjHjG3476gSiM5zf19viD4
	cuKuH7u2jTjssSWQZQXbl7nwvl/bLOvaXa52vNRvEd41I/aymyMORUnwRR3tsXoHvor1gdPPMX0
	qITYMMrTrg==
X-Google-Smtp-Source: AGHT+IFxtrlFgOqjtPWmcbTop5atYMQR5wlp3G20PrYkrjTwFyMIK3YWhWugGZTVBZoVnxoCmQsfmA==
X-Received: by 2002:a5d:5f48:0:b0:386:459f:67e0 with SMTP id ffacd0b85a97d-386459f687dmr1299798f8f.21.1733790879571;
        Mon, 09 Dec 2024 16:34:39 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm10646632f8f.65.2024.12.09.16.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:34:38 -0800 (PST)
Message-ID: <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
Date: Tue, 10 Dec 2024 01:34:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Joel Fernandes <joel@joelfernandes.org>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com,
 shraash@google.com, marcel.ziswiler@codethink.co.uk
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Peter Zijlstra <peterz@infradead.org>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org>
 <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net>
 <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 13:56, Peter Zijlstra wrote:
> 
> Does something like the below make sense?
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..abebeb67de4e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -664,6 +664,7 @@ struct sched_dl_entity {
>  	unsigned int			dl_non_contending : 1;
>  	unsigned int			dl_overrun	  : 1;
>  	unsigned int			dl_server         : 1;
> +	unsigned int			dl_server_active  : 1;
>  	unsigned int			dl_defer	  : 1;
>  	unsigned int			dl_defer_armed	  : 1;
>  	unsigned int			dl_defer_running  : 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..e2b542f684db 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>  	if (!dl_se->dl_runtime)
>  		return;
>  
> +	dl_se->dl_server_active = 1;
>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>  	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
>  		resched_curr(dl_se->rq);
> @@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>  	hrtimer_try_to_cancel(&dl_se->dl_timer);
>  	dl_se->dl_defer_armed = 0;
>  	dl_se->dl_throttled = 0;
> +	dl_se->dl_server_active = 0;
>  }
>  
>  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> @@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
>  	if (dl_server(dl_se)) {
>  		p = dl_se->server_pick_task(dl_se);
>  		if (!p) {
> -			dl_se->dl_yielded = 1;
> -			update_curr_dl_se(rq, dl_se, 0);
> +			if (dl_se->dl_server_active) {
> +				dl_se->dl_yielded = 1;
> +				update_curr_dl_se(rq, dl_se, 0);
> +			}
>  			goto again;
>  		}
>  		rq->dl_server = dl_se;

And I tried this one on top of v6.12, but got a warning after about 1 minute (lucky?).

Funny this one is also on CPU 15, but it's a coincidense, it happened on different
CPUs before.

Dec  9 18:11:10 kernel: clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1194465656 wd_nsec: 1194465705
Dec  9 18:11:10 kernel: ------------[ cut here ]------------
Dec  9 18:11:10 kernel: WARNING: CPU: 15 PID: 7389 at kernel/sched/deadline.c:1997 enqueue_dl_entity (kernel/sched/deadline.c:1997 (discriminator 1)) 
Dec  9 18:11:10 kernel: Modules linked in: vport_vxlan vxlan vport_gre ip_gre ip_tunnel gre vport_geneve geneve ip6_udp_tunnel udp_tunnel openvswitch nf_conncount nf_nat ib_core esp4 veth nfnetlink_cttimeout nfnetlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 int
el_rapl_msr intel_rapl_common rfkill intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm rapl vfat fat iTCO_wdt virtio_gpu iTCO_vendor_support virtio_dma_buf i2c_i801 drm_shmem_helper virtio_balloon pcspkr i2c_smbus drm_kms_helper lpc_ich joydev d
rm xfs libcrc32c crct10dif_pclmul ahci crc32_pclmul libahci virtio_net crc32c_intel libata ghash_clmulni_intel net_failover virtio_console virtio_blk failover serio_raw sunrpc dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: ip6_udp_tunnel]
Dec  9 18:11:10 kernel: CPU: 15 UID: 0 PID: 7389 Comm: revalidator42 Kdump: loaded Not tainted 6.12.0+ #78
Dec  9 18:11:10 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec  9 18:11:10 kernel: RIP: 0010:enqueue_dl_entity (kernel/sched/deadline.c:1997 (discriminator 1)) 
Dec  9 18:11:10 kernel: Code: 0a 00 00 0f b6 45 54 e9 d9 fc ff ff 45 85 ed 0f 84 5e fd ff ff 5b 44 89 e6 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 8b c4 ff ff <0f> 0b e9 b2 f9 ff ff 0f 0b e9 14 fb ff ff 8b 83 b0 0a 00 00 48 8b
All code
========
   0:   0a 00                   or     (%rax),%al
   2:   00 0f                   add    %cl,(%rdi)
   4:   b6 45                   mov    $0x45,%dh
   6:   54                      push   %rsp
   7:   e9 d9 fc ff ff          jmpq   0xfffffffffffffce5
   c:   45 85 ed                test   %r13d,%r13d
   f:   0f 84 5e fd ff ff       je     0xfffffffffffffd73
  15:   5b                      pop    %rbx
  16:   44 89 e6                mov    %r12d,%esi
  19:   48 89 ef                mov    %rbp,%rdi
  1c:   5d                      pop    %rbp
  1d:   41 5c                   pop    %r12
  1f:   41 5d                   pop    %r13
  21:   41 5e                   pop    %r14
  23:   41 5f                   pop    %r15
  25:   e9 8b c4 ff ff          jmpq   0xffffffffffffc4b5
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   e9 b2 f9 ff ff          jmpq   0xfffffffffffff9e3
  31:   0f 0b                   ud2    
  33:   e9 14 fb ff ff          jmpq   0xfffffffffffffb4c
  38:   8b 83 b0 0a 00 00       mov    0xab0(%rbx),%eax
  3e:   48                      rex.W
  3f:   8b                      .byte 0x8b

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2    
   2:   e9 b2 f9 ff ff          jmpq   0xfffffffffffff9b9
   7:   0f 0b                   ud2    
   9:   e9 14 fb ff ff          jmpq   0xfffffffffffffb22
   e:   8b 83 b0 0a 00 00       mov    0xab0(%rbx),%eax
  14:   48                      rex.W
  15:   8b                      .byte 0x8b
Dec  9 18:11:10 kernel: RSP: 0018:ffffb03601d336f8 EFLAGS: 00010086
Dec  9 18:11:10 kernel: RAX: 0000000000000001 RBX: ffff9ee93f1b65e8 RCX: 0000000000000001
Dec  9 18:11:10 kernel: RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9ee93f1b65e8
Dec  9 18:11:10 kernel: RBP: ffff9ee93f1b65e8 R08: 0000000000000000 R09: 0000000000000000
Dec  9 18:11:10 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
Dec  9 18:11:10 kernel: R13: 0000000000000001 R14: 00000000002dc6c0 R15: 0000000000000000
Dec  9 18:11:10 kernel: FS:  00007effb172e640(0000) GS:ffff9ee93f180000(0000) knlGS:0000000000000000
Dec  9 18:11:10 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  9 18:11:10 kernel: CR2: 0000720000080000 CR3: 000000010d86a005 CR4: 0000000000772ef0
Dec  9 18:11:10 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Dec  9 18:11:10 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Dec  9 18:11:10 kernel: PKRU: 55555554
Dec  9 18:11:10 kernel: Call Trace:
Dec  9 18:11:10 kernel: <TASK>
Dec  9 18:11:10 kernel: ? __warn (kernel/panic.c:748) 
Dec  9 18:11:10 kernel: ? enqueue_dl_entity (kernel/sched/deadline.c:1997 (discriminator 1)) 
Dec  9 18:11:10 kernel: ? report_bug (lib/bug.c:201 lib/bug.c:219) 
Dec  9 18:11:10 kernel: ? handle_bug (arch/x86/kernel/traps.c:285) 
Dec  9 18:11:10 kernel: ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
Dec  9 18:11:10 kernel: ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
Dec  9 18:11:10 kernel: ? enqueue_dl_entity (kernel/sched/deadline.c:1997 (discriminator 1)) 
Dec  9 18:11:10 kernel: dl_server_start (kernel/sched/deadline.c:1652) 
Dec  9 18:11:10 kernel: enqueue_task_fair (kernel/sched/sched.h:2745 kernel/sched/fair.c:7048) 
Dec  9 18:11:10 kernel: enqueue_task (kernel/sched/core.c:2020) 
Dec  9 18:11:10 kernel: activate_task (kernel/sched/core.c:2069) 
Dec  9 18:11:10 kernel: sched_balance_rq (kernel/sched/fair.c:9642 kernel/sched/fair.c:9676 kernel/sched/fair.c:11753) 
Dec  9 18:11:10 kernel: sched_balance_newidle (kernel/sched/fair.c:12799) 
Dec  9 18:11:10 kernel: pick_next_task_fair (kernel/sched/fair.c:8950) 
Dec  9 18:11:10 kernel: __pick_next_task (kernel/sched/core.c:5972) 
Dec  9 18:11:10 kernel: __schedule (kernel/sched/core.c:6647) 
Dec  9 18:11:10 kernel: ? plist_add (./include/linux/list.h:150 ./include/linux/list.h:183 lib/plist.c:111) 
Dec  9 18:11:10 kernel: schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  9 18:11:10 kernel: futex_wait_queue (kernel/futex/waitwake.c:372 (discriminator 2)) 
Dec  9 18:11:10 kernel: __futex_wait (kernel/futex/waitwake.c:672) 
Dec  9 18:11:10 kernel: ? __pfx_futex_wake_mark (kernel/futex/waitwake.c:135) 
Dec  9 18:11:10 kernel: futex_wait (kernel/futex/waitwake.c:700) 
Dec  9 18:11:10 kernel: do_futex (kernel/futex/syscalls.c:131) 
Dec  9 18:11:10 kernel: __x64_sys_futex (kernel/futex/syscalls.c:179 kernel/futex/syscalls.c:160 kernel/futex/syscalls.c:160) 
Dec  9 18:11:10 kernel: ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
Dec  9 18:11:10 kernel: ? sched_clock (./arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:285) 
Dec  9 18:11:10 kernel: ? sched_clock_cpu (kernel/sched/clock.c:394) 
Dec  9 18:11:10 kernel: ? raw_spin_rq_lock_nested (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:600) 
Dec  9 18:11:10 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec  9 18:11:10 kernel: ? _raw_spin_unlock (./arch/x86/include/asm/paravirt.h:589 ./arch/x86/include/asm/qspinlock.h:57 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:142 kernel/locking/spinlock.c:186) 
Dec  9 18:11:10 kernel: ? finish_task_switch.isra.0 (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 kernel/sched/sched.h:1518 kernel/sched/core.c:5082 kernel/sched/core.c:5200) 
Dec  9 18:11:10 kernel: ? __schedule (kernel/sched/core.c:6699) 
Dec  9 18:11:10 kernel: ? schedule (./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6771 kernel/sched/core.c:6785) 
Dec  9 18:11:10 kernel: ? futex_wait_queue (kernel/futex/waitwake.c:372 (discriminator 2)) 
Dec  9 18:11:10 kernel: ? __futex_wait (kernel/futex/waitwake.c:672) 
Dec  9 18:11:10 kernel: ? __pfx_futex_wake_mark (kernel/futex/waitwake.c:135) 
Dec  9 18:11:10 kernel: ? futex_wait (kernel/futex/waitwake.c:700) 
Dec  9 18:11:10 kernel: ? do_futex (kernel/futex/syscalls.c:131) 
Dec  9 18:11:10 kernel: ? rseq_get_rseq_cs (kernel/rseq.c:161) 
Dec  9 18:11:10 kernel: ? rseq_ip_fixup (kernel/rseq.c:257 kernel/rseq.c:291) 
Dec  9 18:11:10 kernel: ? do_futex (kernel/futex/syscalls.c:131) 
Dec  9 18:11:10 kernel: ? syscall_exit_to_user_mode (./arch/x86/include/asm/entry-common.h:58 ./arch/x86/include/asm/entry-common.h:65 ./include/linux/entry-common.h:330 kernel/entry/common.c:207 kernel/entry/common.c:218) 
Dec  9 18:11:10 kernel: ? do_syscall_64 (arch/x86/entry/common.c:102) 
Dec  9 18:11:10 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  9 18:11:10 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  9 18:11:10 kernel: ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
Dec  9 18:11:10 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec  9 18:11:10 kernel: RIP: 0033:0x7effd0a86a80
Dec  9 18:11:10 kernel: Code: 41 89 f0 83 f8 02 74 0b b8 02 00 00 00 87 07 85 c0 74 47 90 44 89 c6 45 31 d2 ba 02 00 00 00 b8 ca 00 00 00 40 80 f6 80 0f 05 <48> 3d 00 f0 ff ff 76 d6 83 c0 0b 83 f8 0b 77 0b ba 81 08 00 00 48
All code
========
   0:   41 89 f0                mov    %esi,%r8d
   3:   83 f8 02                cmp    $0x2,%eax
   6:   74 0b                   je     0x13
   8:   b8 02 00 00 00          mov    $0x2,%eax
   d:   87 07                   xchg   %eax,(%rdi)
   f:   85 c0                   test   %eax,%eax
  11:   74 47                   je     0x5a
  13:   90                      nop
  14:   44 89 c6                mov    %r8d,%esi
  17:   45 31 d2                xor    %r10d,%r10d
  1a:   ba 02 00 00 00          mov    $0x2,%edx
  1f:   b8 ca 00 00 00          mov    $0xca,%eax
  24:   40 80 f6 80             xor    $0x80,%sil
  28:   0f 05                   syscall 
  2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
  30:   76 d6                   jbe    0x8
  32:   83 c0 0b                add    $0xb,%eax
  35:   83 f8 0b                cmp    $0xb,%eax
  38:   77 0b                   ja     0x45
  3a:   ba 81 08 00 00          mov    $0x881,%edx
  3f:   48                      rex.W

Code starting with the faulting instruction
===========================================
   0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
   6:   76 d6                   jbe    0xffffffffffffffde
   8:   83 c0 0b                add    $0xb,%eax
   b:   83 f8 0b                cmp    $0xb,%eax
   e:   77 0b                   ja     0x1b
  10:   ba 81 08 00 00          mov    $0x881,%edx
  15:   48                      rex.W
Dec  9 18:11:10 kernel: RSP: 002b:00007effb172a528 EFLAGS: 00000282 ORIG_RAX: 00000000000000ca
Dec  9 18:11:10 kernel: RAX: ffffffffffffffda RBX: 00007effb172e640 RCX: 00007effd0a86a80
Dec  9 18:11:10 kernel: RDX: 0000000000000002 RSI: 0000000000000080 RDI: 000000000171a3c0
Dec  9 18:11:10 kernel: RBP: 00007effb172a5e0 R08: 0000000000000000 R09: 00002effb172a89c
Dec  9 18:11:10 kernel: R10: 0000000000000000 R11: 0000000000000282 R12: 00007effb172e640
Dec  9 18:11:10 kernel: R13: 000000000000000b R14: 00007effd0a89a50 R15: 0000000000000000
Dec  9 18:11:10 kernel: </TASK>
Dec  9 18:11:10 kernel: ---[ end trace 0000000000000000 ]---


