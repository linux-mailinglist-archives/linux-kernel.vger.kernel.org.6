Return-Path: <linux-kernel+bounces-427542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92B9E029B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295951618CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166061FC0F4;
	Mon,  2 Dec 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6ZL0xRI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F41FECC7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144282; cv=none; b=YT6JvYbPFVbz4FEw78io/ThEhTBWUA2iQJBsuiKSZKOBo7GRu6CoIf9Kbw0gUZyRuC9Fqdw0rKEJ5VOB0QNvM3XqQ7Xn6WNmvYERbE7ujWcr9Z/TPvZRTzmu5NmR41mTxrJxnJDfQBnDuBzwXuL8w64SWHfuRK066Gbfvrx8kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144282; c=relaxed/simple;
	bh=GEQTVkp0q7S6wbPvLRUNqVr9Oj8O3XKdaZNNO+BsE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FKIPu4CoLrfZJmM1XMvv7e0tslC3+f5J2YLJzPp/EbYcbX0MfA0g8kU7V64iBt+AHW9yKZk1o8CnoH1q4gRhKhU7r/yjx+1XAo9o3lcAeh3qOwG26wAf0f7wvGxqjn2VvLJx67gIht+2cYk6GtvHp/FTKR2+f+i0TbMUq5yrbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6ZL0xRI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1309667f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733144279; x=1733749079; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZEzOmy1c1zMqWMX7Wa3GA2/fvlPtEiXHjsYcmo7LSw=;
        b=q6ZL0xRIu3aL2KyRhkSIo0cPAs4T9/ZGXOMmadRsXoW/3S7lcYEvw/fuy1oFiaB0LL
         hSQzAWjNInzf05PZhRkA1fbEIRXaElY8iwURlelf8iXWY/Y07XyLCXYC85Fc7E3CI5c5
         ExU8vekbT/oOX1lrQ3qc/HR9r2/xjylOosUSxT04SXayGoaxvhpUHjh+kH3ECXUa7ab8
         wzzuhow3DD20QVu2d3zdWs286p18yDP2rOXUxNbLowuyFY5CM0/alk9Ldi8FQ5s2xWUh
         sTLXO5oNFz8mzOElU+YxMI1LE5rVak1aRAw/C0l8wI251ZqVJMkNLXUi47iq+n1/Fhrf
         T3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144279; x=1733749079;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZEzOmy1c1zMqWMX7Wa3GA2/fvlPtEiXHjsYcmo7LSw=;
        b=T1tvYQAqe9/Y8wJqpCObpd0exiDussCkgxnAxx54IC9XWN/Wa/g/xure26ss38/KIi
         Qne8fxe9+qiLqc1mY6pR7jY0eLai5kOXNTax6imRiFpcpahoxozcO5ib11yhl/FkhJAv
         uMJvtRfoD1XrHxDvwpYN8y8ibqgsUgyISL87DvQbgRCaR8tmzOELehN26VpBuO/1dsOw
         LJ/CfH6EVvN1Q3ZAAP0uCFyoU38x+rm/iTv35KK1vAy3OTvzeuHb6r9xDxT5ccsvTxpr
         QhUw8bBCNpGumwmp3Wefo5sCFov+/MkI6QU6WdYyKz+8uwa58JJ2a/bROVS5QUBpdtiA
         tMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5fADFRj92KQtxjCx5Q3E/uviYvmm2db7VaZEhNrS1pMlkp9jsEihNlBiQ4BIGkCLOpPajx2mJI9t4to=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsr1/w8kKaa5ZEIKbVYXmyJxKAKOrKfSs4aOwezicB3VH7b03
	VhWrPMLO2kZlvsTNs97eqaK1O0UbN2mVCh67kjA3nnYcJhTlBF/sBCmjIYq6eIU=
X-Gm-Gg: ASbGnctJ4FR8xPCK3RrGFXv7+mtoQqpZWvJifQf1HbGrVdlQUnmt65PE4XN0uoYfBZv
	Vo79Bss3tuT9PS3mk7k6MHz2PB0DzmaTXtsZCfWPg54w97qQ/RFrjMRtdI7jv8Q8fzfJgEg2wHb
	GQYcVAfbpxFcOuh74o0bQGP/UaveBoHzAwvGPDPuZAbkUS09IU0kPkaMUXq5fj0F6f/q85ux0ms
	Y5XdMmfoUx1DrycZ52dKk9T9AP+/U84xOjV0AMUPDGXsNKlYDE5xPI=
X-Google-Smtp-Source: AGHT+IE6fYWnBhMoQgAuqEUuYRVJcRW1Ua9iOjCZrmiZOy42mMa37ZKinsmWcYvq0V848TnBhQipiA==
X-Received: by 2002:a05:6000:2b12:b0:385:df43:223c with SMTP id ffacd0b85a97d-385df432391mr8837794f8f.13.1733144278635;
        Mon, 02 Dec 2024 04:57:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f18bsm187503585e9.4.2024.12.02.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:57:58 -0800 (PST)
Date: Mon, 2 Dec 2024 15:57:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Lianqin Hu <hulianqin@vivo.com>,
	Shen Lichuan <shenlichuan@vivo.com>, Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix a DMA to stack memory bug
Message-ID: <60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The usb_get_descriptor() function does DMA so we're not allowed
to use a stack buffer for that.  Doing DMA to the stack is not portable
all architectures.  Move the "new_device_descriptor" from being stored
on the stack and allocate it with kmalloc() instead.

Fixes: b909df18ce2a ("ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices")
Cc: stable@kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/usb/quirks.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8bc959b60be3..7c9d352864da 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -555,7 +555,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interface *intf)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
@@ -566,15 +566,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interfac
 				      0x10, 0x43, 0x0001, 0x000a, NULL, 0);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
+
+		new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+		if (!new_device_descriptor)
+			return -ENOMEM;
 		err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&new_device_descriptor, sizeof(new_device_descriptor));
+				new_device_descriptor, sizeof(*new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+		if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-				new_device_descriptor.bNumConfigurations);
+				new_device_descriptor->bNumConfigurations);
 		else
-			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+			memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 		err = usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -906,7 +910,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -941,15 +945,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "device initialised!\n");
 
+	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+	if (!new_device_descriptor)
+		return -ENOMEM;
+
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&new_device_descriptor, sizeof(new_device_descriptor));
+		new_device_descriptor, sizeof(*new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-			new_device_descriptor.bNumConfigurations);
+			new_device_descriptor->bNumConfigurations);
 	else
-		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
@@ -1259,7 +1267,7 @@ static void mbox3_setup_defaults(struct usb_device *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
 	int err;
 	int descriptor_size;
 
@@ -1272,15 +1280,19 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
 
+	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
+	if (!new_device_descriptor)
+		return -ENOMEM;
+
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&new_device_descriptor, sizeof(new_device_descriptor));
+		new_device_descriptor, sizeof(*new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
-	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
 		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
-			new_device_descriptor.bNumConfigurations);
+			new_device_descriptor->bNumConfigurations);
 	else
-		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
-- 
2.45.2


