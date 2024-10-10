Return-Path: <linux-kernel+bounces-359783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118599990B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F7E282BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB32010ED;
	Thu, 10 Oct 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iE+fjr+"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF879200103
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584769; cv=none; b=EcfnBXIRML+7X8KaTFwI/ay93OWZsmTQ0IYmRoKVZYxz93lNgfuQEnc4hauv8rpO0vo+T9zT/+hNuvKqvKHx/j27McNZWil6SRvwF8DalwF3Sx98v4uL49jEDZ1E+soAl6ybZNLCjdgtCsXQGFBP6UJOSj4IH/+LJTflFZvNJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584769; c=relaxed/simple;
	bh=HP41e6SfsC4ul+oSDEyzHZ0hlt7iv8seYpnKNCv0jUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBINEimqQXBwx/RPQFM+xOb1Zi0PeECYJgUyf42SbHBU+YVp3KSwPpz1U6bA5Fmr5Xt7XVCPmfJu80gxGI08jrCKE1fOpbbR0a29aeyCsFCpGhH0pcnqpnbwg0LJHNotEw10oG0Z/Mjy3bs0WzUTpvbXgwchSUVmHI5s4Xfnn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iE+fjr+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e04c42fecso1289996b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584767; x=1729189567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n3l8C52m2RjpLTXcY6dq+UIBo01A1fTC4GBMzDz1kHI=;
        b=3iE+fjr+J+BhPA8v3iqwSMU7gQHtmXoLc2UoAeE8K7W7XowZPMedacJz0kDLjxUDYQ
         QBHxZX1NpRwXYSGnH0HL3vJtR2VFd/IfEGEWVjktv7EDSMjvcPUq75M3pmwLSNSY+vlM
         TTGcpYpnDBEcT6Yq4ZgXXOtSRMnft79vdJT2U4MoIAfvpL1GKwjhtjsMIhwYKH1sdUdg
         mA89AXe5f0SdxOYRU+ZmAG4KCc7jke6+CVqu1SVWGJg4hyIVrQYwExBFF/T3JmjQdnSL
         ThQ6E+6hJCDsmRcl4PwyBxiNMZtTBKOsC/MsBvMbt48BIiFEhaYo/ha2z7lutfruNTUk
         snKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584767; x=1729189567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3l8C52m2RjpLTXcY6dq+UIBo01A1fTC4GBMzDz1kHI=;
        b=C1W+JZFDkHJ7oYkoQHiMCHwZrA7nb1vGszkxQ2KGhCsHLkUYnGfjbmRiBsjonapVgs
         1vLw+Bs3gGLNfrJNW6/IlPt0vsB7plaTjoLqL8VUBtzRy/oU5DzQk9VUoWY1lrwWcn6D
         CjOWwnNB7OmKENDIuC0L5V/VH2wLHxiSgmmxm01b5qI9gqCR1p9xhItXqo5YBGJkuDWb
         hkH1ZbXbDAoO/TfIm7wHWLsje8e4BRFDX2l6gvGe8Mnf/Pa7XF7g9CPSr5vFg/wJ/bY0
         qL9ErL5a1sZBDlpCeDkI2U66c5TKcWF3jGqD6prQO0dOPvI62BQDvKu+yuAAjUsH+Dxh
         7Pvw==
X-Forwarded-Encrypted: i=1; AJvYcCXmIYDTsVI+8gVNwgcTLW7WOGD+l8A4G7cz/KcMY+duyaUgaqMU/NLq/Y6HB+bDcafkZWHVxAi5Ukuu4kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORl/QTLC2UrzPE97vlZajvPC7s3SGI7GceiXRjqoQ5IvwDvfy
	9gELHGGMxbpURBtOT3zwGsbLjiqYC7XHEpAUoZUDxKcgXwML3vUBH0vwS/GOryV0qwskDNG4jX8
	WNw==
X-Google-Smtp-Source: AGHT+IH5y4h19aQ8D3UFZNHEjFs0l+IkJ/F+GwDOdY5CLNZ6WKY+eP+zfpO4DiXt2PfVXCIgSRJOtCb+AeE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f44:b0:71e:268b:845e with SMTP id
 d2e1a72fcca58-71e26e53c16mr11733b3a.1.1728584766802; Thu, 10 Oct 2024
 11:26:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:38 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-37-seanjc@google.com>
Subject: [PATCH v13 36/85] KVM: x86: Don't fault-in APIC access page during
 initial allocation
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
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"

Drop the gfn_to_page() lookup when installing KVM's internal memslot for
the APIC access page, as KVM doesn't need to immediately fault-in the page
now that the page isn't pinned.  In the extremely unlikely event the
kernel can't allocate a 4KiB page, KVM can just as easily return -EFAULT
on the future page fault.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 20526e4d6c62..65412640cfc7 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2647,7 +2647,6 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
 
 int kvm_alloc_apic_access_page(struct kvm *kvm)
 {
-	struct page *page;
 	void __user *hva;
 	int ret = 0;
 
@@ -2663,17 +2662,6 @@ int kvm_alloc_apic_access_page(struct kvm *kvm)
 		goto out;
 	}
 
-	page = gfn_to_page(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
-	if (!page) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	/*
-	 * Do not pin the page in memory, so that memory hot-unplug
-	 * is able to migrate it.
-	 */
-	put_page(page);
 	kvm->arch.apic_access_memslot_enabled = true;
 out:
 	mutex_unlock(&kvm->slots_lock);
-- 
2.47.0.rc1.288.g06298d1525-goog


