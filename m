Return-Path: <linux-kernel+bounces-427686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692B9E04C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C255283C96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D2204080;
	Mon,  2 Dec 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jl1mVenA"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4775204F69
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149484; cv=none; b=UWsD9u7C3LVRQanS0Q8Ai3YrKWS/tlV4doVvE4au/bYMa+CLfc/aRqeTglPFD+cTEg00k8XdG1/8VkmLkys2k7QyVdojtivy4kvYqtC2HQrvsR7naLnU2Lct7sHexFlM1tsQXWDQIM9BCy2/mLD0PXFutEyAUXtok7Xz7j7lo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149484; c=relaxed/simple;
	bh=JIoL17arYYY+WJ1P2Tyw3eLMLkgho4uZtx1nVbBKRgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJ9tt9fDldAR0j9twpQlxc6GRVUU6Lj989aG0GjL8aJPOj00vdiCysWPiX/LnXu6FeHMpNrQBfbDarnNNlwOyj97rhEVxjEnXsmRg7H5xz5cU06UOPYyvTu3D+kZdU+6TM1nLZw+jrQQpfDLHAxZ3a1KjlraZf3VIztdeS/Eadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jl1mVenA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f1e7639391so1342479eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149481; x=1733754281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlS6BJbN8gylinhy8s0wE1xSPoRGB+PwrEezFLyVemI=;
        b=jl1mVenAXrfFRzW+U6Kt/gnG11Cn00pN+LhtZ9qNyrBErmT6NwlAPz7lEhwrpvdbT3
         AbrW0A/RR9TE73Tu1Oo4tqO8ta7WGOVDw29s7AlCJ99IgIduX35Z0mameiVcwHuoXSTs
         cf/n75bV8rSubbU0zz5+60r1tiery5qoSo9ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149481; x=1733754281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlS6BJbN8gylinhy8s0wE1xSPoRGB+PwrEezFLyVemI=;
        b=LqjwE/cMEo8Z+XKoLMyauqT22Gcwz9RZbaFFFPJouDL48IIpA0yWyRsrX8TiNwpHbW
         I9lNZvtgb4AYpQhSNLURmVvaHkt94lGXZRbSoa1MbxDi9TGNT6MFKTJ2Uv8rqu2KVE5W
         B2mrHKtoqQrQf8/i6wGVzBv080QsfKiznKP7MzydHdd92DYRFkGzcNpP+mBr5wdsY2n8
         1cbS26h6a8YRHUest0NsqZrb9mlgKuXHTP5DvBsJfCE0UKK+DVktkEUQ+5W9QKOufl7F
         k5nR2kJXSeaI4H0zy+g7ug2YmGnbgYT2pZA792N0QaUAdpGpG/65fc3OtrttmxgoMTMX
         88Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVANsE4KIa9qeHB/h+wPgQO06ZiCJWv/MhjJ7/hWRz7vmqxnXI4nT/+g55wgsWq+6EUL16HdzihYUPf0bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTwJFIQIYsXRKJf8HCxVnlDSz/INw1hldLx4eQ7huqKjtbwqQ
	UPBAx96bN1cNcNjWUXtOtmVw7gMORqhj8qcIc/5S5mCkXH/WDMq9eB8UBXOc4A==
X-Gm-Gg: ASbGncstndGR1r95vrdM0m12sbAb1m/9tc2/CB74mrKbsEDZJtES3A4t+luVkwZWz9y
	yskxgUI5BZlNlIc6hJAnmMJCh2u26y+hNziGJJIETSp2FQUlzUvefMM4hHg0m3xoXTIkO9ZUOVz
	a2TyNZ1zkNazmtsR6vbRTWbKpcXfF7xh6dJcd2y8yZCZCZbPUh4kiDOudoiDSIbMQJBGlaxO+5I
	HhqL/UlpOos6IpxWeLMqEONUsCeqLirgRZFKXdNjxDzLKkOoTuMeIPQmyU+5NyblcYEGUUlMqpu
	EB5vZhKOsaJbfXvEsFvOnGwU
X-Google-Smtp-Source: AGHT+IHf7xfPeTnIxhLY6p/5p9023eGvkBrVh98IJJaw48pna5VKZ8hh5eZx/e2fyBNDJsz/FgZFPg==
X-Received: by 2002:a05:6359:7609:b0:1c6:1d01:9ffe with SMTP id e5c5f4694b2df-1cab15b6233mr839794555d.10.1733149480869;
        Mon, 02 Dec 2024 06:24:40 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:39 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:35 +0000
Subject: [PATCH v5 1/5] media: uvcvideo: Only save async fh if success
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-1-6658c1fe312b@chromium.org>
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
In-Reply-To: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Now we keep a reference to the active fh for any call to uvc_ctrl_set,
regardless if it is an actual set or if it is a just a try or if the
device refused the operation.

We should only keep the file handle if the device actually accepted
applying the operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..9a80a7d8e73a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback,
+				  struct uvc_control **err_ctrl)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				*err_ctrl = ctrl;
 			return ret;
 		}
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			ctrl->handle = handle;
 	}
 
 	return 0;
@@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
-					     &err_ctrl);
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback, &err_ctrl);
 		if (ret < 0) {
 			if (ctrls)
 				ctrls->error_idx =
@@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}

-- 
2.47.0.338.g60cca15819-goog


