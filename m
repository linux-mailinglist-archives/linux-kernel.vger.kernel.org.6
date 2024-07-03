Return-Path: <linux-kernel+bounces-238979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009392546A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FCEB20EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF57135A6C;
	Wed,  3 Jul 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kQadzdev"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71313541F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990628; cv=none; b=swIdPbl+fKj5KNFLSeZK4Ut6CVMu0gHlm9/TL7r0vHaJKgDy0Luq1IP/lNN/vRNeyS1F6sdD19zVfiF4LA4RSdn7lYjsLrkJvbb7B1ITJsJbUmQL9COWZAF7g8F7f2AlY4b1LoQkOW1fQ5KMM/DVLtnsGOrmz74+OVnOamhRlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990628; c=relaxed/simple;
	bh=OlwUiCXewDyw3zYSLPgZ1L2XZ7B8RYL2CMyOeckMhdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IcVRG1FjecgxZSvm0Fk6jKjHGiyaXh2qlDTNx6a5vSfJXcDWqAhw1FbFBtwGwCu+YBX1zUOGooKOWftwXBLT3E2zWEe4yt9bqpsInEejvNHscmQUmsJdIUTcjBkkPSzqxiiCVwGB8Sms/XCUF7PJS3OIPbPHaDAbBauAklhwTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kQadzdev; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719990623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bhgTv6ReHO7QsWKhJp5T5JfpRyE52nnWo5na3qgj96s=;
	b=kQadzdevaT4Yinmvis3gGKRPoTnuOB5xxjFi8mBkz2rgTiPZiGaKSaf+sRpGjOheiIdhps
	yaXmsIInA40LqMRwUHLzFciZUDcbg9BuERjq/cfkRqlHKKKLCMeTkrFRB9fgZvy5oCYCTN
	VySLjQODtfpAQB6U1a6rDcpqt0BrlfU=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Mark bch_inode_info as SLAB_ACCOUNT
Date: Wed,  3 Jul 2024 15:09:55 +0800
Message-Id: <20240703070955.104163-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

After commit 230e9fc28604 ("slab: add SLAB_ACCOUNT flag"), we need to mark
the inode cache as SLAB_ACCOUNT, similar to commit 5d097056c9a0 ("kmemcg:
account for certain kmem allocations to memcg")

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index be7eda94b459..092f95426dce 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2126,7 +2126,8 @@ int __init bch2_vfs_init(void)
 {
 	int ret = -ENOMEM;
 
-	bch2_inode_cache = KMEM_CACHE(bch_inode_info, SLAB_RECLAIM_ACCOUNT);
+	bch2_inode_cache = KMEM_CACHE(bch_inode_info, SLAB_RECLAIM_ACCOUNT |
+				      SLAB_ACCOUNT);
 	if (!bch2_inode_cache)
 		goto err;
 
-- 
2.34.1


