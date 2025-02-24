Return-Path: <linux-kernel+bounces-528715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B503A41B48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F718992EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEC2566EF;
	Mon, 24 Feb 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0TB+K5h"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413A255E4F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393302; cv=none; b=u2pMGIoMKFFDkx9qadCgABzqJvtnHhSiu5PVJUfD1yJ+uhxRy3Q52X0Q3zAuibaWgYV7NbYMngUYm7jytfZiXLzPT5uhWC40Q9uAOUwP2rrsPM2x5vMSE0/q/QvFMOEzXtaMwBFNClSW0n06AJGkWEme6yuiZEaG/uCeHv0CNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393302; c=relaxed/simple;
	bh=sdce7IzPAWOPBlp9w7GmVc+7zDnqq6RpXhnvyRYvo7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISBkqsa1dYgpq3cauGYYdfKbVUNvCfBHnnJWfzKIJq+g5WtkUJLe50d5RguMmypzGZc16D+gODXUecSIpP8H8pTY2n/dNJiFQrJCatMpuecnhXGAHUDIFH8QOl4wNphtgEroqrvosJaweO1iNBlPouxo5p3kfqgRbRlu1Sbk1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y0TB+K5h; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e69db792daso36479786d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740393300; x=1740998100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDBMWb4EY7onVf4QJeXNUmC3vcoRuBZNuT+yUekjkJQ=;
        b=Y0TB+K5hr1/STb/e5hixDLC2vrICvzhpRLWqDsS7X9ct86uI8l6alNgv3WjIQwa9rk
         eajzU9wXDek99rclw5qfcZ15aUsHvYJXy6TnLcii4nrCqi6Q42td2nP5NajYWN2JWms9
         dpuGxS2ajWAjxSqrpZOG07jcwSXUh1td5VfOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740393300; x=1740998100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDBMWb4EY7onVf4QJeXNUmC3vcoRuBZNuT+yUekjkJQ=;
        b=VC48YXhdsNg1zGh2tYysO4zIodjUIQf8dU3veCvLxF7xEeETm0vKSW6TXFGlPk30z8
         l/6PvbESwSYd8F/PVMF8EYURoRPn+T+b6Gkt4LpE4yju4BObrc5CdOqBKjqzHASiUrJz
         zL8PMwYdR0VSdCVoAnjRqjYVHOHX0VuvP74HSNKfVCSo9RXiW2DGuZCiZB01/jS5fjez
         i4lWtMPDPWn96IsWNt6RqlO6XxGpveOMaxWZj+MMKzdGnonxc/W+ErUIymKZmkrcMQh1
         dZ76p0C8lWpFIsaofwvJOm/9PFinn370zsbvuD7OkSYiPgDC79lzgEqtWiu0CFpQDk+t
         cM8A==
X-Forwarded-Encrypted: i=1; AJvYcCVHwRJyEi+kpWNLr8YKTlnT4uTmgWn2Dl0M0nSB9qqIznPduaC346VdFBnjdYkWziOFhj006lbWC0pHjSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxqb5beHXdtle04Or4wtJc1E7w/TPMyBVkE/oXR+jiOxlSKGgl
	VSTlXoHPQegzlSh9OVBVXw2M6gc7vSfNM4plq38dRJemoC8JuwtlojOgANn8Ww==
X-Gm-Gg: ASbGnctdGVqz3eqme3FlPWc5SuZe98onMS572ivuTAlwxDEHSM28q91JuKl/sMU9qNd
	82icPvHUs54+ptjIbnYjW+KbtLhhxrlu7BNkC0fNs+Y00Jfm4+hnqC4tl8XWbafRzAtkJ4glYPI
	KVSv28Bu/SAxrJMi9vMjxk2LTiJ8F9gOx5rKkOLts9WbVVkjbd1xb7d2i8YBM09TgC32QYq4696
	AGJN4knJ7mGjIC+aZZPT0g6IbftA5n89EmuRVNnnmeUgk9vVKKeePnBsK5N4UmZo4Fw/EVmAxva
	9uWO1NHb1YM0AUygBPJd+96J+GNClpPB/6Xifq1b7dE1TrwpJ5ZmHYAFxf9nF6w+7WX0QGM3XBA
	6puc=
X-Google-Smtp-Source: AGHT+IFL2G6nlS0x1tvmzLvi/Z81P9HYgn38ttQ4HgDtQAzXQAOsKOTGkfcdbCKeON5iaFKLYPwyeQ==
X-Received: by 2002:a05:6214:e8c:b0:6d8:f0ba:ea92 with SMTP id 6a1803df08f44-6e6b00fca57mr166811326d6.21.1740393299864;
        Mon, 24 Feb 2025 02:34:59 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0b7f637sm787139985a.33.2025.02.24.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:34:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:54 +0000
Subject: [PATCH v2 2/3] media: uvcvideo: Send control events for partial
 succeeds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
In-Reply-To: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.14.1

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f2484f6d21c1..7d074686eef4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1705,7 +1705,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1716,6 +1718,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1954,11 +1959,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);

-- 
2.48.1.601.g30ceb7b040-goog


