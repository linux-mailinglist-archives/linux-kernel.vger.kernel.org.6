Return-Path: <linux-kernel+bounces-560163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D68A5FEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039617A3791
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DD1EF393;
	Thu, 13 Mar 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNYbY42D"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C331EDA0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889507; cv=none; b=DImIOeshHs9n6Vai0PPj6wKEar8guSPLQu2qpqpqBI5Kw4XnITuNmq6Hp6IALOGqC5bD6qYvbSGjpdAj2sByI5vLJv43FB0fxkR1D1wOdUxZdvlPeKQLxccvkJEqYS6Lwf8fNJDKaIsJe8XzpHbu2UsxNuNi81zBXzqMPE7Gnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889507; c=relaxed/simple;
	bh=QoFHdORegggk6C1oj4h2wdr/nyVe2zV7VnrZowp+f2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flSuz76KghgyaikbeieG78q9fRyej4YuEIHrGBIH1WIOWuKT7GXivIbMXZaok2g63GREObcWtj2k1VmfUX1lrEm02sxjQFyVrSgvP9id9SpiWJczLS7CE7lsnWMwK7i0RB7gagv9UhAJXLocLlSdI0k87I/melRcavygR1hHwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNYbY42D; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso715436f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889504; x=1742494304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd3MTUJa5EaKKcsOqm6EUTHveqQqPDqzenzbNHF0zNE=;
        b=NNYbY42DBvqILpRNc4ZmVT1AWj+z3pnxHvCazzJFSu8MQw+ygRVnPJeHQ4/Xkw3W7s
         AzDfm5ziIK654UUOWbq1YV3E914d2LWTlLXXznhd8nAOdeai7+T1YX5a6qh6LOypVdsy
         X3IUDaSzKbt852Qlkckvf591OU3ed1yzb5M2gbdwgsQ2NH6ztff+Zx8BhMfE+rSnO7IL
         fwZD91qJ0LaL0W/c+HDADBSNEgEwHbGxq/9K1Ari3LlvzPapXO0jy5BDs00ov/jL3hqV
         jq5lYl2yghm4UVw74HObrWD/yed+uwZ3GCSMOwakUS+3TVcqmiRtwYGJyCdctp2/gSKZ
         GGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889504; x=1742494304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd3MTUJa5EaKKcsOqm6EUTHveqQqPDqzenzbNHF0zNE=;
        b=lDrLHFW/2V7qs/tcpezg4Zpevvz49SSNNdHh7wWn2IFov1z+8Ndtg9BxPM1QFvqh9C
         2zIx3Nqa3ZsxnrkiYvWDMRgl2QXomFkneUD2sK+NJ9U/Yw06hVoZ98zId/iWWQRLJcV8
         jTzBwfUQmfju9lxfnJXBY6f8hJdB/knzZt1Io+rM+Esx+SO+uFrlag1VOrd7ZfRiEAAi
         w9ByFukthOhpeDDE8ADP7oB3JF8t9IthIzEc0/cVxzSca/z15beNuDeN6Z94Y/aMRwIR
         vQWOBQ5/uMGEpRrpiMu6dSTs18Ozpj2MxkIg7B1djeqWqq9im80MTsOw7lrA3jsLV16x
         GJSg==
X-Gm-Message-State: AOJu0Yz6JBH3tWEJnBsNPH8+k+MONJTxwtvkJKkxtjbjk37IFgjmhFRc
	2ciOP5wkvmkHS6i/oKnL17kSuZgLQ/ZdKlpk9JL4NquRX/tKiR3ubW0lAA8aVHs4uVnoqXpGcCb
	i7amaMbnX+A==
X-Google-Smtp-Source: AGHT+IFsOBeq83+HmwcjVeSsK8GiNED4UzJeglwlfgEFKTnF1muToCLx1a+QuwroI+KWJKQsz/7UlqSE3IjxUQ==
X-Received: from wmbfp13.prod.google.com ([2002:a05:600c:698d:b0:43c:fb36:c419])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:8b45:0:b0:391:9b2:f49a with SMTP id ffacd0b85a97d-396c3e16b07mr499843f8f.55.1741889504104;
 Thu, 13 Mar 2025 11:11:44 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:21 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-2-04972e046cea@google.com>
Subject: [PATCH RFC 02/11] x86/mm: Factor out phys_pgd_init()
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

__kernel_physical_mapping_init() will soon need to work on multiple
PGDs, so factor out something similar to phys_p4d_init() and friends,
which takes the base of the PGD as an argument.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df3036bd185cdb3f54ddf244b79cbce8c..8f75274fddd96b8285aff48493ebad93e30daebe 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -731,21 +731,20 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 }
 
 static unsigned long __meminit
-__kernel_physical_mapping_init(unsigned long paddr_start,
-			       unsigned long paddr_end,
-			       unsigned long page_size_mask,
-			       pgprot_t prot, bool init)
+phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_end,
+	      unsigned long page_size_mask, pgprot_t prot, bool init, bool *pgd_changed)
 {
-	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
 
+	*pgd_changed = false;
+
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
 	vaddr_start = vaddr;
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
-		pgd_t *pgd = pgd_offset_k(vaddr);
+		pgd_t *pgd = pgd_offset_pgd(pgd_page, vaddr);
 		p4d_t *p4d;
 
 		vaddr_next = (vaddr & PGDIR_MASK) + PGDIR_SIZE;
@@ -771,15 +770,29 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 					  (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		pgd_changed = true;
+		*pgd_changed = true;
 	}
 
-	if (pgd_changed)
-		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
 	return paddr_last;
 }
 
+static unsigned long __meminit
+__kernel_physical_mapping_init(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask,
+			       pgprot_t prot, bool init)
+{
+	bool pgd_changed;
+	unsigned long paddr_last;
+
+	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
+				   prot, init, &pgd_changed);
+	if (pgd_changed)
+		sync_global_pgds((unsigned long)__va(paddr_start),
+				 (unsigned long)__va(paddr_end) - 1);
+
+	return paddr_last;
+}
 
 /*
  * Create page table mapping for the physical memory for specific physical

-- 
2.49.0.rc1.451.g8f38331e32-goog


