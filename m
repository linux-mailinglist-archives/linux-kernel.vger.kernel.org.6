Return-Path: <linux-kernel+bounces-425900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2418F9DEC60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BEB163AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB671A9B31;
	Fri, 29 Nov 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMOK2cgK"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AF1A4B69
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908316; cv=none; b=cKtyVHQ9gzmB8QzZh7E3mYIO32IrzfGfEpmXEAzJcRX2KtDVfeQb0UgiPnv6pkpn+OfbLdLN8/iUEmd4yY5aTQIj18reUuSLkp885pV+lW+PutCVDU80ffkI/bevjQxwdnQB9jRCfOtoKAF+vTIq+MZ/ijrj3ecfbKjIKgI8Jdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908316; c=relaxed/simple;
	bh=XUx4menmu/stFBE7lkIhaln7CdzGv+6pSaMM952p6qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7PcU6uhH5+PrOui7iG8TfpK7liIx0GjEoGSw07y7aVzvm0TkTykb9GgpbE0n7E1IedfFkJ80AiUY6cN5EvlXNQKxpSxLRqlJ3gG4bFcM8xqVE6xIq3TiXHpAK/ETSmUexYVf4+BQgEHtRD0CPE6unnBo9DPPnX+8xMzyH/Z02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jMOK2cgK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d849a93088so14256746d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732908314; x=1733513114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nl7Ezol8cCw5t0X68ApdPTyYZfINMaJDWIUvhxei38=;
        b=jMOK2cgK1OgEAg333gdphos+z+XIFir0okfHis0x8hV6M/xeXxy/ThdYgq2XESgGjz
         gFNjEkjNV2jvyLMCGixePiIQQ1eLdZsYsYHh9gzjJ8ETm0r36khHnAgKTtLETs9qthJ7
         fN2gk6rbGkjy3BNTg/3GeKsflsCUbhq7D6/iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908314; x=1733513114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nl7Ezol8cCw5t0X68ApdPTyYZfINMaJDWIUvhxei38=;
        b=Gm9WAYspMC+bfuxaqp6LZjH1jalOiepykDOcTzDANpZznIL96ccmVwC2ufQi6M8ip/
         EwF9jn3QnFxrpgg58HsPH9FeAsE+8N3r/N3/vyGPPnv9LBJg5+peH8f1MnAISbWDMAq5
         C3N/d6zq08Hrug2LMT+Gf2P8sXL4rr3FX80wfVJ5TBJP0noG8FJFKFYX1AQaDiMHiPB1
         sSkAzPSTamx94AbQLidT8uBlHDEW7K5H7OClEF4csw75cWUzHWJ26AGuwWDbV5qoNw1S
         bk6r2x5m0TCDKa6F4ezGMkMOgtLXLh5HIGqZn4uBOLWjdryUGFxflxZQXRBM6jG5txfg
         xKng==
X-Forwarded-Encrypted: i=1; AJvYcCUPSWt79OgqxqX7wnKIhBoK56lta9uFCDvIIFrNWI83Ru8tr+dRu7EKmDT3jlHJFI0szlMDiTYsiGRcaZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAKlMcLR1EkHbpGTtLMT4l+WiLuqk5HF3i6YhKRYO1Z6kK7rM
	cfz8KcHI7xnVEARplHM/Wj9sytPFldgS5XqcL6obIf5tFX8FvvoyVW9c4dkksw==
X-Gm-Gg: ASbGncsG3ztPKV2XZjGpzNwam0fPKTJIykJAo/ihdKlKU/16uf2XnSpr5QfTkLIsx7r
	8ePxwQhRkapJJVCZRIRDRVh/ZpPBzVYVq4SmVUF+pvgJfrz7O7GQxSn7Cy1p0rLQuXwgiftZisT
	H30JP2jK63IxdtnIeIGtFAsGS24iIj1mjs25qyI1fBwb9L/vz5ZQG39SqMgRwb1aNFm8PF5Jvtk
	YOWODTpQBofsKabxXnISb430iQJCqZDJWxTHQpL1lI+dnhRbr0wGspZtgcXYrSfOvJYWUlSOpSZ
	i4uOYrWGDJOtJJD6GOpjTgzL
X-Google-Smtp-Source: AGHT+IHjqJRktZLhz6NaZh+WfbURnZUbAXxMRHeD7FdgtGCNkYRC+4y7nJMCRQlFRwuCpsM1e0G4OQ==
X-Received: by 2002:a0c:b542:0:b0:6d8:81cd:a0ce with SMTP id 6a1803df08f44-6d881cda2damr54003696d6.43.1732908313864;
        Fri, 29 Nov 2024 11:25:13 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87d899ec2sm14462146d6.50.2024.11.29.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:25:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:25:05 +0000
Subject: [PATCH v3 4/4] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v3-4-ab675ce66db7@chromium.org>
References: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 1b58e558604b..2d984060654c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1657,10 +1657,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
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


