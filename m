Return-Path: <linux-kernel+bounces-219497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52690D43B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EC2B2FD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511B15885A;
	Tue, 18 Jun 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="i1hXgQHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FARhaj1R"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4214D28B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718138; cv=none; b=eTuGTnLkQrEA+Y2JBP1aEGIXVO6UPkowJHxegitagf/GGSFpzdh0XRL8fCewK73xkH9TVPLDS00vuM9L7EHHLMDO+FtklYslkuXVSyk7LnyuRD7+JFby2hQ4OJshEhYVKFSxfRfAC9gbgFOJvU4XiO2OlrDoWxzmfK+CCMpPBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718138; c=relaxed/simple;
	bh=hAD6WGlGhKVnn8bXxD99vpgCu6dETZRsyqYzR6QUko4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orUwe7yYzf9uOKolf/EEYDVzcazwsLCZxfWUYdd0eKQPcm5A/KLniiDfbdpztQrc3lQpYpdjhPlLgc08H9cEJ+7RIPD4jwBpDLJIPMpbdn74FO8uhN8KlZ7E45+Vi2F8d3N8G2xYJia+Vw4gp38T1JLSx2swI0K+lqAokkZzxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=i1hXgQHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FARhaj1R; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 59CD7138016D;
	Tue, 18 Jun 2024 09:42:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Jun 2024 09:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1718718135; x=1718804535; bh=1rMFbhFWb3
	xr4q6NG/BsEtMpY09blv8NLf6aid/bJqw=; b=i1hXgQHeKoWylV/OSeiU5Zc4nt
	zS/4q5NWtStL/LXiE7yfpC9X7W4+0z0bMXJgcvYE+X18dcOYCZvi9IsN+rAdYGrj
	KIuXQl57hJFeLThBqvH6wZLgKd7qLIDJD3qQZOHPptDjfgId832nkFZ/e5bMOaWA
	+v2jTuVRnU6tkM6fxQLIDAZZKFmpmuyaXzZ+hJga7Xyn37z5ptKvhABjNFSevj26
	R/RiOvOsgu2R1nFZ2CoeZeXSr/MueL2USuNFMyheO9CvrnBIw9BOXvEUAar0WcNL
	D7nfz82oz1SChCp2xXvFeWAC9QdcNmPgeE4bY3w+B2d06MDwq8RRx5XO4LmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1718718135; x=1718804535; bh=1rMFbhFWb3xr4
	q6NG/BsEtMpY09blv8NLf6aid/bJqw=; b=FARhaj1RJe2S/grLAEPH7BZEyjLF6
	nwX4CWcuzt6WnVRYqaI1ZU1UnaBsIwOv+ZOWE1vB/hQPnj7Cxk7/eIrcfmgC9ksx
	VUo/PVEfHJMROv0AMsi/aoMArrTGfxh/vSfYGK++RycjJYPgXzn4hqF33fWMu0YQ
	kPwQjJ0Bep6Sm0j5PEtDUTnpbBR/TSou/+g34/oFa+lGluXPBsCp7nXSTLcmhAZZ
	gdLpOG+FyjC7TS9PGAjk1nbDtF4VF9moJsaw9l7ZX7dE/eHuy3uHl7/4PqVzthHS
	9vE2V6VZmgkFKD51C9ugnimBjEF00DjYBjIkhL4JcLikUD3oCamShya7A==
X-ME-Sender: <xms:t45xZhv4TZSZEz3kr0TJTgZNB2Lzr-LFnuFVj-ReRVrCG94wpL1U0Q>
    <xme:t45xZqcB9Zx71Isv6vCUuGXY0nnYjDtEKJ8i4uctmdshnkQYZzEAay256LCVDWsQE
    KWUOUxQuIJnOvGv7Q>
X-ME-Received: <xmr:t45xZkwWIkPDDe42_BvWp6sJPNz_H8xW1IykkKdNh11qfTJpJ1tpD7ZFtT7hiPaTIS1v7fViwQowkAfIZ2defP8jVEFjCAzSRKK-gHn0AS_LItuNG-CFxD_v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeffgf
    egkeetudelueejveefieeuieffheduteetudeuffejkeffhfettdeihfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:t45xZoMyf_CgQ6u9wqHP4pS1bIc9FRnlczSelJFe3YAGV8ytsPxQig>
    <xmx:t45xZh_4kRTRlEZfGqOEB69lQgoQ9p5atR6Ok95XILI4N7-bafwwiQ>
    <xmx:t45xZoUbjQaARB7nB8akoqJorU1WoF9EzpGwLcYG8K9nFfGLwN5_lw>
    <xmx:t45xZifHB7jCnCTbl8HNmxGpqeT-PeT29gg3EHaZTPXB5e7d-DMLdA>
    <xmx:t45xZi3QcvvkMj2HqLPb0OgADYJy239pQqBM-AZC_k3OntaC8wSIka2h>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:42:14 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/migrate: make migrate_pages_batch() stats consistent.
Date: Tue, 18 Jun 2024 09:41:51 -0400
Message-ID: <20240618134151.29214-1-zi.yan@sent.com>
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

As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
calling migrate_pages_batch().

[1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2cc5a68f6843..20cb9f5f7446 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1659,6 +1659,10 @@ static int migrate_pages_batch(struct list_head *from,
 			 * migrate_pages() may report success with (split but
 			 * unmigrated) pages still on its fromlist; whereas it
 			 * always reports success when its fromlist is empty.
+			 * stats->nr_thp_failed should be increased too,
+			 * otherwise stats inconsistency will happen when
+			 * migrate_pages_batch is called via migrate_pages()
+			 * with MIGRATE_SYNC and MIGRATE_ASYNC.
 			 *
 			 * Only check it without removing it from the list.
 			 * Since the folio can be on deferred_split_scan()
@@ -1675,6 +1679,7 @@ static int migrate_pages_batch(struct list_head *from,
 			   !list_empty(&folio->_deferred_list)) {
 				if (try_split_folio(folio, split_folios) == 0) {
 					nr_failed++;
+					stats->nr_thp_failed += is_thp;
 					stats->nr_thp_split += is_thp;
 					stats->nr_split++;
 					continue;

base-commit: 14d7c92f8df9c0964ae6f8b813c1b3ac38120825
-- 
2.43.0


