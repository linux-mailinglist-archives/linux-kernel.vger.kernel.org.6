Return-Path: <linux-kernel+bounces-218324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE290BC93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6E81C21F21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33019A287;
	Mon, 17 Jun 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYMgxtG1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877981993B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658286; cv=none; b=iixzpE/EB0qA5qtTONkbjQtgK0IeadChKR3nwTAro1NoSXBUt76np5KRFSYVryHBn7YZinzhYOh/heCxyRYzDe6kVmlgxDaRmt7eiDt3dbGYr1TtURNcWQsjBKmCrzduzgM4nLbTVxj/EPXxDLwKHcVyd+q8yKau0e6eR04WIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658286; c=relaxed/simple;
	bh=abcNN6/yOl1D2N06tiJ3hT0s2jLzDjcN7nV9gnKoViE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hikzASWJYfNJSV0jmtA+b/uTkSaQrxxfRURHzkcc510jKCFVhDdS7IU2iWDPYD2tRc67YfxZ9WA0xm9zDC/4fDP8tvMTGUugnr2vMMnWQJ3i5ySdwrAAQr/N4MoOCqwQLnN5v3vFA0JzcS5jsoGBFSIpTFQEQEceUimLVNlACHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYMgxtG1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-632588b1bdeso59847907b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718658283; x=1719263083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+W/+ANKl6aDY00ytIycx9vklTfPR8Zq4BBj+gxYemOg=;
        b=tYMgxtG1fxADn2T9ChLOoUlEIcv4hZIyXdgj3JvGK/sE9J92R8Rg2M+L6E3FAA/ZDi
         aMInrbnQnqZdkHRNCkvro5C3e4Dt3NUCknUtLkjKdO8dV8+lfy9HecmdKha0ZNrTcM7i
         n2XkHnInCV94sMqEc2jYZlVgtVYqx+aKO36cB3skcl188fsE83S1CMnDcKQYuHoY7SYM
         d2R5nQJ3rx38oPk8um6D07NdGeuYEmaxFMZGHWITCIUF+dG9OX6LuEjSUIYt7sc2/Jq9
         Qb9Kzl2FPqLqWYQHant/QKwZfKA3KjgYMq71HIyCx5/VzhFmiylCSnz2a8fkDhpllb7D
         hzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718658283; x=1719263083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+W/+ANKl6aDY00ytIycx9vklTfPR8Zq4BBj+gxYemOg=;
        b=Bh3VrOD60U6nB8ss8jbWs8lkP66xTHtZS3XRI1syfsx6XbZPWfTU+dOmlWybeHNbcq
         HpBHzQ+kkqLDke+0uSb98Xt0VCRfaiWqboXsPhuLJe9QAVgsnz4qhpNas4IoycCzPQ13
         fu6G2ZHR/gVyxkfOk7EhzBHJc/41obt4f/RXAiNrSrfvscJTKpwJ7b3CslahMZQZKRJT
         l2Ac1HF6uxyCaAnm1Na79UNwPILngIiOiqZCQJCYyV7wcef85+KTQDSAVVimKQCN1GY6
         gxECQsGA+Nl9t1NDIiEQw2Eo6rHgYLDNW1oA2itQGZFaHAgaAUPMZnzRYqu4uJbzxnrM
         XZww==
X-Forwarded-Encrypted: i=1; AJvYcCXcCZZGqK1Oyvf4Wm3O1zS/o75nE50N8QHJ2AEdanHs3ZIMSNr0l9WxycOAfXASLYH8NMbmUYkiNJNhqW8stwwb0sxsC9ICE8HYLHCH
X-Gm-Message-State: AOJu0Yw0VFiOKRtZBZ8dkA4KPrcj28eqQydcnth8Qx7VyUNkk07IDipt
	uZiJPNv6F+jpfu98ythgZQn4H6X3lEEx9YtppIfUVMYrMouga/0mjFjDuHrJZv9/MRrrevV4b72
	yeQ==
X-Google-Smtp-Source: AGHT+IEN6Rwwh4iwjkOFUoqjrBzVaK6d8aiiHhe3RLuNcj2xLyObA9Gk4dpr4kRqjva8iIoe6Ang/bKSdPE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b84:b0:de5:bc2f:72bb with SMTP id
 3f1490d57ef6-dff1554e6cdmr1092359276.12.1718658283661; Mon, 17 Jun 2024
 14:04:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 17 Jun 2024 14:04:32 -0700
In-Reply-To: <20240617210432.1642542-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617210432.1642542-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617210432.1642542-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: SVM: Use compound literal in lieu of __maybe_unused
 rdmsr() param
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

When reading MSR_TSC_AUX, which is effectively a 32-bit value, use a
compound literal to consume/ignore the upper 32 bits instead of a "maybe"
unused local variable.  While (ab)using a compound literal to discard an
unused output is unusual, it's perfectly legal as compound literals are
valid, modifiable l-values in C99 and beyond.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cf285472fea6..69c0dea5cc0d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -678,11 +678,8 @@ static int svm_hardware_enable(void)
 	 * Since Linux does not change the value of TSC_AUX once set, prime the
 	 * TSC_AUX field now to avoid a RDMSR on every vCPU run.
 	 */
-	if (boot_cpu_has(X86_FEATURE_V_TSC_AUX)) {
-		u32 __maybe_unused msr_hi;
-
-		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, msr_hi);
-	}
+	if (boot_cpu_has(X86_FEATURE_V_TSC_AUX))
+		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, (u32){0});
 
 	return 0;
 }
-- 
2.45.2.627.g7a2c4fd464-goog


