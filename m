Return-Path: <linux-kernel+bounces-394931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C809BB635
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BCA1F20FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BE1B3957;
	Mon,  4 Nov 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMjC1tB8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC221B218D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727150; cv=none; b=oVmDDAWKcaOFCscvMjyA3AoSHpKCDaOW6qs4IUyp7eNe3Nm/yUKuaBZDDsfYQOwYQlCv/BVkGR/P7McBYNPUgN0rI39SYMMh75nT98usL/1kwWcTdicMhzCUuhQM/vspkOgIesAS6AFpb2ZrXu3Meyi2iR7/KxQh/kOa0Q9Kwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727150; c=relaxed/simple;
	bh=Y+NcSPecdDDpRmAMDV3kFDluNG6PwbZtKm26naCPO60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k44WbAs73pd9xXDHZ+/uchJLrsDDMdLZKl/busPxekRw/06ystOctpzIx1BQXtgKCWoeLBKmIkaqIufbzaul4/0KAQPFxkrIkkPhzvYyi5WrP7RrOfxwLnBYzLxN+n5iZpuvDHPShrr2Rdglamz7WT9s1+yUjLaluxkfwUhLR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMjC1tB8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so8366578276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727145; x=1731331945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRaBXKWmHCm6FdE1Chl6Fbm7Oz0LIxurr/17hTAqXWI=;
        b=FMjC1tB8EkslWq3ABut9zhMVG7McWt+ZkjGH981FBECinaTXmX/ApJfosju0yDJB5D
         8GivCbr92b8JQ0x7uo9B7FE0QgWiudpDefIShDr9o5k/wXHHyLPTHhWAq2D0EB/uHj6L
         Xvsba/6hPy9P7vPRK9gMTUuNkEh1bUEFvosc9TWWGT7Jskdti8z70CyosabZEeJ5G0aH
         VC6luOuY9EFic5fSSDrs+HwLpsEXJxSwMNBxlfVtjN8h7Qn8Oqc1fSZpowswFNp0Rbil
         eWMlIR5GJ8Fb77xlNnYxIQUVRdYTiaRrbGxpbPJCU+vu2m3Ii2q6BMctR0mNEk3kwUsJ
         iduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727145; x=1731331945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRaBXKWmHCm6FdE1Chl6Fbm7Oz0LIxurr/17hTAqXWI=;
        b=KVeLXJBZ5xZiMy/YHUIDuGTlAwG6dSbKuPxdu/7YIkqeECm2t6sKfsd4Jppf9jYwVQ
         LYKFE9M0nEO2rvSIywREVGGU7yl9VmrypJs/ctYX9bgbG+LrBOwBzO9J1dNxvjt3wPdO
         8ZkzyZEiM9Lp2km8Ca4erjrKPE6FT7p+8ILYxE7QoR0p5GPA5CzNoY6/OAHRfWZZZe0Y
         x8XP8GgSX7P6Z/erPpOxhHTNQq5A68LnV3/IFvtY8M2XARY8TsMCbgNKRpdXqyZEVb2c
         XPfpwqO2PRJLJMsEQ24/S27ry/s0e2uX1QI2OT6gw1yJFKuooksnOrBFXS1PAn2CsxYN
         H0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokcPp0mk5eMvEEEA8dZm33BoCXqi9s7A+xJEyhyhjQahPTkqFpJNLUF4vC7elgEQNK433EKLegkkC/50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pvX40V2s7+l11dvia5xEqLzTdT+Zh8KiIUdwtZCAqxvpPY+/
	YK9uvwYBhxtWPr/Fa6hW9ZFIDPI7sRE876NSqQl96p2Na2vgHKRsQarVTCZrv6GRbdLNvjvaS9q
	a3iCNGA==
X-Google-Smtp-Source: AGHT+IEIRmWbJCJ91gChrscm24F1xHepSdW9Ht8okQQnwSOPBLJd4Dm+SGDL7D1GGWqTGSqt9NEIHueAq4mp
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a25:aa05:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e330266859dmr11233276.8.1730727145034; Mon, 04 Nov 2024 05:32:25
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:53 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-8-qperret@google.com>
Subject: [PATCH 07/18] KVM: arm64: Make kvm_pgtable_stage2_init() a static
 inline function
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Turn kvm_pgtable_stage2_init() into a static inline function instead of
a macro. This will allow the usage of typeof() on it later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index f52fa8158ce6..047e1c06ae4c 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -526,8 +526,11 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb);
 
-#define kvm_pgtable_stage2_init(pgt, mmu, mm_ops) \
-	__kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL)
+static inline int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
+					  struct kvm_pgtable_mm_ops *mm_ops)
+{
+	return __kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL);
+}
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
-- 
2.47.0.163.g1226f6d8fa-goog


