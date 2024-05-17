Return-Path: <linux-kernel+bounces-182447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89F8C8B65
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CAFB2405A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE414389B;
	Fri, 17 May 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xxmup4vt"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DC142E82
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967612; cv=none; b=rlaqZb6OwDYD2wX6o/T6LO+zQeG2QYn3HYcqx1n3QQ5es43LytDHJc7FIt5WV51zE7L3S+posnPTHVQlbRFt0BJJneBr6PCShduDUzh7pmRzpG01xZiXcNav4gHIEA+AufG6ZEsrYlilqwN9oE6leEMy39hpYr/6FexaySeh3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967612; c=relaxed/simple;
	bh=zRj32qdgHhJsALJpg2jyemKEBBr88t5aYQ51Nc8NJEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UIaS/UVZjBgAJPdOdFE9g82tCvT2y8FXAE/Zb8T/VWUrDOYCN06IhDlUZhhYa1ZPyXfptGb+t/VJ8+5mgbYgx+cGnAHKgTBbxs8l60MRiFVwiawChaC1u/adhOQ4gGcxj572XweYvYFGi1hzaRoqFAuBVwu3ebT2F8se4HYJ4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xxmup4vt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba0fd5142dso1871574a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967610; x=1716572410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6bzxOU8NhNsl1Y52djteXEYcFAfWB0zibELE07MjEz8=;
        b=Xxmup4vt1L/AEF6Yy7VHF+MOc47yxsdaW58uLhBl5/GImOS6xkI1jR3UKI5YMLpWb3
         bEQ+WJk7N2ca0laqE3rPlYG37/hZQZZyO2Z1EnMHjNNiMbTG00/iD0r0pgJMJ/xd0O9C
         PlpXXvJei+/NGCoqKXQuxZ69+DrGbWleDATcmKfryygy23DdaxBDUA34ym/g/yTs12/z
         cPDAosw2vKWLkpnmbQ/GF1xtxo6Ty4y1Y0v4b+siQZpEzRPw1vurS5y2NxOcsPaJGI2T
         7I/aa/zCdQnqnunzVV20zmmJEw2R5GOis/xeOxNhRi6zAktDxpjoYlqzmi6J+G7Mm4wj
         N3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967610; x=1716572410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bzxOU8NhNsl1Y52djteXEYcFAfWB0zibELE07MjEz8=;
        b=c3PaI4HJTdF2aoyYV16Xohv2yTiNllvOQ/5r5gv3CaWy9jihz+AxDu7FCxua06cewA
         Q8Y0pYcERkI25bStMTIuleA208SvaD7uJL7ST0ApD7FYCB6Amk7a0R8ZApwPeZFpivPB
         18KBng7NH48RcYdYcjh4ypsyQCmm2AW9W3LeyvEETG4jfNb0PZOOVdnGisVh7JFCRB0s
         zSOE0wKjRAI4/62SXVvOzdzvQ+4iXKEQB78z/e7gc+yzo2qTCp8yv2b/1KhmTvQaOASI
         azwdg9AeuNro4Q/awf1qJX4WvuSX1VqUqs8JiNU1Z6s4e7tBnutBuIT2V5bOHTkEkA+E
         0QAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkR02M1YAlYJUZgcaKub9igxg+0NIAe6XAgId9P2XhZfF1lfaD48uHW4Amv25aEdhFRqRZmVPyrxf+E8thww0q2IydPsfL+Mmhn+I7
X-Gm-Message-State: AOJu0YwI+V9y9wU19YXPOX5+RCaIP8trCtnvHKhE8grN74MJBJXDnRAi
	X28j4soC7MwqLdIWlcBNbSY2e/lfCO9v0GEsZN/XVZZlzptCE3Be+62J+XxhqO5lYPMHHLYk1ck
	tZw==
X-Google-Smtp-Source: AGHT+IFcLo7rDAywCFo+bppcXqC0KCOZkzjWf6sQX6YTcrUeeHqCwQvqaaQ8ZGIZSQ3h26muIlAjIduKPl4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a886:b0:2b5:d981:29af with SMTP id
 98e67ed59e1d1-2b66002b693mr113340a91.4.1715967610168; Fri, 17 May 2024
 10:40:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:51 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-15-seanjc@google.com>
Subject: [PATCH v2 14/49] KVM: selftests: Update x86's KVM PV test to match
 KVM's disabling exits behavior
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Rework x86's KVM PV features test to align with KVM's new, fixed behavior
of not allowing userspace to disable HLT-exiting after vCPUs have been
created.  Rework the core testcase to disable HLT-exiting before creating
a vCPU, and opportunistically modify keep the paired VM+vCPU creation to
verify that KVM rejects KVM_CAP_X86_DISABLE_EXITS as expected.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/kvm_pv_test.c        | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index 2aee93108a54..1b805cbdb47b 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -139,6 +139,7 @@ static void test_pv_unhalt(void)
 	struct kvm_vm *vm;
 	struct kvm_cpuid_entry2 *ent;
 	u32 kvm_sig_old;
+	int r;
 
 	if (!(kvm_check_cap(KVM_CAP_X86_DISABLE_EXITS) & KVM_X86_DISABLE_EXITS_HLT))
 		return;
@@ -152,19 +153,45 @@ static void test_pv_unhalt(void)
 	TEST_ASSERT(vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
 		    "Enabling X86_FEATURE_KVM_PV_UNHALT had no effect");
 
-	/* Make sure KVM clears vcpu->arch.kvm_cpuid */
+	/* Verify KVM disallows disabling exits after vCPU creation. */
+	r = __vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
+	TEST_ASSERT(r && errno == EINVAL,
+		    "Disabling exits after vCPU creation didn't fail as expected");
+
+	kvm_vm_free(vm);
+
+	/* Verify that KVM clear PV_UNHALT from guest CPUID. */
+	vm = vm_create(1);
+	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
+
+	vcpu = vm_vcpu_add(vm, 0, NULL);
+	TEST_ASSERT(!vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
+		    "vCPU created with PV_UNHALT set by default");
+
+	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_KVM_PV_UNHALT);
+	TEST_ASSERT(!vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
+		    "PV_UNHALT set in guest CPUID when HLT-exiting is disabled");
+
+	/*
+	 * Clobber the KVM PV signature and verify KVM does NOT clear PV_UNHALT
+	 * when KVM PV is not present, and DOES clear PV_UNHALT when switching
+	 * back to the correct signature..
+	 */
 	ent = vcpu_get_cpuid_entry(vcpu, KVM_CPUID_SIGNATURE);
 	kvm_sig_old = ent->ebx;
 	ent->ebx = 0xdeadbeef;
 	vcpu_set_cpuid(vcpu);
 
-	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
+	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_KVM_PV_UNHALT);
+	TEST_ASSERT(vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
+		    "PV_UNHALT cleared when using bogus KVM PV signature");
+
 	ent = vcpu_get_cpuid_entry(vcpu, KVM_CPUID_SIGNATURE);
 	ent->ebx = kvm_sig_old;
 	vcpu_set_cpuid(vcpu);
 
 	TEST_ASSERT(!vcpu_cpuid_has(vcpu, X86_FEATURE_KVM_PV_UNHALT),
-		    "KVM_FEATURE_PV_UNHALT is set with KVM_CAP_X86_DISABLE_EXITS");
+		    "PV_UNHALT set in guest CPUID when HLT-exiting is disabled");
 
 	/* FIXME: actually test KVM_FEATURE_PV_UNHALT feature */
 
-- 
2.45.0.215.g3402c0e53f-goog


