Return-Path: <linux-kernel+bounces-359789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4999990C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0586DB2195B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8EE204089;
	Thu, 10 Oct 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E53iqmq8"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D3202F90
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584781; cv=none; b=KvjFq8AaSdnmUtc73ut438tDHZItBZj3HPzR8fcNiRoo+R6NBrLgDFqQKiWu1ugpJHlrBBvOAWWxirx53fKA05ieIYOgV1Q90XKuIDkFxUVQN/h8BWja7JlcOHTNTM3ejzAcycjLRQpK5JgGMq0NnpQq9MAbivrny8Q9oN+D6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584781; c=relaxed/simple;
	bh=hSHnz2G1ntKemXewFOwXdDJXjhCTKhhhRrw1wSIGnaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdECsv9TR+eIbSUP0quhFc4wNCipFoik5z5yETN21stBCoMVTnwkqQPlXRPGhyJNSOi2hKWjbolAtsFPbIQQ6DXhVLBEhoEIrMIRVVvkB+TzZh7fKqJWV9uNp4BIujLtRpK4VakJJ+iJPMc79Ny4NfRnGLW71RtofSRG6kb1bOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E53iqmq8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e1e989aa2so1655349b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584780; x=1729189580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DwvYXI8CmE5CO0Ycvk+EgdgF52vTMi74FFh8TONwA8=;
        b=E53iqmq8I7HHufRa9Nfa4QpSUD3mPUf0HdiC+gr3+ZJVA0PtJRMGFCy2RlpuApodID
         MHkYZafORHG4Fo5pdlmIa2Zu49fY42Dn8Mwbg8BEIZ/Pa8OJQiqqaoX3cE0NBkDUycJi
         8knjazonwqf9LvKUPFmBk2crmB0MGGb2WbPM1i7pjkVZjFgAzrwTCr7oBWE4eumlOw58
         NDuf4DR/sTZJYm1oq12ic4ny/HL0dHq+Txgeh165RAyYFWZt+w+um9fwU7jF7aG4NAnz
         uIpRYBDmcMn403NAN6nAehV9jbOFJtSN+/wsSbKYsr5xfV60UWvUZH56iYMQo+BvtQRs
         hZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584780; x=1729189580;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DwvYXI8CmE5CO0Ycvk+EgdgF52vTMi74FFh8TONwA8=;
        b=aIskNM9luHqe8fcq3BHxh66Y0vqbpDaJbdHKJnzGfTOi9+iN9cQXnwQBiNPDegJVGm
         spJ0KdMAloWyDd6rmDsmLdp1+vaIXDGTDDeoUtaf580CdPE+1QTRHjGSJBx+LR3eQZm3
         Fl/PmIWWAJBWKSVZJp6U+/7/lwUWdiOeP81UYqE6FG4O7aIHlX0dryeKsa6BcDu+qCpF
         QttJnPC52ikRBE4yLAkw3Zq2N8ZTneCWlgelxBxHXOyu+MMdPRHmfNCwCcvW2DGulDfY
         3UZ9I1WKcOkqpNYmtmHTBpVTGGbUdi0s7y+JQlHZMs47zowLBNZawqKPELIpWlG/PvVo
         WgZg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqWVfw7icTiw5tG5lwP9sNRLfvEjIBOK+Yf1qCjla2pLFadSHc3FyeNT5tGBGr+OxA+D4ZaniEkTkc2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNEkHMdEn/chsB38B+HL/wx4eq6/+1DJFR92sqrO8R2KmJzlf
	i8Q6kxHMPPuHlC9WgDjWis9AcduPyuxSupiSUIF9dQteJ5flJMFqXipA6ryD3SmIKn3Iz9v1UYF
	EJg==
X-Google-Smtp-Source: AGHT+IG3pPvsekcqYnotExeZVZUXEYlJLq+6e3a1eutYJX4gtVKcKQbhJKMNrxmpaRIGMBxtyW/kZ/ByL14=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91a3:b0:71d:fb06:e79b with SMTP id
 d2e1a72fcca58-71e37c53abamr28b3a.0.1728584779496; Thu, 10 Oct 2024 11:26:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:44 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-43-seanjc@google.com>
Subject: [PATCH v13 42/85] KVM: Move declarations of memslot accessors up in kvm_host.h
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
Content-Transfer-Encoding: quoted-printable

Move the memslot lookup helpers further up in kvm_host.h so that they can
be used by inlined "to pfn" wrappers.

No functional change intended.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9263375d0362..346bfef14e5a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1168,6 +1168,10 @@ static inline bool kvm_memslot_iter_is_valid(struct =
kvm_memslot_iter *iter, gfn_
 	     kvm_memslot_iter_is_valid(iter, end);			\
 	     kvm_memslot_iter_next(iter))
=20
+struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
+struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
+struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn=
_t gfn);
+
 /*
  * KVM_SET_USER_MEMORY_REGION ioctl allows the following operations:
  * - create a new memory slot
@@ -1303,15 +1307,13 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
 })
=20
 int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len);
-struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn);
 void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot=
 *memslot, gfn_t gfn);
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
=20
-struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
-struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn=
_t gfn);
+
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
=20
 int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *=
map,
--=20
2.47.0.rc1.288.g06298d1525-goog


