Return-Path: <linux-kernel+bounces-535268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961BA470C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6037A740B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A714F9F4;
	Thu, 27 Feb 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhA9oCje"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC124B28
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618816; cv=none; b=OTjwUhxgy3NhcHqJB4zKP71f6sTXuvIK6y7Lsn39lJn1bEb1fB2A9DFd/un8jnEBA8LBsvE1xSsY7akvjWxU4hLInlXG7D0KuS+Udn2SYV5yt9kbMh0m7SykRlHILyLribd5XUoGMnlI0ELQRZibZaV4sMT3+cIiDsJs4e2DJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618816; c=relaxed/simple;
	bh=uaIIITJgUawWH54PuijoRuV64Rx6tfBFy6BV8graBMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=odi7l6xSTUeZphzFHieS8NnUXnI2PkUyNntleUME4z/V81X47oL1sjqODcLVBObz+iPY56YRzhv9jCcrramc6XJnEiU50igD9PrUG43oICh2XherCdurWa6VUxjXndPQXDkB6UKXYUx6YADOfk0p9yuH3aDi4C2JqDmpBZcKe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhA9oCje; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fea1685337so686180a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740618813; x=1741223613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4G+4qHSVJnaTG8aqakqnf5oS6XZxipCyWxhYCrPdMqU=;
        b=BhA9oCjehr15kGno0LTWWgc4p7eaPwWB3ylKyIhJDsPOoSSo+zFz+AK/6AZyNeXRSr
         Pvg74JXDg0cn3tvXX735xyTlfWjdwe7UvTYmoXPuf7TokuwufxBJWYmw5M3OJpJdNyEi
         qdtsE0yIaY55kKiJeQvv67xopm8b8bUpRyQM0nA5vAqD2uTsFYJMHz0Ov5ddi+YV8Ain
         KGphSBeyL7WEvWFE/1rFUhsCKQQwFz9H5rs50jooEh92bZsw7nz8C4tf31U5Xj7cP1Hi
         6f12bz4MsVgGethfBv2hMQkd/YW6Z5OzIi0rvto4jGsR3gVb2EJKwngdRqes3SLd09X4
         hC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618813; x=1741223613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4G+4qHSVJnaTG8aqakqnf5oS6XZxipCyWxhYCrPdMqU=;
        b=VWBZPtO2zVhIcUmDz8mpUDucmAaoYFZJr+5QiIWXDZuLDbdb98p2WLImAgEWLdkLb7
         rva6JA1psv+zbQJWIsby5RKX03y/HmxCSeBlo19sblDe6Gh+6cOnOtfRRF/blMslfJI9
         Qa/oyyXIAFLy6Hwa4O7jTmVho172dUlEsDPsdh5ZGyePYaLBqYwxu8KdEgNJ9OTI5m6N
         4m0P5Yhq3gJxwtkqVLNY6hWqIcYK5x3cpSns+UIt4w8OA1QX9o4zRxf5HU43MJAqlxvv
         BbimIA4yFRJvf9o0yPDXaQanN8vO7WFDQgG0qCnt4Ec5dUHQtrNcqYfeHXWMh6CwmshW
         aiCA==
X-Forwarded-Encrypted: i=1; AJvYcCVmjm4fhTqI9l0argTlDgwq98VaXOBmKfN/i6UNwcvzfwwlTc4WLwMbqydh43DKUmwU2WkrNjddgfR+PS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ59lrHYeY7vyL9Epe/6KvX3cSQrkONTTFBTpZI4ySiMN6xfzv
	3/tVf2dzhc5j7ap9UBQHcpt4e+9N5TvZ2se+N9qCRwmbTFe63TyicP8Reuu63Aw4rUGp54LjenH
	S6Q==
X-Google-Smtp-Source: AGHT+IF/0LojBvPM/mubJWQkN9zSmVziqMW9oNei9YATA6U+yuMtYGUbUTWyWB3moXPOEe6/3bNIOyIL5jQ=
X-Received: from pgbdq17.prod.google.com ([2002:a05:6a02:f91:b0:ad5:418b:c301])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:8402:b0:1ee:b5f4:b1d7
 with SMTP id adf61e73a8af0-1f2e387ef46mr2042905637.7.1740618813467; Wed, 26
 Feb 2025 17:13:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:13:20 -0800
In-Reply-To: <20250227011321.3229622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227011321.3229622-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227011321.3229622-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09c3d27cc01a..a2cd734beef5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4991,7 +4991,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10984,6 +10983,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.48.1.711.g2feabab25a-goog


