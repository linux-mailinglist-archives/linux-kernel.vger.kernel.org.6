Return-Path: <linux-kernel+bounces-213994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1C2907D72
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC64C1F25996
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8EF13A249;
	Thu, 13 Jun 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7zv0nTn"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A1137902
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310419; cv=none; b=lYyYPaicirTLUS3Jh7b9d4/oGPESP5+Sjcadf+/xKEXE4dvTflVX9MHWFO+JXIfj5TNsXx0+ajTmxfTQX7dJhg/z7VwpI9jLLKc0M19us2KgGDlfy4q9ftyIx1mFPCE7PPhzXQZyGWoAMaxZik+GBR6a6BeTpFWG88w2mmURxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310419; c=relaxed/simple;
	bh=467aTyVqOm1A+Q0r7xGR8nUtJ7JjD0p8ner9YV8wIis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBKsoKs7+5DpSxtr54FuLipiil1D1RwJSXFDghL7yGyZdqg11bx7Uodc59y7l2AReULYl871ZzUhAZwI8xLZ54oCdQ756vFttBiddarDFyAHz5KK0eqfQV6gpEbeH7c3RcXgtJp0f9EwH1C8BB7l9nB2Dr0gzuazkGK57QoKG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7zv0nTn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9a5be6668so790579eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310417; x=1718915217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8gz6DxLT5yhvPl6EJHfnDjIivJ1OPPCYGvBRj7cC5A=;
        b=f7zv0nTnuY+pfCTYtV5BE406UhKn5lAUSnkZcucgfmxpqyRH2Fk01pdbbC3qvhJrdO
         5j729+Yt+LTg7Lw4yB2VjJQXig945H+qPIl2NNn/4m9N//nQXLnenIEB+CxJAoNOoiPb
         qHmKOR5ldUePV86CRwsGagBgakujW3A/vECebyet6BoX67I3wkO+9jp5i5FX/OIm5saH
         aANOhTugrVZ1SgMLaXlKxA5SJJM+IZKMMadihUd+hVI4VUm2HcN4H8CR9wkMOY/Q5bN+
         vsEtVzv/IPsMALQAWL8R7DckQeFN3rn2jcuaMcCloDt5xIn4zGyVNIsSBWQTI3KbWq8d
         lV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310417; x=1718915217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8gz6DxLT5yhvPl6EJHfnDjIivJ1OPPCYGvBRj7cC5A=;
        b=GpCfC5ePLNKwXQLmrKE/OIfsMq2CYo1KTN3zsP7+wh5dZO2YhhCeM9lCGPvieFzA3x
         4y5mh+4JSQzhjypjjaARItXHThetktiA1kW0zpIhS0IkD84U3UGsEVL1BDhg7SSL4dij
         nx6Vt3J+1YzLveq21K1wkLxj7Hlm2BkmwQJWttxxv+xejlhVnLOdXSz8kUpFcsF2Tc2+
         SuKh0uxgjYiejHDW7UNaSfoIY2oZU5fgiXTh5QiyPg9e4Qpu2RXgpM1ALR5MKWYT4OyV
         LuaIZL05wIkzEbCDVh/7idtKoK9YDqutB1Y3sM6fenIZ7kwREQWwYIpVYL5IcjVNP+qZ
         w5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWTSlv6oeOVturOKbacF/GYwO+zp+IBnkP8/pt6Abv3SUZ9uhLziAk417pPJLjdQ2Bd4VvNrl1ZC1UhGyyjG8w+8adk/lIR9ap0VQCI
X-Gm-Message-State: AOJu0YylvNIErBfLQqa/DFO3mm6nzTaFpaB+wD983YcuuXebH6f9WaZJ
	WA5sA2o7I4D5ZdyaWkNMC4lDzHzxpRplA0AlKLgE26UL+4wrmj/n7C2YpouI
X-Google-Smtp-Source: AGHT+IHdOGyVm9yHfksJCeL8SnB65MaIbw9PYQ+EVQqFkiMLEh80afsuWspQOHlIQP7S206rSM8DXA==
X-Received: by 2002:a05:6359:4c82:b0:19f:5612:cf4c with SMTP id e5c5f4694b2df-19fa9dcfac7mr104211455d.1.1718310416798;
        Thu, 13 Jun 2024 13:26:56 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf49d7b1sm1496677a12.51.2024.06.13.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:26:56 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: dushistov@mail.ru,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] ufs: Add table lookup to set d_type based on mode & S_IFMT
Date: Thu, 13 Jun 2024 20:26:50 +0000
Message-Id: <20240613202650.39739-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usf_de_type_mapping structure to map file mode masks to dir entries.
Add a static ufs_type_table array to map file mode to dir entries.
Remove switch and add a table based lookup for the mapping.
Add ARRAY_SIZE macro on ufs_type_table to eliminate checkpatch warning.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 fs/ufs/util.h | 57 +++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 0ecd2ed792f5..8a941d69270a 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -9,7 +9,28 @@
 
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/types.h>
 #include "swab.h"
+#include "ufs_fs.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
+struct ufs_de_type_mapping {
+	umode_t mode_mask;
+	unsigned char d_type;
+};
+
+static const struct ufs_de_type_mapping ufs_type_table[] = {
+	{ S_IFSOCK, DT_SOCK },
+	{ S_IFLNK,  DT_LNK },
+	{ S_IFREG,  DT_REG },
+	{ S_IFBLK,  DT_BLK },
+	{ S_IFDIR,  DT_DIR },
+	{ S_IFCHR,  DT_CHR },
+	{ S_IFIFO,  DT_FIFO },
+};
 
 /*
  * functions used for retyping
@@ -153,32 +174,18 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 		return;
 
 	/*
-	 * TODO turn this into a table lookup
+	 * Table lookup to set d_type based on mode & S_IFMT
 	 */
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
-		de->d_u.d_44.d_type = DT_UNKNOWN;
+
+	size_t i;
+	/* Default to DT_UNKNOWN if not found */
+	de->d_u.d_44.d_type = DT_UNKNOWN;
+
+	for (i = 0; i < ARRAY_SIZE(ufs_type_table); i++) {
+		if ((mode & S_IFMT) == ufs_type_table[i].mode_mask) {
+			de->d_u.d_44.d_type = ufs_type_table[i].d_type;
+			break;
+		}
 	}
 }
 
-- 
2.34.1


