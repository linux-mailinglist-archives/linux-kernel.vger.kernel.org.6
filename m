Return-Path: <linux-kernel+bounces-430216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C19E2E32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8679AB306AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7D20B1EF;
	Tue,  3 Dec 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+E6Nm1h"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EF20ADE9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260823; cv=none; b=L84uhqJR014F/3XV2A8ssdXpO2dgte7Pa2EhgdZFQeboT86rsUi0s2AplSxaZ8SFGTpBywu8RGEkbgeZWVFAeQ9rmBzCTcvN19Gn4Gy26F+nUHJsDw7fmiTwpUQoSbmv8biSXnqAAjFX4MTbvmBHvtxhx+7u1D9I0UdsnNK/z7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260823; c=relaxed/simple;
	bh=l4/lhwctK3kBC3s2JyaOOWF9ukBbTcldFztSXBtwWD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGzvyVOqSnxQAv11AXz+/4iFf+JR1Rm9H2SqVrnl3c2eKAuVqasR5E6n/qBqhQlve5uwN1ZdH3prP5WsSqzsaAtX4TKyBdNNtEUa49T3e05iiHAWsZtZNH5eaLbvNPjmNunWIaerQXfReTeaI9xxtpI0eOTrit0v1IEVJjv98hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e+E6Nm1h; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afa4094708so148229137.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260821; x=1733865621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL4Atu/0WT3Bi8AnR4uXCq5U/XlhAxlSF0B4ijqZik8=;
        b=e+E6Nm1hFjwqcRGOb8qFT7tP30MVCZ5B+SM3iPDu9n3QNPvXzjxd1FrRbPpgbWkJ2+
         UQRcB7vnhSiW8iDNOGfhOXGnvMlywv8romtCbY4/Sxd7jBX8CozCRYEuXKIjGLuPIjg+
         T91RF4uUsqLpE+A9X3QSjA8e/9zqooMdpCNlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260821; x=1733865621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL4Atu/0WT3Bi8AnR4uXCq5U/XlhAxlSF0B4ijqZik8=;
        b=pfKYCwXMVWmqvLRaT5oI1AaHar5d3vsaDMSg1YP/mfiNNS/3xZGRFQ32uP2wzPGtqM
         C0r3KkjjaBjkVJQEPtBPvEXgUbZV5rRjisF+wixaydHw3E2Pe0NwZGCtKnnt6n1msXCz
         Gu2VGVo+34aLLzFwIJVe4YoaImFoGVxDSXoM4qeRn+OzhMmEOCJ+uzEFN0v1ZykDCwSc
         tg3VVK5722Iko6MqPLzlTq5kCiDwJtad6gtwRJWnrJE6dTMjyfSrFuqBJTvOmZ7fM/0t
         d31EsGOWjWwSPLW1YSPudOtvnnHZeKVzMB5p8WEbSX9cZ0gCFAELdbrbuFuwNtdC3iT6
         BXBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxuXXsEqvpDtiIImoh0vM53P4wd7lwcvq7goIhyG7PNbfxmB2rWnmjpZ5oDaG+c7ICAsX8hDClt5xtdtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd399lPmC4YNcWfnU2GZqr9XzRiAilOe+kdj4vjE7GUdCLx5PQ
	j7BIDkaE+menHLKt+5yOx3GakxCVVMImA8F0eZwS7oSduBMjaTf48kHRSnvUtA==
X-Gm-Gg: ASbGncsan27eN6v4kr+GIrDwC6QvDUjWJHHExhmUmmiHa+sbikLclZp6OiiCYMCC4xF
	+2SJW/+JeexfUc/yVK8yBFu/vNkb5x1mXhz6B2wxXNr+sN+vJa5l9abLCB+3+j1nnxRVDRnCneP
	2wIvZTsWxi9idsQBvOT9g0/AyLjXap5e9UuaAjoe3xvhFJUsyOS3OBLmZIkTc+9JWK/JXahANB7
	NikFCAOKc7Mp6YkrGUtnnHSv8QkZwATCHmbE/VVdv+ffMpc1UiyATk/yaRhQqeuLhZDJe4p0scg
	Uys/ZMwzhFbLuCkq+4lfcBbh
X-Google-Smtp-Source: AGHT+IFDq/YyaSDjFBUXsfLRGsjk8UOE+Mft2rZWydxkoxjhSW9PDslAnWq3gxZr/nwtXjYBEcitrw==
X-Received: by 2002:a05:6102:e0f:b0:4af:4c4d:c8e8 with SMTP id ada2fe7eead31-4afa4fb9017mr3596621137.7.1733260821288;
        Tue, 03 Dec 2024 13:20:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Dec 2024 21:20:09 +0000
Subject: [PATCH v6 2/5] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-uvc-fix-async-v6-2-26c867231118@chromium.org>
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9a80a7d8e73a..42b0a0cdc51c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1640,10 +1640,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;

-- 
2.47.0.338.g60cca15819-goog


