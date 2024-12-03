Return-Path: <linux-kernel+bounces-430219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C09E2EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653C5B34CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAC20C012;
	Tue,  3 Dec 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LyCfcK68"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42F20B80B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260831; cv=none; b=X5An4prvND62JS+qbwvdGLlSFjn02qNFnQWByxlG3MN7nbxGXRzW97oInF/EcYEdG+kg1WCf8GPJr4JcWxI1St2pS/aNtp667t9iM9EXyIN/7W7aKQRiVg8HZXtAvdx60BWf3Aok1GZSdtHKTo9VDwZd0ymazEQznm6IZbjk5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260831; c=relaxed/simple;
	bh=jFTBG9LprJIjbHQlM1I0RJN2j3CUZpzoB8yyx/zxbSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEjuKvMGwLXiiZhvrCJKoNa0jAfVmzNVaKzqFJgmyorEIdO6gIIMgASq3lAWEfKw7ssLfFLIyT7zAf9r0rrSRpzT+TCZwe6xpt1rgPWKZRoqeugqnOQFUAnFTVs2ciSPrypHMaH+w10bvMn2o634FGbKhJIuUS9udbZ2dg+SCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LyCfcK68; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f1cec20a77so2095132eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260829; x=1733865629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLLkfyeupXOCJEsbtIiRnjf9v6qN6z82wPD/jzcKBAs=;
        b=LyCfcK68f5N6DK8XS3wwSUe+nlKahIqetZ+9qL/+vkDYLNgYksRTzeJvB2aNRsYtko
         4dvZu9OcRJhgIUngglhimUfE2S6HpL2qRnQG3de59EpLklP/DcTyNcJpnkNRH2VPYDfz
         GrJiJreNnCvDuXZ9iuCo8GlHhGX1oQFHHxHK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260829; x=1733865629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLLkfyeupXOCJEsbtIiRnjf9v6qN6z82wPD/jzcKBAs=;
        b=i7vCGSV7QGXDj44rUKkUuPUFFRKbJXB0B/jJm57d4mdx7CCKe9qWPBY5hznVk430qZ
         j5B7bJa7HQBtVNyKizyyBegw15TslIYnZ99RG9lK+h5SV985WpZl+PtOtDzS+QCNqA4X
         63n8u8Nc4KYJGBLHy5vqd2JdDX1m8T7DJxD69Cs5xLXnD15dmB1sS1mreHdsZ/SUNKLk
         KuHz28toMDxb4aVUC+HGd76yoF5Q57VBxG2MJTksIlzjl4A9PI2b15nO+O3c8zRduMgK
         xzm+xCfTpsAlRUrcNhPIptQh/CZuPYbjJ2ujox1Ublf6a4/tP6wzfdr+DyoHQObtiYx9
         vdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ98xslOEhFqWFSxH2C7vLY+308CQg0i+Y30MTB9EdBrt12EEezwOLSxBEIwq/4JMPIIf0yk9FNfFOxuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfB8EP/KWswT1jfwqfPAfQj4eC19AlS5ERZiMcG3jJvjVNcXH
	7yBJ24aiPbdh/5DloPXALO91YBN4IAevVWlyuMkX7iUhNT9IZ5ZS1TeFfaEyaw==
X-Gm-Gg: ASbGncvsNFG9y3/vCVMYalGuJiK5Kcp3zXep4S9OF0IF2WxiiwZTlHDfnYkiJfplzSS
	iSDxuDQMfA7CgUO4clduL1dY0JExVUlpyVTnTtf2zYXwz9Uon8+Y24ANCKnv/RbYrQDTxkG+Zvo
	/FV/YrGRLl+rxTAA8zDBUabt+fhBntrD3Vz57srh01tzIVkk96BYbXq8/8Sq7/aQS9pZ67/d0Z8
	e8bAV+uv6Z1AcmpKwBgftnR65bSGDXNKJ4CxGnUlkS6BotxaUpX0/P9YxA0wto6pICaKNzls8bd
	ArWeswMRBmm8RnU+WEcrHh0p
X-Google-Smtp-Source: AGHT+IHXPcyq+8B+KJ1dPXvdy3NU/VpWuqhFh2jcwyvKYbPbXmP0jy2dIclUy4Dce3/3CyVeNJ8Jdg==
X-Received: by 2002:a05:6358:5bcc:b0:1ca:9660:67db with SMTP id e5c5f4694b2df-1caeabd17d0mr509285255d.23.1733260829162;
        Tue, 03 Dec 2024 13:20:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Dec 2024 21:20:12 +0000
Subject: [PATCH v6 5/5] media: uvcvideo: Flush the control cache when we
 get an event
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-uvc-fix-async-v6-5-26c867231118@chromium.org>
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Asynchronous controls trigger an event when they have completed their
operation.

This can make that the control cached value does not match the value in
the device.

Let's flush the cache to be on the safe side.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3dc9b7a49f64..db29e0e8bfd4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1622,6 +1622,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 
 	mutex_lock(&chain->ctrl_mutex);
 
+	/* Flush the control cache, the data might have changed. */
+	ctrl->loaded = 0;
+
 	handle = ctrl->handle;
 	if (handle)
 		uvc_ctrl_set_handle(handle, ctrl, NULL);

-- 
2.47.0.338.g60cca15819-goog


