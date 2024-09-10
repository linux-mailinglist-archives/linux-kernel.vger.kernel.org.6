Return-Path: <linux-kernel+bounces-322363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1B9727CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04562B231D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B81552FF;
	Tue, 10 Sep 2024 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nctESva3"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572828E37
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941112; cv=none; b=CiUTdCvKcJwIPcrEdMp++YsYRav5fOdeXPo7fGa2PiAKTUL4V10eLE+wnaJFbV6xNjJHWbAjlv/k+p8UKejU1wQ2I3mhMo8Va0F+oeotcWe2+VPce5x+2ZpJWNPoJIJWatmXHvTv/4gnOvw164JOEZghbTOQTIDdu6HcmZoH3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941112; c=relaxed/simple;
	bh=ZGtWmC6isHMopRoqC9d8yE1P6elCllzkgS1uslrz6Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fs91reVgFJ7EYMo0rH68mW7oknE8wm7gAXErJlC4scHUzFjjtPFbATFeK9HfOyufNzCn1h62pZ7aWAN7IQh5QfC5K9bU/ZgFZI/c4GMyusrWKJtvyn7YeAL49PE7oizbkhdEI9zR5plRLlO8cjpKtj0wpidi0/XshKAfcQ4O350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nctESva3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71790698b22so951083b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941109; x=1726545909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSF+JNJPT0XCzK0Is0o/8qewAVtX7tARlqlY9lwV7uc=;
        b=nctESva3GDWGX2X/429Xo8lHSpuye7PmbIFtA4njjt7LyQckRXmrrM6KMmJkEJaQgw
         q/G7de1R+EVjs0ZDgjAy4pl5K8IXrGnyC9pyzTqsqXnmh9BAkVp68OZQDYvKVqVw0Hr5
         UDQFuj9v7vCnPVfnnWif6uedk6+8yY5a9d/NdzYBfJZd+fmYC5kpeZXrB1QRt5OziG4O
         PDgt6CtlRJuucN86PJAEgCwa6BNWhtlOD9O1s5wpsXpl7jyasf3QGLK8Dt7ydyMU5U+e
         JFaPr11jCjiXZqfZL+9CPH1GTNeTTVemGuouYFd1hHs9Q2hJFCIFp6BMWGL4U/jgniRE
         Vnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941109; x=1726545909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSF+JNJPT0XCzK0Is0o/8qewAVtX7tARlqlY9lwV7uc=;
        b=qDKDfYDPY98/5I+n6244/kmC/7UVmhEuc+CAjXvqwWVnuWbcWl+JObnLg//n2w8WEX
         nBwDyq0Y/YpJbpLfFW1F2OGE/tNvBQHPRx4m9idRWYL0LhFipjZp/HWB4opgCd2Z0lkP
         e6ou/GC8HnI8dXo8K72r2xtHxnO2G7Cnv9LupSUZxo2wg98/9hsE0B2mZeG6d4diMftz
         GMAyyzBqw95kAzzcPdkAoRRzpWlvNQ1ul2VLAgmT5/LCTOyb+l6DR/kVpDxTYIP2kBoM
         1Ad8BDMGsELELQS52mu85ZI3mYMBTtOzMI8pnZuL5FVLrP2miFT/FbqqEVNAuUtijIvN
         QDXw==
X-Forwarded-Encrypted: i=1; AJvYcCVYrUafOA3rq9IS8Rlg7zpX0nayBKQKsWExGOoG1DKKNYnXaoIE5RYE8+xB7O6FhODRIPLxEU/rxBo6Ahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsvfQS9SnezIIMSU6xoEOIQztl+Os7vCdKyi9sa8cyZdikjMP
	chq06n1rDGvjXgCRWZlDkc+luYIijxIsUHu4W0Otsx6JvyuFesP9
X-Google-Smtp-Source: AGHT+IGPsUCz9jDKrZQpfPAcaU5EzuOdjxIgcI7BKDP7vk3MEfa2dTR8ldd+pyfyJYYWP70tfksjBQ==
X-Received: by 2002:a05:6a21:3395:b0:1cf:5471:bbe1 with SMTP id adf61e73a8af0-1cf5471bdcamr564575637.8.1725941108872;
        Mon, 09 Sep 2024 21:05:08 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bccbcsm4779172a12.79.2024.09.09.21.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:05:08 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
Date: Tue, 10 Sep 2024 09:50:01 +0545
Message-Id: <8b9184ba4e489d7eec389389ae435fa4d9232113.1725933169.git.topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725933169.git.topofeverest8848@gmail.com>
References: <cover.1725933169.git.topofeverest8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3: Created patch series with cover letter as suggested in the feedback
v2: 
 - Created patch series as suggested in the feedback
 - https://lore.kernel.org/all/20240909041530.2431-1-topofeverest8848@gmail.com/
v1: https://lore.kernel.org/all/20240906141134.10118-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index e103c4a15d1a..e665479babc2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -131,7 +131,7 @@ struct mlme_priv {
 	u8 roam_rssi_diff_th; /* rssi difference threshold for active scan candidate selection */
 	u32 roam_scan_int_ms; /* scan interval for active roam */
 	u32 roam_scanr_exp_ms; /* scan result expire time in ms  for roam */
-	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to speicific target without other consideration */
+	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to specific target without other consideration */
 
 	u8 *nic_hdl;
 
-- 
2.34.1


