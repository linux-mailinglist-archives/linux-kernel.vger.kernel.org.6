Return-Path: <linux-kernel+bounces-213982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C871907D49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3652E285EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4D13B586;
	Thu, 13 Jun 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECsBG4vv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414513A275
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309789; cv=none; b=NQ/cV6LPSbj5PxpPv9OZE9u4UsbTGi/Rb0lYf4if3lmP7cptBbNTC2MQwMeZIfphjUdeHvDGBgnOrqp3HGscAI9qNcnuLnmFLZBONb5kBFDCyzSKn7/+kFzDzjP1ptK82nK+fDF465/V5Z7Hy/7yEzEU0tQC0Mzi9GqkQ4X0RY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309789; c=relaxed/simple;
	bh=viq19hhLwhgCawmtWkzUKxe8/CYDTKmX+TRGv9BSlT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8KVK91j7SSLv0rx2UCDqy2LO+wNh72MbtnICsTY2SvYrpYDr5+I4T90JeULkzjKEnI7hKBtVS3TZNJDeGIPvHY1EP6FlR2uisNYQvvnI5l5h5HxE8aE4lqtSiDjLPpSQH9YdI+yXOe/b6/g8WQmoedBJGPJuygNBMA6AQiF4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECsBG4vv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-422df2a81f2so10196145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309786; x=1718914586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4BpMyOlWJiT/+4vsN8G1skGb7QkBQSrOKk0zqDdotM=;
        b=ECsBG4vvGTAiTy6eHqONShvUb0bMwDpcZ8AIZ/RYdYNWxPbhCZGtuC0EX067w7y8g8
         0JTOdXqCEgGqS9j/ylBy9i3BP40jAyGNCqUPPM/GFj+J0uN/vwSV/J/qecnsnM+klba/
         CFeqvdsUHExprEDNJ4UpRZDW9Bm7KONVmbWyRdcwmljgV0Upmi9elsohrj2jVv7MjjZ6
         5mANcpg7E4MJ6+w85dXZL7gzTIo/EzSexpqdcYrncy/QyuHNZaPEWJxyFpdWL2hHpkve
         8W4I85EySb8HL0pMK+Mjy29O5pm8XGiW7jiPIyIbQl6byBFL91YrG7d6rtHRkHpDSSG3
         gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309786; x=1718914586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4BpMyOlWJiT/+4vsN8G1skGb7QkBQSrOKk0zqDdotM=;
        b=iByzy+pIuzZjeiNIDtVSML/79QCtF0L665nIMRi0cWtGwvVn4TZ6ikMo0WqZXhpGPg
         1R70ZvnN1CrGewXyFfY37tmKYCKgWuqNT7dQunm9NX7bPKGoTUot40PzEz4TxR1CtVnJ
         TKfmf7BI2WgaQMxf4lZrwEu79SMyNW5hsiaGCMv14VG4LgBu7WOMZeV+G6804z1Tzm9k
         xT5I1V/ld0HsJka/0zUBgOHwLj88Zujn1Etb2UO4mzimvPzXaLUnnKdQ0TE38mSZKkbd
         B/xmWu1sMvftbnH+e94SgOuuOYo4C/edv0S3JcFyp4gPKu607lpu0StyPZmdASiHJVR6
         KWSg==
X-Forwarded-Encrypted: i=1; AJvYcCUeV+FgadRV70j8f8Hm5m/t51iorfyYaAieaA03Up8LLCTSTyCU8izs+BaajLg6RArDPX43IE4JxRkJsitZPI6no5loyyYWAMFCnJaI
X-Gm-Message-State: AOJu0YzEY4tpdf6vZ0VC3PmQBBsOda8+UKMJQwzoZG0GoDLi3kuqpIjv
	7OINIPOuy4qv+wf15nytkb9CQQd2PkZ1R4f4MRIgKLS1AFIxg8r3
X-Google-Smtp-Source: AGHT+IEfZkHaUm8w5/W/JDiY44eGJXmWO4V+N6Yz80XCAZ8giPgNP5uPGmxrNceLtJs0hPoiG3YBJQ==
X-Received: by 2002:a05:600c:4f84:b0:422:683b:df34 with SMTP id 5b1f17b1804b1-4230484eed9mr6907895e9.28.1718309785690;
        Thu, 13 Jun 2024 13:16:25 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:24 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 2/5] staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
Date: Thu, 13 Jun 2024 21:15:08 +0100
Message-Id: <ef5ffc1063323f6c1f22ab75f3b5ff01982c3061.1718309120.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
References: <cover.1718309120.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused struct declaration.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 486397d7db84..d87bace0a19b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -136,13 +136,6 @@ struct tx_fwinfo_8190pci {
 	u32			PacketID:13;
 };
 
-struct phy_ofdm_rx_status_rxsc_sgien_exintfflag {
-	u8			reserved:4;
-	u8			rxsc:2;
-	u8			sgi_en:1;
-	u8			ex_intf_flag:1;
-};
-
 struct phy_sts_ofdm_819xpci {
 	u8	trsw_gain_X[4];
 	u8	pwdb_all;
-- 
2.39.2


