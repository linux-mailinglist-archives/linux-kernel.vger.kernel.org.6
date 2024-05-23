Return-Path: <linux-kernel+bounces-187262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C628CCF39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278541F23A34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B113D274;
	Thu, 23 May 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP8i+FK+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101EA4F8BB;
	Thu, 23 May 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456404; cv=none; b=sNksetEOD5TiF0HmZ35AeJ3PGEyR8S+hCPkbutw52MwSQRMxGGdKpu2YjqUI6o+ATx9FmBtxWnPeJb1VW+ICKsBKeYsKlSx9wAkdhnLS+5fVWFZnlLRUjnzetBUSqXasd+IYDpgi61llt/DugBHB6MMqGlNkGb30yfGJInphTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456404; c=relaxed/simple;
	bh=U4/f+5/ELJS3ohNly/5cYQy9ZMzgntrMLXVYhWvpTHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAtHmbqNDC/um+Qt8KwCCkGseJ9IZO9zucwRsqzSnFUAg7HL5pMNVnuOEzr83jaWaH5zrKUVeBEoPCptGhpjz7rxwMCmKdzyhTLGq4bs9Yeneu0qE7+wIkO64GQBv69YiS3PM8NOCYVZ9fgCPWYPoWkehoyjv6QJUddUI4h3mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP8i+FK+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f304533064so13237605ad.0;
        Thu, 23 May 2024 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716456402; x=1717061202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgjVFtFKjSQKkqo/YluY+yPsMkYZspFKPmE22dhDd8w=;
        b=QP8i+FK+TfArNsWta+I4FDNs4EQzlQ0MDoblMWJRxe9AzhbOfClzPo30NQueUcFr1s
         Czc97wcv2JMxxOt6mUFf3rRIkIttWwzHnH0Lgbm5Rdkz40ygxfOU2CUR9m51RegQ41EX
         6c71KUT5WpmTv7j+WE/05mJYqH9MqjpQDkLk+Emb3eOVLZrPdqKWF+SpqIuEq/p7wd6C
         VQ6WjlhUwHMe4s/vpEmyk2Kdyneyt14IX5aJk+j9BqbrfjeAyjATLzGfd4TSK6oovIAL
         nqt1BTZwnRw1X/SSigcItr7cOhYF5AOkMFJ8R+QI+m0v2sAt6JkB5mlfcqkstZx/sP/H
         jngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456402; x=1717061202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgjVFtFKjSQKkqo/YluY+yPsMkYZspFKPmE22dhDd8w=;
        b=SLwt5BIChTnIQXw5GCAqvGeTukG3IBqvfJ4dztQu95nn+3wqEPnI/YFM0skJHY+FRC
         nZwkCGkOSHws7WzaCU3X/GOrF7U8CM5AygmJyL0jiXgnsYD8XiaTQ9OZLLERwPVQVZpU
         VgJCR9n+qZtPVX+fubBdOjyY+UywyNTcDeJEeZVjQrqPAb/Qo7ogeYuTlyvbZAQ2GwHa
         bJoiVrmaoL3TkvNPQ+5fZnOVdGU6WVLGc/vKOTLwgOcZYLdj3E49cs6gWIHJudRkeH5W
         DALcJo9rqJnZ6ZthJu12Oshw3ASg6j9POoff8JcABazn+KwjO16W8JhhME+Q0JwfkLCA
         nOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXHpzkgukl7j/YJ/SxGzC8kTlUwv6cT2icn1rILDJqgB6lnMJlDJ6xirDb2gjk4E05w6T8WBsdjqCgzy0XQixACaetqDLe3CnDyWQxI
X-Gm-Message-State: AOJu0Yz0AVGIQd7Jz+SBjDhp4YmmSPJcriKNAgRKG0W07sI9t4fQPzvR
	7owtSR05NPDVpc4Be0O/alBsExBCqXD/keVaafGja5rNKkTfMZ5W
X-Google-Smtp-Source: AGHT+IFCr3V9Dqrv4LSKbq8usfuk6tYF56YXMp0+vQFUDBMcY6lFQMXXbNGQi4pdZj6/2zBHv3pZdA==
X-Received: by 2002:a17:903:11c5:b0:1f2:f50d:ca47 with SMTP id d9443c01a7336-1f339ef5237mr23830825ad.3.1716456402245;
        Thu, 23 May 2024 02:26:42 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6641dsm23591883b3a.4.2024.05.23.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:26:41 -0700 (PDT)
From: Shichao Lai <shichaorai@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Shichao Lai <shichaorai@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCHv2] Check whether divisor is non-zero before division
Date: Thu, 23 May 2024 17:26:08 +0800
Message-Id: <20240523092608.874986-1-shichaorai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since uzonesize may be zero, so judgements for non-zero are nessesary in both place.
Previous check is moved out of loop, and one more check is added in alauda_write_lba.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
 drivers/usb/storage/alauda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..a6e60ef5cb0d 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -818,6 +818,8 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
 	unsigned int blocksize = MEDIA_INFO(us).blocksize;
 	unsigned int lba_offset = lba % uzonesize;
 	unsigned int new_pba_offset;
+	if (!uzonesize)
+		return USB_STOR_TRANSPORT_ERROR;
 	unsigned int zone = lba / uzonesize;
 
 	alauda_ensure_map_for_zone(us, zone);
@@ -923,6 +925,8 @@ static int alauda_read_data(struct us_data *us, unsigned long address,
 	unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
 	struct scatterlist *sg;
 	int result;
+	if (!uzonesize)
+		return USB_STOR_TRANSPORT_ERROR;
 
 	/*
 	 * Since we only read in one block at a time, we have to create
-- 
2.34.1


