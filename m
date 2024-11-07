Return-Path: <linux-kernel+bounces-400178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A9C9C0A08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76854B22C00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BF213158;
	Thu,  7 Nov 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axPO1j/v"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E6212F0E;
	Thu,  7 Nov 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993042; cv=none; b=YuRxZzvZq0sNY1FRxBa4Sxehghe/ZucS/kWVBkl2fxrXojLVwVtd7nICIPTusiXyrak2cUIwDfaiw2zcn2U+ZRzig2XKbc3JXkElV/YM6wzZ/yDkUEIWb6VXJfGzZs0AXH4X8hRpn+LscNkjBHRIrm9PLEQLVAANeLZIiS96YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993042; c=relaxed/simple;
	bh=Ydytn3zFPXQ8db8t7w1VjU3Z3nD4s32fMULsIAHYe2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S2IUa5GjGJucA4OVq1VerpER+q7KudfYynxbQG7kw+ABCm8052mIvjTXtZmA5Jf/l8ti2pvtE2ATUUl2UMm2b/qiEMsa7bqlMrcoqTGWGOSYOXXMBzpvJUoVs4NqgpExLh6zmbMQdeEHQ9u69wqcPzewLeBdHz5Ofkjarxh/U3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axPO1j/v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so707655f8f.3;
        Thu, 07 Nov 2024 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730993039; x=1731597839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iu+6qwj67jqw/aMxFHS0WsWdHyUYLzz5doN8TK6GCeA=;
        b=axPO1j/vvF2g8Fivqa7KcKV2pEKkOMGlCW51lLSCRUlpu/7OK604/Ugt0nmHGNgl0C
         NRYrOI6kzqP4z7OkaZQj83rCOFLqdw3ch8prnGteZ9ZWPvKwaM9B5Va125H0NIclEGqo
         yVAHxxN1/ywN5kUrWXpgC8a1XhbPrdAgdM6pjgm9CqaukcSedctApnARUXd8k0gR3P46
         UEXpqRJuee7LIprSNBr8SPWMIkYRlxmngnOEiaZCaagRSabDH6E5VPtzBBNm5GmV/ubQ
         Z9Xkym53HywmBDCLfvnmkkK+RYkOQEGQr7IAQCswTmTv7hbfFWs7QvLLDJO7jEIi7C6r
         Zk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993039; x=1731597839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iu+6qwj67jqw/aMxFHS0WsWdHyUYLzz5doN8TK6GCeA=;
        b=Fh9e85avM3PVHBp89Tb92o8d7o4PdAdzAaDugFCP0vwNGiRU460DuCwztUd1hmgVgy
         PE9NMEvqQeOaZW1HTM6KA1F4GpUdixAQDcxnXbHvX8fvBxALzhim7hk6NJ8HdSovG5ke
         XldARL85OLN4tb9N5jjdIwf9Ge8/JTP6xpaJmtvjtKx9MoTsxmKP1NTdwjiBA9+Nm0dt
         AjZRtGd96rPVsQmtdUkhm8znCE8kAhqaUZvMk/x+xcE2KOpPbNUpH5LlB1o4FO/zSEkd
         Cn0R7y3hxAsNUZhaypxKFSUEGzBfyzu9qqetG9mtBbOiLw7qLp+ws35ep46IdCkWlFFi
         ZXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVxm7CVps6uEV3ZBrOZQcUtBeLw7yi6q6UJI8vgiuH3GNOOAeoWqiShku6Gx17De60gvV5ht/X6YLUuIJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMa6bO9Cr3peZyVlCCzSmGvJs3QGlS+3nAqUGhMdJNThicDr/
	+eJPntNH4Fh/kIQrFo+YNre1+YaypTXI0JmrwHlBDMZbDx53Zk3yiF56De9nIk0=
X-Google-Smtp-Source: AGHT+IHGtxXAynhb3KJmGzpenqjLjpVrlz+NUezG2N9EzScTrr3fbysZ49WwOOa/gl3juBSTlHoRwA==
X-Received: by 2002:a5d:6d89:0:b0:374:b71f:72c9 with SMTP id ffacd0b85a97d-381f09c6060mr278504f8f.16.1730993038544;
        Thu, 07 Nov 2024 07:23:58 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e46bsm1964610f8f.30.2024.11.07.07.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:23:58 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: remove redundant check on bytes_left at end of function
Date: Thu,  7 Nov 2024 15:23:57 +0000
Message-Id: <20241107152357.63387-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In function ubi_nvmem_reg_read the while-loop can only be exiting
of bytes_left is zero or an error has occurred. There is an exit
return path if an error occurs, so the bytes_left can only be
zero after that point. Hence the check for a non-zero bytes_left
at the end of the function is redundant and can be removed. Remove
the check and just return 0.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/ubi/nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index a94a1a9aaec1..34f8c1d3cdee 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -55,7 +55,7 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 	if (err)
 		return err;
 
-	return bytes_left == 0 ? 0 : -EIO;
+	return 0;
 }
 
 static int ubi_nvmem_add(struct ubi_volume_info *vi)
-- 
2.39.5


