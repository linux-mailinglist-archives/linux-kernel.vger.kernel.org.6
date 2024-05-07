Return-Path: <linux-kernel+bounces-172132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA58BEDE9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C0A1C234DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E818732F;
	Tue,  7 May 2024 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mKAxOqlw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA9187324
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112901; cv=none; b=LkYYm4TTWrraI3ZbeFvAisgeARRQi3pE+cQ1yaJYVu5fZZUqbLJ9MmavlM2pU2LPE9wbBU4AMyGyDxvcpW2i/ovGOsUqOwQazvY5W0E7qbeGAUGv+wcIx8bcaETcSFWHV/U0iOGAUAgIUih549GmMs2bYObu0rDUnqvyKgt+olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112901; c=relaxed/simple;
	bh=uF/Vd8iS8+hkKkgcHT7XHq6r8l/kr/38zC1///r603M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG9cCW8lyQaB24Rr6WgAN+lhybMBlSakf/MeZ9LHcCn+2JwuIonjPVnJiTsHXOZTFVdkIT68zR8HKdwUuG0765t73sYxc5/jJcod5ZJBllVa4rkSU3Geuu4u3zE6oAGFGWihdzltw4Oa/ZsQjp/naiFFq5k8o8sKzw3RT2mBJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mKAxOqlw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b58fe083so576919066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715112897; x=1715717697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc+DhP3qfYMeQYd1WzssP6XA1Z1B/2uDPEzJQepNAyA=;
        b=mKAxOqlwrmfJGrfxuiCJObs39MnQuJtjRFEwx90wZpLM3JZwvHIXzVoRNKc/GAWvGh
         u57h6vSnVIOrpcfagTK5S8xN0BnpshAQ9xVogv9YuTY+Bdsa54WxLL2DiKapU3PD2Tni
         6iaDM9gc0SG+cFD8BUmk8PC0bXfE1M3Wuq+zuwC7Guzr7DyfGTglxIWVDg9gZfr3Nkt4
         E2YOdQoWX6zMatP9HuTbqVVoa0QNU3tnjOn5s4byXICMZRacTxpilEFQVqevyE5dnqq/
         Bcom8dArut4Df69jYZaVHC/CTlkJc88V/gQKK5ezt82p4nB/Z7LnZYE3HUHrdCS7cJxI
         sD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112897; x=1715717697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc+DhP3qfYMeQYd1WzssP6XA1Z1B/2uDPEzJQepNAyA=;
        b=f66CyC4s2z0KKSUeWJ2jYv/6xa8xfOrHXNDd6mMPxGd01WVM411NKZKPOjYJ5Usagm
         6kyTmdjpu2QLdg+/WvojPT490H5bQXNQODujABADje7yBwrYcGtuucbPvhDhPI3pAy6o
         acNQENtTq54d5kGt+YWfVFc1lNxs95UH1zbgSopTpRvV2D377e+1eK3UkfFz3jQvfANb
         MMTerpUHMHCjZONH07QTQT2r3qa4tmt8wTBpowm4TyZm17gqEUMKrKmR7AlPxC87Cu0g
         hllVLBa3VQxwhZ0WTez1bCwqL70gQPNiDE/eQ3itQ4cST9SIM71O6dYDwGHRtljrOHs7
         Md6A==
X-Forwarded-Encrypted: i=1; AJvYcCWxFjlc9GzbSJAkzSI9zHFtqaxYCdcVKPKh+BXtSxs3jCyhqCi+w+SnafECzHNdyoxfLy1ZBP4U9wZNpO/4QqWvtB0BEHw44Wt8H4lb
X-Gm-Message-State: AOJu0Ywq1e+xjCpVmFoi4KFBUzzwdE3a5Re1h1S05V1k1s9ISUiBJfYn
	j4mWikXi2XczOPyC6AtjPwJtEWeIJTkfJbQNQwhmMNuHFZkrKTKTG1rMUIUkJ4g=
X-Google-Smtp-Source: AGHT+IEQe0zPn3qRHBQ30xg52DP8WChP6Hz5lHqyXN/WSWB0ohXFcZhrQTgXdVgveeG94gxUrJhRhQ==
X-Received: by 2002:a05:6402:50b:b0:573:1ee9:b617 with SMTP id 4fb4d7f45d1cf-5731ee9bb40mr362496a12.36.1715112897342;
        Tue, 07 May 2024 13:14:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402128e00b0057278b1b139sm6634458edv.29.2024.05.07.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:14:56 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] misc: fastrpc: Use memdup_user()
Date: Tue,  7 May 2024 22:12:39 +0200
Message-ID: <20240507201238.213396-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to memdup_user() overwrites the allocated memory only once,
whereas kzalloc() followed by copy_from_user() initializes the allocated
memory to zero and then immediately overwrites it.

Fixes the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

	WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..2857cddaf812 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1259,17 +1259,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
-	name = kzalloc(init.namelen, GFP_KERNEL);
-	if (!name) {
-		err = -ENOMEM;
+	name = memdup_user((void __user *)(uintptr_t)init.name, init.namelen);
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
2.45.0


