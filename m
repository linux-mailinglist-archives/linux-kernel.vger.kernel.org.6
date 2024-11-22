Return-Path: <linux-kernel+bounces-417872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC49D5A17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9319EB2221D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3769170A37;
	Fri, 22 Nov 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="guTVK73O"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129941632E5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261038; cv=none; b=sqo4WO97tcIQO3rG0evLBWV6u/Qu/OhQVM+qXdjTxWrJMZnhPkbK9UTPyGTizjqVUz7OUejS8i4wlQVd6cQAG9H3xliA8VGMKvDowmdh8jAV2oQE4vhDjTo3yd/PpwSV5KN6Zns612ANCfrNK2OmORSGdtsiuymEPLqBUlV5hiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261038; c=relaxed/simple;
	bh=GqDLA2aJbcyW2sNZqwXdHIKsQ4D2f2/gHOwOecSMJTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAytswnw4nqLY8eWR65oqEHreTJUVeVqqEvvSXI5STkn60Dx2bdmEfun48fFHuTlVRIClNAHs/f7oUuMNi2nedoOXrr4Mwl5qtNXnUNgi9BiiL/Y1WTN8XQcWUIaFaeyyJu5jU0BCHKPw93SR/B9CwTUwktS5k8pUk0qnkzx1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=guTVK73O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1545147b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732261036; x=1732865836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV7gLq0Dv5b58r83fWTxkWC1hdPvA2dZ9u+ZCszo9Js=;
        b=guTVK73OXWDS7csVHtxqcCTF0Ez1U9wX/DF7H7y6GRlwMctTY1+qhlAO7iF7ZRflkp
         Wtq2YpKgRDZaGQIcOQFJu7v2hho5tiLjFXMjbgXkreZZTvjJtjC30s6o1YAv8QY53dRG
         LsrdqfHSGNLrHvluZRs3KpErSp1pTrv8oZ5keiw2/Q1z8BKXo0q63q6UeofMtYBboxeg
         EbNfw9HW9YBH471kxQuHg2rnVuftg2L8Vj7xiw+NZ2BET1+1fKbru1B60O3SZzPleuhW
         kPhoLx7nm9j9QpKVu9RCbOSistTXAaVcxeAElankHdBscoabXKn1X9RrFfzMNKkE9s47
         mjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261036; x=1732865836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV7gLq0Dv5b58r83fWTxkWC1hdPvA2dZ9u+ZCszo9Js=;
        b=U8Dpi9wS6HNjPe6rw8uHJLXtv34FX4XPN4QsSL0uXi+PAwhHSOwGGqraMA07In46Zv
         F5mu4l2hIH83hjiMvrHgYPZAFvOtZQZCRYJZjo8lw3kKkVUqXHLDrOUuaqrK5WxbhTEs
         n+Ypb5dOf+s9SHJop1FfOj3fKGyjy8oauKk1knEWFnUH9mrtGDZtvLqSfMrJHPYP4Vtr
         yTnb5wUWp6WS1w6w0zmJZZX+rB2KiUVQjQYeRlrFAx34jFkcjyE1BDX+zWUVo6EVMSW0
         2wjoKJ5rl/ZstC2R4o7iBqyb+JY5fmus8dGEf1tHlK4CHkLfT1hcQpytOjjcLTouO5Or
         Ss0A==
X-Forwarded-Encrypted: i=1; AJvYcCX1wzVj7hNjZMOEKARljJmwU/7s2qjaQdh+RDPsozZaq7w5I+9wKPDu7Lt0kjc+/ODcWoJW+Zfyt5yuVK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLX8PEapq/LacX8i6NDYoLdjfrWlOdTNDe3A21fNPRMUWihXj
	I/qb+wvyII7EE1eoFpE9ORWwixVqADPYwKXEG1wS/p/ljPwVd8Ac7Uqjloi5bq0=
X-Gm-Gg: ASbGncvhq2sWZ4Xw6nfsSyVLr5WatyyVCr0XrLD5FK05taGEGAnYKrtAFp1OOxbVwpi
	YzbJoJ0PyaEoQNdFkpkmUSnjmSprsPMLJRWpUZg4ORWBthBClfsx90Fkqo6qVoqzui6QvIKP8wd
	MNwmkLQcoOZh+w1NahwUmGoHE3s2HFPgeTJyH7Ab79xdi/fcQGanqY1ax0kKwWOPAL/P9XUWTMF
	zAwrExpZVhovyf4cceBkXAbG8ekSnFRLQ9SphGnSPTMrdF5ck8s+ILstntbVGUaTNS8B8JWZ3zU
	B+B6A1AIRak2DQ==
X-Google-Smtp-Source: AGHT+IEulizdJJtMylU5KZsgvUSMXtgdwGEw2Ghn/IeTkwaWvM2EMmiAvOUJ1bOFUVxdjfkLEjgd7A==
X-Received: by 2002:a17:903:1c3:b0:212:51dc:3d51 with SMTP id d9443c01a7336-2129f56fb86mr19675655ad.27.1732261035313;
        Thu, 21 Nov 2024 23:37:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8cf09sm10084205ad.4.2024.11.21.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 23:37:14 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: pasha.tatashin@soleen.com,
	tongtiangen@huawei.com,
	jannh@google.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	jgg@ziepe.ca,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2] mm: pgtable: make ptep_clear() non-atomic
Date: Fri, 22 Nov 2024 15:36:52 +0800
Message-Id: <20241122073652.54030-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the generic ptep_get_and_clear() implementation, it is just a simple
combination of ptep_get() and pte_clear(). But for some architectures
(such as x86 and arm64, etc), the hardware will modify the A/D bits of the
page table entry, so the ptep_get_and_clear() needs to be overwritten
and implemented as an atomic operation to avoid contention, which has a
performance cost.

The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
check") adds the ptep_clear() on the x86, and makes it call
ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The page
table check feature does not actually care about the A/D bits, so only
ptep_get() + pte_clear() should be called. But considering that the page
table check is a debug option, this should not have much of an impact.

But then the commit de8c8e52836d ("mm: page_table_check: add hooks to
public helpers") changed ptep_clear() to unconditionally call
ptep_get_and_clear(), so that the CONFIG_PAGE_TABLE_CHECK check can be
put into the page table check stubs (in include/linux/page_table_check.h).
This also cause performance loss to the kernel without
CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.

Currently ptep_clear() is only used in debug code and in khugepaged
collapse paths, which are fairly expensive. So the cost of an extra atomic
RMW operation does not matter. But this may be used for other paths in the
future. After all, for the present pte entry, we need to call ptep_clear()
instead of pte_clear() to ensure that PAGE_TABLE_CHECK works properly.

So to be more precise, just calling ptep_get() and pte_clear() in the
ptep_clear().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
---
Changes in v2:
 - add a comment (suggested by David Hildenbrand)
 - collect Reviewed-bys and Acked-by

 include/linux/pgtable.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index adef9d6e9b1ba..94d267d02372e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -533,7 +533,14 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
-	ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = ptep_get(ptep);
+
+	pte_clear(mm, addr, ptep);
+	/*
+	 * No need for ptep_get_and_clear(): page table check doesn't care about
+	 * any bits that could have been set by HW concurrently.
+	 */
+	page_table_check_pte_clear(mm, pte);
 }
 
 #ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
-- 
2.20.1


