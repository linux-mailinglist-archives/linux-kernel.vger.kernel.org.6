Return-Path: <linux-kernel+bounces-542641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4376A4CBDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE937A4F59
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21932356BB;
	Mon,  3 Mar 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7kUDY+4"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C023F294
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029230; cv=none; b=HwQ12z9OoCZrcFtwZ2nJztKmhtqjWsXeda85jIWOG5EEw8AAhEZtYJE5xOc8mvHPf+r22vao4NfQii7bOekJwpeqBeQjz6/hBDpauGjkMuBBVK3tbbZUc4GpscMGmX7lYce6+D4KK34rkzHny0aVa/QxK2eliBxxYCUHMJbD+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029230; c=relaxed/simple;
	bh=lPK79adRklZww3Mk0PpdCX4VtxZROHYG8wz1+NxPpgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l474vsCThNkwdd+kEdbliVLtci0XSacdYkYxLPX/V+he0awGkNGg8u6CjLI77/3fp1gE/g7e39Vts/OGCDIQYt0zeYTaf+kwH+0tVsfVPx6QUO1u1Ir4sCL3Gf8i/zF8DXqnrAphqLRi/THtxivLUwtV27/t7h499zPkvs4G6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n7kUDY+4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-474f8d2f21aso5478811cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029227; x=1741634027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ikl6DD5slE5XP2vR++WylhZuHcrlQkez/ZWPWDZyaCY=;
        b=n7kUDY+4yxo4abB6YEk0kxuWQbtWzhcuZvJeRIQ0cHAIG1kiHz0pTEk9e2/bF3dGtA
         kDrSV2qa3Pe1F2Bn/X/Ss36s+g+1yfoBkIooZU23YFhNii/MJaU1oDoM9JIYMzFd1MXg
         BwyPHpCHs9ihnri1i0mucx7SZWxWlF63FgU1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029227; x=1741634027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikl6DD5slE5XP2vR++WylhZuHcrlQkez/ZWPWDZyaCY=;
        b=ZkzmQDY87SzetkN2CqLUCwPXTAA9heMtU0gXAeXNLIrKO1sO9AELgMBdywIQeFbWyB
         /ZFsQQa8Qu3JBe+dh9IWr0pMLcSP0BDxwlQmqAHY0qlY2erVtgtWaQbAkecCQ+hlFugu
         692+gFiNVrQuucpSwsbTjI78/32GZNxxKojo7X5/tY5MzEpzptdmK49IGavwIyhAzQSG
         VNU5MhuiQYTyqepdtzRQp+WTVcvpI9SbLbLQnOfCANdY+XpYNCfoZjsmZt9zTVrbIQCW
         rDbXSAIpXIWxo51aTpTigcI2WB8nxUh/ntbmoFnbq0CFt2IqURBIY1/6AzLePafxm69i
         DRXg==
X-Forwarded-Encrypted: i=1; AJvYcCWrmI4MYsXflrHnPmuA2r7KQV/IWt2+JkedgP0wdliQTiD3+5cAOjdSoJeN8ZL7X5Miyhvjut3OdEDBn9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdppr/uISqCNNtmk1yhXP1yVQhgEy2ZJVhy73ANGz0WcvvCc7
	0SY/r/v98aMQYWzzTaWOFZ2tSJWQeU1o16wnlA32lEjk6KZH4WpayFyCycy/cA==
X-Gm-Gg: ASbGncu0fIlU4Xznm1ruO5uc24MUYcls19QBotl82wND8tcB3D6wS8rOutRr7+gD5T4
	BkXSr5McBAxsRJWJDSBruFe/x1Oy/hgLuuha7VJBLdUbdtvxRSwlp4vLSyIDw1pVD7qN1SpnncF
	EqMrUMDnaLVhLTtuwVRaoqV4y3gyuw4aMLNVkUvjZYrfgeNzS0R4nF+6bAJvZ0NR4ovnM0WBoaU
	yCotG71isi8VRftNNkAc77BNAbWpA+alphsksMiu+4Xrw6TmzXUypQvTpwg2rW/iN2+dl/ti6W9
	Znh2A97Bk03hmqZpvfuEhCQbiRvlw6E2gsraree74LPoXB3+xmet4eYw2AfTvcVUklQb4MU7haG
	A7PdOBRD+vIZv5O7ksp5d6Q==
X-Google-Smtp-Source: AGHT+IFHbTUMUMAOtYe4aIC70aHDkZKC+eDmzTxeiVMALjYKfsCeCsempFPzl8+QoqwoKasS5kDgvQ==
X-Received: by 2002:ac8:5d8c:0:b0:474:fbb4:8f7c with SMTP id d75a77b69052e-474fbcc549bmr6415241cf.11.1741029227080;
        Mon, 03 Mar 2025 11:13:47 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:13:41 +0000
Subject: [PATCH v5 4/5] media: uvcvideo: Make power management granular
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-granpower-ng-v5-4-a3dfbe29fe91@chromium.org>
References: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
In-Reply-To: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

Now that every ioctl takes care of their power management we can remove
the "global" power management.

Despite its size, this is a relatively big change. We hope that there
are no size effects of it. If there are some specific devices that
miss-behave, we can add a small quirk for them.

This patch introduces a behavioral change for the uvc "trigger" button.
Before the "trigger" button would work as long as userspace has opened
/dev/videoX. Now it only works when the camera is actually streaming. We
consider that this the most common (if not the only) usecase and
therefore we do not think of this as a regression.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1c9ac72be58a..6af93e00b304 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -652,7 +652,6 @@ static int uvc_v4l2_open(struct file *file)
 {
 	struct uvc_streaming *stream;
 	struct uvc_fh *handle;
-	int ret = 0;
 
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
@@ -662,12 +661,6 @@ static int uvc_v4l2_open(struct file *file)
 	if (!handle)
 		return -ENOMEM;
 
-	ret = uvc_pm_get(stream->dev);
-	if (ret) {
-		kfree(handle);
-		return ret;
-	}
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -701,7 +694,6 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	uvc_pm_put(stream->dev);
 	return 0;
 }
 

-- 
2.48.1.711.g2feabab25a-goog


