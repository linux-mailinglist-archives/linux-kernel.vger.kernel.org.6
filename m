Return-Path: <linux-kernel+bounces-417368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387B9D5312
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15F91F20F78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F541E1A28;
	Thu, 21 Nov 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxqjqYcC"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81B1E0E0F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215223; cv=none; b=I1ezD/u7mnjqR0uAsDm78qELqmVisf99d97z5QOcs3oQ+r1UnN7RvgfMog2lSU9BrL+8Qlg5bwRK8IE7a8RQvvrWewu9waDXbDG4GGom5phCm11++dtCTVa93KwtFeGCCNvLvZ+t5Op2xuk7PG7nv+6tgFKNV+VwtTvlTkHYMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215223; c=relaxed/simple;
	bh=Ia47x5eqWq7m7XvirgYoICFMCzP4YkrxFKv1nGHdVnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sbg/Yvc8PGfBROYb0Y2jeb5QVxbJX7L0JU/RVNKoEdy88sOR9wNsBzRYfHiAQHnF+LucnH8mjuo6xcx1f0kRR2uPYxdDiMZVfoNJ9/JtfPhD/FAGfKbfyEICXH2BqLxTfOEtikc7Rz9MsFN1fO+Amdv52GnzwQc39ys3HzgnpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxqjqYcC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e479829c8so1398955b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215221; x=1732820021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=czlM8Zx0msme5nVYY+cCt41KVQO5hp+W87Vv3EaE5IQ=;
        b=jxqjqYcCi+rUa+jljXZFhrQdsgiFX7otgcaea5xbORgCs6gWKLMtNhnNcr6HQlkAM/
         noAegI58v52BYubQxXYqmu9Ck9AfQltrx6zLO0GXQCpYZWAiUnLiVD+I0tLC9+Ggo8+/
         dJ4iPIkhC2WnsWgs+WEAiCwYJnjLF8hQ6HYViXEfpD67xp/elLpmW4spu3Td+aCy9UCH
         9I8ZKExSwpxtbDwtECU9rJmwnTrwvpsYO8ROvSclTlToS5ugWUoVlkdT4QTi4LGoe01u
         YfOUILvHKa+CsSQF7yAOhEOTzg882/yDZyF3GCw5y82qpSgs/G7ZrDWgAkZGoZEGgNai
         KqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215221; x=1732820021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czlM8Zx0msme5nVYY+cCt41KVQO5hp+W87Vv3EaE5IQ=;
        b=SE/uZrgSien7Rg/JP0+eJjvGBaHN5ZSkh2mBieVlj0enMe3wu7mlz7H6hz7HWYvz5i
         VTjg7htpTavfgVMDepWObP2HolDyhxSItV8EymT7He9Y1WjBa8JhcCLJdZTkf1sqL/jL
         q5TULdzvtnAgZoyBu0ETZjiGMOnZwjrGT7anDhdArNLFPVZZtddNe5P7XoMKvjXObG+/
         A67F30CqGFvpy4c2t00tVPvs96lbpKpXHSzSPXONZNRcLF6ntPOmb9JARidaS/L6PyP6
         I2HfAr9ydWZVHEj8MWkIQEnfuM3eY/6wGk0DT3PU4WIAR5bCftO7yy86j+QF4xtLARnb
         ktnA==
X-Forwarded-Encrypted: i=1; AJvYcCVp4+g56QtUHRb5YKTXPIzhcVIYdtMCtQM60ICk8nhBQgfnQCaUYg0U8ftONTcvv8SafYpHQmHoNuwKAD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKP6KvFuGKgXELG0KkzVspmmchKAxNSybOVmkC2izFZuGe0nL
	P5FXCVwlBGGoMon65VDTAzPUZYiUNX7O+hObqTNMHX0xApicQsN6YttGqzZm9LqjUuwdklg42U7
	whx0SDg==
X-Google-Smtp-Source: AGHT+IHuvV0WxRsObLmAMkZqtAMSt8mnH4jrgbXi7VVFR03pnbqw7dTGWT6Ax0Ujfs7YRaBjuYhmpaT6B+nG
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a62:e40a:0:b0:720:2e1a:de with SMTP id
 d2e1a72fcca58-724df5d10f9mr87b3a.1.1732215220806; Thu, 21 Nov 2024 10:53:40
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:05 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-14-mizhang@google.com>
Subject: [RFC PATCH 13/22] KVM: x86: Load guest [am]perf when leaving halt state
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

When a vCPU transitions from HALTED to RUNNABLE, it resumes time keeping:
its virtual IA32_MPERF MSR should start accumulating C0 cycles again.
Load the guest values into the hardware MSRs for direct guest access.

Background cycle accumulation is unnecessary at this point since the
vCPU has been in C1, so the guest's IA32_MPERF has been stopped.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b914578718d9c..acfa9ecc5bc36 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11204,9 +11204,16 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 
 void kvm_vcpu_make_runnable(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED ||
-	    vcpu->arch.mp_state == KVM_MP_STATE_AP_RESET_HOLD)
+	switch (vcpu->arch.mp_state) {
+	case KVM_MP_STATE_HALTED:
+		if (guest_can_use(vcpu, X86_FEATURE_APERFMPERF) &&
+		    vcpu->wants_to_run)
+			kvm_load_guest_aperfmperf(vcpu, false);
+		fallthrough;
+	case KVM_MP_STATE_AP_RESET_HOLD:
 		vcpu->arch.pv.pv_unhalted = false;
+		break;
+	}
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 	vcpu->arch.apf.halted = false;
 }
-- 
2.47.0.371.ga323438b13-goog


