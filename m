Return-Path: <linux-kernel+bounces-288827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436D953F33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A256E1F213F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBF3BB30;
	Fri, 16 Aug 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ObVO3nUu"
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB21DFCB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773617; cv=none; b=kL1e6d0Dw1I/8SV3p6HH30W8WJI7CyILDBDB2OzwpQP2YoTwvo12q45S2vfTlkXouNcMiNYHbFLiGcHbK0FsyLdNq1IF/ek8dv0twKxjK0/LZJ/+BnAhQB1/b+3BgHf3XbenV0N1xtUZi4d0CIV4eGmTwQN0iXg1muuvJKtfBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773617; c=relaxed/simple;
	bh=xUHAMMt5CPV43RQEHQURLk5SuPKB5Ii2393sz9l5A1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvZrSH8h16HFsAEzQLCfpREqX3ERBwvB6bqzdJYQEIMrzMFMWMbqthyY0BoM9ME+SUFmdaocrRPBYRlza02fd9cEVviZ6/HhmRvlpc/rHbi7pqYHUrwNUHDM+k2Ewd8N5kA0bVF8jIDWSFnIg4G2CVU5QLPiem/WgaS4c8KfJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ObVO3nUu; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773612; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=;
	b=ObVO3nUu68ulowo3D/xh/idBQyGjaad9zDoW6j4L9dQJ8g6RD7hgdGugLVa2DNA2Zhtp7wIyGao6OIPjBrllMKwbuwCWhsfZD78uC7GEh81jnmo4H+hznvno88uZtMqaUZMvhyDGmygXOI+yYrdRbRTwwRmeM+c2a7BJYqnzPOQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBoj._1723773295)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/6] um: Remove unused kpte_clear_flush macro
Date: Fri, 16 Aug 2024 09:54:42 +0800
Message-Id: <20240816015447.320394-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has no users, and __flush_tlb_one doesn't exist either.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..83373c9963e7 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,11 +359,4 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-/* Clear a kernel PTE and flush it from the TLB */
-#define kpte_clear_flush(ptep, vaddr)		\
-do {						\
-	pte_clear(&init_mm, (vaddr), (ptep));	\
-	__flush_tlb_one((vaddr));		\
-} while (0)
-
 #endif
-- 
2.34.1


