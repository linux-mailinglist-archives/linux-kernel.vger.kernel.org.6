Return-Path: <linux-kernel+bounces-216310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA1909DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5087A1C2187F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E3188CB2;
	Sun, 16 Jun 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkA3pRb3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEF1DDF8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718545035; cv=none; b=ui6SsHQzmksFLugJy+dYQUwQfXTMvt4Hsb7EwNSOjSFlaAp8+IB7jfEcFJZXpxhJmLyY20XAlxoDrp+EJDi4QoracDu5E4o5C7TVdIrL1dOm0OA8T01o+3BtabPudJQ86q8wb3819DIkKEdO+u+xDdduCfHAHAloUNgGI0MpA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718545035; c=relaxed/simple;
	bh=5+SdQnZnG1y9HxR07OjoUs4P3c1JXSE8RHTxsbHXs1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ucG1+OuCeHDHJ7rcwlJWO4gsOa/S1yOA/IQQI/8ahhX6rNpLf5/M5aPapObGta2Mo2dEZCh7jbvqXkZGnnxOofFcw4wFJWLTyy/W1RD+XwMs/+No3dfo0m076ZLMlDpYPO5634QUC1ob2TRV4UFAHrAj2rQK1d6ty0AzsRM6j+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkA3pRb3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f700e4cb92so31143975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718545033; x=1719149833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo6LewisGnKDZPN/HUntq5aJW2gPhK/j1eCzo1GB2/k=;
        b=EkA3pRb33loxoXz4GnYaYi6g+LZnToVYkEs0BOwaGZNyp6i3CG256VLtlAuu5/tuw/
         eZx7zFmck9kbklb4+CQWEUZeTeQvblssPe18iszJ+eePZe2PTbVtpPUTFWcxzZ4zGPVK
         Ady7XV5rB3V/GHC2ZGIoO/PiZ9oXVzdErVfS4CgAcP0EjjjDKY7+EkrqbNCu/5N0AOxn
         k6T9gJWUpPSduE15vWr7UHTsBBbsl5QjgHeGO88985ycX7IHo75Iz+WRtWTL+me5C+qT
         4KWbdpZvlN17ZbU7d0IFsXSZiECIVq5CtIaQti5QIHKi9TxdgAWNezLungN7pW0QNkhE
         MGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718545033; x=1719149833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo6LewisGnKDZPN/HUntq5aJW2gPhK/j1eCzo1GB2/k=;
        b=Mr0Rj68Nl/i4a0gPuNrgwySVZy4dwo0MC9pKCYF9R5pp/9Ory7OLSvkIXxJLQMNS+n
         OPcakdWOKtyQfQ7zc+uDPmZGbJ84zJZ5Zfr/yxTzqDf2soEHg8BlIeNes1a3/JqZChhH
         /y2oVqtNr3joW4QUrljrIWVUTkZ8V8TYIJC4Kb/skdmFSNFmQyOgFQyCdA++msKpbIXb
         S5hL9E8Ynw/XjW197+dufy9529PYgdMYdZ4uxdPTXXYZU8xDC2G132yDxta93ooyUWjE
         bkC8Qgei7ptgNy6DQxh10W66sMThRuLZgYH5EkNEyyUfQQJekbquou0aM2ZaQaCgV8pq
         092A==
X-Forwarded-Encrypted: i=1; AJvYcCUG+OPzn13lwxqIjdzDy55YFS5GvXukM50B1uGlLxweX3epZ8VfZuEzlqIAUN5AQ6CBuW8az6lZws5cl8C+Qjl2VDfvbCC9p2bm0K0l
X-Gm-Message-State: AOJu0Yz8DOXz7D+ThrdW1WMoSRBbTs4hLgeIO4gW4ZUPU1jZA/Sfnlsl
	AyN3uVsmwnUgMtu8S535zjVEtSEA11U2fCIRDdqZB/p3ZKWxvvTT
X-Google-Smtp-Source: AGHT+IHyKCYIIMXS1PzF7WjVg/51xGCgdvMjVfp92z+vEuJxUitlc9CwdsLpXLBEUtFpq4zoPA2AMQ==
X-Received: by 2002:a17:902:e847:b0:1f8:49e0:4d19 with SMTP id d9443c01a7336-1f8629fed6dmr108963735ad.57.1718545033157;
        Sun, 16 Jun 2024 06:37:13 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee6f01sm63756575ad.153.2024.06.16.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 06:37:12 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] fs/ntfs3: Remove recursion in indx_insert_into_buffer
