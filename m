Return-Path: <linux-kernel+bounces-287593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8599529AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1750D283404
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2A17A5A1;
	Thu, 15 Aug 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo3VukFF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA8BA20;
	Thu, 15 Aug 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706004; cv=none; b=vC3bvwB3WI/3f+Y4Hla3X6yYZTofZU8FHFXJYPTkQE+an83UlUPW1Fpy8TU3pLbdt35Um29u92pxsw0ASwdkF/+SSxK4D0xUDRyjcGjz2dBNQTjfBTwpdEjJjkuUCww/91XqyKWUdkZRX/Lsqjox76FGJbj3Pf4EzjOxzq6iph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706004; c=relaxed/simple;
	bh=aaFDd5ISb84lhCJFQsTbHtxY5uuIzKwhP/XKSewykcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkUgw5tw92r3l/p/ehAMHP1hUsh6LIYfzBSMnvhm15PBh4Vrvdv5KNjuJWNpt5lLImMMCAHGFR1/upn3j+kY3Jd9JeXTgFQTXPW0ne9yoNzyPz9XGDySz2LaLERFSCMllJigDbRoDcugNxE7XXcVExpUee0sTjxKGRzgvJHienc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo3VukFF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so550914b3a.2;
        Thu, 15 Aug 2024 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723706002; x=1724310802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvruj7SsdqsHY133idfzMsgdOO/tE81N6D79Gm7sQSA=;
        b=Bo3VukFFkyEhbysKZ0qdTBb69nVsENhO9taa6YWKiC6r3GCGPuOTCTKHP/Ti1iV8VQ
         qNab2bfEGEh0cNLXP+SaLMAgAw0qqjfauzOGYGgNDC+B3SOmK0AEXnOdG8cFH+m3yRG5
         YI8CYD+da0S/i5DDrBTF2EfHhjA1Se7g98sM0rcU29zh+SpMErbaIEvbC+kvppUf1Fbq
         HrKxwSEBVICfGIig/4SnLr95E7pCPOBV/9GMF+UB2IZH7accmaz4vYqCGtuBMtfPd43f
         WRarGG+R5D+DdzO+3pUIQ3M1JYCMLIunAPrJmlwanutBhdM7aoI3i2VI2hGR0sqbWPw3
         yWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706002; x=1724310802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvruj7SsdqsHY133idfzMsgdOO/tE81N6D79Gm7sQSA=;
        b=ru+wEDw64iyly0RvXgPeY1J8MICFz4iMq9DN7Pugs4xAsQGG6wePJ8rHQXiLXpmv37
         xgCjprK2FcrwldhUaVUg9usmfNth2ZX0T6idN24kz2dZFQb7FmCvIMhHvLtUMINBa2R2
         xKPoOb6O2ClFf4SKP1ACEpVEklsyuP5jo9cwUMOL42HoVt6HqG1+XnrBpkAnDUCdacYm
         wj29soQomyKHvzpX1Dc1XNFbdW8czTm0PzHK80cY+/qPVJ4jZeDDYD8jD4N7Uovc9Tap
         MCcczGD1JpQyTC7dy/+rjEjCWzPXMYecN7CZ/6b9U+e2JFfljxbLmpSrazObSLv1XUN6
         0NQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5zn4a4jJAGIVQg8btUFUmGKtG22GLvJ9Bb/sd9QR2BhN0HsKNRrtVixokCJaQOUT6gJyfN45YfqdbPZ4Xxh4eBJgXglHmvt6h574p38MwGQY7LgAXSKzW7BMZfi55eeLZtQiL31C
X-Gm-Message-State: AOJu0YwhevAYWHM2zZ2MdUYep+f/7nyDXE8e0kDDSORcK5rx1WedxoaD
	G7TUkrEcwu+LZuPfTlypgP5d+qR0syD6fEeHGWSoPJs/o96YYLBLu3ESzniH
X-Google-Smtp-Source: AGHT+IH+IvT/Oj9VfFCVJHaRTlcxTgxmWb/kFvuImwpkR1wygBW0AcrPrsKQKoyntPTmuxV9TaWaJg==
X-Received: by 2002:a05:6a00:1996:b0:705:b6d3:4f15 with SMTP id d2e1a72fcca58-712673ea24fmr7223501b3a.25.1723706002330;
        Thu, 15 Aug 2024 00:13:22 -0700 (PDT)
Received: from embed-PC.. ([117.99.192.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b60a1122sm612431a12.0.2024.08.15.00.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:13:21 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: dan.scally@ideasonboard.com
Cc: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Thu, 15 Aug 2024 12:41:51 +0530
Message-Id: <20240815071151.585297-1-abhishektamboli9@gmail.com>
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


