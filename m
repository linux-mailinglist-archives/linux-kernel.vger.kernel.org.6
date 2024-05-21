Return-Path: <linux-kernel+bounces-184431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9D8CA6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7D2820FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538EB51C4F;
	Tue, 21 May 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RYWLW1NC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B547A76
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261449; cv=none; b=Qjk10IgTWWHI6T1cuATe0rWLmtSvSwcl4SY4PNEaXIMimlSKKgXenrixbG8bzpi8aWYTRoEmNTySookXhIwLqApisCCjD4kBL1ewYNEK69VQQHcq7RTYivg2gZT/3wdZpKyQuilR6UPnclJPh/PnnAFjrrc3E7etkVfKNko8Fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261449; c=relaxed/simple;
	bh=xUSO0L0OOfzjr5/UosXPyoMQS3r3Io2/L3l6piKs/5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0sNhsfOCbmyXW8T1fUfV4lxyZnd5JRRW01HrLjO25LxA2G12HXWCLrm1uJ8vasVpaMr8K3oCn9sdaJ+uRX8GwPLAIHYQDEGGZC7nJOpBTHHaE5KHozxrAFmXN744bmgD512T/b+Jhp8jV/nb2vCx2DiFp4XGvmkrsFQ5T4EzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RYWLW1NC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f2f566a7c7so64563215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261447; x=1716866247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ8EqTPc0f85y/sPEaQ2P9Fmp+Ujn48v2g0YjXV3Sdc=;
        b=RYWLW1NCt4aA2XPC8uzfuaxoAvyLcIUNyE4YTeHezRlOTnbzZbUZYpJ8u/YSpClsgE
         GN3DoNte4atLYqFBnHGIL9+VLVLTjW4f09QxkGoLkDVTksAtLnad3M3fob4JCItCmEXv
         pcLNqTHdTHBxKLXW+P0H+GFl20SghYCnBJ1iVA2vx9zWBPE5//zCP2lsYf9G3whr4opp
         7nDIRAGiqK0fOra7J0TESQwTjLKdz/A7+3oMG3iC5MVwOeY4FBjeeDI4esHWl7UwCrEt
         PPR+mISvTGegkpLnLLHEM9O2CqfTOHr2X6zMopYUZkclzZ3vrhlKkLCiDSRiCB8QnXPi
         kuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261447; x=1716866247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ8EqTPc0f85y/sPEaQ2P9Fmp+Ujn48v2g0YjXV3Sdc=;
        b=CmEn0oByn88VxTx4S7rOgwGhVW+Y8P6nr/PJdrf/KXVSJZxuGOhGybWDA6zbtxJg36
         o6nAzHGXumhrYTXUqtt7vqyrhDBr+BVXlsbRK2YxsxyiI14jOGzOJpLz0mfXT3Isr+cT
         toPG+7vwoJEO+kJI31Fyf5HuiW+VHi+GTZ//upcZWQnV7GknYMcHOclkzZOECS1luc1v
         r5jR/r1IkFuNKuXbfW/uoH6M/Bvoh/YMRkAbt+MznF/eYAPA1BR8SC465wOvmTLwV6o7
         UBbr+jxT+gt4qq3UB+WqpiqtZWhQ5/Y9hKtPbpBuXTRUsItXqAAxrBGY7Vsr5MUnMeDD
         kqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUs8ybADbGDMMs3rpomCMUGowaHinLMoIQIG6ymd2TBgmBOBmUvruE4QXNMh8q5Wsk0Ggpx5TP9HbnNGsA/x46yFOQDyH3q4hQStFl
X-Gm-Message-State: AOJu0YxqiEGGcJlvqok7GTJ6ESTj3aMtkVbKZdbRiaq1eRyEnmXRHQUP
	LkGkIXkQw1lunwnS4pSG12OCN7ndEDzGmW33Rew+08X84Th4VPC0IEy7jJ4xllk=
X-Google-Smtp-Source: AGHT+IENtRCxhNAvkpmcZ59SyrjtbbYxkY+wENlFTVIEpZY1wEkucQ06zKq5zCDgo7JH91LudJzktw==
X-Received: by 2002:a17:902:d511:b0:1f3:66f:e030 with SMTP id d9443c01a7336-1f3066fe370mr40450515ad.56.1716261447012;
        Mon, 20 May 2024 20:17:27 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:26 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 07/31] Staging: rtl8192e: Rename variable MBssidMask
Date: Mon, 20 May 2024 20:16:54 -0700
Message-Id: <20240521031718.17852-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable MBssidMask to mb_ssid_mask
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7f1c2f49227e..3722fc0cae1d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -915,7 +915,7 @@ struct rtllib_network {
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
-	u8	MBssidMask;
+	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
 	u8	bss_ccx_ver_number;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c29efa3eef6f..19cb717df3bb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1818,14 +1818,14 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->ccx_rm_enable = true;
 			else
 				network->ccx_rm_enable = false;
-			network->MBssidMask = network->CcxRmState[1] & 0x07;
-			if (network->MBssidMask != 0) {
+			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
+			if (network->mb_ssid_mask != 0) {
 				network->bMBssidValid = true;
-				network->MBssidMask = 0xff <<
-						      (network->MBssidMask);
+				network->mb_ssid_mask = 0xff <<
+						      (network->mb_ssid_mask);
 				ether_addr_copy(network->mb_ssid,
 						network->bssid);
-				network->mb_ssid[5] &= network->MBssidMask;
+				network->mb_ssid[5] &= network->mb_ssid_mask;
 			} else {
 				network->bMBssidValid = false;
 			}
@@ -2349,7 +2349,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
-	dst->MBssidMask = src->MBssidMask;
+	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
-- 
2.30.2


