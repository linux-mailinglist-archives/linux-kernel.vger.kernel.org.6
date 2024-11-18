Return-Path: <linux-kernel+bounces-413289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1329D16EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127B81F22DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9A1C3040;
	Mon, 18 Nov 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OE2MIzeM"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00011C0DED
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950221; cv=none; b=a/MpepQ1s0AsumneuDv36hMQZSriGmVWx7+32kBG8MDrDrIk8/KGRAxPH3x10v+WvISIBiP+D+fuu1EK46JMVUawPj6PfK3brFkufs9xOGDx/2hwVkOo2OkO6xVdV5K9uP0dZUzp2Xg2LQMw1Ot9RbqiHu6GmIoR5pG6eHn3Ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950221; c=relaxed/simple;
	bh=A5tEeWedtG0Y+rutx5jNpOYlvPw69q2OPMca4sA4STQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuQqBJDvIpPbBSrRI93fn1Woa/RkOfOSz6h63nmOes/en7PJ1g+C1nV/AgK2AhWj9TfzQLW9E4THEYuHM0xsaOyr9WRBNTHI+x/ZB6KcetS2sqfrxNSvaYAJnPZMcnGtRfGBKssaFNtJNyshbjoJjA/Uz8rQqUaVUCo3gJ+y9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OE2MIzeM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d413def36cso22244516d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731950218; x=1732555018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ30sDfZ/stXUDJszdPegRDEKjQSfHFQOt3ymhmzQbY=;
        b=OE2MIzeMPum3EvO3y/9PueYnRDFwE/miApRewgduRymSNzo50c/q7QlpAjqOO9CRSv
         E/Pmef0Rv+sDN351xDbPKNQUR+iYduZL63OIT1PFByi8iM4PaBCXDV3MOfzIlesdB+XM
         3AQWME8ZIUazUnDYKGGUJRgnKuGOy/7wPGVl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950218; x=1732555018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ30sDfZ/stXUDJszdPegRDEKjQSfHFQOt3ymhmzQbY=;
        b=H58wMugTFaViKV523lHhJdS/vrdOa/iHFs8Fj3ITmX5Z0j+non460ak4rPQgr5kZzk
         QY4csu00FDU/QQy9jqsm/QfDrV9SF0XnmL9FEGY6BUYghprF0Oti6d9yPC2eMEZN/f1J
         qWo4CDL7nglY4fGCxHng/oCrsPRU67nP2lFu1tP9NnWr9wjI6ykYs/ujZhK1GVwKMlWy
         z9rGtQwWEwGS5vaI1aJG4ANVIr1MmigrDfGEtk+TQB5XKbU6Noiyg61oAJE7thuQxin2
         m1pbLKkLFjuqZY+uAKOEh1QAd0np/Bf5hOT4Y6/Z64C5pZQEpKm0C5eyfpXk1lypDdkH
         qOMw==
X-Forwarded-Encrypted: i=1; AJvYcCUa6sQ21qTCSsXVgbT+enLykd4CnsjM9V/zvsZE3AQ30NL8RXyGWMxFitfMkMqVLFUwxpMOjkEKW/jgLKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJRENVWWPeCK6bsdiPp8sW8uciRBYt1J7gQc0C1MUTLfCOkLI
	IfHINkr86VF0Mi87t/HpofJSTY6W/NHRo333zvcUS5p2qai1/9hkTu9uY4n4ih+2i9gGqSfTJig
	=
X-Google-Smtp-Source: AGHT+IGaNZV/qqJqHa4tiN/uf1zjGJjsroAU+mlkDujCrCE4+KZVeNFgCEheZGGSpyliMGY3+QOMAA==
X-Received: by 2002:a05:6214:3387:b0:6d3:7f9c:9e51 with SMTP id 6a1803df08f44-6d3fb7ed418mr178431086d6.20.1731950218592;
        Mon, 18 Nov 2024 09:16:58 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd733c3sm38255246d6.97.2024.11.18.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:16:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Nov 2024 17:16:52 +0000
Subject: [PATCH v3 2/2] media: uvcvideo: Add more logging to
 uvc_query_ctrl()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-uvc-readless-v3-2-d97c1a3084d0@chromium.org>
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
In-Reply-To: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

If we fail to query the ctrl error code there is no information on dmesg
or in uvc_dbg. This makes difficult to debug the issue.

Print a proper error message when we cannot retrieve the error code from
the device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e165850397a0..0195394e10b5 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -110,8 +110,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
-	if (ret != 1)
+	if (ret != 1) {
+		dev_err_ratelimited(&dev->udev->dev,
+				    "Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
+				    uvc_query_name(query), cs, unit, ret);
 		return ret < 0 ? ret : -EPIPE;
+	}
 
 	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
 

-- 
2.47.0.338.g60cca15819-goog


