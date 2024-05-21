Return-Path: <linux-kernel+bounces-185103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991938CB091
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CF01C20912
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC614262C;
	Tue, 21 May 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuyT3iLG"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95B770E3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302206; cv=none; b=H6pT6Bj2xuoZBu3fo9vFOvXICIZ4DSPNXw5ju6Ivofgix8VUbyRbqi+xFtjVpKd+2v3DRdqVgbiAdp9fnQpO7ZMCaHk5YTTz7Efl0fZyIciVToJ+59MqroPMtbHaj8+S1rPSrJaDEVAcsuw1itOF7YP6GIo6wwYAlHwlegELYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302206; c=relaxed/simple;
	bh=RkxcTAGiypwdS8ks2MdXm+0G5zezjLyPmKlm8b5l57o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEkpYbSWAyktK6ILm4ExXceZNqmqhHCJZxaA1MkbShODj1SLViy8IpYAD1DVOe/ps1L2rmBcrzYW3qeWtn9ug3NfACrwiPxgkFBeYBcQ42von53RGDRlTOkkDl+T9jlxQBpgfQUOLF8cVTl2dfQYb3NBGCb0M5l/ZJWO8gfKPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuyT3iLG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so741700b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302204; x=1716907004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BynBJz4xedvnT0nDFPYWUwNi7+Io9mNGTAt+X4QFG34=;
        b=HuyT3iLGA1fFIcgo6JFrEFL1HmypfSXTVnMeB22hA8CUCGO6gsGFJ9CSlPuFSLLs/7
         fG+MeEfVXujyX1cdDbJklkJ0H+wU5v+A8jJI2h1KdYvL8NEz1Tn/G3pShg5+UthpDNse
         HO5v27m0MlhIhpOAgv08+xy+hw7ECuCEP15yHIfbp8WXz+UGuj42mLPqaHHgUS8i5cDS
         8N+AfM5Un1YG7cZ27Ns1AU7LjFTvHVQnF1ESvoWMsIM4Mg49FrQLSMD0gJdAetNUdISg
         QZHZnIeqeUprXJcY3KQEzLTpXje3APAAskSWF8kfXRtsihw5TDKa35kdUghfB2rEfgXX
         tsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302204; x=1716907004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BynBJz4xedvnT0nDFPYWUwNi7+Io9mNGTAt+X4QFG34=;
        b=b7zrjOVsIUqZ8M4x4ZHJs61QKIuobocSq5KAGo8tIyxcaas7n6irjigonSfnROsNmY
         8axhihoJqL53vUo59s6C2rQ3C6J9Y3UnKQW0S3Z37BKkZnId4dLYrqyXKWoSXRB7OT63
         qW9nH1Pnna87W+uIKIDd7HNledXJAf3ssFrH9/4zxiv1T1LnNYg0+qCu4UiIxnGQiTCt
         iG8J8LlNkxnCaDhNS+78KSXyPhYZPlVU3WiZJk+3GCVXhTeZxWIyGn+yhLULyIKjreNc
         DfW7AYQPM9xbdYxj4Ao8mT/bd3DCS4b7ZJXiZY7cfs0muJo2QXWMDM/r8n6sT+rkfi92
         1U5A==
X-Forwarded-Encrypted: i=1; AJvYcCVFvVJ/F8ClfVeLp3gWmINRridEEL+Vet1B46A/EYkGpLn13hHTesxSaIV07GoQ7lmcH4K+KbfPUcdH8HXRZni/UDGBiEPmVMB1Nmvb
X-Gm-Message-State: AOJu0Yzs7plJww2vQfzWJtAen/uFIQAzoEjbdgXMRhqvGDVnElqEMYjI
	NhxPkkgqnFuglv/13VlrfiqqKI9Iuj2DBHl4bBuYuCvjkE7Ls469
X-Google-Smtp-Source: AGHT+IEhHkXc3gEQ/59qxMkeqDVXPHb5xH5G9ULXkpNkxZMVvu+VESyyg5CeRR2jEObc9IE9uXY2jA==
X-Received: by 2002:a05:6a21:2782:b0:1af:b80e:5406 with SMTP id adf61e73a8af0-1afde0d4d1amr27260112637.21.1716302203457;
        Tue, 21 May 2024 07:36:43 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a632823sm20886815a12.19.2024.05.21.07.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:36:42 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	rcengland@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fix spelling mistake in rtl8712_xmit.c
Date: Tue, 21 May 2024 20:21:17 +0545
Message-Id: <20240521143617.53139-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled aggregation in rtl8712_xmit.c. This patch
corrects the spelling to increase code readability and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index d7d678b04ca8..12f2fdb1b3cb 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -247,7 +247,7 @@ void r8712_construct_txaggr_cmd_desc(struct xmit_buf *pxmitbuf)
 {
 	struct tx_desc *ptx_desc = (struct tx_desc *)pxmitbuf->pbuf;
 
-	/* Fill up TxCmd Descriptor according as USB FW Tx Aaggregation info.*/
+	/* Fill up TxCmd Descriptor according as USB FW Tx Aggregation info.*/
 	/* dw0 */
 	ptx_desc->txdw0 = cpu_to_le32(CMD_HDR_SZ & 0xffff);
 	ptx_desc->txdw0 |=
-- 
2.34.1


