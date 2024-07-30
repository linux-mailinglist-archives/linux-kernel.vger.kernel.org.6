Return-Path: <linux-kernel+bounces-266766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FBA94067E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF44D1F22D18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F815FD08;
	Tue, 30 Jul 2024 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="JyuTcL09"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEB156C73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722313217; cv=none; b=UonW5U/onvxt199/exvci/e+j8azRTbA8WC+shBpq4wahU0OtNWkjR4huuPHHvbbenR9OKhz6ha0PQMx4WSysPxPdiErMOhqFqVjjcR08ZqbRYACBOMxfwTAKAUSQ1fueHkfUnYbceilgDIDjObr6BYF3c2boN/lQA4r8uRg5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722313217; c=relaxed/simple;
	bh=9fzbBwAZFbA9hyYJ0bES056p9e+ojgZ8LdDOqZh5WBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCILIuFuBI3fkdlbMcDGlYc7Dy12XY7OCgeP0Eyep0Uf+nvcgXha+yj+FUj7GJJ0p9QFZdS1idwibbVH8Lg3JPKlfCxBnGQqhLMYPh7QVzkshs1km2ZWefUfV51+MkdmNWlZ8kElA9nEG19ictP/AmogqbzG0jL6rni5OcRFgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=JyuTcL09; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc47abc040so23527105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722313215; x=1722918015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o19yh9ys/OTFhj2Zk+zxyd5d4oTpnQEk5rAEnqp5m/E=;
        b=JyuTcL09uWkak/Nf9FsA3cgAc3WCC9QLTk7qnUWDRqwki4OAtZCCmf5utn4Gcdh/y6
         hxUBn/K6wzxqPleJg/p+PfoCYheh6SDVq5xxJD4ASaIjB43mhBRgWycSdItT1ErAbBYc
         WKGxuMn0RgzQOMQybFfNe0p9HTyEVAWfbzLdsiP3NnDNxzzYFhLLgLLVPB1XoGu6CpSW
         6snmVBS0vNvx71DY8NGyJ3VpaAdGasZ/f/9dVAKOLk0ufBMe0Ch8W/92DsgtOwuccOsz
         43oWKhU2wpoMKHacfcjX0yd3przLTjrgzTJpIzUGArqllPRbZvPJxbsUhMf+g2VZkFq5
         vCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722313215; x=1722918015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o19yh9ys/OTFhj2Zk+zxyd5d4oTpnQEk5rAEnqp5m/E=;
        b=XgLSWCZdr/WG9G+Kgeu5RArE+a3Lk6VkWGh7e4uZbxpLpcYd7uT1KLHqSLdI9usxoj
         RJl12HytN7T1osomry9ciFtZA5NyLh5dG2Mg1Ia5VDUL+ej9i94NJbmeLn8fdN7S4k66
         vvIu8/dFXL82firZIxeqMOUVQiFmWsw3PWO1lR1vhzDEajdzOsFvJn2hJpszlv/6+w0D
         WxMfHClP2oB5+yVKhZZrwoyc+z7k5FqSARLsInrHkoboa/IpQmOL1mESsa4zuytZidyZ
         jhSE9x2BM9Kp/9puV9pOvMOxvgGZugWhcVyWigU+Jmd8lGZ3rLgzTGa77csaVkQWnt5C
         RCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+YyAmZNgleytyh3G1/W9VVi1Ko56QsZVeygdXalZXWAnxCzspohBVp6WPeMa2c92f3H78vyEzbnW4+LRrPKd6+6chqVxh7chHS63R
X-Gm-Message-State: AOJu0YyDom/BH9KqsW4HKrN3DAG9m7/UCO8d/5hdf/wO6z5kOjfuJYde
	lCyvG2W6M1put8jdc4SIGOCei4/s6FKoCjZSPklKtVdCNvzmXJnSPMgJXC2uUxI=
X-Google-Smtp-Source: AGHT+IHAsE7I5+EgnDR8mGBj1d1SohKwalzvS+5UuHVH0CCZHjYstzqbhQaXkQ/60nfks7oyCCiQMQ==
X-Received: by 2002:a17:902:ce8f:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-1ff04842797mr77754345ad.48.1722313215187;
        Mon, 29 Jul 2024 21:20:15 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc9cc0sm91158735ad.279.2024.07.29.21.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 21:20:14 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: amir73il@gmail.com
Cc: miklos@szeredi.hu,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] ovl: don't set the superblock's errseq_t manually
Date: Tue, 30 Jul 2024 12:20:08 +0800
Message-Id: <20240730042008.395716-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
References: <CAOQ4uxi4B8JHYHF=yn6OrRZCdkoPUj3-+PuZTZy6iJR7RNWcbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 5679897eb104 ("vfs: make sync_filesystem return errors from
->sync_fs"), the return value from sync_fs callback can be seen in
sync_filesystem(). Thus the errseq_set opreation can be removed here.

Depends-on: commit 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes since v1:
- Add Depends-on and Reviewed-by tags.
---
 fs/overlayfs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 06a231970cb5..fe511192f83c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -202,15 +202,9 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	int ret;
 
 	ret = ovl_sync_status(ofs);
-	/*
-	 * We have to always set the err, because the return value isn't
-	 * checked in syncfs, and instead indirectly return an error via
-	 * the sb's writeback errseq, which VFS inspects after this call.
-	 */
-	if (ret < 0) {
-		errseq_set(&sb->s_wb_err, -EIO);
+
+	if (ret < 0)
 		return -EIO;
-	}
 
 	if (!ret)
 		return ret;
-- 
2.25.1


