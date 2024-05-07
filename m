Return-Path: <linux-kernel+bounces-171829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 141798BE9C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC59B2C67C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6F16F0C5;
	Tue,  7 May 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCQPkDt6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5116EC15
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099520; cv=none; b=USKZkAYCI+DK2hptdfZFq/VGyKOz0m9omnEyuz4IakWZQYdR7vg0yl9ZChFrIAl0o+sFx9V2ndrsW2kFgrP0FGB63MByNKiDTqEY+CEk8nYOW8oTczsuoCSXl7hI/6n9C11dSYLCnIOyjeeFV1jMEPh8FtNIwc7BGBw11HcjQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099520; c=relaxed/simple;
	bh=7kgjLi9TNhjqGWboyoms3uNHLSO0jTRhJxxJrePYkO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JZKzsJNo5GFAIqYISfaIeh4HNs+CXoS7xigjC/P9MPXzxp59HJmkaneSQlDNjQI9Sfs2Q4qEhwh8L4LHE408Vidgmrm6452ZGV6qJG/fgOwLOxCZJGAVfUZUNO2ME7DBc/fimsenzsMl548Qw9r6bvAiHf1qgp++jqDOVLSAW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCQPkDt6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5a8638579so6494665276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715099517; x=1715704317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1e/eDMa4fHA47lU+IKD4lhvdRlMMmjjebDxPNzXZQkk=;
        b=MCQPkDt6RpI0I6bObED8rKPG5eUAx25RiRomNdzDqh/EBTLxVNHro0TqzZk1kOwUN1
         Zuz/9D1F2GAoCjy5mPp0prNWMnSqnOqEznDS2GXVaOKsspXd0thOZU3Aw4RikwTGNSII
         uuFW7vTlzozgVY/GU4vceYlww1tqa+zxPhxOZ4CQHOMfKNHbk+5+kDYv6UF2B5JnCiie
         kWdgW0m+68tWnczsZRpjlPWet1xzVwUtA4im3SdvIyFS/78UODTAmNOM0BTCAQXb30tu
         8ojedXLQ82+ssRsPabPhxEBErJFZKiF0Qvb8c/H6/Y+XWyk8+yXU8WdhhtJsfBomd5zv
         nrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099518; x=1715704318;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1e/eDMa4fHA47lU+IKD4lhvdRlMMmjjebDxPNzXZQkk=;
        b=Y0oSxOSJBoRBaSgvl2jFe5GTIMvQ714RoxI7GpOZ6sz8KcI1eADrTD022Ltkg/CR4H
         jBb7YjRMboI8DNAGjrb3PjuqPRvsRpnUKJZDZ2OOn9esJok1R7rChNMcZ3ZSKqnkYdj8
         B0UyR6uymw2n2QDw5tev8HDmBb7Mf4Em51mjJEmJTRZiXvOigSPuNuVVPlqNTLpjlz2T
         EDe15yI5zVGS/FyZ6UkvBMDWuGWCRPKysrS9/8U5b0xA7ajcJjQLHApAUMDuPmbljayY
         DrpQDKhhGC55U3+7A8BBjafMtmnm/Y1h+r5++a9YdKtgev93ur1ab+meLhAzuvi/6O2J
         5rvA==
X-Forwarded-Encrypted: i=1; AJvYcCXqz0/BTFLE31v3MgFy6iwO1QwKhqiFlSMN8nHXNJnMnfDC2MiEVyUshQcAYc4H+Qa3zLsMLz//+XSVKHDN+oGL87q6rwQ5+9wT3Ke2
X-Gm-Message-State: AOJu0YyWxRd4e/6owp7+XVng/HwqmihEJwOgtpQqJk6w+CKyoEFlOZaV
	48EJkRR2I2iHNL+m6vdxgNe0WPfXw20lrmfMbthnGPw8j8nY5LEcajh+BlhBNXSiXbFpENf/Bx1
	nPQ==
X-Google-Smtp-Source: AGHT+IGZVgoWBMMFq1L9YeULM2uZbSISiYBnO4niE0YUsWvKq+soQEHDD98XH3lHMNeIe8FvRkQJIKWr3j8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2991:b0:de5:c2b:389b with SMTP id
 3f1490d57ef6-debb9d2db7cmr11986276.5.1715099517748; Tue, 07 May 2024 09:31:57
 -0700 (PDT)
Date: Tue, 7 May 2024 09:31:55 -0700
In-Reply-To: <20240425233951.3344485-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-4-seanjc@google.com>
Message-ID: <ZjpXeyzU46I1eu0A@google.com>
Subject: Re: [PATCH 3/4] KVM: Register cpuhp and syscore callbacks when
 enabling hardware
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 25, 2024, Sean Christopherson wrote:
> Register KVM's cpuhp and syscore callback when enabling virtualization
> in hardware instead of registering the callbacks during initialization,
> and let the CPU up/down framework invoke the inner enable/disable
> functions.  Registering the callbacks during initialization makes things
> more complex than they need to be, as KVM needs to be very careful about
> handling races between enabling CPUs being onlined/offlined and hardware
> being enabled/disabled.
> 
> Intel TDX support will require KVM to enable virtualization during KVM
> initialization, i.e. will add another wrinkle to things, at which point
> sorting out the potential races with kvm_usage_count would become even
> more complex.
> +static int hardware_enable_all(void)
> +{
> +	int r;
> +
> +	guard(mutex)(&kvm_lock);
> +
> +	if (kvm_usage_count++)
> +		return 0;
> +
> +	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
> +			      kvm_online_cpu, kvm_offline_cpu);
> +	if (r)
> +		return r;

