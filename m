Return-Path: <linux-kernel+bounces-363864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229999C7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C6B1C244D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8DC1AB6DE;
	Mon, 14 Oct 2024 11:00:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0A19F42F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903627; cv=none; b=PgsVBi+EQ8yLzWW3VktY/d6kkzUT94ZD9JeaYpwfkPkTCQj3WH0jXmufbxmoHH/QK6JD6cZZg97+vWR5TS8FFbbE1MvFYXsQywfJnoSRzJPh70nCuA6CM7TO2Eq5hVDL0hxtLGUviHi0TAJAbcDl5QdNV19e0JH8tbLMY/2Qf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903627; c=relaxed/simple;
	bh=3/2HPrccl30005OylBE12Sv8lUu1WsbUJyhSWNkJQ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuNA5sMr/37/lGf3g54Ad5W7m8QkZ6azWXnLcA6XobkVMXQKpwskCNi8gmzjVhgZMyhtSBxJaaxtkuz19coEdAudPDlB58wzk62KWuwjPhLC/VDGm7NV6bpSGy/OanSwUiz1iCZ2Z2RWWX5MQJ855T1aSKoi2ztFdWK45QMD1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5428F1684;
	Mon, 14 Oct 2024 04:00:55 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F953F51B;
	Mon, 14 Oct 2024 04:00:22 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:26 +0100
Message-ID: <20241014105912.3207374-19-ryan.roberts@arm.com>
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

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6eb..978c600a47ac8 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
 	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
 	 * definitely will be in 2 pages with that.
 	 */
-	BUILD_BUG_ON(size > PAGE_SIZE);
+	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
 
 	crash_notes = __alloc_percpu(size, align);
 	if (!crash_notes) {
-- 
2.43.0


