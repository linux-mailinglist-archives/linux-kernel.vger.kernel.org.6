Return-Path: <linux-kernel+bounces-406262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D05C9C5F93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A77B28051
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAA20495A;
	Tue, 12 Nov 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkDuRESP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAD20CCEF;
	Tue, 12 Nov 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427130; cv=none; b=dfxdd7PxMChRRok1Dfalbgp2mLYzA08EISRFRqsbYwnXRUI1+GNvTxTpUcrwSxl/TYG4/J8evAqnODh0+b4jwQ/63lTxd8hwPawNIdtFcZPl8j6g3TuBG/pE4Nn5cBJEhzvPC3eOGL1WS3gs4M5oiYK/7vxII67hddE5IJEwtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427130; c=relaxed/simple;
	bh=BS+W4NLNitc/rh658uxhSObPTer0s+SXmyx9+eClOOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0Cv3uJIjPe7yiAR/SPslOPl2SCkvaDcHrxevb0lAHm/NC71rDeP5932gDm2W7yXe+IiMlk3HF7Nikb0sOH/Wv4cQQ+0HUNficb85MzQXE7ZgHE1rIedNX8iSp/HPlcDJW48JbrNeGqqCintdMW47iMy823RDlEGl0WFhlg+z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkDuRESP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d495d217bso5321322f8f.0;
        Tue, 12 Nov 2024 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427127; x=1732031927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPqm3+0wFCwqO/jzcOFah7stBZqw75yUdyOGq2gHnGA=;
        b=NkDuRESPY9x71FUm22u5rIDSH3CnTX04iuRRgQkCizoPM22h4g+ctrlPbyzdFTKXph
         73BQ3Up0867piPZ/ufmSRHfbkbZXHRzT1wN5xzjQzL/MFqIy4JhFnyjtP+dNK8FDIuoo
         SmzdVANkpmEDA2KRMGNm8/5x/f8KZ7HQExt0qLyNyW1yEU5DUQ4bTw/dM0DkLPKSVV5J
         MRMroDUdZ3G7zOh7233R4IkrH67QMylyRLCePy4uekUH/z8HcLGtaRKFW/9jx5K729hC
         XhgS/YKqPbcOb6PP3lKxWJQMYPPIDdXtziYYNl5A+9udPlbGOMO7nq8rDLMaZwXarxyK
         4JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427127; x=1732031927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPqm3+0wFCwqO/jzcOFah7stBZqw75yUdyOGq2gHnGA=;
        b=YcZb6jO+9isep5qgZ91fex5oGQHOt8CsdOwWRt6QBn0ycFR4KYIHCKDtqypzcUXCKz
         BtP8244N42Jg3vSMECrSUmKXsDUSpRPT48gDnjzNpVYBuSj2uQyW+5upOcZC2+82h+t4
         P+51uQPceD4kywfuzYJl762WZ5mTAtYsEPS0ozDxZlyrraSdAPDWdAjbv3JLrKpwcsuE
         FeiL9rzAd5Q1Krw0uLYMM4IVEWcb3ke7aUJhttpkDXsl0GXpv6INr+FbqVFentBLOxbT
         qnYeA1kwoMa72f4swYG7ycedDhwMVrx9mSlJYqH1T2BYJ5OwSwd827QZONPvHvKJwE/B
         WsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUhVZY3MKqz6ir6pBbfSAi30Ttc4o12d3d9BmYH2swZ50KqzoN19bIfZV2HxNTmJaiF0DnSHE39c8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYb7pOF5R3wfVduC4cL5wXQDI92jaF8A6pZh8OKqIJi5efsNn
	kZzekzJDI4HR8ZANVqQ45FhN/J6ycDnV9bqGRUTaqq4frXTWHRI3
X-Google-Smtp-Source: AGHT+IGF1oY4L6RmN+BZPkWQctTMCBFmLlST8MkZ1QDOGfGAvINLvwrekWN3unxTDcmS+thQ/mgwCA==
X-Received: by 2002:a05:6000:1564:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-381f1884855mr18317807f8f.41.1731427127167;
        Tue, 12 Nov 2024 07:58:47 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:46 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 8/8] drivers/usb/storage: refactor min with min_t
Date: Tue, 12 Nov 2024 20:58:17 +0500
Message-Id: <20241112155817.3512577-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t() instead of casted min().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/storage/sddr09.c | 4 ++--
 drivers/usb/storage/sddr55.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index 03d1b9c69ea1..30ee76cfef05 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -752,7 +752,7 @@ sddr09_read_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
+	len = min_t(unsigned int, sectors, info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (!buffer)
 		return -ENOMEM;
@@ -997,7 +997,7 @@ sddr09_write_data(struct us_data *us,
 	 * at a time between the bounce buffer and the actual transfer buffer.
 	 */
 
-	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
+	len = min_t(unsigned int, sectors, info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (!buffer) {
 		kfree(blockbuffer);
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8227478a7ad..a37fc505c57f 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -206,7 +206,7 @@ static int sddr55_read_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min((unsigned int) sectors, (unsigned int) info->blocksize >>
+	len = min_t(unsigned int, sectors, info->blocksize >>
 			info->smallpageshift) * PAGESIZE;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL)
@@ -224,7 +224,7 @@ static int sddr55_read_data(struct us_data *us,
 
 		// Read as many sectors as possible in this block
 
-		pages = min((unsigned int) sectors << info->smallpageshift,
+		pages = min_t(unsigned int, sectors << info->smallpageshift,
 				info->blocksize - page);
 		len = pages << info->pageshift;
 
@@ -333,7 +333,7 @@ static int sddr55_write_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min((unsigned int) sectors, (unsigned int) info->blocksize >>
+	len = min_t(unsigned int, sectors, info->blocksize >>
 			info->smallpageshift) * PAGESIZE;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL)
@@ -351,7 +351,7 @@ static int sddr55_write_data(struct us_data *us,
 
 		// Write as many sectors as possible in this block
 
-		pages = min((unsigned int) sectors << info->smallpageshift,
+		pages = min_t(unsigned int, sectors << info->smallpageshift,
 				info->blocksize - page);
 		len = pages << info->pageshift;
 
-- 
2.34.1


