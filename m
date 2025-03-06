Return-Path: <linux-kernel+bounces-549248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9FA54F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B92F16B65F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9821325B;
	Thu,  6 Mar 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fprApgwN"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B821129A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276270; cv=none; b=O9o1HpWwv7kh8lUlZkgKYYbl5kzTdijBrRC/5KX7ABAOqUwsDDEZo7kg63TEM1J/AuNizrsr/pSFEC7iV2imuytPVpLZMjQcxDBtC0nk41PDEQGAjKZixDTykvOyVgnWb87cbkXUBk8faH11/zKcvdPo66PW+Z+VtZXkCNhnLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276270; c=relaxed/simple;
	bh=sIWjSP//bax9MQTRChAEaQyMFPvhzadmJr8ZnrvUJTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq013beoeCwrutz2i6LC/HQ4Hd8pMGMv1/qy/GL72Cl4KxViQtSzTvg499JqzAzJ/RV/IqSv9/SpGl8oxLSnx2a0IqsDKJIV6loSh5qMRFYAhsG4HBuHLo8qmvLNpM2291dj2wZ4Ts4PuAAzqgtYPLDlLcQ8hX4KUERtqbdVbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fprApgwN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0155af484so119144985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276268; x=1741881068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8GfSnj+zIIgfn2ux5Vg/9U83zEPCtOOrWat8WfZMlE=;
        b=fprApgwNzHk621IKcNnWeclqWhLy973E9WqMN8ZxHgsb/h6NV3iVWtMDzE/gmgDOtR
         +TOoUkQRG7Ar3ldifSd+KeaZdIwfF1GHDK85TF9KMgOrRGkFKPZA6yVFdTWuQjtooFfO
         yPKOC0oJcmfuGRd3XxsDxexXDc0v78GaKbWPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276268; x=1741881068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8GfSnj+zIIgfn2ux5Vg/9U83zEPCtOOrWat8WfZMlE=;
        b=o9MxFv/r58ZPXLClgS7kJMzEal7CwULDUDdXU3bL3zAGDR4bQ1CelxriVo4S+9jD6C
         V5KL7mCpM0KZnzCHfvnY/NFePUcLErIK7hZPrXj1fkyFrYpGybfvb+WLEZPyip9gcbRA
         LCgOoxpxA0SmX8FeDRqWZEIQlpE/70dChlR4HkSMz1xeuCJJVk5VmoUpReB9SmSadGgB
         AgGqete3xaBb8p8e+3kxFCIpS8TaR1NgD2zXj2BMesD5LJhrEycGWQ2LZtLM2gvOdXh0
         wZsuA8UMd+rbC/UGh3i36wadMfQCamd1H1vCoiPfiqdKN/oo/qmUMvWplgnCsVKWWMpJ
         cYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcyTqWfYnEwzKadmJUHdeOpNX+3B3FJrob6j/0ZBWGappzCjr98BY+xYJLZS+iTy45fXE3++vNIozhSJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqS4XsQqpvEBb0jc//w1P5VlNqk8Bcwt+5k1WF844c8K1D7JLJ
	8+ESNwXTN5kPEcwajYoaUBPbEoKQl32EuJ8l2LEl5DV6dq5aEafULdT35Chhyw==
X-Gm-Gg: ASbGncseY0wQbA8/xH/z1WOOUaVhyjZhT6RTf3Ph+NlP0nBeGgEEIY4ATZnmlqN6TQ2
	eRtcJygszqWbGC7piVIDIoB9QnQ96XfqcJYeiyJxTIPhloDifxGJHyD8AAYwIJFLbmjfMLxuNgT
	3evq98heVRzT0YoIrCJrryADey63jmI6Ty52ROcMW7pEKFEkUnbzI7wRWJrONyaoGvhjbe5TJNF
	Ox+mCusSefWF0wCG7Hr3A32d75lCXOjE3k7Kh/lpUfp7+xUn4PPzLAxpYHfyDxnaHUArCFse584
	2HkmU9hn0sAdxUJfbD4diTl8xiHKq8F6z0wWA3AVNY5xup4MgHl3OnG58hxqJvGjSnDPJ71ltaA
	dbnw63kGT0Sv2/jmhci5YKA==
X-Google-Smtp-Source: AGHT+IEYBvMSEWNHJ/1hj3bKCOo7ajfk5v8Aot3cuzewpOwzNsY/phoYuzG1+uzlcwgpVuTa35TRzg==
X-Received: by 2002:a05:620a:8bc4:b0:7c3:d862:dfe1 with SMTP id af79cd13be357-7c3d8ed325dmr910967585a.51.1741276267703;
        Thu, 06 Mar 2025 07:51:07 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:07 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Mar 2025 15:51:03 +0000
