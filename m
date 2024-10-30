Return-Path: <linux-kernel+bounces-388690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D0B9B631F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E92820AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FB1E571F;
	Wed, 30 Oct 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnfyCQGk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC871E5734
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291520; cv=none; b=psWzL1JCeMPVgoZbQ1j8a3qT8SQwv5UaNHb98OaPo/KI6IlIUOFFpKLLYju0Ocz4RcIqe13DGJMQwP4hZOsNh8gVyPf7bFXg9VYV0T9gw/+k1JfPnBMxrrvuMrzuljCWm7RHru/ZBv2rRFafgsm46ysMcOXPY0NN+4E+zyw2M7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291520; c=relaxed/simple;
	bh=Giz/mURqvqVaoic/VisR6dZMT3/sZ4x7w01A9rETjJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q/K7v41lVhSC7xqtVDDiRQTNDp3hlB6DS0Gh07qkVCIEGkWB6BkuVXTqdrdCuqhq3BJ25JwmGfa0KDCv+8YDR7Aur5Kr18rzd+lrE9dRzZlqf2dYlMEF7F34KVFvpquQ40HXEJfiY3TsflGi1Vf206rIPIpiqsTCmfME9tc5x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnfyCQGk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so656741a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730291518; x=1730896318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpVbNemuqem1Mv7Ge0jObf+sLKmtqb08uNrfDrodtWM=;
        b=KnfyCQGkdLBAmpxLpuVPXxCRaN+07AbXFTiOBZ9nnkM57w59jMWhfzyuBaKKehlj1p
         rEXnHk1PPpRDuHTqI8Zsu7pUXxbgpCrehLJbutsYmuwNwktR44ko6uxc09MCCH3o+Phh
         oxzSGFEu/6wUUBwnYUNuIn548GSobbTIOP3iTfI+0whG05TtPivSHsPc8nB1YtW40y39
         mgvlWnyGDosyFnxig0HxgKNJRfVGXyXzsMUT+vA5VbnuhTOwyPM+HzcKfTRJxpD1x/O2
         g//1KJb02VHzklc+N8LkOelhyyMh2hwTKwfmPBZIj+J6jLsghEAjN8yQxWJHsJCRlU0i
         GuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730291518; x=1730896318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpVbNemuqem1Mv7Ge0jObf+sLKmtqb08uNrfDrodtWM=;
        b=PS9+AOjHcMfzf9a8GtTTBipz3H0pACgmnBt1tvfF4DIHw0SN0nHTcqhgC+FerJfM1a
         FDst0HAJFAzJRYZnM7F8sMVyLRgJIrhxciC6jN3WM364rKIqFrXMSCRwBL7O69JrMoVc
         xWVKuiVlUHPqSU6GkSasKub4+xWDY0XLkXzzsIcTA0aWI0v9qwqfdCXeZq2BJhBMA6l8
         fH8xlDfNPnZAnDQgWx9iLLuQNLkR2L6jTkTu7pzFe832oAGvjcZJ6A7T0YbxDotggjjR
         YRe3IyYoLrc0pACne8HUa0TTBR1sb8Mapa/PPYlzDxJiUoP2APCKkVXQubq22LEwtHvG
         1KQg==
X-Gm-Message-State: AOJu0YwsN1FBltBkJBORdyn8im4meHyArttEmA8sghzPUA9hes/9t77p
	qv88qVxDy+RqWfJCsfT5WmajugrqHKbE+6kY/QpyJqRy03uFpJK2
X-Google-Smtp-Source: AGHT+IHvIp0tkAiO4P8ZZ4P2Sd3zFcmtjgSOyulVA0w/tTALOxiHTmKhrKpr7QsN/B/RQ+uA+hWGUw==
X-Received: by 2002:a17:90a:7849:b0:2e2:bb32:73e7 with SMTP id 98e67ed59e1d1-2e9224b5ce0mr9181052a91.15.1730291517587;
        Wed, 30 Oct 2024 05:31:57 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40f2:e:4b75:4a8b:dc8e:3a8c:27fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa634b3sm1561615a91.27.2024.10.30.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 05:31:56 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: mikulas@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] fs: hpfs: fix inconsistent indentation in hpfs_write_inode_ea
Date: Wed, 30 Oct 2024 18:01:26 +0530
Message-Id: <20241030123126.16531-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the indentation to ensure consistent code style and improve
readability, and to fix this warning:

fs/hpfs/inode.c:153 hpfs_write_inode_ea() warn: inconsistent indenting

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 fs/hpfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index a59e8fa63..0aacad6b4 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -150,7 +150,8 @@ static void hpfs_write_inode_ea(struct inode *i, struct fnode *fnode)
 		   Some unknown structures like ACL may be in fnode,
 		   we'd better not overwrite them
 		hpfs_error(i->i_sb, "fnode %08x has some unknown HPFS386 structures", i->i_ino);
-	} else*/ if (hpfs_sb(i->i_sb)->sb_eas >= 2) {
+	} else*/
+	if (hpfs_sb(i->i_sb)->sb_eas >= 2) {
 		__le32 ea;
 		if (!uid_eq(i->i_uid, hpfs_sb(i->i_sb)->sb_uid) || hpfs_inode->i_ea_uid) {
 			ea = cpu_to_le32(i_uid_read(i));
-- 
2.34.1


