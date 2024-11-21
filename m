Return-Path: <linux-kernel+bounces-417359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744AE9D52F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD93AB2731F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D91DF723;
	Thu, 21 Nov 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l64VzQCS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140D1DED75
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215208; cv=none; b=iKhgHz9iKoF9Pk4pCGJfd0UJePrih5/oBJoQkuYDNS4BTJ6RMzW7dKybmiwic0HWdIqNA+n8y0qohf42BerxmA/W2+H7qB7LA6gWR5NNipdRI76vYuMt6iPEJbrm6jAjyjgZnQwmIWEBzE/qxZ+qPpUE413tuIW+uEc7oXWSz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215208; c=relaxed/simple;
	bh=3LJNuc0FG7aWLKpUxqt+8FC4Sp0enBCrekTBe7yW4mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cb0y6eG+CGwCmEjbJ/o0PBsjLTDAQ9CE/aN8STHFAYFtP+khlE79yheRdR7UQEdzrssBuRd7TulkoMGR/K1B55mvBcNTtt9ypZuGKx3CQZaoUef1LA0Oa1oWwCitVJKxM/mUdQJHDauO00g0mX6cewT8KXDqLw3bvRpVa16+j/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l64VzQCS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3891f31330so2151909276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215206; x=1732820006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ldqdeENXrKnhWpzxrOZizNypt8qWrYQwaqWYe/ZI/p0=;
        b=l64VzQCSX2OGlNkHidG4Pt0qBFrGyhfmGmqFscUPYgRZrBHVwS2wJBbjwAqfSJHbv4
         7FMXsJQe7DBkkWaISjT4x+emou5wWjmt0KbUpdc+75o11v82JsUY2Neng/yY+aK2/ocK
         Oiv41CxvMpdKI2YmThz9ONdy0ssCsYSlKW8+yu17WxX87ptRT8ELRSG2lTEiGoKW+VRF
         uAfHfNsS7yPNWf41QnXtJUxHbZv6CWTWMmjmZoRcEdZrNE/K5alA+WvtZS/RXhxlhbDk
         uSBj58D8fMVYim0FigXRUgoQ8SQAOz4C2ci/Q8vUOlfBrXWO+7nTgLQGHV2OEvSVwUH4
         ngyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215206; x=1732820006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldqdeENXrKnhWpzxrOZizNypt8qWrYQwaqWYe/ZI/p0=;
        b=A7b00Gy8HnjaN0yJHizw56yHtIB5RLEgtn3SG5uFCw1hXjP2E3EqMTSY9k2mXDvSNt
         j6caxh00JqoaEexSG0Vjo7Bly5l+vomjAScWOAbq+j7NyTX9pKOY/723SkphRHYGEtf0
         qASJu9GA1/xidg7f2Vo0aBCvF2TIcXNUtAtGyHH4G7FVdeL+/ptuCaxvnFGFLBAubKyK
         krMcGIsBzFEc8KZVP1KoreGQEvlL5+nzqQ9x3PRuZUtxDlVh/JM0Wfv23yr+N9NmAa60
         qjXNV/A4QbXOP9BEOWGWgFzAOSXdJQUN1WVXzHUnKAuX1Cd72e/bfLlRTjIiJXVYvSNK
         vKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZLO70+dzVEVQFlfGerdq1Xc/zAZyX1a58To4izRo99gkgL/h3MwihV9nURmjZL8yiKjA0MxeqHgvAmrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuj14Hb2geApBGiOqTgElHwUGLvwyEIOCsDNoHLAT255UXgeXl
	g5C4TrqTMTh5Zd7qmz5pLjjk8xjYY57THgTlFPWsVrl/AU0KzD26l2TZZ41CtP43n5etlDvdviV
	5JI++Cw==
X-Google-Smtp-Source: AGHT+IEvgJFcwcEy1VprydexSjluVe7GGGLSwDWQd6+6WjkEkzi4dzVs6HiLRuow03gjfWhDHnT4jtN61JUj
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a5b:9d2:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e38cb546a8cmr7249276.2.1732215206128; Thu, 21 Nov 2024 10:53:26
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:57 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-6-mizhang@google.com>
Subject: [RFC PATCH 05/22] KVM: x86: Introduce kvm_vcpu_make_runnable()
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Factor out common code that handles the transition from
HALTED/AP_RESET_HOLD to RUNNABLE state. In addition to changing
mp_state, this transition has side effects (clearing pv_unhalted,
apf.halted) which must be handled consistently across all code paths.

As future patches add more side effects to this state transition, this
helper ensures they will be applied uniformly at all transition
points.

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d9f763a7bb9d..04ef56d10cbb1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2283,6 +2283,8 @@ static inline bool kvm_is_supported_user_return_msr(u32 msr)
 	return kvm_find_user_return_msr(msr) >= 0;
 }
 
+void kvm_vcpu_make_runnable(struct kvm_vcpu *vcpu);
+
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146fc..3c6b0ca91e5f5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11167,6 +11167,16 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_running(vcpu) || kvm_vcpu_has_events(vcpu);
 }
 
+void kvm_vcpu_make_runnable(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED ||
+	    vcpu->arch.mp_state == KVM_MP_STATE_AP_RESET_HOLD)
+		vcpu->arch.pv.pv_unhalted = false;
+	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	vcpu->arch.apf.halted = false;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_make_runnable);
+
 /* Called within kvm->srcu read side.  */
 static inline int vcpu_block(struct kvm_vcpu *vcpu)
 {
@@ -11222,12 +11232,8 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	switch(vcpu->arch.mp_state) {
 	case KVM_MP_STATE_HALTED:
 	case KVM_MP_STATE_AP_RESET_HOLD:
-		vcpu->arch.pv.pv_unhalted = false;
-		vcpu->arch.mp_state =
-			KVM_MP_STATE_RUNNABLE;
-		fallthrough;
 	case KVM_MP_STATE_RUNNABLE:
-		vcpu->arch.apf.halted = false;
+		kvm_vcpu_make_runnable(vcpu);
 		break;
 	case KVM_MP_STATE_INIT_RECEIVED:
 		break;
-- 
2.47.0.371.ga323438b13-goog


