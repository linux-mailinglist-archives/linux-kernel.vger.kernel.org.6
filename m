Return-Path: <linux-kernel+bounces-342518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A6988FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D401F21389
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40451494B1;
	Sat, 28 Sep 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNieBaWR"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE1136352;
	Sat, 28 Sep 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536166; cv=none; b=nyKnnqo+2/8M8LGXhsteyl2OuS2PRKX81iTK4v0WrgrZXfpTHUoQyMQkRYTM3eKZ7m29+aAYsu/1OXGjBvxVo9R54KfdnWg5a/R/7FSo0Ox6JTp/hbIy+LDRdjZ03rtp8mZd2wzbF+2QS2RQ8kOXwzRsGNBckInblqpFTTIqxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536166; c=relaxed/simple;
	bh=z0X2xVY0aS8zlwN/lvqnVJjE5yAtz9tjufvdhNlOvIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbMByOu+lJC0Rqs/WQQOvWclgZgYKOIanHFL5VboIqzN23lHT7Nm2NeFDG/dIlB8y+gj/ne1oMJmUUeDbh9zpljnSJWMA3bmZC48O0Zwfo13RApGWoJrfdXPIHfEn5U0FRxRUNHu6S/X0GF0BpGMZZohEt0evUxWu9nC0HMgLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNieBaWR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb48e77b16so1927136d6.0;
        Sat, 28 Sep 2024 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536163; x=1728140963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuzSoXaQeZoL4jPbk74ZB4LmK4V9Zc/pikziXjh7WQk=;
        b=QNieBaWRQ/pmz8cZQy/5Zb5/4K21I4mhsvJ8h/a3LVw0RfmvuAZQaWZZKkwNYPKANe
         EF8VIlBr4lNY4GoZFjIfCcEP42kiDbN6DLWfiCwIiCZYjoIGBURSiJV1TMdZtCxAaOln
         Unb8n9oUWKdTz2I8b7AvO9gttAK06JxmzlbAJhoSgNx8Bgem+4sY7ylT47+bRicSPqRP
         IuAsq/Qw+s/gEf+Gad4Qyu8uONIf2WOb6fO03ld3o64PYAoHbFJ12AUsmS9U/wXKHmDY
         ldUfQMhDsz7E5LokI5QIB7Az//CuRcbfPC+hFqF/lPRQ/lS3NlgyodobzocE9BTcHaG0
         dNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536163; x=1728140963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuzSoXaQeZoL4jPbk74ZB4LmK4V9Zc/pikziXjh7WQk=;
        b=kiY1lJaVx1jwfVLo4O9lk/c+k6FwqlpgDH3BBkLbMrVommJVSMvguKuoFl1X/vIJD7
         IxjO6Mh7AAoGKAwo5xWwqcpRECgzHjF/kHqzxUQPiW3mslQZJUteNGK9etzxQnSaJ3RO
         whmtEm++MYaMiuzDqvM6Oufnhv1KFqhMFOiGowyLmNil2pBOAXtK0nmVmdv30uS5eEwt
         PtZqKLzeh9p5PMJQOTABxBuLDzf93ICwO9J9wuKy0PCVeyTRWAXRlLfUtRUa6QdQ4DOp
         IXQo0vlr5M68d/eaajAr7P37mUpxphYO+Z0ISNsWeYJrKTf4btXWGa3ibk7vDOgudtg2
         kUxg==
X-Forwarded-Encrypted: i=1; AJvYcCVnB3anNB71Z8BKptDewksp1PV3ptFcMLwq74SHYfND8/Ydh5puY8QShvlsyZC2XWZJn9YHNvGAbqlrB6Lq@vger.kernel.org, AJvYcCWwXvSo/r5eHlow5Xxk4WVtsNw54x0qXVWsrUaOO7yCtpU8Lq3jYQnFXwA8d/6EMwzs13C/0CfEWN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmT2YLuDBd+gr3uhLh6cM8AlnbsBdCkWLSOkRxebVDi2EmVal
	FesKIJYVV0NMn3t/Vfk89MmG4S8rF3uSf5Vf1/r3OzcU0LtCdmEEv48STCKepdg=
