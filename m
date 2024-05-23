Return-Path: <linux-kernel+bounces-187486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839168CD26A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E1283756
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4050149DF5;
	Thu, 23 May 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMFxKz/d"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC6149C60;
	Thu, 23 May 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468159; cv=none; b=O1238CzgD4M2UY/brwAzDZNgun53wyEQHtXzlmlTzAXjb3XtAij0LXLb5rDgxjaHJwYCmpI7Ci8YxKuJRmJq0f1kWGMpx2mRcK8ebaPzwnvlAMPAB3F/XjBEYq4X3i4Gr/PwVBnFOjrEwXH/JtFh63jCqH+NJtubaxf7qSP4pcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468159; c=relaxed/simple;
	bh=Esn6qQ80MM0mLfU5d1BTrg+JdFQ+xC7owVO0xXFpm5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHVy4UgsNcwGRT57PMeqBoFtwcmkl3nuDknCLB9PDpSi0K6YGgB2vj57oTMCFVNMrf/bPbtws+IzSYmK3oFvC7mEBrV3hxRAYEG9RhMHw74YTpV7/lhrAkjYaxgTilxjqQBFpp5ofyB+SOaqznxIuxpP9BGvbFQo26MktKC3yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMFxKz/d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f3421564d2so3733685ad.1;
        Thu, 23 May 2024 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468157; x=1717072957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbQU7x0E7jnDIOH/Jd+2ktPiOpulnhjgxogsGpGe1YM=;
        b=MMFxKz/dE1eB4dveiEfY66N0Ee/0xDGJA15ij0boUttVZ/qbiIAnp6ycmtd4KYZo3b
         6oHF02DYEzYsMYANe8ElMkNAmXOINDXUHl/iR0idp7eUooZW1X3ZfNQode0XB4el3d7v
         LZmR/DGNqTaGsyp5c+MmKRUV52gY92ReOzWRNfVwegAuU+PTJK91CTJXiDoRsEjK8vHx
         rgSALMstVI1FJcGNjD8F44O4QioOVsYQiqf2wtRZLgKbGJynuWnrMmFbvPD1dFM2nw16
         CfpEsiaLatuKmIpQItFs7RfMfxYD088nXBXOO+156v1yIG+fqns8qSXPpo7Gf5CCVVGW
         IH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468157; x=1717072957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbQU7x0E7jnDIOH/Jd+2ktPiOpulnhjgxogsGpGe1YM=;
        b=YSaeVtdvbZsvR4dJXEPjkL8xu4sqY7mTH5kM+HOwLMNehEjHR2youy04ERfhQY7cCo
         gmTIgiOtHCLsLc7vMie0Pqc/CbYGLfkEPdefu8g5AqN6a1lb0Tw6fcXdUJnA61XBPor3
         JdhZv0ZjUGKpjmKhsO1SSys8FRMIILQSor8U2xqXUEcNdpdAr9MQFLow+CdQJwcKstUZ
         cNL7PL4CxrSJD9r9PGXyzNAJs8v76KRMOhjld5sclvRviY5LviIcLSe6FdD/RM3QDbdZ
         k54+ef8FWNWP5P+/BThSeHGDgBvqVmgZyJhEbeokH0TX/JEWZh652gUYDhb0f+OlRGuo
         r4tw==
X-Forwarded-Encrypted: i=1; AJvYcCVwwry0ttZNrj1J3t1Qik02h4w9Xkcn/4TyrepPLKSfZCAJGsiw5xrwg9aPXgYRoBS3QaohRS39enAHCSesyCgYZe10P+nMPw3UonS+
X-Gm-Message-State: AOJu0YwPqaPkjjNerWAFWWLuqa69efPCS+n94ttcxShI5s3xJJPyy3mz
	cGiKHwGML+UU7Bz31I+tFv4A7duHhQUfdMel0Cr8M2o1OT9YgUvp
X-Google-Smtp-Source: AGHT+IHHPyrRvRC2l+E6UFyavRMYRZSN6jN9PPSwZRIP/D9hU2lokfItTC/nJ06Qfuu9ehKREjLc1g==
X-Received: by 2002:a17:902:f550:b0:1f2:f9c1:770b with SMTP id d9443c01a7336-1f339f0bc9amr34931695ad.15.1716468156978;
        Thu, 23 May 2024 05:42:36 -0700 (PDT)
Received: from velvet.. ([111.42.148.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b1b1d13sm255739035ad.0.2024.05.23.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:42:36 -0700 (PDT)
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
Subject: [PATCH v3] usb-storage: Check whether divisors are non-zero
Date: Thu, 23 May 2024 20:42:23 +0800
Message-Id: <20240523124223.1035964-1-shichaorai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since uzonesize may be zero, so checks for non-zero
are necessary in two places of alauda.c.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
Changes since v1:
- Add one more check in alauda_write_lba().
- Move check ahead of loop in alauda_read_data().
- Change the order of variable list in alauda_write_lba().

 drivers/usb/storage/alauda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 115f05a6201a..ebef1a8a7ca4 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -816,8 +816,10 @@ static int alauda_write_lba(struct us_data *us, u16 lba,
 	unsigned int zonesize = MEDIA_INFO(us).zonesize;
 	unsigned int pagesize = MEDIA_INFO(us).pagesize;
 	unsigned int blocksize = MEDIA_INFO(us).blocksize;
-	unsigned int lba_offset = lba % uzonesize;
 	unsigned int new_pba_offset;
+	if (!uzonesize)
+		return USB_STOR_TRANSPORT_ERROR;
+	unsigned int lba_offset = lba % uzonesize;
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


