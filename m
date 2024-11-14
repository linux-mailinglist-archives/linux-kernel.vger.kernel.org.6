Return-Path: <linux-kernel+bounces-409263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF29C89C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16907B2A2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01891F80CC;
	Thu, 14 Nov 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N7bVKPEp"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E71FA247
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586680; cv=none; b=HO+hqzmOzkCOFK2YBbg3C7ZNBcqnD3I9gTjCJ8fqSQNsQvd2uzahOMmJhVr3tWXukWUgaTGjgTWMIG+cUX7lSa1/USogX9bzORWXg0cuv2qFTVDdwZl1Rs61DHqgLGpebygC67jSaBDPabg58rjysqQICF2EU0CdTt2+k7hodbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586680; c=relaxed/simple;
	bh=N/GDH2zht3psLi5xuTVskGPxRXYNRZ40VZScG7ytdK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BfOAhghnXa6TFvC5wFujs8HnKAvNOAQQOZWrJMuB2/ZdK0yisRKnHwIWzmiNlwwh1+CN/mCO6ZDwnBuv/XBQZQ5fiV6xDcmZcyI5eZoO94uOdA/foX8AVNtLr0uNgKmZbptXTkGSsg2SOaiOJSlNgP1cnQZ00l/OTSEevrO7KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N7bVKPEp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d3f7febc1dso323306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731586677; x=1732191477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gy1kU2vG7cfktt88URAUukP1kc/UFqp7OEgO6Z8nWEU=;
        b=N7bVKPEpRtjxXSzbdFPGJrfibFjIBLkpRiX/qMs96936YismhlAeGHcVeXlLwnCs/+
         P83I0f3DIfR6bVYScbMGG+vwY7SZdi9DKqOXwOsCQOo2qwph0aYvPNlN6oYWx5aQ+wM4
         cL24cPIjamqnCgxKUFl7/gPEgDVE+502bhqfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586677; x=1732191477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy1kU2vG7cfktt88URAUukP1kc/UFqp7OEgO6Z8nWEU=;
        b=a58zIqu/Tx/+oc6AqdpGUeM52mkxVWUbBY0EadBRCOZjIEbebhUzIYr1m8BT8hvt20
         6zwFrSTMrcZep5EiZbuKc9wpnn/5Jn5Nz9iaC5Bz56yQdo+4KPvhzlWnL2xJOXx7hEOX
         DUbo642FQbfl1sshuBY27M+83gP2saAon9WBflFHISdTT9BEDYnlT2dRIqJz6DvYaD7l
         jzyHdvpXRh9poftwpVpb6fG8tx8t5BQOCczeREqpiBtBSQe3g9VeMlgXyPzxwMCB2eXx
         xDk4YmT7JgdS49oSJifCx20Fq6aWyN9RnUb82KKkH0VsPnymiDMeE5J8sjDfekDKbTX4
         B7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAilqWWEiyJOFN1nyd9T1FDHyDy6uXHPiEy7Em8D2jax05q4rS5HkeGnKSK80+x+ImocbeYR91lEB+SnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscXPYsQFzC8tnpUhkn0UOfSHgJcG2Np6xdVtFnVITcBqFLM6F
	0ICL/4a3SUPgLxeCZRsRqY+svC6sbDEfSo56wTFrqEIGUKRNRuCwuSAiq2tiqXxwqP6zfuG62WE
	=
X-Google-Smtp-Source: AGHT+IGDUkjyrwlUR3/IJ2HW2O28Ckj2eASrYe7mXjDUndoHj4jg90y3NZW3ju/7hwy5p+rqEbJsiA==
X-Received: by 2002:a05:6214:4883:b0:6d3:cf8a:9fe3 with SMTP id 6a1803df08f44-6d3eddd713dmr19465316d6.42.1731586677449;
        Thu, 14 Nov 2024 04:17:57 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee8fafc4sm4715666d6.109.2024.11.14.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:17:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 12:17:51 +0000
Subject: [PATCH] media: uvcvideo: Fix event flags in uvc_ctrl_send_events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-fix-event-v1-1-6c580ccf0766@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG7qNWcC/x2MQQqAIBAAvyJ7bqE1o+gr0SF1q71YaEkQ/T3pO
 AwzDySOwgkG9UDkLEn2UIAqBW6bw8oovjDoWhsiMnhlh4vcyJnDibrTfqG2b61toDRH5CL/3zi
 97wc5wncNXwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

If there is an event that needs the V4L2_EVENT_CTRL_CH_FLAGS flag, all
the following events will have that flag, regardless if they need it or
not.

This is because we keep using the same variable all the time and we do
not reset its original value.

Cc: stable@vger.kernel.org
Fixes: 805e9b4a06bf ("[media] uvcvideo: Send control change events for slave ctrls when the master changes")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e59a463c2761..5314e7864c49 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1626,13 +1626,13 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 	unsigned int i;
 	unsigned int j;
 
 	for (i = 0; i < xctrls_count; ++i) {
-		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
+		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;

---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20241114-uvc-fix-event-272df1585bb3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


