Return-Path: <linux-kernel+bounces-226464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F594913ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A611F211ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B91850B2;
	Sun, 23 Jun 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="czPRr6+A"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE765C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180495; cv=none; b=dQxlLR0cZgxosFpnfXGWnCWFploJMKAPh9xqVm/nETQ0XWMRi1lMLsyCetEuE3nFCftbHn+O0qpOcN5MBcrmr4o+2pkTKx8sTWBNj+EG3KEq4nkOfZWbHrvThoYfjqZSbC/NfLWgDpSU0fE0EozZxT7f0+CvFRcSxodydN/S8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180495; c=relaxed/simple;
	bh=JXVPvdJXFuAJ4LokvuipCDdgW0Te7YriS/Smrp+hlDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gd8WWYPtqGOxrS0KAEllod615gay1HjlQvZJT/toUMSdH9zUF5fIfdehooTWUcUFLCgnzM4sfGDKZojTPFt+dbodpDAS41KNUccJ5tt9NUQtu9fkBSLlNctm67oKKW2L8G8vSSQpZYkXv7qHhVv/tRVx1xhmItBB+c3VB326yW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=czPRr6+A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6fabe9da3so30163725ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719180492; x=1719785292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQaycCZZJSmk4VvPe3LrTmMf0NGhS8rmwmIttagYe2Y=;
        b=czPRr6+AZovfnB6YxtyRUilvT0hCbKa2Wh26TBSFa50wG9EtlXSTStoUk6pfg2Vtkb
         bfRiK41uQz+Ane5yrXkmSHNxAEXT2De9rNPs0Q4QmBtkvE18eQzrJjivi9G6hbbL/hjw
         J+7HQovrsxUTzKLYzKx/w2q7EGQK8GFNP5SWB9W+pBj03TlTFHiF/Mp/+eVsyljliJB7
         cyqTcnJrLvN5W0TAwk5xqg7A4/J1mOJXzR1CrQGdmFR3BBOQWVF7G4p6mYyWLSnXmTtt
         drh/k+nX1L9aaG6oepaIb3pSf2RikQmJR+Tp8upp7XXSng0d6KmBsmBUXtG8LwRYGKr3
         LWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719180492; x=1719785292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQaycCZZJSmk4VvPe3LrTmMf0NGhS8rmwmIttagYe2Y=;
        b=VQQ0zxPgNUVczMh6Y97vhe5unxD5kzvHbNiv3stT9EdtfMSoe2fI/VslqA+gyF8mKP
         zSqz2kHlj3aDXfb8l8JNkuvfOtrPuZhM5Md360blv0D9JM3I2BsOYaLNL6RbwS6qwgEC
         flyAFOuQS238DdFMd5W34sHgVMIvyLLs6+DJajhHsUD4/mUAz3EUy73pcZmk1xmbgxQ9
         gJEf+3otUdcgownB2HBcmcxp8WPHyUqC/qf+obx0NqhJdYnjgxzCq7pGTyNmVIfroNMc
         ckziZ1GpHsuVSHJAsAeXxIUb05G27CRS/Rii9wnFSxjuOrzT9qr0wt/SOffEkvhRc6x+
         7ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUTL1hLwFQsde7Eg24ugRvw3LBiVsyIAEwpGs+SSAI3JGXmV396RiEN1U/Ogv+nyrdbF7C7iPSt9yxUPs97gcDhJhmK+hPOnQ0PxrCS
X-Gm-Message-State: AOJu0Yw/ZI+JmCMTZHFPn91KRscydttWzjwFps84yNqn7FY4+sc2uET6
	mHmCxY6eF0Q1CbvoCJGcBVrtxXKcl9VJ41uApGEDH+0O1MjWdVPQO52yEKe7338=
X-Google-Smtp-Source: AGHT+IEyKNVCLl4cy6A4gndHDt8aCWqNyTGjZOG5DblhRwo+WiOs+2dJoKg3qHaKkj1Zv7N7JdKyYQ==
X-Received: by 2002:a17:902:ced0:b0:1e0:bae4:48f9 with SMTP id d9443c01a7336-1fa23ee263dmr30122535ad.32.1719180492508;
        Sun, 23 Jun 2024 15:08:12 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7edcsm49044635ad.297.2024.06.23.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 15:08:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: elver@google.com,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] kcsan: Use min() to fix Coccinelle warning
Date: Mon, 24 Jun 2024 00:06:07 +0200
Message-ID: <20240623220606.134718-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Use size_t instead of int for the result of min().

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..11b891fe6f7a 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
-	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+	size_t read_len = min(count, (sizeof(kbuf) - 1));
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
-- 
2.45.2


