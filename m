Return-Path: <linux-kernel+bounces-413385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D621E9D1867
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E68F2842B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890A1E501B;
	Mon, 18 Nov 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2b8JMuP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349D1E103C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955543; cv=none; b=HGFONNW7B8tY4USfYMF0jMLg5W7HSFowMVr34TsRBMlrP8uJvDK05o+8fTYDShfw3GL+IW4aBcEqCkLXIG33xymLTUF1cW+Cq4uaGUVgX5PmEwqfKqeh9r1O/7Ewvl6gmiQ5Sh2tSCQp1GQhu8aSTaAxot6nKuUvvFDTF/PoR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955543; c=relaxed/simple;
	bh=Fr7v4H9DWsSJxqMRgTDv9BGwu6HmSu7GRDLzo2SwD/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/7oAvUFF4eZBSlcN3mXKyVk/MVaFcU/yQoirbTyBJ8AC9JS92BsGU3HFFH3zt7/6osOPWFPbXouIwnAimnq8dz0Fh1XvUHdKQ30piLoovOOd4lNOT3fYdHm4B3GJTJOnXawRmjRR94wO7ju520YQtXjMba4NoI47PRuSduH4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2b8JMuP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso3361030a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731955541; x=1732560341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hi+RFUnTdC+uuCyoN74teTvaWgXTbPW8c0oasB6dJN0=;
        b=G2b8JMuPKV8E2J7oQvXO3HyVtkmabiNUUHXfgGFpKPqEuxzZm8xBsMH0QfNYVJowf1
         fsVE1+G8nZSkr7F6gqJFkLXslN5tLNc0I4wchXH4uMiFZSJGEInBXlRABt/0lTZa6pxv
         40347JJH8bP/HY82x9Ua8FNlpi9+6qgdzE2knFajngLdYZaHPOXnV/+tohSJxAZSf2j1
         XmqGtTz2V9/Mc/Z53719b1EeijKxO78Ag56zdYmRXKgReICDf3KYSSZFGwjt+8/SQk9e
         Q98gk2mTRekzhu1rw7jpTFk6VTUUM/U6YqmZsNsZoNaDAxOwrGNznYf1b7ho8i1M6js+
         ceQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955541; x=1732560341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi+RFUnTdC+uuCyoN74teTvaWgXTbPW8c0oasB6dJN0=;
        b=BfsL/RtOld7VvzVtUxYtSUdRNe9/143hDUxpikkPJa4rK3ERd3cmI5cE6t2F0kFvsr
         tX43y9ZgOz5dlMl56X0wzUIRWIOsowgfffV0ZiM9g1DhnuI55BSm4ZUr5u+w9VYNFnR0
         iP6MGjx0IPNxJKw6RTR3HzXIMk05Yf7YTDeVNtjaCoSgj33LxIYrysxFmOaBxfDAyo1s
         8OEUdcVN/z3gjpTEtAwHs56h1gD6VO15YERmMrm9w7tGG9AzCvnebGcx7r4tjrCOMFIF
         sxqTFFbPEGgqLznaEasA1etoTfeB6KH5GgD+OyYlor/QbSgb6h3xctUTgSMJZGDSFUt7
         3aeg==
X-Gm-Message-State: AOJu0Yy9Lext6f+DkxiSlP0spk9CKHaO1wsaUuxQzcPqmI+xOpbU6Hrr
	c7kjXCy5Qjt/Zz+aziswEWQnxDB++aLIDOnq5wel/wEtL/QJgvdOYEoWEA==
X-Google-Smtp-Source: AGHT+IFsxG1vk886ZhlOHC0wu4CA+2e4OBsKJr9OaHDhhc6RVWAcXeKEiYio1UdcAHKb+ImgCuig2w==
X-Received: by 2002:a17:90b:3806:b0:2ea:507f:49bd with SMTP id 98e67ed59e1d1-2eaaa7379c5mr617970a91.2.1731955541020;
        Mon, 18 Nov 2024 10:45:41 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:7bb5:50ed:8f20:3617])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e640esm6507466b3a.156.2024.11.18.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:45:40 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: adjust unusable cap before checkpoint=disable mode
Date: Mon, 18 Nov 2024 10:45:35 -0800
Message-ID: <20241118184535.1047327-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

The unusable cap value must be adjusted before checking whether
checkpoint=disable is feasible.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd48..da85e3c47698 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2474,6 +2474,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
+	adjust_unusable_cap_perc(sbi);
 	if (enable_checkpoint == !!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 			err = f2fs_disable_checkpoint(sbi);
@@ -2518,7 +2519,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
 	limit_reserve_root(sbi);
-	adjust_unusable_cap_perc(sbi);
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
 restore_checkpoint:
-- 
2.47.0.338.g60cca15819-goog


