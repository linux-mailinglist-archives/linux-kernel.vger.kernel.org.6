Return-Path: <linux-kernel+bounces-398453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864E9BF180
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7AC1F228CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9D20408B;
	Wed,  6 Nov 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asvGlPzT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F29200CB5;
	Wed,  6 Nov 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906533; cv=none; b=pLlt2VfFWWe7w2cBFsPgvDfIItT1sGr2fL9kEJ72k4E3GJuda71IlbksM0jUtIjJ/ti7vWmTN/w6MUnljE0LhRq5BHArzrdm3rj6s+ELHis9lxkn3HzfHSy1wxswbu3z4VQjxrgEQD5mz+35kBr+W8zOC1ESs3rYIs9AlJfkRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906533; c=relaxed/simple;
	bh=TegPHsJb8UtZrNvXmEc16dnLIaw0GbTMBePpl8yK+PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UyPTtiWNOXmoox3mYVVKsT1as+75gFSBiApwqScnBBXU/UscmZcYkqbyzYxB+81wY1PKqrrgNzwnNxWqypKu56uoJZ5WkyEjW2aluRLDzVf4nNtBQR7uS0YSVbaox6C3A/i8dd0dqkq4Fu0+pUw9FEDsyf34A8pZMX3PF3CvgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asvGlPzT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so80048455e9.2;
        Wed, 06 Nov 2024 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906530; x=1731511330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojWgkBkJEMmCI62V4jCnf16CEFOk3HJMOucjebvfEik=;
        b=asvGlPzTl90WCzI8RCVJ7WWGt8jy7gum0fqOit1n6eNWOJlwLvcesFIRPPS+CwYUaI
         xsBSg4I6EMySDWCz/jDvo1Vq5hsv7ocWRecEj5jpVcNDZfhJFM5WKHnJGVvkgLksQs20
         g+940O1W9SVHQndFiG58v/xyYQhKhgdQ9VUjTw5e8o7IjNNGf+mePJatgY5D3+BXYbrL
         tQZPJWoQfcxZocqtM5s+U/pXvryYXmPRd/3nOqPPe6Y2wkPQ7C+gLsBSewlZdWFx1TcH
         1SNJVqbwhrIdX8ogFSmILHHcL4QFbKzzHAQb3RmN1gKW5gIGT21vP2hrEiRMVIkjamBQ
         xKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906530; x=1731511330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojWgkBkJEMmCI62V4jCnf16CEFOk3HJMOucjebvfEik=;
        b=dpn6LCS0dkqdwR4/kleQJBTRz1gwKDkCZCD1XChOliXOzdwzwGRWJwyodKlvaTpNSH
         3Ac8sEYNDWzb3Mte8tEKrTSTxk+Kq89iJMGaKhDH33xtaq6B9y9J0UFB5xypztkQ/TCb
         L6PSPSvWU6hRguTgS+kRoJs4uyiyMJDW6VPKLQowFz3KFBaeEXBUYElvJikvcA9pxVgk
         jwsnguMjdjNvNFhjy8Tzm3bhAGc9GgN+xUl5zn36Fx8/xgmuqdWhN2Zf3xeqEJMYX20P
         wslRhLtXM8GnwZ/8hfmCd7dPyGekjH6l5iKBAoMskAQVezI3RkrpSblESJt+D9DXBSgT
         uL0g==
X-Forwarded-Encrypted: i=1; AJvYcCXawBL+mIP9C8Ob/+RBwPhuiebu4vMl/CN+1l8GXz7fGljJpSAOUZKH3/C5CKp1+bOdtMPkHXeY54BxsLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJGgoyipwT4jWNiV0Z4QgwHSzethkHOszDVosgRMvxyezygeN
	hptV8GETPoH5UWOcjNhnvFNqpsFa8qTpPF1qhbpTDpXboxGG4iTy
X-Google-Smtp-Source: AGHT+IH79nN8Lx5TC+3a80nhd8cyj+o9blu3nB5kz6aXwplTbMCxWrEQiYYSM8yIiy9mD69AcgA8pg==
X-Received: by 2002:a5d:5f8e:0:b0:37d:3705:84e7 with SMTP id ffacd0b85a97d-381c7a5d0d4mr21256608f8f.17.1730906530252;
        Wed, 06 Nov 2024 07:22:10 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e528sm19654399f8f.78.2024.11.06.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:22:09 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/9p: remove redundant variable ret
Date: Wed,  6 Nov 2024 15:22:09 +0000
Message-Id: <20241106152209.1626630-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The assignments and return checks on ret are redundant. Clean up
the code by just returning the return value from the call to
v9fs_init_inode_cache.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/9p/v9fs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 281a1ed03a04..ee0a374e0d9d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
 
 static int v9fs_cache_register(void)
 {
-	int ret;
-
-	ret = v9fs_init_inode_cache();
-	if (ret < 0)
-		return ret;
-	return ret;
+	return v9fs_init_inode_cache();
 }
 
 static void v9fs_cache_unregister(void)
-- 
2.39.5


