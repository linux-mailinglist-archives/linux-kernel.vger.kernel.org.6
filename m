Return-Path: <linux-kernel+bounces-363877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D857399C818
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D73128A80A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D21C7601;
	Mon, 14 Oct 2024 11:01:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49101A4E84
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903670; cv=none; b=cChdcgaYB8k9PRaNo52Fl5Os/O1BUoeZMpcVI8G9xFWpGV3o6hlZ3UkqOYimZtmsO1pOTm+/qQsS1QhU4xbhP/rhExgDr+d/jzrSgO5Nl7iY7mfeyn5xnmGOKtQQ/psv3iEyFJsYhSsoddnVXcGHltZTvPzqos1pVuEkJjX8Cog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903670; c=relaxed/simple;
	bh=HplFCyKdDS9/C8qHLpPqN3zSWfPRYmtXcxIr6UPwB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8g+SY3YynYkNb5LRLb8uNGEMQ/ciU+XYTwRxl/mvvXMaHlHVMIfIMSWWjBQwFTbHk1OcBpGine/3I0laleuX3cpVaAMvZoUfjttGrtVSgVrfetFF0LeC1N6tM4ZxMwGjl23fV6zu53TNoqzXuMYjaKI8BpyJXpcnfo6Fr4CIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AA116F8;
	Mon, 14 Oct 2024 04:01:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A33C3F51B;
	Mon, 14 Oct 2024 04:01:05 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH v1 32/57] optee: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:39 +0100
Message-ID: <20241014105912.3207374-32-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Updated BUILD_BUG_ON() to test against limit.

Refactored "struct optee_shm_arg_entry" to use a flexible array member
for "map", since its length depends on PAGE_SIZE.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/tee/optee/call.c    | 7 +++++--
 drivers/tee/optee/smc_abi.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 16eb953e14bb6..41bd7ace6606e 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -36,7 +36,7 @@
 struct optee_shm_arg_entry {
 	struct list_head list_node;
 	struct tee_shm *shm;
-	DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
+	unsigned long map[];
 };
 
 void optee_cq_init(struct optee_call_queue *cq, int thread_count)
@@ -271,6 +271,7 @@ struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
 	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *ma;
 	size_t args_per_entry;
+	size_t entry_sz;
 	u_long bit;
 	u_int offs;
 	void *res;
@@ -293,7 +294,9 @@ struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
 	/*
 	 * No entry was found, let's allocate a new.
 	 */
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	entry_sz = struct_size(entry, map,
+			       BITS_TO_LONGS(MAX_ARG_COUNT_PER_ENTRY));
+	entry = kzalloc(entry_sz, GFP_KERNEL);
 	if (!entry) {
 		res = ERR_PTR(-ENOMEM);
 		goto out;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 844285d4f03c1..005689380d848 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -418,7 +418,7 @@ static void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
 	 * code heavily relies on this assumption, so it is better be
 	 * safe than sorry.
 	 */
-	BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+	BUILD_BUG_ON(PAGE_SIZE_MIN < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
 
 	pages_data = (void *)dst;
 	/*
-- 
2.43.0


