Return-Path: <linux-kernel+bounces-209453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD4903506
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B41F220FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327E176220;
	Tue, 11 Jun 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uc5Zv05L"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81867174EFA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093536; cv=none; b=Ydo9Ygf/+0yUnsYiz3lFveMtE/xBXLTkbz1nKrBShJKOpRRRildJLHiL7r3ynHnIDi/0+AztTBadZrE2zCZm/BEDEY4PYrMiuw5iWsy6Cfm2/u0AFuG9g2LLM3PwFlKvHbHh3dtVs7MGGCDgkxeuJAi85d6A0zFCi1CpHt8YbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093536; c=relaxed/simple;
	bh=hVLGmVR1HMkUx7+t5Nvw+6vPF4SbFF3ImKNPy0MAlEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTvz/0RNM9bXPVZg+Aglyra0m1ilpm2UuzO+Ao6neNvpb2gLgu9/1u2UtDyouteI4L7+cd5NgU7UFY0nJu1eai30UFOteHcuoTKIEivok77BaNX7yFFPIeX1BrYY1IvTD1d3zHjPkZXiwx7Xs2AAPlVj89jsTwt181xEf173iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uc5Zv05L; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b06f1f9a06so12869226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718093533; x=1718698333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qcNpYr9SkPtRLJMkT2pD1WoLD/0+PdytNXdst5BZm8=;
        b=Uc5Zv05L3zx0B+t6IHfmS25NKwjWRsoWfUBKmZgHSW0INbbFCiQLjODl8S/s7aAhAo
         FWN5QbQzDDAZd3eut+Ei3LP47sQwcdMLIuhkK5BvAdSf+n5mjYzQ5XHdrqMvpnYRTWKr
         twlnQ9LiWmKCBx3g4589rrXy4rL/OxM+87O8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093533; x=1718698333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qcNpYr9SkPtRLJMkT2pD1WoLD/0+PdytNXdst5BZm8=;
        b=GwLGa5NagzSXCDhVnK/VuM/bT5pJ1l0C15WpqDebR8RdOwx1vC81WCbDiKNR3LIgpK
         Eipl9df9PVvruXv5ijyZmU5/VMnXRYSGgQijF+yn7uiA9+slmzUUVL/OxrSEo0se3kkn
         fqC44OWUMFSxOywPvaBQFxQp+Bsgz875KT5D9o9IQnYwi2h83wAfDxuVl3dZegCTkkDh
         nbXDXwF5xdgIoYK0LYE00QfjLUrpB3nPs+ay9OIAfJP4dPAWImY9I8IjCcYcA0ezVGGF
         IV2+TQ5FzRk2VRsHLiu8Xp7Ju27wITwc7C6rnjZKwP08NZHA9U1dpc7oBloBZba+Nh7j
         wHaw==
X-Forwarded-Encrypted: i=1; AJvYcCXMHRwF/HwgbIyw4JbJS1KuoSSI8u1lh8kD/85Cj+nEdKpNOamrm7Crl8R8iH+I7b0Wd2PWY4KNiTqJq7StnKb9FuYKapYtlBXrCjew
X-Gm-Message-State: AOJu0YyQV8NjAW6n5is5xV43s08GsChwwh3aiuQO6i17cGCPvdg57d3B
	w/CzWoUYwpFyutZy0mSnsfD2KhPnFkX42tisMUM+V0nyb0hmMsWZY+ck5AgOWA==
X-Google-Smtp-Source: AGHT+IH48KT7q9z49yEVjuF/xwKgCzBz70RWMzOb4ndYUOF7z0Kudt/BHMFgmwtck1NHVeX9Opq37Q==
X-Received: by 2002:a05:6214:3912:b0:6b0:7ba0:ef67 with SMTP id 6a1803df08f44-6b07ba0f05cmr47438746d6.31.1718093533266;
        Tue, 11 Jun 2024 01:12:13 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b09039c2b9sm1548886d6.28.2024.06.11.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:12:12 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Jun 2024 08:12:08 +0000
Subject: [PATCH v5 3/4] media: uvcvideo: Avoid race condition during
 unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-guenter-mini-v5-3-047b6fe5d08b@chromium.org>
References: <20240611-guenter-mini-v5-0-047b6fe5d08b@chromium.org>
In-Reply-To: <20240611-guenter-mini-v5-0-047b6fe5d08b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

The control events are handled asynchronously by the driver. Once the
control event are handled, the urb is re-submitted.

If we simply kill the urb, there is a chance that a control event is
waiting to be processed, which will re-submit the urb after the device is
disconnected.

uvc_status_suspend() flushes the async controls and stops the urb in a
correct manner.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 375a95dd3011..8fd8250110e2 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -294,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_suspend(dev);
 	uvc_input_unregister(dev);
 }
 

-- 
2.45.2.505.gda0bf45e8d-goog


