Return-Path: <linux-kernel+bounces-549246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848DA54F95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CF73B1362
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D772116FB;
	Thu,  6 Mar 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRYskNbc"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448D175D5D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276268; cv=none; b=gfVHc28xk1hBlvsRNWOjg5Vg+bvyWJG+vHWoWIQ8/x5GtGCyyJYZP6QV8AdKwKWEXxpRHze1kaGdzAOwkTREXnUZijfD7C8yAxamzpeJijqhN/YoJwvWlARXhDqURTMt/1B4NScUdNTq4nHi/AkLqLM4i+G2zIMknqOjoX2UnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276268; c=relaxed/simple;
	bh=+tMzP8/U4KAu2Jedl6Pv/UjdmDc9hwAIH6ZLozGbNFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agI55xCfob9N6Ki6BJPbrnLbOfetvr2G0pxDRtzudMS8jPYdDmD744ZrM4iN8sOENa+3R14zR5kjfRCdPxvwjZm7AI2szLe0tFs+QK3a0E8NLnks+tIgdfxLO67OVudZHR9QcTBUmLx/IH/sHtjSl6DvU/J4WSkREvIncu0k6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRYskNbc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3cb761402so152992285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276265; x=1741881065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tebyllIN/Zbv6qJSF1gFn0ztQoDPanzaNONkrFerC40=;
        b=iRYskNbcRb5aI0TOVuOq6zWSGMvzSGnD0QaL2TWHuKIAJL+xz6N//zG+mqimioU/TG
         hPl5WyWBZ4/aMjPsQuEVqBufF2zfy9BX6qrp8INHNgY1Ozkpwq1QipfaEcs3dnQi+4RZ
         V/chydMSFMXjadsCMi0sJ+FY3tJkG4qA9rU8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276265; x=1741881065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tebyllIN/Zbv6qJSF1gFn0ztQoDPanzaNONkrFerC40=;
        b=dTuBA2Mv8yRxqrnNX/nusfxdWfn7rIdRk6VejhxFdhef9qFyDxvQTaSiTSWV+iBdI5
         ELryO5tcIyj7s664nYhG5RDtgNWrXwpZfDV+drvDS8tS+27SoBSbxDSTLR48rCkuTI60
         i3luhpiaOrs3/vUlpDLhEjw69pqp1Hs1bjHmPgRKk3if2vrvkS6ynGACCD6RGsGC98L9
         cWM3olDp5vwfPyv7oz7cetCV/Yjj8+5g7ZMmoPAmxkDdRP9qmPb2bO8ayAilfrwtkxpT
         cG+zpoVLfaDwQZg46YgHuM9n5FA/T+4hRuNyfX9zqnW+n2BUdxGRnEE/nJDe63trrF9g
         SXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKN/awdN82QiivFErN7oQfRfPbDQNqWZSWLElcRuyKt5wd6PgYvqMPIbphg4y+R4ZDiv6BD8Jnj1GItY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsaagVtij5cCKxbglwOELwe7otjFgoxHTYLVEq9UlijQ+PXE3
	/ayEQqj9CnoYx/FeUmKebDcz5Nri1PQeJxF8KEe7OfjKE6AccQENIXjq3smj0w==
X-Gm-Gg: ASbGncv49OtIQAjfVjHOofURCwJN0RDbGvTnF0MNNMtdCWniC2uhMtjs0gU5eIfHjLL
	OiUSF8hbOloA5Q9T34VNmIaFzGlumWnuPwEy3rD17+w1MPkE2UTRo+KrpWQ/Lp3/JAMnCc7eIP5
	ClVMeDxODiUHK93b4H/rwlvZcCW4QXAnvJPPQswudPjObAae9qLNZkXDz8sf8p/FYGP3w/DpSRZ
	wV/HFLD97EguGWt/Xab7cZ9+D0BvCdLxb3ixzsqLxg3mIz83ZKB0sZoeM716MPc12Gss82XsEas
	evEAiYP35WdhuIDWN+Ya6taNf9iUrGw09PAWM3k8XnndwbgLBjPSdoCLw0YQSacRCON2NoSvJkc
	k7AadtAeRQ+sFz5hw3Ua0jg==
X-Google-Smtp-Source: AGHT+IH5bWdUn9V+inAAYzX1nFsPFrQPywd00cBMWhKVgBRcwkroYe3aZ88m81OT1RfDwLpdZdOW6A==
X-Received: by 2002:a05:620a:84c8:b0:7c3:d07f:12c5 with SMTP id af79cd13be357-7c3d8e97042mr1392961385a.53.1741276265252;
        Thu, 06 Mar 2025 07:51:05 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:04 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Mar 2025 15:51:01 +0000
Subject: [PATCH v2 1/3] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-uvc-metadata-v2-1-7e939857cad5@chromium.org>
References: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
In-Reply-To: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, the driver performs a length check of the metadata buffer
before the actual metadata size is known and before the metadata is
decided to be copied. This results in valid metadata buffers being
incorrectly marked as invalid.

Move the length check to occur after the metadata size is determined and
is decided to be copied.

Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e3567aeb0007c1f0a766f331e4e744359e95a863..b113297dac61f1b2eecd72c36ea61ef2c1e7d28a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1433,12 +1433,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
-	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
-		return;
-	}
-
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
 
@@ -1459,6 +1453,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  !memcmp(scr, stream->clock.last_scr, 6)))
 		return;
 
+	if (meta_buf->length - meta_buf->bytesused <
+	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
+		meta_buf->error = 1;
+		return;
+	}
+
 	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
 	local_irq_save(flags);
 	time = uvc_video_get_time();

-- 
2.48.1.711.g2feabab25a-goog


