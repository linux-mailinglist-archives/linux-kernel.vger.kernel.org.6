Return-Path: <linux-kernel+bounces-277844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70594A741
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76870B252E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C101E6725;
	Wed,  7 Aug 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="KdDrrX+x"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F591E4EE4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031525; cv=none; b=H+E4GzvNZwCm7Q1fAiL0P1Vlg9YsqQAXeQvISiNoBSgmqslacPyj1ROhmksPNLqCJvL/KOTi7/BdFL+ENQa5j3yf8No4LrKyE4IZWFNNnrnbtPUElPJyLauT4ql6RPw1wLK/5RXNHVGeyLxnJfxXI8DtTvcdUyvY/EzHtGa5/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031525; c=relaxed/simple;
	bh=IGFlB68INDcQ8sKrUZofoAD3z1NjB/zmJ8yA1Y+vowM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISxVJoGsZUP2arce/Mq5J4natTb9ybSy9JJGhupnn/CsovYDd2P3hlLg8aHpGEGWu6T+kXEjmoG4qw1nANfLozNBBmXo2V741L9liu1t8fdYMqjibkC2n0nEtSoth/XOGYsNuKO0+I6eE/kLv1cyBUGtlJbPFQhYTehSvQwZpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=KdDrrX+x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1847534a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723031521; x=1723636321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5733r8MkNcdcarsQAxONBjSXJjRkkEqIUJQucklfAjI=;
        b=KdDrrX+xmcL6RjpsZ7RjGbzZ+tnn7hLcopf69N9xOamTq+19Qc/nXi0E45R5pouaLz
         QEZsxf8m3i7Pu3T76M9hCozJzS0TndzS9Lpc4QcEB3qSrN12rTfRMXS4VkHZYr63GDDa
         I5Ua+OWi0dXbYzl9FRpbVF0ieBWAE8AQqOdy1CLFAVO4NmE4ENUzFEHFB0SZFtgTTtfI
         I0ai7bGpDHOib4004IJNZZqf6t5GQreBD1BKOs6Xe7SilTs8gVExYMHPYmXhS8dlh0Qm
         CF2lxgF7uLIbxxwMYeJiKAFjT4vEs/KcbwF7SNXxjUUG/fIbP80EldKM8rEDMY7Z7CjU
         ATqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031521; x=1723636321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5733r8MkNcdcarsQAxONBjSXJjRkkEqIUJQucklfAjI=;
        b=QIpaQoof7u4QEwe2V9IPoF2hunm0OSyMjTT5JPEiHDFODifZZQjy5By1r8pRXHyARn
         TmP0gbtJcOlvUtsz8/uwZpE+FGKzpD+9O94U4UNrPSkcR48MKdTHKGDqkkP5Czx6vR+3
         8EmZgrjMx2poGpXFre4GS0z6znutvT5tt0ywnGFINWNZ4XozabYB7YEqdUXnIXyccDdK
         eEnupO3GrANJYEYhmJA3Dg47DsW27Ix65eXOFiLfXg6zTkcn/SrgcU/NGF1f5eiA11RR
         Qs46rpsnc4yQsqHZc2pBNT3+JPFZP19Z9SRqu3cCqkRuhIg4wruLkBC/IwRZooPDsGOn
         MzFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJOorBgNWVpGpJ12TFi9Ma6KFoYtqTEHKBApSrKHoq8eK5u5DtCbwPePPs/Bn04Qpmgh1zLFSkUBWi92w+DTzAqYRkjfHntbfoxqU7
X-Gm-Message-State: AOJu0YyFhAVuPU6U9z3lYF1pDAQRqksIjhiSQp0Qo5LSHR0r1szix3Jk
	25J6HM8JzYCEjYCPYpaSEigjkapMBduWjrJ9XfU0+4/U931ldOrmNFv93AMAwI0=
X-Google-Smtp-Source: AGHT+IG072hvtVXEAG8bATDH9oftvsuC6XgrrvmWhDdJcJRKEph+45ZjwZZwPMYSkUif6Ip38iEkZA==
X-Received: by 2002:aa7:ccd3:0:b0:5ba:cb82:a776 with SMTP id 4fb4d7f45d1cf-5bacb91e9eemr7858125a12.9.1723031521608;
        Wed, 07 Aug 2024 04:52:01 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af119b00710ea47398d5cfcf.dip0.t-ipconnect.de. [2003:f6:af11:9b00:710e:a473:98d5:cfcf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba3acc257asm5207141a12.51.2024.08.07.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:52:01 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] tracefs: Fix inode allocation
Date: Wed,  7 Aug 2024 13:51:38 +0200
Message-ID: <20240807115143.45927-2-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807115143.45927-1-minipli@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leading comment above alloc_inode_sb() is pretty explicit about it:

  /*
   * This must be used for allocating filesystems specific inodes to set
   * up the inode reclaim context correctly.
   */

Switch tracefs over to alloc_inode_sb() to make sure inodes are properly
linked.

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: ba37ff75e04b ("eventfs: Implement tracefs_inode_cache")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7c29f4afc23d..a9279810158c 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,7 +42,7 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	struct tracefs_inode *ti;
 	unsigned long flags;
 
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	ti = alloc_inode_sb(sb, tracefs_inode_cachep, GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
-- 
2.43.0