Date: Sun, 16 Jun 2024 13:37:04 +0000
Message-Id: <20240616133704.45284-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove recursion by using iteration.
Decrement the level so that parent buffer can be handled in the
next iteration.
Update the header of the index buffer to point to the correct buffer.
Set new_de to up_e so that the promoted entry is inserted into the
parent buffer.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 fs/ntfs3/index.c | 204 ++++++++++++++++++++++++-----------------------
 1 file changed, 106 insertions(+), 98 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index d0f15bbf78f6..09d5dcbfcc38 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1802,122 +1802,130 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	u16 sp_size;
 	void *hdr1_saved = NULL;
 
-	/* Try the most easy case. */
-	e = fnd->level - 1 == level ? fnd->de[level] : NULL;
-	e = hdr_insert_de(indx, hdr1, new_de, e, ctx);
-	fnd->de[level] = e;
-	if (e) {
-		/* Just write updated index into disk. */
-		indx_write(indx, ni, n1, 0);
-		return 0;
-	}
+	while (true) {
+		/* Try the most easy case. */
+		e = fnd->level - 1 == level ? fnd->de[level] : NULL;
+		e = hdr_insert_de(indx, hdr1, new_de, e, ctx);
+		fnd->de[level] = e;
+		if (e) {
+			/* Just write updated index into disk. */
+			indx_write(indx, ni, n1, 0);
+			return 0;
+		}
 
-	/*
-	 * No space to insert into buffer. Split it.
-	 * To split we:
-	 *  - Save split point ('cause index buffers will be changed)
-	 * - Allocate NewBuffer and copy all entries <= sp into new buffer
-	 * - Remove all entries (sp including) from TargetBuffer
-	 * - Insert NewEntry into left or right buffer (depending on sp <=>
-	 *     NewEntry)
-	 * - Insert sp into parent buffer (or root)
-	 * - Make sp a parent for new buffer
-	 */
-	sp = hdr_find_split(hdr1);
-	if (!sp)
-		return -EINVAL;
+		/*
+		 * No space to insert into buffer. Split it.
+		 * To split we:
+		 * - Save split point because index buffers will be changed
+		 * - Allocate NewBuffer and copy all entries <= sp into new
+		 *   buffer
+		 * - Remove all entries (sp including) from TargetBuffer
+		 * - Insert NewEntry into left or right buffer
+		 *   (depending on sp <=> NewEntry)
+		 * - Insert sp into parent buffer (or root)
+		 * - Make sp a parent for new buffer
+		 */
+		sp = hdr_find_split(hdr1);
+		if (!sp)
+			return -EINVAL;
 
-	sp_size = le16_to_cpu(sp->size);
-	up_e = kmalloc(sp_size + sizeof(u64), GFP_NOFS);
-	if (!up_e)
-		return -ENOMEM;
-	memcpy(up_e, sp, sp_size);
+		sp_size = le16_to_cpu(sp->size);
+		up_e = kmalloc(sp_size + sizeof(u64), GFP_NOFS);
+		if (!up_e)
+			return -ENOMEM;
+		memcpy(up_e, sp, sp_size);
 
-	used1 = le32_to_cpu(hdr1->used);
-	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
-	if (!hdr1_saved) {
-		err = -ENOMEM;
-		goto out;
-	}
+		used1 = le32_to_cpu(hdr1->used);
+		hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
+		if (!hdr1_saved) {
+			err = -ENOMEM;
+			goto out;
+		}
 
-	if (!hdr1->flags) {
-		up_e->flags |= NTFS_IE_HAS_SUBNODES;
-		up_e->size = cpu_to_le16(sp_size + sizeof(u64));
-		sub_vbn = NULL;
-	} else {
-		t_vbn = de_get_vbn_le(up_e);
-		sub_vbn = &t_vbn;
-	}
+		if (!hdr1->flags) {
+			up_e->flags |= NTFS_IE_HAS_SUBNODES;
+			up_e->size = cpu_to_le16(sp_size + sizeof(u64));
+			sub_vbn = NULL;
+		} else {
+			t_vbn = de_get_vbn_le(up_e);
+			sub_vbn = &t_vbn;
+		}
 
-	/* Allocate on disk a new index allocation buffer. */
-	err = indx_add_allocate(indx, ni, &new_vbn);
-	if (err)
-		goto out;
+		/* Allocate on disk a new index allocation buffer. */
+		err = indx_add_allocate(indx, ni, &new_vbn);
+		if (err)
+			goto out;
 
-	/* Allocate and format memory a new index buffer. */
-	n2 = indx_new(indx, ni, new_vbn, sub_vbn);
-	if (IS_ERR(n2)) {
-		err = PTR_ERR(n2);
-		goto out;
-	}
+		/* Allocate and format memory a new index buffer. */
+		n2 = indx_new(indx, ni, new_vbn, sub_vbn);
+		if (IS_ERR(n2)) {
+			err = PTR_ERR(n2);
+			goto out;
+		}
 
-	hdr2 = &n2->index->ihdr;
+		hdr2 = &n2->index->ihdr;
 
-	/* Make sp a parent for new buffer. */
-	de_set_vbn(up_e, new_vbn);
+		/* Make sp a parent for new buffer. */
+		de_set_vbn(up_e, new_vbn);
 
-	/* Copy all the entries <= sp into the new buffer. */
-	de_t = hdr_first_de(hdr1);
-	to_copy = PtrOffset(de_t, sp);
-	hdr_insert_head(hdr2, de_t, to_copy);
+		/* Copy all the entries <= sp into the new buffer. */
+		de_t = hdr_first_de(hdr1);
+		to_copy = PtrOffset(de_t, sp);
+		hdr_insert_head(hdr2, de_t, to_copy);
 
-	/* Remove all entries (sp including) from hdr1. */
-	used = used1 - to_copy - sp_size;
-	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
-	hdr1->used = cpu_to_le32(used);
+		/* Remove all entries (sp including) from hdr1. */
+		used = used1 - to_copy - sp_size;
+		memmove(de_t, Add2Ptr(sp, sp_size),
+				used - le32_to_cpu(hdr1->de_off));
+		hdr1->used = cpu_to_le32(used);
 
-	/*
-	 * Insert new entry into left or right buffer
-	 * (depending on sp <=> new_de).
-	 */
-	hdr_insert_de(indx,
-		      (*indx->cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
-				   up_e + 1, le16_to_cpu(up_e->key_size),
-				   ctx) < 0 ?
-			      hdr2 :
-			      hdr1,
-		      new_de, NULL, ctx);
+		/*
+		 * Insert new entry into left or right buffer
+		 * (depending on sp <=> new_de).
+		 */
+		hdr_insert_de(indx,
+				(*indx->cmp)(new_de + 1,
+				le16_to_cpu(new_de->key_size),
+				up_e + 1, le16_to_cpu(up_e->key_size),
+				ctx) < 0 ? hdr2 : hdr1,
+				new_de, NULL, ctx);
 
-	indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
 
-	indx_write(indx, ni, n1, 0);
-	indx_write(indx, ni, n2, 0);
+		indx_write(indx, ni, n1, 0);
+		indx_write(indx, ni, n2, 0);
 
-	put_indx_node(n2);
+		put_indx_node(n2);
 
-	/*
-	 * We've finished splitting everybody, so we are ready to
-	 * insert the promoted entry into the parent.
-	 */
-	if (!level) {
-		/* Insert in root. */
-		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
-	} else {
 		/*
-		 * The target buffer's parent is another index buffer.
-		 * TODO: Remove recursion.
+		 * We've finished splitting everybody, so we are ready to
+		 * insert the promoted entry into the parent.
 		 */
-		err = indx_insert_into_buffer(indx, ni, root, up_e, ctx,
-					      level - 1, fnd);
-	}
+		if (!level) {
+			/* Insert in root. */
+			err = indx_insert_into_root(indx, ni, up_e,
+					NULL, ctx, fnd, 0);
+		} else {
+			/*
+			 * The target buffer's parent is another index
+			 * buffer. Move to the parent buffer for next
+			 * iteration.
+			 */
+			n1 = fnd->nodes[--level];
+			hrd1 = &n1->index->ihdr;
+			new_de = up_e;
+			continue;
+		}
 
-	if (err) {
-		/*
-		 * Undo critical operations.
-		 */
-		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
-		indx_write(indx, ni, n1, 0);
+		if (err) {
+			/*
+			 * Undo critical operations.
+			 */
+			indx_mark_free(indx, ni,
+					new_vbn >> indx->idx2vbn_bits);
+			memcpy(hdr1, hdr1_saved, used1);
+			indx_write(indx, ni, n1, 0);
+		}
 	}
 
 out:
-- 
2.34.1


