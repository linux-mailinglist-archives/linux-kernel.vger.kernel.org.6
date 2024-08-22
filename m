Return-Path: <linux-kernel+bounces-296331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF695A953
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E221F22EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864F79FD;
	Thu, 22 Aug 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T47OLQnj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFE125B9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288703; cv=none; b=USv6noughsdDCzXfauk0m7pxPu89DJB30QS9K1HvDElP/2FCMRYZQ/sC1Kqt26xosdBbMY3jFUd42JqyJyC7/nnMsb1sBVJ61SF5PnXTQqIQ4VUi8J6dN4lD8Hg/lMrEfx92Xn8l/0qeMNtL3pPH5Oa34mBB36IxYj3VtunMms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288703; c=relaxed/simple;
	bh=KaQHJ1axYkzKzgkXEiOc4F41R+cWOtM/HmwckotLqLI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=e9PAu6WasSM8B3ZUxFokhc1TQm86XEC+BEjvEkjzGfbpwvY24kursE93pzDDmzCVxtgHIPp/rvFKU19aI9MR1B0CgKJvgawJU+831gnY64NqW9cM8ObJciTGt1OKYC9v+QiJj53+iFqhk4xii0a9qBUitQMTXXqzRMTjVATq6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T47OLQnj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20203988f37so2465705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724288701; x=1724893501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TZqZXS0paZX3JkgPfszEWkiQ2lwUxBfsVyeTkU7eUg=;
        b=T47OLQnjO86fFGKvO/J9IuZrNGp0uoAuPHaHGFz7NSa6jO19UKID9/xxJoeYcDod3s
         n9XUNStNutKxeNXkJY2Ram2eoAK4yT5g0b3/vnXwfEb+R3bzilceHTz5k/wD7Yv56Gjr
         FJqsPkdF9jFPEa7WP954SuB5+n2bE1cQgGzdhHtedlugnZB69Zat+rzMpKJgCkY3AL9v
         +9Zq96HeczIgMO2AiCwXqV97s4mZ8jAs3cpvicBPhjzWvwqLc+6vN2sf7qlgqB4EpOxd
         NWLiXzGmAvn97BRycc7KURDb6p/Cl/NRmhAFsvglF9gP5aR1Io12yQmCX4SvJ3ljFqXX
         dfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724288701; x=1724893501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TZqZXS0paZX3JkgPfszEWkiQ2lwUxBfsVyeTkU7eUg=;
        b=FTJcSJOKFcCH+bK6hArACygr+cgXWLQEa6eukIy8yzXALK/rDaTJt6GRN3MRJme0Ah
         vnvSUn4Nj1mSVLr+uT6Nj1AcAfD4IplDdpnZECZON/0+wKoAc7UFDKt/GQLvwEzv0xWE
         Z34DCae5Y8H0XZLLaiTOXequnwhZ1TVgGR8MyKbxVLNxPyBscZixdzlwqah8lQG9X4hw
         iTdm5B/ac1PUAU7MzJJ4N+Zs4LWjgXRHUIqp37sKwrU8jzkAUxQE75Mgxo0g72PVHBZ0
         HjW3+1qLuEQ5MoBiNGXp9MMfdeDUpfbF8vyTzYxT0Xs6CdGNCjTPGKEGS1WkhDvL9kIF
         Cp3w==
X-Forwarded-Encrypted: i=1; AJvYcCVKKHlVvtvoRuYTAWxohPHevAO5c/Sjk82S8p695O2oBt7Dri+a1pvuGBPBifRPY7TIB3TcSmsMDP8mEw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxudt0U34s1E5oBaSN5e7VfY0E9DrxYtEsjyXqXVczR3FXLge4Z
	VPxG8wr97dfp0CjfyIIhQn/o+APpVk5f8HY/YPlkIeCMdK+VCZBN
X-Google-Smtp-Source: AGHT+IF98dKtfZStTTkleRcDBumduS4nsxLDmifdKnaeGzSY9zelxFTPLxwgsMdDx1kMJgrsE3u6yg==
X-Received: by 2002:a17:902:e5cd:b0:202:3430:654e with SMTP id d9443c01a7336-203681d1c1cmr45611375ad.42.1724288701017;
        Wed, 21 Aug 2024 18:05:01 -0700 (PDT)
Received: from localhost.localdomain ([2804:868:d047:6251:8658:8c6b:1c3d:fb16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbd96sm1948725ad.175.2024.08.21.18.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 18:05:00 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix blank line
Date: Wed, 21 Aug 2024 22:04:56 -0300
Message-Id: <20240822010456.20186-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed blank line in r8192E_dev.c in order to silence the
following checkpatch warning.

CHECK: Please don't use multiple blank lines

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..8d2c388432c0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1859,7 +1859,6 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 		rx_chk_cnt = 0;
 	}
 
-
 	slot_index = (priv->silent_reset_rx_slot_index++) % SilentResetRxSoltNum;
 
 	if (priv->rx_ctr == RegRxCounter) {
-- 
2.34.1


