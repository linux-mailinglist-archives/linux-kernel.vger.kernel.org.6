Return-Path: <linux-kernel+bounces-309609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79513966D63
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F16D1F24940
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBD15A4B3;
	Sat, 31 Aug 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mfp6PDTM"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BE11712
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063385; cv=none; b=HGMBjuRt6BliyIBA80InImuz3vp/z61o7ovKoslPmKO+YgpDdj0ANgzzAYP0RlM75cC1epmztBNnyzsSeNwwuixBYVnK9F+F5lPTKvOxDVNjhrCNI9XAVF+ddpMCIp4wPi6XRNwJNuVcS8SDopYByWUWQZRvtf6aWlwyxoXPp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063385; c=relaxed/simple;
	bh=0jH6aGUfJ6nXVSowsfjSHGcTxPjzpE2W+Gg/9Z921x8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lKv5SEM0x6yBdPqsaRJsAt/stUKp52sPi8czfAFUOeIiAOK6Cs1XcUhloQyBiknuO5ZvgcILJ/vUJxbb3rqLvA6PzEDOI8ZM7NdGIIfLAr73ocbOjyF1m3SnnLRyAjMylpaqCqaBSlvOBch/alzfiMZsitVCTUzqQcjAHXAGolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mfp6PDTM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd93173175so1272721a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063384; x=1725668184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DYB5QhEfP12JFKsEt0nbZ8L014oKTm3YJf7/Et6tdYI=;
        b=Mfp6PDTMjZtwF95ui7Km+FWChJKeWWZT+yE1ZWOqar5RRPsgXglDh7YnKZ8e1tUCdS
         Z1YKJw9s4gmLmacMPNxmIhhSyT91I3w6EkkD2HKMwaE7/HIzS3PBsPXgR2lT6XllzoQ8
         wy3Um6tjd+5x7vh+J+57J0YS7Ktjjb9LAhZ5IoAJTjg8VqN39mTZ1j9F1xHU6dAG6qXj
         jsHPOd5/6GdpTV0ljohtsWiuZFd4PhIs1NZkBrHGoJznxYKVXI2cB4a3iScfLu5d/IL6
         i7fvHI3HuFxjj4PWMUTAVXp2o2vMJlhLhD2c9Ge0hhVi7xnIF5FVkhl4LnqK0njd1jCj
         0HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063384; x=1725668184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYB5QhEfP12JFKsEt0nbZ8L014oKTm3YJf7/Et6tdYI=;
        b=SD2xWnllXQG4XENxLqIxGSQDk7tpEL3qdhB6V51oLwGZYSr1fiL7GkcIukpqRF7Msl
         HWbuxc4ypAV76FG7RmUL3DzkTbDaKsedRPmYlKANMkC43+uJYF3C6cFJpxYDtubzb0/k
         G8Gy1gIBrEpzjzIuUpWoDaLge3pLQ30XGB7DIyCZXmJ7Gpke6VK/3dEdNsEkYUg/aAri
         XMUGeRQZXT4+edUWEAMXXbqHJaYdHsduAkOgLTTcVw8TP3SyX+8o5tgJEA/Gsyr6Xn1E
         qwrUhUbiRdkWtjVZ1jsQooYtoCtJt6XiMOY988PDn9ooW5k/fbyDQPh8+US6dBNCwoue
         hhqw==
X-Forwarded-Encrypted: i=1; AJvYcCXR/SDHKEtiT+brz5pg5cFHBwnS1FmyQgh1wqabHEa2S3866crCWHGR7Pc/yHglxDbFfZxaTXVMhgTxQVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAtmw8PIJ+AcK0+QZQCFnzab3ULGe2anyvyvL2lZxKFyfWRXN
	V6nCW0oRFtzqxPhOpMVYIFCS0fqJjzeUoczjjTHQB1suEzGg3HWYdBV/fKxECbqSa7dU7BAhIvc
	W4A==
X-Google-Smtp-Source: AGHT+IG9Caf/Ygx0zgVnN7lUuRoljiEi/rAgaAN7Ize+jtz+IuGMkKmmeQheo0RyBKXbT93DJK9xVvlhHb4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c7:b0:1fb:716e:819e with SMTP id
 d9443c01a7336-20527669412mr2026595ad.4.1725063383865; Fri, 30 Aug 2024
 17:16:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:36 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-22-seanjc@google.com>
Subject: [PATCH v2 21/22] KVM: x86/mmu: Detect if unprotect will do anything
 based on invalid_list
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly query the list of to-be-zapped shadow pages when checking to
see if unprotecting a gfn for retry has succeeded, i.e. if KVM should
retry the faulting instruction.

Add a comment to explain why the list needs to be checked before zapping,
which is the primary motivation for this change.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d042874b0a3b..be5c2c33b530 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2721,12 +2721,15 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			goto out;
 	}
 
-	r = false;
 	write_lock(&kvm->mmu_lock);
-	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa)) {
-		r = true;
+	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa))
 		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
-	}
+
+	/*
+	 * Snapshot the result before zapping, as zapping will remove all list
+	 * entries, i.e. checking the list later would yield a false negative.
+	 */
+	r = !list_empty(&invalid_list);
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 	write_unlock(&kvm->mmu_lock);
 
-- 
2.46.0.469.g59c65b2a67-goog


