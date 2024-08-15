Return-Path: <linux-kernel+bounces-287599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0E9529BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8D51F21C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376A17ADE3;
	Thu, 15 Aug 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyP4XM8G"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13DCA62;
	Thu, 15 Aug 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706255; cv=none; b=T8uZC0Bk9clG0SKKk+y8kyQXXyVjGVk3QErdRLQixeMVEkNzK5lid2RCrbl9u5Vm0AgAaEGTCXcUyOFpanMPl0OzNhybWfkLjIhQRh7ezQdsNmkHdHBGgLYnxDx6cgystORa1VMNwTZKSCC76J1Gn1RLRwMZlWBfW86qMWZV/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706255; c=relaxed/simple;
	bh=aaFDd5ISb84lhCJFQsTbHtxY5uuIzKwhP/XKSewykcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xg+paoMeHME52jcbxDwzYtLA/K5zc6t2k7v0wjLMxd0HBzlmmhkmA7YbIhILCHaG82yKAeOt9E9lEEzzqhETiHyEadtLBT+Rw+ijpAUViW5a0bA9EXUfvD8j9beERFrkQDdyQKreFCxj8WDwqVci32Tlbpa+JQ0jKfIvm0vJuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyP4XM8G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1c655141so421212b3a.1;
        Thu, 15 Aug 2024 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723706253; x=1724311053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvruj7SsdqsHY133idfzMsgdOO/tE81N6D79Gm7sQSA=;
        b=QyP4XM8GASFru9G6mrfgkfM4n964+mRasYyBWcdsfGIDi6iV69aVEg1Hl+fxMTMqTY
         y8iYUlZeaJtGEdmyIZOQ2QlJPM3AA/lthelMXk0r9i7YpTxtrxiJQLZKz159zS6fTvfB
         esqkjvWlJdvaXhXGhQSLdWggfanvaQSqAdxdm4OJDT4HfafSDzw2CrBpj/Xs5nwnM7NM
         LXV27h8voKifwF8Fi6/55FmVgpUBvp70bIk53h1V+KXP0X8pdY1v64dMHIn3Zb+nf5fV
         4AJvaPShKg2ZJZF8mL6yze4tGK1tJnf+NrhwcFB/F3e89nob5YXlZfQ7gSPUQ7CkSRA7
         ozbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706253; x=1724311053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvruj7SsdqsHY133idfzMsgdOO/tE81N6D79Gm7sQSA=;
        b=ui1GAiCG2Z/OH3kWNQS4OqfyY/Tl7bcKa1BrmOFFR2WQX3SZshM9AjYlJKFeDDdSMr
         /LrMH/MHnhzdeKJrAgDlX4qs2EizjCBq+wa7IsUO9zC/einBUxo6W8KR4jMhyHSVpKxM
         Lo6PZ0DI7nnYS7H2CJa+oTZ416QtpKR0AXlSJH344peD/MUyOIr1XvMY8MBii+b6G3yZ
         N3MdQf1VFZw1ZutuoVB+XkSX+3C3i2gKnrV9noeVPtTfwDQ5F2VJEzneNZGJf8qaATs1
         CCpyw81C23hIIQo5NSBCETpao+5mdcLGmmfEASMo+IgQR5DdVDMH4DaqrhDPsmUwvlmq
         yl5g==
X-Forwarded-Encrypted: i=1; AJvYcCVgYVS2VXUlz3SlkWbgIayATfXrhaE/LtT+wZzLaYi52gGFgNNdg1BMgWjbY/axHV2/MHJlC8Jj2zCGgCDiFVXdxTt8a4JXYfKw6tojQHf0qT2X5EIOmoCCmEwqYFsk0em+4NAZHAir
X-Gm-Message-State: AOJu0Yx/Y0uUiEOzbR3gut3dfOl9J0wlppjvugNApbxyZWPny0ulfEhT
	LiQ/8qYNM2WVjp+Ydb7xEkLDKS6Fuci0sE/rzpOzbKCaZt0HZptI
X-Google-Smtp-Source: AGHT+IHnq8ZsMvaDul8KdxjK2STZStCb5oTgnTG8zdSTjLFE5fRFXTJFZbeFFOVy7c6u8+cQmX0/3w==
X-Received: by 2002:a05:6a00:170a:b0:70e:91ca:32ab with SMTP id d2e1a72fcca58-712670fa539mr6744797b3a.6.1723706252977;
        Thu, 15 Aug 2024 00:17:32 -0700 (PDT)
Received: from embed-PC.. ([117.99.192.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm604455a12.4.2024.08.15.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:17:32 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: dan.scally@ideasonboard.com,
	laurent.pinchart@ideasonboard.com
Cc: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Thu, 15 Aug 2024 12:44:16 +0530
Message-Id: <20240815071416.585559-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
and uvc_v4l2_enum_format().

Fix the following smatch errors:

drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
error: 'fmtdesc' dereferencing possible ERR_PTR()

drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
error: 'fmtdesc' dereferencing possible ERR_PTR()

Also, fix similar issue in uvc_v4l2_try_format() for potential
dereferencing of ERR_PTR().

Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()

 drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc..8bb88c864b60 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
 	list_for_each_entry(format, &uvc->header->formats, entry) {
 		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);

+		if (IS_ERR(fmtdesc))
+			continue;
+
 		if (fmtdesc->fcc == pixelformat) {
 			uformat = format->fmt;
 			break;
@@ -240,6 +243,7 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	struct uvc_video *video = &uvc->video;
 	struct uvcg_format *uformat;
 	struct uvcg_frame *uframe;
+	const struct uvc_format_desc *fmtdesc;
 	u8 *fcc;

 	if (fmt->type != video->queue.queue.type)
@@ -277,7 +281,10 @@ uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
 		fmt->fmt.pix.height = uframe->frame.w_height;
 		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
 		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
-		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
+		fmtdesc = to_uvc_format(uformat);
+		if (IS_ERR(fmtdesc))
+			return -EINVAL;
+		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
 	}
 	fmt->fmt.pix.field = V4L2_FIELD_NONE;
 	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
@@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 		return -EINVAL;

 	fmtdesc = to_uvc_format(uformat);
+	if (IS_ERR(fmtdesc))
+		return -EINVAL;
+
 	f->pixelformat = fmtdesc->fcc;

 	return 0;
--
2.34.1


