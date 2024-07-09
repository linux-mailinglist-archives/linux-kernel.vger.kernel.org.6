Return-Path: <linux-kernel+bounces-246243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993792BF82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A56B1C2359C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE019D88A;
	Tue,  9 Jul 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i9EQr3NK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32A82494
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541845; cv=none; b=hOkOOUVqEg8olkpFtPKCnIHzdmsiVdTPZypAgTF1ArkEyfqpS51T6J0c7k261zfnnM6G3THb+nnFcBSbnpeoYKFW/i6Q9quDuO1iN09L7rkB8NXfHPEAYqgd21kMVxrIQvMtG31mLI4l6lhmlof+69yHcqxV6jBt4HuU1eTrlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541845; c=relaxed/simple;
	bh=Xb6Ml21wBPBh19gBXrL81tVPdYZEYOFKPPlc+LqY/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKqda295TdRiSFpJYVFgy0T4uvj+Y37bHSsXm7iwAzf8Mm6gOpgSXGpZZFA2mdGXlFqngED+ar0BE6cKKl8Sh0/RFFi+7SD6MHI3bPoEe/KWVSFbcZww5mwZi53QR2pi+womUif97jF9H8hSAyySvroVflZhmnbavJlXQ3gPD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i9EQr3NK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720541836;
	bh=Xb6Ml21wBPBh19gBXrL81tVPdYZEYOFKPPlc+LqY/ME=;
	h=From:To:Cc:Subject:Date:From;
	b=i9EQr3NKcCAUdOzGy9IlJYRTkvLGOK8O+zzrtWLfy7KP9XiMe7Sw7P4fBE5uPhEcl
	 B+YXdAHMPiML/OJVoJSwLReK55MKgDHqUR2poehZyqQl0Fg3tE4pMDnfIjRix+YJdU
	 ntgnpFFoAzI/4W4q8TBbCK+yOfUyL5x29WPZbAgoKcDp2azxIExignFPn0QlAFHB7o
	 WD+t+I4wKxXPsWxMKUE+Tn8G8KutUJbNNymCtxsaSYZSdn+FtjOPsQ9hMz6Gfs5u9+
	 Vg3dQBlSHDoysDOgpx0pjVtM9ivu79zIiheptBFukl3tS2mdDZ4twj66ePhYiGJhkQ
	 oVgKa1qyqn+AA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 646EC3781185;
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
Subject: [PATCH v3 0/2] Enumerate all pixels formats
Date: Tue,  9 Jul 2024 18:17:08 +0200
Message-ID: <20240709161710.83109-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this series is to let userland applications enumerate
all the supported pixels formats of a stateless decoder without
setting all the possible codec-dependent control.
That offer a simplest solution for applications to discover
supported pixels formats and possibly let them doing smarter
choice between stateless decoders.

An example of how it can be used in GStreamer to discover the
supported pixels formats for stateless decoder is available here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/v4l2codecs_enum_all_supported_formats?ref_type=heads

changes in version 3:
- Add a flag to inform userspace application that driver
  as take care of the flag.

changes in version 2:
- Clarify documentation.
- Only keep V4L2_FMT_FLAG_ALL_FORMATS flag in ioctl.

Benjamin
 
Benjamin Gaignard (2):
  media: videodev2: Add flags to unconditionnaly enumerate pixels
    formats
  media: verisilicon: Use V4L2_FMT_FLAG_ENUM_ALL_FORMATS flag

 .../media/v4l/dev-stateless-decoder.rst          |  6 ++++++
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst  | 10 ++++++++++
 .../media/videodev2.h.rst.exceptions             |  2 ++
 drivers/media/platform/verisilicon/hantro_v4l2.c | 16 +++++++++++++---
 drivers/media/v4l2-core/v4l2-ioctl.c             |  3 +++
 include/uapi/linux/videodev2.h                   |  2 ++
 6 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.43.0


