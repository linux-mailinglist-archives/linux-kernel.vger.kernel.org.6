Return-Path: <linux-kernel+bounces-436817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E239E8B50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24658161419
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479052139C7;
	Mon,  9 Dec 2024 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LsYQHE49"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBB15B115
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724271; cv=none; b=j/aVWaWCYs2ZPBWAbmJcGAcBXTaeLVNI4RnAiZ+ZDUKQdWee++/qtJ59hVVPs1kbHxib6mixokCTwkkdEvCuAWFgXP79XaKT8VdCjlLbFBhQjnh1l1Qay2B2liI1G81CAMwffGFxJJjLwiodrNse3Te/OO7zTc4SvpU2FL5HB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724271; c=relaxed/simple;
	bh=F4vouyVtcKW0X8jSdaJkiCxfL9VYGc6mP6tX/c3lWDA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ROaewrehPGX/mJcWnXWYhkP/V9vBuZfDwf1AX3a0VEZeWxWkyDZMjvh3GItjpgvB0jcTF+mLrbi7jgwhO5hXhithrrZ4B8Z5R6nAbK3dO3NcL2ls+XGGKDiz8c35BppR7yA2lSXS3DnquRiXYeE6hVSC+hBgf8kBAidm9dgXLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LsYQHE49; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc88476a02so3329911a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733724265; x=1734329065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xBLZIFuwdPdIo7c9yIdBVJBPUeOE/XllfXOGGCfPYA=;
        b=LsYQHE496pg9BA6LE2dn9A+BOVKHc0A6jsKr9ryx2Wu1sCkWSdE9HMfuMjw1wPoVgy
         cqBKdd7Pz6jyI2IOXZKINh+QEfS66jIvn4C8UWKaY4DzQCSm+IUeinD3C6JQtUr9OWBv
         1Ur22+/g8PHZRxOF1wkPWIKzHgadSlX6/tBmHFAaWoi3UBdUsExajDcYzxBa9zzjUhxK
         YmxFNUiv31xVoSMY353Kbj++POQRtJnilwfTepjJ89r0G+J3QRvxY7VVE8j1b2HXY/ea
         +7pE1ZYCuM6OsTkmCSO4CLJ6vIIhwDW5F3DlhDUykHfyB2/Zk5h5jcPcJDuQIcNjRlFL
         qsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724265; x=1734329065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xBLZIFuwdPdIo7c9yIdBVJBPUeOE/XllfXOGGCfPYA=;
        b=wbKNO+qkIbpFZhCsTupHpoG4PFDP6cqL6to0PzqfeQueSM7RvL2w6sXWTOVBgQIPNp
         7DoU+8ZecHzO+uYt27eRrJHwqs9d/cSeq8bqbI/lVxj/iOrAkIn0ZnOqA0bL7YyA5JXM
         fHvlXfg9PTsT8XWKjyRhSbzd1/lkGD9Y13wbw2axzAwuwFOKMLQHfc1RMSOMOLmd6q8Y
         FG4+dnVP+vwWhTw39LuL48cMWQI+siUJ6nIBVxUIkmiT4YL6l+4+TsThNEtO9QhQeyeq
         kMemnry3BGcnwAc71dTecn/r35waZY7VHguqy5t2JPHKEmGc1ySGtQ/rUjku3noxxl6M
         oWdw==
X-Forwarded-Encrypted: i=1; AJvYcCWUgEn4Q8cphkkWwwCBK39EOn2OibCLC6Ytc/DgSX7YpQ/dX/pDuyu1cEL4I5Z5Xua/GKSi7BnlSydakEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPS4xW4qGkcvn1Rh3WNChethNNxZxnOrYAVSY27qPlfOYGzxR
	gkHRrlSrrPBK1VmpZYUXQ1LO5M/aicW3TVSi8DLBLWGv35xMeLsKdVshw51vkzA=
