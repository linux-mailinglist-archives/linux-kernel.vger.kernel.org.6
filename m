Return-Path: <linux-kernel+bounces-424115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057219DB0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB47A16373D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55D126C0D;
	Thu, 28 Nov 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtnA2cM0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23387404E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757679; cv=none; b=C3gZfnVX6Wamr5+APj2JDx/xA1EEFkIebHNwwT/FkyS/rTVTOOgR8fsndC11mrh7Yn71fY/idzd07XOjdM/QLq6qV0JqdHkuE/UQrFdq6X0n+cFxuTfppjnjXKsLF3HOZytNQp21bORZI9FUYY0mPOGupZ98RYbhd2XneSG1Jls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757679; c=relaxed/simple;
	bh=7vVjTI1IYt9Ka0X6XGELMUcgFM1rLq1eO9TLeH2zWJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=io58K5C203lTRY74DRsXAo1xdxY7kOPTsIKH/pe8h00Abp1l+BXZsOOIOzzxpQdfjcJrIQlrWMVQgmxOLJonsc2AyyredQsSpfn+5OLpLxA35FqZ4cgMIvyGHJTQiPtvzX4aES4+d2fS1FkOcsRkPvd5boPMwa/QnFjegZY92+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtnA2cM0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72524409ab8so363436b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757677; x=1733362477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W7i4MVUMNzTFsHNyUK39fhmabLo3cQhQ4gdIqXWZQBc=;
        b=DtnA2cM0EUH033fLJl81BAT1S1prxZNO05oTq8R4IEiv7Zf+7QVyQh04DAnOlg/WJn
         4Pp9o9jDpnpPmcyZJOp2JqFPLt9w5cBbHwxVqKC9vVlegjtXUyZyt8u2xtgmHeEACy8H
         agattUT+dKx3FBMi34yNQ9Nl4RpyF5QxKjQOCYzUugyj/7TeXqtpXPszqpNaHnZyq6Wz
         /QEMMrntkikCLFdGfma4deCnwOCfEN6xjfX7rAQHYoX2mwUmsMax7G/6e4BHddckNOub
         ARuTwA4U+3oJt3QMn8cN+jwW/OVIS3WXfpxGc3NOJlK3h3119w5h9ptMI0A+ZaSkvVYy
         t5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757677; x=1733362477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7i4MVUMNzTFsHNyUK39fhmabLo3cQhQ4gdIqXWZQBc=;
        b=TFtQI9RySIKKm9Q6gvv5eIGNg3DU1NIPFlRZzfmx0pQ4KHPJcMvBw6FbwtqMac4F1k
         0PCz0BdoxROsVWtaBPAQUzE9KIMhQLNFe3RI9Aog26PJ3Wfm38auz0mlQ8LnYZGJE8ws
         tNVivqQeXyliRh20T9M5r+1Y1kG+kQ/SGKIy1OWO8rjVO2DRydwixZtLFQ4oMdVi7GbD
         6CPCxJDMeWG0QI9CLcrGmAnpxfkWDCVvCUVAvKjzDvnjoP6cMzC7erUUiRkNLLXDs4zz
         zVzkyhZ+gXJ8NRJHLYAHR1EV7rjVsLv9lat0MA8NSsC93R6LuseaGyXumgOCHlF/wYin
         o5CA==
X-Forwarded-Encrypted: i=1; AJvYcCVcVzYmsJHHmRH3ek1uH2l9uDLvQqeSgprOSjbFJzxx7oC4Vi23xKnJcY241ekcchb+aodA1oEoWvCjkcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3vQimQfEgahppbFs4S5iD5f8RIDQwn6zJOdbDc84q7yXaE4J
	ZbDtjI1jFcBiJL3H33xATvvqkMrobFod5CKiyyfwG4UpGhkR9tG65tW8UKjH2RH6iusIe1oD329
	4WQ==
X-Google-Smtp-Source: AGHT+IGy2y8MpKFIGLJ8ugM1EARXHsNlb/10mHQIqOwMOmkAddSvnQGItxPJxpxt0LeckBq6k6OWrM3jSDs=
X-Received: from pfaq7.prod.google.com ([2002:a05:6a00:a887:b0:724:ed04:1c85])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:891:b0:725:4109:5ac0
 with SMTP id d2e1a72fcca58-72541095b4fmr1164009b3a.5.1732757677293; Wed, 27
 Nov 2024 17:34:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:30 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-4-seanjc@google.com>
Subject: [PATCH v3 03/57] KVM: x86: Do all post-set CPUID processing during
 vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

During vCPU creation, process KVM's default, empty CPUID as if userspace
set an empty CPUID to ensure consistent and correct behavior with respect
to guest CPUID.  E.g. if userspace never sets guest CPUID, KVM will never
configure cr4_guest_rsvd_bits, and thus create divergent, incorrect, guest-
visible behavior due to letting the guest set any KVM-supported CR4 bits
despite the features not being allowed per guest CPUID.

Note!  This changes KVM's ABI, as lack of full CPUID processing allowed
userspace to stuff garbage vCPU state, e.g. userspace could set CR4 to a
guest-unsupported value via KVM_SET_SREGS.  But it's extremely unlikely
that this is a breaking change, as KVM already has many flows that require
userspace to set guest CPUID before loading vCPU state.  E.g. multiple MSR
flows consult guest CPUID on host writes, and KVM_SET_SREGS itself already
relies on guest CPUID being up-to-date, as KVM's validity check on CR3
consumes CPUID.0x7.1 (for LAM) and CPUID.0x80000008 (for MAXPHYADDR).

Furthermore, the plan is to commit to enforcing guest CPUID for userspace
writes to MSRs, at which point bypassing sregs CPUID checks is even more
nonsensical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 arch/x86/kvm/cpuid.h | 1 +
 arch/x86/kvm/x86.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index eb4b32bcfa56..b9ad07e24160 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -338,7 +338,7 @@ static bool guest_cpuid_is_amd_or_hygon(struct kvm_vcpu *vcpu)
 	       is_guest_vendor_hygon(entry->ebx, entry->ecx, entry->edx);
 }
 
-static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c8dc66eddefd..e51b868e9d36 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -10,6 +10,7 @@
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 void kvm_set_cpu_caps(void);
 
+void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
 void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
 void kvm_update_pv_runtime(struct kvm_vcpu *vcpu);
 struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2e713480933a..ca9b0a00cbcc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12301,6 +12301,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
+	kvm_vcpu_after_set_cpuid(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
 	kvm_vcpu_reset(vcpu, false);
 	kvm_init_mmu(vcpu);
-- 
2.47.0.338.g60cca15819-goog


