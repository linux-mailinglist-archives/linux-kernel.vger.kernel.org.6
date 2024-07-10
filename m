Return-Path: <linux-kernel+bounces-247604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74092D1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82825B272D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC11191F90;
	Wed, 10 Jul 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tjb6ADZK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0A4C631
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615262; cv=none; b=ZaLbRhOW7QIZR3bk3yyoggRkaR8dHXsqJPtlFYCBt0MJ00CX5JTaZial9nF8YqhN5IYDuOOWakX05F6OccubJ35j1nj7+5Z7nKckII4dtIbSVuObcNDbpYBqAlBDG/JDfieb2kjN6/I9HekVulbVnaWtOCMeHwckkRb674JdEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615262; c=relaxed/simple;
	bh=1qonYkuvgugxym8dPLSROyJnYV8KaGdsqJmBI4WouCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy3tNvYpK+1cDg9BfnMqaIcA9+Ig28SVaONlLOwBr3D/icRxrtTRF/P883I9K8IyTj2yeq0gjBOK3GSrggpVp/WXaDkwT+pxsfNd8C8aW1G9Gf8qVr6cHK8OuD4cwL9VISOBjWv0Q4I6GhvEifFvqpzS3hChPb3opW38KSh36/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tjb6ADZK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720615259;
	bh=1qonYkuvgugxym8dPLSROyJnYV8KaGdsqJmBI4WouCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tjb6ADZKOLPeVs089OvMIT94I609pxISnM7G/pDFj6rus2l+cMo2DNO2DvufFC+Kb
	 23/WoKBHJYQDMpMrvlEv4Lhf9xdp1VOsGdHaBFIOEWWUqa2VqcXD1jE9Uz6XVsnlLA
	 tzRtu0eMJzZMQdAbNUoog2SClH34waKALJ+BAz0K30gV++YFY7eqasl9crRkSmiU8u
	 g+EpEuvMRCM1Dwn163f6S001bFH7/Izbw+tlqplEwpIW+9UOdmHmIwET5v+dWe5epx
	 nkyDU6srM/0YG0P/6dgKHsk4tmmnK1U/7ttd8zXKHKzl3c0E5AI9H8CjhuB/CJ6bRR
	 saaF6T/NgMw2Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F299C378107C;
	Wed, 10 Jul 2024 12:40:58 +0000 (UTC)
Date: Wed, 10 Jul 2024 14:40:57 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 1/2] media: videodev2: Add flags to unconditionnaly
 enumerate pixels formats
Message-ID: <20240710124057.j3j4kow5fcvveyrm@basti-XPS-13-9310>
References: <20240709161710.83109-1-benjamin.gaignard@collabora.com>
 <20240709161710.83109-2-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240709161710.83109-2-benjamin.gaignard@collabora.com>

Hey Benjamin,

On 09.07.2024 18:17, Benjamin Gaignard wrote:
>Add new flags to allow enumerate all pixels formats when

s/enumerate all pixels formats/enumeration of pixel formats,/

>calling VIDIOC_ENUM_FMT ioctl.
>When this V4L2_FMT_FLAG_ENUM_ALL_FORMATS flag is set drivers must
>ignore the configuration and return the hardware supported pixel
>formats for the specified queue.
>To distinguish this partical enumeration case V4L2_FMT_FLAG_ALL_FORMATS

s/partical/partiuclar/

>flag must be set be drivers so user space applications can know that

s/be/by the/

>drivers support this feature.

s/so user space applications can know that drivers support this feature./
   , to highlight support for this feature to user space applications.

>This will permit to discover which pixels formats are supported

s/pixels/pixel/

>without setting codec-specific information so userland can more easily
>knows if the driver suit well to what it needs.

s/knows/know/
s/suit well to what it needs/suits its needs well/

>The main target are stateless decoders so update the documentation
>about how use this flag.

s/how/how to/

>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
>changes in version 3:
>- Add a flag to inform userspace application that driver
>  as take care of the flag.
>
> .../userspace-api/media/v4l/dev-stateless-decoder.rst  |  6 ++++++
> .../userspace-api/media/v4l/vidioc-enum-fmt.rst        | 10 ++++++++++
> .../userspace-api/media/videodev2.h.rst.exceptions     |  2 ++
> drivers/media/v4l2-core/v4l2-ioctl.c                   |  3 +++
> include/uapi/linux/videodev2.h                         |  2 ++
> 5 files changed, 23 insertions(+)
>
>diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>index 35ed05f2695e..de006a7fd02a 100644
>--- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>+++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
>@@ -58,6 +58,12 @@ Querying capabilities
>      default values for these controls being used, and a returned set of formats
>      that may not be usable for the media the client is trying to decode.
>
>+   * If ``V4L2_FMT_FLAG_ENUM_ALL_FORMATS`` flag is set the driver must enumerate

