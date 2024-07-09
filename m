Return-Path: <linux-kernel+bounces-246244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D943992BF83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C3287FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7819D8A3;
	Tue,  9 Jul 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EpmAn/Ot"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DEA34
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541846; cv=none; b=A3W5woNr4hW2s2w5WrscTclcaQCSqTn5pWNj4VJ+HULE9+bxhyFu3yytkVc7JydzrCOTFs09qk0956Wpa+Nk/oqw6SgydsV2kQwjhlTBfbCK8wqxRWT0tUGUGeoFwqEM3+92TkR4hB9R1oodGiEDLBbhvxwHIw9vFVm7VwX+JoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541846; c=relaxed/simple;
	bh=pY9dyAuf+IgDN1fa8f1eKketAbqYvw22P2aR6+ef43M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GliaDHEpNc04Z/0m/W4mME799EV9Qw3nyKPVJHxPuHVi42aI73EteWTZJaqt7phozPHaa7CIepGlDYYghVN7KSiwyNzicep+J84YO1IyTKOK8zRWcid+n+m7kjFEL+8GdY27n+ezOQzvfw7+rAFYclYV/QLrtkRrUpJMkvk0P9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EpmAn/Ot; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720541837;
	bh=pY9dyAuf+IgDN1fa8f1eKketAbqYvw22P2aR6+ef43M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpmAn/OtCJT2GGyZArBtv6j9t5PQtB7mHzXT/p9lXmV6OBIByK5uwxAX6b6job0pL
	 D21Lodx2rqVhmECxSPclMSWbMXe0mcRU1Um3shunxGJfY+UTeQWobDVZE+qavNATKX
	 TJaU3rW4LLPJRCE0vJ50pvsmAdKOvRxNqC7R4GkxaXehsErU9ADrWHXm+WAbPf6FtI
	 tcozblnpOXC1BTqMrGT3rY6/vNlQWJ3X8NuIOM5BPeu4MKA8xULWAMwHJvsn+Gr09Y
	 qkesIlMgcrIEmqqyRxt3sDiIc6yYMumjZaTD3p4shA1ud1/IqLppw4Ny9nD3DtwC/f
	 ToxNFFkrAk8wA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 060C137813C0;
	Tue,  9 Jul 2024 16:17:16 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	ezequiel@vanguardiasur.com.ar,
	hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 1/2] media: videodev2: Add flags to unconditionnaly enumerate pixels formats
Date: Tue,  9 Jul 2024 18:17:09 +0200
Message-ID: <20240709161710.83109-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709161710.83109-1-benjamin.gaignard@collabora.com>
References: <20240709161710.83109-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new flags to allow enumerate all pixels formats when
calling VIDIOC_ENUM_FMT ioctl.
When this V4L2_FMT_FLAG_ENUM_ALL_FORMATS flag is set drivers must
ignore the configuration and return the hardware supported pixel
formats for the specified queue.
To distinguish this partical enumeration case V4L2_FMT_FLAG_ALL_FORMATS
flag must be set be drivers so user space applications can know that
drivers support this feature.
This will permit to discover which pixels formats are supported
without setting codec-specific information so userland can more easily
knows if the driver suit well to what it needs.
The main target are stateless decoders so update the documentation
about how use this flag.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 3:
- Add a flag to inform userspace application that driver
  as take care of the flag.

 .../userspace-api/media/v4l/dev-stateless-decoder.rst  |  6 ++++++
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst        | 10 ++++++++++
 .../userspace-api/media/videodev2.h.rst.exceptions     |  2 ++
 drivers/media/v4l2-core/v4l2-ioctl.c                   |  3 +++
 include/uapi/linux/videodev2.h                         |  2 ++
 5 files changed, 23 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
index 35ed05f2695e..de006a7fd02a 100644
--- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
@@ -58,6 +58,12 @@ Querying capabilities
      default values for these controls being used, and a returned set of formats
      that may not be usable for the media the client is trying to decode.
 
+   * If ``V4L2_FMT_FLAG_ENUM_ALL_FORMATS`` flag is set the driver must enumerate
+     all the supported formats without taking care of codec-dependent controls
+     set on ``OUTPUT`` queue. To indicate that the driver has take care of this
+     flag it must set ``V4L2_FMT_FLAG_ALL_FORMATS`` flag when it enumerates the
+     format.
+
 3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
    resolutions for a given format, passing desired pixel format in
    :c:type:`v4l2_frmsizeenum`'s ``pixel_format``.
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
index 3adb3d205531..510d2a6700aa 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
@@ -234,6 +234,16 @@ the ``mbus_code`` field is handled differently:
 	valid. The buffer consists of ``height`` lines, each having ``width``
 	Data Units of data and the offset (in bytes) between the beginning of
 	each two consecutive lines is ``bytesperline``.
+    * - ``V4L2_FMT_FLAG_ENUM_ALL_FORMATS``
+      - 0x0400
+      - Set by userland application to enumerate all possible pixels formats
+        without taking care of any configuration done on OUTPUT or CAPTURE
+        queues.
+    * - ``V4L2_FMT_FLAG_ALL_FORMATS``
+      - 0x0800
+      - Set by driver to indicated that format has been enumerated because
+        :ref:`V4L2_FMT_FLAG_ENUM_ALL_FORMATS <v4l2-pix-fmt-flag-set-csc>` has
+        been set by userland application.
 
 Return Value
 ============
diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
index bdc628e8c1d6..7a3a1e9dc055 100644
--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
@@ -216,6 +216,8 @@ replace define V4L2_FMT_FLAG_CSC_YCBCR_ENC fmtdesc-flags
 replace define V4L2_FMT_FLAG_CSC_HSV_ENC fmtdesc-flags
 replace define V4L2_FMT_FLAG_CSC_QUANTIZATION fmtdesc-flags
 replace define V4L2_FMT_FLAG_META_LINE_BASED fmtdesc-flags
+replace define V4L2_FMT_FLAG_ENUM_ALL_FORMATS fmtdesc-flags
+replace define V4L2_FMT_FLAG_ALL_FORMATS fmtdesc-flags
 
 # V4L2 timecode types
 replace define V4L2_TC_TYPE_24FPS timecode-type
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 4c76d17b4629..5785a98b6ba2 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1569,6 +1569,7 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
 	int ret = check_fmt(file, p->type);
 	u32 mbus_code;
 	u32 cap_mask;
+	u32 flags;
 
 	if (ret)
 		return ret;
@@ -1578,8 +1579,10 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
 		p->mbus_code = 0;
 
 	mbus_code = p->mbus_code;
+	flags = p->flags & V4L2_FMT_FLAG_ENUM_ALL_FORMATS;
 	memset_after(p, 0, type);
 	p->mbus_code = mbus_code;
+	p->flags = flags;
 
 	switch (p->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index fe6b67e83751..b6a5da79ba21 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -886,6 +886,8 @@ struct v4l2_fmtdesc {
 #define V4L2_FMT_FLAG_CSC_HSV_ENC		V4L2_FMT_FLAG_CSC_YCBCR_ENC
 #define V4L2_FMT_FLAG_CSC_QUANTIZATION		0x0100
 #define V4L2_FMT_FLAG_META_LINE_BASED		0x0200
+#define V4L2_FMT_FLAG_ENUM_ALL_FORMATS		0x0400
+#define V4L2_FMT_FLAG_ALL_FORMATS		0x0800
 
 	/* Frame Size and frame rate enumeration */
 /*
-- 
2.43.0


