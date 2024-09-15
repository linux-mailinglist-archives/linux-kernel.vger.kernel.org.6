Return-Path: <linux-kernel+bounces-329843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941D9796A0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7A1C20E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CB1C6885;
	Sun, 15 Sep 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrYmtrtW"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85271E49B;
	Sun, 15 Sep 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726404148; cv=none; b=FeZNr0PGSEnM84a3PSkLHRJPgs/GGO5OG5+Qj475RCnaL0iWEHlNvGf8YtJJrazTlD5B2cqq9hBW9mTxFxNJdLxelg/kMvPoZf+rVAK0Sn7tmgo4Zu5BoT7gCSrrSLO78npHqvifN4iy1ZvYnoS/mm0yOJTcJVYjuGtd1v3suic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726404148; c=relaxed/simple;
	bh=WYUiwiY2xirV3YCWVuRo/1eCoCh+/9EzRMm1hSd4MfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWDmbdfFDlCFANy2HUNtWzWbNrz5aSY8DVtTc+JwK13NBPBleg4XBJixKJBlptpO+6Fb3k9GncAOnJssBpCKzPqp1c9xQJfCb9OeSR8Ph2W4ZU00aFcSAEQ9gJe+4CBA6/vvIlnuMl1j2j8nx+cu89QSZTr3d21vcbFPUCSLoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrYmtrtW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2236772f8f.0;
        Sun, 15 Sep 2024 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726404145; x=1727008945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAmoRpSGu0fthg3IsTh3p9z8Wk1qhoLI0UGs01+Vzbg=;
        b=BrYmtrtWjnavoyUf6mTLQVrYMiylPZ432A6PwisHCmun72z88jXnYtGMxtBzxk3hAf
         237JQ6Rg7v2LKu9w3KB667UFqoLCuQ353Ic5jEXuETx89H2SOXcLsaoW+BBuGXsqGkN6
         QibBnfnfjiDudqEO7BKfqCTHuOhFCskeCT6D6cB7uzXWSaJF5tQpvkKch50eDEuhT2P3
         P/iRurwz8vjUHSeAAQG30yPINZ6SvR8cRwEj7zlnBb+qhiZ6G80WzDCaQoc9m32wp+IJ
         OhtKYb9jk7fA6HYF2CxA5t3iLlYKv4ooyQJWvJrbhrcZfsxomhgYuyV+k10HS5Xh/f5D
         OkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726404145; x=1727008945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAmoRpSGu0fthg3IsTh3p9z8Wk1qhoLI0UGs01+Vzbg=;
        b=rFNMLcObrpA836F14osRglbBq7mOJ3oOi4W1xe/Un2AwKQMKrWkeuy9nGbrQEj263D
         MNk9ZCIugIJJPABuEzTgkm1VmFIO0iir/7XXkB+ootH030stq9Mzvf4wO4arcp5lqE9m
         eWr43qvuCDwkUCWe1wFBSKPPguwQhMpja4iyp8TU0guavimUjXG/tHBXRKVTKoYhm0Ma
         dslN/Sx6bO6if0xEVdC/51glJy4rpHVoL8jhVMdbCJbEZ6O6eO8F40Eich9g8GUNUb9e
         pXjvIez3fdoV8wXjcnwK5ysdMrN7cGp0YJqgvxC3ySuRTtwsv8s0+9bHXb2ZFP88OvsR
         Agrw==
X-Forwarded-Encrypted: i=1; AJvYcCXDhdYazDr41u+n/79abvKoSbgAjv0LZFYsFYOCD/fPO6QZuCmeKPQqBr+vqpUbLDVbf+qmHXYB/PMJynnFVwM=@vger.kernel.org, AJvYcCXHG3U4MestHtjw6ziNKhaiH3tjeKSLJ4B3jhaKe0xJIwWjp+m6YwXbxqadbHYpIS5nUl90/k/NTflLLkLp@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ2SCA/P4UYlwPVmsjHEPrUaoLrtv1n25URmnFwyxCcE2W7w0
	NvLTrD0gzhvafaCQYFVbmtiY02DS778JhROT5yhPaWnf4Jxw31+0
X-Google-Smtp-Source: AGHT+IH13ljMpV/M4s6ZTPZ7igI97OJY6H/YX0z75kicoEwj0ihA0PkxmlqVfGWTgPZhVPTCLOld8Q==
X-Received: by 2002:adf:edce:0:b0:374:cb28:b3f8 with SMTP id ffacd0b85a97d-378c27a268bmr7448921f8f.1.1726404144909;
        Sun, 15 Sep 2024 05:42:24 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80afsm4578802f8f.38.2024.09.15.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 05:42:24 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] drm/sun4i: Fix a typo
Date: Sun, 15 Sep 2024 15:42:20 +0300
Message-Id: <20240915124220.105873-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index d7898c9c9cc0..0b24a5e3ac5f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -120,7 +120,7 @@
 /* format 21 is packed YUV444 10-bit */
 
 /*
- * Sub-engines listed bellow are unused for now. The EN registers are here only
+ * Sub-engines listed below are unused for now. The EN registers are here only
  * to be used to disable these sub-engines.
  */
 #define SUN8I_MIXER_FCE_EN			0xa0000
-- 
2.39.5