X-Gm-Gg: ASbGncvr/bdCrlUU5WttCFASA/GIWLz8mUZuW3elKYNEUTDdpwp/cuYob0hK0hvw43B
	AlNEl7uo14bB0FtX4SdRDqM/52HuPs37lwFOzC31g75xHaMcR0913ERVTruaFG5XlUJexJSImgm
	/ZCSDwJJr9fBAyGg3ANdRBy7uDR4u535afjjmjw7GmDY1ag3+JKDJ9b003Q6SF2Qc8TKF8tI/ok
	m+x8Ro2i8DTXylFI8DFlaMig8WYSvFIcd7MGfQSsRvxtUjwFd5NeIsWgWpeJg==
X-Google-Smtp-Source: AGHT+IGnNpiYR9YRPDiKPN9Q5vTAOHi7xpfdLlQY2S9l/FJYyvgp5XVUlnCd4fDLpn15Z3eTjLxA7A==
X-Received: by 2002:a05:6a21:7895:b0:1e1:ab63:c5ed with SMTP id adf61e73a8af0-1e1ab63c75cmr2452719637.23.1733724265250;
        Sun, 08 Dec 2024 22:04:25 -0800 (PST)
Received: from localhost ([106.38.221.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e34bbb17sm2104894b3a.56.2024.12.08.22.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:04:24 -0800 (PST)
From: Jian Zhang <zhangjian.3032@bytedance.com>
To: wsa+renesas@sang-engineering.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: slave-eeprom: add latch mode
Date: Mon,  9 Dec 2024 14:04:21 +0800
Message-ID: <20241209060422.1021512-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read operation is locked by byte, while the write operation is
locked by block (or based on the amount of data written). If we need to
ensure the integrity of a "block" of data that the other end can read,
then we need a latch mode, lock the buffer when a read operation is
requested.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 5946c0d0aef9..29246ac7d350 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -33,7 +33,9 @@ struct eeprom_data {
 	u16 address_mask;
 	u8 num_address_bytes;
 	u8 idx_write_cnt;
+	bool latch;
 	bool read_only;
+	u8 *buffer_latch;
 	u8 buffer[];
 };
 
@@ -49,6 +51,11 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 
 	switch (event) {
 	case I2C_SLAVE_WRITE_RECEIVED:
+		if (eeprom->latch) {
+			spin_lock(&eeprom->buffer_lock);
+			memcpy(eeprom->buffer_latch, eeprom->buffer, eeprom->bin.size);
+			spin_unlock(&eeprom->buffer_lock);
+		}
 		if (eeprom->idx_write_cnt < eeprom->num_address_bytes) {
 			if (eeprom->idx_write_cnt == 0)
 				eeprom->buffer_idx = 0;
@@ -69,7 +76,10 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 		fallthrough;
 	case I2C_SLAVE_READ_REQUESTED:
 		spin_lock(&eeprom->buffer_lock);
-		*val = eeprom->buffer[eeprom->buffer_idx & eeprom->address_mask];
+		if (eeprom->latch)
+			*val = eeprom->buffer_latch[eeprom->buffer_idx & eeprom->address_mask];
+		else
+			*val = eeprom->buffer[eeprom->buffer_idx & eeprom->address_mask];
 		spin_unlock(&eeprom->buffer_lock);
 		/*
 		 * Do not increment buffer_idx here, because we don't know if
@@ -152,6 +162,17 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client)
 	if (!eeprom)
 		return -ENOMEM;
 
+	if (of_property_read_bool(client->adapter->dev.of_node, "use-latch")) {
+		dev_info(&client->dev, "Using latch mode");
+		eeprom->latch = true;
+		eeprom->buffer_latch = devm_kzalloc(&client->dev, size, GFP_KERNEL);
+		if (!eeprom->buffer_latch)
+			return -ENOMEM;
+	} else {
+		eeprom->buffer_latch = NULL;
+		eeprom->latch = false;
+	}
+
 	eeprom->num_address_bytes = flag_addr16 ? 2 : 1;
 	eeprom->address_mask = size - 1;
 	eeprom->read_only = FIELD_GET(I2C_SLAVE_FLAG_RO, id->driver_data);
-- 
2.47.0