s/If/If the/

>+     all the supported formats without taking care of codec-dependent controls
>+     set on ``OUTPUT`` queue. To indicate that the driver has take care of this

s/set on/set on the/
s/has take/has taken/

>+     flag it must set ``V4L2_FMT_FLAG_ALL_FORMATS`` flag when it enumerates the

s/set/set the/
s/when it enumerates/for each format, while enumerating/
(to highlight that every enumerated format must carry the flag)

>+     format.

s/format/formats/

>+
> 3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supported
>    resolutions for a given format, passing desired pixel format in
>    :c:type:`v4l2_frmsizeenum`'s ``pixel_format``.
>diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>index 3adb3d205531..510d2a6700aa 100644
>--- a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
>@@ -234,6 +234,16 @@ the ``mbus_code`` field is handled differently:
> 	valid. The buffer consists of ``height`` lines, each having ``width``
> 	Data Units of data and the offset (in bytes) between the beginning of
> 	each two consecutive lines is ``bytesperline``.
>+    * - ``V4L2_FMT_FLAG_ENUM_ALL_FORMATS``
>+      - 0x0400
>+      - Set by userland application to enumerate all possible pixels formats

s/application/applications/
s/pixels/pixel/

>+        without taking care of any configuration done on OUTPUT or CAPTURE
>+        queues.

s/any configuration done on OUTPUT or CAPTURE queues/
   any OUTPUT or CAPTURE queue configuration/

>+    * - ``V4L2_FMT_FLAG_ALL_FORMATS``
>+      - 0x0800
>+      - Set by driver to indicated that format has been enumerated because

s/driver to indicated that format has/
   the driver to indicate, that formats have/

>+        :ref:`V4L2_FMT_FLAG_ENUM_ALL_FORMATS <v4l2-pix-fmt-flag-set-csc>` has
>+        been set by userland application.

s/by/by the/

Regards,
Sebastian

>
> Return Value
> ============
>diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>index bdc628e8c1d6..7a3a1e9dc055 100644
>--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>@@ -216,6 +216,8 @@ replace define V4L2_FMT_FLAG_CSC_YCBCR_ENC fmtdesc-flags
> replace define V4L2_FMT_FLAG_CSC_HSV_ENC fmtdesc-flags
> replace define V4L2_FMT_FLAG_CSC_QUANTIZATION fmtdesc-flags
> replace define V4L2_FMT_FLAG_META_LINE_BASED fmtdesc-flags
>+replace define V4L2_FMT_FLAG_ENUM_ALL_FORMATS fmtdesc-flags
>+replace define V4L2_FMT_FLAG_ALL_FORMATS fmtdesc-flags
>
> # V4L2 timecode types
> replace define V4L2_TC_TYPE_24FPS timecode-type
>diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>index 4c76d17b4629..5785a98b6ba2 100644
>--- a/drivers/media/v4l2-core/v4l2-ioctl.c
>+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>@@ -1569,6 +1569,7 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> 	int ret = check_fmt(file, p->type);
> 	u32 mbus_code;
> 	u32 cap_mask;
>+	u32 flags;
>
> 	if (ret)
> 		return ret;
>@@ -1578,8 +1579,10 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> 		p->mbus_code = 0;
>
> 	mbus_code = p->mbus_code;
>+	flags = p->flags & V4L2_FMT_FLAG_ENUM_ALL_FORMATS;
> 	memset_after(p, 0, type);
> 	p->mbus_code = mbus_code;
>+	p->flags = flags;
>
> 	switch (p->type) {
> 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>index fe6b67e83751..b6a5da79ba21 100644
>--- a/include/uapi/linux/videodev2.h
>+++ b/include/uapi/linux/videodev2.h
>@@ -886,6 +886,8 @@ struct v4l2_fmtdesc {
> #define V4L2_FMT_FLAG_CSC_HSV_ENC		V4L2_FMT_FLAG_CSC_YCBCR_ENC
> #define V4L2_FMT_FLAG_CSC_QUANTIZATION		0x0100
> #define V4L2_FMT_FLAG_META_LINE_BASED		0x0200
>+#define V4L2_FMT_FLAG_ENUM_ALL_FORMATS		0x0400
>+#define V4L2_FMT_FLAG_ALL_FORMATS		0x0800
>
> 	/* Frame Size and frame rate enumeration */
> /*
>-- 
>2.43.0
>
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com
>This list is managed by https://mailman.collabora.com

