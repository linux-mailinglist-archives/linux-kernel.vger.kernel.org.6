Return-Path: <linux-kernel+bounces-402337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650419C2688
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5E61F23E83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A52123C9;
	Fri,  8 Nov 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKkj6aG+"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E320B7FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097559; cv=none; b=YDJE5IxhzBGx5WotMy8ZKnQlX7aTNDZ4rchh+LGij+kf7vW+ulBLN0ghviB9S/Xh/6ocu+GN8YmF/EYX3zkWrM4Lr/ncUSz3hPiqu+HhThXVj4FBvhpnQU89nlrBt1yOYjVKKJTNQzxJ8RSjEHLaYlZk+o1totFK/P4G3JGz3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097559; c=relaxed/simple;
	bh=PElbl8uW8Fa0oaZt4+kEmvtPpbNU7LixpWE5F/F/xAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrticl3ZzsPsOdOvqmxCdI8gxmhrsswXt97ewjFXkg39P4J0vSW8eqUXsDmbJGBoggfY8bXezCxnJxB4+Bv4SgDMUVdYX0RHOg92xwpgm/AQ2hZnUN2pJgTYeq4crBLcy3FT2zDuXK/DFj/DIOu34fm/jLJhFerW/rXd384TUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QKkj6aG+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7187e0041d5so1692125a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731097557; x=1731702357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P5DVRMjbEuaaQXC+PIiJu+9ELqOWJV7Errw4E0pPWQ=;
        b=QKkj6aG+9jU6O1E9Cx119PC58TO2h1aKA5anVqpXID6lZiZsPEHMET/qkoPBz3pHZS
         d/P5tDvleUTk9mm/9Kg8L9iFTh0GbgUXUPXaGwM/Ozq09fCa0hLSM4Ur4Xs/NLHb3pOL
         eUKo+56JlTwMRsL4LrhwhxiWJNHMj619W5VUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097557; x=1731702357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P5DVRMjbEuaaQXC+PIiJu+9ELqOWJV7Errw4E0pPWQ=;
        b=kxjlZqKgfn0cNLdKstmSAYmXHVYnCmLsJecrEEOq1NVOLgApWmQhFikf/ZxKQypwjx
         kReYF5Ti7ZreABzMTye8XLrqTSPZeH3wjQyTKzDEj9v5xaUfa5edUkns2q2SmCGXmr7g
         lnOKEisb3XVwTb9/kZYV5jiFpuz8qfznwQdJUN0YwSBCZ+4fhp/L6raK9NO0vjlZOk+L
         06TfSRdXa8ZXtjYfXBQA5taIIzYlMeoq8/adGYT+AeqW6yq5R0gJkpS7dR+gORIb46ow
         FMoRH/IkezNqNQuCmp/qawVHAuHXa3I7z0r70CmYAESwiyAGLH3icdtLs+Q89R3LYhKA
         8kcA==
X-Gm-Message-State: AOJu0YzDhtTgS4mUeBuUq4QALabibXhgsAINeSUdxFYkFVJDhvS5HZda
	ScN6EcJ3hzcTqXxMdyu77HhkSDdxEZ1cPHXMwYMkBo8anEZWY8TAGW5Yye0GuQ==
X-Google-Smtp-Source: AGHT+IGC/EK813LZkTWulIiITX2osqFqScFLwuEM4MPPYy5EEnhNBmWIUGoF8gCb/UExPoL+qBFbqQ==
X-Received: by 2002:a05:6830:4890:b0:718:18d6:a447 with SMTP id 46e09a7af769-71a1c28b0cbmr4649836a34.24.1731097556736;
        Fri, 08 Nov 2024 12:25:56 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff46d440sm24207341cf.52.2024.11.08.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:25:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 08 Nov 2024 20:25:49 +0000
Subject: [PATCH v2 5/6] media: v4l2-core: Add new MEDIA_ENT_F_GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-uvc-subdev-v2-5-85d8a051a3d3@chromium.org>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
In-Reply-To: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Add a new media entity type to define a GPIO entity. This can be used to
represent the privacy switch GPIO associated to a sensor.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/userspace-api/media/mediactl/media-types.rst | 4 ++++
 drivers/media/v4l2-core/v4l2-async.c                       | 3 ++-
 include/uapi/linux/media.h                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index 6332e8395263..7ede3954a96a 100644
--- a/Documentation/userspace-api/media/mediactl/media-types.rst
+++ b/Documentation/userspace-api/media/mediactl/media-types.rst
@@ -24,6 +24,7 @@ Types and flags used to represent the media graph elements
 .. _MEDIA-ENT-F-CAM-SENSOR:
 .. _MEDIA-ENT-F-FLASH:
 .. _MEDIA-ENT-F-LENS:
+.. _MEDIA-ENT-F-GPIO:
 .. _MEDIA-ENT-F-ATV-DECODER:
 .. _MEDIA-ENT-F-TUNER:
 .. _MEDIA-ENT-F-IF-VID-DECODER:
@@ -100,6 +101,9 @@ Types and flags used to represent the media graph elements
     *  -  ``MEDIA_ENT_F_LENS``
        -  Lens controller entity.
 
+    *  -  ``MEDIA_ENT_F_GPIO``
+       -  GPIO controller entity.
+
     *  -  ``MEDIA_ENT_F_ATV_DECODER``
        -  Analog video decoder, the basic function of the video decoder is
 	  to accept analogue video from a wide variety of sources such as
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index ee884a8221fb..8a902fc897d1 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -320,7 +320,8 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 	struct media_link *link;
 
 	if (sd->entity.function != MEDIA_ENT_F_LENS &&
-	    sd->entity.function != MEDIA_ENT_F_FLASH)
+	    sd->entity.function != MEDIA_ENT_F_FLASH &&
+	    sd->entity.function != MEDIA_ENT_F_GPIO)
 		return 0;
 
 	if (!n->sd) {
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 1c80b1d6bbaf..d3d045e52d78 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -84,6 +84,7 @@ struct media_device_info {
 #define MEDIA_ENT_F_CAM_SENSOR			(MEDIA_ENT_F_OLD_SUBDEV_BASE + 1)
 #define MEDIA_ENT_F_FLASH			(MEDIA_ENT_F_OLD_SUBDEV_BASE + 2)
 #define MEDIA_ENT_F_LENS			(MEDIA_ENT_F_OLD_SUBDEV_BASE + 3)
+#define MEDIA_ENT_F_GPIO			(MEDIA_ENT_F_OLD_SUBDEV_BASE + 6)
 
 /*
  * Digital TV, analog TV, radio and/or software defined radio tuner functions.

-- 
2.47.0.277.g8800431eea-goog


