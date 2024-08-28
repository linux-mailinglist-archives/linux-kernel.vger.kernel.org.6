Return-Path: <linux-kernel+bounces-305801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5119634A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BB928660B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14321AD9EC;
	Wed, 28 Aug 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI1QaHbr"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D91AB51F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883875; cv=none; b=VONKppUXUtz4XIIoawVSS/9y78nT0DbUn3rQAjXIoFGtOgOlNoL5wnq6MwfkIYF5c+w3GAtAV6Oz7/Mrh8I+jNiE5posNnrac4bB5Yatgqmgh+xoy+6jKm6E30UN517kqOgImxpFp84YB1s25qS9tLaF7YPEELojppovOdrv6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883875; c=relaxed/simple;
	bh=L09wa7vlLRmNr0dmhartiU21dRPbQfFr2TinzdN0/bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoFUcSTPmQo8vjvHA2NGXiY2w5ZBtAFyOaQflW2RYlIFdKu0O3v3gOVHQswlDhl7ovpHcEw8SAfUfl3WsoFNhsTtL2GsO/wJV4WAAXeA34Fm4vLg074bCy74D+qTSY6dsDvM5qAc5tfuL+Ux4ex1t4BwgBzoTSmbwhb9veBGsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI1QaHbr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3dc25b1b5so4862356a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724883873; x=1725488673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZXmCOMGdmd33F1p60pK7xSyspX5TYCEhDc9OsTh3BE=;
        b=iI1QaHbrdIY7pcZ3eaWfjZqZi/wYhWe2UbDc7rf+pqpMKz2uLOSW5/OLMpnFpa0ead
         LN9Zbl0D/huhG2yI0xz2XM/R5CWal16cM7lCf5jZgaTJw8NFYma3FISkj7ufY6OEqfye
         bgzgeHyjMLnxuNIQZuQdcAIgtUKebc8ki7jTvBfhkxSBZCLCfUSpm0n/8x8xEn9f/MRx
         l3pB44uu/EGe+w5oP91YedMeprgZHrPgyKmVBEP19xU26qhlHa5RaDOmxHKR9N7e/9gU
         CqdnsgKFoJdoAwI93OFSZ0bUXEcsr7Em78XkcqVfhv7h8Lh6lsx4YR3/Gj5MBzBITKPC
         Pyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883873; x=1725488673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZXmCOMGdmd33F1p60pK7xSyspX5TYCEhDc9OsTh3BE=;
        b=DHewGWwQyczcNHo7UwBEd+sw/UakJGaweswtYcN1YlmPpEKRmYxbmSvj6pGAzzjW3D
         q9/Vqhni+y6mKU9cPJmPi6tdFd0Fi5IdqFZgRqAaV/DB3pNiCcmBmNWIa+KlO0sJt0Tc
         EQACxpX1wIVj3GQly6p2duVraT1U/piQkrnVg1uZFAeB1PDHDH7asNoE99k3geN009/E
         MuswrB1twrnIjGQRFTpF3F4ibjaZLMnN7b8L2R0JdMUgi1KDuPXL35xSHQH3it0X+iVr
         hKJPPhGftPchp15xD6w3Zt6uVnipYKO+x5n/+6jjPpoW19wsYLrWO1aCHcyoXSclTMss
         xagw==
X-Forwarded-Encrypted: i=1; AJvYcCXNweBk3YnPRtxRKF8kbZ7iJA7NOgeZKuhncwJzw+I5XwoQDdf+3nkwFK2ntUpk9sNLwvJmNbDBGNElGTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw114hQAY5PZ3Pk9vtX77puNLfcXw9i/Y837uD/jlpqbR7YHAN7
	b/eHBnKAYFqxtnoGer2q2mMhHtDcqYT+RzLmwKGkC/wmW9yovMVe
X-Google-Smtp-Source: AGHT+IE4BGdNTK7tQc+a59H/LzKSQpWC7djTz5uWod+WYy47V5xBwEewxNT+SiJ17O5Fa1cICIl3cA==
X-Received: by 2002:a17:90b:4ac9:b0:2ca:f39c:8d76 with SMTP id 98e67ed59e1d1-2d856503a5emr829272a91.39.1724883872849;
        Wed, 28 Aug 2024 15:24:32 -0700 (PDT)
Received: from masingh-thinkpad.. ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3897sm2460744a91.49.2024.08.28.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:24:32 -0700 (PDT)
From: Manisha Singh <masingh.linux@gmail.com>
To: florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: philipp.g.hortmann@gmail.com,
	Manisha Singh <masingh.linux@gmail.com>
Subject: [PATCH v3 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
Date: Thu, 29 Aug 2024 03:51:53 +0530
Message-ID: <20240828222153.68062-2-masingh.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the _init_intf_hdl() function to avoid multiple
assignments in a single statement. This change improves code readability
and adheres to kernel coding style guidelines.

Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
---
Changes since v2:
	- commit message updated.
	- assignment done before goto fail.

Changes since v1:
	Broke the patch into 2 different fixes.

 drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 6789a4c98564..378da0aa7f55 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -48,8 +48,8 @@ static uint _init_intf_hdl(struct _adapter *padapter,
 	set_intf_funs = &(r8712_usb_set_intf_funs);
 	set_intf_ops = &r8712_usb_set_intf_ops;
 	init_intf_priv = &r8712_usb_init_intf_priv;
-	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
-						    GFP_ATOMIC);
+	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
+	pintf_hdl->pintfpriv = pintf_priv;
 	if (!pintf_priv)
 		goto _init_intf_hdl_fail;
 	pintf_hdl->adapter = (u8 *)padapter;
-- 
2.43.0


