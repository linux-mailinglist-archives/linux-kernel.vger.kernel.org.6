Return-Path: <linux-kernel+bounces-390597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F79B7BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7668EB21C70
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DA1A704B;
	Thu, 31 Oct 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Duepzyif"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B341A2550
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382209; cv=none; b=Pkjxz0YLbysx6IZ+I44wqAPEG8a5aozJoFM1L1y881bpqhg+b6ap8h4jLyxkznedgp93ZGaI1FDby9an4Ci7A56LYmGFiCiry2eQL/dXVC+cRD5zIx1OT8dU6FEiG5gQC0tOeUccgOGAgrvliNAhL88TikjrlaVhsPh0JKzRtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382209; c=relaxed/simple;
	bh=blJa50xw0lKvopXaZAiEuV1VgzhB5oNeTs67sGqviXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAiKWChRtUsGsq8ei5FOJKVoUQ0sJNc254XnVFInajiPai4sLJU976HNaf5Y90kevSS+zy9whTQ2GX3q+oTEanQe8fxYpeVg3iv+naTq8j5L6MZk/nkzLv9H/oQz/yQVjbFSiSAnWTwo4xGXHNEj7DI4g9ZL0FkCMLHqsLGNuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Duepzyif; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b155da5b0cso66240485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730382205; x=1730987005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daIxjktyxuG2VDq53N9YeRfidBwsAYBDLHTz0c0/NdA=;
        b=DuepzyifCKYIt2owSji5xtsnqHJL8zeESEqtekpBWyqEN1G56Vub10z3rSZi/WkqAX
         4QTzhUTd1ufhJ/Yjp3f5E2cY1UpwYcDJM9EKmXA3KBLyxn47x88wgBSVQNpiWbWh4RSh
         XEsvoMotnO+HNJ2cTMeXuavr2z6lUeH1hE+yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382205; x=1730987005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daIxjktyxuG2VDq53N9YeRfidBwsAYBDLHTz0c0/NdA=;
        b=YU7oHnPiyMEbUdI0EV90Lsx63F3yf67+Zb+5gMuu9ebvuJMYjzL5dinMxvK7NmphuW
         AWsHmYm2t7Yq3FKjWz6lnUbmVkmQ+Rapks6qiJjLvxyAL4OhH0ZTx0Qm4/r2WXE5snnk
         0WdAzQd6AbsBVvlDyL/yQ+QDVwz1aWmgKIhaUL23l8FmRc3dW0bN1e+0KBR/V4p53fPD
         FRbU2hNzw5AC2iZIuedBL5qUJhJzrU+SsAT8kJ8+jBhzehoX+KBHNXRdqPZEtD8lWwa6
         76FwMGi/jvpba3VjPOQuQiI2TNZuIFn2H0+JvoxMhHHrMY8JcQSIYvDRmcIvmVNk5tvz
         KtcQ==
X-Gm-Message-State: AOJu0YwuGtoWAIPOaycp9uvYqLnQ7hSjLxyHnmJSkk4Lm5MqXU7inZ7g
	7NxkUSoeYuGOeHdnmBUQ7R5npKfV0LFEw38VPe0X+vB0Hq5oLhzsBV6S87+Akg==
X-Google-Smtp-Source: AGHT+IG7Pr+EQGs4svOdqXUCFGOmSkeTMmvCRbqYTY2HIOLnsdesNRsmZ1TW0g4y8DD6bLq9qYnE3A==
X-Received: by 2002:a05:6214:3bc9:b0:6cd:eeb4:4f73 with SMTP id 6a1803df08f44-6d345fc8799mr93692756d6.14.1730382204713;
        Thu, 31 Oct 2024 06:43:24 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177d2fsm7837776d6.107.2024.10.31.06.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:43:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 31 Oct 2024 13:43:19 +0000
Subject: [PATCH 6/7] media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO
 entity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-uvc-subdev-v1-6-a68331cedd72@chromium.org>
References: <20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org>
In-Reply-To: <20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
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
index dad77b96fe16..3cb95df1f670 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -114,6 +114,9 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_ITT_CAMERA:
 			function = MEDIA_ENT_F_CAM_SENSOR;
 			break;
+		case UVC_EXT_GPIO_UNIT:
+			function = MEDIA_ENT_F_GPIO;
+			break;
 		case UVC_TT_VENDOR_SPECIFIC:
 		case UVC_ITT_VENDOR_SPECIFIC:
 		case UVC_ITT_MEDIA_TRANSPORT_INPUT:
@@ -121,7 +124,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.47.0.163.g1226f6d8fa-goog


