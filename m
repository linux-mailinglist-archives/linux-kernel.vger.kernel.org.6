Return-Path: <linux-kernel+bounces-342519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83030988FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DD6280CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5811C16FF26;
	Sat, 28 Sep 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arW4pOmJ"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC31474D8;
	Sat, 28 Sep 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536169; cv=none; b=lsKuS9yJcTtXS3HtHPTSGCWs8jTKAHpMSW36dH6JoiBcfb32+7Trfk0PVd4lv6pXC7FjZ095GkTJMDHPIU6ZQ6lwOW7F6ZcfbJ1F7neOGCzPIOwb+bFvMTf/eNRM4P7RgfSDzFdbJfeT1pbjyY9R9OEMpzrrdiuYDFRtZcxz3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536169; c=relaxed/simple;
	bh=DIC2P8HkVB9qMMyxjKjxHU/L50YrnmCLbRnLGFH7WeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6cKrazNwouKhRJ2EaCFqoVeowNpX4CC6BTkXwN3+X2YpIj16sr8OXB4yUsXINZR9TgaeBjJSjkpDHYPnKRYdyASpGdc8bMo3Zly2vM2tNlmA59gCkWjDXrKeYZOFx/mU+wD0uwuGNf9PKAl0mbp7XhmEr/VuJUYsO4P2CmLm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arW4pOmJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9a62c6734so26988085a.3;
        Sat, 28 Sep 2024 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536166; x=1728140966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MX5tEqh6uhy30KPRHM69PdB+zn/Kf6NCsv4Yh97r1Q=;
        b=arW4pOmJREFLScse3Q/KVVMbB0KMOz5YWoaV4SieBwOKGdhWZrvN1Uw8UujmyBArSX
         qZnaeyee3G0cMZMnXvNr5PS+BRbqjj5A3jmha97yKatJ/sAHaPwvgR74FvODHWd82sT6
         BehmWDW6SOqbqKfChkJXHngxP8QdUgG0E7BH/0MQstuimjb2oez4818Fwr3byswGLbce
         WlvHlUwCwUaDeZjTQ6uqrhHmyWnwJRgpd+zvg7clhmGDUXTH0wgFu85ngiAaMqiQ/CJ+
         224fmGXU8doGwcMKidsYrYHgZuH/pTWp0cORhAVVVgaZH57QC8UkuiEL1gsT5TwYwxqE
         g+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536166; x=1728140966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MX5tEqh6uhy30KPRHM69PdB+zn/Kf6NCsv4Yh97r1Q=;
        b=nmpx+SufzYNNFJgzydKI1XhI3nn8yiT15ME6eyJD9SYLbt44x4sXc4VPkBFQJ7YaFs
         vMn93edqq/ClUSTPa7J3gd9Kil8Tr9c4lYfxz4lr80MVP4kYIkKPLM61yT9bRDcksBaL
         +0FXdKQrxqxPugPKsr4WoO8pCjrBK1dKPfexzaRW0HM28BmTiyuNClBKtJOONG2tsRwl
         HRleEUVUY88qMsN9y2PBMj8ndj40r0CufX9qUhQUImoed5bZ1EEDkSjkTFVoUtpREVmJ
         zeXa30jAEsYWdc2oWxopZtPTBLty0guj7diiJsowuiJLs4q1clriFJJ8uzgnLKQGt16O
         YFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8J68VV9YuWFLGRNwMHhO1WPWbx5Hn2Ld9tmeBoHWksJFJnWyCyCsMtvc8yMRd6lvqGQmAroGb2pmxzhE7@vger.kernel.org, AJvYcCXWXQ/sVvwn5/O7mU5jGORl/Lero3XTfR8kYrJPOo3c8CjdKOwRaVaDAn34JUsxEhZQtA3N54owLbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RxZcniwVj1c5wsisy3fThIaKDuo46sorP94pytwr9DSzLjaf
	pIcTHObcFZeU61Md4Avynm89j3iGjJrQoE28LrQamtC+HB0tsO0MToCVZVKWcHg=
X-Google-Smtp-Source: AGHT+IEm0WTpxVpC7oDmcnf2jckEfckfCGS8eSpW94cEArO98OIGPoSDXUlQGXhzgJPxFCR8YXBrdQ==
X-Received: by 2002:a05:622a:c8:b0:458:21b3:63f with SMTP id d75a77b69052e-45c9f317f50mr47042161cf.13.1727536166087;
        Sat, 28 Sep 2024 08:09:26 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:25 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Gruber <jimmyjgruber@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	John Keeping <jkeeping@inmusicbrands.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lee Jones <lee@kernel.org>,
	Perr Zhang <perr@usb7.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH RFC 04/14] usb: gadget: f_uac2: Move max packet size code to a common header
Date: Sat, 28 Sep 2024 11:08:55 -0400
Message-ID: <20240928150905.2616313-5-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240928150905.2616313-1-crwulff@gmail.com>
References: <20240928150905.2616313-1-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <crwulff@gmail.com>

