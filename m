Return-Path: <linux-kernel+bounces-250828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED192FD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1EC1F21A33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E1174ECD;
	Fri, 12 Jul 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkHU+PvO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25181741D1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797222; cv=none; b=MPajxMYZVGYyps6X56NeDSJlFfSi3RjpXblJpJDYUVZD+Hk0+gQvmoqo3ouSf3XNjDDUiby4dUEBayDm2e0cEZtNtgHLRgwLOvESKcLelNz9hv/95jWlYSCeemD9XAiKysCTbUuzXK/S0BGwIFdnAPspWX1mWdtRlnEbsUkavtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797222; c=relaxed/simple;
	bh=FMK1JNQzZMC+LLZ+NnGfOW2CO/G1iLTvC9MBzV8N/ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q07cmBcvCNK5DZK9TV5Q8b4UE9LNCjShw6e21uhBt0j3FOQGs0eU99l3NPCjzS41y4Z5IbVrFuTdB3lrN4VGCX7VPBlJ/iWv3BGy7fRbBcr8R2A/r7l2hAX+tFOLUJ977d78sRaH4xFxBKebe3pGUUorY7YoWOhLLvJRqTTaMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkHU+PvO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so3432410276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720797220; x=1721402020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uNeBBWCFWkfC6m3nRC4ikAjguGNDe/LUsyASgE65KAs=;
        b=hkHU+PvOezwwEOba4ULpklfsCbN9d+iWkYw9EYM2zfI6lSoxVdZqBU0r5Plo1tuzsP
         YNoWUy2nQTGq/M34PjUj5lnvbRvJov8bz1kIoNksFmUkYRMqGjaPPNQNW9r+Bz5cOvwx
         yY9Sz4xklNaijMBDzta3bVBk8EYxtrN6pgRkKv4Fo3zo7qEOHHMG4u8McwfTpQtML33K
         eCu/ZM4WxWDYizhH4d8NAUaMGLXoZGkDRfobXbBHc2wAZlwDZrPLKHJIy8bD1OW8iwNb
         mQ6P5DOQQfj5oE8/0xzm82WWCDAMYK99WUDqDL1FB4WcsjH5eRjgsB1UoZfOiA9pltf1
         EaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797220; x=1721402020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNeBBWCFWkfC6m3nRC4ikAjguGNDe/LUsyASgE65KAs=;
        b=iCIXDV8hCCiQQCeaQlSOupYxfz7F0wujQ/mvH1o7S2jT59aE/y527jDGKzApeErrCE
         BXPFVxqQyoHdBf73mH0T0VfFu99Gu1LXqI5R/fQAUV6gIUR0Ws9RBadGKD9+dW4kuOvs
         vk756qoDJNRnmrwlxn+xJkqm43AFrti3k3WsxZCASWp2fVFQAVmQnSa3EaJbYwjBlLDw
         Dp3OSyPC72m2mxEHoH4Ro1EWsNPgUtjB3O/qYJvQyA7eWLx3mJi31EZD4aIcZMhP4DCy
         epAB8SgOKcTdubpOym0Qfx/DPrq1lZmva7PkrorVp50wal31HWOm8yqSmiVNto47rrOk
         Bf4w==
X-Forwarded-Encrypted: i=1; AJvYcCXchkB6/uB1CxYKlG8LPRLZ1IiQLd2Xx9uMkfaKR4ny45tOZWsuOAyZV0LG4wO18sa34SGvVdNYX+11O1nZdcXOStO/ljxY70Sm9ahl
X-Gm-Message-State: AOJu0YwpTxLMpAZzfvcTLdvBwf8dH9pCTM9fTJZ5JgPmdTzKlr61zuT7
	orYGDUI/DwdjL9yCunR91rRhhYuXkPt65n9wElD5Ue72rlu+ZM2sKT0S/LY7LKEVKE30RLq14FT
	AFQ==
X-Google-Smtp-Source: AGHT+IFb18rrVSrijY3yb9YIXcErdEDiSDk80QlE2yIt+GQ0EP5KOyZY2pb43G390lTTX4jv/Y2p7iSY+m0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114b:b0:e05:74ca:70ce with SMTP id
 3f1490d57ef6-e0574ca77fbmr435165276.4.1720797219866; Fri, 12 Jul 2024
 08:13:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 08:13:34 -0700
In-Reply-To: <20240712151335.1242633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712151335.1242633-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712151335.1242633-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/mmu: Bug the VM if KVM tries to split a
 !hugepage SPTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Bug the VM instead of simply warning if KVM tries to split a SPTE that is
non-present or not-huge.  KVM is guaranteed to end up in a broken state as
the callers fully expect a valid SPTE, e.g. the shadow MMU will add an
rmap entry, and all MMUs will account the expected small page.  Returning
'0' is also technically wrong now that SHADOW_NONPRESENT_VALUE exists,
i.e. would cause KVM to create a potential #VE SPTE.

While it would be possible to have the callers gracefully handle failure,
doing so would provide no practical value as the scenario really should be
impossible, while the error handling would add a non-trivial amount of
noise.

Fixes: a3fe5dbda0a4 ("KVM: x86/mmu: Split huge pages mapped by the TDP MMU when dirty logging is enabled")
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index c8fe13217ff7..bc55e3b26045 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -296,11 +296,7 @@ u64 make_huge_page_split_spte(struct kvm *kvm, u64 huge_spte, union kvm_mmu_page
 {
 	u64 child_spte;
 
-	if (WARN_ON_ONCE(!is_shadow_present_pte(huge_spte)))
-		return 0;
-
-	if (WARN_ON_ONCE(!is_large_pte(huge_spte)))
-		return 0;
+	KVM_BUG_ON(!is_shadow_present_pte(huge_spte) || !is_large_pte(huge_spte), kvm);
 
 	child_spte = huge_spte;
 
-- 
2.45.2.993.g49e7a77208-goog


