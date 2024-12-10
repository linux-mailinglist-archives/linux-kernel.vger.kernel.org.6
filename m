Return-Path: <linux-kernel+bounces-439262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C579EACD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7FC1619FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A403DABF5;
	Tue, 10 Dec 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZmVpE196"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77758215792
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823787; cv=none; b=dv+3BZdGX7aDl7/4KQwrk4ITHra7IXxfpt7s2mijwLSvNKLpwbH+GmwHYkK8ALcnrfigzExINow174xqRt2Gkuu1keUPvCDO/H6Y2rJx1hM6XhKUIDWbQn+UH99mZCSnT00HpgJL/FBb9YFkZk+UOXoOBF+5KJfw60jDbDK1v+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823787; c=relaxed/simple;
	bh=j6w/ehoFFcMfXU0GvWdVutVl4sbMYNCORCUrUbyVXPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrcRsVYy0h9i46eTm+EaTaQ90swYEq5V9TRSULcVPVUJYOTr6+cyS2vsU1kQ+4FUqYhVrOkah9EmQM0LhtrV/DZSwOgM4R+BSHQontq99/8PfyAOuj7vMxmTRkbPekllExd6KlbbwlT9LNXKNACYaOJsICVQdIXyStEBjRiOcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZmVpE196; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8918ec243so53708806d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823784; x=1734428584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teneHbxdymYBZ2TJXTz4C2Fnz+shby6Rz+Rw9UldIMg=;
        b=ZmVpE196GIYFHl4MJlQhv9glMEJv9th6z+yPxbzztGBiJJQkXBOOX1XRzNKireLXKb
         wAM0WZza2M0qYQb7xLfW48t6y0Oux4ZiWFmD787urHOyfsOeIojmPIxsK012jU+vxVVv
         jUd9GlZ1PeqxOCMx1PGg69/Z5M1/JlQPCEkfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823784; x=1734428584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teneHbxdymYBZ2TJXTz4C2Fnz+shby6Rz+Rw9UldIMg=;
        b=kGh1OrycssH/91krkuZh4FNpMxkgx57F5P9Hi7WUuBmBUEQotpjq1WW2lMvvEptRyf
         6dgtSVkHckXGi1vN/xdj1/zf5VJEAoFLV4c+R9oyQF7lR692Op402Bup9945qQOzUUP0
         fsczHN7TK8EE7oJmklkTYstI4V8o7zjfFmgkHstzfSswjlTiR/zuy63Yc9B0SXvReUin
         GaYUOUg5IHePvqsTqmJadruz7NtB1i9k+9DQe+tCAGUd3q2LgIqc3IvfC603g8uR8aNG
         HnBsvQ6wGuOK/FIpMRmPq5gbHgtN/VPUBKX4Apcwn0rAE64I3ujZys7G49gncjgXYRIJ
         Gdbg==
X-Forwarded-Encrypted: i=1; AJvYcCWSoCsqND3Ah3NjcYbz23nT3z9RR9e6a1BOZSMtNIOgl/JqtsHNmwkDj2F4dKleRScak8Ln/5HONPKVB78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsPjbnQ5iwt5QyS96KCS83Wfgx4KS7YYnrJUoM5WFNpdHwBj+
	A/4K8n2nTfuS9bITaSRB+/tcRLIIVYZj/GHMDTzd7Hv73bHBjxHXoteeQYEtGQ==
X-Gm-Gg: ASbGncuhzFIPDfN27zmZpOKJmEc4bOURvx0b/kvml9uBWJ+gF0CSR4rSN0O4r5pZGzF
	B7pVi2uT+PCs/Eey4jj8muu99hxbL04W6SfLzYSzH83JwXatNPEyL7HGSflC6yBvFJZObfO/4i8
	UiKobe3Fva1wWekwrrtcqd4CE3p2rvgn67MGbqakKgEorJmNUaGi3nsQMNXTnuNt9vYrvLuqNVw
	FRIxaYSA6y9NRuD1/wlQhppVPShMMpSFnuc++zP2Qzo2SwPufRyCfdQKAkqDVylwJaQ6tVG3nIp
	EmzVkXIfwtCqSG/ZKypNQO0q6Dr6
X-Google-Smtp-Source: AGHT+IHPeSY10FnNmsQEJGreViToMkX+83gWAxGpMBUhrfxnm5Cs2DpKJx49CNRZNU1nYkGjkjlubQ==
X-Received: by 2002:ad4:5c49:0:b0:6cb:99db:bdd5 with SMTP id 6a1803df08f44-6d91e40b5b5mr67741986d6.39.1733823784162;
        Tue, 10 Dec 2024 01:43:04 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:43:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:51 +0000
Subject: [PATCH v16 15/18] media: uvcvideo: Introduce uvc_mapping_v4l2_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-15-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

Centralize the calculation for the v4l2_size of a mapping.

Reviewed-by: Yunke Cao <yunkec@google.com>
Tested-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 58bd42191f3e..dd6129becf58 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1471,6 +1471,14 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 	return 0;
 }
 
+static size_t uvc_mapping_v4l2_size(struct uvc_control_mapping *mapping)
+{
+	if (uvc_ctrl_mapping_is_compound(mapping))
+		return DIV_ROUND_UP(mapping->size, 8);
+
+	return sizeof(s32);
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 				 struct uvc_control *ctrl,
 				 struct uvc_control_mapping *mapping,
@@ -1512,7 +1520,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 			v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
 	}
 
-	v4l2_ctrl->elem_size = sizeof(s32);
+	v4l2_ctrl->elem_size = uvc_mapping_v4l2_size(mapping);
 	v4l2_ctrl->elems = 1;
 
 	if (v4l2_ctrl->type >= V4L2_CTRL_COMPOUND_TYPES) {
@@ -2101,7 +2109,7 @@ static int uvc_mapping_get_xctrl_compound(struct uvc_video_chain *chain,
 		return -EINVAL;
 	}
 
-	size = DIV_ROUND_UP(mapping->size, 8);
+	size = uvc_mapping_v4l2_size(mapping);
 	if (xctrl->size < size) {
 		xctrl->size = size;
 		return -ENOSPC;
@@ -2284,9 +2292,8 @@ static int uvc_mapping_set_xctrl_compound(struct uvc_control *ctrl,
 					  struct v4l2_ext_control *xctrl)
 {
 	u8 *data __free(kfree) = NULL;
-	size_t size;
+	size_t size = uvc_mapping_v4l2_size(mapping);
 
-	size = DIV_ROUND_UP(mapping->size, 8);
 	if (xctrl->size != size)
 		return -EINVAL;
 

-- 
2.47.0.338.g60cca15819-goog


