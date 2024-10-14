Return-Path: <linux-kernel+bounces-364024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6F99CA03
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A651F22ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3E19F46D;
	Mon, 14 Oct 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WCrvR4A1"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956D19E7F7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908756; cv=none; b=p5hzpdVqxf57ZlH497TyrQvq8zteKAq7GlBRB5RRxcpGLpLJ5iOhUGoDrfkiB6AsDuiPCaBmLXo1QWnt1c/dvIozYpxpb2zipc3DYf7jFXNwlMIhVdFeoQeEVg4ZN2brWbreD1WJlouK6+fdQjKcEZ41w7wjDI5uY0kIyBzhpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908756; c=relaxed/simple;
	bh=w1HrVAkLkPniqQ4vM+cswvOdxgv25q1aBbgL6kqywBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaDmsj8Y21FY827VADEAgNhF4KMLQXUe2Vn6nLt/qguStyJnXp3Bm9+bRFbDah0oLpO79nO9TpFHGA024OXgnOZy2HMaGmhdYIVEcIl4xvNNvPYFc4hkBA9f3ru8nOcpxf1JPIvPqyV+xHVv04j6nARMsldTLK1gts2f8Qxasmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WCrvR4A1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so41154165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728908753; x=1729513553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWQ+ozPxKh+LkihJTluy5OmXTe+QWtR6N6dEDPKb5v4=;
        b=WCrvR4A1P/ybMr52S5QtOIbnb2G+cMog+Zi5XamedlFxf8R5tQFXQ9NnwOv4LnnZ64
         N8dqJu95osnHPUYjTIJd/bfnUfX2cVRLU3/VJqpJf5LYsuw6MRbM4bCFQTQqVtnPOHjy
         FZlSSBr6rvgCQp/JICRfJXnRbpYfy6I1+pFFCRI5gTRBgK79BZYcxKbzd7oSea5BRaOA
         K2mwRc4G7OmSKJVfPKQU5d7iwo4CvdzvBoUyOiDB4prXIYKpMMwdNVAaYX3YJP4rLy2K
         wPa1CTOrNrz3spQPxuxwe41aKzERfaJ4H/6lIgOmAvm+FJhYU1XPNUZ7eLveBenl1FEF
         bkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908753; x=1729513553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWQ+ozPxKh+LkihJTluy5OmXTe+QWtR6N6dEDPKb5v4=;
        b=rDcaKx2YUqqtJEQHv3p9+slpvWEvNz8BO6ILStobh+7iaq0fMyA/Tg1WX7DuPizXs8
         pTSzLj4hUqwfTnjWcDDmCi8TCcMqcyNl2WqEZmdhnz/JISjjUC+yPBnxfI6A2Vy1hLqe
         zLCgFpaIyS1Vzl7j3hxOv+TppL7ZInrr2lw9FLtIU4fB2ebw+7pub8Eii1TioAR6fo76
         nQyNAS781rWgv5L6o1kCI5SHR00EjVYmNdsmrLZyxI72ROe7Esz63YQdv2SmXDVt3N+m
         FmvT0m4+GdXCH599fojejqaBU74FWgybAc2g6XHDrXx628dca0vv1IYKtxl3m1Vj3not
         Tqlw==
X-Gm-Message-State: AOJu0YwxmGpRolImTgpPn+iUaxMktszQuWF5z33uiBMrvZJHw7vK2zo8
	HM9HAlf7nH9PRwsk8hIZ+cGSgCcTySmmaoMABQ0S/0aOx3EvilnGrNB0kRBSQBU=
X-Google-Smtp-Source: AGHT+IG1np16l0QXAWqXF8NCvfGi7g6exzYBeXy0PDwjPEYIWSkuVUrPKx/Jyy7eh5wf0fxZFNI4Ew==
X-Received: by 2002:a05:600c:4f07:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-4311df55cffmr95771935e9.33.1728908753476;
        Mon, 14 Oct 2024 05:25:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8928sm11327931f8f.7.2024.10.14.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:25:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] mux: constify mux class
Date: Mon, 14 Oct 2024 14:25:51 +0200
Message-ID: <20241014122551.116491-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All class functions used here take a const pointer to the class
structure so we can make the struct itself constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 78c0022697ec..02be4ba37257 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -42,7 +42,7 @@ struct mux_state {
 	unsigned int state;
 };
 
-static struct class mux_class = {
+static const struct class mux_class = {
 	.name = "mux",
 };
 
-- 
2.43.0


