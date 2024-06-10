Return-Path: <linux-kernel+bounces-207604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8090198E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AF8B21186
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320806FC1;
	Mon, 10 Jun 2024 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myyei5ay"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF9F9D4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717990963; cv=none; b=mrXt/84obGJ6Z0PreE+TYw3jFLVw+cOt2DAUrOV5ieXBmXQBY/rFWKzN97MlbV5yB58lP9cHuk1CEjFu2rX4zxYXk4APTOK/GlFBrXTTSmCto8es/nMVqlgDXwGvDDLL6z5nnZVpEFBE5RGGZAqKEDE4KDdn1I5XujeKM+hngIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717990963; c=relaxed/simple;
	bh=t3VdJEotzI4Ro0q+MWskZGZL8F2LoDZJnFJJK1Eoxis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbnjN/UONC/OcEnlNVc4J7OhxGdaY8Zf/rP5BKUeKg4WZdntBzxxde1M6rnwflz/+ZAaP2iGKbk1vMLKEla6RQCxrQ2Dy0VesERbkOQLLU/Fif/M2RUF7yO7+ufGmV+qhhqcySWqQowFErULkLn3rQrUaGii1HzvIJH/U10tiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myyei5ay; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4eb3277badcso1531426e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717990961; x=1718595761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEbAtXZAxmPVWPII7D3ghN9eKKqyx3k0dRCLuMe3f/w=;
        b=myyei5aykiUNo6tdCQBSQfQdQfw/NgrNe2jvPGFsSeYzL57+gZIdFm/D2DYGUVArJ4
         fXpfUDmqKC85YxaJzvddT7KiYQm4whK2w/7536BpJyiukX+NNHSSqgmA4C0oGc1VNdQA
         JOaSShjYBshkgi5ZJwFtgw9S9KZzjAtkvwxTn5ggBE1CKDloNQ6FK1eQnuW48MFKbDA9
         HWrNP2YhyFXaMYYIEvGlz/Ko7SnDG5olXJLCBF7+b1ECd44zHFB2TNj9Z6GzuKiFri9c
         6QTJkmVRmVaTGw9ESdRAmx3OS2gSRxgojrTgt0LOfsyx2d+FZpLEYm3nxgZo+Uj6UAb8
         jW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717990961; x=1718595761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEbAtXZAxmPVWPII7D3ghN9eKKqyx3k0dRCLuMe3f/w=;
        b=MlrLL5r4EMPXJjbs6sd/Mtf+4bVvp2vZxfpjjgIVLkf3mi3geEhclg83tSoNWMJE8k
         0RSdbu5kTe8A/EgpIoDsm5vpMhR2519CycY3e0W5T10cvUekUuv+dANp6tT9+NSwdc/4
         nLlSzYNau/P3UyHMjQxwrSgko2uWdAsF/5/oOpAyPpfJb5hKvxwdPFIKiAkkDaGFnwwj
         rKCLZyqzjoFlMST5v++Y6pr6zsjfgsP0/Jd/B0apK4K/DwBDcrNaRCqgjFfMJc4Ztmzl
         JJzat7G+OkP6yrk+969d26qQDG1kZyUXxvpiXzMpLXFxMaG3UEMaCHyXHYSMyN/zTeZa
         DGlw==
X-Forwarded-Encrypted: i=1; AJvYcCXmfRCRywCa/BgnDWY4h5h2aNzqQtTFRqb3C+ZoG4hEH1ruAay9hLrQ7MMu3qehcAK4KZOhWTjq344LWo/ckPOc9+uGitp7t6TIkJxD
X-Gm-Message-State: AOJu0YwVmg4hZIDNCounQW3RkcRtJPvSzX34Ela1Zx1yyw3QUyzNJ8Pq
	l2wKPTIGctG1iRVDNpjE6brZnuXAAkVFZwoD4dnFh2K0O/Z+Omy1
X-Google-Smtp-Source: AGHT+IGztUNaGjZFWUnDL7xh/FztbOYUcGyLwc5aSOAng5l2BJ9dXPkCUM6X/FcwsIgBf2udZwwY2w==
X-Received: by 2002:a05:6122:903:b0:4d3:39c3:717c with SMTP id 71dfb90a1353d-4eb5621cffamr8039667e0c.1.1717990959373;
        Sun, 09 Jun 2024 20:42:39 -0700 (PDT)
Received: from x13.lan (2603-9001-5c02-c5bc-0000-0000-0000-1b5d.inf6.spectrum.com. [2603:9001:5c02:c5bc::1b5d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eb5e95c169sm888024e0c.17.2024.06.09.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 20:42:39 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: dushistov@mail.ru,
	skhan@linuxfoundation.org
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ufs: Use LUT for dir entry types
Date: Sun,  9 Jun 2024 23:42:14 -0400
Message-ID: <20240610034219.14711-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the original TODO, replacing the switch statement with a lookup
table results in more concise mapping logic and improved performance.

ufs_mode_to_dt maps file mode bits to directory entry types. Indices are
created by right shifting 12 bits to isolate the higher-order bits in
order to use smaller indexing values.
e.g. S_IFSOCK >> FT_SHIFT => 0140000 >> 12 = 1100

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
 fs/ufs/util.h | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 0ecd2ed792f5..caa843373191 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -7,10 +7,13 @@
  * Charles University, Faculty of Mathematics and Physics
  */
 
+#include <linux/array_size.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include "swab.h"
 
+#define FT_SHIFT 12
+
 /*
  * functions used for retyping
  */
@@ -146,40 +149,29 @@ ufs_set_de_namlen(struct super_block *sb, struct ufs_dir_entry *de, u16 value)
 		de->d_u.d_44.d_namlen = value; /* XXX this seems wrong */
 }
 
+static const unsigned char ufs_mode_to_dt[] = {
+	[S_IFSOCK >> FT_SHIFT] = DT_SOCK,
+	[S_IFLNK >> FT_SHIFT] = DT_LNK,
+	[S_IFREG >> FT_SHIFT] = DT_REG,
+	[S_IFBLK >> FT_SHIFT] = DT_BLK,
+	[S_IFDIR >> FT_SHIFT] = DT_DIR,
+	[S_IFCHR >> FT_SHIFT] = DT_CHR,
+	[S_IFIFO >> FT_SHIFT] = DT_FIFO,
+	[0] = DT_UNKNOWN
+};
+
 static inline void
 ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 {
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
+	unsigned int mode_index = (mode & S_IFMT) >> FT_SHIFT;
+
+	if (mode_index < ARRAY_SIZE(ufs_mode_to_dt))
+		de->d_u.d_44.d_type = ufs_mode_to_dt[mode_index];
+	else
 		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
 }
 
 static inline u32
-- 
2.45.2


