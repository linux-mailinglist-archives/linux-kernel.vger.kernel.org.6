Return-Path: <linux-kernel+bounces-527915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F06A41142
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D28318983B8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207621148F;
	Sun, 23 Feb 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZvtngmJB"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F8210185
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337187; cv=none; b=uol93D+jb4ZgvCewdJh5fZF9+Dh8oTeuZ3qXMHWp+z2ePhGXR/oWZ6earHQPwFrpI8mkrN6HQm/ygww7YLivAC1Wh9Q4Smc+6Q/xOr/pKrdtgH+XZKU+pm0KYSRCuvTbUtKHHmOTTzQS9InTkLpUP4+6pLu3U5KHMcjtoEvyjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337187; c=relaxed/simple;
	bh=dnwNReE1hPulb+Tc8iZo/fcErBj/zFU9VbifxtAwbsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PIkCI3O8/d52iJQAPgQjvpCLyvI9GbjIrtiie4ZAiVcNbtBRMfq/S9RsyntKSoSxCdwHYZdU7W2o57mWUfoEjpSSGl4ItM4FzVXdqz4mVMbNsPqPbrjB+g4itoTziVyoXNslN0hd5tB8hBE3AJeX7vGacta62IPaQkSEPNLeSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZvtngmJB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c07b65efeeso372208385a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337185; x=1740941985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1ZNr+zAsbdRe6SnCCPjc7UJkoW/yg5cRHdJ7D9R9Hg=;
        b=ZvtngmJBQl9C27rYRt+X+FHVcXHm8b8taPsOH+hMlheQD3nFZ9LlBFPHq4HB5HmXBn
         WbV2LzrkvRZjsSyZ9vmugp8hchSiTko3xNu033TdYjkySkoKZh1KHVRFh+aoe+36kDRU
         AKS6ez8J+fL5jHzNts8/KNMyWzGgKl7zPvBos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337185; x=1740941985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1ZNr+zAsbdRe6SnCCPjc7UJkoW/yg5cRHdJ7D9R9Hg=;
        b=FH1WeA45WKlh3izFdzgPouZSOdxwivnat02S3kkTmfsbQQqC3lMTaZUy3uoOhSKCFz
         SpLdTJX6r03KGGEJgMnFTYbUzw8y0BHmTx//HUMTjCjQV3vvlBLP/8wHZ7NEsDrkw2w1
         7NtnD4uB29y8UV7NObagN+jlrxvsBc81nTT6X9C+LQn5tWxlIQYjXb0vAqnSIICWMMan
         LsqA3w6DRVSAvNuaCIn4tBE+8zC/SF0e7pWv8JjEFvjoIxHUsCGuoCqWwljtwpOGwJ9A
         89XjL13sHGceOoQTO8uAhGjKhUYTDq4qTVRwzW67xA8me+X+f42SeBiA1jEvMxp8ctg3
         9eLA==
X-Forwarded-Encrypted: i=1; AJvYcCWipgzqSzcR6jLn4SoErgPtozSWI1Fj2lz4jV7IPrlIx3Hlq6HOSORdBh/M9xFC+oeLDvyjvyPkvT2FWkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xWiIo7sxT9cQfJNIgBgLFyO8xZyPp6ZHqAzSn6NUqLVy7a6a
	dzJtg+h3CHkJcyzEqCoXaQjOf+MtHSem2jzEjeo+TXkFnQiLUOoJNfYO4ZSS5A==
X-Gm-Gg: ASbGnctG4Iz0ZaRtlsvoECFOPdq8fwfyF/hMnO0zclAMrXLY+RZGP5pz9tb3cJz1SO9
	G04wr8Vn0JOTx3xePF3xrF+zQ5+LtCQfELGr0L/vxBw/91ku/OqgKbrH3aTG+0jJlKdQsPjOjW7
	tS5i7PK+RFhmZHmvEM5g+Aq+JHLeW0uHopn0HWDk+93d9nBVzbUkFle3guhU1sLtocs9cLTLomT
	qddgC0u/vhhmegIbZ/gfpKpWI6C6HZiNVUxmGvFQSvbQtqv/xveGeDip2TYsEf4TnTmHIvuQZif
	MYxEnk3+MTGmDkM98M1eK6s4Bq5DPCEYN/auyiwU6xlNwB3Y6YU7sdHOWOk+qGGxCrzqiYBaFm6
	fLGA=
X-Google-Smtp-Source: AGHT+IERdPcmnp8DFkM7FzQDBmkbwLEcVj462XFjOmf0I55eocLBJbotx9VABzofXN7Sh0Nf0lYF2A==
X-Received: by 2002:a05:620a:470d:b0:7c0:be0f:2dad with SMTP id af79cd13be357-7c0ceef9875mr1290641485a.21.1740337184802;
        Sun, 23 Feb 2025 10:59:44 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:15 +0000
Subject: [PATCH v3 12/12] media: radio-wl1273: Rename
 wl1273_fm_vidioc_s_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-12-4292911cab6b@chromium.org>
References: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
In-Reply-To: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Now that vidioc_s_ctrl is gone we want to remove that string from all
the codebase.

Besides, it isn't the correct name of this function anyway. It's clearly a
left-over from the past.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/radio/radio-wl1273.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/radio-wl1273.c b/drivers/media/radio/radio-wl1273.c
index 511a8ede05ec..f55217ccf2b8 100644
--- a/drivers/media/radio/radio-wl1273.c
+++ b/drivers/media/radio/radio-wl1273.c
@@ -1407,7 +1407,7 @@ static inline struct wl1273_device *to_radio(struct v4l2_ctrl *ctrl)
 	return container_of(ctrl->handler, struct wl1273_device, ctrl_handler);
 }
 
-static int wl1273_fm_vidioc_s_ctrl(struct v4l2_ctrl *ctrl)
+static int wl1273_fm_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct wl1273_device *radio = to_radio(ctrl);
 	struct wl1273_core *core = radio->core;
@@ -1945,7 +1945,7 @@ static void wl1273_vdev_release(struct video_device *dev)
 }
 
 static const struct v4l2_ctrl_ops wl1273_ctrl_ops = {
-	.s_ctrl = wl1273_fm_vidioc_s_ctrl,
+	.s_ctrl = wl1273_fm_s_ctrl,
 	.g_volatile_ctrl = wl1273_fm_g_volatile_ctrl,
 };
 

-- 
2.48.1.601.g30ceb7b040-goog