Subject: [PATCH v2 3/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-uvc-metadata-v2-3-7e939857cad5@chromium.org>
References: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
In-Reply-To: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
V4L2_META_FMT_D4XX. The only difference between the two of them is that
V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
V4L2_META_FMT_D4XX copies the whole metadata section.

Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
devices, but it is useful to have the whole metadata section for any
device where vendors include other metadata, such as the one described by
Microsoft:
https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata

This patch introduces a new format V4L2_META_FMT_UVC_CUSTOM, that is
identical to V4L2_META_FMT_D4XX but it is available to all the UVC
devices.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 30 ++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 6 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index 86ffb3bc8ade2e0c563dd84441572ecea1a571a6..9fd83f4a3cc8509702a2a9f032fdc04bf6c6d1bc 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -19,6 +19,7 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-pisp-fe
     metafmt-rkisp1
     metafmt-uvc
+    metafmt-uvc-custom
     metafmt-vivid
     metafmt-vsp1-hgo
     metafmt-vsp1-hgt
diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst
new file mode 100644
index 0000000000000000000000000000000000000000..bec197cad65b52902c950c158c125dc17189c1d4
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+.. _v4l2-meta-fmt-uvc-custom:
+
+*******************************
+V4L2_META_FMT_UVC_CUSTOM ('UVCC')
+*******************************
+
+UVC Custom Payload Metadata.
+
+
+Description
+===========
+
+V4L2_META_FMT_UVC_CUSTOM buffers follow the metadata buffer layout of
+V4L2_META_FMT_UVC with the only difference that it includes all the UVC
+metadata, not just the first 2-12 bytes.
+
+The most common metadata format is the one proposed by Microsoft(R)'s UVC
+extension [1_], but other vendors might have different formats.
+
+Applications might use information from the Hardware Database (hwdb)[2_] to
+process the camera's metadata accordingly.
+
+.. _1:
+
+[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
+
+.. _2:
+[2] https://www.freedesktop.org/software/systemd/man/latest/hwdb.html
diff --git a/MAINTAINERS b/MAINTAINERS
index 29b4471574982bf3f8d03158cd5edcb94bc9fab9..4e8e8096951ff0e7159d7f3916cf7b014a6ef95f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24665,6 +24665,7 @@ S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
 T:	git git://linuxtv.org/media.git
 F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
+F:	Documentation/userspace-api/media/v4l/metafmt-uvc-custom.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst
 F:	drivers/media/common/uvc.c
 F:	drivers/media/usb/uvc/
diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 82de7781f5b6b70c5ba16bcba9e0741231231904..b257524d279a141f650e2fbb376a35cc17252c2e 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -63,15 +63,21 @@ static int uvc_meta_v4l2_try_format(struct file *file, void *fh,
 	struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
 	struct uvc_device *dev = stream->dev;
 	struct v4l2_meta_format *fmt = &format->fmt.meta;
-	u32 fmeta = fmt->dataformat;
+	u32 fmeta;
+
+	if (fmt->dataformat == dev->info->meta_format)
+		fmeta = dev->info->meta_format;
+	else if (fmt->dataformat == V4L2_META_FMT_UVC_CUSTOM)
+		fmeta = V4L2_META_FMT_UVC_CUSTOM;
+	else
+		fmeta = V4L2_META_FMT_UVC;
 
 	if (format->type != vfh->vdev->queue->type)
 		return -EINVAL;
 
 	memset(fmt, 0, sizeof(*fmt));
 
-	fmt->dataformat = fmeta == dev->info->meta_format
-			? fmeta : V4L2_META_FMT_UVC;
+	fmt->dataformat = fmeta;
 	fmt->buffersize = UVC_METADATA_BUF_SIZE;
 
 	return 0;
@@ -106,6 +112,24 @@ static int uvc_meta_v4l2_set_format(struct file *file, void *fh,
 	return ret;
 }
 
+static u32 uvc_meta_idx_to_fmeta(struct uvc_device *dev, u32 index)
+{
+	switch (index) {
+	case 0:
+		return V4L2_META_FMT_UVC;
+	case 1:
+		if (dev->info->meta_format)
+			return dev->info->meta_format;
+		return V4L2_META_FMT_UVC_CUSTOM;
+	case 2:
+		if (dev->info->meta_format)
+			return V4L2_META_FMT_UVC_CUSTOM;
+		return 0;
+	}
+
+	return 0;
+}
+
 static int uvc_meta_v4l2_enum_formats(struct file *file, void *fh,
 				      struct v4l2_fmtdesc *fdesc)
 {
@@ -113,16 +137,20 @@ static int uvc_meta_v4l2_enum_formats(struct file *file, void *fh,
 	struct uvc_streaming *stream = video_get_drvdata(vfh->vdev);
 	struct uvc_device *dev = stream->dev;
 	u32 index = fdesc->index;
+	u32 fmeta;
+
+	if (fdesc->type != vfh->vdev->queue->type)
+		return -EINVAL;
 
-	if (fdesc->type != vfh->vdev->queue->type ||
-	    index > 1U || (index && !dev->info->meta_format))
+	fmeta = uvc_meta_idx_to_fmeta(dev, fdesc->index);
+	if (!fmeta)
 		return -EINVAL;
 
 	memset(fdesc, 0, sizeof(*fdesc));
 
 	fdesc->type = vfh->vdev->queue->type;
 	fdesc->index = index;
-	fdesc->pixelformat = index ? dev->info->meta_format : V4L2_META_FMT_UVC;
+	fdesc->pixelformat = fmeta;
 
 	return 0;
 }
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index a16fb44c7246e35f3710306fde5dfc15329b4d95..1ffbf38823b226ff7044c798c4b982d52137e904 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1457,6 +1457,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VSP1_HGO:	descr = "R-Car VSP1 1-D Histogram"; break;
 	case V4L2_META_FMT_VSP1_HGT:	descr = "R-Car VSP1 2-D Histogram"; break;
 	case V4L2_META_FMT_UVC:		descr = "UVC Payload Header Metadata"; break;
+	case V4L2_META_FMT_UVC_CUSTOM:	descr = "UVC Custom Payload Metadata"; break;
 	case V4L2_META_FMT_D4XX:	descr = "Intel D4xx UVC Metadata"; break;
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index c8cb2796130f8d1b864d669267d2b31f73b839aa..b0af18b7621296be0885d5b65494ec01bc425c9c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -851,6 +851,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
 #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
 #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
+#define V4L2_META_FMT_UVC_CUSTOM  v4l2_fourcc('U', 'V', 'C', 'C') /* UVC Custom Payload metadata */
 #define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
 
 /* Vendor specific - used for RK_ISP1 camera sub-system */

-- 
2.48.1.711.g2feabab25a-goog


