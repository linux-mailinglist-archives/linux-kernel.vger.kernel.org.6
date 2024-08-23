Return-Path: <linux-kernel+bounces-299530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1495D5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0311F2354D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D4193068;
	Fri, 23 Aug 2024 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G47bSehk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5C192B65
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440443; cv=none; b=U65YQTiXpHVpzUZLtKhupvhT7ZMye6LFvg7UBEYNDrsm/6Ouzk26MNRtvuti+l+WIaMMpafcC3JhcffjVdrVNSRHw4f0Mo1d9vlNxLgyjUEJBX7dP6yJIHa+PeKmRDX0r07lJEssMA88ffA8AtM2yZku3KpDtGL4L9cSnYPtbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440443; c=relaxed/simple;
	bh=cdOzM3rsvHcnzUArd40Rm9cxgyuFYjxWAuX6AqH1qKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CqLv+JkxlbdnoGyzTjB3WUfyg4yfFdEWZ5b3kkem8Fv2kj/PYj1KzQmde2V0QDHTyEg64qkAEOQ9rHDO503TumYuYzDofhHSRqS13Fok9TGssYx6muYTaZ8LkYLyGW9gLBTYksm2dOYkSN8FU5qlB7u3jxOfqOoy2DymCK2FToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G47bSehk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d45935fed4so2690355a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724440441; x=1725045241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yI1z4uCFmAkM0sDj6QIO1l+MqKKyzx7UyA4O1UMvJKo=;
        b=G47bSehkkb7/InYBY0XqKXqso1w7rnhX2PCbZ8EuHAs/bO+LJHl269vih9w3kT4OcA
         Tmdo/lPy6PtmSR5q2YY80M6Nm+fK+jfkKu9nCmwknY1XiOaCHXOFprLspREaWJMA5XqZ
         b5S+DXV151DrkDZs+zgSZ7O+IbO2A81EOZmkmT+S1E+2FAPhyCzG71Auw3esU0aB9tkx
         AtQUlPGkcs1nhPMgzg+Ud3/uZIdyJlk+1hYboBnzFyR8vQ+9G6++V/hiWeLcrMDKQ1no
         otR4LpFtfzgHWTt9NyXHZ4zIhql4HMrF4uh0UjUHRROTXpwyJsTQB4nVc9C83zZg8WB3
         Jgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440441; x=1725045241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI1z4uCFmAkM0sDj6QIO1l+MqKKyzx7UyA4O1UMvJKo=;
        b=ZZ7Iy1H8k8/QT74nmGDQzUyaVbApl5+Yf49ulUL/TvBSK9Muum+dMqN6BUJcvStSJH
         NFoXojwcfugDV3NT8y6UHGW+HfrXoccmHRklnWW1JT6znRN3lQJROOwmugzMryjSyn3X
         APHHxm8qm+JkUVxfAgK1XlY9nXZHgeQnbzsKGwckudZUcHm6CuwEwJHoDp0bHSDbkUl8
         czmRC+lIa3PgLGKuzskHtF5hdFiyLymrKWhBknCj2TixmIsJrDgHo2TMbZ7862gcx2h0
         LAmA73nlafu6aU57cyeyRdKItDWy7bPK83IwFSDF0r1zT80/d9ZbgruzuLlkykohGJ9n
         g+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWghy+e0XiPyyz7yhGDq4hUmrfD0vVrc9m6k8aK53LYIu849WwenbPtmt1YbNm7q8KAUV/vUvc0isOR+jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbRji9P3HlEF/0W+NuwxoUv50lo3A2aprlIqg7DCdiYVlm/uI
	6tLSD2mcFN3md4D0DZVGlkkpI0dfoSFdt2NJxAvFXMmoD5Dbi7jsJIymrH/2hgl0HlstfHyh3Tj
	WZg==
X-Google-Smtp-Source: AGHT+IH49IoEI0t5rMhPSFXLwE7VljKjMosdxqKhbbOkcpez1wXrr3Af1H7qUWXNPubHQ2mYtm5XMUDA7H0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:688e:b0:2cf:c2d3:714c with SMTP id
 98e67ed59e1d1-2d646d0eabamr38494a91.4.1724440441269; Fri, 23 Aug 2024
 12:14:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Aug 2024 12:13:54 -0700
In-Reply-To: <20240823191354.4141950-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240823191354.4141950-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240823191354.4141950-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: Clean up coalesced MMIO ring full check
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ilias Stamatis <ilstam@amazon.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"

Fold coalesced_mmio_has_room() into its sole caller, coalesced_mmio_write(),
as it's really just a single line of code, has a goofy return value, and
is unnecessarily brittle.

E.g. if coalesced_mmio_has_room() were to check ring->last directly, or
the caller failed to use READ_ONCE(), KVM would be susceptible to TOCTOU
attacks from userspace.

Opportunistically add a comment explaining why on earth KVM leaves one
entry free, which may not be obvious to readers that aren't famailiar with
ring buffers.

No functional change intended.

Cc: Ilias Stamatis <ilstam@amazon.com>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/coalesced_mmio.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 184c5c40c9c1..375d6285475e 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -40,25 +40,6 @@ static int coalesced_mmio_in_range(struct kvm_coalesced_mmio_dev *dev,
 	return 1;
 }
 
-static int coalesced_mmio_has_room(struct kvm_coalesced_mmio_dev *dev, u32 last)
-{
-	struct kvm_coalesced_mmio_ring *ring;
-
-	/* Are we able to batch it ? */
-
-	/* last is the first free entry
-	 * check if we don't meet the first used entry
-	 * there is always one unused entry in the buffer
-	 */
-	ring = dev->kvm->coalesced_mmio_ring;
-	if ((last + 1) % KVM_COALESCED_MMIO_MAX == READ_ONCE(ring->first)) {
-		/* full */
-		return 0;
-	}
-
-	return 1;
-}
-
 static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 				struct kvm_io_device *this, gpa_t addr,
 				int len, const void *val)
@@ -72,9 +53,15 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 
 	spin_lock(&dev->kvm->ring_lock);
 
+	/*
+	 * last is the index of the entry to fill.  Verify userspace hasn't
+	 * set last to be out of range, and that there is room in the ring.
+	 * Leave one entry free in the ring so that userspace can differentiate
+	 * between an empty ring and a full ring.
+	 */
 	insert = READ_ONCE(ring->last);
-	if (!coalesced_mmio_has_room(dev, insert) ||
-	    insert >= KVM_COALESCED_MMIO_MAX) {
+	if (insert >= KVM_COALESCED_MMIO_MAX ||
+	    (insert + 1) % KVM_COALESCED_MMIO_MAX == READ_ONCE(ring->first)) {
 		spin_unlock(&dev->kvm->ring_lock);
 		return -EOPNOTSUPP;
 	}
-- 
2.46.0.295.g3b9ea8a38a-goog


