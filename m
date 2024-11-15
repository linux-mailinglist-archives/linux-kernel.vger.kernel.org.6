Return-Path: <linux-kernel+bounces-411451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E39CFA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA19B25AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641818FDD2;
	Fri, 15 Nov 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="aAe2jjqK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA54187876
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709584; cv=none; b=SL4Yxd5oHCaYuvHlhmRK5HLrJ72NaJPVtaCoLkkJWRnQ81ZtXHe+oiohFQmQPjHuaY2d4YmO975sqWvLhgHN3WJR/3slKBDj6VwXSb3IM1djeIelpzGVF9hPmTWK6AwgFfCnItrAVDpIxiSyFYoKAazYbUpNrSuKtS3BNK+ktHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709584; c=relaxed/simple;
	bh=zv2kRmZ0zwfoCSsullziMlgUgBWI3MPelQST3WNVw2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2d3QEbzNGlmld2E4y/6FGW91DrgdrfKE/uu122H90PAGfUVT75zBWWNRlstasSPFz8iWJw3PzjQmz0jz1AMqVEPDel9Wj5zqG4us6/ILtA7a8vrXtk+vm6fDVWTrWszBQFk2Oo1CZdq3+MdG63zPJBGUSWfwXiQZwMEA8U8LMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=aAe2jjqK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso1296725e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1731709579; x=1732314379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8Xp5DchzBLMx2DW4umYiCSRYu9AVer3xBbdskCBDnE=;
        b=aAe2jjqK3RwoMGlpC9shwHAlmxbvT8XglF9/mkIe5WkSboH6RSbsrHGbkiJx4ZkvHx
         XFaBIoek1+dG3pjMXabGYvD8N7oNuTsCkEfvMBtLVY0e5G+oA42UyowjwjrzBYODanef
         hWu5TqJeKeTqqYtVZe9gDr2zX1rcWBp02k1AQmZiCzjI20qjA24JCDIZNZ6qoZy5cki/
         ABbXFtQfOp7OjDk9/0OxfbSaeicywKpeJhjV9CYYQSNzhwaQ2jq+n4Gn46Ot2+EE+Af+
         H3Edrs2aEfsc4jGIpOUOw8HOx05ivxfhE60babq9Rr7/0yb5vjXxgipv/RcnPzQygN/n
         OOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731709579; x=1732314379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8Xp5DchzBLMx2DW4umYiCSRYu9AVer3xBbdskCBDnE=;
        b=UjmLjYpTGyA8NbETFDcl1W/qn8Tn0cNyAXeXuz+YBsvDvon292o4+VUshbxeeLi50g
         0Awsn6iEKiCYeZXcklwoVjInOpHb9Ys8tLjSFtRTdpWTzaW9H/Qvb9wIwfZ185QqY0PH
         OiwrA++Le8ay2qy8qrWMH0sU1W4V9v/VLUGti8N99cytp0YlHzpAasxnoEnCNk54n3To
         /9pHCx3XBMhKWdHS0QE3GyZZiCFs2CBXTCWm78gSHWyBErM+mKDi122lZH+UE9s5MqVV
         q3yobgmxRMmR3pMcsB3Z5ulztDIfpB4kdajmiMvWhxRg7K/kyLaNea9u86JeE+h1MPD9
         yo+A==
X-Forwarded-Encrypted: i=1; AJvYcCVK2FoFXwsrs69OgTQdAJQg+8KS934Cv9v1wMHqRSHSZdkgl81GSiyW1UEW7h5zCtkk1yB6DsDsNorAglY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQKfU+g9YoQl3eOTQ86Y7yKN0YaZMwQlVWs9oFw5+caKCmc/h
	Nb6pqc/f9MMfUVlopgCdUrpc9Qi5HMOTMJyMHah4+bLK9UxNgIDjk961fd+m1H4=
X-Google-Smtp-Source: AGHT+IHeJP49UiLk1+A21zLZ9ga84quFsvsfDwLTyueK66j1t98EbwAOHupzp6aQwxL0DRmf+jG8zw==
X-Received: by 2002:a05:600c:1ca2:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-432df7876d4mr35648385e9.25.1731709579711;
        Fri, 15 Nov 2024 14:26:19 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1b94:c354:f504:96f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821d0ea3e2sm5115774f8f.109.2024.11.15.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:26:19 -0800 (PST)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-mtd@lists.infradead.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: fix uninitialized variable usage
Date: Fri, 15 Nov 2024 23:26:34 +0100
Message-ID: <20241115222634.32259-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ubifs_jnl_write_inode(), when an inode cannot be deleted
due to too many xattrs, err is passed to ubifs_ro_mode()
uninitialized, thus leading to bogus error reporting.

Fix this case by passing -EPERM, which is the same value that
ubifs_jnl_write_inode() is going to return to the caller.

This fixes 1 UNINIT issue reported by Coverity
Report: CID 1601860: Uninitialized scalar variable (UNINIT)

Cc: Richard Weinberger <richard@nod.at>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 fs/ubifs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 8e98be642371..5eedf511880c 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -983,7 +983,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 
 	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
 		ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
-		ubifs_ro_mode(c, err);
+		ubifs_ro_mode(c, -EPERM);
 		return -EPERM;
 	}
 
-- 
2.45.2


