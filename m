Return-Path: <linux-kernel+bounces-207677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70018901A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8182812E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781A6A8BE;
	Mon, 10 Jun 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ij0+zD4t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1C5473E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998550; cv=none; b=OqmIBRQETMEfXvOLnTRckIFtUHLa/GMIHPsX6yJdcToG1gP+du+mrQU3t90Qb5nWcl3dzEdSSEC3Q4azhIXkesYyHC0k9HS9IuchzVGFfs2Up9bqzHtrjYVS4epWhEZVG3OPIiBiRwYW3ZJH0O/fhGZ6FLCJWUAY0qfUvOE6U8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998550; c=relaxed/simple;
	bh=DAYO1UkoTEwRYzPKZeP2B6xOig5Qbj9NtQUJIxmkDFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDJgkUcUBcy+gyKwLOBpKYJeLlP8aAKFv1ldWUqVbRRKiAGwJerTM0XzA1RPCMi9ayopSW1cId51Psp5EM74j04E3u0zp4ipbASbP2DRlDUbgjx86ouaGkTmXLJIeULTsKGu8DKqsNNSvz4Nn1jpT0DnLkqLh3Spu1zy06fevwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ij0+zD4t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4c7b022f8so37087445ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998548; x=1718603348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5EeJFmlN6fZbFYCrboW8TSJ/n4ASdI3Z95ifsP8Epc=;
        b=ij0+zD4tLGUVMZNIJkdZmjchH72gMZimzFTRxr+sbZnqMWNlbBrfE4KIGrdzbp/5ha
         54Z3g+bvvh1F3djzpLNi5++KjYOZgjXsOLOroKvVA3kJJw+jgI7FEy9J08gOvoIUHqjj
         ZMmLVFXOW0uCY8zfeslTBSqgNUwmPp5EeDirmJOT3OM3WglP7Z1apPUffsfN8bk2j38N
         ONCdfgPp/GQ22LirAP/3tJpXyW0cFdCAw8lEnNpSz3dCAKrMrNM3wfHGZI4dbzYDuRp/
         pmtOCENGKoizO3D4k5YdZ2uOKjggiU6IHh6HwgLTi+BGN7BSOskOBmX8wNVesj2yncJL
         bSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998548; x=1718603348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5EeJFmlN6fZbFYCrboW8TSJ/n4ASdI3Z95ifsP8Epc=;
        b=aCFWARfdFbEe+WMzZWoMjs4qxpcua1hD11XOl3NP88aVP9tizv4WHXXSYvD4vM2J07
         b01IPje4+YUMOzZghzFuglmnccU/HGwfl63O8BQSTQ4P6q3NjSVwzqDvKgIuM1oXwMcF
         8RkQJMd31u8DW43K6UyDAXIewhgIb/bjP7pLH+wYk0CMxx/EvN/vECZDmvYTi9u0NdyB
         120P5mbnMhWjJYfPs0ZUFVEitp3oRbpmm1dYtb+54/eZkhcK//DRW/TrMO1Ezfxv6bC8
         LglYF8D8OWpBR/c4n4TH1Ojk4R0Oty6rqa4mW7v3XN4HDa1AmejN4Z7bj4ePkUPcH2ES
         IiGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJwdcOcaBDFNMeDnt78ITRKEoDiNyEfP6nMsrkUNHSdgPMVY5VaraVcDeHNJASsb+PlHD5ZXMoGqgbnT3dMBUmnkRR6dtbDCrfQlH8
X-Gm-Message-State: AOJu0YzICGTuz/DBgEBFoO2bibCw5ZNZAwW/ir6CF9HqM6UVpRC5AtTq
	62mRTSMBg+is4WmNwuC7ffU++U2wPyftMna/Sta2MJTFe3oqgBxL8gXLtj0Ur0v352uG8RMTJPn
	6YEc=
X-Google-Smtp-Source: AGHT+IEDdY0qdi2qtgDOmmQ+9TcA0sx7tqqRpsWnHXQHxWfoNbdXcIi1a47EyGFvp2zlA8CL2juLUw==
X-Received: by 2002:a17:902:d504:b0:1f7:1931:6123 with SMTP id d9443c01a7336-1f719316628mr13099925ad.38.1717998547875;
        Sun, 09 Jun 2024 22:49:07 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:07 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/24] Staging: rtl8192e: Rename function TsStartAddBaProcess()
Date: Sun,  9 Jun 2024 22:44:39 -0700
Message-Id: <20240610054449.71316-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TsStartAddBaProcess to
rtllib_ts_start_add_ba_process to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7cdeca7ed8c2..ed6a488bc7ac 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -431,7 +431,7 @@ void remove_all_ts(struct rtllib_device *ieee)
 	}
 }
 
-void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
+void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 {
 	if (pTxTS->add_ba_req_in_progress == false) {
 		pTxTS->add_ba_req_in_progress = true;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 33bb1cbb525a..0029e4ab4394 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1770,7 +1770,7 @@ void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
 	   u8 TID, enum tr_select tx_rx_select, bool bAddNewTs);
 void rtllib_ts_init(struct rtllib_device *ieee);
-void TsStartAddBaProcess(struct rtllib_device *ieee,
+void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
 void remove_peer_ts(struct rtllib_device *ieee, u8 *addr);
 void remove_all_ts(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 56510365f1a9..369fd26180fa 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -301,7 +301,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			} else if (tcb_desc->bdhcp == 1) {
 				;
 			} else if (!ts->disable_add_ba) {
-				TsStartAddBaProcess(ieee, ts);
+				rtllib_ts_start_add_ba_process(ieee, ts);
 			}
 			return;
 		} else if (!ts->using_ba) {
-- 
2.30.2


