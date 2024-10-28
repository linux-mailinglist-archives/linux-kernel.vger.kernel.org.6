Return-Path: <linux-kernel+bounces-384820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D69B2ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620ED1C21BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A861D88B1;
	Mon, 28 Oct 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpoM+gfq"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7621990AD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114476; cv=none; b=G0NqJ62hLzPVGKvUQMldwiKwp6ZrqPwSl96iVxqELzNqyL7ez4HLOcLqKF0HZ+X2JVrJQINT/Uiwfppbz2ohFEjvAmfYksJ2C/qOuK7HC/VHxMiEUBk/H4WNviibB+yAQetFkVhv85xngU23afq2C005iWc8qbxuAYYLIzkp05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114476; c=relaxed/simple;
	bh=THKWmR2YFhTE4Gq8LFDOvjdB5gfvH8D1//XRmLSEhjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFMdSoFn9Tg1w+ByhrCug0r7KW+K9Uyk8JCvEpyT2AdubYWngRQJ34l6sg+GeJd5qJkh4oRKVN0UMX1XX2Zhp21mihCSivF1hJA+F8uuqFcoMoWxpo8o25Yi6xXGAx9j/puJApiguW/Qi8Tg2HUMcIf/tHtCUbNml9/FM35MzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpoM+gfq; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730114472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KLtHY9tS67dDZxAwj9pQlA2Bn0F9rB4pbPk7zyiMrFE=;
	b=wpoM+gfqNmz7Dex6Ij59PM2QJfzqz2tTHMw67/VYooUlUOYKUcaiTcfDsL33HOgHb4NOK5
	EqxsrtZBQphERvRf56Eh692br/n+TNqrncum5/EY0ZALKF1miOZSlayBvL12vAOn7hqqIt
	ZwFhqyTgpzEL2RL/RR+zD1EWMhXr89Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] f2fs: Use struct_size() to improve f2fs_acl_clone()
Date: Mon, 28 Oct 2024 12:20:58 +0100
Message-ID: <20241028112058.3346-2-thorsten.blum@linux.dev>
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