There's a lock ordering issue here.  KVM currently takes kvm_lock inside
cpu_hotplug_lock, but this code does the opposite.  I need to take a closer look
at the locking, as I'm not entirely certain that the existing ordering is correct
or ideal.  E.g. cpu_hotplug_lock is taken when updating static keys, static calls,
etc., which makes taking cpu_hotplug_lock outside kvm_lock dicey, as flows that
take kvm_lock then need to be very careful to never trigger seemingly innocuous
updates.

And this lockdep splat that I've now hit twice with the current implementation
suggests that cpu_hotplug_lock => kvm_lock is already unsafe/broken (I need to
re-decipher the splat; I _think_ mostly figured it out last week, but then forgot
over the weekend).


[48419.244819] ======================================================
[48419.250999] WARNING: possible circular locking dependency detected
[48419.257179] 6.9.0-smp--04b1c6b4841d-next #301 Tainted: G S         O      
[48419.264050] ------------------------------------------------------
[48419.270229] tee/27085 is trying to acquire lock:
[48419.274849] ffffb5fdd4e430a8 (&kvm->slots_lock){+.+.}-{3:3}, at: set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.284085] 
               but task is already holding lock:
[48419.289918] ffffffffc06ccba8 (kvm_lock){+.+.}-{3:3}, at: set_nx_huge_pages+0x14a/0x1e0 [kvm]
[48419.298386] 
               which lock already depends on the new lock.

[48419.306559] 
               the existing dependency chain (in reverse order) is:
[48419.314040] 
               -> #3 (kvm_lock){+.+.}-{3:3}:
[48419.319523]        __mutex_lock+0x6a/0xb40
[48419.323622]        mutex_lock_nested+0x1f/0x30
[48419.328071]        kvm_dev_ioctl+0x4fb/0xe50 [kvm]
[48419.332898]        __se_sys_ioctl+0x7b/0xd0
[48419.337082]        __x64_sys_ioctl+0x21/0x30
[48419.341357]        do_syscall_64+0x8b/0x170
[48419.345540]        entry_SYSCALL_64_after_hwframe+0x71/0x79
[48419.351115] 
               -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[48419.357294]        cpus_read_lock+0x2e/0xb0
[48419.361480]        static_key_slow_inc+0x16/0x30
[48419.366098]        kvm_lapic_set_base+0x6a/0x1c0 [kvm]
[48419.371298]        kvm_set_apic_base+0x8f/0xe0 [kvm]
[48419.376298]        kvm_set_msr_common+0xa29/0x1080 [kvm]
[48419.381645]        vmx_set_msr+0xa54/0xbe0 [kvm_intel]
[48419.386795]        __kvm_set_msr+0xb6/0x1a0 [kvm]
[48419.391535]        kvm_arch_vcpu_ioctl+0xf66/0x1150 [kvm]
[48419.396970]        kvm_vcpu_ioctl+0x485/0x5b0 [kvm]
[48419.401881]        __se_sys_ioctl+0x7b/0xd0
[48419.406067]        __x64_sys_ioctl+0x21/0x30
[48419.410342]        do_syscall_64+0x8b/0x170
[48419.414528]        entry_SYSCALL_64_after_hwframe+0x71/0x79
[48419.420099] 
               -> #1 (&kvm->srcu){.?.+}-{0:0}:
[48419.425758]        __synchronize_srcu+0x44/0x1a0
[48419.430378]        synchronize_srcu_expedited+0x21/0x30
[48419.435603]        kvm_swap_active_memslots+0x113/0x1c0 [kvm]
[48419.441385]        kvm_set_memslot+0x360/0x620 [kvm]
[48419.446387]        __kvm_set_memory_region+0x27b/0x300 [kvm]
[48419.452078]        kvm_vm_ioctl_set_memory_region+0x43/0x60 [kvm]
[48419.458207]        kvm_vm_ioctl+0x295/0x650 [kvm]
[48419.462945]        __se_sys_ioctl+0x7b/0xd0
[48419.467133]        __x64_sys_ioctl+0x21/0x30
[48419.471406]        do_syscall_64+0x8b/0x170
[48419.475590]        entry_SYSCALL_64_after_hwframe+0x71/0x79
[48419.481164] 
               -> #0 (&kvm->slots_lock){+.+.}-{3:3}:
