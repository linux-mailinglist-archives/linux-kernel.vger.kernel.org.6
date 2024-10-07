Return-Path: <linux-kernel+bounces-353220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D93992A93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A812835A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851701B4F2F;
	Mon,  7 Oct 2024 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1QnB3s1"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056818A6AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301614; cv=none; b=mkHObswV2yxzc2iaCMewGJiM4Z0uy9HboDBjxIz+te+7jLdpZf8CQWvXjfUjJ13SSCrWbWRm8uzHHXW258WNSxD2g+ORfkvOFyNNBeyeG0oey8fgqKBpJ7M/flp3whMkH/G8RsQhcebsJOJRk8X0JQzcgNvUxZgIrhlO39ClFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301614; c=relaxed/simple;
	bh=+FgrIbE/YvDLp+WWfmzWSJOntTSQcjxrlHLLvoQZAv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZEdql9q/pYiG2S3kZgYgyP/FeckX1HPozeeKo5zSDWHE+ptOiV5bvMepzUjCQOpTKa1e+5YHTuvFXN/kPiN2IGgGq4gsjy/WHoao4Q4PJbHp0I6447AB3vc/rvtpmJT7nGgFy5mTDXRlG/1dSsYXV4rDz7eq1nGuxid56iHKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1QnB3s1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728301610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xI5pJ0sea7IKzkBw+m/YUJfJHhAPmQx7k7R0WfJFwcY=;
	b=P1QnB3s1jNHMoJzfQ5QSUUyUVQc0hHQOI9RIyF1XlH59b8CRoMARTdkvC+euwT5MjR+5KF
	/SLiYYZHuMVNFePzpFb1EI5yF0+46/r5yvzlxWK5gKiXwPH8gQsWICu8Z6YlsPsTCW+Wzr
	6+JzbTcKzPO6fmZ/ihPmEr0lkghnUUE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] f2fs: Use struct_size() to improve f2fs_acl_clone()
Date: Mon,  7 Oct 2024 13:46:37 +0200
Message-ID: <20241007114638.1337-1-thorsten.blum@linux.dev>
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
2.46.2