X-Google-Smtp-Source: AGHT+IGCpZW7Ox6nf5NyXR6WfoiIZbJSap5/P8lAF7P/FMsLF0WFMXqPfAqFn1hG+F9BEOIQhAMpjQ==
X-Received: by 2002:ac8:5a41:0:b0:458:31ee:74f6 with SMTP id d75a77b69052e-45cadcd22a5mr19607421cf.11.1727536163383;
        Sat, 28 Sep 2024 08:09:23 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:22 -0700 (PDT)
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
Subject: [PATCH RFC 03/14] usb: gadget: f_uac1: Add adaptive sync support for capture
Date: Sat, 28 Sep 2024 11:08:54 -0400
Message-ID: <20240928150905.2616313-4-crwulff@gmail.com>
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

Allow the user to configure async or adaptive mode for data from
the host. Enabling async mode will include the feedback endpoint.
This functions the same as UAC2.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 .../ABI/testing/configfs-usb-gadget-uac1      |   3 +
 Documentation/usb/gadget-testing.rst          |   2 +
 drivers/usb/gadget/function/f_uac1.c          | 101 +++++++++++++++++-
 drivers/usb/gadget/function/u_uac1.h          |   3 +
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index 64188a85592b..758b8c9a988a 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -8,6 +8,8 @@ Description:
 		c_chmask		capture channel mask
 		c_srate			list of capture sampling rates (comma-separated)
 		c_ssize			capture sample size (bytes)
+		c_sync			capture synchronization type
+					(async/adaptive)
 		c_mute_present		capture mute control enable
 		c_volume_present	capture volume control enable
 		c_volume_min		capture volume control min value
@@ -16,6 +18,7 @@ Description:
 					(in 1/256 dB)
 		c_volume_res		capture volume control resolution
 					(in 1/256 dB)
+		fb_max			maximum extra bandwidth in async mode
 		p_chmask		playback channel mask
 		p_srate			list of playback sampling rates (comma-separated)
 		p_ssize			playback sample size (bytes)
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index bf555c2270f5..68fc0011b388 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -952,11 +952,13 @@ The uac1 function provides these attributes in its function directory:
 	c_chmask         capture channel mask
 	c_srate          list of capture sampling rates (comma-separated)
 	c_ssize          capture sample size (bytes)
+	c_sync           capture synchronization type (async/adaptive)
 	c_mute_present   capture mute control enable
 	c_volume_present capture volume control enable
 	c_volume_min     capture volume control min value (in 1/256 dB)
 	c_volume_max     capture volume control max value (in 1/256 dB)
 	c_volume_res     capture volume control resolution (in 1/256 dB)
+	fb_max           maximum extra bandwidth in async mode
 	p_chmask         playback channel mask
 	p_srate          list of playback sampling rates (comma-separated)
 	p_ssize          playback sample size (bytes)
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index f68d444d1961..84423d9a8bd7 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -33,6 +33,7 @@
 			|| (_opts)->p_volume_present)
 #define FUOUT_EN(_opts) ((_opts)->c_mute_present \
 			|| (_opts)->c_volume_present)
+#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
 
 struct f_uac1 {
 	struct g_audio g_audio;
@@ -305,6 +306,48 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.wLockDelay =		0,
 };
 
