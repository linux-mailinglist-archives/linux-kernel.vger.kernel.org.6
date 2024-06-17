Return-Path: <linux-kernel+bounces-217757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DF90B3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE88B1F271AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044515B553;
	Mon, 17 Jun 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="SwoQeyQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfrE+bpW"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEE15B561
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635175; cv=none; b=SSXemXpNNHkCOTZx6RjkBcjhMz3OX7IrDuPMEWu7e/oDGhpa0otoam6QAPMk2pmjzlbaEr51hbIlkIvN91K8w9SDBAe+9zhN2Mvws1GuE2UrP4lTmm1Z3ICrWF3p4RP8E1G2pjocmRTu7PmmpJJBGyjXJtA852rMDe2q2VHdQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635175; c=relaxed/simple;
	bh=KjGx90/Mk44guEnUP4Jppy6Thcm4cwsS4n/mldWQzAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lvc8TNZI+OFVVwMpW9xiBYeIlEjhL9l1Pzekq3VTyt5ZPeHoCY6Ov3ivcl8cYILbBNW1oZqpFmGh9yU++CSXRIYScEKvQSK4otgg5iLGZWa0vUz6HWiB++WbecEoCEf/jvA7fZsvJY65SYL4u/uH9aJKFlBdlcNeLmcdgjewtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=SwoQeyQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfrE+bpW; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id B53E31C00067;
	Mon, 17 Jun 2024 10:39:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 17 Jun 2024 10:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1718635170; x=1718721570; bh=YTcVxGJJSi
	tBHmI81csUD7sOdb3OERyqcoYJY7uvHYk=; b=SwoQeyQD79h0J0zshDT6H5OPdO
	8i2aO3luQk1ijzRDHHZFe04KOiSxfomStah3hZZEv5lANnsX7BLBJrgyYKhzf0P9
	dZCsa4IL6dFy3jZP7vd8pUFsPoI1cYS1tTbiXWpYoVXxXcee8Nbc/08rM290LFN7
	F9dFwXSPOxWAF/7g1EpNwPjKbbmV9DUf+xexxN8sVhU3gb2XN1mKxSSTO0JzKjcg
	/zIFOA4BU+cyytieWov0Rm5DleLitafnEH2+2ZSXTr9rM53cW8Gz8N7Z1UBwDAcR
	sH5cxP8po9wJcWpAWoBFHUkR+8RxJM8b6X7TpOKSXQb7ot96PAERXU9R4E9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718635170; x=1718721570; bh=YTcVxGJJSitBH
	mI81csUD7sOdb3OERyqcoYJY7uvHYk=; b=RfrE+bpWFhIRKjaGeNT1S2KQjzRs+
	xdifj1Z3+ekeqXh6br9x6VMq1A8zBijVlqf5CIbS3hhGahKURIDB36oDRpXWOmTn
	sOKlgiEb+xY8MbT5MfhgSqHxx7hm2c+uwmupfJ+AxPnok25cCskaZKwHEhchM7hK
	A/mnhNwfCYivmWlFOBcZWrNwRZZSNZEiXc7AcTqp5a+zOEkUmBQorGi7UkqMRHtO
	CY/ErRaU0e7x1ey6aqAKe87JgMvfWurkYHEycFhSitjarP2DTtTE2azCPOxxbeuk
	3TqgXE5tsu6iAB8kSUCQqDMAu3ATXvkVJt8YNR/tPP4geDrwpX0Yh4OLQ==
X-ME-Sender: <xms:oUpwZlCHMA5BUvqXf0FDRWyuQ4tc0M-49VT0rmIh06K8rQWDhX85GQ>
    <xme:oUpwZjiZ8Qku-kzQrp9k_EhqV-KFYOPNOCn3XbVz1y13N0lMYXvnw0HxJtGGoB92Q
    iCcnjB1zdDN4SasmQ>
X-ME-Received: <xmr:oUpwZgnlhhJh0KtIKBAmf-4-IaXre7cTg9u_lUEPaV9-ohmmOjYk0p7JkX-tO5Kjo_ntalgOeKXqrgxxU6OR2ULttvE5gwH_6g0IW5iTdH4ilVavY6_lk1tI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeffgf
    egkeetudelueejveefieeuieffheduteetudeuffejkeffhfettdeihfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:okpwZvwGZUyBLJIhwtFsOlIorZbV_bdkOKsupFRucH-g0W4Jn2j_eA>
    <xmx:okpwZqQl3n-NjMYN4e5qWZllQNHMwjMefRQz37qxHWt-KAkTCmb5wA>
    <xmx:okpwZib7fXMGOYdJT_iXa31wO4b-hRxRhSxgHUn3K-Re-KHETmq9bg>
    <xmx:okpwZrSk7UkCMB8s2rzqxBZBXr1e45CFVBgNXTYe5-NF9QmtrWBunA>
    <xmx:okpwZkBh6hBbaCR-5qs4n3l7dDymLS2GD3CdQb8dpMcCkZQgFmDwoGlJ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 10:39:29 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/migrate: fix BUG_ON in migrate_misplaced_folio() and compact_zone()
Date: Mon, 17 Jun 2024 10:39:25 -0400
Message-ID: <20240617143926.1511227-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Both Hugh Dickins and kernel test bot hit an issue that migrate_pages()
reports success but still leaves unmigrated pages on from list. It
triggers BUG_ON in migrate_misplaced_folio() and compact_zone().

Our convention is that if migrate_pages() reports complete success (0),
then the migratepages list will be empty; but if it reports an error or
some pages remaining, then its caller must putback_movable_pages().

There's a new case in which migrate_pages() has been reporting complete
success, but returning with pages left on the migratepages list: when
migrate_pages_batch() successfully split a folio on the deferred list,
but then the "Failure isn't counted" call does not dispose of them all.

Since that block is expecting the large folio to have been counted as 1
failure already, and since the return code is later adjusted to success
whenever the returned list is found empty, the simple way to fix this
safely is to count splitting the deferred folio as "a failure".

This patch is based on Hugh's fix and suggestions from Huang, Ying.

[Hugh's version]
Link: https://lore.kernel.org/linux-mm/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/
[Additional stats change suggested by Huang, Ying]
Link: https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/
Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/linux-mm/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406171436.a30c129-oliver.sang@intel.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dd04f578c19c..30f9a61598ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1654,7 +1654,16 @@ static int migrate_pages_batch(struct list_head *from,
 
 			/*
 			 * The rare folio on the deferred split list should
-			 * be split now. It should not count as a failure.
+			 * be split now. It should not count as a failure:
+			 * but increment nr_failed, because, without
+			 * doing so, migrate_pages() may report success with
+			 * (split but unmigrated) pages still on its fromlist;
+			 * whereas it always reports success when its fromlist
+			 * is empty. stats->nr_thp_failed should be increased
+			 * too, otherwise stats inconsistency will happen when
+			 * migrate_pages_batch is called via migrate_pages()
+			 * with MIGRATE_SYNC and MIGRATE_ASYNC.
+			 *
 			 * Only check it without removing it from the list.
 			 * Since the folio can be on deferred_split_scan()
 			 * local list and removing it can cause the local list
@@ -1669,6 +1678,8 @@ static int migrate_pages_batch(struct list_head *from,
 			if (nr_pages > 2 &&
 			   !list_empty(&folio->_deferred_list)) {
 				if (try_split_folio(folio, split_folios) == 0) {
+					nr_failed++;
+					stats->nr_thp_failed += is_thp;
 					stats->nr_thp_split += is_thp;
 					stats->nr_split++;
 					continue;

base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.43.0


