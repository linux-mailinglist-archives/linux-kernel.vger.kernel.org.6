Return-Path: <linux-kernel+bounces-554314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B6A59619
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF951890865
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3722A4E3;
	Mon, 10 Mar 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9wWsLHX"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7022A1E5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612874; cv=none; b=u1YAOI3FJdv9/26nBjajOJ/wP2VcHR/ktritDbVzkJ2npCDFh66wVVAZ4hVhEI2vLNSv6n5DkogCBvRihGU6zfwZdT81EPhyflfMbWppqWqRx1ZgKO3ahlEpQxOeJpUYZK5wiHXR0cX2EueG9dGIylBbIk+dUmZDIbe7YxwlPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612874; c=relaxed/simple;
	bh=Ggvbp6qOa6npOF1qMV9S0zFDNXuxRGjSMsDMPctgc+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WOmnSV88H+JxgCIj+AzsbhofKhqs0o02O2ZwOJmgFgY2SHKxK+qkwOOIH4o00DtdLPb5iE7xn/f48jjjhbH9kMGAtaqtUNCR+8hZ3g7nLlLXAgYNXoq9TF16BDI22Dr5ZlEVCkKSywBbs4Xd32Z26iY79tuutorxSc59p3s9OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9wWsLHX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fb83e137so27262116d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741612870; x=1742217670; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEnhfGvFhDvehBkjvbbg0FC/c5Jl4TnP9p7hSbE7ZkQ=;
        b=I9wWsLHXUHc0rJhggJkxE3Ox4nkg1zAaCd/dJZmBEK/5xKuBvrIiH/qhqHoOApXlcB
         bz7PoWpd85u2pUGHvGw+0x5L7haRm+0EzuF5A0C5RW/uo38a4OZ6LwmwQnexZhe6SQHj
         H1IGF/SdIVhiR8hpJahSR2OrEDVOZ9QvCGHx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612870; x=1742217670;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEnhfGvFhDvehBkjvbbg0FC/c5Jl4TnP9p7hSbE7ZkQ=;
        b=dC3n+2xVYn2xEuKU1/SJDPOhFUfXyNbrlcr/m1xneHCDne3E5Xvc+aHaj1vhCcfkWb
         myfjWCEjrPnfDFYetpQ68VtK3qyyX4dhupza7IuKpWV195I5D8DRCpmSfPqRGqHc++ix
         U1beZHmS4WlUtR8GtyuK7sRXgXRHyEDJo/4+PCTcki0RId9wVmoudhsImik8aw/EQoiO
         vHFUUVQD1zZULox+o5phzFKkUO4H8ykWGHVToqlLx1jgwQihELjC/xfJu9nq1C1UOeXK
         zpRwwWmVx+GFlwMwvaeR4YEtjdaNIexMB8yRbkXx8IzB8Qd/OGtRVk1cdyUZgWFDGFF0
         75Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWtVhV8g92DN6lzA9MnKttDMKMwoDONH0YL2RAsau5GxfR0aMwv4VGjLjIpgIjsbRuTb+k7PcpnMeZkI78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEy0n6T4XcPWPJFUhfQ8lkjajPYDO4268alz9Hv6sJWOKRZSK
	jEMSsCBSS9GIJbqlrgTcuA3tA/rtkLJh1Z4U2NlUfAHNr7SqfaYGFNpXUPrfVJ272IQPzK4MxXw
	=
X-Gm-Gg: ASbGncth4EIzM7q96APKw05zSecHRNNCy9KmPwq69/+mHGgVr+sHg2kjWOC42jV+yiK
	/lv990jbK6KbH3hWPGVlwl1CSUpr2dGIxUZVJ//qh9/dqD6eZEjJenVTUK51iSyUCMf8xxJwxW3
	8iP26RVaQQSiROEm2770vGfdJHkNIzf7i93jmUorhKEi/xcddf0xmNLWD2iyImb6+7ZfLzP+t4i
	vBr7w7Rj5jDEx/p+TB5ml/EfwMUYL+X0ia0UUGhIm/1iHkCDnta4dO1Fie0nE+rDaYSuzsAZ+dU
	PXCi6ubwbkuyGDUD3C2QFgO5dSQIAvTd+9gYt6dsteyOHFaaezIPMyzoKxxxZPSCXOsEreUr+vd
	/lDMxy8ZK2tjSIob2zlJAoA==
