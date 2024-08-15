Return-Path: <linux-kernel+bounces-287795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D2952CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE44281FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075C1D1F42;
	Thu, 15 Aug 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBBU+GYY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9421BE22B;
	Thu, 15 Aug 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717437; cv=none; b=Fi2v38kvD9Y3CPwiPGXj8ugaoQZuTTLxx0UfCdgCHwD5Xjl+A47QgDg0Fkeg2/m0VLaum/37/W1OAA/wY67XviFLTNbHKyWUchv0/4DkeLgez3PzLPcj3JsyXCtJf+4F3Ag32CWeWBIEU58yBPbqOVRM8Zwwcmd5CWuDniOe8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717437; c=relaxed/simple;
	bh=vaO2bQL+x+qVSEjpB5J2V0P2pQYy5iaElBnUbnLPXko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PINHV6+Uh4A3JQUhWCjrXko4rkxgyG/DukAaSV1AjwUYawbCARSJ0YwihMdC8d8ismON2UWWaE7NwwooCZrsoS5aNIQnjpLaJEDT+ZEulB6gAYNMTDveGJYAzibcmKrdAbvcF2L4uX2CU6y1UNgaeoiG/BrswWeoOZ4xft7z01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBBU+GYY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd70ba6a15so6766265ad.0;
        Thu, 15 Aug 2024 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723717435; x=1724322235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq7fbg1eOsvG0ItPF//0IwrkFyZmuk5NQdbvO/TCh44=;
        b=hBBU+GYYPb1UcBQnA2PGbFiCwLvijoRE4eCGcEZ2t6iHvE+EvHykoF28+b1LCVP1SI
         PVOxx+FG97pga1syBDNyGEPSKdETq/u9KwKSA0msd8hUHyxzBEziwYaCPdq9AX/ivNC9
         fOC16nKysEXFtiE6Vee3hzTqbzi8kmKh0gqMTdOnhHZRCHoFmo7TQg3ya3tt0toTpCoU
         YcNJJVd9uOixIcxv19d0fFRQUEePKAccNHcoJl9mWZrTx7UXcyo1YNjdxHjMCdsH0ocm
         YPN0apUaQyS5kcuwlFTxHZrVQy4qV3z+5/f2QwzhLkvBD4qSrUAPUc1jucGHFtILADEn
         o3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717435; x=1724322235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq7fbg1eOsvG0ItPF//0IwrkFyZmuk5NQdbvO/TCh44=;
        b=h/4dNderS3vYHZtb0uSlRdz6QAbqCc+gQtDQm8PvY8i1KSgoBDLSgsXpsBF6MzqVGP
         kAL2lOEaMlNRkd1MwuNaK8N0l1QzlRcmocIV4rzi0r6C/bH+W4/strNz3x80uExfcTcV
         fw8lmZ5IgHQbAP7j1e/Ci6iMsYioavlGl/tZQSJ/8XRdnwIiXtShHWkiqk0xbwPm+FLc
         3n1Vup/3tJrt9Rb7h1aGm0IkGffTS/h7ozV3zbvpCAYpDgoezmVoDgRT/l9hspsJzmxR
         jCeVVGKOWPMkZM+9tyVq2BSHmLIiKG6DkT2IJU9RFLvRmhAIAgZY1hNn2/Eo+/nWo1Yu
         LEyw==
X-Forwarded-Encrypted: i=1; AJvYcCUrWxZu+XROX6efrdVkE1AD3UXv9L8k8R0TRDjIK1AjJ783ooqJAfGxvztHVB0Vdi9gwvqzGXD2lCcM+kCGVmYHN6A48auMNWz3C8sKQck4XYnfBtnF1r33VdCcBBkoh6VJAPlACD2J
X-Gm-Message-State: AOJu0Yy3WLoI1KN/QB0QOD8LfdcjNVyNm99vPv3gFF5IOsCL6NE3pSo2
	LpiIEYMJ7SJvI+zeAA3rIRTAgHNP1vIFpqUHXpA92ObaJ4lL4UbZ
X-Google-Smtp-Source: AGHT+IF65Vk0UJTrOg0O0JsLoJ7hNz2P7gEInAhGTSB5ssnKOUPkBDzbHJf6OrSiEYHxKyNqi53Ylw==
X-Received: by 2002:a17:902:f68b:b0:201:f6e6:c7cf with SMTP id d9443c01a7336-201f6e6d26bmr10889685ad.45.1723717435098;
        Thu, 15 Aug 2024 03:23:55 -0700 (PDT)
Received: from embed-PC.. ([106.222.235.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b303sm7892025ad.192.2024.08.15.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:23:54 -0700 (PDT)
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
Subject: [PATCH v3] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Thu, 15 Aug 2024 15:52:02 +0530
Message-Id: <20240815102202.594812-1-abhishektamboli9@gmail.com>
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

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v3:
- Return the error code using PTR_ERR() in uvc_v4l2_try_format()
and uvc_v4l2_enum_format() instead of directly returning -EINVAL.

Changes in v2:
- Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format().

 drivers/usb/gadget/function/uvc_v4l2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc..de1736f834e6 100644
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
+			return PTR_ERR(fmtdesc);
+		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
 	}
 	fmt->fmt.pix.field = V4L2_FIELD_NONE;
 	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
@@ -389,6 +396,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 		return -EINVAL;

 	fmtdesc = to_uvc_format(uformat);
+	if (IS_ERR(fmtdesc))
+		return PTR_ERR(fmtdesc);
+
 	f->pixelformat = fmtdesc->fcc;

 	return 0;
--
2.34.1


