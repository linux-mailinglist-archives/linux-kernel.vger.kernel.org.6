Return-Path: <linux-kernel+bounces-273092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFC94647A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C1C1F22359
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895B134405;
	Fri,  2 Aug 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSU7wFT7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907B12AAFD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631151; cv=none; b=nMeIzrNcHXM5DOgbr3Ri3IV8D1VRLE+o/WOqFopUW38mZ5WuYa0sOoJq2S4z2Gwz+8iosjubX3mZW2bvKMLQ0MLpgfqxpqHuvcImQ4ZHfDR/AcXTku9ydzdZKr2Rgbe10GVs/gqLFgrEgj3X7ISn9+CxxVxrfm7WR3XS0iMo0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631151; c=relaxed/simple;
	bh=ul3I8jtNfEVe2uxdPBcvEuYLJaZMuXyRTYdE99HTjQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqrH7wea2U7j1cRjQMJoyHoQs55c32A7DTeYW7zjp3BbUN94dOhFSIj6jSRs96LPm9lFhKOip65a4OklP6TfGkz/hjs3i+ZlTSLwWzVwDTJALJ3rHjdedO0areTh7mK1z34BQgI58cP/Q94nSUnehX9P+t7eivhBHx2XYi5CgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSU7wFT7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66619cb2d3eso185811587b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631148; x=1723235948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UjvdKHX5XmbdhKLTWlXN2ri3L77fxrqJCXnnfCjoJs8=;
        b=WSU7wFT7U36UARGVoVUTZUcunD+twpI4AKK76AqUPiys9it226ott+xEmVe7CHivdx
         IXDlp7TFucZK8OvRnzA2Vnso9wBzaHKVz1zs9LafIosw5NZ9nscV7yRcuH5FARh23VUp
         Jpw5CHYXpd/zzMBTBqCWWCB71g3pNixI8FpMmfXgbsjJSNPb5wuUv+bLXKjuHDUpTg81
         6j14Q63GQIg53L1aka8rItRQew9p0DihLyKEn7VbTyUBMEUEk5Do+Cn0hEKyEoxz7qc0
         2Ws7mVMIAI17sTSgglmTmDZUQgKYSOF5tOsofoN4+Ixob6LRIk+s6rMo+EczdQZrKUC/
         XDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631148; x=1723235948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjvdKHX5XmbdhKLTWlXN2ri3L77fxrqJCXnnfCjoJs8=;
        b=U4S3s9J29PX6iZYr0RzuxdI0KeAFqLnq9SM0c6FCWeh5fbinxeTjFn43V9Qes8Tovx
         BjYm4Dx4MlEhuUjRm7o9zhbPFx211UGoMfVuiycrisjMSeSZTd0RjRTLRXrfHeQ/A+fN
         t1y6Dy0QJQS7gO52bl5LNXa2aVLJBomdEu7kCpgp21B/YlONJuIYybaKoCj10R8ABrxz
         9RYD/1+Sb29tQlHdiZdTuJtnt5CFOrMPvKTQkoiwPisbJEypq4cIEAnNgJXpMKKz0lYR
         V8LmQc+iLyEuxSf3E/UFOxwDhIEGk0RI0R12gDoy6w9rp+IXcfkM4EdYBNvE7Udi+lXB
         rpmw==
X-Forwarded-Encrypted: i=1; AJvYcCV+n087gx+j0qMX5xbqG3kf+MLa59h1PFGk4slYuDCy8VmL1I2T9Wg5pweqy1qJ4H9j9IM2QoV43rC9UmIgTXAziq0eh5GehUDIPpye
X-Gm-Message-State: AOJu0YyoU3FzgVMyJqXyQOlAgzNe8sycH0zNhRnky7iXsfPCRTkKkHT+
	kp+VnjQCusrVxgOk7pVMecD99IriP1Ol/WkvlF+W1aDxO6pBi/yDrWiVDrmj0zb2Zr/jaje1XzJ
	QLQ==
X-Google-Smtp-Source: AGHT+IEPSQRTx7gBHRSttp+7gITI0epwEssMzt1KPQLzKi+lHEKLoj+vlFZlHc60M8o1PIdYF4z2PAULIsM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:10:b0:64a:8aec:617c with SMTP id
 00721157ae682-68959efadcfmr3215337b3.0.1722631148748; Fri, 02 Aug 2024
 13:39:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:39:00 -0700
In-Reply-To: <20240802203900.348808-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802203900.348808-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802203900.348808-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86/mmu: Reword a misleading comment about checking gpte_changed()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rewrite the comment in FNAME(fetch) to explain why KVM needs to check that
the gPTE is still fresh before continuing the shadow page walk, even if
KVM already has a linked shadow page for the gPTE in question.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 480c54122991..405bd7ceee2a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -695,8 +695,14 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 			return RET_PF_RETRY;
 
 		/*
-		 * Verify that the gpte in the page we've just write
-		 * protected is still there.
+		 * Verify that the gpte in the page, which is now either
+		 * write-protected or unsync, wasn't modified between the fault
+		 * and acquiring mmu_lock.  This needs to be done even when
+		 * reusing an existing shadow page to ensure the information
+		 * gathered by the walker matches the information stored in the
+		 * shadow page (which could have been modified by a different
+		 * vCPU even if the page was already linked).  Holding mmu_lock
+		 * prevents the shadow page from changing after this point.
 		 */
 		if (FNAME(gpte_changed)(vcpu, gw, it.level - 1))
 			return RET_PF_RETRY;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


