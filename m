Return-Path: <linux-kernel+bounces-306275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A0963C62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088AC1C237D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450D16D4CA;
	Thu, 29 Aug 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BKdnPUrZ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EF14A0A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915771; cv=none; b=r9h5GI+OHI4OAZNF2bTb/2pd8hJeGvbEaVxjOmpqI7FWzeViWnRjNaiug51nXXDvMR8VFwAw9pqnrNc/+34HE4PqmMxL/ZMMEdG5R9Ky5mN0im63tybbe4QdpDLDGqedIALD9+HB7FYibfE03FyeWMSC+XXGgixlGYt6TEaFkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915771; c=relaxed/simple;
	bh=8BPOSniWHrQvyGuJwHUdifQmH4rIEpBku5MkeNEdRyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRhXGYtx0NCMCqZQbeojU26ZuasdmH9MvJDfZkYWC6Q6UlQhEYzthhnjGxH3kmSvRxJ10uZnFB71Lyid10u9oKu8NYK2d42uX4BKkkmhsNyfE2CIGgkyWgQs9uWnpH19ln+BqLwvyLKgbe1J4ZjHNqtu9vzwhMppu03ZVkfRhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BKdnPUrZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724915764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i0xeUGCoMFjPpXS2CoMByWeQ2WkworfO2h9ojNKikDc=;
	b=BKdnPUrZ6noU8tgVCXevmJGCnRSxEavE+YxglUD1ePg89mqvsqLcft0uTmhFdNSotZVHTP
	2rgD509Se+g8J6h6yUoGIVCZ+rVvfi8ZDEDTryqW8CvytdVAH1yFvIMiEh2hXJRFRUs+UW
	KvzNn1syB2z0v4PWwSV0IHuhNrbeE1Q=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] nilfs2: Remove duplicate 'unlikely()' usage
Date: Thu, 29 Aug 2024 15:16:00 +0800
Message-ID: <20240829071600.30706-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

nested unlikely() calls, IS_ERR already uses unlikely() internally

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/nilfs2/page.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 7797903e014e..9c0b7cddeaae 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -262,7 +262,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 			NILFS_FOLIO_BUG(folio, "inconsistent dirty state");
 
 		dfolio = filemap_grab_folio(dmap, folio->index);
-		if (unlikely(IS_ERR(dfolio))) {
+		if (IS_ERR(dfolio)) {
 			/* No empty page is added to the page cache */
 			folio_unlock(folio);
 			err = PTR_ERR(dfolio);
-- 
2.41.0


