Return-Path: <linux-kernel+bounces-320373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA71970972
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91DCB213E2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264A17AE0C;
	Sun,  8 Sep 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="SAsjYiXS"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5E179202
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823601; cv=none; b=BOvAk7oC//vGwxOWtRva54ej/e91DrVT+vajjbiCIRd3HK8P6+5dQmb3aFt0U5EhfrYybOWOSmiMED7RpjFXhtHHxKGYJy/D21qto9F6Txc5kie4s6yQiCpGm3DW2AyMfVxI6JLmKgfRaMxY9SzWms26mlJs6ksfRyIug3m4yGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823601; c=relaxed/simple;
	bh=XHwe7H6bexz83D+eLYTBzL3QtD3B+r1/0yJ6B8ukoh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLALqwv/v7exezy87eeQajEQFpi6/EKQjrmsTva8B3mob88AxVqqja2VimaGPKMKY4KtXIX9ahfGGJv1nNASiD0pBURu6tjJdqaFNzxef6tqM8xQeypZNcnQbenurh4XRKv/lzRW1Csa6xwL6STRQC1jHuuQjhnmPtWFMROXK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=SAsjYiXS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068a7c9286so32786875ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823600; x=1726428400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAAFNjlraLtXoBlcyevuGi2oA1bUESdHP74uZQrkAmE=;
        b=SAsjYiXSpbyakR7LqE4toSZbHfDQ3ijxhyLy4uIFvvPqyS2yswzvBxnA0JXvHC3vUM
         ++y7AFpvbpNEsj89+Xwk5/P8t+yPaIfenxsOsu1TUXjWLYOLmh+N2ZjEbwLRSeQClkbr
         ozEWKUE2z0PtYCi4wh5FP/lIWf65vszHJeiY8a80bvXgQLX8nZdRnakdDiFyF/JVAwMT
         JLFxOZc1QKxa0Kzp/CRsvrdsTcrX6oYqCMGxB7VITVC8i9v9gRUXjmPCNLvCapQeyTfr
         4lsGULFAXxk4Ijr8hjtM6TYafL/MobqZFbBdW7FztzR7g3uObFlD29Fk6pNr+y4eBaKo
         iL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823600; x=1726428400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAAFNjlraLtXoBlcyevuGi2oA1bUESdHP74uZQrkAmE=;
        b=czf0edgO2BnmXptiqz8xaY6zRecsw+I4X6PySozSl8z85XWutUdnrC67d/Jfhtb1b5
         ZosDu0ubpPY+O04FanBgYwUxiM+NsxLF5Y6kady3fslFjT8s2cuzSpecP7PNGaTbuXW4
         3Nhu8NIQ6X9kRtdnyW+7bhI+fKKkH3D2Cbd5v+Ec43nJ/1RA0Aslrx0mZnnQLfdt7dpy
         ERQb4GLxX1wRlDdmwT3BJe9Nx4VJZFjI7bTbsiEUtsXmmTFItJvZp2NSReOX0pBWgcqP
         LPFNkHyhACUq2Ms9UWWg7OEyy78lniB2uOjt8mYSqEjxfnGbOH4Se2gkrNX08AfM968y
         wmGA==
X-Forwarded-Encrypted: i=1; AJvYcCXYgF1AVjKSn/qpcKVy04XUEBndT1GnJ86iUPEdvK8QzyOjk8CAgIXZrZCN0ZJGccc/l24suq+OxRGIQ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUjXTU/c3IMK0PM2TlPRdEwfRNNPGcIThkQldvokAeg5MjJnl
	X83OlKk+XVo32mceOtHq97lKEBcybinp/NUjI4obBZjl5I0qA9iw6AKRBpI4BuI=
X-Google-Smtp-Source: AGHT+IHN/69yw/KFeXchSAAkjGr/WSIwkimD6G+sYs+qcUtKVBw5d1hD3Uo0qO9V73Yx/2Jyk+ARrQ==
X-Received: by 2002:a17:902:dacc:b0:205:76b1:175f with SMTP id d9443c01a7336-206f04e9593mr115995855ad.21.1725823599808;
        Sun, 08 Sep 2024 12:26:39 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/16] Staging: rtl8192e: Rename variable pFrame
Date: Sun,  8 Sep 2024 12:26:21 -0700
Message-Id: <20240908192633.94144-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pFrame to frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 188e1fd9554d..9c9c0bc0cfde 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -622,10 +622,10 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
-u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
+u8 ht_c_check(struct rtllib_device *ieee, u8 *frame)
 {
 	if (ieee->ht_info->current_ht_support) {
-		if ((is_qos_data_frame(pFrame) && frame_order(pFrame)) == 1) {
+		if ((is_qos_data_frame(frame) && frame_order(frame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9f812cedd1b3..95e1c81bf132 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1740,7 +1740,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
-u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
+u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
-- 
2.30.2


