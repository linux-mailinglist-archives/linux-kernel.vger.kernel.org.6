Return-Path: <linux-kernel+bounces-331296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE997AB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDBD28BEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01621157488;
	Tue, 17 Sep 2024 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="G9r0hedY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725514F9DD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551124; cv=none; b=qHABjxBSWsZtrWyeMiGfOeOSUd9OWkq+32xgRlSWw0wpTLCZlq3SEkk7ebA6d652ze7qNU6fXboG/43wBMCWjDucCQqhWmE097afN2YAtUsnOO+r4bmvGdgIsW0ues6Gsmp6VwdJG4QpiDKnzvTYJx2yirDdZCUojjysBf+8WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551124; c=relaxed/simple;
	bh=Gpn2H8LHNdXdTOmFy7tNJ6iSxJpv8TCjLYoJz1IYxB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyicKLvGHXPgq/s4R73+Xhf20+JYQ2dfpg+I8UHH+xEPXWA09ZjZ71a19ZbLhgopM+ttnvBClsZZ/arZACKXSwrh7Vcv7dqnpXxWGzHVlgNb0dShtxWxUv2RYF3HTkO+HrdmdyY4TtRAwuINlighEtxaj6uB7ntT0Rhb8dTW3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=G9r0hedY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71798a15ce5so4242151b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551122; x=1727155922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/aNmWGHy2dB2dhTqpwQodFKxIg7+IWGmSsCtZxhNag=;
        b=G9r0hedYSbH6uOMRP86fFXzZS5Gy8EEd9Ys/AsDGjeKNV99WjwqX8lXUSAeGXVDyBi
         RNQQSec2ff47JZpGPtraz9RyLHvvN00yP1yXM7zLr0Xh+eymFXBTHj6o/+mUwjXUtDNh
         AG8UT5t7ItOZmal6I2/8G0aig4HYlr9daiqz1IPlwEv5QO+34BT8Wx8sqwbvA1JfTkek
         SuTqA9gYJF26pFrNByT9DyWFt/KodI4UhdvYPACppeJUsEbHx83kiMHuB2HQ6CBScDSk
         lp+YOLQgUEXuAbCKzA3ogsv4+OOwZjHkCbqT74zRsyP3CCO+DHLY2o90Hix6x0uyHn2M
         Iz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551122; x=1727155922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/aNmWGHy2dB2dhTqpwQodFKxIg7+IWGmSsCtZxhNag=;
        b=va1kL7oZ8bfPoB9xuMSVDh77z3JnCPh5PcBYBtDxKeSulWr1ANfM+Lg7rdaE8Qjaae
         7BtXrHgvkYJR2VHT5hqrNgAVi8hye8WwNhXnx8WfbY++CrKhJO8jN/k+GhTFWr8lJERF
         V61NpYPTn5TD6Cembn3P1koqer0w8aAkxZT2UA89HU7zpikqr7BzEDUd0NKO3C9DgVCl
         LP/YKHRKX1UNfvv6Ss9uCWOQRKY3W0AqGdajKqT5jd34MxVfejBqen3eZUrwtA/Hd/0K
         OeewpI8p5LRM1f9FtffM37M/W5JeKINHkEpskCUs58HUofd1mkIi1PrlDUhyRpARDBnl
         uORQ==
X-Forwarded-Encrypted: i=1; AJvYcCURFIN0Q3fAYOEQHtB37ZjGdlnhXnenZfA4Ih6zfgrDZ2i/wBSc9T+b+6SNnJw6A7bQw6SPQ0OTSm0Eqcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xD3grytIO95bW2EWTBdmIULt48hbfcWjl5IUkxaGoBJhpnq+
	wZwjcpJKxkcSzhDXlK4/247fLBdUfK1WRBuGrKqeUspoRxvEuUjP044qWpWySZM=
X-Google-Smtp-Source: AGHT+IHG4o+lsuxq37psiM1fmskoMo4VtXlyrhsBp2Q1ne+m8rOJmTs7umneHzv9t9X+7R9ETx6FXg==
X-Received: by 2002:a05:6a00:b011:b0:717:83bc:6df3 with SMTP id d2e1a72fcca58-71907f55c44mr34251595b3a.11.1726551122001;
        Mon, 16 Sep 2024 22:32:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:01 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/18] Staging: rtl8192e: Rename variable bFirstMPDU
Date: Mon, 16 Sep 2024 22:31:43 -0700
Message-Id: <20240917053152.575553-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bFirstMPDU to first_mpdu
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 003343e75f0c..87a370a4b2db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1651,7 +1651,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	_rtl92e_update_received_rate_histogram_stats(dev, stats);
 
 	stats->bIsAMPDU = (pDrvInfo->PartAggr == 1);
-	stats->bFirstMPDU = (pDrvInfo->PartAggr == 1) &&
+	stats->first_mpdu = (pDrvInfo->PartAggr == 1) &&
 			    (pDrvInfo->FirstAGGR == 1);
 
 	stats->time_stamp_low = pDrvInfo->TSFL;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 32dcccd58b9a..64be0415fe0e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1483,7 +1483,7 @@ void rtl92e_copy_mpdu_stats(struct rtllib_rx_stats *psrc_stats,
 			    struct rtllib_rx_stats *ptarget_stats)
 {
 	ptarget_stats->bIsAMPDU = psrc_stats->bIsAMPDU;
-	ptarget_stats->bFirstMPDU = psrc_stats->bFirstMPDU;
+	ptarget_stats->first_mpdu = psrc_stats->first_mpdu;
 }
 
 static void _rtl92e_rx_normal(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5db03fe9269d..ca8f39f8e9ea 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -477,7 +477,7 @@ struct rtllib_rx_stats {
 	u8    rx_drv_info_size;
 	u8    rx_buf_shift;
 	bool  bIsAMPDU;
-	bool  bFirstMPDU;
+	bool  first_mpdu;
 	bool  contain_htc;
 	u32   RxPWDBAll;
 	u8    RxMIMOSignalStrength[2];
-- 
2.30.2


