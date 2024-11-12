Return-Path: <linux-kernel+bounces-406436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE39C5F03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A2F2847F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC02144D5;
	Tue, 12 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6MRz86y"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EB209F25
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432664; cv=none; b=dgU1oQCwEpcp5PqvX8P6VF6JRPX9ogvyEZEva5OIXbVlPBViSmMTFuK21W0/jrA00DNtG1N2cyA/Ka6CETqxIumLAFBbSSgbTjLY5mNAlXa1KPHsZ/w8pla679N/PSBqqN2SDgdnnSyyb80qbEEaDir/Rz6ITutAjdQrakSuLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432664; c=relaxed/simple;
	bh=uHvRxnCwxSPwoWBt7s6p7RnvISj6q1/A38c/hPBn/Oo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T7eKDusAOMBF8IWQ9VGh2EF0VSYNPtsvRQm8BX/4hj8y8BFbKXRg9yphC1pURyUYmddIvLHuoJadfndOVhtm7BWWTigfuVZwj5IwMWdUn50EtrnbZTnvwDhenvRPbEfWVDIx7c2pp4tmZWVvGHjhgaKuyZULOHfhr6ufoUiBsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y6MRz86y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b154f71885so471953385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432660; x=1732037460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNnLmwM6k2wna/0wjImN/u+vOWZSQ1LYfyw6a2jXzJ8=;
        b=Y6MRz86yPlcWXEfyD7YCtcJj35Kuevwrg9TnH7I4AIGVDnQZRAjgt1LgADTvnz4feS
         GH7nukySUTB8yRjxrDL6gwxxEtN0ddF+sOg8XwHxDk4qRJi9d7E8hd5hfMY4z9LrEzqt
         hCVQq0U4NPxcm8rK93EvpKZXq22xvtwU5iZmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432660; x=1732037460;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNnLmwM6k2wna/0wjImN/u+vOWZSQ1LYfyw6a2jXzJ8=;
        b=APtgUi651QliG4DB0UE1XrvzI2BKBiqTuyCkkZiERHX+YG5DxhuxGnX2oh9twO9DP0
         iJcgylCwtN6fquRwSC/snj0csxUtKeDGvVBO2XqlypeNH3bXywL3JuE2jLNh4qeOFiYm
         fi5W2oOwCZYk5X08Wy+XpfRmoraokR1WOu3ooJZ9va0c5ZaNiEL34sYfgQuIVwsuF6/Z
         Jwo0nrMyGocFD3ZDyXKZnMWHJ61bb2VNMANQnK5ro5stm5wNAf36b0MassFR7HtODLWj
         iYEU7zCa4PrgIJOqOwXgHUJwntgJK6tQ9s8hnNBhdz7mcufAMYG5EovK2For6jXcsxLG
         tVuQ==
X-Gm-Message-State: AOJu0YyYoCxeaMwLwRD0oz/Ss01OGp4QqcIEzHCN1LBjzNBgPJJ8HTaP
	bPowHS2uFn6PSMmX5D6Yxymf3x1SNPZlJyb8jAmMRVL1IvEGo6K3DNRgIHrL1d622vHskvuG/ww
	=
X-Google-Smtp-Source: AGHT+IEqc2TDtyerxS7bC/9aGU2bzWGZBxZv6iEwNKljp7OmEq6pHR5Uiz4/K5WvZFBjN8dhnkGfug==
X-Received: by 2002:a05:620a:4495:b0:7b1:5143:8da1 with SMTP id af79cd13be357-7b331f20600mr2305215085a.43.1731432660551;
        Tue, 12 Nov 2024 09:31:00 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:30:59 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
Date: Tue, 12 Nov 2024 17:30:43 +0000
Message-Id: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSQM2cC/13MSw7CIBSF4a2YOxZzL/SBjtyHcUCBtgxaDFiia
 bp3aRPjY3hO8n8zRBucjXDazRBsctH5MQ+x34Hu1dhZ5kzewJEXhALZlDSLU2NsYvLYFkVVK8S
 mhBzcgm3dY8Mu17x7F+8+PDc70fq+GfpmEjFkqpJCkLbG1Pys++AHNw0HHzpYpcQ/NaH8qXmuZ
 WmkwpKUMOKvXpblBSRkygLlAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

Some notebooks have a button to disable the camera (not to be mistaken
with the mechanical cover). This is a standard GPIO linked to the
camera via the ACPI table.

4 years ago we added support for this button in UVC via the Privacy control.
This has three issues:
- If the camera has its own privacy control, it will be masked.
- We need to power-up the camera to read the privacy control gpio.
- Other drivers have not followed this approach and have used evdev.

We tried to fix the power-up issues implementing "granular power
saving" but it has been more complicated than anticipated...

This patchset implements the Privacy GPIO as a evdev.

The first patch of this set is already in Laurent's tree... but I
include it to get some CI coverage.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- CodeStyle (Thanks Sakari)
- Re-implement as input device
- Make the code depend on UVC_INPUT_EVDEV
- Link to v2: https://lore.kernel.org/r/20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org

Changes in v2:
- Rebase on top of https://patchwork.linuxtv.org/project/linux-media/patch/20241106-uvc-crashrmmod-v6-1-fbf9781c6e83@chromium.org/
- Create uvc_gpio_cleanup and uvc_gpio_deinit
- Refactor quirk: do not disable irq
- Change define number for MEDIA_ENT_F_GPIO
- Link to v1: https://lore.kernel.org/r/20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org

---
Ricardo Ribalda (8):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Factor out gpio functions to its own file
      media: uvcvideo: Re-implement privacy GPIO as an input device
      Revert "media: uvcvideo: Allow entity-defined get_info and get_cur"
      media: uvcvideo: Create ancillary link for GPIO subdevice
      media: v4l2-core: Add new MEDIA_ENT_F_GPIO
      media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO entity
      media: uvcvideo: Introduce UVC_QUIRK_PRIVACY_DURING_STREAM

 .../userspace-api/media/mediactl/media-types.rst   |   4 +
 drivers/media/usb/uvc/Kconfig                      |   2 +-
 drivers/media/usb/uvc/Makefile                     |   3 +
 drivers/media/usb/uvc/uvc_ctrl.c                   |  40 +-----
 drivers/media/usb/uvc/uvc_driver.c                 | 112 +---------------
 drivers/media/usb/uvc/uvc_entity.c                 |  21 ++-
 drivers/media/usb/uvc/uvc_gpio.c                   | 144 +++++++++++++++++++++
 drivers/media/usb/uvc/uvc_status.c                 |  13 +-
 drivers/media/usb/uvc/uvc_video.c                  |   4 +
 drivers/media/usb/uvc/uvcvideo.h                   |  31 +++--
 drivers/media/v4l2-core/v4l2-async.c               |   3 +-
 include/uapi/linux/media.h                         |   1 +
 12 files changed, 223 insertions(+), 155 deletions(-)
---
base-commit: 1b3bb4d69f20be5931abc18a6dbc24ff687fa780
change-id: 20241030-uvc-subdev-89f4467a00b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


