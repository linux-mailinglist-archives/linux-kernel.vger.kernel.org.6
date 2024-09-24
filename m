Return-Path: <linux-kernel+bounces-336468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46533983B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4D2826BA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBCEAD7;
	Tue, 24 Sep 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ur7VKnPg"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20A1B85DA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145130; cv=none; b=ejAfuuNwX0eOvyztJiN890BpdxVzW3Agf7e9JVn67uFL8Vf4zaClbuQ3L43VS9kSXsbFhM06nKyQzZBefyK3n3YhVLlJAeWnody2OHI65zbwVa3GvgyEf8hw3GafowklcqdofYa++duxYAoNzv5h9dvSE6DDKIbO0LiRKDfjrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145130; c=relaxed/simple;
	bh=J8MmfqvgO9L7wwIGqVVVe+B6hrA4KxtYoSQ2jQGcXEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bHRSO9LUyBFtl0lVdgTGVDJaNPRaCP6S+sJ3+2LJP/h7Q2nz/sMthyWUkp+gxY8DyHQ2Z9xsRBmOWfuHjxaS4UPc1UXg8Is74Jh9Jm+sHFuBo7coJzE1OvMUk9Sg5/w1iV2m8Gle/nKQCYGROwigT2fvvqjyTegqdyY/Zy2epak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ur7VKnPg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727145124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MGOpr+w9lQCY9L6X+aU90icJEyeUObMC6TBwToVX3k=;
	b=Ur7VKnPga49Q1updQc8xwUFLlD2VYiRB9g5ysBqIgg1BgCrVGRd1BSqnFkXFjgjxD6atCB
	Z0i1VrCyTXSo8igiBX03HocHyL+EkuGNdol6SY8I76diGuCZt1Sum/D3ITHk0kG1r4qgke
	fnlK6E0vkTWiDdLZQzdImnhUPcpJzgc=
From: Youling Tang <youling.tang@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] btrfs: Remove unused page_to_{inode,fs_info} macros
Date: Tue, 24 Sep 2024 10:31:35 +0800
Message-Id: <20240924023135.3861974-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This macro is no longer used after the "btrfs: Cleaned up folio->page
conversion" series patch [1] was applied, so remove it.

[1]: https://patchwork.kernel.org/project/linux-btrfs/cover/20240828182908.3735344-1-lizetao1@huawei.com/

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/btrfs/fs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79f64e383edd..82169cbd99e1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -876,12 +876,9 @@ struct btrfs_fs_info {
 #endif
 };
 
-#define page_to_inode(_page)	(BTRFS_I(_Generic((_page),			\
-					  struct page *: (_page))->mapping->host))
 #define folio_to_inode(_folio)	(BTRFS_I(_Generic((_folio),			\
 					  struct folio *: (_folio))->mapping->host))
 
-#define page_to_fs_info(_page)	 (page_to_inode(_page)->root->fs_info)
 #define folio_to_fs_info(_folio) (folio_to_inode(_folio)->root->fs_info)
 
 #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
-- 
2.34.1


