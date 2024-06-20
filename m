Return-Path: <linux-kernel+bounces-222729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E191064D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220C9B273A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688851AD48B;
	Thu, 20 Jun 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DK6/61RQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTxuo+tK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DK6/61RQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTxuo+tK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613411AD9F8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890552; cv=none; b=I8qdh7ee2X6TO3Lo1xp3jkS5uNUyScGypHNafVSaqJZsJQdLPPq+inv87qqm1cWXaFVLtqqN00F8lE9d7m8AfPCvLiMYdpO2RoqDvL84k5SOEA7bmzss7RuQuvTbP9ma6GwEIxoCuwtyB6NgRTyRkEqKZXA0Z3/DPczClSMq/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890552; c=relaxed/simple;
	bh=njMabFVjMAnfE0E7MGojZkIn4Q0fiila6FXNHBRiB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+rTNokOVdoJPCrnKNZhjy/X/oJpHTtoCMgE7C8JK33Wmrt6VBf5qFflxBVE9d7G85HVLiKykCB+T33ZLpb1ttQU+cp9hsp7unozE3OxF/FuHb9pvF3/+7IvP9uzpcDynaMpXY33FmK9ggQBN9TR9n1uWKH3I8DFv/kJ0FKGp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DK6/61RQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTxuo+tK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DK6/61RQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTxuo+tK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8714821A82;
	Thu, 20 Jun 2024 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718890546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VmDjXJMjer7/Zu640NExzGGbsOAZzvgWwUMscoSi3I=;
	b=DK6/61RQ21Fc+O/jOJ6qvtceSxzX3iyhOK2be4TdYPC1rVMa74kBLB00kKDWfw/Od2/xYy
	ynx9YCZVjnci22YF52APdsoEsSZT783KmtgMqN3wa8BQS7vQVwrxufhEiY9Im0RMc3Oz8y
	dChf7TOiqu+YJB1NLSoAfzHRd2/Pk0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718890546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VmDjXJMjer7/Zu640NExzGGbsOAZzvgWwUMscoSi3I=;
	b=VTxuo+tKYqaQgu7uDbrHTycBDkj9bo+B+o1eH1lOZsUQxDT1kbQcyPVkONNO1N75ICkU1Q
	u46DKgFH1MXxoMBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718890546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VmDjXJMjer7/Zu640NExzGGbsOAZzvgWwUMscoSi3I=;
	b=DK6/61RQ21Fc+O/jOJ6qvtceSxzX3iyhOK2be4TdYPC1rVMa74kBLB00kKDWfw/Od2/xYy
	ynx9YCZVjnci22YF52APdsoEsSZT783KmtgMqN3wa8BQS7vQVwrxufhEiY9Im0RMc3Oz8y
	dChf7TOiqu+YJB1NLSoAfzHRd2/Pk0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718890546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VmDjXJMjer7/Zu640NExzGGbsOAZzvgWwUMscoSi3I=;
	b=VTxuo+tKYqaQgu7uDbrHTycBDkj9bo+B+o1eH1lOZsUQxDT1kbQcyPVkONNO1N75ICkU1Q
	u46DKgFH1MXxoMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78B8713AC1;
	Thu, 20 Jun 2024 13:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cbBzHTIwdGY0TQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 13:35:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1544BA0881; Thu, 20 Jun 2024 15:35:46 +0200 (CEST)
Date: Thu, 20 Jun 2024 15:35:46 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] udf: balloc: prevent integer overflow in
 udf_bitmap_free_blocks()
Message-ID: <20240620133546.kn7fde2u76llpn5z@quack3>
References: <20240620072413.7448-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l26w2hohu7qwsslp"
Content-Disposition: inline
In-Reply-To: <20240620072413.7448-1-r.smirnov@omp.ru>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]


--l26w2hohu7qwsslp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 20-06-24 10:24:13, Roman Smirnov wrote:
> An overflow may occur if the function is called with the last
> block and an offset greater than zero. It is necessary to add
> a check to avoid this.
> 
> Overflow is also possible when we sum offset and
> sizeof(struct spaceBitmapDesc) << 3. For this reason it
> is necessary to check overflow of this too. The result is
> stored in total_offset.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>

Thanks for the patch. In the end I've noticed that unalloc table block
freeing has the same overflow checks and I've decided to move bitmap offset
overflow verification into mount code (so that any bitmap offset for a
block within a partition cannot overflow u32). The resulting patches are
attached for reference and I've queued them in my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--l26w2hohu7qwsslp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-udf-prevent-integer-overflow-in-udf_bitmap_free_bloc.patch"

From 0b058943e21fe0034b3bd7d634ddb1508380f50f Mon Sep 17 00:00:00 2001
From: Roman Smirnov <r.smirnov@omp.ru>
Date: Thu, 20 Jun 2024 10:24:13 +0300
Subject: [PATCH] udf: prevent integer overflow in udf_bitmap_free_blocks()

An overflow may occur if the function is called with the last
block and an offset greater than zero. It is necessary to add
a check to avoid this.

Found by Linux Verification Center (linuxtesting.org) with Svace.

[JK: Make test cover also unalloc table freeing]

Link: https://patch.msgid.link/20240620072413.7448-1-r.smirnov@omp.ru
Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index a76490b2ca19..d8fc11765d61 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -18,6 +18,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -123,7 +124,6 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head *bh = NULL;
-	struct udf_part_map *partmap;
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
@@ -132,19 +132,9 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	unsigned long overflow;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
+	/* We make sure this cannot overflow when mounting the filesystem */
 	block = bloc->logicalBlockNum + offset +
 		(sizeof(struct spaceBitmapDesc) << 3);
-
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
@@ -374,7 +364,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -383,16 +372,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct udf_inode_info *iinfo;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
 	iinfo = UDF_I(table);
 	udf_add_free_space(sb, sbi->s_partition, count);
 
@@ -667,6 +646,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 {
 	uint16_t partition = bloc->partitionReferenceNum;
 	struct udf_part_map *map = &UDF_SB(sb)->s_partmaps[partition];
+	uint32_t blk;
+
+	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
+	    check_add_overflow(blk, count, &blk) ||
+	    bloc->logicalBlockNum + count > map->s_partition_len) {
+		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
+			  "len %u, partition len %u\n",
+			  partition, bloc->logicalBlockNum, offset, count,
+			  map->s_partition_len);
+		return;
+	}
 
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		udf_bitmap_free_blocks(sb, map->s_uspace.s_bitmap,
-- 
2.35.3


--l26w2hohu7qwsslp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-udf-Avoid-excessive-partition-lengths.patch"

From 3533a6bc34badaa3d32c7b0f2816dcf1bade7f8a Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 20 Jun 2024 12:52:17 +0200
Subject: [PATCH] udf: Avoid excessive partition lengths

Avoid mounting filesystems where the partition would overflow the
32-bits used for block number. Also refuse to mount filesystems where
the partition length is so large we cannot safely index bits in a
block bitmap.

Link: https://patch.msgid.link/20240620130403.14731-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 9381a66c6ce5..c7bdda3f9369 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1110,12 +1110,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1171,6 +1178,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d it too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
-- 
2.35.3


--l26w2hohu7qwsslp--

