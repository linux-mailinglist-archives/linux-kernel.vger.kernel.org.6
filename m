Return-Path: <linux-kernel+bounces-360378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712B999A32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79856B248C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8551FBCB3;
	Fri, 11 Oct 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYPMO+dI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330011F12E9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612691; cv=none; b=BMCOPzF7k+C72of7bT2laf9sZZl0CTLV5BwsT5mrPq4kmcL7mUPljCa3tzletSjbTyAX1Orwjp8TttJuZNeSNn1CrxHqPQTXztTydmQA3QXE1YgCXvgU6JYs5mcdUFrGUGtdD5ILdSBcIHpqEns2bPUgwAlUUXyFPj9GcNUs7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612691; c=relaxed/simple;
	bh=iyJm/h+JOO59f+egBKANfLu+0QMr2pI0zJeagTYRCD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQKpgBJTPS/Op8yz5LvFEx0Q9p5JtW5NZQftg6lE+NtrwE7JXC/ScfiFaC1ihQx3I00CuH2X2iLyx4UwbmDDDqdJrt0R1XwTo2k6nIlBZ6r+cp9E2AWRElr0BD1apfmTbZyCmQR0nUKmsJBOfTMllkkCS28ZVsDYRpCfJENMQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYPMO+dI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so30735237b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612689; x=1729217489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HPDDwUN824pfD2nj2HWQd9wsiBjvr8+g8+t2fSbMNlA=;
        b=PYPMO+dIz2MEJ9uWGnpzMDLoKh+UuyJIyZmNXuqbSiVOdTd214fzLaTbR1r/huZV6G
         gUCNMV6B52TgkvmtpjDNuduzkb92NtWqgasAaY+wAZYjvZ0H5I9C16O55KtJTEiAAvpc
         9QHy/RtL6SGjpF98SSBX5CaAtlaI34+Y9n5jvCtnuLGPW3j/w5bmER0tDHQPup2InfJh
         8NLMGe2+b0hFnbp0glpF33KZbnMpiOn7DpgyppnLX8VdkE3Eb2RDJQoxANgT2bQBpeTX
         hqnp3IwrCFkL1iBeNy+pL7ILktxKp96OaGtltMGYnfnPKp6V53PPQF4zzD2T5a5G9g3r
         F32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612689; x=1729217489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPDDwUN824pfD2nj2HWQd9wsiBjvr8+g8+t2fSbMNlA=;
        b=Ycyv2cUA0xGa/nYm8kw1lFcq3AnnxL6jmEK8qzKNBH32GETMSLWQnmARlFwRGu4vf2
         sRlwn8z5o7wLJptIYTtm2c0zH3oiFZbclHDEEryCzKQQCb3g+wzmIFcffXbq+ioLw5ha
         VBv2OL7u0770NcmY/kDfTsrDgNd1bhtOnKMDqtoG8vGKn5beMmt0uZSGk72GGxqp8YrI
         3Z6hNKo5f28DCoDkgvzQT+ePjbjX1euT4E0uS4nKPgn1ef09LnB9xBwsCXOh6132euES
         SsV0sLZcs+NquglqzSDKxvMrvWvnT7hUbIfURILz/4bgcWBHgf6/MA29mZERmKVxcdaq
         KmEw==
X-Forwarded-Encrypted: i=1; AJvYcCVrZRZf7N+VXE6EEfmuuOw5YykBP8wyhoOFtdhKJsD7cwoGfcfZeDvuGVjI7aVh2Co91pkXUWB4ybf8ckQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWp4xtz7PLqk70MQtCRg/CRgEeTLcsNyEN3tzaQnOzZRWZK+B
	O9tzue8J/vrX+vSPU4gcT1VfApirbm09xCxQZWTKuyPzoAC0tydD0GsjAzZhUnpScF4CfgRf5/G
	KPA==
X-Google-Smtp-Source: AGHT+IGTSYki/MPVOSXtSoZ4BErjm1NrfbNeO31MKvV+62YjjXjQGEoBGgc7gkTIPIKCnszTY2Gpwqbhv0k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:d346:0:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e291a32c730mr5851276.11.1728612688656; Thu, 10 Oct 2024 19:11:28
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:49 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-18-seanjc@google.com>
Subject: [PATCH 17/18] KVM: Allow arch code to elide TLB flushes when aging a
 young page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a Kconfig to allow architectures to opt-out of a TLB flush when a
young page is aged, as invalidating TLB entries is not functionally
required on most KVM-supported architectures.  Stale TLB entries can
result in false negatives and theoretically lead to suboptimal reclaim,
but in practice all observations have been that the performance gained by
skipping TLB flushes outweighs any performance lost by reclaiming hot
pages.

E.g. the primary MMUs for x86 RISC-V, s390, and PPC Book3S elide the TLB
flush for ptep_clear_flush_young(), and arm64's MMU skips the trailing DSB
that's required for ordering (presumably because there are optimizations
related to eliding other TLB flushes when doing make-before-break).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/Kconfig    |  4 ++++
 virt/kvm/kvm_main.c | 20 ++++++--------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fd6a3010afa8..54e959e7d68f 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -100,6 +100,10 @@ config KVM_GENERIC_MMU_NOTIFIER
        select MMU_NOTIFIER
        bool
 
+config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
+       depends on KVM_GENERIC_MMU_NOTIFIER
+       bool
+
 config KVM_GENERIC_MEMORY_ATTRIBUTES
        depends on KVM_GENERIC_MMU_NOTIFIER
        bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b1b10dc408a0..83b525d16b61 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -630,7 +630,8 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
 static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 						unsigned long start,
 						unsigned long end,
-						gfn_handler_t handler)
+						gfn_handler_t handler,
+						bool flush_on_ret)
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
 	const struct kvm_mmu_notifier_range range = {
@@ -638,7 +639,7 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 		.end		= end,
 		.handler	= handler,
 		.on_lock	= (void *)kvm_null_fn,
-		.flush_on_ret	= true,
+		.flush_on_ret	= flush_on_ret,
 		.may_block	= false,
 	};
 
@@ -650,17 +651,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 							 unsigned long end,
 							 gfn_handler_t handler)
 {
-	struct kvm *kvm = mmu_notifier_to_kvm(mn);
-	const struct kvm_mmu_notifier_range range = {
-		.start		= start,
-		.end		= end,
-		.handler	= handler,
-		.on_lock	= (void *)kvm_null_fn,
-		.flush_on_ret	= false,
-		.may_block	= false,
-	};
-
-	return __kvm_handle_hva_range(kvm, &range).ret;
+	return kvm_handle_hva_range(mn, start, end, handler, false);
 }
 
 void kvm_mmu_invalidate_begin(struct kvm *kvm)
@@ -825,7 +816,8 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 {
 	trace_kvm_age_hva(start, end);
 
-	return kvm_handle_hva_range(mn, start, end, kvm_age_gfn);
+	return kvm_handle_hva_range(mn, start, end, kvm_age_gfn,
+				    !IS_ENABLED(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG));
 }
 
 static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
-- 
2.47.0.rc1.288.g06298d1525-goog


