Return-Path: <linux-kernel+bounces-242030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64B9282EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979DB1F21D26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A314535B;
	Fri,  5 Jul 2024 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtPrM5m1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2D143866
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165276; cv=none; b=ImLhZbM9yRSj7fEAp/u2ao6ss231M7TIGz2dW7hjnQtuiGJXY0pzt9VrnzIBFjDmEBROZCm7rySysK1gxwglYnxdZSEZMLK00ZlgWazlN2mvNQelptAb35guUraKIPkdFZLifyUsn8LwdKeb8pxW1GAPPL1U1eCtBb0tybykLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165276; c=relaxed/simple;
	bh=k+nb52xgZXJXsYaSnHBpWDVDQGynYhvn3tPYZFKBG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPNeATBiAc30+Mqhby+zpglDAwx1OyfT+MRGZ2+II9nT93C64IIe4X6UDoanfQPye7YUHy+OyZbJa6cRh8jsWwqU1jIKeki770BmbxEuarI4atpYlisoNmPa3REZyUunnB++lKTJYAMBk9Qk/4/VfOMUrtkD8PcGw3M8uw2OuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XtPrM5m1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so9014905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165273; x=1720770073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUMQGL5WSCg+ncFb1/+wfOD2d0NKg2if04eVfZHfzc=;
        b=XtPrM5m1POqO7F5cTRxQG24gbsdFm9modTVDdWWdiYWMxNRSVEkT5myZO/X6wiUtCK
         J1gOikoWG0LJ/HmGvgmkWF0f7bh4fM+MVVa5JhxKS1SRcNmZ6g8ffkBaIkPm0PjZLCIC
         mdaoUPumoNe6FIk+8a5WysES4UQhOd8zdEJDTuMJzRzYg9WndAMyjqtKsprYKUjy+sZv
         2xDTTrt6F+TAU5/eCKQVkUwz49gsNZKIJnKSlyKDdtsyF4MlCr3yRy5LUcILehTcAVzc
         HQ3zXHP/LpQmYbTMoCSCUxgGQf60x14xO3q9N7+go1+5r5fLl3+1/gKpknUfZv3fJej0
         nbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165273; x=1720770073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUMQGL5WSCg+ncFb1/+wfOD2d0NKg2if04eVfZHfzc=;
        b=lO9ReKzw4FMraRLWTwV02/A2vWj4uewml0WB8Ct5jTfnynLFKlLK61GWYp0XKdYrix
         vlaUE0y6PETVr52Jg5eRQygvt8M56sZYroxUrXRwXIwXlQXYgEnO+8IwKwx6jgYoyVFc
         pOJPxSrGHkE3Lt0mRxWtU5erKmFMMHS4t2Zsy1wf7VeFMseiwSa3cLEhUFa0Fr6ztVQu
         YfkSZVAkeqQ/esefZsC7eyBMJoFcTWxxzh7ukfFkF2yvUbeeSP+BlNE5wXNsvh0vAq/n
         h5w78wFIxdyuZVB040H3rTB8M4N1pecX4/gkiO1lASALerh0+f+P7+NeTGjPECifzDIQ
         ZNlg==
X-Gm-Message-State: AOJu0Yxev8Lh4EtP66oMe/o5R94NzetgrXP6tQmWALYqprPiea6X1TZ+
	7x2nrXdArJP9VjcIgQSrMvfWkBXZswMRiJXCVFGNg8ytKA4PryRoQfCgYN7uZHQ=
X-Google-Smtp-Source: AGHT+IEUciTxiIJXgl21ZjpRtapbbhvDEVustDC57bElkAi2huEleNscN9MRru2lcqGeLtOeVRBzjg==
X-Received: by 2002:a05:600c:12c5:b0:424:a578:fca with SMTP id 5b1f17b1804b1-4264a3d9e29mr28129975e9.4.1720165272681;
        Fri, 05 Jul 2024 00:41:12 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] misc: fastrpc: Use memdup_user()
Date: Fri,  5 Jul 2024 08:40:39 +0100
Message-Id: <20240705074045.418836-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1f72f6Oq6H/lspXXzDtpAY/Ia92lu+L/z56Kxb59lGA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N9SfE5gfxQc3u8tTzwRZuEugV8adc6Rd+qc k5UagYJig2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV N18dB/9vYQDXKtv3LAufJK3rEsq0TeCtk50PDmmUt5tUMHOWZ1DrRexxbQe8rLMKbG/6DpxUYTD eubsvphKX71EdlRLwYeoiYbJDM2VlE80MTfKn3bUa4Gwx/Ly2Y1wokYc3A382yzyZkSqmnxScvU MbIIz+ZnuRdxPaYBG2ySkKl1gw+xGLLmdGOhRtzWOUQL//3yLkEvFCru95AQqi51l2qBbGmk7vV wvirs5DZM7JsGTxzgfpJEhUhgP22uq0Dp9irieAZR1y9Jls4Vx45F5kI83by7cej/vRAX+S5ECz BHjs9B0RjvOc+TUUB98+zyv4bx9ZosEwRpwEnATgeHbYGpnV
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


