Return-Path: <linux-kernel+bounces-307528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDBB964E92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337FAB23770
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20A1BA267;
	Thu, 29 Aug 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vA6tzHe"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897361B9B35
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958863; cv=none; b=tbiypij2WHYjhiP3qVvXU/BMHz1QQ4aYuxy+yPGmEUlhQ3qweCAsAEtcF8ghuxiT5WIiQ9lA171astgkC529E/LIaE4UucungrUy8IgxFMjRGisQ/td5IWwf6bD7NlpW1DzelPj41HmqRoNkfU4xVWmQpqgJP1rXw+TIgprnICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958863; c=relaxed/simple;
	bh=DLYVbOyAOXiOoZ7O1FIx1sY+tLPrpj43JW66pjzCKCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+mGrDdLpzwmwcX0o7DpKgf+bZoqoOuVm5KajyHWUJu+h60PtyTyHRkphjjaPni1RhUfQMU9IBwebPkkmMNfUPUAo+BTvD6LrvlLOg2PtgTzyxpmqeRnFhdI7u0ixKH7aXon6Nz7RU8DbWQCcdqOSTPTakpO4aToClwfxrFIDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vA6tzHe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-203a142c31dso11318045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724958862; x=1725563662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=p/FgfdhlBFPaII3VwKu8OXKCzJuOVcc3OJ6Xh9EER4Y=;
        b=2vA6tzHedxqaioiTOTWkPLjs6KcByk4qEKdhPRWSBQeqRCMCNYjrr/925PRUh8EuYT
         K/48/mOXFxAG0n0O2dlrmTFtTYOalQpxNRC85wTTXGLHUoJqKsDni8MPNYx3qEKzsGuk
         zcC89VwsQklKXY3WPXTwsX5Bszf4fxkhbxsjMwA2fVePCmFx0O7bvekRB7Fx8d8d11+e
         euhw9Eai2JBw/RsxACIfOBmuzEBFml46Gmm9/+VP8vtmOBPn7AZmV8tUsgKYxGi/VQxa
         cJGnjMoVJRbTpHV3ad1KL0COvfGVEDvMQjHL6OWQj/kRzTstanuDT/DQ4/fycrRZzR47
         tnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958862; x=1725563662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/FgfdhlBFPaII3VwKu8OXKCzJuOVcc3OJ6Xh9EER4Y=;
        b=AHGwQ9RDLNa2VaOk/WU1V3BX/73CdYz+zrCfmzdlcpV8Ii1BTmU7XWrKAdkSZM7x8p
         BHt2iypsIBU2yGb6SRq8q7jAUsMw6+iJ2i3WTeQ/j2J6XjGsKzE9v6s4x3JgfOIXBTMT
         3BRC3pisS/rx56HQVUN1IUkZR/ma9mSFrBFw0iOL7sWz/Jms+cSDS6rQ2lWTaslVTtyo
         LLB0CmaznPKJsl2ONcAfjvDMCWzF263L5iun6xftgUCEWoS5BasDOI/CEwu7DgkBlZkI
         iZMInQE5v+WRQmCaQ9fxE8mve/HoLvpOD0mr4z1d/Ie7zzqGYLLwmE6wersbGDzd/xxw
         s+AA==
X-Forwarded-Encrypted: i=1; AJvYcCVWn76gpQjTgKE2z9kbC3mHmfaM0aNlZu/w+ADCwKIzEN91yVsx/Fq1q685gQkotH1lAygGm3utxZAz5ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujMrx7wQkFpmw5xG2wawPqG7hOP/5EigHpXbuhiiIeugzFvWd
	73tlgmeDreZkcZuDWqgZdxXgovuSwXC/1LozEXB/y/umxwZ56D7g1j+/duzESnRxKSQzmtMLnGf
	JbQ==
X-Google-Smtp-Source: AGHT+IH5ChutmsP6103JjAhCqMw5SQ3KVVJLqVu9D4hnLR2shZ7oURw/Tuxrcs9dgf/1fd1kguor7MJA+VU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d508:b0:1fc:5ef0:23d1 with SMTP id
 d9443c01a7336-2050c3dbfc1mr1999975ad.7.1724958861863; Thu, 29 Aug 2024
 12:14:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 Aug 2024 12:14:13 -0700
In-Reply-To: <20240829191413.900740-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829191413.900740-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829191413.900740-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: Harden guest memory APIs against out-of-bounds accesses
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zyr_ms@outlook.com, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When reading or writing a guest page, WARN and bail if offset+len would
result in a read to a different page so that KVM bugs are more likely to
be detected, and so that any such bugs are less likely to escalate to an
out-of-bounds access.  E.g. if userspace isn't using guard pages and the
target page is at the end of a memslot.

Note, KVM already hardens itself in similar APIs, e.g. in the "cached"
variants, it's just the vanilla APIs that are playing with fire.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e036c17c4342..909d9dd7b448 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3276,6 +3276,9 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	int r;
 	unsigned long addr;
 
+	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
@@ -3349,6 +3352,9 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	int r;
 	unsigned long addr;
 
+	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
@@ -3379,6 +3385,9 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	int r;
 	unsigned long addr;
 
+	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-- 
2.46.0.469.g59c65b2a67-goog


