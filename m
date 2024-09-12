Return-Path: <linux-kernel+bounces-326424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62597682E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433081C217A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8E1A3025;
	Thu, 12 Sep 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q2jOPYO/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4EE1A264F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141719; cv=none; b=qoEzrlHrzbcH+Haurl4HBOoooL7wTIkHTicPmK3dqPvwGYYWlBbMnFRh+jdJSjXBZv5ijwBadZzcK7KjOYIzWXvcplCUjYcajFAsMFohuihn8cv0gA5q77cWcgVEd3x6WnGFa7hGDjPT6q4CLH7lbGcGVxVhkgQnj0pHjhMLWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141719; c=relaxed/simple;
	bh=5MeAB3wNWXW6zxJcKzD345TpEvs6pJEG8GzU2zkj5H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGUaGPnBIGsgIVDG+MGlbK2MPoI83v1jrrXfVWgsPV1fC8XGyClqRE5w7WYwKILXaeD7ojDVWe7wzhnPQMe/7vZJJYVbYyaxsrQgGDp3RINXE71J6+tdm2qgDayxgMkla3z3vYoffNcI0qDn6QMmD03NsPSzyNixOnX/3lCayXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q2jOPYO/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so7156705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1726141716; x=1726746516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4n+GYZ6xQGCnhlI0MzrUhScT+W1XwcIKjMSfmbo9NU=;
        b=Q2jOPYO/E7jwZYaYl80OevGfuGyfBcBsTDXrzKzAxWlaq0esh2Aun0lVXEhAxuWlRo
         Mn+MNR2yMgGhGllj/OSI5tentrXbjkWdBaCmyi4jr+oMJJ1vJTBLkaiyMHSCnWTng14F
         EaomsFP2V/3jrAsmbSxsbcud9Xjgh+ZryHgcjiRyTGf1lXzYrdc7NDSH6F3c1tqsWfMj
         8QlLgoFTqnwluHYW6uoD3EhYeXr0iu2sv5hI0QAiL2zeE3myX5BWzs3BGtw97MxaUN33
         O2MZIUvaAYQXD58UYOIFc/vh9Uil4UDiRsPB0K9aOpEp2nCKE53fJDES/UpyunoqHqcZ
         9piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141716; x=1726746516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4n+GYZ6xQGCnhlI0MzrUhScT+W1XwcIKjMSfmbo9NU=;
        b=l48xZ/o90KzmC2G+zY6TueashZN7cMOATEhzmhfMd9vzdeghAovGDc75fmfI8rbely
         kWQG7Scbmat/xhrkGRqQBJEXb7flw+inxBZr7hwwdTb/ABaLbwT054R5ndditjRiFuNn
         wHBI80U/ECqn9eLZ/NTqNx/zJN3Jg4Uyw0DIqMnmCUd114butfTOSshMk31aXyDepiGr
         VTJF8qGnWdXSiIhfn9kMtZwWCeXtMfwi/iKBY58/V6tDZla3z6xL/dcv2y9uQp5rKV9d
         WnqQx22qeZ6XIw80lytIhCdD/MPp/gW2f+gdRnQAEFRjgdIzGce6Hxhjqe1kkeLH7kKy
         xHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDLrV4Lsrs2XJrI5udybqBF8b/M1wSeFj3UWpThRnT7Dha6YFcQ7y6z6lmqmfEcty5Zjhazf9DHq9wESA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGJ6WCa6puMsw8fSJ+SeIzC51wbZrioNvZKY5R5CvwQV+TfHJ
	I4qCnXQn4zoBwZOC5oaGcYULB46jz8oBwhMVG4SzY2cT+di3+Xni7kXB923nwqA=
X-Google-Smtp-Source: AGHT+IGuLMW5PBxZVZzC5sjGav8GQCfg4HAZBPxOo7KZmIvu+1pf6lJkOGjLrp49iZcF/LWq3PE2sw==
X-Received: by 2002:a05:600c:548e:b0:42c:a905:9384 with SMTP id 5b1f17b1804b1-42cdb54d606mr17694175e9.20.1726141714874;
        Thu, 12 Sep 2024 04:48:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm14162196f8f.50.2024.09.12.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:48:34 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:48:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Subject: Re: [PATCH v2 00/13] KVM: selftests: Morph max_guest_mem to
 mmu_stress
Message-ID: <20240912-757a952b867ea1136cb260cf@orel>
References: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>

