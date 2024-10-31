Return-Path: <linux-kernel+bounces-390595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92559B7BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D8F1F2215A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554F1A0BD7;
	Thu, 31 Oct 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zni4pja9"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7C1A00C9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382205; cv=none; b=cfTX4IXofONmee79Pe64uwcGlbsGxTO/pPVMhGfkBwgVcioI8m9eJfVfR3wjRIW9vHHotxIRlUE49ixjuVwX90edCdO5cUKfblg/yHGML1/MNxKUKCOdymRXhd74OpGidn+2JM7/foNy/ygl9ZB4JRh2CjB/BdrH5jyL2OViDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382205; c=relaxed/simple;
	bh=Cmze8r3g0v2icURj4HJAeixp7Fu1vBhNkAGZdpuZMkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQJQLLK5P/P+VN8e5w6P007jWQ9J5MaMy11Q5+sC1jSiZ+MSeC+vToTQMqVFRlNwiOJn6jHpQQCvlo9Vq3CO8rKVhIZ81Dc59GsliSM8W1W64F4n7nljSn9neuFQPk991lU2Tb0Pgn7szx9o7kyDf1ok7Tzll59shyO4dxYAxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zni4pja9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1474b1377so65011585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730382202; x=1730987002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ+e6C6+GSrAnIb1/5IVMUrH4LpoM+FfmfvDlsPOksU=;
        b=Zni4pja99y5+L1/OLEQsfYmP7JwhYxDiqM+kGxWE/2Rfv/cZu1EwazYLQf/oDSZrem
         im1kgRxCpnUcdROvQK7k3ii7O1uFIGCeL4OCD01lCeueMWLCZ9AvTJCXD+uTX9TCLViZ
         6XMKjGazx5TtsLW5DJKooqeJffcOKE/oSSEfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382202; x=1730987002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ+e6C6+GSrAnIb1/5IVMUrH4LpoM+FfmfvDlsPOksU=;
        b=rRh6rlfLKVvWpI9clas3Yvo7slxMeVLG/2T+lNy+adx5MpSkaCIeunTBZmKGIx3Baw
         aLbyJG6HVZNiR/l2/KXkd2ev83kgywXafODUkIvNZsCIxLxR/Uv6wIhVBMEt4wUxRic7
         zZqsPgpbFz9nuDiiEwlaDu7elVozUbhvzwQPb6cLHoAilRMwW+TtDRtAY2+y4R3K2M0q
         8c6T2MFRSvWzwexbaQsYTN0c9FSbfxM/sse8gJh2zgCsACze+WMCHhcXiL7gyUj7j4KL
         rlSGV0CJPKvlKUjAeHDgJKODHsVZHxtyYe8gL5Mag67tZbTQNLoUmbwJ6q7qPNzx2dQk
         qhEQ==
X-Gm-Message-State: AOJu0Yzz62Pd5xHcbxHB4kHYbHZi4jpQUml/jJuSODZ9/easRm/Vh0dj
	1vHqcai7m90JDC5OvH2JtE2nSupgLLlrNnUp1xkTwjb/P/sXvYtMVA/WL20nlQ==
X-Google-Smtp-Source: AGHT+IFYV2lrgriqNv8NBVIjXACfwQqoXY3hpb9ZeqjxeP58kyKKudAiPp5NbglODhq91Oqx814v8g==
X-Received: by 2002:a05:6214:590c:b0:6cd:ef7a:8c82 with SMTP id 6a1803df08f44-6d351b24ffemr20012896d6.41.1730382202571;
        Thu, 31 Oct 2024 06:43:22 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177d2fsm7837776d6.107.2024.10.31.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:43:22 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 31 Oct 2024 13:43:17 +0000
Subject: [PATCH 4/7] media: uvcvideo: Create ancillary link for GPIO
 subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-uvc-subdev-v1-4-a68331cedd72@chromium.org>
References: <20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org>
In-Reply-To: <20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make an ancillary device between the streaming subdevice and the GPIO
subdevice.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index c1b69f9eaa56..dad77b96fe16 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -53,6 +53,16 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 			return ret;
 	}
 
+	/* Create ancillary link for the GPIO. */
+	if (chain->dev->gpio_unit && UVC_ENTITY_TYPE(entity) == UVC_ITT_CAMERA) {
+		struct media_link *link;
+
+		link = media_create_ancillary_link(sink,
+					&chain->dev->gpio_unit->subdev.entity);
+		if (IS_ERR(link))
+			return PTR_ERR(link);
+	}
+
 	return 0;
 }
 

-- 
2.47.0.163.g1226f6d8fa-goog


