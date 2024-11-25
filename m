Return-Path: <linux-kernel+bounces-421569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9F9D8CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE8E16A600
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF621CDA19;
	Mon, 25 Nov 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7tFM6IJ"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E81CCEF6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564162; cv=none; b=u4HGyN4LmEnMoFomJYBbuPCFqbQ4510lL9V5BxFJ+ztEBWjjTuCrkqzTT+r1k2x3BUVfXTuEWDpIlOWEBB85SNTQ+QAlERBlypuNyUjOVqD/CwFVNeImrtX7evhZqxTn51BnDItBcjKYADNYbSBjpHo8B6wuK0WK2IjO793Od/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564162; c=relaxed/simple;
	bh=vAAOYhnDuCS6QSDtHNvCZ/7V8wyms193hC/CkNF19gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGSsGLKy55Fc7hu0pEID8oJzNSF9FZEpCgFw1xnsVObX/l3jmN+aBd/6zXP/D8TXKxwNVjb8BH0Rbh8t2sYd0LUBYEBkRToSoqTEmF8VxOB8FqBX6bp0Iq5wV+FIcYQedKk8IAKvftRh9wKY9gkRF2KEjhFKUPIzJs34Vw5OVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I7tFM6IJ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4af0e3bc307so556581137.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732564158; x=1733168958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qew2lSt6MOHSZhwSkHfFr6COKD1ZhgAt7ezEOaoydpo=;
        b=I7tFM6IJ4z1ud9N0cp5ha0k3yRHi0XUjo7ipQ+LJEkd3nMkgkh83zlQHsJf5vRE1wZ
         W0oJA9i+AeZXj4JoqBcQFpUnvVdx5Ks7w1E+B29rhe2naPsasUVv4DyreQnrfhm9NS55
         d6P1xJxlK64LwCDEwQxB+Cya9JVKshX/zeW9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564158; x=1733168958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qew2lSt6MOHSZhwSkHfFr6COKD1ZhgAt7ezEOaoydpo=;
        b=K1NRo94No/9IBIDAZ19rtch5hNEkaj2JUMYH+IVEjP6Ya3+q2PW0qfmU6Rb19oXLg/
         LisdnOC0lGAmRxV/HxCZrWxN/vBuBnOAWqglMZ37DckJAW6xwM0LorOnVq1zf3Nhx1NX
         Vl2Q4LQRP013QRK/baMjY1tZcDUwmpXD1uKQB6bTlCrZqs+k8OKyAP7H8jwgo8R8VVWR
         K6e2p2rTDo8B7a+U7LDgHRLtv2Lwbld71d5i9Sbu80ndY0HMh8Qq0uf6w643RAMXejsB
         J5JNvLwo23CEIfyVo13VxKyX80Yhf3A42vDCUiAnHwRo9lTGzt7sjLYBZSaDHyQnHyQc
         esvA==
X-Gm-Message-State: AOJu0YwSmq/z7C0fdo/bh0i8oyafPkWMwA+5g9+UphWKCJ/k+QjF2c6A
	XIscjn2GkI/+x6IY/4R7SYuhw02PHNwyxcsqOeCnb9uY+ZLJbvfKPEdZKCDkBg==
X-Gm-Gg: ASbGncsVnochWs4wcnJbCMokrvuKLwFCG2bOzUWbPNFDgWr0lYH/0BLS+7YYeaB3wx4
	N7KEoTwMI0wviQtAH11YgYhvwy3/YMV7iDInLhrifhrBJcjTk+sNPYEVgg8u5cZLhjA3VqZBdik
	yN4Ighq7QESyiw/BdyurUhU/VAWBWEpnIIgA8hRJUJWJGdMQZHFxYo1KcFS/wNWRWz265DR2gLc
	3EO/KkZTlaXmgzA7MCC52Hy1ShodE5YfVpC6NMRkSmduaU2gO1hrtXVmPL77gY4U0fq+zcj6eb6
	R8SWNXWaDKSunoMx225spZgj
X-Google-Smtp-Source: AGHT+IEzOfjRUDJXkBH/ci9g+7icIZ8rpZbJ+DF/b16ADeDrCfZI2M6YFtGhhnhW1P+JjUvKqQBQpg==
X-Received: by 2002:a05:6102:3f44:b0:493:de37:b3ef with SMTP id ada2fe7eead31-4addcbe4e47mr15581878137.13.1732564158359;
        Mon, 25 Nov 2024 11:49:18 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358d2f9asm75324137.23.2024.11.25.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:49:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Nov 2024 19:49:09 +0000
Subject: [PATCH v4 4/7] Revert "media: uvcvideo: Allow entity-defined
 get_info and get_cur"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-uvc-subdev-v4-4-51e040599f1a@chromium.org>
References: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
In-Reply-To: <20241125-uvc-subdev-v4-0-51e040599f1a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

With the privacy gpio now handled as a evdev, there is no more need
for this.

This reverts commit 65900c581d014499f0f8ceabfc02c652e9a88771.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 20 +++++---------------
 drivers/media/usb/uvc/uvcvideo.h |  5 -----
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b98f4778d8aa..90bc2132d8d5 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1087,15 +1087,9 @@ static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
 		return 0;
 	}
 
-	if (ctrl->entity->get_cur)
-		ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
-					    ctrl->info.selector, data,
-					    ctrl->info.size);
-	else
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
-				     ctrl->entity->id, chain->dev->intfnum,
-				     ctrl->info.selector, data,
-				     ctrl->info.size);
+	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
+			     chain->dev->intfnum, ctrl->info.selector, data,
+			     ctrl->info.size);
 
 	if (ret < 0)
 		return ret;
@@ -2055,12 +2049,8 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	if (ctrl->entity->get_info)
-		ret = ctrl->entity->get_info(dev, ctrl->entity,
-					     ctrl->info.selector, data);
-	else
-		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
-				     dev->intfnum, info->selector, data, 1);
+	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
+			     info->selector, data, 1);
 
 	if (!ret) {
 		info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 06c4d514d02c..6002f1c43b69 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -240,11 +240,6 @@ struct uvc_entity {
 	u8 bNrInPins;
 	u8 *baSourceID;
 
-	int (*get_info)(struct uvc_device *dev, struct uvc_entity *entity,
-			u8 cs, u8 *caps);
-	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
-		       u8 cs, void *data, u16 size);
-
 	unsigned int ncontrols;
 	struct uvc_control *controls;
 };

-- 
2.47.0.338.g60cca15819-goog


