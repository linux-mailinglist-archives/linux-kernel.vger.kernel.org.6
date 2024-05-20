Return-Path: <linux-kernel+bounces-183433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895EA8C9903
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D99E1F213CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F717543;
	Mon, 20 May 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1Xei6+Q"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BA1B7F4
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716187687; cv=none; b=aiMlD4xVpSU9hnniMOZpxSUW8ctZh08D+LhImXl1u/7alGqr6qd5gEsi9P6mjqfAd/fnt++Ex+fme9kim04Tew1WmK47Ka+9WPMRc2V+iY29gefKWB8CdyxxH0UWTHXSo07rOQfcsOEXLYkkzSkEF5SqhmJQChZXDVh+LeRMgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716187687; c=relaxed/simple;
	bh=y9ZGn5ap2YWzMsXkY7gtbA7uHfkEFSZUvzYZUdbBh+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hH+/Z4PVSI69VH4xMOHI2AcMp1BT7umWWnoQrG5+6hFI3wBTEvm8uxZwpYGRp87Az/KThfHNX6pbNcdBT24w+5WaAXauSd/0cqXSmPGVvBV6+7sSxpxb7M62r4/98fJqtXIBbZvXJ6Z2B+8XHOewzQj36OEBSAxdqjZFM/olxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1Xei6+Q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee7963db64so66915295ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716187685; x=1716792485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfMzlC0870/LEOajOtqmC6jp6j08ml+NFYZpxKCmgUI=;
        b=Q1Xei6+QuxxJ79MDBEzbpHEnFSxR+d7jE/pCnPmBKT/UXbDrwVPSeXeSFQQnjs6MbY
         nQowImdSBzcatvuiFZbFge6LGEV2jkR73Kjo6xL/U8n6szqigEu7kZTVynCt/a/sDRDT
         wV+WFmaMABYu/rSnTeTQLAyr7OaBlioO3Q+D4b27CDpLJv+9YY3kli396Z9RasXFmISj
         rGKTLjaNi3AVZIjb9QWhqHEZPvYHqA6menMoGQlIGhZVAw/oKrqPdDObaAxMaZZnOJ6U
         q0b3AA2ldU+7kHUdXcK4P4mjYlrV7V7AUWNS5W4k4gVszt8Bga5WKvVH4haIiQDJsJCY
         LIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716187685; x=1716792485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfMzlC0870/LEOajOtqmC6jp6j08ml+NFYZpxKCmgUI=;
        b=d90RmTC5Un8FUtK5ZJkxR9Jf8mYO+2jdI8SLiYS+KK1Nct1mS7rSiMpgal/bmfPfB1
         V2CUt+HNNTQk3s+ppw+jz9QYowDmy25bYgTYMnyq6ZUAfiwyubpDvu8yNbmYnKtN4L3+
         T/mYUFH6YJOrEie3yHDr+d8CWTQa/mEaGBkfngpCgcJqjPrZRKghSjpbhWlnyajFLplO
         CJHreJPuJrsOuftSbg7v0wKw44JWA33qS8qrdAUqcDf3js+PBaufxo5Lj1Jw6Z+FKZ6a
         nwppjcVZ8pc6Q25kDt3qsRSG++o0fxvb1jGUkLN8dPOc2QsBEaz6wNWZEwseonFJBCL7
         2cVA==
X-Forwarded-Encrypted: i=1; AJvYcCViWthBpkgeUh2NU9iOxIaTkQz4L8ti2rtCPJdN/ddxwXrLjGNY05hK4TIsq2cHDfpWqmVCeL+AySxMXsGBKAqoPZVrwOoC19y4aMSc
X-Gm-Message-State: AOJu0YxqMLkEmSIYvScCm0wgyBNIsYTRDwJKbvwYRKWFYz6rMxadOSvr
	qlGWcyLED+0W+M5bqfkdrYzBu2TK1c5+fl4kYjxS3qWQ9NtXZO0B
X-Google-Smtp-Source: AGHT+IGMwSQRDnd6pbwi2Fukz0POjpWHTpsfdv+vu5vnuyuyukqUIACaipIlOEHjNA7nHESLEyakWg==
X-Received: by 2002:a17:90a:9601:b0:2ac:9baf:25b5 with SMTP id 98e67ed59e1d1-2b6cc76f70emr24064874a91.25.1716187685331;
        Sun, 19 May 2024 23:48:05 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863cd9dsm21206699a91.12.2024.05.19.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 23:48:04 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	ayushtiw0110@gmail.com,
	dan.carpenter@linaro.org,
	namcaov@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Fix spelling mistakes in rtl871x_event.h
Date: Mon, 20 May 2024 12:32:50 +0545
Message-Id: <20240520064750.48912-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled joining in rtl871x_event.h. This patch
fixes the misspelled joining word.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 759a2d27d8f2..0cc780cf4341 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -37,7 +37,7 @@ struct surveydone_event {
 };
 
 /*
- * Used to report the link result of joinning the given bss
+ * Used to report the link result of joining the given bss
  * join_res:
  *  -1: authentication fail
  *  -2: association fail
-- 
2.34.1


