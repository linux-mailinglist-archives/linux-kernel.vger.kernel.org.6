Return-Path: <linux-kernel+bounces-449941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A29F5866
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BC71893552
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0F1FA175;
	Tue, 17 Dec 2024 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RSNBeIoU"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5031FA171
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469629; cv=none; b=ma7cXvnYzz3FPFw+pDWUwWGQteDpX24gPylEQFz5VCD0UiYwNv91oqJ6J0JJn71kiWCKKvTYzDVN6DKD1LZHRjZJdkG8j0F5KEldYcl9PMiXT3tCCGlyWHVjKrNVMaNmy/9sybeEgaAzxjLnhsAsW4LAcoeZV8ma2j5PjQhjev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469629; c=relaxed/simple;
	bh=uenJu74j/Lwr2wWBMfStYd5Y0E2jiTk4eE6aU1AVS9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMrsAn40xuzzVZTpRp1PC0NIRfyaUZB7CgI+LrYJJrS6RxGWA8G+FEGh954TdG0LFuDqnJDTO7d20DxXdtm5tKVbD0iTsUVMGvgvzYCY8XISx+k5OOf72l0btSGuFkZBbcdVo9WGG2cjfMEqKp35e20OKclQYP3Iui90F1ztMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RSNBeIoU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso51562356d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734469627; x=1735074427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X38Eu7mA026YUSiXMDtPdvj4gwf9pxsv7m3KoYh7F0=;
        b=RSNBeIoUJpiEqSPzD1ut2BbMtwXIjPsJjaDjG3Rztw/gEdhnPfIo6Za65DpKxzQLHA
         p+4bYopdIR4R/HgNb7dyl6YaLmnkK0rf27v6j+n8Pf0/+fXTs/SxhFHbsoJrSBONMUM6
         5x+TzPW1mklS9EHW97q/AIxIf/OdN/C9ls6Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469627; x=1735074427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X38Eu7mA026YUSiXMDtPdvj4gwf9pxsv7m3KoYh7F0=;
        b=ANEG9bWyHPU8OJEdR6Z54AAHjafcTnFbko656PM+IRE9SgTfXDtQyFlJVGPv7w4bgq
         2lyN7Tam1Bczsb91FyfqW77YfCQaN5Hd4hJMdEfL8bvZz9ADTmNYus6KnornCFavB7Pu
         nm98wVhQ4zGpp/3/u3NbTrUYvimjxCiHu0Ay1VTuef7e0Hb1D1wKhTKtDuy7VYZOCMaf
         gw14BmIv2lWJhM+WqWqX/ki7sYb/ZpdGutdnv7JRpaByJ+NKN4ulJ3BBO73zZOOz2Vx+
         Bgl1OJE1ygFecZ6h9cSYEGJdXWG2+k9isx98fXVqZnB8OgQznT1xMXNB+u2H8P/WxhjK
         NJxw==
X-Forwarded-Encrypted: i=1; AJvYcCUaFaM+GZfkENvmun1ZpDUnzbpqNN43PrrPXuApHtIMCUb/vaRimkMOSIc+x12+xOfdj9rq8YmFdN3Hprk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4DmajgjT0Q40PX74xWV2K+/3gIXG3u7Q7cOXjELj0Sj/XcdE
	zkqJkb2vzW7za6bZh42BKa9sU6a8CbSZJD/LXJFUURGe0XLRoXCdgI3hH+htVuSbt9uCyhjOLFo
	=
X-Gm-Gg: ASbGncsDRZovNswNTix/ljbUYhooyxq/mxxiMfc6MLLzYmN92FRrNfU+uqfA1bq1/Kf
	NLA+TxGoDKmFa+IjiZvpaK2Z0JZ94Oww6ghS6f5cYaIDqy/VUAeXAyx7Eesq9c8XjbUSrGu2Hal
	6BnitCEpB2md45iY3FN1K860bglvM6388POv+hyFQBlV3OuTa1DEU+h917E9y4ouWGbjklhmIVF
	CP5UCyGKt/VxOZt6OJh8ZJPqQ1N/sxwII6I3LA72NkDK0N6EXwddkS2H3znA/maxC4pMZeI6X2I
	uwFQzvi0rpYqOXAlAMZ6DOEe87HN7bg=
X-Google-Smtp-Source: AGHT+IFXaZ4pKbRSE3Q+DHG7qDiGY5XwCpLr9wYWd9bPXYCo700dc7W1WXA/aJz07Xomabvl8yqDxQ==
X-Received: by 2002:a05:6214:f2e:b0:6d8:899e:c3be with SMTP id 6a1803df08f44-6dd0927b806mr8066266d6.49.1734469626916;
        Tue, 17 Dec 2024 13:07:06 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f2a7sm42825276d6.27.2024.12.17.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:07:05 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Dec 2024 21:06:59 +0000
Subject: [PATCH 3/3] media: uvcvideo: Announce the user our deprecation
 intentions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-uvc-deprecate-v1-3-57d353f68f8f@chromium.org>
References: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
In-Reply-To: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

If the user sets the nodrop parameter, print a deprecation warning once.
Hopefully they will come to the mailing list if it is an ABI change.

Now that we have a callback, take this chance to parse the parameter as
a boolean.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 10812a841587..d8e8675dd2cd 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2424,8 +2424,25 @@ module_param_call(clock, uvc_clock_param_set, uvc_clock_param_get,
 MODULE_PARM_DESC(clock, "Video buffers timestamp clock");
 module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, 0644);
 MODULE_PARM_DESC(hwtimestamps, "Use hardware timestamps");
-module_param_named(nodrop, uvc_no_drop_param, uint, 0644);
+
+static int param_set_nodrop(const char *val, const struct kernel_param *kp)
+{
+	pr_warn_once("uvcvideo: "
+		     DEPRECATED
+		     "nodrop parameter will be eventually removed.\n");
+	return param_set_bool(val, kp);
+}
+
+static const struct kernel_param_ops param_ops_nodrop = {
+	.set = param_set_nodrop,
+	.get = param_get_uint,
+};
+
+param_check_uint(nodrop, &uvc_no_drop_param);
+module_param_cb(nodrop, &param_ops_nodrop, &uvc_no_drop_param, 0644);
+__MODULE_PARM_TYPE(nodrop, "uint");
 MODULE_PARM_DESC(nodrop, "Don't drop incomplete frames");
+
 module_param_named(quirks, uvc_quirks_param, uint, 0644);
 MODULE_PARM_DESC(quirks, "Forced device quirks");
 module_param_named(trace, uvc_dbg_param, uint, 0644);

-- 
2.47.1.613.gc27f4b7a9f-goog


