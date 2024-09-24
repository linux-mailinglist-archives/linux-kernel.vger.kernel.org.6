Return-Path: <linux-kernel+bounces-336481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AADF983B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8D1C21FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995412B93;
	Tue, 24 Sep 2024 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmDceVBf"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB917C91
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146478; cv=none; b=LWB1UL5yPb3WunB9KFwxgIfE/gQM42b6qSZ9OIAdL1i5EFBKQh3dZon01QsP4Bi5uxOaTN79yz2vSGcNB9JTVjBTaR5XQtck1pyiw7sgX3h3M6h5zX6FKXRTyzgpj9KBkC0hwa2/qOJJN1masWJQ4WrxvxoKu5ednD2j3Hou+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146478; c=relaxed/simple;
	bh=QG8A+aj8+qiVIJXQDatc0psJO1nQixSoI1HYpErTnGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxlHp85UeWxAe+2F3DVQlXbt6A1c10job0Fcl6JBhAdxtVJEX3eFiD2gmTgZGz+Ii2yO4/UHlG/1IiQFOtFU7btQwCP5HGepDBSHNyLnIDCP55682yDngZTAcCV5lBIfuE8w3NZr4sqXP4PIqzPVeCxeW3dy6iy98kmqQ+9bzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmDceVBf; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727146473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hX0ICgYkWPwpFSHu/i9gdiyiwv3g0dDgwMMYMEyidkA=;
	b=DmDceVBfX9SESHXUBGftAb6BfR7yv9cs8yq4nTTEo8pRejjAUPLHr0mxPDXJKjUvV+3+zH
	5LcVwOd7jL3bTo/xBnlMTAdoB4wooRfB9MAJQw19TiF0HVXVHdiZCGw7qKsfsM3gU8TG4V
	kU//CcZJa45piq2Q/CiFKrrQrsh1z5E=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Removes NULL pointer checks for __filemap_get_folio return values
Date: Tue, 24 Sep 2024 10:53:50 +0800
Message-Id: <20240924025350.3948674-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

__filemap_get_folio the return value cannot be NULL, so unnecessary checks
are removed.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-io-buffered.c  | 2 +-
 fs/bcachefs/fs-io-pagecache.c | 2 +-
 fs/bcachefs/fs-io.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 48a1ab9a649b..9742aae87017 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -669,7 +669,7 @@ int bch2_write_begin(struct file *file, struct address_space *mapping,
 	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT,
 				    FGP_WRITEBEGIN | fgf_set_order(len),
 				    mapping_gfp_mask(mapping));
-	if (IS_ERR_OR_NULL(folio))
+	if (IS_ERR(folio))
 		goto err_unlock;
 
 	offset = pos - folio_pos(folio);
diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index af3a24546aa3..972092906100 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -29,7 +29,7 @@ int bch2_filemap_get_contig_folios_d(struct address_space *mapping,
 			break;
 
 		f = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp_flags, gfp);
-		if (IS_ERR_OR_NULL(f))
+		if (IS_ERR(f))
 			break;
 
 		BUG_ON(fs->nr && folio_pos(f) != pos);
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 71d0fa387509..5025e70ab6b2 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -256,7 +256,7 @@ static int __bch2_truncate_folio(struct bch_inode_info *inode,
 
 		folio = __filemap_get_folio(mapping, index,
 					    FGP_LOCK|FGP_CREAT, GFP_KERNEL);
-		if (IS_ERR_OR_NULL(folio)) {
+		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
 		}
-- 
2.34.1


