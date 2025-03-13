Return-Path: <linux-kernel+bounces-559435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF37A5F3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A1D7AABD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB9266F08;
	Thu, 13 Mar 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D0mSEVa2"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC6266B4C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867590; cv=none; b=Shlnl0rR5aurXSzpQMJmcdM8U1ygE9Pmm87isl1FI61PEd8VSp0p9pPC/r/oZOHpIfSXfuZnEHTgHLCnNxsLQ+0KfWfpsr0GPintegCo5M6y3cxSAmEo6g60mkPnm7/LVMk3Hyxhf0Cwv/qHWBNszcT4l9qTySHIY24BnNH+bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867590; c=relaxed/simple;
	bh=YgUq00/8AbhG4t9L/nSWQetaZNYQQMmFFe2guzrS0oQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jn5OTZ0WsmV4dnZiZhFbT4ZvuA83BC/SYH8ZlTyL4Oz5n+bId/nmKRHbAehAXb+Tuy0aedW937DCsoviHkJv7QbTI6il8KqAn3pBEp1k8AugJkLq5BDs+nklub62epeCqtKcG5LlDVEYyJcZDozCLXDcgkEVq+rZY2OS2N5biww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D0mSEVa2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be49f6b331so79370985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741867587; x=1742472387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HHfyOLpdx1aPPgPI4Rp9Zj3D1LYRLFjWWXAeeSzzaQ=;
        b=D0mSEVa2Ni2Y5XtUTXWkGBJ8YuVZHcfBIgmzF0tGh8UyDZVqIc9cu5Zi9HSyN2d7LX
         Ah+dZtjCQXN1IjE39meiablIUScuOPzXwC4GL5lEMn+RlcksAawkZLJx5jAwRmPmweif
         1Jnq9rX2lwwQbHu0Q692XBf0XEzhI62+4wQDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867587; x=1742472387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HHfyOLpdx1aPPgPI4Rp9Zj3D1LYRLFjWWXAeeSzzaQ=;
        b=DNUsdv/LO2PKMQiKoZjyMAjll7vCvB9fbsqbTjd1qvagDkOPRwYmA8zgRBR/ZKVe90
         Fj9k27xvOBe7+z6R+z3kRnZFA2MeNsZjKmQZUwXqisc2Wifyl9XW+sl9hCsRZeLxpi3a
         TxzUxItIgNVUQciyOVIrWUXjSg89QUhGyKRb015FS/phGtYFiw/XCKaKZHFsW5jLeXGp
         d6oL3lot8o9nsffN6Vm4DFIck3InqWPNoV7V1WWoEXpTtMMj+nmWxa3x0O7Kp4BODIdQ
         KhfdHgwP0fId4GXgA5r6yLAah4NtowWtUVDUCyulHukrox27jvvGsfsl2rTvsgxnRZui
         jaJg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OYyQi1rjWrnvqgwMabx5ZXSKCuRDxw1pt05eiV11m5K19xlwyls6NwMeRSsJjRqmmDfzbAqGCNOg32Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+WviA+UqkHGra46Kfnsuh7hIFJ3TGYV6UyGhtapHJMEPO2JB
	MFZq51rWij9ZSNxarC2QwRAWSH9t7S6Epi0CdlnHFV/CkNdjwzNQ+ray3ETvx9ICfNSFOSZ28oA
	=
X-Gm-Gg: ASbGnctrw0d8zXV5kBj520R9jwDUgwB5fBdsM8P+bgTU+bActzex3VeVvQF0Gy8HZJt
	syPTeWbOKJ1ugYZO9Cw5AQHE+cz5fTtsFn8ohUAGDYC7tUANzwxyYWarhHTSILgdl3IdXGRq701
	Ozp6JesuKS0xMiS0nwmJQGSBNbux5ueBkEWPatINfw5ICmbyUd0ihyeAdEI4C5WzznpDSRlPMIN
	mBxjosMQyylkkznDgCqzrXLGqtZFuYoAER5AgK2ze/bZCKz+fTjC0zCdnYWV+/3I4s/pUSa2v1Q
	53IFlobiJogyI8HsNam0/p7b2oHERKSYeH38lEeKPBMGVyo+iE5XORSa8W+NW1jBO6N4fr4GVZ1
	MAEEooUYDqggGI0P5wh+9sQ==
X-Google-Smtp-Source: AGHT+IGLSM49dNKretr2HZ5V+KCsqhUkgKSImjMwSG2jKqCqMqncxxsSoTFy9uuqSCOzVvGsMJ0i0Q==
X-Received: by 2002:a05:620a:86cc:b0:7c5:5883:8fbf with SMTP id af79cd13be357-7c558839293mr2121678685a.21.1741867587461;
        Thu, 13 Mar 2025 05:06:27 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4db57sm92117685a.8.2025.03.13.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:06:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
 + other meta fixes
Date: Thu, 13 Mar 2025 12:06:24 +0000
Message-Id: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDK0mcC/3WMQQ6DIBAAv2I4dxtcBWtP/UfTA4VVOSgNIGlj/
 HvRSxOTHmeSmYUF8pYCuxYL85RssG7KUJ0Kpgc19QTWZGbIUXBECXPSMFJURkUFSA3VtWilNMR
 y8vLU2fe+uz8yDzZE5z/7PZWb/TNKJZQgtZEdCdKonzc9eDfaeTw737PtlfDXV/zYI3BoqK3ai
 2i0MuLQr+v6BUORt83rAAAA
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
Changes in v3:
- Fix doc syntax errors.
- Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org

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
 .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 31 +++++++++++++++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 ++-
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
 drivers/media/usb/uvc/uvc_video.c                  | 12 +++----
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 8 files changed, 78 insertions(+), 13 deletions(-)
---
base-commit: 36cef585e2a31e4ddf33a004b0584a7a572246de
change-id: 20250226-uvc-metadata-2e7e445966de

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


