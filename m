Return-Path: <linux-kernel+bounces-363879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C099C81B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9702A28AE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F01C75EC;
	Mon, 14 Oct 2024 11:01:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8B1C830D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903672; cv=none; b=J6Jl2R+eMir3BxaN6q7vKkaPWG4/qo2lYAlJ/RnChBM3/SlfnTQcuyyalFSTYwXo+ifAE1Rg8tw7q9WiWJci5qXElwNwWYhBgOR4gDUsdC8XlkhtwwFCmYrRyBgQsdJeBiRrSnpPfuvQc8sCeVmkNwTR+Wg+XEOCLHjtdpcM664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903672; c=relaxed/simple;
	bh=H/vqBylW/8P4IpHWUutJFZVlfcQEOfAT/LHhARXtxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkoQl6EIiLf7NyiwlVayoGoNuxq/9l0t7U3fpX8irL9n0ZfMJNzbFToSf9j0397DtAa9O2359eW592M7s27tve/PHiof+bM5f4fLlFrY9W3WdF9sm3bj4D4MReHNOdbTydh+Ih6ShoLYgv0qCcgeV2qdd2qQ4H8wtYbEdy/nbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B62B016F8;
	Mon, 14 Oct 2024 04:01:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78EA33F51B;
	Mon, 14 Oct 2024 04:01:08 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 33/57] random: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:40 +0100
Message-ID: <20241014105912.3207374-33-ryan.roberts@arm.com>
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

Update BUILD_BUG_ON()s to test against page size limits.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 87fe61295ea1f..49d6c4ef16df4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -466,7 +466,7 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
 		if (!iov_iter_count(iter) || copied != sizeof(block))
 			break;
 
-		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		BUILD_BUG_ON(PAGE_SIZE_MIN % sizeof(block) != 0);
 		if (ret % PAGE_SIZE == 0) {
 			if (signal_pending(current))
 				break;
@@ -1428,7 +1428,7 @@ static ssize_t write_pool_user(struct iov_iter *iter)
 		if (!iov_iter_count(iter) || copied != sizeof(block))
 			break;
 
-		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		BUILD_BUG_ON(PAGE_SIZE_MIN % sizeof(block) != 0);
 		if (ret % PAGE_SIZE == 0) {
 			if (signal_pending(current))
 				break;
-- 
2.43.0


