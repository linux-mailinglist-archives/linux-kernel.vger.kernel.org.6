Return-Path: <linux-kernel+bounces-326208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BD9764F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA4D1C20ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7661922F7;
	Thu, 12 Sep 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHNnCAO4"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E26190662
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131143; cv=none; b=ZLklcLgJ5rAU1ARfNwUKUS45o6blGWxFVLMWEJf7fX9j8Cypqe958Pb2DxbiCPE62JlKivm1/Ynx6B6TO890VR/uOh5C2oyOEkryIz1JrYQ5XTio2Z/ABHZA5Yw7KWEsZjNX0e4+sNY0McPa/R8e/Vcf8lwsTQcbOlX+uRLnZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131143; c=relaxed/simple;
	bh=+Uv1yRx1t/nh3AdvtaBsQpatvoFp9YWwQHVWraJdMZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E05XnsyxK+yOLOZivK+BQ7HzmDXdOZ+FVeNGrFsOsX+ysAlvEKI9hLRh6Kqw9ao9mkLcmXlhkzeR8/2Czs0Ja6hUEUZHDlzTbjhZCwTzOyi0cQlM0XZ7Ry3twbJpH72fM3NMds4Fl57kn0UIq7iITKBVPmFkYape0woV92nU6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHNnCAO4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso7472365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131140; x=1726735940; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=dHNnCAO4zhZC+qsMBiIoDyxScRAY6ZFWHKAeJJZrHWQWIegYrqq7DZA4plol5xZALa
         oStXpSsG3TCBOAQ/5x2lXzz6rI5nIVc38cbamWqhS86GaxUyti4G9tXUh06gyKQrIdFT
         VidwLHdWyRDA88uZWxkCdU/Cc0W0AiPN2/VHGEIT3S03qJ1L3kNxM7JxH+RW7y8QmDf8
         bDryWOEcHgMATg54uRn1hWFWoMZ62eeG04nwQaA9+ULqWxffK20RaZhhA3gZXVqgU5Ac
         hZ8lFshApIV5bF5mqYUCbT05a6oPnD3+Wtl17D/8z5ti1gFNzEYY+eyO6CaeDqEc79Sq
         Bp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131140; x=1726735940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfx4IHYM/f9TvrOy+r/MT0ESdhaPDLWNq6uOUg30aAY=;
        b=QHVB+DeJLSkQs66+tjAesCPUk2b71a0aIay6eEWhxAj86fJG2+kEdRO602CKBrlPrU
         UEDkhRYpIP3HEd0MVi0QyPhVx6PphzzwJBkVqm9X+w6DmxyEzRrYcPjkwuX3tjLVaWlj
         KAXUg2TelWUa8gzwsItb9mxZ09wnqhXHSKnQr9DSxIPt8VfAt1cWM4+IN+g9Pz/Rhrd9
         8Eft9wSUoFqPwYOywaFXzsbrGNm9gO+gVXe0xMAybnlXHeRp6m+CQRpSHXC5GZRSYpxv
         qqz6405v9Cv78gsceXggVN+Gx3M+1xKgAsHHt8MfMY1TuVZ8UPlLKpba7u2ff6Aw3jMQ
         JXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3TneeCaMOp2nzcmykgjCtMGJr5sH0xkf8R8/LE3tGbJT6BoTDCRATuXYCjImNvFRNHmDlq3l0WtqllTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksmouPzgsmA3EvhT/mBOE0yPtcFEM5Y3EFdWjPzx0b4s6zHoG
	Xuy38heYnjSE7wmXfdp2Qn/ap//QVhA5IdoLU0gT2gbEuU6Zd/Y0++UJunpeM0NCIiKhe57ldIt
	B
X-Google-Smtp-Source: AGHT+IE3JvQVI8H7Az2p7xH5qjI8YDyhtJ3aO9BUYYnl2AM0k/tr5zbW/XahZ19yePpZcAyKjxL+wA==
X-Received: by 2002:a05:600c:35d2:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42cdb5112eamr20411895e9.3.1726131140394;
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm86851825e9.0.2024.09.12.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:52:20 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:52:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: remove some unnecessary code in netfs_read_gaps()
Message-ID: <df691112-1114-431a-8c71-09d1656f0771@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We can remove the "sink" initialization and the check for NULL.  It was
already checked for NULL ealier.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/buffered_read.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..9f96844205b1 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -481,7 +481,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	struct folio *sink = NULL;
+	struct folio *sink;
 	struct bio_vec *bvec;
 	unsigned int from = finfo->dirty_offset;
 	unsigned int to = from + finfo->dirty_len;
@@ -540,8 +540,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 
 	netfs_read_to_pagecache(rreq);
 
-	if (sink)
-		folio_put(sink);
+	folio_put(sink);
 
 	ret = netfs_wait_for_read(rreq);
 	if (ret == 0) {
-- 
2.45.2


