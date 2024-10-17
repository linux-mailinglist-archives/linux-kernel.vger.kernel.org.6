Return-Path: <linux-kernel+bounces-370664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73AB9A3078
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9180D1F22C59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3531D7984;
	Thu, 17 Oct 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rrZR6XW5"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600841D6DA3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202743; cv=none; b=WaR2wOGxS8XC+UFFiqKOhFNftbCOPWB2gXEZH/ik71vE74zM4pF8lPgYGefK5K3+mbabO7e8/zeeHbdyUj/cwFNVf7yrtl7lyfhNqs7RsKcYVm3XuMrHB2lAeV720oWLlhDWwIHTIWc2lWaBWHt/aKsjQ4gsztPcwBr9CheiI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202743; c=relaxed/simple;
	bh=THKWmR2YFhTE4Gq8LFDOvjdB5gfvH8D1//XRmLSEhjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwFX85tWI9Lw7QcWpGYdFw8CQUurTC1rJxdnaByRszpPR2W96QVau65X+sQQ5TakHM47V1WpXMieDphqA4aYWKR2s37rECy14xVcuDKCf9++nrSdATEFXoCDA71JHXE89JmMVs8/wAX/fYcQIiItyVGtkdNavYfTnwUyFoRcP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rrZR6XW5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729202736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KLtHY9tS67dDZxAwj9pQlA2Bn0F9rB4pbPk7zyiMrFE=;
	b=rrZR6XW5obyGjfp9maIjt+NwAWzo0Ut3OPAfuViOukBWE15y1qHD/960MHE3i5uep9nzyy
	roFl0uJIIvX/G7kLKIwRUKF2ngJG8mWLbO5jpwxxKQ/Mxj7NAdyT1ORKj2x/CmEMgg2opV
	xb2J5Yhc6+bgMYYPeRR1BVwhiUuIzZs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] f2fs: Use struct_size() to improve f2fs_acl_clone()
Date: Fri, 18 Oct 2024 00:05:03 +0200
Message-ID: <20241017220502.1592-2-thorsten.blum@linux.dev>
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

Reviewed-by: Chao Yu <chao@kernel.org>
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
2.47.0


