Return-Path: <linux-kernel+bounces-372498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E739A4947
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02472829A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193418E763;
	Fri, 18 Oct 2024 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G04hxbcL"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED718E030
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288315; cv=none; b=ja9RMzdCz1zVscqPx33tzMbLANKH0QP9r82KD6SFxeYCE5Yz33uC1dOjtssvcFDp+lgY+/9nliruABMr4enpC1Y/Oga9leLvEmxtxeh0on/E12Q7nAhZu6bU4h+JhcaMhnAN0+RFNL1NvTSY+mB538VmJ4H8m+iaZ+1UtegZpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288315; c=relaxed/simple;
	bh=jVp2XeJQWhWiqlq3PrKHMlTiUUGh1DY0t5jJkqZX1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxuCB2WDq0XNLWSAs4MOA25Zq5Tog+r1LpELi33sqNLDEd9buumKKv61A8QZ+2bUi07hh43feDnZJRw7kkn7hUGWOSLzviB89lxhW6XRFyg4ErLE/4VjWV2kMZ6uxRJctYmCn01Lt5k9UJuhMIxT+hXtkvVP1STUTYgqvFqsKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G04hxbcL; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729288310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKvnKptp1uRbOCnjX3f51ubHWt1GVBSz5qp7SywltcA=;
	b=G04hxbcLM5ARBdAuppF3qu/poZZI+HVTeueAMIeyTT6o7aWbi76M3ENuq7in8n8HMyW7D6
	Mslv3jEGERecoe+glP+9LA7j/KEa0iJ6dD8CBVZCyrGreemFir31qhk/PGjIrecMoY+kb+
	xgZmPwRGXRrc1xmn6kUfT2ntjSTM51s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ufs: Remove unused ufs_old_cylinder_group struct and related macros
Date: Fri, 18 Oct 2024 23:51:35 +0200
Message-ID: <20241018215135.163634-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct and the macros are no longer used. Remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ufs/ufs_fs.h | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index ef9ead44776a..3dedbebcfc92 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -521,15 +521,6 @@ struct ufs_super_block {
 #define	CG_MAGIC	0x090255
 #define ufs_cg_chkmagic(sb, ucg) \
 	(fs32_to_cpu((sb), (ucg)->cg_magic) == CG_MAGIC)
-/*
- * Macros for access to old cylinder group array structures
- */
-#define ufs_ocg_blktot(sb, ucg)      fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_btot)
-#define ufs_ocg_blks(sb, ucg, cylno) fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_b[cylno])
-#define ufs_ocg_inosused(sb, ucg)    fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_iused)
-#define ufs_ocg_blksfree(sb, ucg)    fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_free)
-#define ufs_ocg_chkmagic(sb, ucg) \
-	(fs32_to_cpu((sb), ((struct ufs_old_cylinder_group *)(ucg))->cg_magic) == CG_MAGIC)
 
 /*
  * size of this structure is 172 B
@@ -575,28 +566,6 @@ struct	ufs_cylinder_group {
 /* actually longer */
 };
 
-/* Historic Cylinder group info */
-struct ufs_old_cylinder_group {
-	__fs32	cg_link;		/* linked list of cyl groups */
-	__fs32	cg_rlink;		/* for incore cyl groups     */
-	__fs32	cg_time;		/* time last written */
-	__fs32	cg_cgx;			/* we are the cgx'th cylinder group */
-	__fs16	cg_ncyl;		/* number of cyl's this cg */
-	__fs16	cg_niblk;		/* number of inode blocks this cg */
-	__fs32	cg_ndblk;		/* number of data blocks this cg */
-	struct	ufs_csum cg_cs;		/* cylinder summary information */
-	__fs32	cg_rotor;		/* position of last used block */
-	__fs32	cg_frotor;		/* position of last used frag */
-	__fs32	cg_irotor;		/* position of last used inode */
-	__fs32	cg_frsum[8];		/* counts of available frags */
-	__fs32	cg_btot[32];		/* block totals per cylinder */
-	__fs16	cg_b[32][8];		/* positions of free blocks */
-	__u8	cg_iused[256];		/* used inode map */
-	__fs32	cg_magic;		/* magic number */
-	__u8	cg_free[1];		/* free block map */
-/* actually longer */
-};
-
 /*
  * structure of an on-disk inode
  */
-- 
2.47.0


