Return-Path: <linux-kernel+bounces-296291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E195A8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25B51F22628
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97477494;
	Thu, 22 Aug 2024 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er3c9JTn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD0125A9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286251; cv=none; b=nUZAvrCjo2Ft12fqbjoGoo95UnmPUJHjgV3sE2hOR87y3s/NwKEbjqZFzrF6zNJrY0EBJqdSRe3c2+mUdwbtLI9P3lJEZe8DpBVnOFOV6uQjT20f+8za62YJrUQHOz4Q3Jq9NK7w4Hq8o2b/m/kMkD9SpWGOmTcb1wvXk22cjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286251; c=relaxed/simple;
	bh=vm4AnZJlmNPDgFyh40AzDC0fxYGicrts8thHOMpNl90=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=V1pK3hE0tpntikyoo8CqkGjx6GM8jnPzNWVV4e7l5nLMZNAiMQ9YLub5/EkYDx8L/Vd4AnljkDK6tKLHbFl/zc/7Af0CoLFzj6ThcKBruHZtzNoaaKI5T9xgLmrXVw/wUIw1lzYZ6yLHgnm7qigujOiiY5jfzmGbxBo+cWPrbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er3c9JTn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so216060b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286249; x=1724891049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zO4Xc1tbpPD+VdbX4jQeqPTy7zhlzFf2fjtWR9GiAT8=;
        b=er3c9JTnqFYQJlftBHSCRBABoTi54vVbVGKZE9EpV7hHICgL72jr4KauyF2lKi9N6q
         jdaToToWCG3Ev5IwbLYrET3a9TNYZRCIiJ6Sria988JR5hSrN8jrCLlYtBn1guRoA4hV
         LKLTw2dDCdQCH/dDrsSSL5comnQ75ny3IWAwKP+Hpb6LSmAdtJMaDxjBloGHIzXglQ+t
         xdQrI0hUht0NfQ6LYFse//+ugmIip/6bYE6ZmL1xLqIJ+YEYbtrxZNSPh5PCfkPj3VtW
         xA3tgszODoRdQAwiRIPhc937iWiLKUZr3VZQ67+59cHfli5tze0cObX9j9MaiijzngLJ
         YAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286249; x=1724891049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zO4Xc1tbpPD+VdbX4jQeqPTy7zhlzFf2fjtWR9GiAT8=;
        b=VpkhN4QdYmjgsY7dh3uH2Y3ue+S2mNq7RlgKYh/SQXIeWcMtFqLF0w59KsKIXkJEDJ
         jBgsKNMnNvdJ5WQWHZw9C3Wlcfpi1srBg/3VJ130V/Ombw6eIoAoRDY213x0kkfdfdPl
         YE/DSrDm9GyqImXF1AOeMEwy1TeyBJxSlmo1j1muAMr4ekgbeX0ckFy5zDtVBsZL/4h1
         5Y9+MAoSzth95IFAbNThcBfubvrgiJeOb+BFefZdgGyYt5j91CP1MRSE4JaGxNqTNIG0
         vSPFMhKNezsybTmgst03h8dnS3kbIbLcyRTqWTlf5etL2wq5qqFeo9e+nm5u6PH5SqpW
         atcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO07ymHyGZMrz/yQo8M6cTKgtfOdhufCo5rpBpJf1U42uebw8yRPy3rc5hiwLSB0Kn4pYgJ2yRj7C0x5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3ePb85G1Lrsu5OL/YNspiM5Jn4MNq16W6nDSUEWBwO/v9okp
	oX4Y8mT9fHD2K+Gpip4FqZjBuO5rAw2OSJLGTXPanBRNTrfhurtm
X-Google-Smtp-Source: AGHT+IEeRkHn4GXy9LH3kNxRqBPsAYUdX2kRNWhzY5AjSuNKPF/SMIesumvD0NUFFvsfIHIVYvPFNQ==
X-Received: by 2002:aa7:88c3:0:b0:70d:2c8d:bed0 with SMTP id d2e1a72fcca58-71423557c7amr5184589b3a.24.1724286248748;
        Wed, 21 Aug 2024 17:24:08 -0700 (PDT)
Received: from Thiago-Linux.unicamp.br ([2801:8a:c811:1:6eea:428d:6c73:1edc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434252726sm235892b3a.66.2024.08.21.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:24:08 -0700 (PDT)
From: thdecamargoj <thdecamargoj@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: change logical continuation to previous line on file r8192E_dev.c
Date: Wed, 21 Aug 2024 21:24:03 -0300
Message-Id: <20240822002403.268452-1-thdecamargoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change logical continuation to previous line to silence checkpatch
warning:

CHECK: Logical continuations should be on the previous line

Signed-off-by: thdecamargoj <thdecamargoj@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..05324682ab5b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1837,8 +1837,8 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	rx_chk_cnt++;
 	if (priv->undecorated_smoothed_pwdb >= (RATE_ADAPTIVE_TH_HIGH + 5)) {
 		rx_chk_cnt = 0;
-	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5))
-	  && (((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
+	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5)) &&
+	  (((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_40M))
 	  || ((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_20M)))) {
-- 
2.34.1


