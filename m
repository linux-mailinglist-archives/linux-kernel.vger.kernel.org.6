Return-Path: <linux-kernel+bounces-424117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520E9DB0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8982280C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8213FD86;
	Thu, 28 Nov 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+1ZUj7n"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9513B780
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757683; cv=none; b=LDsylOHFCbc/BTYikA/a7rOqD52FhX7A0l3UKd7ujnAUahR4fP2BFc5Wx4WI5JKBDm1//keQBO33N29dkR/qw/0mi63uXB9g2olB5G5bVHR7B79jjeeXrQL80XkXyQoHeaVBzETheMmuMjwzVdp87TJG2XkvICvzUypoYspR2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757683; c=relaxed/simple;
	bh=0JfgxpdrupIaRnl7kC2dOFPwCk6+xhe6f1i1SPh5VQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIoh94UOLT57hLoJMtJy6v5A7IphbP7MkJgXtIeRmQ5CGABlmLCyZBgZXPpHT8hmnWONApDICv1ZF/lM1TaoA/sibVYu4Klxs8XQRDKJpO561HjjSJkO5Va5iKIZT4Ank8uT1tQdU6CzsNl5glUYiXfV+zz17OSbsch2me4Ne2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+1ZUj7n; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f71e2fc065so254831a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757681; x=1733362481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jXmvhxEmqHLmptmFrlYapwE2GXQS0ioWcRCpjRVCiP4=;
        b=B+1ZUj7nxYcQPdPxX6cIe8EQZmv3QiuKpXyoF7gQ7jOPhRJpJQcFUAIjjeX0prayIJ
         LYPOanroS7dG26Wz/p7NKGz228o8PgyyrhRYOHvy/efs4oeqg5e1E6FcntQDmpzsOzFZ
         Quy/9m5jzpRO6drQ0TzB0/7IAWrMjLOydXfeFXFETlyEKpiUvwVR/6ZFZkRXrKTkkVdb
         4wRYXrTfMLRVZrwVbn1hpLCbY4JKyvrjhydHaeNDAVt7AYrnWv2djd4qtU02mIjmOLSZ
         iIh5zRYyGKopORv1OL7GYdirYgzEH1oz50wNBXWSg9MFdRNnqEeCxSve1g6Wz61QlBc1
         roGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757681; x=1733362481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXmvhxEmqHLmptmFrlYapwE2GXQS0ioWcRCpjRVCiP4=;
        b=nMNKtcC/Aeo1c0HffYbwx3jfB1GWXmV6r6sLelMG/jbOmveIEy8yDrN4nyWHGmSDc7
         0GX6pqbthsgo+bEKlaHBlORRAxxS1duQLAcUmIFsuqWrj7K03JJT5XkYs6DJ6E+vM0rm
         6csJlxMtQzAsaJg5SvZZ8Znq5iK1VmxwhWl71iJs1k43miwRFVXdFbH3Tt+aIJvgo6ai
         xDw8YghVW8n0BpN+gP0XfdhMp3vS3pINvAO8/Ymmods8s7h3bKHWP5BT9XyTi9z5j0Dx
         YjeDFhRX1Hb56sLgYJONwZ7R0OXsnNd24t0cK/nOgBaWjFYFmlPL4hjKod+onPjk+BQi
         r4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXo3DUbGa/V9IL7wyvwvNSro1AoocYWVuY+Nn3TEHWjZHTSonk+PmfynYcLNYRvM+M72FaSXtLwNQTKL2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpfr0uXGW8jexZjB8pnivypqpjtAao14DZ6EhsqcgZ+1GlnnI9
	9QGWWTVb++efE+d+4LK9KaRngwt9cCq79YtmxpERadCORRDhgnPVXO/f1Rw9T24Zb3i7pGrvIJ/
	8Nw==
X-Google-Smtp-Source: AGHT+IFQhFinpFVGMQCaQ+dyl10TAppaguaY+VdZfxJxAIk1wFY127FX/WZeqzKczEacxeO44YgSxWQsq5s=
X-Received: from pgbcv2.prod.google.com ([2002:a05:6a02:4202:b0:7fb:dc15:be43])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:39a:b0:1e0:c3bf:7909
 with SMTP id adf61e73a8af0-1e0e0b8d0ecmr7963436637.41.1732757680762; Wed, 27
 Nov 2024 17:34:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:32 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-6-seanjc@google.com>
Subject: [PATCH v3 05/57] KVM: x86: Account for KVM-reserved CR4 bits when
 passing through CR4 on VMX
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

Drop x86.c's local pre-computed cr4_reserved bits and instead fold KVM's
reserved bits into the guest's reserved bits.  This fixes a bug where VMX's
set_cr4_guest_host_mask() fails to account for KVM-reserved bits when
deciding which bits can be passed through to the guest.  In most cases,
letting the guest directly write reserved CR4 bits is ok, i.e. attempting
to set the bit(s) will still #GP, but not if a feature is available in
hardware but explicitly disabled by the host, e.g. if FSGSBASE support is
disabled via "nofsgsbase".

Note, the extra overhead of computing host reserved bits every time
userspace sets guest CPUID is negligible.  The feature bits that are
queried are packed nicely into a handful of words, and so checking and
setting each reserved bit costs in the neighborhood of ~5 cycles, i.e. the
total cost will be in the noise even if the number of checked CR4 bits
doubles over the next few years.  In other words, x86 will run out of CR4
bits long before the overhead becomes problematic.

Note #2, __cr4_reserved_bits() starts from CR4_RESERVED_BITS, which is
why the existing __kvm_cpu_cap_has() processing doesn't explicitly OR in
CR4_RESERVED_BITS (and why the new code doesn't do so either).

Fixes: 2ed41aa631fc ("KVM: VMX: Intercept guest reserved CR4 bits to inject #GP fault")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 7 +++++--
 arch/x86/kvm/x86.c   | 9 ---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1944f9415672..27919c8f438b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -400,8 +400,11 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
 	kvm_pmu_refresh(vcpu);
-	vcpu->arch.cr4_guest_rsvd_bits =
-	    __cr4_reserved_bits(guest_cpuid_has, vcpu);
+
+#define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
+	vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_) |
+					 __cr4_reserved_bits(guest_cpuid_has, vcpu);
+#undef __kvm_cpu_cap_has
 
 	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu->arch.cpuid_entries,
 						    vcpu->arch.cpuid_nent));
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca9b0a00cbcc..5288d53fef5c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -119,8 +119,6 @@ u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 #endif
 
-static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
-
 #define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
@@ -1285,9 +1283,6 @@ EXPORT_SYMBOL_GPL(kvm_emulate_xsetbv);
 
 bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
-	if (cr4 & cr4_reserved_bits)
-		return false;
-
 	if (cr4 & vcpu->arch.cr4_guest_rsvd_bits)
 		return false;
 
@@ -9773,10 +9768,6 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		kvm_caps.supported_xss = 0;
 
-#define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
-	cr4_reserved_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_);
-#undef __kvm_cpu_cap_has
-
 	if (kvm_caps.has_tsc_control) {
 		/*
 		 * Make sure the user can only configure tsc_khz values that
-- 
2.47.0.338.g60cca15819-goog