X-Google-Smtp-Source: AGHT+IHx9NmSS7QfBnoPwnOYaAioCmKsiHZltBnlg+tKiT79EFQbFaFwYpgBnFGU0pCHoAYf+3pmxA==
X-Received: by 2002:a05:6214:2428:b0:6e8:97d2:99a2 with SMTP id 6a1803df08f44-6e900681c78mr197207696d6.39.1741612870054;
        Mon, 10 Mar 2025 06:21:10 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e90f5198fasm29718846d6.67.2025.03.10.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:21:09 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Mar 2025 13:21:08 +0000
Subject: [PATCH v6] media: uvcvideo: Set V4L2_CTRL_FLAG_DISABLED during
 queryctrl errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-uvc-eaccess-v6-1-bf4562f7cabd@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEPnzmcC/23PTW7DIBCG4atErEvFMPyYrnqPqAszQMwicQUNS
 hX57sWRqsaVlx/S82q4sxpLjpW9He6sxJZrni99mJcDo2m8nCLPoW8mhVQgAfm1EY8jUayVW62
 JhIERjWBdfJaY8u1RO370PeX6NZfvR7zB+rrfacCBGxmFV4nIoHqnqcznfD2/zuXE1lSTz9xtu
 ezcJ6OloMEPJuxw/OVagLBbjp07lxBRBw2IO1w9cYAtV52Ttdr5FMCHveP1H5dSbble/+5EsOg
 pJjn848uy/AAs9s7SpQEAAA==
X-Change-ID: 20241213-uvc-eaccess-755cc061a360
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

To implement VIDIOC_QUERYCTRL, we need to know the minimum, maximum,
step and flags of the control. For some of the controls, this involves
querying the actual hardware.

Some non-compliant cameras produce errors when we query them. These
error can be triggered every time, sometimes, or when other controls do
not have the "right value". Right now, we populate that error to userspace.
When an error happens, the v4l2 framework does not copy the v4l2_queryctrl
struct to userspace. Also, userspace apps are not ready to handle any
other error than -EINVAL.

One of the main usecases of VIDIOC_QUERYCTRL is enumerating the controls
of a device. This is done using the V4L2_CTRL_FLAG_NEXT_CTRL flag. In
that usecase, a non-compliant control will make it almost impossible to
enumerate all controls of the device.

A control with an invalid max/min/step/flags is better than non being
able to enumerate the rest of the controls.

This patch:
- Retries for an extra attempt to read the control, to avoid spurious
  errors. More attempts do not seem to produce better results in the
  tested hardware.
- Makes VIDIOC_QUERYCTRL return 0 in all the error cases different than
  -EINVAL.
- Introduces a warning in dmesg so we can have a trace of what has happened
  and sets the V4L2_CTRL_FLAG_DISABLED.
- Makes sure we keep returning V4L2_CTRL_FLAG_DISABLED for all the next
  attempts to query that control (other operations have the same
  functionality as now).

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Hi 2*Hans and Laurent!

I came around a device that was listing just a couple of controls when
it should be listing much more.

Some debugging latter I found that the device was returning -EIO when
all the focal controls were read.

Lots of good arguments in favor/against this patch in the v1. Please
check!

Without this patch:
$ v4l2-ctl --list-ctrls
                  auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
         exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
     exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1

With this patch:
$ v4l2-ctl --list-ctrls
                  auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
         exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
     exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
