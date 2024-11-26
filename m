Return-Path: <linux-kernel+bounces-422562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBF9D9BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9015B2A65C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27371D8A0B;
	Tue, 26 Nov 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROAGRC8a"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664711D63D6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638027; cv=none; b=OZ5CGAlhG7XWXHJUWxskv3ud9U94xSSIM//czyKCRMRYWS/3tK9Z5DcjUQI4LVpdNu7fz/wpoJF611yotdAT80E2QcLlE0l13tqdXxTamutOA081ddyJB4vovAkUAGdFkSTxpG9BZ2tD5HRdOyQ5TeHwNXIFFF/eQLsSDS5d0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638027; c=relaxed/simple;
	bh=dSQ7ETPxUqr7Y8jY5HOOpL2zd0d1eXHqZdnF61NKGPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aWOFATQHbPJIq//PFLchjDxctIrU0IjwUbKHn/OSkEzRTWANNLIHjiT4rDQAmpJQG81MORP6jSRxPRO8P/510i+3GqQf+Ae0Os1iqUe3Kqup4VUadmlYJGZG9qszBOJY41jOl0Kvj0PbVIBcXxj98at2BMuLFlfU6Px35qHQhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ROAGRC8a; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71d4c462ab1so1068994a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638023; x=1733242823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5h6wJYoG8v14a/k7G0R4omEhI1WXt8Qcm4fv6qiXWkk=;
        b=ROAGRC8anXQPCtnU370jhvfT3931HKw/C2oPcy/HQu5YA5ZhxKv5h13r2Asldx8WFM
         FIa+aPq1osYo9oNHrYAl5+vaqr7FhptZstKRAaGoOis7+N9M/0bILWHn8BwWzgiIllTZ
         8xEdI7hwYkdubCKnjgZBv9shoubMIJDeHZhsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638023; x=1733242823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5h6wJYoG8v14a/k7G0R4omEhI1WXt8Qcm4fv6qiXWkk=;
        b=P1tqodeG+mt5ARX+k3IjB/5KwY3ckjYAZ6RAGWi/+9Pgx8KpfEzNVvmzutYw8PCwgT
         XIipKVQwFVTgiGOqsuojZEdiycdqZWEI7B/aBvNyGD2D/ZuV3NgoWUmE2E2iqIBfXNXl
         xHcK9PdeZ9vA8oGjZnvLz70EdpB1uhJMb6/Fhu/2Zgbrn1ZUFddx7q62SUDKhlVwo63F
         tj3F1Pu66uTp8ViTyTxn2psITM2ep5ddUFyoV879KjZSu5gLXAmFz3NEOp7OKSZP8H1d
         J60DOWCMX9Qwj4B3HtKICO+aAGd38IYCoEl2aOsWHsd5QefeJzBfJxPW1S9GDPlwG8lM
         msVg==
X-Forwarded-Encrypted: i=1; AJvYcCVrb/NlAR+j/ql5dwfiZj4lSSndeDjgvcv8fqJskQmLjoVSLgnvwlMoswS5MMTMzZLPKPeKdGP0vMwM8dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IMJ6qVBQiqvSAkTXW66YyBSP3CXjCN7LFDB6MJ/4Xeh6zN61
	39KkyKZaB/HYFCOKwtVoN9HH1FcKbYuYnHzeuxuTjBwyTEgLnfuC49uV7GAH5g==
X-Gm-Gg: ASbGncs6QW9bUnNTpcVL2oOqhdrAXwiNAvKTCRo5PHTDU3vxjkLbhY+lcLDMGg22h/2
	EeQn+kuHoZ+tlzVhxrtZJl4ZEZoSwH+0IVjnOpmIK1r/Tt9f3KPGIjRwTZe9+pR1cAk8qeA7bgW
	k7wmPD8Ye6EI7EfoRZx20Fa0vk8+/bfq6CznTr8+3V4scopWrT/Qb6bcSGNdva9ve3ffD8l90MB
	PrDYFVcEwKVW923YFC/9cgdJ3jg+VTU516TXZjNRsdph79aXX1xDgacnDKFitcicKRvi6cQ5Jam
	sRbsybfLiUM5cViJ89wE9byi
X-Google-Smtp-Source: AGHT+IFG2bZ2P5Zn41kVEQ+tyZFJfQtiniQ3kN0ylxwnAa8drHufHNkYqM3/xaK/IlGeahhM3vi+qQ==
X-Received: by 2002:a05:6358:1281:b0:1b5:fa8a:791b with SMTP id e5c5f4694b2df-1ca79805541mr991681755d.23.1732638023341;
        Tue, 26 Nov 2024 08:20:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/9] media: uvcvideo: Implement Granular Power Saving
Date: Tue, 26 Nov 2024 16:18:50 +0000
Message-Id: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOr0RWcC/x3MywqAIBBA0V+JWTeQYvb4lWghOdlsLEZ6QPjvS
 cuzuPeFRMKUYKxeELo48R4LVF3BsrkYCNkXg260UUpbPK8Fg7h47DcJxoCNHVTfOutNZ6Bkh9D
 Kz7+c5pw/KV0QamIAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Right now we power-up the device when a user open() the device and we
power it off when the last user close() the first video node.

This behaviour affects the power consumption of the device is multiple
use cases, such as:
- Polling the privacy gpio
- udev probing the device

This patchset introduces a more granular power saving behaviour where
the camera is only awaken when needed. It is compatible with
asynchronous controls.

While developing this patchset, two bugs were found. The patchset has
been developed so these fixes can be taken independently.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (9):
      media: uvcvideo: Do not set an async control owned by other fh
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Keep streaming state in the file handle
      media: uvcvideo: Move usb_autopm_(get|put)_interface to status_get
      media: uvcvideo: Add a uvc_status guard
      media: uvcvideo: Increase/decrease the PM counter per IOCTL
      media: uvcvideo: Make power management granular
      media: uvcvideo: Do not turn on the camera for some ioctls
      media: uvcvideo: Remove duplicated cap/out code

 drivers/media/usb/uvc/uvc_ctrl.c   |  52 +++++++++-
 drivers/media/usb/uvc/uvc_status.c |  38 +++++++-
 drivers/media/usb/uvc/uvc_v4l2.c   | 190 +++++++++++++++----------------------
 drivers/media/usb/uvc/uvcvideo.h   |   6 ++
 4 files changed, 166 insertions(+), 120 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241126-uvc-granpower-ng-069185a6d474

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