[48419.487343]        __lock_acquire+0x15ef/0x2e40
[48419.491876]        lock_acquire+0xe0/0x260
[48419.495977]        __mutex_lock+0x6a/0xb40
[48419.500076]        mutex_lock_nested+0x1f/0x30
[48419.504521]        set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.509694]        param_attr_store+0x93/0x100
[48419.514142]        module_attr_store+0x22/0x40
[48419.518587]        sysfs_kf_write+0x81/0xb0
[48419.522774]        kernfs_fop_write_iter+0x133/0x1d0
[48419.527738]        vfs_write+0x317/0x380
[48419.531663]        ksys_write+0x70/0xe0
[48419.535505]        __x64_sys_write+0x1f/0x30
[48419.539777]        do_syscall_64+0x8b/0x170
[48419.543961]        entry_SYSCALL_64_after_hwframe+0x71/0x79
[48419.549534] 
               other info that might help us debug this:

[48419.557534] Chain exists of:
                 &kvm->slots_lock --> cpu_hotplug_lock --> kvm_lock

[48419.567873]  Possible unsafe locking scenario:

[48419.573793]        CPU0                    CPU1
[48419.578325]        ----                    ----
[48419.582859]   lock(kvm_lock);
[48419.585831]                                lock(cpu_hotplug_lock);
[48419.592011]                                lock(kvm_lock);
[48419.597499]   lock(&kvm->slots_lock);
[48419.601173] 
                *** DEADLOCK ***

[48419.607090] 5 locks held by tee/27085:
[48419.610841]  #0: ffffa0dcc92eb410 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0xe4/0x380
[48419.618765]  #1: ffffa0dce221ac88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xd8/0x1d0
[48419.627553]  #2: ffffa11c4d6bef28 (kn->active#257){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xe0/0x1d0
[48419.636684]  #3: ffffffffc06e3c50 (&mod->param_lock){+.+.}-{3:3}, at: param_attr_store+0x57/0x100
[48419.645575]  #4: ffffffffc06ccba8 (kvm_lock){+.+.}-{3:3}, at: set_nx_huge_pages+0x14a/0x1e0 [kvm]
[48419.654564] 
               stack backtrace:
[48419.658925] CPU: 93 PID: 27085 Comm: tee Tainted: G S         O       6.9.0-smp--04b1c6b4841d-next #301
[48419.668312] Hardware name: Google Interlaken/interlaken, BIOS 0.20231025.0-0 10/25/2023
[48419.676314] Call Trace:
[48419.678770]  <TASK>
[48419.680878]  dump_stack_lvl+0x83/0xc0
[48419.684552]  dump_stack+0x14/0x20
[48419.687880]  print_circular_bug+0x2f0/0x300
[48419.692068]  check_noncircular+0x103/0x120
[48419.696163]  ? __lock_acquire+0x5e3/0x2e40
[48419.700266]  __lock_acquire+0x15ef/0x2e40
[48419.704286]  ? __lock_acquire+0x5e3/0x2e40
[48419.708387]  ? __lock_acquire+0x5e3/0x2e40
[48419.712486]  ? __lock_acquire+0x5e3/0x2e40
[48419.716586]  lock_acquire+0xe0/0x260
[48419.720164]  ? set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.725060]  ? lock_acquire+0xe0/0x260
[48419.728822]  ? param_attr_store+0x57/0x100
[48419.732921]  ? set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.737768]  __mutex_lock+0x6a/0xb40
[48419.741359]  ? set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.746207]  ? set_nx_huge_pages+0x14a/0x1e0 [kvm]
[48419.751054]  ? param_attr_store+0x57/0x100
[48419.755158]  ? __mutex_lock+0x240/0xb40
[48419.759005]  ? param_attr_store+0x57/0x100
[48419.763107]  mutex_lock_nested+0x1f/0x30
[48419.767031]  set_nx_huge_pages+0x179/0x1e0 [kvm]
[48419.771705]  param_attr_store+0x93/0x100
[48419.775629]  module_attr_store+0x22/0x40
[48419.779556]  sysfs_kf_write+0x81/0xb0
[48419.783222]  kernfs_fop_write_iter+0x133/0x1d0
[48419.787668]  vfs_write+0x317/0x380
[48419.791084]  ksys_write+0x70/0xe0
[48419.794401]  __x64_sys_write+0x1f/0x30
[48419.798152]  do_syscall_64+0x8b/0x170
[48419.801819]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[48419.806872] RIP: 0033:0x7f98eff1ee0d
[48419.810465] Code: e5 41 57 41 56 53 50 49 89 d6 49 89 f7 89 fb 48 8b 05 37 7c 07 00 83 38 00 75 28 b8 01 00 00 00 89 df 4c 89 fe 4c 89 f2 0f 05 <48> 89 c3 48 3d 01 f0 ff ff 73 3a 48 89 d8 48 83 c4 08 5b 41 5e 41
[48419.829213] RSP: 002b:00007ffd5dee15c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[48419.836792] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f98eff1ee0d
[48419.843931] RDX: 0000000000000002 RSI: 00007ffd5dee16d0 RDI: 0000000000000005
[48419.851065] RBP: 00007ffd5dee15e0 R08: 00007f98efe161d2 R09: 0000000000000001
[48419.858196] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000002
[48419.865328] R13: 00007ffd5dee16d0 R14: 0000000000000002 R15: 00007ffd5dee16d0
[48419.872472]  </TASK>



