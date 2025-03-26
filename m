Return-Path: <linux-kernel+bounces-577242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8DA71A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F94164AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52971F4184;
	Wed, 26 Mar 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="q9DYFxPv"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A41F2369
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002905; cv=none; b=iw71ZuPSvhoB3oBRnIFMi3KOHA0uiBRLFJGFyGbq9N3oSkr9PUCF3DXILu4FjU4kR4zcFzn1Tl8meldrcKegr4Wu/fjasYcoTREcNnX75WuHQJ1YtszBd2JEZvG7tFHXb3fXyiKkCMa8srf0PsKzswqvSP27oACbDivx/0d74VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002905; c=relaxed/simple;
	bh=In8mradJdyTsnSMN/Zx5eut5oPE9f935FbSWzJQjo2c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lthffWyCdXaNdvf5oLlEVFhwVcIO7K8iOuz27i5w4uoPQINKuRf6/RC+QYUGUR1wvDmfOR6JMajsDqbE/EesJ3qtr5bixxI8a/q8n+uO8q+huejOU6dBfw9KZaCe6DJTFJCNd3D2JbteexhWHqWmsLzCNs+Q+olYoLgPiOLKum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=q9DYFxPv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so53933886d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1743002902; x=1743607702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJkS3jBwTRqrbFKeqmQ5FYC+7YoE9yU80iE+FHpuAHI=;
        b=q9DYFxPv3ld2sh8neyVmUbZq3kLmMX+yaYLY7LWZ8n4n8fpHDPlcoyT9TS3vmWqnNx
         degK4/It7KNADfJ4bmGuywhNrb6EIz7cCCuirzqrp0B29Pt3PzNQKq4YxVkF8ad6EOAR
         Q1k1QdNtL2vZ9kMSpdeuW9ukEplrwSCvBGTl45v5bCjzTSMVm2NEZonq94pdxvXeEWMr
         gfdLeMGgQvbgg+VZ3rRKMYgjF6nbKOml1cz9Bds+XouiWY+1tB7we2PADDlW177uwJWa
         2812a3Fo3plJGCYYuKC6FkWCHiC72cHWEhMf4RBpcQtW+mgHuEu7WFtclcU6zhckmzsN
         UReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002902; x=1743607702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJkS3jBwTRqrbFKeqmQ5FYC+7YoE9yU80iE+FHpuAHI=;
        b=N7ofNkpt54keDhj+57Wf3vThFqoIJR0Ars/z9unc2dSJT0Trrfr4ePL23Gr+cIqa1w
         Gr8FourC39zM1vaiWVXBhWl6eho2C1etpHbaMKHnmGWd/borm9YAi+yE4m4ZvfSGuSSo
         c/Wdv8+EhZDy55sdWZf1Ej7QW1vCCd81gtSvV0moHSVZrp7xBwoXN8JMgt8faErZwpLj
         GHiLhN/VCn3Khgl1SdrrrwDjGqwfagnTY4D7r4pY1TNVvrOxzdoF93nwuTVY9mdigXp2
         I8jruZ7DKfI53I+y7rK0QvwKlL7jJkG+7/f7JHmieVb2S12Vp7yB8fFBoAvOqhpBo8CR
         N3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXaybvuRrnWLDIvQKTq8pk02GFpA21iXKZUT7xjsEkEmesBGrp5rBEkbu+r7uyMGqVkmwmhtXxZ10NB99w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVpw8+S2RcAtSErSEaHXSHRO9Qu4X0looovZME5kbm3d7sle/
	+bcnwnULWT8g3Zey55ZPzvr/YQX2ffQ+ktpgOEF2KcQbXv70NWTl1SH0wofe5g==
X-Gm-Gg: ASbGncv57MfUMO0Ka7eZG6YCHZMpGtteKRNUd2/vgX1Ga9wUMP5jXDKvFWqebxVgd5g
	7rRVOcutgY5dB0JY+1K3YFoYANmgd+Ha8a/kpCbbb3Lu30zl9QF9NC9RatI3x0SSmpkBGPc7F1e
	31jZSfl2YG2R34MQqYiOtoKUuqCI4vOzTr9j0nFsug8p3O9Ico6xSz5B4MoZEtoGEa0ECLm4PjF
	767BZc/Ox1pauN6lU577Vzv/MqI/q/LKCjcvsdnveeRKwJEySQmJT2T83qEja47c5yOVO3ekZz5
	XSBFbMnt5swSyfHM5J6cYnFxbiKBcF5+Aw0YaTNCE3rNArrumia/Dd2rmWKkhdgjbA8Q02LTSJF
	EBAuw/0/mrfwXzLNqu83vbB7NPd4r5FZGbhMKzw==
