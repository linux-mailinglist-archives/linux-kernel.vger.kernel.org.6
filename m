Return-Path: <linux-kernel+bounces-375905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255979A9CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729E4B211D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AF16132F;
	Tue, 22 Oct 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMqQid0v"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F10157487
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586238; cv=none; b=NGOCs95nujLxv50hiaC/OzInm0l6pgLptDsmHPbuTzWIToZjAUr3YtcpdfzbxF3Qhp90o3O08CGMhINcylHtqWYM2VvxMyDnASbu7im/09islb447rFK6XFX1dXU+F8rUtnWePZPOs7mjY/vllnxq0U1RYTAKWFjsLDq9DYfbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586238; c=relaxed/simple;
	bh=2+tHBXLB52nrb5ur8WQTqZDtTXdTlh2/ORRFsQyeWeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NhuOwyXQU8c+cbpLRhRus9ojs7TCvuox0O5X5Yy5BTtkFRH9/JPNhOKy9aFgkxMqjLpOXiYP7X7eIWuEbDDAhuYo42WWxP/j1sIHeOQE8TPanfHh0FByPd8BK8WUFOTb7so29B6fJxgxMK2g4BmawdC7FQI3IhJKQnZB5Gbx/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mMqQid0v; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso1579592241.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729586235; x=1730191035; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYBU5LVKi1NBKSVbybBbkXcGxUCfltoJjMWsJSkrdSo=;
        b=mMqQid0v8LL1ITEE8DRPl8JeIEAbBrQ67jJvl9ZPyjFIejVsI+xcZ5/GvCafAsmBUz
         6RyHPTbdJNf1aXj3g4tDw8SGZNkUUgbZC7DvUAfxzPYX2V6YauQkzpr5oqrf2mwcsllS
         0B4O78tGjgBFvzaOA8JWEq41dxhkAchJdhsXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586235; x=1730191035;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYBU5LVKi1NBKSVbybBbkXcGxUCfltoJjMWsJSkrdSo=;
        b=IwnnJj7Vzh7AHzQbGxOJz3dEt8IfnEgF596BBERqWHAXT/GlZgr9Wa5tUnD45ddYGE
         9sbeXxaN6Nd1aXnOW5SFhfWP/Fzrisd9YyVJBfbFfEYjJ7VF82aLio/AK5O37ur+9K2C
         e4BdPuwMHYvEWvevPS+AokObNTP490qnO5Fxbs1eQXQKSPp0PwrY1JNGOIfLT0eV3dxd
         ljW4dEr15n80P7RZ+D9jqFhyYIn0ZPDJ0bsPiMLW98vX19/BsXi810NmIASC8zaRViGi
         WtmqkNr3Argq5Si4QclmHTpNqojozz7zsj+7JwvIRpj5MMBj2unOw/wQ/lhnK3Fxu1aL
         hdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4rJ5lPcYnOTyp13Nc8tcKJIYaUUNVUuZDMyAPydhFdVH8KEUPhySoAvkczvz5pg1DYmyRCDJ/qEFTsBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSmDdCefFvkAm8IxQHzCpuvOYmzBySTq0kkAgRMpSmxTfWMwB
	uarQc2glQ195IgkOyKGsaxYr/+h54w9wLwWkQcBS/Q/5QmxWMi3aUdZds7Lwsw==
X-Google-Smtp-Source: AGHT+IHmy8BIavT1N3KqQl/mbI9rUUbK3P3RCOywFOoBOEnGDDkVRqT1bLldV/imxr6JYpZUT/3qSQ==
X-Received: by 2002:a05:6102:5092:b0:4a3:aa99:5ef1 with SMTP id ada2fe7eead31-4a5d6bd71d2mr10940099137.25.1729586235669;
        Tue, 22 Oct 2024 01:37:15 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c95aafsm27324541cf.40.2024.10.22.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:37:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 22 Oct 2024 08:37:13 +0000
Subject: [PATCH] media: uvcvideo: Reorder uvc_status_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-order_status-v1-1-3904fafca340@chromium.org>
X-B4-Tracking: v=1; b=H4sIADhkF2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMj3fyilNSi+OKSxJLSYt0kwxRLC9M0cxMj42QloJaCotS0zAqwcdG
 xtbUALdUpDF4AAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Only initialize the input device if the interrupt endpoint has been
properly initialized.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 06c867510c8f..02c90acf6964 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -262,8 +262,6 @@ int uvc_status_init(struct uvc_device *dev)
 	if (ep == NULL)
 		return 0;
 
-	uvc_input_init(dev);
-
 	dev->status = kzalloc(sizeof(*dev->status), GFP_KERNEL);
 	if (!dev->status)
 		return -ENOMEM;
@@ -289,6 +287,8 @@ int uvc_status_init(struct uvc_device *dev)
 		dev->status, sizeof(*dev->status), uvc_status_complete,
 		dev, interval);
 
+	uvc_input_init(dev);
+
 	return 0;
 }
 

---
base-commit: 698b6e3163bafd61e1b7d13572e2c42974ac85ec
change-id: 20241022-order_status-b1d985f7423c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


