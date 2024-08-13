Return-Path: <linux-kernel+bounces-284198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E948894FE61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CFEB225F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4344C61;
	Tue, 13 Aug 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="uK1GDArS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C961DDF4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532848; cv=none; b=VlRGGOh4Rk6yG8zalBjHB1wBXyY3Ooszo+/mdd9e7vcO/gPDFCX/dH5QviqF2bLcHD6yGMLw4n6NB77yfVP9TuJAcfeDDuGQZ8VjRD17Pgj4tJ1KIGiDPZWfsDMxx5eMNmzaL2OHN8Z+pWU4fTzGzw2AbfLzmk02zlJCYSTyiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532848; c=relaxed/simple;
	bh=FA1o6bW5O7JQChJM65nekRnovAiEKN1W9YAQTw6lCGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdLrVEWsIJD94H5e4lEIFV8YDNlw4J96FDzet5DF8DoURTnah6prbhwoDBzZq0A1+/OGnrV0cdouXb7tMe0BY+7ItvO94IQzNj6ubGWm2o6TVaYQXIW20BgrMqdLIIkK+OTf51Ig/PIaHI0F9hrTs9mYlseXYZ5iAsQpJj7bjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=uK1GDArS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso1577241a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723532845; x=1724137645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qlzP9K9pVJI8dYoKKJYhQQ3MxfZMtGgoNckW49ihmYM=;
        b=uK1GDArSJe4iz6w5GTHD86UoConSFQ6eI4Cv8v2Wl0Xo5UdESvdMAk1YGS/U00k7op
         Nzcj/bD4Vk1bvOg9vi0/UIiu5LoSldVSaDQTZ+gkYemWJ1vztVfEweAPQXLDb/gT8SNw
         lH+PEBl6ewnkZH62Kxh8j/fSiHjRCc2GbF/UxacKkqNrWTbgvqWbXzsQKMnQowbIXszT
         /LYtd34F92h2PRReznLI106OBay71/stHekxJZAzmzoMBl/MZf9Gt6vuZ8Vi6k+kDWrB
         jDf/glpETHdhHQ4Zp5ffwWpqZz+X/TPFo5WO2RSranrN7VhMM5KpbJxpd+SXFK0IUwMW
         tfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532845; x=1724137645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlzP9K9pVJI8dYoKKJYhQQ3MxfZMtGgoNckW49ihmYM=;
        b=lsI3AVnCRzpDhB1lKvlLIZMO+wIsGvwIPAaRDneH9N2NrO7R9pBvjxS4eHxa79DjNw
         xLnYwp8I8dYDWRt3hFpc6kxY3L/xOWWPin2Idqg2cvsQ+qKv63j9oYb4aGGCLMJmyQWU
         REtwOTnOUpi7+dEBhvXXROnifBdD0ChXKnIiRZdhKzws1I19SVuGY73LqB620i0PJjeg
         3VES3ilsgnhdGYnazfAGkk/BEmxgPxQ7LDVE2oXybtBTPERucsg7j3e39wSRJfHDdrQp
         TO76AOUuoxYMqHiZDERq3fRXD/WlGQJRgycw1fy6MJpaigMb5r/7RKfLAocOM6p30wC1
         zQHg==
X-Forwarded-Encrypted: i=1; AJvYcCWybS7RD0/5qfZL6qbxcSYX0R6AJ+wmlEp1gDD0EQ5rMqgRfPLH54iJxoYg5uZJ/z9iWs+WT/mEe76/Nqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHFwSmAROj4i7dJbBWjUfQqwK8UxKFGfLvsCz40okjQWhLO2D
	3u8c7mdOnrQubs1ZQHgrChOponOnifsnbAZF6sQzxp1KUD3oKNcaSDidzeikqsX9yFeNUDA85Wc
	G
X-Google-Smtp-Source: AGHT+IEL2o7J8niY06ZhHwNmce7tlV0CqAfDYL3+ZbEUCzUSX0Rf0+4b94uBu6x8HpqrO62FfWadUA==
X-Received: by 2002:a05:6402:42c6:b0:5b9:3388:f362 with SMTP id 4fb4d7f45d1cf-5bd46254ff9mr1680174a12.18.1723532845135;
        Tue, 13 Aug 2024 00:07:25 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e07a9sm2687726a12.78.2024.08.13.00.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:07:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH v4] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Tue, 13 Aug 2024 09:07:07 +0200
Message-ID: <20240813070707.34203-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
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

In ext4_expand_inode_array(), use struct_size() instead of offsetof()
and remove the local variable count. Increment the count field before
adding a new inode to the inodes array.

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

Changes in v4:
- Remove unnecessary count assignment and adjust copying the whole
  struct as suggested by Gustavo
- Link to v3: https://lore.kernel.org/linux-kernel/20240730205509.323320-3-thorsten.blum@toblux.com/
---
 fs/ext4/xattr.c | 22 ++++++++++------------
 fs/ext4/xattr.h |  4 ++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..263567d4e13d 100644
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
 		memcpy(new_array, *ea_inode_array,
-		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
+		       struct_size(*ea_inode_array, inodes,
+				   (*ea_inode_array)->count));
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
2.46.0


