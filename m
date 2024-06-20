Return-Path: <linux-kernel+bounces-221939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8790FAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F951C21CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F63010A3D;
	Thu, 20 Jun 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Y9W/okRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kA3RPmUp"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560B803
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846839; cv=none; b=NWWR0zvk3Jn7ThCe5AyuNObMwrtO15X6UeXwXX4gRSGtJ1qGTL9HgRm5aXP5AKKDiqn8rrkT+SChGE1f4KfU/sMJdojTjggf43RqKB0T9v4PxVwgZtAlyspL8PXKPIJaaX1ygh7bKS+uDYRgWRy3tO+VLo/MWvgYHlaYgRe6mqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846839; c=relaxed/simple;
	bh=grvF2qrtdC/38+0kcT/7zv9vEgZe+zVR+MDqI8G7nZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cl9tbsHqjA5wWPGw7nOUNOkAFnKYzhRDFvbwnJLAqh5xgNHiediqZRlnk0ubVwsSS9/sNLdLBtXQlQyoeD1hIHv4ttWuKvnJNEBe8xO0LybKtZ7/5jxqq/I9BYCTQ3PuenLaD8+gfDnPwgsga+HcoejyaCTNu6KYLtz7H75polc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Y9W/okRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kA3RPmUp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6D001114022F;
	Wed, 19 Jun 2024 21:27:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 19 Jun 2024 21:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1718846836; x=1718933236; bh=k9foSFkePz
	9cBwUSIx+qhJ76EzRla1z5nODbQMDGUyw=; b=Y9W/okRqn5OzHVjaMnL84Oz7Mm
	vesKSAL1dP78CkuGWuKRQMYR0fjUALK+z0Nd8AGKTbhe7NO4lbU/vYO3wwbNE1PZ
	nAlT4V1gVeVUGJ5MsyXEjzeDgU5cEABlzB5AJ8VkI6d255/EBJmBUrOaCNcxhao9
	RlohSOPLIl5+1UaFR/4SyV7YIWjMUvjaRXWdMO2V/K3sz15rAf1gnPdNs4vnLC3e
	hro/UmkapcFG66W8w/jLc+Vcl2nPBCEAio7qrRC0d6jh51x1MUDhTLqfo8/EuUKy
	k3a73PRUoUfLlX1n0/tvJs0DdrA3PIWxzylr5fd6j9FOOM6TQCQVqGfyxmHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1718846836; x=1718933236; bh=k9foSFkePz9cB
	wUSIx+qhJ76EzRla1z5nODbQMDGUyw=; b=kA3RPmUprUBRXC7VjHr31NGCXf9ef
	EubGp8TF1o6vYFTr22oeu/uSWh99M8c2jqrWjYjfxV1Sy85TlklbxELZJa1xB/kf
	UJTJnbg9oIfe1NEAiZRYlcMsUS3So9ltGXlWg9wA/N8INxGOGUjDaLQthaNjXady
	ldFOZHHRyYZy9o707uH10vg4nXAuWURzw1ngw0lnlK6snldyQLnQ2MTAb0EfKMR1
	OdWfHm8Kj/fvtK9CMyCzw2ZQogVt1OSwfNFfwLSbBk2aMvXrHCuY/SDA01ljiyxf
	RbrmllQPprqeeO7iMsoUsbapUHxeY28u0V4hcYnVO73vmJpXx8c2RsuVA==
X-ME-Sender: <xms:dIVzZo6U9_mnjPTxfudMD2EneXrXXQ1GI8B3Efdgg_J34mx4NYa_Zw>
    <xme:dIVzZp7wvzwC0RTWbAlCKijVMOPux8mHGYR8My4T6aiH5rid6SeoyLKH6NAGpOt8X
    xUF7r7NLMCgxk6huQ>
X-ME-Received: <xmr:dIVzZne_7xxTisiKpBb2b_qGwCc3HEHh162VNK7dR016m2DlZah9phcLOGKNUT94Cxtv6kb4hRr8T3k0LHtSirYeFQk98haS6aTPZv3sGxyyJ1TpMHjJNQGv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeffgf
    egkeetudelueejveefieeuieffheduteetudeuffejkeffhfettdeihfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:dIVzZtLbsLA_nluTokiK1r7MchsDAyeeBjSjpUvEhI05KOyQljyLJA>
    <xmx:dIVzZsIIqB7lX4mwUMQpNZlwEmQ-HPgCBKMcafi2DrWA2XQLoxm7QA>
    <xmx:dIVzZuyiKNWBYoELOJHjCRRsonmEiQR12ZU-tNelW6GYjvDNhAleyw>
    <xmx:dIVzZgL42pB31g9rV8y462FkQbgn1KVCFQ785piHTkU_foqiTbHJqQ>
    <xmx:dIVzZpBPCmHs24nNeGqv0AyIInOoZPE4-Pbs8x21sVGoL6dD_h-9xUzU>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 21:27:15 -0400 (EDT)
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
Subject: [PATCH v2] mm/migrate: make migrate_pages_batch() stats consistent.
Date: Wed, 19 Jun 2024 21:27:12 -0400
Message-ID: <20240620012712.19804-1-zi.yan@sent.com>
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

Because if not, when migrate_pages_batch() is called via
migrate_pages(MIGRATE_ASYNC), nr_thp_failed will not be increased and
when migrate_pages_batch() is called via migrate_pages(MIGRATE_SYNC*),
nr_thp_failed will be increase in migrate_pages_sync() by
stats->nr_thp_failed += astats.nr_thp_split.

[1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 66c74b89d3de..781979567f64 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1645,6 +1645,10 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1661,6 +1665,7 @@ static int migrate_pages_batch(struct list_head *from,
 			   !list_empty(&folio->_deferred_list)) {
 				if (try_split_folio(folio, split_folios) == 0) {
 					nr_failed++;
+					stats->nr_thp_failed += is_thp;
 					stats->nr_thp_split += is_thp;
 					stats->nr_split++;
 					continue;

base-commit: 7c4c5a2ebbcea9031dbb130bb529c8eba025b16a
-- 
2.43.0