+/* STD AS ISO IN Feedback Endpoint */
+static struct usb_endpoint_descriptor fs_as_in_fback_desc = {
+	.bLength = USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(3),
+	.bInterval = 1,
+	.bRefresh = 0,
+	.bSynchAddress = 0,
+};
+
+static struct usb_endpoint_descriptor hs_as_in_fback_desc = {
+	.bLength = USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(4),
+	.bInterval = 4,
+	.bRefresh = 0,
+	.bSynchAddress = 0,
+};
+
+static struct usb_endpoint_descriptor ss_as_in_fback_desc = {
+	.bLength = USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(4),
+	.bInterval = 4,
+	.bRefresh = 0,
+	.bSynchAddress = 0,
+};
+
+static struct usb_ss_ep_comp_descriptor ss_as_in_fback_desc_comp = {
+	.bLength		= sizeof(ss_as_in_fback_desc_comp),
+	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst		= 0,
+	.bmAttributes		= 0,
+	.wBytesPerInterval	= cpu_to_le16(4),
+};
+
 static struct usb_descriptor_header *f_audio_fs_desc[] = {
 	(struct usb_descriptor_header *)&ac_interface_desc,
 	(struct usb_descriptor_header *)&ac_header_desc,
@@ -327,6 +370,7 @@ static struct usb_descriptor_header *f_audio_fs_desc[] = {
 
 	(struct usb_descriptor_header *)&fs_as_out_ep_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&fs_as_in_fback_desc,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
@@ -361,6 +405,7 @@ static struct usb_descriptor_header *f_audio_hs_desc[] = {
 
 	(struct usb_descriptor_header *)&hs_as_out_ep_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&hs_as_in_fback_desc,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
@@ -435,6 +480,8 @@ static struct usb_descriptor_header *f_audio_ss_desc[] = {
 	(struct usb_descriptor_header *)&ss_as_out_ep_desc,
 	(struct usb_descriptor_header *)&ss_as_out_ep_desc_comp,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&ss_as_in_fback_desc,
+	(struct usb_descriptor_header *)&ss_as_in_fback_desc_comp,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
@@ -1236,9 +1283,11 @@ static void setup_headers(struct f_uac1_opts *opts,
 {
 	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *epin_fback_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
 	struct usb_endpoint_descriptor *epout_desc;
 	struct usb_endpoint_descriptor *epin_desc;
+	struct usb_endpoint_descriptor *epin_fback_desc;
 	struct usb_endpoint_descriptor *ep_int_desc;
 	int i;
 
@@ -1246,11 +1295,13 @@ static void setup_headers(struct f_uac1_opts *opts,
 	case USB_SPEED_FULL:
 		epout_desc = &fs_as_out_ep_desc;
 		epin_desc = &fs_as_in_ep_desc;
+		epin_fback_desc = &fs_as_in_fback_desc;
 		ep_int_desc = &fs_ac_int_ep_desc;
 		break;
 	case USB_SPEED_HIGH:
 		epout_desc = &hs_as_out_ep_desc;
 		epin_desc = &hs_as_in_ep_desc;
+		epin_fback_desc = &hs_as_in_fback_desc;
 		ep_int_desc = &hs_ac_int_ep_desc;
 		break;
 	default:
@@ -1258,6 +1309,8 @@ static void setup_headers(struct f_uac1_opts *opts,
 		epin_desc = &ss_as_in_ep_desc;
 		epout_desc_comp = &ss_as_out_ep_desc_comp;
 		epin_desc_comp = &ss_as_in_ep_desc_comp;
+		epin_fback_desc = &ss_as_in_fback_desc;
+		epin_fback_desc_comp = &ss_as_in_fback_desc_comp;
 		ep_int_desc = &ss_ac_int_ep_desc;
 		ep_int_desc_comp = &ss_ac_int_ep_desc_comp;
 	}
@@ -1296,6 +1349,12 @@ static void setup_headers(struct f_uac1_opts *opts,
 			headers[i++] = USBDHDR(epout_desc_comp);
 
 		headers[i++] = USBDHDR(&as_iso_out_desc);
+
+		if (EPOUT_FBACK_IN_EN(opts)) {
+			headers[i++] = USBDHDR(epin_fback_desc);
+			if (epin_fback_desc_comp)
+				headers[i++] = USBDHDR(epin_fback_desc_comp);
+		}
 	}
 	if (EPIN_EN(opts)) {
 		headers[i++] = USBDHDR(&as_in_interface_alt_0_desc);
@@ -1509,6 +1568,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (status < 0)
 		goto err_free_fu;
 	ac_interface_desc.bInterfaceNumber = status;
+	ac_interface_desc.bNumEndpoints = 1;
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
 
@@ -1523,6 +1583,23 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
 		uac1->as_out_intf = status;
 		uac1->as_out_alt = 0;
+
+		if (EPOUT_FBACK_IN_EN(audio_opts)) {
+			fs_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
+			hs_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
+			ss_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
+			ac_interface_desc.bNumEndpoints++;
+		} else {
+			fs_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
+			hs_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
+			ss_as_out_ep_desc.bmAttributes =
+			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
+		}
 	}
 
 	if (EPIN_EN(audio_opts)) {
@@ -1569,6 +1646,17 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 		audio->out_ep = ep;
 		audio->out_ep->desc = &fs_as_out_ep_desc;
+
+		if (EPOUT_FBACK_IN_EN(audio_opts)) {
+			ep = usb_ep_autoconfig(cdev->gadget, &fs_as_in_fback_desc);
+			if (!ep)
+				goto err_free_fu;
+
+			hs_as_in_fback_desc.bEndpointAddress = fs_as_in_fback_desc.bEndpointAddress;
+			ss_as_in_fback_desc.bEndpointAddress = fs_as_in_fback_desc.bEndpointAddress;
+
+			audio->in_ep_fback = ep;
+		}
 	}
 
 	if (EPIN_EN(audio_opts)) {
@@ -1631,7 +1719,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		audio->params.c_fu.volume_res = audio_opts->c_volume_res;
 	}
 	audio->params.req_number = audio_opts->req_number;
-	audio->params.fb_max = FBACK_FAST_MAX;
+	audio->params.fb_max = audio_opts->fb_max;
 	if (FUOUT_EN(audio_opts) || FUIN_EN(audio_opts))
 		audio->notify = audio_notify;
 
@@ -1678,6 +1766,10 @@ static struct configfs_item_operations f_uac1_item_ops = {
 	UAC_ATTRIBUTE(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,		\
 		      opts->lock, opts->refcnt, type, name)
 
+#define UAC1_ATTRIBUTE_SYNC(name)					\
+	UAC_ATTRIBUTE_SYNC(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,	\
+			   opts->lock, opts->refcnt, name)
+
 #define UAC1_RATE_ATTRIBUTE(name)					\
 	UAC_RATE_ATTRIBUTE(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,	\
 			   opts->lock, opts->refcnt, name)
@@ -1688,6 +1780,7 @@ static struct configfs_item_operations f_uac1_item_ops = {
 
 UAC1_ATTRIBUTE(u32, c_chmask);
 UAC1_RATE_ATTRIBUTE(c_srate);
+UAC1_ATTRIBUTE_SYNC(c_sync);
 UAC1_ATTRIBUTE(u32, c_ssize);
 UAC1_ATTRIBUTE(u32, p_chmask);
 UAC1_RATE_ATTRIBUTE(p_srate);
@@ -1706,6 +1799,8 @@ UAC1_ATTRIBUTE(s16, c_volume_min);
 UAC1_ATTRIBUTE(s16, c_volume_max);
 UAC1_ATTRIBUTE(s16, c_volume_res);
 
+UAC1_ATTRIBUTE(u32, fb_max);
+
 UAC1_ATTRIBUTE_STRING(function_name);
 
 UAC1_ATTRIBUTE_STRING(p_it_name);
@@ -1721,11 +1816,13 @@ UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
 static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_chmask,
 	&f_uac1_opts_attr_c_srate,
+	&f_uac1_opts_attr_c_sync,
 	&f_uac1_opts_attr_c_ssize,
 	&f_uac1_opts_attr_p_chmask,
 	&f_uac1_opts_attr_p_srate,
 	&f_uac1_opts_attr_p_ssize,
 	&f_uac1_opts_attr_req_number,
+	&f_uac1_opts_attr_fb_max,
 
 	&f_uac1_opts_attr_p_mute_present,
 	&f_uac1_opts_attr_p_volume_present,
@@ -1784,6 +1881,7 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 
 	opts->c_chmask = UAC1_DEF_CCHMASK;
 	opts->c_srates[0] = UAC1_DEF_CSRATE;
+	opts->c_sync = UAC1_DEF_CSYNC;
 	opts->c_ssize = UAC1_DEF_CSSIZE;
 	opts->p_chmask = UAC1_DEF_PCHMASK;
 	opts->p_srates[0] = UAC1_DEF_PSRATE;
@@ -1802,6 +1900,7 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	opts->c_volume_res = UAC1_DEF_RES_DB;
 
 	opts->req_number = UAC1_DEF_REQ_NUM;
+	opts->fb_max = FBACK_FAST_MAX;
 
 	scnprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
 
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index feb6eb76462f..59eac5ca8114 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -14,6 +14,7 @@
 #define UAC1_OUT_EP_MAX_PACKET_SIZE	200
 #define UAC1_DEF_CCHMASK	0x3
 #define UAC1_DEF_CSRATE		48000
+#define UAC1_DEF_CSYNC		USB_ENDPOINT_SYNC_ADAPTIVE
 #define UAC1_DEF_CSSIZE		2
 #define UAC1_DEF_PCHMASK	0x3
 #define UAC1_DEF_PSRATE		48000
@@ -32,6 +33,7 @@ struct f_uac1_opts {
 	struct usb_function_instance	func_inst;
 	int				c_chmask;
 	int				c_srates[UAC_MAX_RATES];
+	int				c_sync;
 	int				c_ssize;
 	int				p_chmask;
 	int				p_srates[UAC_MAX_RATES];
@@ -50,6 +52,7 @@ struct f_uac1_opts {
 	s16				c_volume_res;
 
 	int				req_number;
+	int				fb_max;
 	unsigned			bound:1;
 
 	char			function_name[USB_MAX_STRING_LEN];
-- 
2.43.0


