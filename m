Return-Path: <linux-kernel+bounces-242081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91192928350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27001C2266A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3331459FD;
	Fri,  5 Jul 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0VY6lVJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD211442F0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166346; cv=none; b=J3lOxgxdTe4icGFspoJgfTXjA304yKynnFJZIC0KtDWwpFPtohmufTpAzXNCWbuZAZsH3uUIG77pmfsYsehliaKWtfvQHXIMoZdVVsDLr6kDgXQO8pTboWqECn5Bt6wxecFAatvYbOt/JfgUV68d0kmJb0CQ+VnfcKevyY33gTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166346; c=relaxed/simple;
	bh=k+nb52xgZXJXsYaSnHBpWDVDQGynYhvn3tPYZFKBG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBSm+zmSrkbB9w1OH0aD6DLbTRbqzF5V9ISvVFkYANMVrMShfxNcmminzwDQy0/u0rMhdPYnoD3TWux6hbXtZK5jL3Lwum2bB1F8sYbC4iD+eU2YdMfuUlNWO243o8bTbp5q4jxFE3Ti9E7rr70+X75OF7IAIT4Bba3CvOO5hQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0VY6lVJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426526d31a3so1681165e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166343; x=1720771143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUMQGL5WSCg+ncFb1/+wfOD2d0NKg2if04eVfZHfzc=;
        b=H0VY6lVJ98GSDKVDRvt9YcdClDATALSz6jX5qwjLMQwWrtAeNKiE2A2YvbGFyhnVTp
         zpsq96C53tEeI63EZnVvhkKeUFHzw7yOahL60anHwcum16Lkz4Nf4La9GZbRWYzj7ZGo
         VkMbNb2PH3InduQTGNoF1XRoFzgVc1lNs3nLWa1RMt85QX86Svj0dtPLBoj5Jj8ERlJy
         4ti6/j/1d1GZn/LiSrZdAnon+6D1wEkr7g/797J3zc3BUg739peqguL9aJl7AqkR5i7G
         qY/oxOFRnuP+SU4siz9x4r07ApkIU7CqeBrxuQLOIQpnx+JWnJpNcXXEssX8MzRtP4JT
         CAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166343; x=1720771143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUMQGL5WSCg+ncFb1/+wfOD2d0NKg2if04eVfZHfzc=;
        b=WrnK03FG1oU17h3Y6L1dkuvGuWMs8Z7lz9X8Oe6anlXWD7HK/76EaAUvkw56ILmNdR
         mKLarCf4y/YFwTwklcAb/EW2H8SAGGFhsoIYHL9IuemswgdYuHKVEgh++7LG01DOEW8a
         VpvvjAzCqtgG5rR/loZprWxIqXPBgRx7GiCobKlt0oWGID7bXfgBudBa0ts9NUbg8/s5
         JMaCeHq42ziQcoM3t+L6qsO9dSJ26IVrrW5Vtbp8K/7mRjvX4stDmJo6O6eP1B8X7eU6
         Voc5njo7/NMKdElHL80VXvDVcmgbqc5pPQFTOFrCAN4WUtlte1lDHYNq8YDtqJpWdjgT
         jzPA==
X-Gm-Message-State: AOJu0Yz1apjH5VbdSjJioMXU/rE4gfRVDac07PwcIDOXYaP6/L2wYo/m
	RcmbvEikWAwgts1aOrYDQiRq2c6Piv5xwD24Cz4KXy9tYLNkUgZm8Rj87dIIK0k=
X-Google-Smtp-Source: AGHT+IEWjY8zD9BufrsEhEqK8tWy5nqJA+CiLwZWAGkruz1YZsp4w1bgxeg4b9IrbrEbs4oBKQUmKg==
X-Received: by 2002:a7b:cd19:0:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-4264a41f86fmr27382825e9.39.1720166343484;
        Fri, 05 Jul 2024 00:59:03 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:02 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/6] misc: fastrpc: Use memdup_user()
Date: Fri,  5 Jul 2024 08:58:55 +0100
Message-Id: <20240705075900.424100-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1f72f6Oq6H/lspXXzDtpAY/Ia92lu+L/z56Kxb59lGA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fDSfE5gfxQc3u8tTzwRZuEugV8adc6Rd+qc k5UagYJig2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N24kB/0RY+uTR9go4oNftnPzQvtN/TgqSitfJO/621L2JbDGrYk9E3Z2DWH+ML23h8wvaH1gZ24 xTB+ZklmTcChFhhLOeGG/zh7vIU/6EblMI1p6y4fTX3/Zs3q2gA4X0F9hfEyNmPLlUOKFGkweOl fQDYh0d3J15ZssZ1QNrTgaXbmGYdm2s9m0sZdLgH4uyZZeJHK6ywDNREB4jN0Sfy3HqS+mDC77L Tgw+aG4ZfM+QNtkq9yej1NgGZTyOFKyYSyn3QxDCYRqecC9O9PUEkAO57Ao85jRmTz2zVusSp8+ cqsmB8ca0I3vRgRPy6a0/WWF7oZ1Z6W+4/cVVGe2neHQY/gR
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

Switching to memdup_user() overwrites the allocated memory only once,
whereas kzalloc() followed by copy_from_user() initializes the allocated
memory to zero and then immediately overwrites it.

Fixes the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

	WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..694fc083b1bd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1259,17 +1259,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
-	name = kzalloc(init.namelen, GFP_KERNEL);
-	if (!name) {
-		err = -ENOMEM;
+	name = memdup_user(u64_to_user_ptr(init.name), init.namelen);
+	if (IS_ERR(name)) {
+		err = PTR_ERR(name);
 		goto err;
 	}
 
-	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
-		err = -EFAULT;
-		goto err_name;
-	}
-
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
-- 
2.25.1


