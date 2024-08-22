Return-Path: <linux-kernel+bounces-297647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31695BBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BF1284C69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D81CDA0B;
	Thu, 22 Aug 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeluPO4/"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05E1CCEEE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344265; cv=none; b=TifOjRTkdiPa7sixSPd3crYpctTxDUR/Ldbov9jz/97bcVk2mQ77hNWOernwx9f2w+j8tOifsqwI96BYtpQCWZsr6zxwN3Xjx1Ii/PdBDfRA2umf5FI78neCE2OeyKMaRIukalScsAjpz+mIHq16W2IbUX1WJ1EHBaBWwkC02EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344265; c=relaxed/simple;
	bh=L24VTJWehq7n35SdssG5EI5FVmJPtbNKUxwuU96OtUM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LKKq9OVCnNGxt9KLL/+joqqAE9Gy7fowCmdrYBF1twhLShg/gsKMu+n3+TMQejXJ+NOUPulbdVaHu6BPHUksv3eD09Tm7AYhbOjTQ1sUey8BzsBa+/5HOWVVz4WZu+H5TjZJfpkuNUqHz3lApNGR1EBzlReEHtfljQXtcTLKOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeluPO4/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021a99af5eso9123095ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724344263; x=1724949063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=51BB2dJoLtPN4L6oCxZATSFDdvc4kXBltpR8Z3f09pg=;
        b=jeluPO4/VoQ0gJKagvtgueRnsVVLjH9WFiQ8NNbckt4WTgYHfduKxekAYqBUL8Zwa7
         5GdXo1udUqqr6scv22Rf2CPe44BcAmjCGdEnjHMMU/gd3KsjKmkxks9v6p9Vppr49F/Z
         vVSxUlXcFI7XSwwe+iOShiyPnfsPC/lAo8yjxFKNrO5re87qQG/iSnDooG1MQXQVM/nR
         9xJF15K/y+S0RFiLMQR0ysiVgTixBngoQz284KGKHm8RneLm7F3+9AzgF/LqDhMkYBMC
         B9GPpOUNmn1GHb3UIjgPvZj8P5ia/OSjYZdBlHyJbh4Ny7ItR4nZwmAvCg0VGNCbBmX3
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344263; x=1724949063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51BB2dJoLtPN4L6oCxZATSFDdvc4kXBltpR8Z3f09pg=;
        b=g6ZjOIYs1m7AU5yzfcr6QqT4+fcVYbmzMne6IXxDK0TqW/vWzEPSsS+SM/NPYE8vE0
         A5mm7qAcx9vQjr9nJakpoSxRSj1DXx2iq29EAbCs3Oo9PV5c5YcvowkqL9UGqZbLqMhU
         Wsh9eT9xP/SDLueIIFpHVGDD7gI6xWExhBMCXwpo6UwxLOBefnCICgFUVIioJu5t/Yzu
         V4jxEZrg+VMcav0dGVAQdS86olNi9gfivRoKjlKQHtjgHIs1l8vcxepFqxJ65KwBaJ1V
         5zQlV34oxnh6ZbOIOunbfhYTEwHhm7cI8yFLRS3h1yjvncyQO/+gfBLK8ublnNVRhBQm
         GgwA==
X-Forwarded-Encrypted: i=1; AJvYcCWGYxCdjvwcFYVH+I32fDOLOlJrDk9hCaDWddDUeCTAs7OdfpW/1CdaFrnwxH/VbuGkoq8LDpJWYBK3G1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHfRwhZ2ik89Nqkb1cMmCGpa1YhlNEohVoYiaIkATKPRyqo7c
	8dYtdvCNVVDC4fZLKw578fwd/H23gY5SaMV5EeKmzBMJSAEvQxIE
X-Google-Smtp-Source: AGHT+IFfeNhr3PHpe5oNd8MbjpQIV7g7fdN+4/1M64+JppkvnVSnk184PcHB2uvtTf+ZHCt227Dg3A==
X-Received: by 2002:a17:902:e848:b0:202:cf5:1014 with SMTP id d9443c01a7336-2038820e999mr28673245ad.4.1724344263007;
        Thu, 22 Aug 2024 09:31:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:868:d047:6251:55a1:af12:b907:522])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae4f62sm14535935ad.256.2024.08.22.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:31:02 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in rtl_dm.c:1488
Date: Thu, 22 Aug 2024 13:30:57 -0300
Message-Id: <20240822163057.14114-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed enter before operator '=' in rtl_dm.c:1488 in order to silence the
following checkpatch warning.

CHECK: Assignment operator '=' should be on the previous line

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 0c7f38a4a7db..e9ca5a8768ad 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1484,8 +1484,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 					rtl92e_set_bb_reg(dev,
 							  rOFDM1_TRxPathEnable,
 							  0x1 << i, 0x1);
-					dm_rx_path_sel_table.rf_enable_rssi_th[i]
-						 = 100;
+					dm_rx_path_sel_table.rf_enable_rssi_th[i] = 100;
 					disabled_rf_cnt--;
 				}
 			}
-- 
2.34.1


