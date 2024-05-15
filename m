Return-Path: <linux-kernel+bounces-179420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF68C5FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819C31F23DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8C5914D;
	Wed, 15 May 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="aerk6ort"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025564E1C3
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748767; cv=none; b=jMxB9iNJuX0NbtC5V+SrJI6Ij1XKyWkWleUNg2CMeqGjwwtUOJBzrsy5I1clQc0CfuXk32qbPlXh8v2BrxFXDFukHAeJPWSBrjuWkps9jPI11T9BW3a2PalajmVbhOH9Cil82ykwoCXCXlgCItqrTaLJxIp891zIwbmcHbjD4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748767; c=relaxed/simple;
	bh=W7YanCirN9wvp2zde5wv/2tgJrgt1xFhjhHajSKuSHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJpsi7hKt+lhuwYrRcIBig43mZQX4hp7ei8k4ESZEb4gRuDIhCUZ24yRaoatJyuEmjBI01dIs5aYEUGb5DxLUDzXJed3mlmAiOvOVfffigEnIBr0ipdDGgRT1rbMVX26sDJ7LvNQSNUM5QK4t3RxwcY3z2rZ08UFtg5sze+U/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=aerk6ort; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9a1d294cfso2205430b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748765; x=1716353565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5uBXo5orQcdm4k609Ve5/BzbHzbX6bMArVHYg6Cjbw=;
        b=aerk6ortgfArtSL985FnFwfLRjUF3SVVPM+Q8BybF5HqnG0D9unCJ4XOBDQ1dUkUpW
         IZEQmMt3I106oSq2RIF8y3l+yBhpDBcgfmJOJ0QJxxYLMVLra9q3odEm8x/bcRAZjxUA
         GiOuNagtBbR9vIU2RhMCLeDdUDowZfKXm2bAVU5UGDdHDTggjulsA3wSJgeigcIwQpn+
         Ywmyyav5X1N7SpfRvbPetUqyW27LtisIzOq3ndtcv/F0cNZjKZ11g7Et3inMNI3wahhv
         StONpbWMQII/4vjZ0P38YKXCYvld8C8nMT5M7gI79PkYA5ImkiJu5JL36Y7fjTfPQCHp
         EIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748765; x=1716353565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5uBXo5orQcdm4k609Ve5/BzbHzbX6bMArVHYg6Cjbw=;
        b=DsvWpOzvvC/sodBuSuTk6Kj5oZux7Kt955EId2TncTwOS6nGRPKpXDeu/kY0F0YcRe
         lwKXbmL4DTGGp1UdL0xNj9xhsTWmndO8hvigcOU446jC6KFyCKErJ3NuXB9TBLLClDSv
         XtKcFubzif/dkaOZN15BBvweWfiXjkkfy6h9ZbbC8XOyZIUJQlqvhv7jrm12kTMAjIpe
         Fvnu/BVL2TxZyE6xq+p8tZ5TUO+hnrQ7TQ5gvCR8VNWRad8E9lCIlrln7T7IJIBPK8iw
         Tp7hPSCsuY0oHONG63//sKtaWG+K/OuJ+htKDGEYU1b3/UsaZRHlXMZ5kFzd0jd67klT
         pcLA==
X-Forwarded-Encrypted: i=1; AJvYcCW0IZN0JXh2fpiaqMqewwpAYNCnGnb95sV7K68lAnURdUNqL8hNeG2dcdUVz55xXVgcUFHkOdK9blHdh/Oipbjzeq2ioG4D7T4MSOEU
X-Gm-Message-State: AOJu0YwlrBricTCmdm6Tk+NXyZjocfuAa7b4aE3c5K3BPmUpkMtgPjIO
	iEBREAy8gH2Ii62AyJE9rHFeiCJaesRGMx1JB/XICTy4GX1ycdfWazU7a1suYRJ3lrnNloonQo3
	w
X-Google-Smtp-Source: AGHT+IGd8pJGmwnbAEWl4DdU9jN9a9BZE7BDE2KjzGYE95GascgoKwP00mKOm6PzR9TUCs2ysEYhsQ==
X-Received: by 2002:a05:6808:144e:b0:3c9:63d1:6fce with SMTP id 5614622812f47-3c9970ba8camr21808933b6e.40.1715748765203;
        Tue, 14 May 2024 21:52:45 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/31] Staging: rtl8192e: Rename variable AddReorderEntry
Date: Tue, 14 May 2024 21:52:12 -0700
Message-Id: <20240515045228.35928-16-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable AddReorderEntry to add_reorder_entry
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3afce436a5d8..30bd6f49e915 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -403,7 +403,7 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 	return 1;
 }
 
-static bool AddReorderEntry(struct rx_ts_record *ts,
+static bool add_reorder_entry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
 	struct list_head *pList = &ts->rx_pending_pkt_list;
@@ -610,7 +610,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			pReorderEntry->SeqNum = SeqNum;
 			pReorderEntry->prxb = prxb;
 
-			if (!AddReorderEntry(ts, pReorderEntry)) {
+			if (!add_reorder_entry(ts, pReorderEntry)) {
 				int i;
 
 				netdev_dbg(ieee->dev,
-- 
2.30.2


