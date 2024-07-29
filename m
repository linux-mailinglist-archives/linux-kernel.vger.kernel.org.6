Return-Path: <linux-kernel+bounces-266261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8493FD47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF01F22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EC1862BE;
	Mon, 29 Jul 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbRO/yOp"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FC78274;
	Mon, 29 Jul 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277437; cv=none; b=Awmkur2ADt5S+wFDPLeeYHxhVJQ/P3qERiSykkKrq6U8yl8TJt7QbgrrIk4GDqcMQXxqd6D9A49Wx6Ld/hGlnbzubUSqkdv8iHPGG4roC+eA+m3D4oNGMV49Ydgn872eBVR7VjebNfhv4uqmbFhiDaxstVI8H5GYmuvpSBm9uMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277437; c=relaxed/simple;
	bh=MPHG3o+R/QFUrik3POHpb8zmr6Vkpss+gxkQBRrzTJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LIfcDj/Yl9i6QwywEGaZDDszV4Y6znX13NdJGi9cTbVr2ZSXV24uq68USPDWlZ6IyMms+n35ncP6GzNVWRQDw34QQiLXBP2tXgBoToIQzY9AiRW/9ARcAesRn7eQ+A7X5fo/aOg2u0/G5Z3TAsUhr/I/FAXX8pZjMRNVr2raEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbRO/yOp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so2172943a12.1;
        Mon, 29 Jul 2024 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722277436; x=1722882236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yemLqtqvWl8R5S6sIbsu7pMycbwVn/6prDN8HksHxqM=;
        b=CbRO/yOpFm6PHWEJpv/tFcYrFe4L5mJXkBIS5elXJjWtNEz4SYL/wCHYMpQ08iQ/R8
         np3y4KTX86NEKTRJ28W8Lk/zO7SgQZ+5YO1wTGJUvHQpoEF5/jChzU0DbQxlzk0riBEf
         Wr7MH8XGGHtyTALNXaRXZ1dgXnvMMPueountdfDxncLNDJet3C0g4RjJDaPMnu9Grdq2
         8RMQHHYqvXUohiZ1+JqjMTPEWInWLc1Y7vhOKBpiB+PtVSst9YGw4Vu5MK3U80u2WvzC
         M5TDMebxIKQfCtEkCqBN+tfSxWOQjN39sa3KwdeEMgT//Of6QIxM3dUI3utfjJzFvKvg
         UIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277436; x=1722882236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yemLqtqvWl8R5S6sIbsu7pMycbwVn/6prDN8HksHxqM=;
        b=ovQp9TS5sVKE/adAqly7jDduWw6Ji19BZLrod7F/BRn4n4DPEsz/tstW5vS/m9jM4K
         ZSzUfjpkvB697jIkUgKqm73WXfqZU6udJ3sCRo9l9GzFPKb2NDmA8OtpCXWWD/WG294h
         GzpVzddd8RMh9YVq4RpYl8BqE/lUlz+XfDAHg6JkSBbDw3q29yoNdwd33twn2QcfT9sX
         3HBiJSY+a9baQsZUq25TWDErUUdcyRgA15vg7TJCZcbNu+X5zoptYNrxYaqeSCHscpHz
         P6dyROfdzf9GKtxaqPjr5FH9UvuqG5BYZgpjUtQd+Th83GAeLixbytWYiod41j/Il3Cw
         2TIg==
X-Forwarded-Encrypted: i=1; AJvYcCXdkTd9ZjdiqhcaZnbh5aiwIUwkj3k4BhT/M8CDyzM/gflSXc0XMCt+pNSSmB7u3/Jp1gzsz0tNDv7iXusTiLvFt7EgklY8ETi85xHdkZmhuO3aILMoXR+VtDRqgeO2TOb4FVMrZqTh
X-Gm-Message-State: AOJu0YwLFFDKgsLyqidQwTjbhp9fsInvF53Bwd9cE2LY8glZWxqbGG0s
	UjB+2sIwTSlRpNENPKI2rIqp6XhYGALuV90VyTUDmgXBAM3GSuhp
X-Google-Smtp-Source: AGHT+IH9+iUBJzVZU1XfIa0JLsbNv0olGSFfaWJAbdv0AQIjRWjfQ4jQRRWTZK213BA3ZnX9F8rSog==
X-Received: by 2002:a17:90b:1a86:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2cf7cf7fdb3mr14524692a91.17.1722277435364;
        Mon, 29 Jul 2024 11:23:55 -0700 (PDT)
Received: from embed-PC.. ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738fe04sm10925787a91.12.2024.07.29.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:23:55 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
Date: Mon, 29 Jul 2024 23:53:48 +0530
Message-Id: <20240729182348.451436-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bl_len from u16 to u32 to accommodate the necessary bit shifts.

Fix the following smatch warnings:

drivers/usb/storage/ene_ub6250.c:1509 ms_scsi_read_capacity() warn: right shifting more than type allows 16 vs 24
drivers/usb/storage/ene_ub6250.c:1510 ms_scsi_read_capacity() warn: right shifting more than type allows 16 vs 16

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/storage/ene_ub6250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 97c66c0d91f4..ab6718dc874f 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1484,7 +1484,7 @@ static int ms_scsi_mode_sense(struct us_data *us, struct scsi_cmnd *srb)
 static int ms_scsi_read_capacity(struct us_data *us, struct scsi_cmnd *srb)
 {
 	u32   bl_num;
-	u16    bl_len;
+	u32    bl_len;
 	unsigned int offset = 0;
 	unsigned char    buf[8];
 	struct scatterlist *sg = NULL;
-- 
2.34.1


