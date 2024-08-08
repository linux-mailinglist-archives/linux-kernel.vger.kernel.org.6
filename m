Return-Path: <linux-kernel+bounces-279959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747394C3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5026A1F21E80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D411917CC;
	Thu,  8 Aug 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1ZOeR6X"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA61917D9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138996; cv=none; b=WbteNbldhxox6+doGKPCZCYQpSw6/25T3tyBxQ7q4PGS1TjM7EuC1V1CA9RfpzmylvPJzpaEL+81+ureJvgidaahkuXT+krw/+DQmI1CKOJZl/y3jeFVNlNBynhr3rZFAh0WjlnJsoPWZngmL9dylEObY/WgyLBhYL8JoFu9nKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138996; c=relaxed/simple;
	bh=86H8Hq/QrVp+2XHWtnQLOHjNx6b6/aA0SVYTRipkXQo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YfKrMTxfC8aoVkh2imlNS/f/fUMm9iVFOyhS3znmLau3r8yfN7I7Jno8vOIRCBgAA+RYuxU/SqwaTj5KYatytiUhOijz6ufr8fXQiAUIRuN/knceDhSL9jj+I6mG8vSmFHNVk+IpMif8TB+r+qWLLbtvJp/oIwF1kGLbxJpl1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1ZOeR6X; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68f95e37bbfso28637927b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723138993; x=1723743793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4+1jkb/kSvflaKrQy8nLqEfji7x/G0gMXefyaO4Ttzs=;
        b=L1ZOeR6XdnnHhgekiLjOqSQHwNnZ7mr0vm7do/FJPnjNttxoK2RPqUVYNkBOAr8Pgh
         UPsxV1azor1oaAlcYfDhDNChjptEkQjcgKFaSe7uBhEf5ozixUvzp9fcxK0bcuZzmj2D
         o8pVNsRak9BDNszEi7JrilF/DEwG9i89TaOla01C89YnTAnMulVEDXDyM7faMFWYY7JD
         4TnknO0vwmEbXMVwOQhs2PP186MIeqss1HSceJUGEBr5H81d5jewPZxJRZkfDaGvpl3m
         deekAGj8kgNBOYezD8MInYGgYdUM9hug8W00Dl464I+M4MDNPJOiEXjZGdeA/TzqjE0A
         Kz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138993; x=1723743793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+1jkb/kSvflaKrQy8nLqEfji7x/G0gMXefyaO4Ttzs=;
        b=hRN4ZMeD1MkRjBLhdvKnU4/83pldGbWIRQYfbCCVy0XosdtDAdP5yKMA8kwIY5q14U
         S7ya8Ni8ag6I9NzBVjNrquNnaC6Jx1L9pz14LdoDw+rKPCLS5pfzeWQAS8nXbEtsHM51
         QhGPkxMm4MLZy8q1pMd98fOlZEbfwfp7lgzWrnm2C79XBMe1T5slt0TXCwTqxpWyimUZ
         pS7r4IDDUnyOoiAL2IvWHCP6IAfANxJzRug4JH1lTjqPiKPJEt/3CGedy9CjwzGtJl3p
         lgSvkfCqq4VaU+JLgyKpu74SEE+Lk5r5RR50fe738rFERhN9SwMHBRhSWHlyCLZPNb5i
         By1w==
X-Forwarded-Encrypted: i=1; AJvYcCXbcToy1m0lEOnyA+xXiIQ+xaQ0hi1QGcpJnB3vBjEwbiF0DQc4TzKxafX1+pOzcTtRu9zN7iyBdES+GbGvcv99r3qfWVlCu227/THP
X-Gm-Message-State: AOJu0Yzts5ZxPWOut01SsjMRt/vYFZ1Vw7NRHZysBjvOs3V3ib/3uYXW
	StRsDrAIbHnSFnvOkeO1Pw2ecGkGmqqAD58t97EXaEGFldM8+iktP4nDRG2mJaxBXzWFo37tR6U
	FFZ585Tv4ByD/uJSDNwP/Bw==
X-Google-Smtp-Source: AGHT+IFI0rnzef7ISFTxPTkBDSrqwcN8rzvq+R6/y07Cu867kKIpT/4oVZnVFq4JrZ5GCRkcJ1KbtYBJHpkWdkmDpA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:961:b0:62f:1f63:ae4f with
 SMTP id 00721157ae682-69bf6f7ec1fmr200267b3.1.1723138993566; Thu, 08 Aug 2024
 10:43:13 -0700 (PDT)
Date: Thu,  8 Aug 2024 17:42:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240808174243.2836363-1-coltonlewis@google.com>
Subject: [PATCH v2] KVM: arm64: Move data barrier to end of split walk
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Ricardo Koller <ricarkol@google.com>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This DSB guarantees page table updates have been made visible to the
hardware table walker. Moving the DSB from stage2_split_walker() to
after the walk is finished in kvm_pgtable_stage2_split() results in a
roughly 70% reduction in Clear Dirty Log Time in
dirty_log_perf_test (modified to use eager page splitting) when using
huge pages. This gain holds steady through a range of vcpus
used (tested 1-64) and memory used (tested 1-64GB).

This is safe to do because nothing else is using the page tables while
they are still being mapped and this is how other page table walkers
already function. None of them have a data barrier in the walker
itself because relative ordering of table PTEs to table contents comes
from the release semantics of stage2_make_pte().

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---

v2:
  * Added more information about purpose of DSB to commit message
  * Rebased to v6.11-rc2

v1:
https://lore.kernel.org/kvmarm/20240718223519.1673835-1-coltonlewis@google.com/

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
2.46.0.76.ge559c4bf1a-goog

