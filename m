Return-Path: <linux-kernel+bounces-221439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0890F3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7754B234C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AF2155738;
	Wed, 19 Jun 2024 16:00:50 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D01553AB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812850; cv=none; b=oxO0mYai/SjEhos5ELggGSpfl1zym7frtH1T14KFi9pM4QLENat9Br1ZPD65dsvhHLK0GO2nwKvoKFVfnn1tsASfCwngJSQQv37gHaMyNrc91K8SM0s4w8MeMkNHUA/Y1u7jDUUIsjJ34zhw/OTK7gX9wx6+SyujT27uKU0+L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812850; c=relaxed/simple;
	bh=w8fNo5SUYq1kqvuVh0RHrw1MQvqBLwMzkGScmxAbDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuLeD5Z4O9d87sPrHRx2HrZSqP8Yhr0yU925o834YdXxdxHDawY7e+lLjPjUyqQgTgSmUaZDg1s1JfM/AafhM0y3Qsa5syGb5L6X9UVdDejJIajTJvXJVJfnBv20hO9/nPlwPBTOG9v/knfSJFFI5h1zD+5pD6m4R5XtcoX3uAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso7784996a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812846; x=1719417646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQkaOWcGgmjLOBMuaajUORGl3KqAhb4Dsm8xYw+be5o=;
        b=AZ3YOHMreKagFBk4MMnQ9ADuLDIga0ko5aLJv/mPoMHuRBhDqnlCP0qyG/WR0MLK9p
         xCz51zyWTR34xpbxsSsFHRjN68Ic3GmxiaxkJxD2PgSa1VU2i4aiXZ4EzvKmcCHvO8VT
         K29o7etcBSjVdsCCFGGDBM5RGI41benw0ZQ76CEpGBm9TR/ZXxxWyI/dLQnSI6+8ViwJ
         xqCL34GK/0VDtDtJsix7FeyKtLwB6LhZyIprg1bLXAI0ygD5R0dJBS2IksvXv614SENK
         Fox8tDvkIBfCW37JffThfGvEv0+7vWVrdqel+gU/FE7QrX0KLKw5loHaRkXe51s8e+yM
         6Zug==
X-Forwarded-Encrypted: i=1; AJvYcCXtTeF6pdUOGxbhqsIk1joeTIBEU3s1HunD9ySH1kfYe34tulWt/6W5PAGGiM/xfzoelH21p7bP1tzZiaa0QIxGZTkpqqWiDSYGPMY1
X-Gm-Message-State: AOJu0YyvTa5XXRM4K+kSWdhGBnr/AMjP239W4zU/hge5LZYFXG9mzlNp
	ha0iUyDKpJQD/Xd4cUcMtYr9fwC7gDmX2K0xwrAFPibG0WhXFrnV
X-Google-Smtp-Source: AGHT+IEnmBrzj7nuqFSWhr44EboeJ4eE+DIbOXghJnLvvWlqGAmQ78SoqeCxaIPvSgrrvWNsUw15/g==
X-Received: by 2002:a50:d79e:0:b0:57c:7f0d:304c with SMTP id 4fb4d7f45d1cf-57d07e2732cmr1425984a12.1.1718812846266;
        Wed, 19 Jun 2024 09:00:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdfc4sm8442482a12.19.2024.06.19.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:00:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: leit@meta.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iov_iter: Update direction initializers to new naming convention
Date: Wed, 19 Jun 2024 08:49:50 -0700
Message-ID: <20240619154950.819859-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit de4eda9de2d95 ("use less confusing names for iov_iter direction
initializers") updated the direction initializers from READ/WRITE to the
more intuitive ITER_DEST and ITER_SOURCE.

However, the function iov_iter_ubuf() is still using the old READ/WRITE
names, which could confuse readers who might expect the new
ITER_DEST/ITER_SOURCE arguments.

Update iov_iter_ubuf() to use the new ITER_DEST/ITER_SOURCE macros,
removing the old and confusing READ/WRITE macros.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/uio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 7020adedfa08..aa1ca69febaa 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -347,7 +347,7 @@ int import_ubuf(int type, void __user *buf, size_t len, struct iov_iter *i);
 static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 			void __user *buf, size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(direction & ~(ITER_DEST | ITER_SOURCE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
 		.data_source = direction,
-- 
2.43.0


