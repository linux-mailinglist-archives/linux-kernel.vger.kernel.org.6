Return-Path: <linux-kernel+bounces-359820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA96999128
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E321F254E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B9C21262E;
	Thu, 10 Oct 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qpUkcRq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F73210C2E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584844; cv=none; b=rLC0cTEcJl8DCRMklZLZZrb9RVgqB681r8V/D+4n91vnT2AtESzRTqm9qgFC6bWnWLULQr+PMmilVXsmkG/kDNH8O6FMgMr+NWsr0+geUvSPsT1rlmlLLud73bIRjEuLWwtu7DpsItW/vbpt0hon6TlSIWQQFomXYiU8LMN8PYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584844; c=relaxed/simple;
	bh=Q0WfZXD0AwljsCbiw/O0WdULhXfIX1X/By/5X/lP1LI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mQFdC3J/BOE+L/9wgsUTDvRN8TKy5gug4zOrQZ8b585mfEw5g4Bwr6yuxgDRZuya3P+5UZFFpWNECeZCWKg6eCKMX4nP+JkVatHBeJK3GX669XlhrqNzXz6Mz/FQ4EQgE1OUdtdQ7ISnrgsVfepfxJIK5sdp7WZjp+IIFfbe8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qpUkcRq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2916c47e9fso298656276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584842; x=1729189642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ/c8QPJoSxQXGCWT5aWp1nMy1t7EEzE7+N8fqq+BFY=;
        b=3qpUkcRqOzUfCZcj+BZdHa8RALWFF7OtRiu+VQ3N3Sp/jKQU8vYZDxOavhvz5GzCPs
         4wMtC27QPkYI4ZZHJTIhsyVCBkQHNDXjn80rQVg5sN8wuj71+RLQ2UFJPOQltkMKo9b0
         qmkHu3LJr2xQyjv0+A4khnwPAAKx6T34tSkbj9Gi9Mhug6a0LgiqKq6ggRDbj1I13x3M
         Y3Gr8fNaFSD6n8ayAIf+4tHcbqgdwwrqOAUwKRd8eJ/bjgCPP4eKndQloqNzhdukKHBr
         xWjD7W7h8Vs/8C2ceSX6nGlC3uH/sYu6EzXd1UTRGjZgT5NEBX+d23twphqB7dwJBHG7
         TZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584842; x=1729189642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ/c8QPJoSxQXGCWT5aWp1nMy1t7EEzE7+N8fqq+BFY=;
        b=O7l2qwbnTxC/ePAUPpogfnoR8vCJ5+eMtEucZap+6AcJ/zWCEUSWuGfO2Z7YKwSh5V
         tRN6MmWLfMBGBWg7QctruN4IM39zsCVdh8CJkAh1eK95T2SVU2nk4olOuxoLVPa86YOQ
         w6zctLZ64Os9BiN4arNJJyDHd0a2jgNY34LtpdvdYqBj59S5iUfmLHbQVpSD7pOK+nqp
         oVcjwDX86/fME6/adEOukwU4my7ixvEh41+aopdmr96aaJOzNWNTa9ybPLUVpSC+8U9j
         EZ0YEGRX6NfmO7i+9MY6f/uxU+P/34/s+jy0fDtjDfPRZxbx433DZ4ABEEAR+W/Kelcy
         81zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu4rPm44F8AAiobpr+I1KlPPW0hN3ne9vImyByb8vkf2DewX8p/7a6UBFhPr+jAtOxmQRmn8g5XEEmPLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pEmSDVS/Q1L9rhjGaCk34mO+jtDCH7/ZqCUgS+6VxJTeUSOG
	dleCqiROfLf0gvcUNZPCtlecLM3aZ7+on3wSV1xW195Xp2kWgWprQAUgjRVAZWepW+4gDfxMngS
	6QQ==
X-Google-Smtp-Source: AGHT+IHhD+Vk6TwFIS5v8fA24SNPRWU4vCcQM+1g+zVw6L+6pfrMpIdoNti+PehtHCeQDGmk8Jps/9lQ5Ek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:d30a:0:b0:e28:fe07:9cc1 with SMTP id
 3f1490d57ef6-e28fe4a3a81mr68085276.3.1728584842321; Thu, 10 Oct 2024 11:27:22
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:13 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-72-seanjc@google.com>
Subject: [PATCH v13 71/85] KVM: MIPS: Mark "struct page" pfns accessed prior
 to dropping mmu_lock
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

Mark pages accessed before dropping mmu_lock when faulting in guest memory
so that MIPS can convert to kvm_release_faultin_page() without tripping
its lockdep assertion on mmu_lock being held.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/mmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index f1e4b618ec6d..69463ab24d97 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -634,10 +634,9 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 	if (writeable)
 		kvm_set_pfn_dirty(pfn);
-
-	spin_unlock(&kvm->mmu_lock);
 	kvm_release_pfn_clean(pfn);
-	kvm_set_pfn_accessed(pfn);
+
+	spin_unlock(&kvm->mmu_lock);
 out:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	return err;
-- 
2.47.0.rc1.288.g06298d1525-goog


