Return-Path: <linux-kernel+bounces-527903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C984A41124
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AB170849
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F0190678;
	Sun, 23 Feb 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0XBVRoR"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9218E377
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337164; cv=none; b=u/TKaW+p7LKq6EQdNwdusfKSBc5Ux2wg24D7NziRg5hUjI5bgHInIQAguRkL2+u3iPMyWRkHV9drpW8dXFRM/7iZ1k8thQCTOvsFMMcC2rIe7+CztLAm2Wim7LSE7YCv9U57MYZwAA8S5p7aooJKQN75pnT9wLKHIzYMNHrPI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337164; c=relaxed/simple;
	bh=u4eeWPx9v9zXxQW6q1d08/EVNgYhQ9eDU6vhv1Eg1lQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i6kKjR636dX4XldqnSrJ33Z730y1cW0/Z2PMja3e5d6D1NySby6zrD4dkfeVQ5DQeHf1wuVtsMCnrBKAL65Uq9uMsJ9Yp/20uJ+E/bY+qT4T1kaxW46d8N7SKNOZKOeV/efHhrwj1B6MASwC70wOKiyem+E476/ZKsRa8EzvLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f0XBVRoR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f281714so467354185a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337161; x=1740941961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKj5wtQrpuxHEw5Ir/rKIm4r91PW3GTX9YpL0smEXfU=;
        b=f0XBVRoRyXGIdf728tMa9slrLIAK5Uuy8S2dpL+m8fySoJtnxxdBsBuJ+xIGpT61em
         jdN90iOmd9W3lsj8NAz6uGTuWQtXfYGayXesPi0l/MsKjt2Vie3y17kMIiyQoVeVPjYw
         MdxFPpWNhVlCZhTi7q6aFAi/vjzu4yDNXIJls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337161; x=1740941961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKj5wtQrpuxHEw5Ir/rKIm4r91PW3GTX9YpL0smEXfU=;
        b=AbqWNGZGpZvPLrvb8xzxv8lD5CwPqylBQNJj2V6mCjoJ/vj4anqVeEV7oRRZiHw1I6
         NDm2cG0P/y62LkmwcdOlyGEubaQygRIXOgoAxEV0zesOWm7ghdGvJ8XutyqpGkHOAU8O
         0+3RKgc7QYuVU2pfcE1VNQOMlmSH8OwyxlEmvt1n+cjyV+59JVy0dEbtGfDgLiXoNKPD
         yKepDwSObzKuVQpwVjE6kbdP+halC5bnSYcLkLc/V5He2qXNA4wUApaWhD1gDf/IuE40
         19soIpdK12FmYM9CDu3S1TBoL7Jg+66IcFPlRw2hSt1zzZvZLfbbdJmuiF4XIc+EswBL
         nzmA==
X-Forwarded-Encrypted: i=1; AJvYcCUQmh3f09n3LTkf3aWWvYxVMDgLIEgGq88MdFfkELjFNe02+XYqKMKPm3Lz0fwlZg18IuPMlI0Z0hoQy1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpX5Pcz3PIHjQy8VC4X3K0RRWkQ3gwMAboGAUKjAF71Y4xqzA
	eucexN/OLCLmTOmK6b0aO9rF/lt9TMFipyH7BNI0CsXxxaid7s20N/Nt7qRT+g==
X-Gm-Gg: ASbGncvlmtNWSYF72BASRcf5ZD59YMLkaj627Bk2dQ4+fAQadqxb+aFpTbbT+SBeCNG
	DLV/fsuKKJHv0iNSXM9AcZ14lnRq5Bt+Twy32duW8XAmwONZG5X3T89T1aJe4JjAc/GNrOMqoyL
	GXhEXwBs4ftQsOzUGC6TdBS/68kHjRkdB1wsjz9LNBLQKY8dX7AicwgCKRcSkEEKsN9CMMpbDPk
	VMATVLBd1i6CJ5XjkoWvPfGn6IDGEfupWWsj7AVSBvu88LtIY4iIxqG/JDoMmntiAY9LT/7/tcL
	fwwwiISiU7ZcBV6lp89iTw3G41bfYcPDF7E2LElzu5XvYbTgCTWAS11KrHjVnqQSfakGcEOAbzr
	c6x8=
