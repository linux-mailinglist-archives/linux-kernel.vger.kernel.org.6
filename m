Return-Path: <linux-kernel+bounces-234008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9F91C0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E2E1C21F16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5D1BF32D;
	Fri, 28 Jun 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPFZ/KBH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82C1BF326
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584587; cv=none; b=cerSAduxdmyIbnCvPUmjlU+w7dc0mRPGOYEU5vpi0d+FoZxtmLiXxdz6o65lOXvbDdDMnBUziv7jQiLxqnRvxu8PvIGHBEkTThwg040QSWwsHyAy173ZksBeVqCMxmKdm5sQmJnY0TgmAqkpFvWCRpZMrgHJPHjwMH6f9nQ/utw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584587; c=relaxed/simple;
	bh=ViBq+s52asFTB5KAE3EVAhxv7Xs/pdnSDcMoovEEEgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocplgXxqdmciqj/2JEiQBk9WGlrb+EyXvVx/a0j+KS5gF6TWkTAHjG2gcTQAnSepf9Vw5PYgRc2sdUQ7xQi3h+TPhNDXd+OSMcMPTQ/DJOSpVuVT/u29R4XXsqDX4WPLHk2cxRzHvfw3CbhfWQjgaRmo9VL9W/2uJdfx7xEKJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPFZ/KBH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70df213542bso411319a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719584585; x=1720189385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjNFyQgCdeFexFM9yRXBBZuAIW82Cy8G6s41VBD581c=;
        b=TPFZ/KBHKpAjUneESw7QdQcd2kY9XjYyZFdkK81PCaodQKdr4lQOrmWb9TbRZDN6LZ
         MWSGs2ajJyCPWPQ59TyAYsr8gJL+Mb/BJdHc3cYVSfXGnNpHa4OXGhxFAuvp0Wvom8aj
         UevwCTG7swGBsd3XX0e12Nv2yX9yAGelJ30zebskUrrenD5DEBaVaw8ybZQCnQuqCQLP
         tCOl9Nqp/GiMJ7+/gT3iqHDM4FRzEL+cbqb0v8ZKEbTIT9xRVxC/btm4ZiX8GhQLaUMI
         2NBcPCycZAHUbDVMkP0mTPfzDX2tpDNVJjHcKWCd6E9wdIlm+06vKHqdGb8Q7J6vABGq
         c2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719584585; x=1720189385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjNFyQgCdeFexFM9yRXBBZuAIW82Cy8G6s41VBD581c=;
        b=aWroT0eAxt9MLrLFnmZhVwVOZqSpcjVYzGEC0YXIiLePspcqAMOHuoJle8cCSK9wG2
         yXTl/GIJyhu0S7MnJVjq30InBH0+qQk4V0mo25Ocq78U9s0d6GVurb6lAG+em4V1CfZN
         /icThCnnJn7kHWhyrPtoZFGZMl2bfDxIio7NE2QZED/pRl7/6SJzt22EtVDy0IEk/0Ux
         23sFuvZDg2dBUxglFuoY0+JEmZfhZi3D6lGbIli3+joX8X/HhSbmCSSZ15abv19eSYA9
         MvOB6NlFmsGGMEm9edLlGtHPlQQLMlGq/j+OVnX+tCjpbHY6sXaGVHmacqWfv9NA8avX
         8+yQ==
X-Gm-Message-State: AOJu0YyOmfLEQXCek/KawqxNaMru/hoc/QEZ9EysoUldY7b1yJYKsfiK
	nDdcZEemSJnzrg5v6d3rmhl8dIzvoHK0jX8XFuDkb3GYYSguqoga7TJJSUUh
X-Google-Smtp-Source: AGHT+IFakoOwn+OZJu9Fq7TFT8g+fxq8e5wnSv1nvnm+Jmer+onX1gBYH+uX3MAXXbuY4wYRAuzc/w==
X-Received: by 2002:a05:6a20:6521:b0:1bd:2358:8c8d with SMTP id adf61e73a8af0-1bd23588dc9mr9615305637.29.1719584585300;
        Fri, 28 Jun 2024 07:23:05 -0700 (PDT)
Received: from yuyu-BM1AF-BP1AF-BM6AF.. (Par50.cse.nsysu.edu.tw. [140.117.168.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ed31ebsm1647740b3a.110.2024.06.28.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:23:05 -0700 (PDT)
From: Hsin Chang Yu <zxcvb600870024@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Hsin Chang Yu <zxcvb600870024@gmail.com>
Subject: [PATCH] Fix the example typo
Date: Fri, 28 Jun 2024 22:22:29 +0800
Message-Id: <20240628142229.69419-1-zxcvb600870024@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the "Sr" with "sr", the example is wrong if sl and N don't
have child nodes, so sr should be red node.

Signed-off-by: Hsin Chang Yu <zxcvb600870024@gmail.com>
---
 lib/rbtree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/rbtree.c b/lib/rbtree.c
index 5114eda63..989c2d615 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -297,9 +297,9 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 				 *   / \           / \
 				 *  N   S    -->  N   sl
 				 *     / \             \
-				 *    sl  Sr            S
+				 *    sl  sr            S
 				 *                       \
-				 *                        Sr
+				 *                        sr
 				 *
 				 * Note: p might be red, and then both
 				 * p and sl are red after rotation(which
@@ -312,9 +312,9 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 				 *   / \            /  \
 				 *  N   sl   -->   P    S
 				 *       \        /      \
-				 *        S      N        Sr
+				 *        S      N        sr
 				 *         \
-				 *          Sr
+				 *          sr
 				 */
 				tmp1 = tmp2->rb_right;
 				WRITE_ONCE(sibling->rb_left, tmp1);
-- 
2.34.1


