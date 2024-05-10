Return-Path: <linux-kernel+bounces-175308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41D8C1DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779A0282CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0715E1E3;
	Fri, 10 May 2024 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0xkDhDG"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CB1527A8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321509; cv=none; b=CDq7mHn0mpvGf5HdN7Mqs0WaeRxSkqfWXUMQvC0AEjUv/tgurWGaSSw7EZ5EAhj6d5bm32iEniQpoWe9gTgXi0qkeI6KzKJsmhCTzI5eNcGYTJNGaTHjlp0uawitEYntiOJ/gJkPPYudiar9L/sRX2ajfAnnSg1E1DAA5vbYnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321509; c=relaxed/simple;
	bh=HlmC0UjiQtAoSWC6vjrGsiGGVG3ulYA6PNHXK+VQfuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ImIm1N8VD+NuHf8KTR4ZBBJOCcWpyCv3J29PqdkbGfsTPakfGGWojgD1rqahjpGiteKN6yma/DblezRU06MM4dzQa+6RIX8wSN6WW4XD3E64wZVVAnxolUHXdrfu6eUIx5lX67FsqkreRGwYxBPRfaZZqgtkF3RGzIaN0KlksDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0xkDhDG; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715321505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZhrcUEaCz3NJloTVX6GrdenLDm/0pV21Z4CgXpXVSA=;
	b=p0xkDhDGFMw1npOCcR14CTUBw/AEO3G+1Kq0u3L63DlCquZLcXQPdrgJu8u33ak2kuFK58
	Xju/XvaUBXg2rjm5kG27Z07mfklV5ILpzote/iFp8MrESY6xk75TwNeDQX5aIh9mvCInIX
	UcnuT2giowntxKmEOOjQ1N3ISe557F8=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date: Fri, 10 May 2024 14:10:58 +0800
Message-Id: <20240510061058.316819-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.
Do that for bcachefs so that noop_direct_IO can eventually be removed.

Similar to commit b29434999371 ("xfs: set FMODE_CAN_ODIRECT instead of
a dummy direct_IO method").

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index a8d71cec1c17..7ef41ce2d8c6 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1142,6 +1142,8 @@ static int bch2_open(struct inode *vinode, struct file *file)
 			return ret;
 	}
 
+	file->f_mode |= FMODE_CAN_ODIRECT;
+
 	return generic_file_open(vinode, file);
 }
 
@@ -1234,7 +1236,6 @@ static const struct address_space_operations bch_address_space_operations = {
 	.write_end	= bch2_write_end,
 	.invalidate_folio = bch2_invalidate_folio,
 	.release_folio	= bch2_release_folio,
-	.direct_IO	= noop_direct_IO,
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= filemap_migrate_folio,
 #endif
-- 
2.34.1


