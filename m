Return-Path: <linux-kernel+bounces-406443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC61B9C6064
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1ECBC7E26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866C217649;
	Tue, 12 Nov 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPRopHlI"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15B217910
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432671; cv=none; b=olfqDevF3nyrVlC/SkAh+eK8UDFyQgemxPZWFYTcMCR5+YqrLi/PU4V8c4NBrjbeIQekR+iBfX/bVIroWUtcUkAYHkFq0293oSPm1DG+owVOQBSSyHAzuYOXW4FZ9h9UDEA7ygAP9cxLYr0WzzAbNR1I7SaYB2ogFxBZMyuviMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432671; c=relaxed/simple;
	bh=CF0PcVCnTua4M04sLWha6j2QMeo+m4ojdywmuELEY+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzYZwxO+5aYDOSmCxsMbffUu66LANUk1zt59NDpHTrVACx7I7jrAMizZc7I+4GWYr68P3B0qXyiDqQsI+Edi247XtkYScfxvGXbprEr5q/ODbBeXQwPRXwo2KUdk6W7n7fwf0yknldfFo4A7z+6CNIezI0GriTlsLBa6dbPpxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XPRopHlI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b154f71885so471962885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432668; x=1732037468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/+vpzJAvr8wgPjhYiRpNY0/4wAsydMrSlnQmD5XDqE=;
        b=XPRopHlILGUwgfbzx24q+sYkVTRymVYtYevErZZ4zIOgGIPPVuxno9mfLwX6f+Qt0o
         Kwfex3Un8pvySCaviItqi793AXN6bDIh/BWpcpIShLflIg+WEHwt/2dmxwAe5AoMFgu3
         EPabbSkJN6COW38nrJDQ8p0m7wsSJEWCEcjDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432668; x=1732037468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/+vpzJAvr8wgPjhYiRpNY0/4wAsydMrSlnQmD5XDqE=;
        b=qvCc9nYxt+vywi4lAX4tH5oGD3HIWeopCnXVG20yhB9ZLOXC1MDHuFo2cE1QL60ywQ
         PfOqmi+2WEi1NSMPR1iBdMPti6s8iwuvCb/skUVQIMvwyOFJHnyvVJ/NQ0SfwHRlzjO5
         6ZaRRMY/uMHP8BMmzXeIJt/FWpNObc2bQ5h9InSUguhGgkH0pge4ZD2uRN8g8OeC5Q7e
         MLrXtNCxSW2+gc6RDKnT/as7n1GV3ebO/Z1C5rM6qyFRhOmK7Nrs64mQHyYdUAVsK3WW
         w0Z24kN/chtgnlS/SYo0ZXFUaTVVzmyQGQHPMG8oCKhq6JeWq0ZXiEDsYGmdawUjF5kK
         agYg==
X-Gm-Message-State: AOJu0Yz86lthMwQfnpsKyh+58BmFV0H2mBC3aKEnN2BAXrh/57sNMt6r
	nqT7J+wYOIjReDAf/9qJWs29jFQRbDgHWyyLx6VDkI2LuyMYsK6quDp3oi5Kdw9xdn08b2CK8w0
	=
X-Google-Smtp-Source: AGHT+IH47lPfRefXpsfqCtb8zXDS8+9Rg/9lO7LpzcLke+uf/oVeQcswjQI8bKQiqG3nUIp8e2h89A==
X-Received: by 2002:a05:620a:468f:b0:7b1:4a48:56ae with SMTP id af79cd13be357-7b331eb6c2amr2339676585a.22.1731432668214;
        Tue, 12 Nov 2024 09:31:08 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:31:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 Nov 2024 17:30:50 +0000
Subject: [PATCH v3 7/8] media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO
 entity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-uvc-subdev-v3-7-0ea573d41a18@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
In-Reply-To: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Right now we are setting the entity type to unknown for the privacy GPIO
entity. Which results in the following error in dmesg.
uvcvideo 3-6:1.0: Entity type for entity GPIO was not initialized!

Use the newly created type to fix this.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 7b8fb85d8c03..c9f806bc03c4 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -115,6 +115,9 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_ITT_CAMERA:
 			function = MEDIA_ENT_F_CAM_SENSOR;
 			break;
+		case UVC_EXT_GPIO_UNIT:
+			function = MEDIA_ENT_F_GPIO;
+			break;
 		case UVC_TT_VENDOR_SPECIFIC:
 		case UVC_ITT_VENDOR_SPECIFIC:
 		case UVC_ITT_MEDIA_TRANSPORT_INPUT:
@@ -122,7 +125,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.47.0.277.g8800431eea-goog


