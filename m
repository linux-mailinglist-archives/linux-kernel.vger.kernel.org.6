Return-Path: <linux-kernel+bounces-528714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EEA41B34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF263AB7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D168B255E47;
	Mon, 24 Feb 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIFbsBNy"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2331250BEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393300; cv=none; b=SIP7WgA98OWgI8HCdayNsL8U7WSAHQRhOfVF51sS0wE59NNhhzXLzhHsZFNfRd1/GwPQuS4UvdXeWWVT0BJLEJSwOQGBMx1TOxZ8ltppJHeDdZohuEIepiYM/MiXklrJoKMy2EwAh6UpTNVdypyHSph5K4dPkwMpnNs3h34tlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393300; c=relaxed/simple;
	bh=u/iLxXp6y4I0dmg1MjcWvu2lVDGOhwUNjbR8NNG1ZA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqUoos5U525P2iFxktJafIA9or98uXZs6XK2DKRCfckogYWITfCteNMKxhBmxDDnFEh89pf3E0Q6i6R1nEAl8JYOBx9ZkcJKScrrGTtut9WQ2HslhPoSC8BtjPaYD9Pc83SDCbbPBPw+sqSXgqUxDo4J1RlElWg6xYJLOJHWKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TIFbsBNy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c04df48a5bso431601385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740393297; x=1740998097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Xr/sdBG76kxT89n/PMoXH6dcMTYy+77eqKmkJlTkq0=;
        b=TIFbsBNytDy8FcSm8lEgoSgnS01KSuCzz1ekK2ZCJodD5ZpD/ASvxPkei9Hjj/IUty
         zZFR4wp23HFF88tYwtYWIV34zWo1SA8yZmKYnnQZDw/JuX08w1D24+2VcgWlXyMj4Kd+
         V1gbheEyudL1q1jBba4J1ZW6oAe3cdNCz0+kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740393297; x=1740998097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xr/sdBG76kxT89n/PMoXH6dcMTYy+77eqKmkJlTkq0=;
        b=ZyOeJ9ldFGlXQAWW/5eoWQ7OMPJoIGNC+5tPG86Xfw/gz8xxxrT//wSPR5A0l06qgP
         0lUaFFf+KSwC3Fxm7XAkENv7BhOdCLKNs1wl9o5bnAkI1DiGyc1SrLr6TVVObJOAiLGs
         5JU+F9IXUFXqjNXL+jMNw6K0u4lgEoW4/vkq1yEDpV4M2T+mPJqGdhVCs8wXN454KGQE
         jk6zj9xPnIExXk6gjdpz0uL1A56LlfuCUviD4fR1YCIfov5GlPmaN13YwAUK5gOQh0y3
         BnFt9OsFGoipquYbKsF6aNB4hMt4bsSg2QMFon18It97qMM5XoE2Ly76yyhc2ZzPxW/V
         3pOA==
X-Forwarded-Encrypted: i=1; AJvYcCX0szjQu+loK5lSmv4VoMM64S4ILtOe1VR07dZthu74ZdBmudML4xuIpoh6UA4aQa1JR+2GbvCO7HY1ldM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeUNtQCD4tRUwtsE8E7+15k0Kts69vPNcz642CKXzNG0YZJwo
	9euy45D/quKIbhwKxLtD64NXY1R0C5nE1fwZqmvVEC9HyLHnntHbozmVxCqxHw==
X-Gm-Gg: ASbGncvP+uAfblPeOi+5E8fiVkp2JlQRS8i6vfK82dHDTpaRL8aDUT9WLzgycbpKHLV
	IpjK9LKme5t1qSLCr5pW/Wxo5xlejwP12dEr69F7JfrfmR3lyXbrtPIF7WlSRpQSBKkk/0hSxq2
	B7dV3cFIKZGQRQokb1Myi5Vt2+AdxO6cGwLGAyljpCWHqosmJSJ7NvNe1t7PEpZ7EgSwPRglf57
	j/NKYVArL7100vpnL8oDlGsHIxc5EWtknzZWiYWa9VwVeagXEPxxK1whmhOkkt8Yg/88B1Uja3l
	gw7eINYLfIPjqG6cRxTzBAqc/KVInGQrxYnIHUr8iQ0Doh6pW2M5NL56jDN2bUB3g8qRiK8TsQz
	t37E=
X-Google-Smtp-Source: AGHT+IHcApxjU5Byx41ftcyJEbR4mgmWCzGNhIuoy/QmW14XpADFHvOrRwBv2j1pC15dhspgCsTEpg==
X-Received: by 2002:a05:620a:1aaa:b0:7c0:8951:4c20 with SMTP id af79cd13be357-7c0ceeec50bmr1271038785a.2.1740393297607;
        Mon, 24 Feb 2025 02:34:57 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0b7f637sm787139985a.33.2025.02.24.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:34:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:53 +0000
Subject: [PATCH v2 1/3] media: uvcvideo: Return the number of processed
 controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-uvc-data-backup-v2-1-de993ed9823b@chromium.org>
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
In-Reply-To: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.14.1

If we let know our callers that we have not done anything, they will be
able to optimize their decisions.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4e58476d305e..f2484f6d21c1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1846,12 +1846,17 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 	return mutex_lock_interruptible(&chain->ctrl_mutex) ? -ERESTARTSYS : 0;
 }
 
+/*
+ * Returns the number of uvc controls that have been correctly set, or a
+ * negative number if there has been an error.
+ */
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				  struct uvc_fh *handle,
 				  struct uvc_entity *entity,
 				  int rollback,
 				  struct uvc_control **err_ctrl)
 {
+	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	int ret;
@@ -1886,6 +1891,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		else
 			ret = 0;
 
+		if (!ret)
+			processed_ctrls++;
+
 		if (rollback || ret < 0)
 			memcpy(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 			       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_BACKUP),
@@ -1904,7 +1912,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
-	return 0;
+	return processed_ctrls;
 }
 
 static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
@@ -1951,6 +1959,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
+	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;

-- 
2.48.1.601.g30ceb7b040-goog


