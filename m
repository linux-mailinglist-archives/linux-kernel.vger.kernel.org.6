Return-Path: <linux-kernel+bounces-260515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272493AA72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CB91F214BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534187A13A;
	Wed, 24 Jul 2024 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Vk5U3xX"
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F43F8E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783485; cv=none; b=OwCMIzwLZotosomL6xFJS+TtZ7pn6H4QwfSZWjTDOXEjPZfCQgZXA7L8xpPpufo2nZNlgqAbIsDrTzSFhxvU9Mng1bknIQ+Th9qBmA3ot9axZtjZyyJugcWRDJvQEqaPLcnApXl+47j4DSOBE+RTdW9AkCNj9ZYrCuyLbgWCT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783485; c=relaxed/simple;
	bh=ELbOSXsn2tl30guokJCMMpH45tyd+sOPH2P1Gsg+Zxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jj/x9CxVjde/XKiUgGvJXUqcdiUsVmr8gDodP/tbg6irtJayVbvj00iaOAYsCZeGxARrHoK0V70E1Y7NbzK3Lb44cG/wXpC3tttYSBfE3ACp5wQ+7t5qvTrBkVYAg/7ZXvwXC4UWE9f5vwAz3ZfsgIcxle5swHdgcRbLlnN7v68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Vk5U3xX; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-821ba96962bso1585437241.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721783481; x=1722388281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6265Vr7ZBVKTm4Fxp+PtFVTNDBMV13LE1gmbTEV1Oo=;
        b=3Vk5U3xX9N5NzduOtpuGbSMYSeVxZOsb3S9l6hcrpVl15VY7FGYs8+TlzJKUNXRpDD
         Ix7FgCJNrIuPf70KwBlVZ9332a7XiGPY9GYr9yMhSTjVqZfdNBLSKxZrAF1btUkpVJV1
         r+mXbVG/wvapWJK3RaH0fgAGx66qlyMrnXQ4AgAjabOgAQuelsadMxQr+/LwHdNCSGIr
         VDj/0Bs9Tv7Jofa6Lf9aCkW8Dk68JpPw0zlUQX1y5uFI91jLLBW6Uv3HCRdRUwoyrcUs
         KP/GP0YvWSC3c0ifLF2JBLFW7za2noyRbm2lWS0X4tu7ZfLy74ekZt8fIErhHrSAwWc1
         efgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721783481; x=1722388281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6265Vr7ZBVKTm4Fxp+PtFVTNDBMV13LE1gmbTEV1Oo=;
        b=vy/uBTjWQbx28FBhtTB5+oe4ywJCrMM6S2WYfSR2Zsmlip5g/2m0EQQywwzsEJKjif
         84kQWGR0WOI8WL1d9RpyspIii6CXLP2BIyHaNp5p5of1w9sITE4zSMfw3t9H2KzZZCZp
         pvT7nLZIKKdQ0auvRd5IZ/VHW4s4K8sB0LUwjd5iPZGnMwZjOt+M8Bx6kfEP9g4mhWvf
         m9fHNT/Jy40qL05P1K9zpST24GlsJsXi5avq8e/EPXGxkgVOYGRPF3RPvoWCB+rcKukC
         9/CK1RIVj9oRDTni1rwdgdMP1Z+0hjrNSk9CpEBKbZHFCD5UoK59++AGTsT35g8RQbWi
         LvTg==
X-Forwarded-Encrypted: i=1; AJvYcCXC6N1+Mc8MCCw3SflNtOKQL7Kt4nBPkCN/5kmVrZnry7UaYT2k/4Vj3zMSqJpdceY8JFXuCYfo9V+HAyLcnUzOGqbuc9AHwBCiGaWQ
X-Gm-Message-State: AOJu0YwJl7r55Vja6e3kEAi2nF5DQA/L1vtrG5+Fe3Lk2KdBdV9rdbky
	andml3rh4fiE0WWfHXQy0LpmgUe2JVQ/h1bsxbhTJcAsdef1HPPqgN9XDMAtSZ/bmgRleamt2I+
	ZzYKBoKVUHpxetPpC2Q==
X-Google-Smtp-Source: AGHT+IGFz1kYjtJ2CB63i3kpIK8cbKQBNz86a9KHHAO5xzKcY+Rn5KgcFneR9rdE9iF/27GJgdzSYep0JZHDL1qb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:358f:b0:48c:403d:4428 with
 SMTP id ada2fe7eead31-493c4b17e64mr40150137.4.1721783481412; Tue, 23 Jul 2024
 18:11:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 01:10:34 +0000
In-Reply-To: <20240724011037.3671523-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240724011037.3671523-10-jthoughton@google.com>
Subject: [PATCH v6 09/11] KVM: x86: Implement fast_only versions of kvm_{test_,}age_gfn
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	James Morse <james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

These fast-only versions simply ignore the shadow MMU. We can locklessly
handle the shadow MMU later.

Set HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_ONLY for X86_64 only, as that is
the only case where the TDP MMU might be used. Without the TDP MMU, the
fast-only notifiers will always be no-ops. It would be ideal not to
report has_fast_only if !tdp_mmu_enabled, but tdp_mmu_enabled can be
changed at any time.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/Kconfig   | 1 +
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 6ac43074c5e9..ed9049cf1255 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -24,6 +24,7 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_MMU_NOTIFIER_YOUNG_LOCKLESS
+	select HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_ONLY if X86_64
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_DIRTY_RING_TSO
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 919d59385f89..3c6c9442434a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1641,7 +1641,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
 
-	if (kvm_has_shadow_mmu_sptes(kvm)) {
+	if (!range->arg.fast_only && kvm_has_shadow_mmu_sptes(kvm)) {
 		write_lock(&kvm->mmu_lock);
 		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
 		write_unlock(&kvm->mmu_lock);
@@ -1657,7 +1657,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (tdp_mmu_enabled)
 		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
 
-	if (!young && kvm_has_shadow_mmu_sptes(kvm)) {
+	if (!young && !range->arg.fast_only && kvm_has_shadow_mmu_sptes(kvm)) {
 		write_lock(&kvm->mmu_lock);
 		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
 		write_unlock(&kvm->mmu_lock);
-- 
2.46.0.rc1.232.g9752f9e123-goog


