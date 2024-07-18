Return-Path: <linux-kernel+bounces-256811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3099370BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0741F2250E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D79145A0A;
	Thu, 18 Jul 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7cwWVWX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51099146595
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342128; cv=none; b=V/eQE7V5zDirDpjQhW2mm5qPPyyCbNT/k/upgO2XGMm5T/M9PFNWeygqZeGVTFN+hazgRopH/QI5D05POztBNJ3UUSVUZ6HYyUv9UGYeBP/lc/HiNtVIvDrk7btDIgPAr9jOis4uRmvFk977GpNMvppGDRVfxNVXk6MbF55mbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342128; c=relaxed/simple;
	bh=YDpDr4yxWaBJNXkK2yYee40+CDxF3GQ0b52/63eIRv0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pxOZiBiZgxHZ2TNmJd4YG+uMUbuFb+PeSnSXGjIpFVQTspfpYbz1j9WhcSyhhriDyKNwfq1DcTdfsqsx4paS3RW3EVewOzg7DCtZC0kK4XB1YGKh4G+B0TP0KzQ24el8Scx616UWKZzlu0JHR0uRjOaP2hFfJBDmGnTiOmAnN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7cwWVWX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-665a6dd38c8so37114347b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721342124; x=1721946924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t17NNug3pGXskbylK7023fOephyseDv5XvuuntGRCyI=;
        b=l7cwWVWXYbvOX9Qf3qSUn/wGUoHJOn+UUKIf8b7HO3UNvpRUY4EvbFUvfq+0hqtBf2
         lT1DYPFB4beq0qBDO/16c1XjrUe9S6AhtcVpent3ZqFVu2agbP2iNQr2ugS0nle4n7e3
         dZ5FiHCR0FgAcVNXfN3/ktgEckxHkiNN6uWj0I6mKVMy+jGxlN9Lm0fjCF3kmuDSNNkf
         5FD+2k5YkLAzyIW+wvwn7ekjOBT+EwED/MlbIEQF4qx3jsD4ROf9NzO4Tl8u49Qn6Pox
         F62WERJsAmeu/LDNjSsdjzL32yNSYmz/QOSiTdr7nfs+CUicWQ1Opu21NHYWz/Aa3wPO
         oQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721342124; x=1721946924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t17NNug3pGXskbylK7023fOephyseDv5XvuuntGRCyI=;
        b=Knbh7CBt14ZJ6c+rrG3LjjYapOgOLwrpvgaOzvftghA4iD7mEeWH1iepD4nFf9F1LA
         f/yYfh0Krhldeatg3zXVjn+T2E6tXLMLavI3+myaS5K1ERNq2nI8Q0IVGx/zUagySvZT
         GsMbrd9rTOjKK0CcqKcR05/fmx5+dPZ2Ov00fbD5Ta6hdFVTtqXLIzLJgFNeSMcMBfOk
         DGMV14CuafBV716OvKx+2ZIKXXwc6psYIP5XbpFTaVXXAQr/ff42lrg/zeK5+9aJsjcE
         mti4zKCF3WHF2ahIPe6Ho8WzM0vvUnR19yvPDyqVh6c7TRBpw+CssxCK6HXWSJovQ0CR
         KyWw==
X-Forwarded-Encrypted: i=1; AJvYcCUthgL1nA7PEqtdtCKa39VSgdanTX7T3pWpbWUnIcGbMhHBuGrJCnyoB3+TBqJIw4IeLE7zrwYFzXchbIWXLPtz+QNi6nkuwf7s9UC0
X-Gm-Message-State: AOJu0YxEXzgFtHMfvvJA4DcaYheidw1pETty+K2eFe3yuSp/PpGY6Gdd
	NOllJgsrAL2Q452NUoBdhCm2qCqHHYzdcQA9PAH+E2NFGqrnoNpce+RjFjrU35mH5+pZhdxCZpL
	nx4fZb+lNhPMNjMQ/1WQlkA==
X-Google-Smtp-Source: AGHT+IFAzxmz+xd5k+TsYOLSlTiwpUEcd3PMTkPrko0oISXqajR79Y7rD10ay46njNzlCvfw2OfNGwggk1RAW9y4Sw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:f94:b0:627:a961:caee with
 SMTP id 00721157ae682-66603127fa6mr1628197b3.4.1721342124251; Thu, 18 Jul
 2024 15:35:24 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:35:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240718223519.1673835-1-coltonlewis@google.com>
Subject: [PATCH] KVM: arm64: Move data barrier to end of split walk
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Moving the data barrier from stage2_split_walker to after the walk is
finished in kvm_pgtable_stage2_split results in a roughly 70%
reduction in Clear Dirty Log Time in dirty_log_perf_test (modified to
use eager page splitting) when using huge pages. This gain holds
steady through a range of vcpus used (tested 1-64) and memory
used (tested 1-64GB).

This is safe to do because nothing else is using the page tables while
they are still being mapped and this is how other page table walkers
already function. None of them have a data barrier in the walker
itself.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 9e2bbee77491..9788af2ca8c0 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1547,7 +1547,6 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 */
 	new = kvm_init_table_pte(childp, mm_ops);
 	stage2_make_pte(ctx, new);
-	dsb(ishst);
 	return 0;
 }
 
@@ -1559,8 +1558,11 @@ int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
 		.arg	= mc,
 	};
+	int ret;
 
-	return kvm_pgtable_walk(pgt, addr, size, &walker);
+	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
+	dsb(ishst);
+	return ret;
 }
 
 int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
-- 
2.45.2.1089.g2a221341d9-goog


