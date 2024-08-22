Return-Path: <linux-kernel+bounces-296323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C595A93A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EB11C22CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C836AAD;
	Thu, 22 Aug 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzJuCZtG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1E1078B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287795; cv=none; b=aRY4meoVmFi/yIY9TdhXME7Bnmyf1wkmuJNJ+ZTn3iVr+8ZBSXfjY2xOnT4s2dwS65fGA4MTLEhmmBAwhuhqImQDlpVwJOmp90dLB6P9JiYzqXoBP5UlYiXvjHikwX/Uo4xuQBB184Lgjr5RFxQRX55Sp3LWE16hAwdpgQ+Wu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287795; c=relaxed/simple;
	bh=AnIqKnh9ldoevdKJjoL24+oTb6ZiwTuOexuRPtIUMz4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W00YAeQALMlnOWIfpojP7FTPEQORK9H28pee1Bo52psNqhHATyzdccvTw4aUrSS83gWPkc2o87Ynam8hSJAojJN/HGzMeYWmY/KTvmV6TZKUbIEyuq/yi8YK/Rkzqj9pr56hbkI2+D/oDLNRr2GgYPJyg7oYuUfyu0OyUjQL83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzJuCZtG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-712603f7ba5so227688b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724287793; x=1724892593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tw5cLiO6wnytINGEVE6XWwraB+DzGxHZd6q+jRn0Qo=;
        b=EzJuCZtGM7qF1/rFAeeVt4naWcjQDBvdeSKLXnsHtQmahgrPTpcXE9iWQ1g60spLWL
         LV43F53h0XLMKB1qTFU/cwGVvDo11/W3t9mEyiW7i1YG9qGyYIUKSuswu5HJFE4rpUgk
         6KNN62W8ruqye5ytNcu+hKFn3rAi08PbRq3SyazeToJCeITD3nlkhB12/cCITAwHGCix
         xbECwmWYucazuq641ipq+TZXPHlzg5x2j4bMWDhKIwqWt+w09j1F/NduzY0axToc3OsH
         2N7JhcmkYiCEsr4OCZJKOkXL04CL1ev0HxsKlyg6ywbZ2o0UH9LmFv1NQmPpRVfmti89
         0j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287793; x=1724892593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tw5cLiO6wnytINGEVE6XWwraB+DzGxHZd6q+jRn0Qo=;
        b=cDTZGsuN+ZiK1biTOXfIftHLzRW3NvQYuD9CFk+ZQqCE9srpEYgwPwnSefU/bNB+XH
         FGvkJ3lPbqJwxaM7jjzg4dU8mEE7z74h8mGwfmu+75DQljz0VTubtnsN8dPROe5RqVHV
         ymgeltjYhQE69Hi47ktvsOuJYXHRELJ14JEDpSzzQZ6Qr7dK4QV3grBG1Q3YaftkxE62
         8GzJxZu3DGku+1QYN3NN7i2hQBWsWMmUYY81XxEKb08VLK06KZTapAeHzmjLVQRvEl2z
         If+J+hSvuJttlLMt2VLdIvDVNDrM0SjZDCzMHao2XGtNNMsumWa9q60q0F6uOaOYvqd+
         UDxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKqYlDlC2IsXgiZUz/0VXQKmwCMjiIVZt+BNd3tdIseznJvkiK2GIVmhNE3LKjh91ZnjXX4/t7Zd2RA2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pr8YwQXdrShoxRXzPSsdpHWJXSlCRDRktsmaWECZ3fG7gsaa
	NoKzSudq6Upq1S9/hO6Syw9Z9GNtiDljY+ani65EEbSStEUAwRBU
X-Google-Smtp-Source: AGHT+IECJLsEhyFo7Za/jVB5clI3+X86rnYOL6uziPIj9ErLnw1RmP2dNAX6v3lsVzauwnm0qHxvdw==
X-Received: by 2002:a05:6a21:e85:b0:1c4:9f31:ac8f with SMTP id adf61e73a8af0-1cad81447c0mr3939501637.37.1724287792739;
        Wed, 21 Aug 2024 17:49:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:baa2:9074::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af14a1sm267398a91.45.2024.08.21.17.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:49:52 -0700 (PDT)
From: Hans Buss <hansbh123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] stagging: rtl8192e: fix alignment parenthesis
Date: Wed, 21 Aug 2024 21:49:34 -0300
Message-ID: <20240822004939.153517-1-hansbh123@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Fix alignment parenthesis in _rtl92e_wx_set_encode_ext.

CHECK: Alignment should match open parenthesis

Signed-off-by: Hans Buss <hansbh123@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index c21a0560410a..fc8e7f73b2a4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -675,7 +675,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 		u8 idx = 0, alg = 0, group = 0;
 
 		if ((encoding->flags & IW_ENCODE_DISABLED) ||
-		     ext->alg == IW_ENCODE_ALG_NONE) {
+		    ext->alg == IW_ENCODE_ALG_NONE) {
 			ieee->pairwise_key_type = ieee->group_key_type
 						= KEY_TYPE_NA;
 			rtl92e_cam_reset(dev);
@@ -710,7 +710,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 			rtl92e_set_swcam(dev, idx, idx, alg, broadcast_addr, key);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->ht_info->current_ht_support)
+			    ieee->ht_info->current_ht_support)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
-- 
2.46.0


