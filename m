Return-Path: <linux-kernel+bounces-281510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3280A94D79E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6B62822BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73062199229;
	Fri,  9 Aug 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIVw8Rlu"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9A1991AE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232644; cv=none; b=DYhi2iYrGS+6k8FKd0HikDWHMxRn6BAtIiV/uGG/MAs74RN31hQMCk3MFcCqu8Vwq8nsPHS+fo5tUwaWhfVmQe/et/jb2WKgFGL/hjOEHPFZIqWqBx0UddpliyPXgfLGvUUYLCx4h25V6YnFnC510ezkAP1qV8E4GJmauU5y10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232644; c=relaxed/simple;
	bh=Ky1N4NEPPXYQ68tuOtFA6BSNneI8rYbZCaa3EnVYquw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CTHpx/6BNTShMCprSBiXHNUX4xXC7j1rvcwTnyKl5GHI2ZQ/i0uq3ID1RLxqKfX5RSXAz7FiALbPMGzEJjxXzAqZ/yfamHJkJwUCb9PLY0ok6avPmO3YcVlo/qe5R/J+Ww+wB0dyE4w6ZDF7cniNtx0u4QJTks9byYa1kq6sgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIVw8Rlu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1df50db2so2316791b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232643; x=1723837443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KngE1DTnwbCcWR9aNh2KG9Wx5wVMsPDCUrAPTcj/AmI=;
        b=EIVw8RluigmxDMVw8j0b2Ek+6tEzRzap1dFnmb+4h3VXdMwG9dCQXL32e14jOFjvGq
         TcFb2itAsoBKoowacw1mYdnagzEUOnCjwVwOQhe1bzOZVFE341gyKyp0mmv7NVmfQVj9
         qXcgXymrr4xrro76/E+7OWbsfhBXynxxJmc5JMTc95mvodngkABgAy2c8QrgeEGvDe2Q
         nJJ7FZD5Djp3HzAPlEoLWWovTtfnYyNTzl/CdC9ggrO3be9KFyFFT35hmaiGbuDW4dXd
         d1SH/3cGzB+KqD0CRd4uebTb7oY6fYtB1S5SnO7MIis0GZR+pFNNHRVNsUsVzXdn1MqC
         +kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232643; x=1723837443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KngE1DTnwbCcWR9aNh2KG9Wx5wVMsPDCUrAPTcj/AmI=;
        b=OKb2BgoE+1OWO5boNIwVR6bcluLMvaRW3gAyVc4nqMUWmQK64ZjvnF81NCu7s6rE0I
         xUYMS1gKOMT5entNCflT9GpeDIYRDisTqEuVnRJxmJvwQrIwZdxsQcx+UHaUdXOwc3hX
         /Vn+cHT5QwAJj2dbSsCNeX8jNcuGy977hhktebd5dRG0Zz4x2cQ5VyrgN7MLrmhfw82q
         31DeAm7pl+ij8g+WifoeBU50aTQ1nxrTC16uL9Yu8Aw7uGb94UvkIwC15mkhJGl1Cx11
         /SYZKm7NPGLfHTrBU0FnDwhi5aFyIsI/9IhW10nWCAijw0xalNgmmNnmenQnnvFCurwo
         DtWA==
X-Forwarded-Encrypted: i=1; AJvYcCVSKuHs5E+LbQs8k4BY0UOZpYmk+zIWzNA7ipcWDv2dytfOfQZDkttmpJG1yeynKyq85k09kZIh3gMM224tEisIzoS9oxF7GvPJ8hJ9
X-Gm-Message-State: AOJu0YyoUJadbeXalNAfT7a0w/LttyhrgHB1iXfZ5XOOVgiSCN16yKzn
	i1CkXQp1jB08XA73EfqvKtJhvHRL2U1Pc+Jsb4gKKAaVb7BkRUl/MXoLfQ+bRLfmTzDHONpGC0y
	fkQ==
X-Google-Smtp-Source: AGHT+IG7ko0vuFPPXt3xcZarFz9eU+f5poN4SmWQJRgKUX/WSEyph3BvOPDm1891EeOCuHmelP3kV0TthVI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91e4:b0:710:4e4c:a4ad with SMTP id
 d2e1a72fcca58-710cc32523dmr145683b3a.0.1723232642725; Fri, 09 Aug 2024
 12:44:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:24 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-13-seanjc@google.com>
Subject: [PATCH 12/22] KVM: x86/mmu: Add a helper to walk and zap rmaps for a memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated helper to walk and zap rmaps for a given memslot so that
the code can be shared between KVM-initiated zaps and mmu_notifier
invalidations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5a7e476f5bb..4016f63d03e8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1592,6 +1592,16 @@ static __always_inline bool walk_slot_rmaps_4k(struct kvm *kvm,
 	return walk_slot_rmaps(kvm, slot, fn, PG_LEVEL_4K, PG_LEVEL_4K, flush_on_yield);
 }
 
+static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
+				     const struct kvm_memory_slot *slot,
+				     gfn_t start, gfn_t end, bool can_yield,
+				     bool flush)
+{
+	return __walk_slot_rmaps(kvm, slot, __kvm_zap_rmap,
+				 PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
+				 start, end - 1, can_yield, true, flush);
+}
+
 typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			       struct kvm_memory_slot *slot, gfn_t gfn,
 			       int level);
@@ -6530,9 +6540,8 @@ static bool kvm_rmap_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_e
 			if (WARN_ON_ONCE(start >= end))
 				continue;
 
-			flush = __walk_slot_rmaps(kvm, memslot, __kvm_zap_rmap,
-						  PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
-						  start, end - 1, true, true, flush);
+			flush = __kvm_rmap_zap_gfn_range(kvm, memslot, start,
+							 end, true, flush);
 		}
 	}
 
-- 
2.46.0.76.ge559c4bf1a-goog


