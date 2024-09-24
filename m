Return-Path: <linux-kernel+bounces-337197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ABC9846CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572381C22850
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFC1A76D7;
	Tue, 24 Sep 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2KWoiTG"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB71A7248
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184815; cv=none; b=PIni+zjfmaFMtD5pRlu2iJBWX5Jtk6/Z47zxtz9CJ/OOT+uH8MoeeRbxCyIzrwIcP0VIWbanYeccGAQ0nw1cTJYhVAKdXUtaePn8pH7Ys3D812EwSHaDI8VSYFfE8gIC0le8KyVlnUWpeq0fHqScuEgeHWoNftny0HAvSTOqrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184815; c=relaxed/simple;
	bh=cEq7D7GYogekk6JdLCtsg3CQebwP5ANi5/On67Tn6vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mWbPeNU9V3cd4BaDXARIiuuA0HkjX5EIuxB1hTRrjweIU+wK0koiXzUQxC0JA2bP2nXTAaaYaD/4BBOOylGByrwuQ/AWI8UhzJAltqTkVKg2LfUJYoaf3ypdJlaugSF7IT7l5Lvu02ZGWGibnZu/h2Z2KrX+K3p1riw2rERLFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F2KWoiTG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4581ec0e00eso41549561cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727184812; x=1727789612; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z0qxOdupfIRXdbnkFD/B9bzDAeZi9Dt7I+vMO5OZG4=;
        b=F2KWoiTG3RXazKszp465W3qDa5l5UEuCK6a6CVVvqoRXykIymyr9F7k/BA3A5btQ5h
         uyS3n+INiZxUREDrC3QIyKx1W0rHeq8RpiREMDrlxsn/21r4Nz4JI29qayTC8rtRqzhS
         rRpPNFDSADt53R4o4OBeNt7RbYtlE1T9rKRVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184812; x=1727789612;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z0qxOdupfIRXdbnkFD/B9bzDAeZi9Dt7I+vMO5OZG4=;
        b=Ltbb7IzLdzCYTNebmHSashm4C+37jSy3u9OCfyAXyZ5H/SmFNLnAI4ftPqqH96rg1+
         oVOf7Py4X6KZNubMQb8oTyBmonfFSy3R+sQ/mVrywX+B4+a3kEbkalp5N/JDuz217cCz
         Ec1zNhF6FhNZvRyK7x2X7moO5pS91gUYeo63ozrlylYFxXpVeHk0JYLGI6nW4+nNqkTt
         u015/ZUPWgWvWr85UlIxbqO+cLAiv6PRiUBHFBOdiwqq6lHWvdInJdwzfTqytwkTVn0d
         ouX4G4I4cWSRvKRPekdL/8gc1PFJ+NzBK7k4WwRHRvYuocSpAlHZL8rfGpmXr5c0WwX/
         j1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXFHCtXiSSm9BUWoAkRqV8Ison6ZytPuQLF0y2ZTDtnXxh4iMEfuUc7njHt+IyaRhP6Y0q2uKmznT6OhdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOnVGeKdvt/t+tMjQxcK7zQhf2F9KdWYb2te0RqQoZkM7UX2f
	1DlauTAAHXe/TzSAcDVdwSTm8pvEAEYa0WahGY0gVTLqfGkjeyQVYyGLV29BKA==
X-Google-Smtp-Source: AGHT+IEAbFJ2gs9LVV/+qhJ79xlUVTJtnBUQy0Wwae8OfDu95Oooo07L6KtmIVjtfF14G2a9ZF9lPQ==
X-Received: by 2002:ac8:5792:0:b0:458:2607:d5a7 with SMTP id d75a77b69052e-45b228a9d4fmr277173571cf.43.1727184811673;
        Tue, 24 Sep 2024 06:33:31 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b52572710sm6335101cf.22.2024.09.24.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:33:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 24 Sep 2024 13:33:29 +0000
Subject: [PATCH] media: uvcvideo: Force UVC version to 1.0a for 0408:4033
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-uvc-quanta-v1-1-2de023863767@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKm/8mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMT3dKyZN3C0sS8kkRdU6NEQyODRCNz87RUJaCGgqLUtMwKsGHRsbW
 1AAZ0cltcAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Giuliano Lotta <giuliano.lotta@gmail.com>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The Quanta ACER HD User Facing camera reports a UVC 1.50 version, but
implements UVC 1.0a as shown by the UVC probe control being 26 bytes
long. Force the UVC version for that device.

Reported-by: Giuliano Lotta <giuliano.lotta@gmail.com>
Closes: https://lore.kernel.org/linux-media/fce4f906-d69b-417d-9f13-bf69fe5c81e3@koyu.space/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f0febdc08c2d..cc62bdf77c08 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2431,6 +2431,17 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
  */
 static const struct usb_device_id uvc_ids[] = {
 	/* Quanta ACER HD User Facing */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x0408,
+	  .idProduct		= 0x4033,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&(const struct uvc_device_info){
+		.uvc_version = 0x010a,
+	  } },
+	/* Quanta ACER HD User Facing */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
 	  .idVendor		= 0x0408,

---
base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
change-id: 20240924-uvc-quanta-52a120a277fe

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


