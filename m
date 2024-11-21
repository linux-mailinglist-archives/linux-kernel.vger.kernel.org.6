Return-Path: <linux-kernel+bounces-417372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E69D531D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D27B280CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10171E2319;
	Thu, 21 Nov 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Q3vNv8L"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB31E2311
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215230; cv=none; b=fSUj9NytRHRN+XbLRJahrZtzHsoDGbD7DRhdDh8v4R4eApcxrHZRC1jZzJZwKLBUFqAt1BjkE1ct6NDxW1tDDFGi6xqW4lZk0vZOU0Q/DQ/bg669lSmBEPVERKSAz+Mg/FNtWe90YkzLAaX1n17Ewy0b74ges+lX9MacjzTalJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215230; c=relaxed/simple;
	bh=eHXZPCixs0Kp9lb7wTpd1eAC5lTE/wHduYYezTPcltI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FHQ5tWkNw32KA8yOQASNOjAMmI067o6dXTpuTMy7tyKodAYlhgZ7hDCeaWRDoBQpWBASXgoK9uTS2rAOy7gpkN4G6TOcOMzoJVWIPAZir48FtqRtJn4bKY3X3xBbdUf1KuHoz/8FRjQ5InstAjjaZOn+RElcUVvDSy4ZvslraKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Q3vNv8L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eebd4e7cc5so14918397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215227; x=1732820027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S3ejUU/7aVBo5O4Q0RNsvCKZVgKY1XQah2zaS1IN8Y8=;
        b=2Q3vNv8LrR2WteR3PRdx5a0g0bxBUBMmsz/1ptNtGsXDSdQHBv8If8DdkSLHMCr8mK
         Ryy8n1eERwWnj6OGFjS7EuhJNu4Lu0eflomgCC62OJ4pNP9W9mmGSTrCG8qJ21UQ0m/Y
         XtT55v1s0frhm3EIGGYIDTD78wCmIWP4ukINQpSHy3okwpTGqBIaB0H1H2/fRL4EEj+Y
         XOE1UEIUFcaVlo7oZe+dF1sx+pXzgf3u5j/YTxG5LJ2r9upJTt6YmU/fXmMZAwWZmB7h
         OGvbPHgdyMQCFxnvi4BTPas6DrTmZ7rHKPG2Ag/wbrsscOjyBu1GDIaWbNPYyWFeml/p
         B7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215227; x=1732820027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3ejUU/7aVBo5O4Q0RNsvCKZVgKY1XQah2zaS1IN8Y8=;
        b=NhSmKKXpgRj87wZ5HBmFQTAFHzoU7o0/TGmgK3cm/1fe6ZCrmjg1jaL1MilaTlbZPl
         TsEpf85cUUfK212kuIwL4aDuPtdUlx0d7rhnAaNBE9kYjiY4Twm738VmM5+UOZM7215u
         pt95ZdyRX1Z078AC60ZGhaiP0bBS3LH+4e9n8JR+xpTW3EHvTW8Revf4E6DA1FdqegxA
         x/i66Yl2aqbYE1wRi0u+Fb2LGaqcBnW2CRFg4tHuutSEVAZbqUF5uQg9Exn4ssV8ToCU
         GXQ+TwNIneNgEzmTaumCJlFfNEz8RBTeqwx2dwqSRjyQMj81y+14VTW9t4+hvRR0lxFS
         lm9A==
X-Forwarded-Encrypted: i=1; AJvYcCWjNXPM/EaAq4T0PMnppmopgDozp3TUwdhM2rDPnydVLOUNOTQVPQ2CF/15SeTHf8X+DV3kGt4ynHy7wKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4z5yPei90+saWklaj1TrfNBmkM9VDwsdE+8MjEqts1b5DBKXW
	jAeWqy1uBfOmFst40jqpaX9jBqa1FfxKr8XkY6LGieT3jXBFx782IMNeb1sVpkeQGyiShDIoHWI
	vp6Ykvw==
X-Google-Smtp-Source: AGHT+IFnZhLdaAm9Iv4V2heWNMD+AOPfEaQHbFcWJ8d4iuBWsqxwVlNaJU/yAnomaTfOoVWSEqQuOYrN36SC
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a81:a742:0:b0:6ee:a2b0:a803 with SMTP id
 00721157ae682-6eecd2b215emr527207b3.1.1732215227332; Thu, 21 Nov 2024
 10:53:47 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:09 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-18-mizhang@google.com>
Subject: [RFC PATCH 17/22] KVM: x86: Save guest [am]perf checkpoint on vcpu_put()
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

For vCPUs with APERFMPERF that are in KVM_RUN and not halted,
checkpoint the current hardware MSR values along with the host TSC
when unloading the vCPU. While still in virtual C0 state, the vCPU
will no longer run on this physical CPU, requiring different handling
for each counter:

- IA32_APERF should stop accumulating since no actual CPU cycles are
  being spent on behalf of the guest
- IA32_MPERF should continue accumulating cycles since the guest is
  still in C0 state

Later when the vCPU is reloaded, we'll use this checkpoint and the
host TSC delta to properly account for any "background" cycles that
should be reflected in the guest's IA32_MPERF value.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 793f5d2afeb2b..7c22bda3b1f7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5173,6 +5173,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	}
 
+	if (vcpu->wants_to_run &&
+	    guest_can_use(vcpu, X86_FEATURE_APERFMPERF) &&
+	    vcpu->arch.aperfmperf.loaded_while_running)
+		kvm_put_guest_aperfmperf(vcpu);
+
 	kvm_x86_call(vcpu_put)(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 }
-- 
2.47.0.371.ga323438b13-goog


