Return-Path: <linux-kernel+bounces-409825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D19C922E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A6F28112D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8041AF0B4;
	Thu, 14 Nov 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wi9nDRUG"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA241AC448
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611455; cv=none; b=OBe2qxLjEPY31C6qORwEqELr/2KzplAwPte3KEKOYYtIx16a5z2a1rqSpm9Y+xqiKLaeOnUCI4LQnoQk7+6zaKb29OTxDeOpNWK9vDvt98TbuqcIyC9JpI41YoZl+r1segJjXVWTksSK/D0qA4iIvz00NmyTVQeIwrzrLPaPQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611455; c=relaxed/simple;
	bh=WuLUGkHs5rzPTrMYeFD9MhMpg+rW/hjaacAF210Zlvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIDa6SXEUxZ1NuVmW8tCpzN5m1noUV3ZKis4b/wVrLJyaA4DqtuplkWVdmcfcPUVTHBCRfO0Cu6Z5G4T6gqyGLWNUP9LsUalWjKfmj7A7ZGLE9WQbzCmbkORNLfZ1eAoKtAQJxwr2N16BnACqJ7muJ6cK+bg4gVZD7yIlDu+zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wi9nDRUG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d3f733bbfbso3482926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611452; x=1732216252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agd78fl9Wg05tfWj8TXE/qjuiAxKCZ/bzWF7jfaD9AQ=;
        b=Wi9nDRUGygxIy2h9iFUZPS+/9jSzndUdZMiRzz6bYdKMnxYrBb6yIH5vJa1GlWYoBs
         yhxx5EvC2TLKr+zVmJMmC2RVL0fggmukurTKf1TxAJMUtGshTxECtjRooJztzGmeW8gR
         c8FxR+GjREE6aCViOLxKaUirTgg5gIPpMcXzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611452; x=1732216252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agd78fl9Wg05tfWj8TXE/qjuiAxKCZ/bzWF7jfaD9AQ=;
        b=MsI62i8its1hNW+I27PavCUOcYFouJlXJpvk0v8jsAb12L2M8C7BpvlRzrbvzyKGlL
         lMVgV0eMW6hkc/Uz3TAPZQRoVW3VeRXM1Z3/1B3Ss5sQeBCwQZ9KO5IkNHGetPCcjP6P
         FyVOALePwEaY8ozLmonSOBcE6qOTRX698qegdHOhc8WAuRgm/WNmc6ZLO0ioLvRRkD+S
         fAhPXuxleTu80PpxMISHsriMYb84bhCTVKdHgnXGbFY4sEaMfsfumA6kCictMh9aMeB3
         s9GbMpEF0VlKs2+Jtmg6RMkF4yirTvMZbXVfRTdiq3gN4QriarD07RsIQDW+xIFiYc+f
         0I/w==
X-Forwarded-Encrypted: i=1; AJvYcCX11jGBOV6ZvDDkcLfZADr/My5zDOFPXO02p+u9RZD5yplVYOBNFC4pPl9QEwY9iWbWuh9ZYOZG1NbJylU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrOWlk8EDbdTHijWA5dZ6gvkmkgDqbwfIoms54Ybm6Z45Wk63
	Pb3ZStZwvOf62rZ+8d/ARnp2YXf5+1dVs+Oqg0xsdIkjdLzBDCjylrRnwMa4iA==
X-Google-Smtp-Source: AGHT+IGfGZ77XmRsvM5pDShNqOVcnKjpwCHBu8ODcL423ifRxyF1TlWSXvxwnSO8pYYbWRznBIZQ6g==
X-Received: by 2002:a05:6214:418e:b0:6cb:e632:a059 with SMTP id 6a1803df08f44-6d39e1f66b9mr323111656d6.49.1731611452695;
        Thu, 14 Nov 2024 11:10:52 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:52 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:37 +0000
Subject: [PATCH v15 08/19] media: uvcvideo: uvc_ioctl_(g|s)_ext_ctrls:
 handle NoP case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-8-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

If nothing needs to be done. Exit early.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 02fd5cbc3474..65dbb53b1e75 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1081,6 +1081,9 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 	u32 which;
 	int ret;
 
+	if (!ctrls->count)
+		return 0;
+
 	switch (ctrls->which) {
 	case V4L2_CTRL_WHICH_DEF_VAL:
 	case V4L2_CTRL_WHICH_CUR_VAL:
@@ -1121,6 +1124,9 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	unsigned int i;
 	int ret;
 
+	if (!ctrls->count)
+		return 0;
+
 	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
 	if (ret < 0)
 		return ret;

-- 
2.47.0.338.g60cca15819-goog


