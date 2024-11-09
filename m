Return-Path: <linux-kernel+bounces-402574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4209C2943
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B63C284B0E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0851E505;
	Sat,  9 Nov 2024 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgfXerIn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3118037
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116322; cv=none; b=JFfqHkwzTop/Y9+EdSn+6ADHsMHEjAxFL8BEuvSH9qxrvv6IsvRggmAqi0z1rjVA//rdVSclgl75Hz/ofOOfKcO23mF3TNm8p2lCIOPXhJixA5kFAzXZVsOBmmojw1NlDhujBllXWBXrYWfD7Y4t79wgKbD4JRCs8l9U8dICwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116322; c=relaxed/simple;
	bh=mtZbDDfRZdsXP2HrgzR9guI13AMRBNqdlL9O4IF6ZGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLnaeN99qAf8F6IdoFLhO+q9MbYC7hAZ2Y+nNivsstT0OlFfncrUtFZyrnGD3eoaCRc7ukCt3tSk+Fu5vBRCm1NGYWkdpfnLCVRbWnbb+fVCF4DxBQFpf36JQDEPOg3s1abKGOLkNhnOznqgHu+OWHiuL8W3LxWSthEvkMlYONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgfXerIn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2118dfe6042so2244115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731116320; x=1731721120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bawIuU92Q74ggWk5pYR+Z5wr5o+e7Od2yBJHvPe/cZk=;
        b=jgfXerInsYObZLZkB/oxe9IxCd3UvwzyaobgbMUZvHHl2TcvNttfO63Tgl/LlVKz7l
         G2Ec/+3S9fxlVkOBm2jVoNiGKEvG5RObsqr0wzsd7X2M6GTyuiHJ7L4V6RRWsND9IHMg
         C1NRxxt7TbdeM6aNzX60mLBqEdSuSZzZVZRw4m5LXwaT3usleGhFN7g60nfULA1eOcBw
         no26MdT2huZ3BnOVvlp/EjKKnD4HG82G4m/mKvhH5qAxeOuImeOaNAUxyIJiRYqVkpWN
         +zTDUarBnM0K7WqmLRJYlLnOaUV9Ey+B6AlLP4fUnn3qYjI0qGWIi7mXiARJ6WPZPKya
         k9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731116320; x=1731721120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bawIuU92Q74ggWk5pYR+Z5wr5o+e7Od2yBJHvPe/cZk=;
        b=sLbozcZ5veL/EUk0ip/fRhrm3cp8zKp7jnngb51ZvPF7e5fabGfqW1/EJAq6X7MRgr
         5++WqeJPdg1GzgW/GQ02H6875VdN6vqWiOJ14MR6gFB4x+jyJy0ETsKKf+nLe9VP/oNo
         kM3GfNnAmYgr1t2evjC8cZs0TRlBw5WTCHRIwuSKMNrYItUKSN+6tvy9oHo9RDQXhxfA
         7Qt5bJCNO5mfSJMorXD4xhfqIIlhiRM0XNauJbzxynns4cLZfu6TEUnoObTjssgrXewI
         OE345rDQRsAFujHX8N0rinLNByuK++F5QyZqLr9Q/IBHRlBbtioZcDEOfspL+9slZywb
         9G1A==
X-Forwarded-Encrypted: i=1; AJvYcCX92Ffpsy1XyEtHV30IbFw2ls0AwwHi9mRZcjgyHEtVK9DGz+mY5IAITt9/MvVmkDf2W0BYCtRRlaebrw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRRxIbAo68aoOhLv3QRiQTjlisBBIJcTdZ8nPMinzy4AZaUhn
	vAfWuXwVdEOxjljdOEWSA7MF+cDQ4+AedKRVt0Y3gM+cZIc9WwKQ
X-Google-Smtp-Source: AGHT+IHjZCAp37vub2/la0ETYlZdowHlKQwip3eiKMZwcVF2lsyB0zO1XdQqTFMxsXDWTDJ75SGn8g==
X-Received: by 2002:a17:902:ced1:b0:207:15f9:484a with SMTP id d9443c01a7336-211835506c4mr59901975ad.15.1731116320486;
        Fri, 08 Nov 2024 17:38:40 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e458bdsm37474515ad.133.2024.11.08.17.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:38:40 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH v2] f2fs: replace deprecated strcpy with strscpy
Date: Fri,  8 Nov 2024 17:38:19 -0800
Message-Id: <20241109013819.5952-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated. Kernel docs recommend replacing strcpy with
strscpy. The function strcpy() return value isn't used so there
shouldn't be an issue replacing with the safer alternative strscpy.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
V1 -> V2: handle strscpy errors, changed prefix to f2fs

 fs/f2fs/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696b..4721a8a8f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -1158,7 +1159,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(ext[ext_cnt], name);
+			if (strscpy(ext[ext_cnt], name) == -E2BIG) {
+				kfree(name);
+				return -EINVAL;
+			}
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
@@ -1187,7 +1191,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(noext[noext_cnt], name);
+			if (strscpy(noext[noext_cnt], name) == -E2BIG) {
+				kfree(name);
+				return -EINVAL;
+			}
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
 			break;
-- 
2.39.5