On Wed, Sep 11, 2024 at 01:41:45PM GMT, Sean Christopherson wrote:
> Marc/Oliver,
> 
> I would love a sanity check on patches 2 and 3 before I file a bug against
> gcc.  The code is pretty darn simple, so I don't think I've misdiagnosed the
> problem, but I've also been second guessing myself _because_ it's so simple;
> it seems super unlikely that no one else would have run into this before.
> 
> On to the patches...
> 
> The main purpose of this series is to convert the max_guest_memory_test into
> a more generic mmu_stress_test.  The patches were originally posted as part
> a KVM x86/mmu series to test the x86/mmu changes, hence the v2.
> 
> The basic gist of the "conversion" is to have the test do mprotect() on
> guest memory while vCPUs are accessing said memory, e.g. to verify KVM and
> mmu_notifiers are working as intended.
> 
> Patches 1-4 are a somewhat unexpected side quest that I can (arguably should)
> post separately if that would make things easier.  The original plan was that
> patch 2 would be a single patch, but things snowballed.
> 
> Patch 2 reworks vcpu_get_reg() to return a value instead of using an
> out-param.  This is the entire motivation for including these patches;
> having to define a variable just to bump the program counter on arm64
> annoyed me.
> 
> Patch 4 adds hardening to vcpu_{g,s}et_reg() to detect potential truncation,
> as KVM's uAPI allows for registers greater than the 64 bits the are supported
> in the "outer" selftests APIs ((vcpu_set_reg() takes a u64, vcpu_get_reg()
> now returns a u64).
> 
> Patch 1 is a change to KVM's uAPI headers to move the KVM_REG_SIZE
> definition to common code so that the selftests side of things doesn't
> need #ifdefs to implement the hardening in patch 4.
> 
> Patch 3 is the truly unexpected part.  With the vcpu_get_reg() rework,
> arm64's vpmu_counter_test fails when compiled with gcc-13, and on gcc-11
> with an added "noinline".  AFAICT, the failure doesn't actually have
> anything to with vcpu_get_reg(); I suspect the largely unrelated change
> just happened to run afoul of a latent gcc bug.
> 
> Pending a sanity check, I will file a gcc bug.  In the meantime, I am
> hoping to fudge around the issue in KVM selftests so that the vcpu_get_reg()
> cleanup isn't blocked, and because the hack-a-fix is arguably a cleanup
> on its own.
> 
> v2:
>  - Rebase onto kvm/next.
>  - Add the aforementioned vcpu_get_reg() changes/disaster.
>  - Actually add arm64 support for the fancy mprotect() testcase (I did this
>    before v1, but managed to forget to include the changes when posting).
>  - Emit "mov %rax, (%rax)" on x86. [James]
>  - Add a comment to explain the fancy mprotect() vs. vCPUs logic.
>  - Drop the KVM x86 patches (applied and/or will be handled separately).
> 
> v1: https://lore.kernel.org/all/20240809194335.1726916-1-seanjc@google.com
> 
> Sean Christopherson (13):
>   KVM: Move KVM_REG_SIZE() definition to common uAPI header
>   KVM: selftests: Return a value from vcpu_get_reg() instead of using an
>     out-param
>   KVM: selftests: Fudge around an apparent gcc bug in arm64's PMU test
>   KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
>   KVM: selftests: Check for a potential unhandled exception iff KVM_RUN
>     succeeded
>   KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
>   KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
>   KVM: selftests: Compute number of extra pages needed in
>     mmu_stress_test
>   KVM: selftests: Enable mmu_stress_test on arm64
>   KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
>   KVM: selftests: Precisely limit the number of guest loops in
>     mmu_stress_test
>   KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
>   KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
> 
>  arch/arm64/include/uapi/asm/kvm.h             |   3 -
>  arch/riscv/include/uapi/asm/kvm.h             |   3 -
>  include/uapi/linux/kvm.h                      |   4 +
>  tools/testing/selftests/kvm/Makefile          |   3 +-
>  .../selftests/kvm/aarch64/aarch32_id_regs.c   |  10 +-
>  .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
>  .../selftests/kvm/aarch64/hypercalls.c        |   6 +-
>  .../testing/selftests/kvm/aarch64/psci_test.c |   6 +-
>  .../selftests/kvm/aarch64/set_id_regs.c       |  18 +-
>  .../kvm/aarch64/vpmu_counter_access.c         |  27 ++-
>  .../testing/selftests/kvm/include/kvm_util.h  |  10 +-
>  .../selftests/kvm/lib/aarch64/processor.c     |   8 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   3 +-
>  .../selftests/kvm/lib/riscv/processor.c       |  66 +++----
>  ..._guest_memory_test.c => mmu_stress_test.c} | 161 ++++++++++++++++--
>  .../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
>  .../testing/selftests/kvm/riscv/ebreak_test.c |   2 +-
>  .../selftests/kvm/riscv/sbi_pmu_test.c        |   2 +-
>  tools/testing/selftests/kvm/s390x/resets.c    |   2 +-
>  tools/testing/selftests/kvm/steal_time.c      |   3 +-
>  20 files changed, 236 insertions(+), 107 deletions(-)
>  rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (60%)
> 
> 
> base-commit: 15e1c3d65975524c5c792fcd59f7d89f00402261
> -- 
> 2.46.0.598.g6f2099f65c-goog

I gave this test a try on riscv, but it appears to hang in
rendezvous_with_vcpus(). My platform is QEMU, so maybe I was just too
impatient. Anyway, I haven't read the test yet, so I don't even know
what it's doing. It's possibly it's trying to do something not yet
supported on riscv. I'll add investigating that to my TODO, but I'm
not sure when I'll get to it.

As for this series, another patch (or a sneaky change to one
of the patches...) should add 

 #include "ucall_common.h"

to mmu_stress_test.c since it's not there yet despite using get_ucall().
Building riscv faild because of that.

Thanks,
drew

