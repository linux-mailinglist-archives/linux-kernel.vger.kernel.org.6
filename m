Return-Path: <linux-kernel+bounces-542642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E78A4CBD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF12C1889742
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F466241688;
	Mon,  3 Mar 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMYFchE8"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DC23FC68
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029231; cv=none; b=M+BLLuHbxuqn5P/JMQIKirzMpwlECml0Fw2yVkGZpgzwtgNCgVYp6UObz6Yh25I5PfnoP/4A+xRP9xlqhXRijHStXsSO9Kmhn1EI9x8fLZd9W+gT67rNuZOhij4H8ooAqn3nuHx+zEWiSorojrxdk2BYt2DsGmJEVBF3hkD7MV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029231; c=relaxed/simple;
	bh=HpW9eV+pa9FArjj97V5rJZ74WC3ZIrPxYtpcWzZb9cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0+YEIvytHoGvP8fKIc8pJuELdbYNT6I2BbHO3i+r+gcxdLdpYnPE2YQTRb2mYl4jrhQe6bfLUnOOOP/MZj9FyfYmaQdUKx8DBS/mThaV6dHoXSNietEC1DCuBAwrX8Z+oCkTsTwMeWmP8Svc4HKj/QWB5nSGGfyJWekGq2sxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mMYFchE8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4721325e3b5so40906651cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029229; x=1741634029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90N1gDxhZVWniJnCXj40uTmKdZp7+inJI9RZU73Ve9c=;
        b=mMYFchE8oRivk/EdkOgYNQW5ZQVaZe+9/F7vCDtPSCScQPUL4DY4ZXzpVk3g9p0nsz
         FdHlsxP1PHrchLPfqWVcAdLJ28+/gw2fEeJSmoiN2PH6/UHN/SwmcScMUurmy8pySk5i
         HYMkF2ZFBpIpWlqsD70ycMycpyVYtz5KR3DAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029229; x=1741634029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90N1gDxhZVWniJnCXj40uTmKdZp7+inJI9RZU73Ve9c=;
        b=VB6ysgddGqAvM/4NB4tO4Z64oQimAXZydOjLiDAGQW1ogAECHmaRQKJ89bFYjzekHX
         Qsz0ZpKqtX5gdmDr1OE0odKlF9MpkPnjn63YKxQoyCzh90QoFr19J4cfSm17102/EK/U
         F9flYr3W9qGOMUrSe0tXIrb33KsX/xKNcP/tFbb3NKa6H2OBW+X2Ke04soXyG/3IIvek
         3BDJNWHYZj1lJ58h7qvSbQqd4k4ojj+KBUcL1lVpwqmp6JswJl+V6OB/tGFZRM7Zbl8t
         pL3ePztWNPcRq7e3vV6okghGDi7O3EGWg89RlRWgCpWLDV/tplfNuiKrwO3PiK5xcX1q
         xGEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHL8v02VERa5jwbb2rC6VfzYifuEJT2mjDLIxYxIaODox3uB4tJHPnkOXm3VWStbaEtY8igJIq80kFS/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJo9WzrioeKlagqEeT8WbGzyPqk9laIRCmZeKKXEq8ufIfC+t8
	zy+RGEkcFc6ZrtGLqHeQ+Aq/qOAqszwF6Aib3BeZ6X0jIMKyAZVU7IClIopAmQ==
X-Gm-Gg: ASbGncvB7GWEVSlWpnQWpF1HjdFkkDPmS664B1mvKFXV9hSdpMi9tyagqlOyz1bDm1/
	WtiFqaPC2Le+psncQLYZcv+DlPFguUuoAGHg6iJVXd9+Vj/NkuMzNkEMF+NgOU8hZ1a++9N/IBj
	oBxsEYFqXgAOjpQh1iZTFmzOTNRFSZqM18OjYuYysIXf8MpJ4Wb7CYltmeNfntW355Rbvau4oMD
	hF7i1w/waFlziIrs/E7Vb2iiXzQmNf26XVFasICF5RysxSAajOOlyOpwFIdIWJeXCkdJBRuB3Qx
	lQwGzPUWhKz3FUmseAhuiWB8pBAikiT03ms09kuhzspqRr3DfNxEkS8eIqpCkWTf5G0owHsHrlq
	8crFTVDkIbfJGAaujsKCezQ==
X-Google-Smtp-Source: AGHT+IGnGCMPktiCa57p8eXL0WJuUBj1Dg8JEm5nxeKyFL9/82NaQ4hsJTD+GyZW0TE5wsRVB5/k0A==
X-Received: by 2002:ac8:5754:0:b0:474:e756:fd14 with SMTP id d75a77b69052e-474e756fd8fmr65875571cf.42.1741029228978;
        Mon, 03 Mar 2025 11:13:48 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:48 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:13:42 +0000
Subject: [PATCH v5 5/5] media: uvcvideo: Do not turn on the camera for some
 ioctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-granpower-ng-v5-5-a3dfbe29fe91@chromium.org>
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

There are some ioctls that do not need to turn on the camera. Do not
call uvc_pm_get in those cases.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 6af93e00b304..de8d26164996 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1450,6 +1450,26 @@ static long uvc_v4l2_video_ioctl2(struct file *file,
 {
 	struct uvc_fh *handle = file->private_data;
 
+	/* The following IOCTLs do not need to turn on the camera. */
+	switch (cmd) {
+	case VIDIOC_CREATE_BUFS:
+	case VIDIOC_DQBUF:
+	case VIDIOC_ENUM_FMT:
+	case VIDIOC_ENUM_FRAMEINTERVALS:
+	case VIDIOC_ENUM_FRAMESIZES:
+	case VIDIOC_ENUMINPUT:
+	case VIDIOC_EXPBUF:
+	case VIDIOC_G_FMT:
+	case VIDIOC_G_PARM:
+	case VIDIOC_G_SELECTION:
+	case VIDIOC_QBUF:
+	case VIDIOC_QUERYCAP:
+	case VIDIOC_REQBUFS:
+	case VIDIOC_SUBSCRIBE_EVENT:
+	case VIDIOC_UNSUBSCRIBE_EVENT:
+		return video_ioctl2(file, cmd, arg);
+	}
+
 	guard(uvc_pm)(handle->stream->dev);
 
 	return video_ioctl2(file, cmd, arg);

-- 
2.48.1.711.g2feabab25a-goog


