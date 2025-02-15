Return-Path: <linux-kernel+bounces-515837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E99A36987
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12AC3B1FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1238DE0;
	Sat, 15 Feb 2025 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3KFErU9N"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6445291E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577999; cv=none; b=jO4u0Gy1s5X6yLjDT5C+DaH1XPUh9t2bWX8pJ0Ay3NxwTbwEJlJKskLHws72we2N5CSC4gexQV+I+FxGSS+TtVteFvDn1hYPBkjdHVdm3AV+0+NKkTjsn5LVE1bO0+aMcWvphKyzF14Kj5XkjNMXNvMMKUMXQYKQTj8Q8nWWGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577999; c=relaxed/simple;
	bh=0w/O7XAcHnizaNLgdZdoSUadEkfJ3M787zxOIN8dWYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WEboHJjpgJR9ZgR3TwA0kacqf/FRVtZ6jvKhc7rUcymtvB5qSILRIayy9eOkLvOoiFHgYF3DD/sDCeT5YXnSUjWN7xZV0rKwPpvngKVLJVZQXmLFdK3TTJpcAL6R0omkvkZqVniAPqWM8VT0ziJC1hI1+XHTvd6nrEJV9VtuTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3KFErU9N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so5478312a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739577997; x=1740182797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dz+g4lvshIwKtoF1GJvNgyo0KsDnNgM7fWbFaBaiOh4=;
        b=3KFErU9NUwFUP7h1KzUBneCbkTxGh60Rpe5woG43epw3FhWj7EjzQLgzNifcBmGBJ5
         Q/BM7UAKDMoiomWW0k4Ko9H25tNid7HtRn6YMOToTb0XF7ReAKVPjCxZUb2lhtCJs/NB
         RqvwTmP4t9ADYjyNCzy9hqUe4LRNcIiJvHrVqd+IigjoaGHXoEn+ZnvnbS60VVnudL3i
         YeUQKSHLM4mq2uYB+T2ag8sNeJpNMLJpeoyYI4kYIEaZypHvghR6RM3fSRHeJdkbdvVN
         b4dTA+EAqAhku/H82+QLdvh6u6OB01kNpKXZtywMLzwlFscUgdouXSZgivbSt8kATvZe
         HQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577997; x=1740182797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dz+g4lvshIwKtoF1GJvNgyo0KsDnNgM7fWbFaBaiOh4=;
        b=oalgYyAlE0l4p3BqrOzIQtNcHzFFkR86kXmLv1PzTFZWW+JFGJdn9lIR6CiQMLy59v
         IA6hdQDYYrDuxi7Y4iD9LOEQJat4V+QS5DSRXT+j58SH17/m7yp+GjKh51Q75UURVM2s
         MlCus5J6RtGsn+LinceBXsG+O6DvU0+LWXWkuF67rx/NbGv0bxC7wpYSD7qKvHLSDMED
         oXceUn7HkNL4178RYT6gk8G/4YVxTyFeVoyfvT/KSYq24y3/xpSSOW1IiccQB2brcgFT
         4tih13xerVOyNyfdWHM2rtAv3jjE0/yb8tcqWRT8uH1kCH4KAkiflJJUpTC/a7ILStbH
         qEuA==
X-Forwarded-Encrypted: i=1; AJvYcCXZwF/EX+8PenIYQGWkAx8rng+G/mX42fGjWcNqO8SjwnvQs1wkknPOJrJJ9E3AYVY0YYcZ5DYWY0sPdLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLPLhzU8wOJ+DwLB+5oDAeTGk5ktEIT1UaBknB2zk0IAte32T
	yjAfhBGpn5nuHPvh9XqV9fHxnW8nA1w3UJyiX6GMyTI8LL4qN8ELcCdirzzgfcSRqfz8mrjaW4p
	GYA==
X-Google-Smtp-Source: AGHT+IFAaagnVh/yITNphVgAXZIbFbGAItl4BwYxNoiKtsFJ0MqhK/MMO9jwFhGOc3GUOdsRMoFtefDlolA=
X-Received: from pfbc6.prod.google.com ([2002:a05:6a00:ad06:b0:72b:ccb:c99b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f95:b0:730:949d:2d36
 with SMTP id d2e1a72fcca58-732618c21femr2181317b3a.18.1739577997093; Fri, 14
 Feb 2025 16:06:37 -0800 (PST)
Date: Fri, 14 Feb 2025 16:06:35 -0800
In-Reply-To: <20250214234058.2074135-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250125011833.3644371-1-seanjc@google.com> <20250214234058.2074135-1-pbonzini@redhat.com>
Message-ID: <Z6_ai1HdLWiTJ2Pf@google.com>
Subject: Re: [PATCH] KVM: x86: Load DR6 with guest value only before entering
 .vcpu_run() loop
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 14, 2025, Paolo Bonzini wrote:
> Queued, thanks.

Drat, I was too slow today.  I applied and pushed this to "kvm-x86 fixes" and
linux-next (as of yesterday), along with a few other things, I just haven't sent
out the "thanks" yet (got sidetracked).

If you want to grab those, here's a semi-impromptu pull request.  Otherwise I'll
just drop this particular commit.

--

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.14-rcN

for you to fetch changes up to c2fee09fc167c74a64adb08656cb993ea475197e:

  KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop (2025-02-12 08:59:38 -0800)

----------------------------------------------------------------
KVM fixes for 6.14 part 1

 - Reject Hyper-V SEND_IPI hypercalls if the local APIC isn't being emulated
   by KVM to fix a NULL pointer dereference.

 - Enter guest mode (L2) from KVM's perspective before initializing the vCPU's
   nested NPT MMU so that the MMU is properly tagged for L2, not L1.

 - Load the guest's DR6 outside of the innermost .vcpu_run() loop, as the
   guest's value may be stale if a VM-Exit is handled in the fastpath.

----------------------------------------------------------------
Sean Christopherson (6):
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
      KVM: selftests: Mark test_hv_cpuid_e2big() static in Hyper-V CPUID test
      KVM: selftests: Manage CPUID array in Hyper-V CPUID test's core helper
      KVM: selftests: Add CPUID tests for Hyper-V features that need in-kernel APIC
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop

 arch/x86/include/asm/kvm-x86-ops.h             |  1 +
 arch/x86/include/asm/kvm_host.h                |  1 +
 arch/x86/kvm/hyperv.c                          |  6 +++++-
 arch/x86/kvm/mmu/mmu.c                         |  2 +-
 arch/x86/kvm/svm/nested.c                      | 10 +++++-----
 arch/x86/kvm/svm/svm.c                         | 13 ++++++-------
 arch/x86/kvm/vmx/main.c                        |  1 +
 arch/x86/kvm/vmx/vmx.c                         | 10 ++++++----
 arch/x86/kvm/vmx/x86_ops.h                     |  1 +
 arch/x86/kvm/x86.c                             |  3 +++
 tools/testing/selftests/kvm/x86/hyperv_cpuid.c | 47 ++++++++++++++++++++++++++++++++---------------
 11 files changed, 62 insertions(+), 33 deletions(-)

