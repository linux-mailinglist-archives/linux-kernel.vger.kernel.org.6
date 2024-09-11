Return-Path: <linux-kernel+bounces-325643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78881975C71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9932837E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A327A1494B3;
	Wed, 11 Sep 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy4vvtUr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA462EAE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090239; cv=none; b=uRSZeCMcIoO3XngH8RUoYIYriYOBZ/YSZsEQZvkRDf2pHeLERoeJRZ5DV+G95ij1rcI5fSkvJZvLI598BzgGJLjN1UiaVZNWxfyMQP+RtRF0dKbk/UGUU28/0R6w7XHuij4PnrKjB9SmxA9WVRdTqCkVxGHF4eiF+KPP0gj8pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090239; c=relaxed/simple;
	bh=hejofH7Exvo7IsOM2OlBMY80Bdlh8Jxd500rsKD+iIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EI3jHPVrz+f0jxUDimiI26VGYGTPHS3azGrJQn83TeH6c/6Cg1a9iXo4aaryWHJC9nvVF3f/F4FGzJHc5RnP1IvPnHdiHUol68qmf24WWmEMH7dQxqmXZjMn0z+RmtT/pOMgqvScYy4Ytdm66cW4qDo1YmLiW8GvuKXlVRa1yGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy4vvtUr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206aee4073cso3391815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726090237; x=1726695037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ND0dFv6nG4nnD2cgNnxmWojj7h/h+D3ul3lYx8AfWwY=;
        b=Fy4vvtUr3wlqjYf5PJJdEpqH+IaGq1Hb7gZJCvilFzUryiMbGh3B2gZybKLgrmUD37
         cR9ny5uJKqIuXTTUNoyDtbLxeH4/D4uRuvHc5cb17lLb3oRHk9wlbn4xQT533Ezf59B+
         3HoMhAXlytW+CiPc9YGqYH/Mbn7jjBfYBYa9LOsWiFvVEI/eK9RcbGdXLfcwErCmf2Z/
         ldbAzAQgw51Xn1bvEgCN2BFBBeDM+j/D74VdIw47NfDExwPiWQcc1JHdO6IOUiFbf3Ox
         S6eNjXX5lN81O0zfG4FnRpUOuf4992oKnetnLwiTmU+SAAo3vL9GuolsYRkUuEE9sMAX
         fcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726090237; x=1726695037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND0dFv6nG4nnD2cgNnxmWojj7h/h+D3ul3lYx8AfWwY=;
        b=iTlJ7CeMkEBOpDZ4nk9Pz68ik3S7KVqaTk6M05x+VkOv/mh0ktsBj6FuMgeWtWLeit
         hCnEdd7kZvwSr6FcnMT63o8HwrKIv9c7Ydeaoy+Q23W3nIZCxdaTlU017unHfqa7xkVu
         JovRNSv6LIZel49lMDIi4cTCdtPJSh1UAncZQ9B3C/x6srPJOXm08/3sVLMpx/GnBOzM
         4Sa9XDf45/knpQfGyTYShQpSICGcHBdaJS8+H0ubI6jyHAOIhUlK0n7hrwrXFpTIvCG+
         /AqIl4Q5MgbUSMkgYfMKVfd0xmvMPphcQnVYyyGc3Zdyv6MfrPWJpflZ7AVRUHO2pwAz
         F2NQ==
X-Gm-Message-State: AOJu0YzVW8HflSGoHyx/VUA9yxFIHbbVNfWT5uAKKAoEnV6IHEsajDGQ
	yEdIPTDfmJwZ262UlPmav37hc1HNTJPJzdiySfD4kMbjSSybdoxnwRMP+w==
X-Google-Smtp-Source: AGHT+IHtRaKXBZUOkwmoSTSvPlA7hYaDv9260Cea35CnvQUz6sWM0eYC/6jYR4nm2iFUJx/7qLb/XQ==
X-Received: by 2002:a17:902:ec83:b0:206:cc5b:ad0c with SMTP id d9443c01a7336-2076e371523mr9444105ad.28.1726090236284;
        Wed, 11 Sep 2024 14:30:36 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:8f19:757b:ead8:14be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm3663715ad.239.2024.09.11.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 14:30:35 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: forcibly migrate to secure space for zoned device file pinning
Date: Wed, 11 Sep 2024 14:30:31 -0700
Message-ID: <20240911213031.183299-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

We need to migrate data blocks even though it is full to secure space
for zoned device file pinning.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
---
 fs/f2fs/gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 724bbcb447d3..aaae13493a70 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2010,8 +2010,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.598.g6f2099f65c-goog


