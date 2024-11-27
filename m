Return-Path: <linux-kernel+bounces-423136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA929DA350
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184AEB25FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D917A5BE;
	Wed, 27 Nov 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ob9aMd2W"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BA1547E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693584; cv=none; b=kSHJkZltuJQmXBToBG9Bx46tYZikOycE5su1OrPutJ7HLBL0IwBzD6vezD9iw4a8Jz/3n+kRQ0klYA3dM8IPcVz5yYwlYbJFHGRDILKTBDy6QF6LNO7N59R0E0MhzK/HkRv2MnZXV41kl+sl40hNz+Ah+GmeMkJb+zH8uMmt45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693584; c=relaxed/simple;
	bh=P7cJDdqJWrLuL8K2uEZRvjaoWn4MVm6+xAAkGWyiVYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxiIsSfUve+uyRVHmD+/UIFbNo+KSIgK5d8x/twBPVF11Uwr/cVnwBKcCBbwqMFfk/XyT5P9xhMqhkizfpOZRinDHvh9XnzwbptWo1fe3LX9nvj8HoovBOuhqWzZZeICtIEwKDiLBTpZgMtrcAEcAUz4auWAa8gR2Fsb26yBgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ob9aMd2W; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d43134d574so39317416d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732693581; x=1733298381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=ob9aMd2WGwHgFzxBQK5Pw0cyNcdvykqiYRNd8WSqBf9QMq/utIA1p1SlM1PQiwpR2T
         Qy3UPxY0TAZKFOmkra9zg3NU/ulQTTjP9BEmKwzaLtmjNXY923JoHIk4ccytcZpn2YNX
         BEaZhPNeNCvZcdc3CTAlWd28JrBIL+InP6DCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693581; x=1733298381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=agEI0C20jtRdtbqC+nTRAydmy0Rfkjsc568TICtuXGQAoV7XJZMZtIauxQOT3ehrnY
         pCRhgC9LqS6B5k0jC/AEeGu0Z+kifHVhEGiVNfj/bPEouENZmBBmYjnU/JN0v/YdiLfb
         Ay/dFHv2nqtdMka63ZnhmXJ72B7uvvZEz+ROHbFY38mH4SKKEIY1rBJQlVIt5An0KjoW
         nLxOWzRXYqBpPne40/IhbDEINlB+Efg8QngE0HHKMFGEEa4qtjj+scm0VY1pSFuo6aBC
         NqrfcJdBibNhht/zMWNdL+pVhHDAIsaKYWCHw93JWGL+1rFfqelcSqyeAtdHmtCfRzre
         1DeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe9nLvY2H1xfkTLBlGF+8DrzEdwa1/8bbwujT9sZnH/Sm/hLpBIp2C19T4bUMPLfTym+fEJkSf/Rlmi9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhgyALW7l+Mnb8J305yQi8DPFI0CrtE9erw3TawONzjmB6BkS
	mzwniTz+CUVnQ+5oah3bHfA3ReVwai4k82arrqB4/Eljr66M6Eg9ukfy1Cz1+A==
X-Gm-Gg: ASbGncsi68idy+00qYY95mKPqS/Bi0uan7ZGLU0QrGyc3aB4dm9n1Ny/UI42YTtJThY
	JxxYdkhGJ+bOx4HAjeemPZjKoo1lPrqZ+MbFP4zjS9yVw4O+77EED733U/ReJKsEenPhLcow1eS
	c8sFxlwrp2il+b7IhACBOL4bu2PhDfOrRQ+mMuW2t9UNevoikxdSf1kThNJ63EyP5IbH2+Ngos6
	XDTcyU4RyYPJihuSVvUMtNqGyafOmHX4+WUCG1cUj8VsbeE+l3IW7SFEGYoCyGhCqJKDD4ILCk1
	vr7VFyPEY3VWmQFHhDOydGU0
X-Google-Smtp-Source: AGHT+IHjZqETEPShgvU8rMJKDjffubDyJxiF4XR9EMU6bbMMSHIwCT/IdCc48x4fk/k07H62yBxdcA==
X-Received: by 2002:ad4:5766:0:b0:6cb:ce4c:1cc1 with SMTP id 6a1803df08f44-6d864d1f41dmr29507186d6.20.1732693581473;
        Tue, 26 Nov 2024 23:46:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b1asm63750386d6.40.2024.11.26.23.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:46:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 07:46:10 +0000
Subject: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org>
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

If a file handle is waiting for a response from an async control, avoid
that other file handle operate with it.

Without this patch, the first file handle will never get the event
associated to that operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..5d3a28edf7f0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
+	/* Other file handle is waiting a response from this async control. */
+	if (ctrl->handle && ctrl->handle != handle)
+		return -EBUSY;
+
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:

-- 
2.47.0.338.g60cca15819-goog


