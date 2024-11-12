Return-Path: <linux-kernel+bounces-406442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4F9C5F12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8761F23D13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558C218939;
	Tue, 12 Nov 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMMPzQtx"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB64217304
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432670; cv=none; b=Q6Q2X+OU+g66Y2n3nqnxAhXZ6BgTWuK55X9LsAbEbAqXEjkxbPWuA1IeZMBKW2itVqcAtvUJ7GeERk/Ipr1PZZN8CQbrFHfgszxwyEv6LgaQDBXg6p3hx+lli7deMVSzSWvI0DNfNfSOHtImg6M7WajhllZ1QBw2/g/Oug2pzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432670; c=relaxed/simple;
	bh=PElbl8uW8Fa0oaZt4+kEmvtPpbNU7LixpWE5F/F/xAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMq5UToi7UDADeaSayfOoKJknLzrpdl6MyBuXLjzWjNjn1DFInLlnzZRpZXtQYQSl1rVeKrkjm91e9HIIrrYMsk2djgsI4GF1+rmkmnuBE2IKwauwIxEsszmeMj6VwOLO+il2u3+QbhxZU+gvcHvFX9MaOl7H9DYM/toa6EXoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GMMPzQtx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b155da5b0cso419868285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432666; x=1732037466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P5DVRMjbEuaaQXC+PIiJu+9ELqOWJV7Errw4E0pPWQ=;
        b=GMMPzQtx5jeo66Sffyt8xdT3OfgAfVyUhH0oS1fb84n6oy8N5/PUkSOKcKNZRItFrI
         NsS30kudoPtF8SQdP6aQaZR0dhzAu43fmecp32HS09NWqKgcT+Hugxw0e+flndcd2SY4
         I1MpZRkQwTM03Ca4+mKuzpx08K5vRH1eaCqME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432666; x=1732037466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P5DVRMjbEuaaQXC+PIiJu+9ELqOWJV7Errw4E0pPWQ=;
        b=Vz6GfDLu+riqPti+3w9HXM0Eb2BpR9EoLgncC6kT+FUff02sf6P+OMkDTvCgVkv8kZ
         Jn801N6ghzErxOBb3WUdkxUtvOw9QzGJGGemq7PJxDx7dyqxmUZLPDE/RzpEbySCWTdO
         kVS7TD7uSTQ6+2rqAvmq3so+Wld4x6rhOf4EquSwfHSD6ZjwIpcRzD6vwmrGCmXs3e11
         sIcfiFylqdcTr4wFO37c7EG6f/ro5WyhqZlwNgZ3bFLPGX+DON6Z0DUi8/lpojLK2yjC
         NBDTwdyJURASxm+Xd49siNZrWgHEgPHtk55i4zPymwoLmg3hgHCZ5iXiPIYByvvPbUx3
         4JRA==
X-Gm-Message-State: AOJu0Yx4+/3iMrkd5wCOcVceTRoFBnh9fZ4E2p48SIW1ZijQ5ipk0g+4
	v3DrMEI1IJyF4d4D/CWIu/hg3X4IyCivmgLtiAHOCn6O0Npg4cHj75Lh/qkOSBoHw8ch134/I+E
	=
X-Google-Smtp-Source: AGHT+IEcAtMGtdgkDsLT0VyNL58SyBI46+EinyYYZVvqJr9WyHwssspAfr3QBpctZQDfTxZjHPLGXQ==
X-Received: by 2002:a05:620a:2a06:b0:7b1:51e9:ed77 with SMTP id af79cd13be357-7b34baf0ef3mr325476585a.10.1731432666627;
        Tue, 12 Nov 2024 09:31:06 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:31:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 Nov 2024 17:30:49 +0000
Subject: [PATCH v3 6/8] media: v4l2-core: Add new MEDIA_ENT_F_GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-uvc-subdev-v3-6-0ea573d41a18@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
In-Reply-To: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
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


