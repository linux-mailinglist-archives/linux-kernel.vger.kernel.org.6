Return-Path: <linux-kernel+bounces-336980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35498439E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AA21F239F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6317BB2A;
	Tue, 24 Sep 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lQdwNACK"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEC17B508
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173751; cv=none; b=SRsY/IlsrwfjLLGokoxiZFWlr6PPOd6oL+UNmbTmtcnX0fXim4MLWZRoymID6LEQjTqPCUsKQ7xZl1sXmzyJhU/oVrnoA8BLWYaoKk4eHQUA2hCjX9CFTlMrqqLEzHxBtP87BOaqN3qE8vtz61nLPi8ExTIf7Opv4eOZE9luHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173751; c=relaxed/simple;
	bh=kqEknAlBnR/VaEa2dNt4LCU5GTDKzHcS0DL54BwSoHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIJ3Hxr2uiHekM4E7nDduf2XUpBWaj/k0UnuLJV1UcUYJezPDJDm1wjQKJ1JAtfS8oONrz3Oxsk2Mrrq0O4ae3TlYTPXDCx7Jj7YBx72ouLvWJdco74QE7DINgD/g/X1YDIwcG3D19CYqTzbkNgS8DV+WpAmQ2u7oJUHK/9ldA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lQdwNACK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727173747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/vV73Ujg2kdpt2Xjvs7nGirCJKlS64rCSJatuWlU+cY=;
	b=lQdwNACKDxDxUIZ2BpzJ9Z0cjPOaXwxBRpKrJAFwmi4PIoqVVYe3qethJctPr/Y/XeX+A3
	h/ksDHzwGCrqojSdaZsK9A5B3mFk95JfSORcKf1UIdyzsNq4M0cx+5JS/9ho2AfHEYslV1
	zi/wYAo774HPDeuZJhJ8gX6Nf4MujM0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Use struct_size() helper to improve f2fs_acl_clone()
Date: Tue, 24 Sep 2024 12:28:01 +0200
Message-ID: <20240924102800.240209-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the number of bytes to allocate for a
cloned acl.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/f2fs/acl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 8bffdeccdbc3..1fbc0607363b 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -296,9 +296,8 @@ static struct posix_acl *f2fs_acl_clone(const struct posix_acl *acl,
 	struct posix_acl *clone = NULL;
 
 	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-				sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
+		clone = kmemdup(acl, struct_size(acl, a_entries, acl->a_count),
+				flags);
 		if (clone)
 			refcount_set(&clone->a_refcount, 1);
 	}
-- 
2.46.1