error 5 getting ext_ctrl Focus, Absolute
error 5 getting ext_ctrl Focus, Automatic Continuous
   region_of_interest_rectangle 0x009a1901 (unknown): type=107 value=unsupported payload type flags=has-payload
region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1
--
---
Changes in v6:
- Keep returning V4L2_CTRL_FLAG_DISABLED in future control queries.
- Link to v5: https://lore.kernel.org/r/20250224-uvc-eaccess-v5-1-690d73bcef28@chromium.org

Changes in v5:
- Explain the retry in the commit message (Thanks Laurent).
- Link to v4: https://lore.kernel.org/r/20250111-uvc-eaccess-v4-1-c7759bfd1bd4@chromium.org

Changes in v4:
- Display control name (Thanks Hans)
- Link to v3: https://lore.kernel.org/r/20250107-uvc-eaccess-v3-1-99f3335d5133@chromium.org

Changes in v3:
- Add a retry mechanism during error.
- Set V4L2_CTRL_FLAG_DISABLED flag.
- Link to v2: https://lore.kernel.org/r/20241219-uvc-eaccess-v2-1-bf6520c8b86d@chromium.org

Changes in v2:
- Never return error, even if we are not enumerating the controls
- Improve commit message.
- Link to v1: https://lore.kernel.org/r/20241213-uvc-eaccess-v1-1-62e0b4fcc634@chromium.org
---
 drivers/media/usb/uvc/uvc_ctrl.c | 46 +++++++++++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h |  2 ++
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4e58476d305efddac331417feda8cb064e340a13..4b282ac714220b26581fe468d9ecb1109a28483f 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1280,6 +1280,8 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
+#define MAX_QUERY_RETRIES 2
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1305,19 +1307,44 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		__uvc_find_control(ctrl->entity, mapping->master_id,
 				   &master_map, &master_ctrl, 0);
 	if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
+		unsigned int retries;
 		s32 val;
-		int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
-		if (ret < 0)
-			return ret;
+		int ret;
 
-		if (val != mapping->master_manual)
-				v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
+		for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
+			ret = __uvc_ctrl_get(chain, master_ctrl, master_map,
+					     &val);
+			if (ret >= 0)
+				break;
+		}
+
+		if (ret < 0) {
+			dev_warn_ratelimited(&chain->dev->udev->dev,
+					     "UVC non compliance: Error %d querying master control %x (%s)\n",
+					     ret, master_map->id,
+					     uvc_map_get_name(master_map));
+		} else if (val != mapping->master_manual) {
+			v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
+		}
 	}
 
 	if (!ctrl->cached) {
-		int ret = uvc_ctrl_populate_cache(chain, ctrl);
-		if (ret < 0)
-			return ret;
+		unsigned int retries;
+		int ret;
+
+		for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
+			ret = uvc_ctrl_populate_cache(chain, ctrl);
+			if (ret >= 0)
+				break;
+		}
+
+		if (ret < 0) {
+			dev_warn_ratelimited(&chain->dev->udev->dev,
+					     "UVC non compliance: permanently disabling control %x (%s), due to error %d\n",
+					     mapping->id,
+					     uvc_map_get_name(mapping), ret);
+			mapping->disabled = true;
+		}
 	}
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
@@ -1325,6 +1352,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
 	}
 
+	if (mapping->disabled)
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_DISABLED;
+
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
 		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 5e388f05f3fcaf0e4c503a34745d05837ecb0184..63687d7e97738a50d037b1f456f5215241909c13 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -129,6 +129,8 @@ struct uvc_control_mapping {
 	s32 master_manual;
 	u32 slave_ids[2];
 
+	bool disabled;
+
 	const struct uvc_control_mapping *(*filter_mapping)
 				(struct uvc_video_chain *chain,
 				struct uvc_control *ctrl);

---
base-commit: c2b96a6818159fba8a3bcc38262da9e77f9b3ec7
change-id: 20241213-uvc-eaccess-755cc061a360

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


