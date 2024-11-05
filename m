Return-Path: <linux-kernel+bounces-395934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED59BC51D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE11F22795
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84282003C7;
	Tue,  5 Nov 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJP5zfzH"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DC1FE118
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786136; cv=none; b=OjXAXCah9EMQnaeu/07hiD3ck4cyA29w8udckBnuTWj09VKqex9bexIkwAfJpEAkHEN2tAmF3EgXOqk4AIMHxi78mp8aYr0MGmBGBAraFFiVrrSLpovsfz6klO5fo6MmvuNzn7MREXKczaGbzUgYercAPVfVCu5g1OsUi82DrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786136; c=relaxed/simple;
	bh=YAdt10EKqZnTSbx22QnFbqqLVkByFk/br1WnjmqVLU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G86KGURJuk6eQ5FSkWxpIEoefpfh4NZN4ha05sBOGjsJcv0opx11lTCIIPJ1rss/qCjma5Oevm2CkpIYagxqCqp5IeZCwbESztCHizFXramg2RRLwL0Q130En/zskNVU26txWkPIlDElOV40M1bBNPh1MDDyslCC97xV1T0jBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJP5zfzH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so9127743a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786132; x=1731390932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogLkc/HIhn4oQotIbLwf5N87GIAE2Iivlj7UzKe+4uQ=;
        b=DJP5zfzHBpRL6plOtH13rBmPZUIaVbWiEI8a9gmtpz1+v0kzmhCXZS8DVnVqtzUSuI
         UVp1Lu2+xKcywlZehikHPyztok5FMh/ZwtxGioGZsy4QvcHmZSd3Omo8zVTsWXmlWIgQ
         CAZljIedu62q2pI+wmy/utrRVPo8j8yv9brBaPDSiICr5haiZZxHFd7wxnFnkCYdUaID
         NGTjr5J8x0P/nH6tyE10aPgaxQxTFEB+TwPPmiKJgyMGz5av1239glFXp7ElRaBqRZDP
         EOFsjNKsPvT02rJ+j1pWeekPzPo6jHjBZGQgHcmbB+GxtgMMK2FC3ZtaIY/w+KK8qjry
         PD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786132; x=1731390932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogLkc/HIhn4oQotIbLwf5N87GIAE2Iivlj7UzKe+4uQ=;
        b=NVh3rngAudctOQjPQrUzZwsq7I9fNGUeJ+f8cWV9QTrXWOK6SimIsj+xbqsTbmkylC
         ZUQGHD6YuusWYivHDmxsYw9kTYD6ymrOUOVpXC6Duzeg7S5OZ510rQYZgbMFKqBq8QvA
         c9lvZy2LbZG+w/rlVryzekym4pTwVPamkJ8GZi/oxqMaO6VETghlxd//W6uf6lMQ5486
         MNXvEMGBHoV+vbY/j0doaHo6K8ee5mLLUXfx8xvDakc1PBKTpjDbxuOyPZhARmQXp1th
         ww4AQGhWgF37fegPQ95wRamIAl7PfPfG76MspaSSkn9nx8YHj9HOfWlRtT7ZK647XTd1
         fn6A==
X-Forwarded-Encrypted: i=1; AJvYcCXCHPzALtppPmTf0OEWwJzVFzrjlAJsLdMauk1ZGgpmCYj/SXLCDSH0t9dFG8aWfKDZrVQp+iZVJQBJaP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfvKntnQ3q98gdGRxbRbPv1vM6QDfShOHuWcnMCyhF/JhzBBi
	x9qznRczTFuqNcMvUu2d7jvE77p5fBxblyglnVEcEXAaJ6DltxpE
X-Google-Smtp-Source: AGHT+IGsG3Xwr1iFVxlgkNa0xbYHo4XUeCWlg32yEp8sbLS4Hy0fxzu0ihDwtfCDLs3SuGdY0d9LEQ==
X-Received: by 2002:a17:906:dace:b0:a9e:670f:9485 with SMTP id a640c23a62f3a-a9e670f9594mr1381412166b.30.1730786132028;
        Mon, 04 Nov 2024 21:55:32 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:31 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 08/16] staging: rtl8723bs: Remove function pointer Add_RateATid
Date: Tue,  5 Nov 2024 06:54:55 +0100
Message-ID: <c7d1c02e570b7779f059bad6f3a45177176fe9e5.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer Add_RateATid and use rtl8723b_Add_RateATid
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 483f0c163bef..46da566106ae 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -227,8 +227,7 @@ void rtw_hal_update_ra_mask(struct sta_info *psta, u8 rssi_level)
 
 void rtw_hal_add_ra_tid(struct adapter *padapter, u32 bitmap, u8 *arg, u8 rssi_level)
 {
-	if (padapter->HalFunc.Add_RateATid)
-		padapter->HalFunc.Add_RateATid(padapter, bitmap, arg, rssi_level);
+	rtl8723b_Add_RateATid(padapter, bitmap, arg, rssi_level);
 }
 
 /*Start specifical interface thread		*/
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 64eb1786d8db..66c2a8fb2454 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,8 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->Add_RateATid = &rtl8723b_Add_RateATid;
-
 	pHalFunc->run_thread = &rtl8723b_start_thread;
 	pHalFunc->cancel_thread = &rtl8723b_stop_thread;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 2df25c1e7b5d..dc5bb61294b0 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,8 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*Add_RateATid)(struct adapter *padapter, u32 bitmap, u8 *arg, u8 rssi_level);
-
 	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
-- 
2.43.0