X-Google-Smtp-Source: AGHT+IEPBVXunXYvubmeu9Rykbfo5eGXhaOm0MVgZQfjAtv1MCc6N7GtK7qCLnbD3lNpZga5u+oDwg==
X-Received: by 2002:a05:620a:2a0f:b0:7c0:c7c3:b877 with SMTP id af79cd13be357-7c0cef48cb1mr1777562685a.40.1740337161085;
        Sun, 23 Feb 2025 10:59:21 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 00/12] media: Remove vidioc_g/s_ctrl and
 vidioc_queryctrl callbacks
Date: Sun, 23 Feb 2025 18:58:03 +0000
Message-Id: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtvu2cC/22Myw6CMBQFf4V0bU0fPMSV/2FclNsWmgjVW2gkh
 H+3sCLG5ZycmYUEg84Ecs0Wgia64PyQQJ4yAp0aWkOdTkwEEzkXrKbvyeAMIz5pAbKUoqngUlQ
 k/V9orPvsrfsjcefC6HHe05Fv679K5JRRbaytFFjQ0NygQ9+7qT97bMkWiuIgc3aURZKBKSl1W
 duclz/yuq5ffPjOzeIAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Most of the drivers use the control framework or can use the superset
version of these callbacks: vidioc_g/s_ext_ctrl and
vidioc_query_ext_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Rename wl1273_fm_vidioc_s_ctrl
- Remove dead code from cx231xx-417
- Link to v2: https://lore.kernel.org/r/20241210-queryctrl-v2-0-c0a33d69f416@chromium.org

Changes in v2:
- v4l2_query_ext_ctrl_to_v4l2_queryctrl
- Fix conversion (Thanks Hans)
- Link to v1: https://lore.kernel.org/r/20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org

---
Ricardo Ribalda (12):
      media: ioctl: Simulate v4l2_queryctrl with v4l2_query_ext_ctrl
      media: pvrusb2: Convert queryctrl to query_ext_ctrl
      media: pvrusb2: Remove g/s_ctrl callbacks
      media: uvcvideo: Remove vidioc_queryctrl
      media: atomisp: Replace queryctrl with query_ext_ctrl
      media: atomisp: Remove vidioc_g/s callback
      media: v4l2: Remove vidioc_queryctrl callback
      media: v4l2: Remove vidioc_g_ctrl callback
      media: cx231xx: Remove vidioc_s_ctrl callback
      media: v4l2: Remove vidioc_s_ctrl callback
      media: v4l2-core: Introduce v4l2_query_ext_ctrl_to_v4l2_queryctrl
      media: radio-wl1273: Rename wl1273_fm_vidioc_s_ctrl

 drivers/media/radio/radio-wl1273.c                |  4 +-
 drivers/media/usb/cx231xx/cx231xx-417.c           | 15 -------
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c          | 40 ++++--------------
 drivers/media/usb/uvc/uvc_v4l2.c                  | 10 -----
 drivers/media/v4l2-core/v4l2-ctrls-api.c          | 51 +++++++++++++----------
 drivers/media/v4l2-core/v4l2-dev.c                |  6 +--
 drivers/media/v4l2-core/v4l2-ioctl.c              | 19 +++++----
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 35 ++++++++--------
 include/media/v4l2-ctrls.h                        | 12 ++++++
 include/media/v4l2-ioctl.h                        | 12 ------
 10 files changed, 85 insertions(+), 119 deletions(-)
---
base-commit: c2b96a6818159fba8a3bcc38262da9e77f9b3ec7
change-id: 20241209-queryctrl-5c3632b7c857

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


