Return-Path: <linux-kernel+bounces-549245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3258A54F92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38351169697
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079F12F5A5;
	Thu,  6 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xu7wHIDE"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634B148FF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276266; cv=none; b=WLj/Q54zVlJJwD1zLfb2Go4x9hLDRpqkQPMGQyRLJeA/ht18zCYb+u5HC4l9gh721Any8rOkeFJWaIKi6fVrkZsrFhXGCWJKWPNy0W8+gQinU/rYfiMHzstNes+b7g7jAKBX7UYmEaloKi7D+YKp5lj/EYMfi8r0mZ5I0nPSEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276266; c=relaxed/simple;
	bh=6/eshPQTJ88U2E8tAaABEc0mBxrlK9eSvRujOfacHCU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=coaRvAv/e4dq/eteqrG1s9la19ZpkgukoiSfmfbkMM8dTRyjiv6HSY+5+8S7OSntk3AZ1U+b2CdS3o4Dz8r7gKudEddS/Mlgq2HvWuZGg+FfBidSJwUAUDsM3ohhMXG9syJeF2apqQvbcp8eNLnWd/f9CjGF9XaGm9ClJwzHDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xu7wHIDE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3b63dfee1so89654285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276264; x=1741881064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMbnC32xMkkNtpNE5OTsWUJHP+Zfh4wWIQQTgHHZzVc=;
        b=Xu7wHIDENqS09TMlJ8kpd7PYRqY5kXbNVLeAHyjW9VFS/MtDqwAEoqAYI9EqLswSw5
         lcc2fmnhSGXscSlFFJerbgn/51ajt+dpi21jTFfFxksQUNT05DtairqWkYOSaSF6QyTN
         HHk597kq26E1w52L7HyBK1mCAHwnYp/DJLtDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276264; x=1741881064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMbnC32xMkkNtpNE5OTsWUJHP+Zfh4wWIQQTgHHZzVc=;
        b=HTh89owPrH/HUU+HR2UJ6QqWyDIzkUPy2wMCpG7F97MIVj9heGRjsFVLUh6xAz8dwU
         UZq/+AthqKTFXQjlYEmYYMWcQMtk0vGGI3ybU/YJw14mJ3y5APkcCjhFcd4b/6PNkFBe
         E/+o++qIXUsP0PFclDjhn3zmt25YVYtVF8P98L8eQgAiIRAhFYDc1dQkCA/Gym6qEI4p
         dC5pWYz94519Bxsy14PHsjb0thhunT82pLIBQUqSjvR4ZB00lKhxw9Jw7lhyh/gmqxMC
         rFuxS0yDUxd4pRSqTPrsAYVrRYdbx9FjiWwmlyYWZwms3BoJ/SoUToIOxT97jXMFC9xU
         LlWA==
X-Forwarded-Encrypted: i=1; AJvYcCVI9uPLjrHrVQKaHF+I2GJl7Cq2qA+lqK9fGHuKv/UNEamIoqLuRPAFYjKH/epNKsDb/yItspi27lC0JaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUXW+g0zMACENun4JMsM9eRp+GdjOjwLLi7mDDnWFkn0RHofC
	PxwEsiiRvcCwVUwKE3hrdvZVEosuw8qOd5A4WFqiMqOWsyVh2QMTcMqJT6fSHw==
X-Gm-Gg: ASbGncvfVzVwBbFa/lUdOT7h4zdmkvO1A9aeSLJ0Er6VhTdPZHF0in+HG18UPKhjMnj
	UTh/VP/L6osFQwbkFk8HnF9jT3BHYkmdrTiZx2qqenUvzBSIo9QWwYZT0GFLUUl86zO3asplWXg
	pvGYHp377hx7LuRA8t478cRGMwBQ8w/TD1rOaTplFucIrCWBALkdsEh6sCwYZDHuITbGzRBq8Zf
	HuJpWkTtSxXoAUBlmLTriNoQe2LIMJWzM0bZPuJoPE/H23SKyA83OFOLiGWGcHjtJhf0C3bkLnb
	5pHWUoKiwj6L8oKhPrBbMXBkssbTJJ6lt+hlMBXiocu4UIzfkVlECU4e6QkDfNEpDkpl5yRw/AD
	SbTa9FdWnHnr3Pz65kOZL2w==
X-Google-Smtp-Source: AGHT+IH24KmuxGN+n2gl5zVRmv9+jF9yqy4bvzwQUqbaRmvUqLbrFB/O+ZtC7Gu9XeQA0kdFZZGpLg==
X-Received: by 2002:a05:620a:6190:b0:7c3:d2f7:ca5e with SMTP id af79cd13be357-7c3d8bd27e5mr1112875785a.12.1741276264174;
        Thu, 06 Mar 2025 07:51:04 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
 + other meta fixes
Date: Thu, 06 Mar 2025 15:51:00 +0000
Message-Id: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTEyWcC/3XMQQ7CIBCF4as0sxbTTgpGV97DdIEwLbOgGKBE0
 3B3sXuX/0vet0OiyJTg1u0QqXDisLbAUwfG6XUhwbY1YI+yR1RiK0Z4ytrqrAXShcZRXpWyBO3
 yijTz++AeU2vHKYf4OfQy/NY/UBnEIJSxaiZJBs3zblwMnjd/DnGBqdb6BaBrwdKrAAAA
X-Change-ID: 20250226-uvc-metadata-2e7e445966de
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introuce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (3):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM

 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 30 ++++++++++++++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 ++-
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
 drivers/media/usb/uvc/uvc_video.c                  | 12 +++----
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 8 files changed, 77 insertions(+), 13 deletions(-)
---
base-commit: 36cef585e2a31e4ddf33a004b0584a7a572246de
change-id: 20250226-uvc-metadata-2e7e445966de

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


