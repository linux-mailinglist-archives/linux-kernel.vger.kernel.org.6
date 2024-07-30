Return-Path: <linux-kernel+bounces-268223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99899421E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F5B23F81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79C18DF8D;
	Tue, 30 Jul 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Gr8wkIca"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9D18CC00
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373072; cv=none; b=LhfgwSqovS+yga/NdrRB141mah5d4KhWNA041prbLZ5N6iouO54r2oE7s+Pg+8aedNf+Dvl2PZ6haENbwsC22I29RboenTvsOX0ne6FKxQcf/sRLSsFDssm2x+2pPRTxwQcK2GOcAjAR4FBQV+6sAqQCOnoHnJfvv5qDsRh+Zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373072; c=relaxed/simple;
	bh=UZFioN48C+LMU6bnsXcw2rpATfhSP3Md7LINlbLSdyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMqtSVbq5errRCzoQAOvtbJzuRCatz7k8TDaMhPf6Y+mEgbBthM9ASS9gtKdCqzPJGbwNWz1VTFc+U2ap+Rqt1QRLVbcp46Q4kthwAq4bTT7Zw5Mf7OsFM3K0CVJpMyw8I8tkp7qXnzQp5D1gMdxXXuIMl9STmISbrRX3004TC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Gr8wkIca; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so65001521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722373069; x=1722977869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPxJ/YjE+pYwHZd7W0h0eHbps73SI/HtbDFZ2gy9/OI=;
        b=Gr8wkIcaLpeJqscLsXsqh3LH3h8gfKnos6InjG9Lo2WXps2bOLRiAANZqmqoxGmd4l
         l6uIPWj5NkrpePQkk3bQQQGjWDS0yFEcFfbwQZy5vCaxt897Nc8b8u9M7ZQubHVpvz8s
         jwaF11Oa0NlproLgMcjaqk94XQDMpBt98K9P9Y+R2jEvxqogOEW5JrLeBkjf1kndYDA/
         h6WfhxLktE2m0mo7YqAFRc+2hyKpv0FhA72QwBC9/360eHckXFWg25Ntdwf45nCm6806
         w+oc7fc30FGwxIEv1YlsmHl1OhgUy5NMU0PwHEZOL0sYZ2u8EZz1GVdgQnLmLQAgV7EM
         +cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373069; x=1722977869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPxJ/YjE+pYwHZd7W0h0eHbps73SI/HtbDFZ2gy9/OI=;
        b=jRWQEkwfYoj4Kcrk2ul4lkh79VBW6Cegbr1peSUc6GXxuLLdIAGpehtOEmKYGvu30F
         7sCVoftqLTpR7ZJbf1MsmXKo80ZMgjd6/oQhxRq71+g0NaLFZ6EEKkI5UkmdbmHojt5n
         eAEqK7+gtFMCp6NRv8+u00whHGoWLjkbPEBgg0Fs4NQnrYM/uNbB5iSOuTV84LRownwM
         lmL40zgyI5fso5s8bCa8FyeBmk8mz4xSpk8nlHSmzqe60iPxuf6H7kog61LCtnXLFhX8
         BxMtzX70HjOkhckCNbCrAo4RDVBwrxeSPsFegW6wxdktAMerMskHJufq9JZSDD6eBU8V
         lpPg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/W/e3j1aRYKFZt6Z66ip9rayVlcfJ4pIkTMZ1oiig77lhLj93cbGXJTvERFuFhtor54y5uLwSP6zaLEq2nU7QxjQrg6q1XMG9Zje
X-Gm-Message-State: AOJu0YxqVBEskQQXw/TT4xxf0I6wNAnO7S6EEjfy9477Ykv4eZaY5KL7
	v4Esh8Ao8A6SEFqEz03w5dImkVfAUaHoNU8nyM0FjXIlOCHF29IeLN16LnfcToM=
X-Google-Smtp-Source: AGHT+IHzJtr5q5xSTOQZVFeHBzvGrYkdr2BxlIJK77NCkkzfZzn1C7QUQedTZgZbk/bUkOQzMVxrkA==
X-Received: by 2002:a2e:8007:0:b0:2ef:1ecc:cf5a with SMTP id 38308e7fff4ca-2f12edd6ccamr86539441fa.26.1722373068570;
        Tue, 30 Jul 2024 13:57:48 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377e06fsm7801393a12.28.2024.07.30.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:57:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Tue, 30 Jul 2024 22:55:11 +0200
Message-ID: <20240730205509.323320-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

Refactor ext4_expand_inode_array() by assigning count before copying any
data using memcpy().

Use struct_size() instead of offsetof() and remove the local variable
count.

Increment count before adding a new inode to the inodes array.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
- Use struct_size() and struct_size_t() instead of offsetof()
- Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/

Changes in v3:
- Use struct_size() instead of struct_size_t() as suggested by Kees Cook
- Remove the local variable count as suggested by Gustavo A. R. Silva
- Increment count before adding a new inode as suggested by Gustavo
- Link to v2: https://lore.kernel.org/linux-kernel/20240730172301.231867-4-thorsten.blum@toblux.com/
---
 fs/ext4/xattr.c | 24 +++++++++++-------------
 fs/ext4/xattr.h |  4 ++--
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..4e20ef7cc502 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2879,33 +2879,31 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 	if (*ea_inode_array == NULL) {
 		/*
 		 * Start with 15 inodes, so it fits into a power-of-two size.
-		 * If *ea_inode_array is NULL, this is essentially offsetof()
 		 */
-		(*ea_inode_array) =
-			kmalloc(offsetof(struct ext4_xattr_inode_array,
-					 inodes[EIA_MASK]),
-				GFP_NOFS);
+		(*ea_inode_array) = kmalloc(
+			struct_size(*ea_inode_array, inodes, EIA_MASK),
+			GFP_NOFS);
 		if (*ea_inode_array == NULL)
 			return -ENOMEM;
 		(*ea_inode_array)->count = 0;
 	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
 		/* expand the array once all 15 + n * 16 slots are full */
 		struct ext4_xattr_inode_array *new_array = NULL;
-		int count = (*ea_inode_array)->count;
 
-		/* if new_array is NULL, this is essentially offsetof() */
 		new_array = kmalloc(
-				offsetof(struct ext4_xattr_inode_array,
-					 inodes[count + EIA_INCR]),
-				GFP_NOFS);
+			struct_size(*ea_inode_array, inodes,
+				    (*ea_inode_array)->count + EIA_INCR),
+			GFP_NOFS);
 		if (new_array == NULL)
 			return -ENOMEM;
-		memcpy(new_array, *ea_inode_array,
-		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
+		new_array->count = (*ea_inode_array)->count;
+		memcpy(new_array, *ea_inode_array,
+		       struct_size(new_array, inodes, new_array->count));
 		kfree(*ea_inode_array);
 		*ea_inode_array = new_array;
 	}
-	(*ea_inode_array)->inodes[(*ea_inode_array)->count++] = inode;
+	(*ea_inode_array)->count++;
+	(*ea_inode_array)->inodes[(*ea_inode_array)->count - 1] = inode;
 	return 0;
 }
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2