Moving this to allow it to be used by f_uac1 in the future.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c      | 116 ++--------------------
 drivers/usb/gadget/function/u_uac_utils.h | 111 +++++++++++++++++++++
 2 files changed, 122 insertions(+), 105 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 2142a0951f71..050789d2d3c9 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -112,16 +112,6 @@ enum {
 
 static struct usb_string strings_fn[NUM_STR_DESCRIPTORS + 1] = {};
 
-static const char *const speed_names[] = {
-	[USB_SPEED_UNKNOWN] = "UNKNOWN",
-	[USB_SPEED_LOW] = "LS",
-	[USB_SPEED_FULL] = "FS",
-	[USB_SPEED_HIGH] = "HS",
-	[USB_SPEED_WIRELESS] = "W",
-	[USB_SPEED_SUPER] = "SS",
-	[USB_SPEED_SUPER_PLUS] = "SS+",
-};
-
 static struct usb_gadget_strings str_fn = {
 	.language = 0x0409,	/* en-us */
 	.strings = strings_fn,
@@ -656,113 +646,29 @@ struct cntrl_subrange_lay3 {
 
 DECLARE_UAC2_CNTRL_RANGES_LAY3(srates, UAC_MAX_RATES);
 
-static int get_max_srate(const int *srates)
-{
-	int i, max_srate = 0;
-
-	for (i = 0; i < UAC_MAX_RATES; i++) {
-		if (srates[i] == 0)
-			break;
-		if (srates[i] > max_srate)
-			max_srate = srates[i];
-	}
-	return max_srate;
-}
-
-static int get_max_bw_for_bint(const struct f_uac2_opts *uac2_opts,
-	u8 bint, unsigned int factor, bool is_playback)
+static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_opts *uac2_opts,
+	struct usb_endpoint_descriptor *ep_desc,
+	enum usb_device_speed speed, bool is_playback)
 {
-	int chmask, srate, ssize;
-	u16 max_size_bw;
+	int chmask, srate, ssize, hs_bint, sync;
 
 	if (is_playback) {
 		chmask = uac2_opts->p_chmask;
 		srate = get_max_srate(uac2_opts->p_srates);
 		ssize = uac2_opts->p_ssize;
+		hs_bint = uac2_opts->p_hs_bint;
+		sync = USB_ENDPOINT_SYNC_ASYNC;
 	} else {
 		chmask = uac2_opts->c_chmask;
 		srate = get_max_srate(uac2_opts->c_srates);
 		ssize = uac2_opts->c_ssize;
+		hs_bint = uac2_opts->c_hs_bint;
+		sync = uac2_opts->c_sync;
 	}
 
-	if (is_playback || (uac2_opts->c_sync == USB_ENDPOINT_SYNC_ASYNC)) {
-		// playback is always async, capture only when configured
-		// Win10 requires max packet size + 1 frame
-		srate = srate * (1000 + uac2_opts->fb_max) / 1000;
-		// updated srate is always bigger, therefore DIV_ROUND_UP always yields +1
-		max_size_bw = num_channels(chmask) * ssize *
-			(DIV_ROUND_UP(srate, factor / (1 << (bint - 1))));
-	} else {
-		// adding 1 frame provision for Win10
-		max_size_bw = num_channels(chmask) * ssize *
-			(DIV_ROUND_UP(srate, factor / (1 << (bint - 1))) + 1);
-	}
-	return max_size_bw;
-}
-
-static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_opts *uac2_opts,
-	struct usb_endpoint_descriptor *ep_desc,
-	enum usb_device_speed speed, bool is_playback)
-{
-	u16 max_size_bw, max_size_ep;
-	u8 bint, opts_bint;
-	char *dir;
-
-	switch (speed) {
-	case USB_SPEED_FULL:
-		max_size_ep = 1023;
-		// fixed
-		bint = ep_desc->bInterval;
-		max_size_bw = get_max_bw_for_bint(uac2_opts, bint, 1000, is_playback);
-		break;
-
-	case USB_SPEED_HIGH:
-	case USB_SPEED_SUPER:
-		max_size_ep = 1024;
-		if (is_playback)
-			opts_bint = uac2_opts->p_hs_bint;
-		else
-			opts_bint = uac2_opts->c_hs_bint;
-
-		if (opts_bint > 0) {
-			/* fixed bint */
-			bint = opts_bint;
-			max_size_bw = get_max_bw_for_bint(uac2_opts, bint, 8000, is_playback);
-		} else {
-			/* checking bInterval from 4 to 1 whether the required bandwidth fits */
-			for (bint = 4; bint > 0; --bint) {
-				max_size_bw = get_max_bw_for_bint(
-					uac2_opts, bint, 8000, is_playback);
-				if (max_size_bw <= max_size_ep)
-					break;
-			}
-		}
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	if (is_playback)
-		dir = "Playback";
-	else
-		dir = "Capture";
-
-	if (max_size_bw <= max_size_ep)
-		dev_dbg(dev,
-			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
-			speed_names[speed], dir, max_size_bw, bint);
-	else {
-		dev_warn(dev,
-			"%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
-			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
-		max_size_bw = max_size_ep;
-	}
-
-	ep_desc->wMaxPacketSize = cpu_to_le16(max_size_bw);
-	ep_desc->bInterval = bint;
-
-	return 0;
+	return uac_set_ep_max_packet_size_bint(
+		dev, ep_desc, speed, is_playback, hs_bint, chmask,
+		srate, ssize, sync, uac2_opts->fb_max);
 }
 
 static struct uac2_feature_unit_descriptor *build_fu_desc(int chmask)
diff --git a/drivers/usb/gadget/function/u_uac_utils.h b/drivers/usb/gadget/function/u_uac_utils.h
index 5f88e31103dd..7ef9f699657c 100644
--- a/drivers/usb/gadget/function/u_uac_utils.h
+++ b/drivers/usb/gadget/function/u_uac_utils.h
@@ -214,4 +214,115 @@ end:									\
 									\
 CONFIGFS_ATTR(prefix##_, name)
 
+/*
+ * Functions for EP interval and max packet size
+ */
+
+static const char *const speed_names[] = {
+	[USB_SPEED_UNKNOWN] = "UNKNOWN",
+	[USB_SPEED_LOW] = "LS",
+	[USB_SPEED_FULL] = "FS",
+	[USB_SPEED_HIGH] = "HS",
+	[USB_SPEED_WIRELESS] = "W",
+	[USB_SPEED_SUPER] = "SS",
+	[USB_SPEED_SUPER_PLUS] = "SS+",
+};
+
+static int get_max_srate(const int *srates)
+{
+	int i, max_srate = 0;
+
+	for (i = 0; i < UAC_MAX_RATES; i++) {
+		if (srates[i] == 0)
+			break;
+		if (srates[i] > max_srate)
+			max_srate = srates[i];
+	}
+	return max_srate;
+}
+
+static int get_max_bw_for_bint(u8 bint, unsigned int factor, int chmask,
+			       int srate, int ssize, int sync, int fb_max)
+{
+	u16 max_size_bw;
+
+	if (sync == USB_ENDPOINT_SYNC_ASYNC) {
+		// playback is always async, capture only when configured
+		// Win10 requires max packet size + 1 frame
+		srate = srate * (1000 + fb_max) / 1000;
+		// updated srate is always bigger, therefore DIV_ROUND_UP always yields +1
+		max_size_bw = num_channels(chmask) * ssize *
+			(DIV_ROUND_UP(srate, factor / (1 << (bint - 1))));
+	} else {
+		// adding 1 frame provision for Win10
+		max_size_bw = num_channels(chmask) * ssize *
+			(DIV_ROUND_UP(srate, factor / (1 << (bint - 1))) + 1);
+	}
+	return max_size_bw;
+}
+
+static int uac_set_ep_max_packet_size_bint(struct device *dev,
+	struct usb_endpoint_descriptor *ep_desc,
+	enum usb_device_speed speed, bool is_playback, int hs_bint,
+	int chmask, int srate, int ssize, int sync, int fb_max)
+{
+	u16 max_size_bw, max_size_ep;
+	u8 bint;
+	char *dir;
+
+	switch (speed) {
+	case USB_SPEED_FULL:
+		max_size_ep = 1023;
+		// fixed
+		bint = ep_desc->bInterval;
+		max_size_bw = get_max_bw_for_bint(bint, 1000, chmask, srate,
+						  ssize, sync, fb_max);
+		break;
+
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		max_size_ep = 1024;
+		if (hs_bint > 0) {
+			/* fixed bint */
+			bint = hs_bint;
+			max_size_bw = get_max_bw_for_bint(bint, 8000, chmask, srate,
+							  ssize, sync, fb_max);
+		} else {
+			/* checking bInterval from 4 to 1 whether the required bandwidth fits */
+			for (bint = 4; bint > 0; --bint) {
+				max_size_bw = get_max_bw_for_bint(
+					bint, 8000, chmask, srate,
+					ssize, sync, fb_max);
+				if (max_size_bw <= max_size_ep)
+					break;
+			}
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (is_playback)
+		dir = "Playback";
+	else
+		dir = "Capture";
+
+	if (max_size_bw <= max_size_ep)
+		dev_dbg(dev,
+			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
+			speed_names[speed], dir, max_size_bw, bint);
+	else {
+		dev_warn(dev,
+			"%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
+			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
+		max_size_bw = max_size_ep;
+	}
+
+	ep_desc->wMaxPacketSize = cpu_to_le16(max_size_bw);
+	ep_desc->bInterval = bint;
+
+	return 0;
+}
+
 #endif	/* __U_UAC_UTILS_H */
-- 
2.43.0