X-Google-Smtp-Source: AGHT+IGDdKxmHGc9gI357CBTixi7+PlBZCZDHIkgl+JsQcb4TNnysAcWbF5MH9GPPMx+dnQUp1PRmw==
X-Received: by 2002:a05:6214:224c:b0:6e8:ffb6:2f8e with SMTP id 6a1803df08f44-6eb3f332a55mr397418106d6.32.1743002902039;
        Wed, 26 Mar 2025 08:28:22 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc568csm68569916d6.92.2025.03.26.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:28:21 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:28:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	syzbot <syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] media: dvb: usb: Fix WARNING in
 dib0700_i2c_xfer/usb_submit_urb
Message-ID: <f8e975a0-87d2-4f83-b580-6858050a252d@rowland.harvard.edu>
References: <6bb3b80b-a808-4992-8666-535ed9a5c980@rowland.harvard.edu>
 <67e2fed5.050a0220.a7ebc.0053.GAE@google.com>
 <29db5fdc-13c9-45f0-9183-c80d637725c6@rowland.harvard.edu>
 <Z-MKiV0Ei5lmWik6@shikoro>
 <d0fd60d7-5660-42ed-b1c7-4dfd6b8e74b0@rowland.harvard.edu>
 <Z-MrfICsY06DZV-2@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-MrfICsY06DZV-2@shikoro>

The syzbot fuzzer reported a WARNING related to the dib0700 dvb-usb
driver:

usb 1-1: BOGUS control dir, pipe 80000f80 doesn't match bRequestType c0
WARNING: CPU: 1 PID: 5901 at drivers/usb/core/urb.c:413 usb_submit_urb+0x11d9/0x18c0 drivers/usb/core/urb.c:411
...
Call Trace:
 <TASK>
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
 dib0700_ctrl_rd drivers/media/usb/dvb-usb/dib0700_core.c:95 [inline]
 dib0700_i2c_xfer_legacy drivers/media/usb/dvb-usb/dib0700_core.c:315 [inline]
 dib0700_i2c_xfer+0xc53/0x1060 drivers/media/usb/dvb-usb/dib0700_core.c:361
 __i2c_transfer+0x866/0x2220
 i2c_transfer+0x271/0x3b0 drivers/i2c/i2c-core-base.c:2315
 i2cdev_ioctl_rdwr+0x452/0x710 drivers/i2c/i2c-dev.c:306
 i2cdev_ioctl+0x759/0x9f0 drivers/i2c/i2c-dev.c:467
 vfs_ioctl fs/ioctl.c:51 [inline]

Evidently the fuzzer submitted an I2C transfer containing a length-0
read message.  The dib0700 driver translated this more or less
literally into a length-0 USB read request.  But the USB protocol does
not allow reads to have length 0; all length-0 transfers are
considered to be writes.  Hence the WARNING above.

Fix the problem by adding the I2C_AQ_NO_ZERO_LEN_READ adapter quirk
flag to all the USB I2C adapter devices managed by dvb-usb-i2c.c,
following Wolfram Sang's suggestion.  This tells the I2C core not to
allow length-0 read messages.

Reported-by: syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com
Tested-by: syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/linux-usb/67e1a1f5.050a0220.a7ebc.0029.GAE@google.com/

---

v2: Move the static definition of the i2c_usb_quirks structure outside
the dvb_usb_i2c_init() function.

 drivers/media/usb/dvb-usb/dvb-usb-i2c.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: usb-devel/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
===================================================================
--- usb-devel.orig/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
+++ usb-devel/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
@@ -8,6 +8,10 @@
  */
 #include "dvb-usb-common.h"
 
+static const struct i2c_adapter_quirks i2c_usb_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 int dvb_usb_i2c_init(struct dvb_usb_device *d)
 {
 	int ret = 0;
@@ -24,6 +28,7 @@ int dvb_usb_i2c_init(struct dvb_usb_devi
 	strscpy(d->i2c_adap.name, d->desc->name, sizeof(d->i2c_adap.name));
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
+	d->i2c_adap.quirks    = &i2c_usb_quirks;
 	d->i2c_adap.dev.parent = &d->udev->dev;
 
 	i2c_set_adapdata(&d->i2c_adap, d);

