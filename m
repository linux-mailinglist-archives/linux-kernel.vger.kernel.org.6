Return-Path: <linux-kernel+bounces-357764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1F99758D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7CA1F22B28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582CC1E22EA;
	Wed,  9 Oct 2024 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N92p/F66"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9B1E1A30
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501833; cv=none; b=VbsEYlIXH6XVqcv8QxSLnhf/9qXwAl0TFDQEhgKflexly+49ajMabrEtoEH48P9cyMx1/LJmOh00Jp6yRBuV4JJiEpw2XUQRi4eVt3AilzwPK5GBtyEwUpmYOWy3A53R3cMFuSG6KIsM+vmd1TVWOOnWTpFor0qdB48/lxJHl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501833; c=relaxed/simple;
	bh=ck6e1+clLHvY37y71iwCVIslPuIUb7JPkmFmrD3a1sQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nbc/2lak4L+mbSeH2cs+JmQDux4XHbhpgITNTBbKSojjIuU27jEz8Vl9bedGCzpkx3Dl/cyj4gujkl4TNsUAiaSMu0nTaYADEkucihvn96j/puzyQCPmY0b4YPZM2njpvvgbHg0RZBWzu/maxYZ2gs37XQvy8RblaMx19jQTtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N92p/F66; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6a9c1a9b8so81623a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728501832; x=1729106632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fx7eMx6VVUuvVYcfbaCKh7/MSwGopnW89lun6HOpi5I=;
        b=N92p/F66PYk+rn224Up55qmHhy8Lw+Dig5dtGTJkeclaHSciaQ/gWGfqbu9lxqu8VA
         MSeaSZldHDfP5kG1DdiyQ+bPpYfb81IM7AGFUKwBUBhg+z2QVVnl/ayw94KhkGd8QTbY
         +sIO7sVeGhKGmIp/+NmIAYAHX9CzOHthqPFS261JZcfAGAWdENLWhwiDhSO0BEefbh+6
         8e64i7WvtmJ5iPxtM+OLHCUrIQU0EmYRMAKamq+H+IICO8o4sqvfib/PtXyfZ7q0dmnj
         mWhPbfXpvKJRv3DWmMvOiwjHsKYEs7/79OEeioqrMcvH7GPKk3m73faiut9DgtMMCdT2
         lZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501832; x=1729106632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx7eMx6VVUuvVYcfbaCKh7/MSwGopnW89lun6HOpi5I=;
        b=WAiBiCObhblE161vhbkFyWQnp49aW8wPQR5NEcJtQyxf3ZxQFu/AOxfkejlkuCCe1D
         zfxZi6EGIA68kIwn3qVqMIAnLXMtcpBD53HBfBIcKvnBy1slsrrpBK+JHd37/yGGPdms
         OKmezZlF+erSrnmMMFix/mowajgwm1zEpm3zvPOGDFTxfcIsOVcF57LVISFgmhuS4gSQ
         PQJqa3pExFze18Fm1FKwHxA94lTvJL7rmScl/gKM8sZm0cKbxOmhvQxNUz7jAj/r8L9Q
         +EBBRoDMrH8fwuW2qpNHTXehkwABG/Xbl2k+7HObYH2iGWE0QFTDuaLcl4qv38tChzHi
         NcIg==
X-Forwarded-Encrypted: i=1; AJvYcCVR8FBamwIc5EsFiFU+81FmAwNKOpWJBkNtAWeER03der11NL7dvK9O0E6M2oqWbnD1MRl+Kt8KjdfW+O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OwBG5o2WNZoN7aEoDNguB6YyWkUgWfkuw6rUyEs0H8jeOCbK
	txoIGNRgocFBRicDqQNidenQJzTP/IQHps2tEEtnEd1LU3OD3kat0Iz/vHjnX+BXfgfky7/XejT
	8pQ==
X-Google-Smtp-Source: AGHT+IFK05VgrJ7xkHvKexCmcT/byWx7dnDBJFxQBRnl03+WtCAsj2ptxNvLmZkLLNUb1oQXRFWnt4p+I5g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:6247:0:b0:7d5:e48:4286 with SMTP id
 41be03b00d2f7-7ea320e1a64mr3014a12.7.1728501831481; Wed, 09 Oct 2024 12:23:51
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 12:23:44 -0700
In-Reply-To: <20241009192345.1148353-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009192345.1148353-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009192345.1148353-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: x86/mmu: Add lockdep assert to enforce safe usage of kvm_unmap_gfn_range()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a lockdep assertion in kvm_unmap_gfn_range() to ensure that either
mmu_invalidate_in_progress is elevated, or that the range is being zapped
due to memslot removal (loosely detected by slots_lock being held).
Zapping SPTEs without mmu_invalidate_{in_progress,seq} protection is unsafe
as KVM's page fault path snapshots state before acquiring mmu_lock, and
thus can create SPTEs with stale information if vCPUs aren't forced to
retry faults (due to seeing an in-progress or past MMU invalidation).

Memslot removal is a special case, as the memslot is retrieved outside of
mmu_invalidate_seq, i.e. doesn't use the "standard" protections, and
instead relies on SRCU synchronization to ensure any in-flight page faults
are fully resolved before zapping SPTEs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 09494d01c38e..c6716fd3666f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1556,6 +1556,16 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool flush = false;
 
+	/*
+	 * To prevent races with vCPUs faulting in a gfn using stale data,
+	 * zapping a gfn range must be protected by mmu_invalidate_in_progress
+	 * (and mmu_invalidate_seq).  The only exception is memslot deletion,
+	 * in which case SRCU synchronization ensures SPTEs a zapped after all
+	 * vCPUs have unlocked SRCU and are guaranteed to see the invalid slot.
+	 */
+	lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
+			    lockdep_is_held(&kvm->slots_lock));
+
 	if (kvm_memslots_have_rmaps(kvm))
 		flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
 						 range->start, range->end,
-- 
2.47.0.rc1.288.g06298d1525-goog


