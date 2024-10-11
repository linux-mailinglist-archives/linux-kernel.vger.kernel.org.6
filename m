Return-Path: <linux-kernel+bounces-360361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECB999A10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AAD1F2250D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8D1EF953;
	Fri, 11 Oct 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W50wc7Wd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7E1E8851
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612656; cv=none; b=hslTV1EatN7DWQFUVmN/JPNVUVAo0d3nVbpTres5d3YS3XAiSAWSUdWDzt8fh+J1MrNBiaL0vHi2J/fYtDXzr9hA5sTtCua/n/PVTKP1g1xAIXYVW6VfM+8gaj+YqiN7KAN/C8Iu6YSTzUaUdplrFfMFoc0h8VXvhiU5iw0Jcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612656; c=relaxed/simple;
	bh=fzW+ChUdusmIA3bhbKK2k3ivftGQJ9q+cRZWuOg3AfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0LLoKeHem6NFRfhcTYVdaO3jEieSIisA/0D4KPu0JI0ol9Tmd1Y8S4pNLeHyTemiqlc8T6ZUbKJC0CDB2VyXxJK0Jsvokp2BPBRUH070/rz3VuUakP9fJvt/PlP72kWWOBLQDOL8Ho6dyQxyZupj+vXN0cgWfbkmhFcrHuHf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W50wc7Wd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so35268587b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612654; x=1729217454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OygTTCCcvLlJR5HYkc6p+scOWI8DJUkTUyIz5b+Yzqs=;
        b=W50wc7WdMCZH6equDluATzYxsEiHw5XfgROMz26kkPkpDgUX4bTjzGENrwgsKkiYUM
         aDOUpI163O3U4r6NkJZrbrQSX1gHDZaZYsCPBxJynFc9zxwwZUPlg7fICUTctp9VdrgV
         zHmJYCqbOpxveLtns16MOKvmcemENHCjbg+UWNotKBXdnLlSUlesHx/meKOha7oTeH5D
         sZ11RY3Y+NNKWFxbhJfB4Td/6L4U7azcYNqBLFIKr4PF8DF5dGjn7kRzUgRU5ROQ4QeG
         mE9aXamCaq9aXH8hLbuC+29607Lx+Rg8XT9m7TKs1Xc6V8FEG03LYjn+k0HBeFZh6LFt
         pAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612654; x=1729217454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OygTTCCcvLlJR5HYkc6p+scOWI8DJUkTUyIz5b+Yzqs=;
        b=q5j2YqT9KuMk0ubszss3PgpTMcHpBCOSjxk2YKu5s3DwFGo9l9HlS60mn+6OGSHi6Q
         GZivDIrLk+4Ry3EoUTMm6VQ46DkjQs2h/MPrG5dTzEdazJkcKEzWIbDHsu484Bi9m/Mn
         GH4A70YbOSBlfBUsB3VAc0K8pERBLCiaiCOmObArughk6zqEd7M/dL0U2ahZrJSDDdFP
         //cvqgs0KI5dQZ0uiSRzlfh6GUJPxU+7fjGrMr7VRnU50fkurMNZzgeKb+pWIGrEHpQa
         3Cp2s3BYJYHjNvBSR0gkTqQj1kdxmcTAL31RCKxEHsb6sy+8tQvft1bPXDxQ03Ncz1Kn
         vcmA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9MdG42YTGnmb+8lu7X1XSOSEG1ZfwGEg72syfDnhHA2273rSLmQHcAwgIYBlvmrybis+3SK2h22UF/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFI5odro1kG+K6kFiarDJAu+JgoAkmHPWcQMnJ9GQACO5O1Ho1
	0xjPm55Z/WsZd54rZpkB7cPqJLTmdtb9dKxrup19giUqi2uwJFbowPrt/oegIQX/6EVlvPOCKgO
	VJQ==
X-Google-Smtp-Source: AGHT+IHdRSYZ+bkxWUZczD2ZC6uRWUXF5TWEoclipxa3r0H2IwoZrfNvJ+VwB67O1mgdW36wABwHwe6bwqs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2e13:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6e347c6547dmr20677b3.8.1728612654326; Thu, 10 Oct 2024 19:10:54
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:33 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-2-seanjc@google.com>
Subject: [PATCH 01/18] KVM: x86/mmu: Flush remote TLBs iff MMU-writable flag
 is cleared from RO SPTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't force a remote TLB flush if KVM happens to effectively "refresh" a
read-only SPTE that is still MMU-Writable, as KVM allows MMU-Writable SPTEs
to have Writable TLB entries, even if the SPTE is !Writable.  Remote TLBs
need to be flushed only when creating a read-only SPTE for write-tracking,
i.e. when installing a !MMU-Writable SPTE.

In practice, especially now that KVM doesn't overwrite existing SPTEs when
prefetching, KVM will rarely "refresh" a read-only, MMU-Writable SPTE,
i.e. this is unlikely to eliminate many, if any, TLB flushes.  But, more
precisely flushing makes it easier to understand exactly when KVM does and
doesn't need to flush.

Note, x86 architecturally requires relevant TLB entries to be invalidated
on a page fault, i.e. there is no risk of putting a vCPU into an infinite
loop of read-only page faults.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c  | 12 +++++++-----
 arch/x86/kvm/mmu/spte.c |  6 ------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 55eeca931e23..176fc37540df 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -514,9 +514,12 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 /* Rules for using mmu_spte_update:
  * Update the state bits, it means the mapped pfn is not changed.
  *
- * Whenever an MMU-writable SPTE is overwritten with a read-only SPTE, remote
- * TLBs must be flushed. Otherwise rmap_write_protect will find a read-only
- * spte, even though the writable spte might be cached on a CPU's TLB.
+ * If the MMU-writable flag is cleared, i.e. the SPTE is write-protected for
+ * write-tracking, remote TLBs must be flushed, even if the SPTE was read-only,
+ * as KVM allows stale Writable TLB entries to exist.  When dirty logging, KVM
+ * flushes TLBs based on whether or not dirty bitmap/ring entries were reaped,
+ * not whether or not SPTEs were modified, i.e. only the write-tracking case
+ * needs to flush at the time the SPTEs is modified, before dropping mmu_lock.
  *
  * Returns true if the TLB needs to be flushed
  */
@@ -533,8 +536,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 	 * we always atomically update it, see the comments in
 	 * spte_has_volatile_bits().
 	 */
-	if (is_mmu_writable_spte(old_spte) &&
-	      !is_writable_pte(new_spte))
+	if (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte))
 		flush = true;
 
 	/*
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index f1a50a78badb..e5af69a8f101 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -133,12 +133,6 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
  */
 bool spte_has_volatile_bits(u64 spte)
 {
-	/*
-	 * Always atomically update spte if it can be updated
-	 * out of mmu-lock, it can ensure dirty bit is not lost,
-	 * also, it can help us to get a stable is_writable_pte()
-	 * to ensure tlb flush is not missed.
-	 */
 	if (!is_writable_pte(spte) && is_mmu_writable_spte(spte))
 		return true;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


