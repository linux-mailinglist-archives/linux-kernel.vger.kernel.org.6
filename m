Return-Path: <linux-kernel+bounces-263857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38C93DB82
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA271C20856
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27142175563;
	Fri, 26 Jul 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocv4GqlC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DA1741EB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038002; cv=none; b=qTMi1xzHLLHrDfzzdCZa2GsnNSxo0txn5NUlX2qvnsTNpDHeECFyxHAY//J0zFBRzp3bgYieXKQzNu+PZWSWJKraI/PPDduLi3izTLpQ6tkhdTkPySX8DAjqI3KRij9umVp3Qcr3RVSqGEcdFhgLCFqBxOEUPHElS1li7hmy6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038002; c=relaxed/simple;
	bh=QpaOetglmizJZZ+b98sQ2qGQfzOr00nbj07HtFuO9j4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+/y7M5TAorS59uHvuXPJN3RbLXzbSGBsH+fuqf+2nYSjU4MGa2nhAKGkyACLq+E96HUeHoyTXKV7SHrx61qrcUxfrBTLHq7v1CLN3rrKxHBu2su6hCaxpMMgoL1P+7k1rqTBNAvO2yBvkiUxBqdvSbCd13MYuHFPdp/aH1cmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocv4GqlC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso354393276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722037998; x=1722642798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F7WgJlT5NNtid7p2jwFbPV8b+lTnD+3vJbPsQDaWDdo=;
        b=ocv4GqlCyEvL0Bf07jV+GPZ/KIm5GT+lwAp+t86ocwSVViCHPl1xeNpA2gX7tLvhHZ
         aGaF38hqmPtz6/NS5kj1IGLHLDKa776uIoP2prtC9EOuNNzGZEU6qdMGBmPyGLwStWuv
         fTmzb0GVx8w6YAzPH1TG9+cpMjS+dciHsrcoew3FqAMxhRXidcY7i71fN5f+HbAUwf8I
         nZPt/ramfQFuB0dmv8j5Itq2kb1BhkAz/KcxopoXPUE+qhNnuCtqrPR7KgqnqyezbvjF
         y6mTxDd01NkMkbDeOk5F3WiPrXKYphH5iBw9jQsGXGsxL3bYcW+rTIvWt0T7OydIkrR+
         9pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722037998; x=1722642798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7WgJlT5NNtid7p2jwFbPV8b+lTnD+3vJbPsQDaWDdo=;
        b=E0xP8nii5ygqoGrV/R3HkbVD6SXPxPncVuC/V1uWNa9Noesr+5GrOb8RkVcSobIqAn
         kXfwXucK7CFsaA5behF8bq6YNYieuHpp5H2aIw42AXsdX9wrRew/L/aMm9JmSnq5MFCv
         VV1VaHKUsrEwFrBK7P+XDV8sed+9L19RERYsfVPBKOjLpBwLUj3T77ypXcjE1p8pBIaD
         Vvti6TjMygzRbT/X2Fqa8izplJL8GIRn3r6mq8VQ79CfC2jrZgjhG+L1Ol2Frdt4ZR4g
         pCW3RWW+e/dnIjGCbbP7c0m0iws6N0FVACA30LqYVNT8oFFwOQ+PraGPP2EFXQvSqFDu
         sPEw==
X-Forwarded-Encrypted: i=1; AJvYcCVk+xKUHOiZWO1Gq6NDZH6VtFSfUfgJR6Xu/fmwAG9SmebANjw09jfX78chIhuu9RZsCGlcN6RZdG/lx86CCCKSCxJjsmjmJcm8oTZb
X-Gm-Message-State: AOJu0YygbsCjv31Jj6u0rG6C5buI8xlK1J1pgibIkTyBsrl+Jwj2f8kG
	SumILosl+dWM4Fc4Yv9wYY5B2YVmzAD45RhevAMoERGZ08nzEdb52Akd/O6jDo5BeGxJhCBWziz
	MnA==
X-Google-Smtp-Source: AGHT+IHz6CGF/LJ/2Irg7XXoFs/UlO9MjKavvm7YGPRddocT798mRWwGF7hDBEuQel+TJyAfnYN45In/DfE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120b:b0:e0b:4dd5:397e with SMTP id
 3f1490d57ef6-e0b5455c058mr1734276.7.1722037998118; Fri, 26 Jul 2024 16:53:18
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:29 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-21-seanjc@google.com>
Subject: [PATCH v12 20/84] KVM: Use NULL for struct page pointer to indicate
 mremapped memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Drop yet another unnecessary magic page value from KVM, as there's zero
reason to use a poisoned pointer to indicate "no page".  If KVM uses a
NULL page pointer, the kernel will explode just as quickly as if KVM uses
a poisoned pointer.  Never mind the fact that such usage would be a
blatant and egregious KVM bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 4 ----
 virt/kvm/kvm_main.c      | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f42e030f69a4..a5dcb72bab00 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -273,16 +273,12 @@ enum {
 	READING_SHADOW_PAGE_TABLES,
 };
 
-#define KVM_UNMAPPED_PAGE	((void *) 0x500 + POISON_POINTER_DELTA)
-
 struct kvm_host_map {
 	/*
 	 * Only valid if the 'pfn' is managed by the host kernel (i.e. There is
 	 * a 'struct page' for it. When using mem= kernel parameter some memory
 	 * can be used as guest memory but they are not managed by host
 	 * kernel).
-	 * If 'pfn' is not managed by the host kernel, this field is
-	 * initialized to KVM_UNMAPPED_PAGE.
 	 */
 	struct page *page;
 	void *hva;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 67a50b87bb87..3d717a131906 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3088,7 +3088,7 @@ void kvm_release_pfn(kvm_pfn_t pfn, bool dirty)
 
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 {
-	map->page = KVM_UNMAPPED_PAGE;
+	map->page = NULL;
 	map->hva = NULL;
 	map->gfn = gfn;
 
@@ -3114,7 +3114,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 	if (!map->hva)
 		return;
 
-	if (map->page != KVM_UNMAPPED_PAGE)
+	if (map->page)
 		kunmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	else
-- 
2.46.0.rc1.232.g9752f9e123-goog


