Return-Path: <linux-kernel+bounces-342517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8C988FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F3A1F20FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8913D53E;
	Sat, 28 Sep 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF6EOpYd"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEB61FCE;
	Sat, 28 Sep 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536165; cv=none; b=EGgcjHMLx1tG9MdjHOKYG813GFdvEqnknwB1dO4aWId5lQ5hMBQuQZ5KYn/IP22gtA0fa81cM1LAvH4UUazqw0iVDCle3qngJ9rLOES5dQIE2TCPQIweTp9EGmDkDBvZPW5mjMyOh34sCE48pDPFDgVQxdfF54ODRwtlzYreU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536165; c=relaxed/simple;
	bh=IyJz+iqPMoLhHut/jqmGwsV7ix4D1Ize338TAuomV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oncPWToX7X+hFqLQrq8/xKxnxTk3R+YOlGxYqM5CIQ+TsQY2ncO7Tv0QBnDazm7k9XhX7cXX/34nwWR+cQJegH5c6lAOpcWURiSM5kBJDc1uh8HVEObBfEqKy1+3cHc6JpQQHezOVFfU+ZAjbmZ47d4zDqffC/VCPWhdD5M+Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF6EOpYd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9dbdc8baaso26970585a.0;
        Sat, 28 Sep 2024 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536161; x=1728140961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN8bBg4/BtNlz+HQauYfU+FQJfwrHCBrf2UGuGo3/5w=;
        b=kF6EOpYd7wx0AdrKCjz5EzhT++kDrnTmatktHVqnMSiPyfShfLbP1wzv3YNQgyq1rv
         vn8zga076WyxgtQydYw6qtjyJpz+6rlp6JLc/mNjTcdAZ8tmmhKFfKGsvQzn7IaopVgJ
         7f/YJ4B/HsuJ08woLFPOLIofPJrpQU6IvTasx4FNVxFzRZIuQEnFBkBqe6r25idJ3tHY
         j2ICAT+RYYg8gYUijoCIEuksZM7MSrDcQ729Jt1lstFSnTj4tkTfWdBSlOwf7+X8EgqT
         PklSICLdRGa3imhNxGyP9pT5vcQd0mdeX6ug7xbCh8nEcQnVnPFlZ8W34A+b3/PBx/B5
         dJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536161; x=1728140961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN8bBg4/BtNlz+HQauYfU+FQJfwrHCBrf2UGuGo3/5w=;
        b=Cw7gY3gcmo6+7GE2hF09b68U0YNlLtW7OaVeoeZ0+KEGyrt5KKpD+HHcdLwOwN+hyc
         HjvX3RQfiXHOs0VGYTCwu+kyR4Yt5RkEkoPH884EfdNbKaaf81p1Ok3j3gKcl9k7RiQq
         DtBUsfVmTOHzvePvE4pwZctAo4mEOShA8TF61Lu0j5eZqwDSKZE0eG2pJN/2PINK8lwn
         dHH/PlYgVZKYX2hS4j/tCdBhQ6Jhb9NjSSsOQoRF8MflZYqYsd0xgrsC9ge5cYzcR+kW
         n+bUb0n9KfLRpSXDbDiQ+MviXCYFKpw0d+y9GMKyQ/njPipW2NEnASjIUNtuPo/sWdd2
         LjZA==
X-Forwarded-Encrypted: i=1; AJvYcCVdUDAxSSauDYwTgLyLPvALPBYDzA+j+8RtEKY9UpudKHdUC4SkaHv+6NPIC/izSEQeW77X09n6TAC3E8mD@vger.kernel.org, AJvYcCXvCHWWCZ9RUzDHodowdm/geGzNeeWolbcBc1mJcPbbzp+OeJ5UH1W8KXgodYJ4YT4N9mdvifi/XDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64wVNa/9XKA3XMuLGRJKM7Sy6KfDkfQCc+WEQRcYXcsXH9+WH
	cU3kYxT1qfXSHAqIZX6XagJjSkHh9KQI421bzjfsTA6n40ZN3obZ4anh7MVcYzQ=
X-Google-Smtp-Source: AGHT+IHaLZrCTIbzpzEWmpbBnoNblHkLEWA5bgRcxrdSy2w810sJF+7rN+mbLSf9Pn6NvPRdvGHCaQ==
X-Received: by 2002:a05:622a:609:b0:458:3297:806f with SMTP id d75a77b69052e-45c9f300aa3mr44139931cf.10.1727536161405;
        Sat, 28 Sep 2024 08:09:21 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:20 -0700 (PDT)
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
Subject: [PATCH RFC 02/14] usb: gadget: f_uac1: Fix fs/hs/ss descriptors to have correct values
Date: Sat, 28 Sep 2024 11:08:53 -0400
Message-ID: <20240928150905.2616313-3-crwulff@gmail.com>
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

This fixes two problems with the UAC1 descriptors.

bInterval for full-speed is now set to 1. Prior to this fix all speeds
were set to 4.

Super-speed descriptors are now built dynamically the same way as
the other speeds. The prior implementation had a fixed set of descriptors
and didn't take the presence of volume function units into account.

Both of these changes need the refactoring of setup_descriptor to
have a separate setup_header which is called for each speed. This
implementation closely follows what was done in f_uac2.

Fixes: b8fb6db6cb04 ("usb: f_uac1: adds support for SS and SSP")

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c | 248 ++++++++++++++++++++++-----
 1 file changed, 202 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index eeedcfa61fa1..f68d444d1961 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -128,7 +128,25 @@ static struct uac_feature_unit_descriptor *in_feature_unit_desc;
 static struct uac_feature_unit_descriptor *out_feature_unit_desc;
 
 /* AC IN Interrupt Endpoint */
-static struct usb_endpoint_descriptor ac_int_ep_desc = {
+static struct usb_endpoint_descriptor fs_ac_int_ep_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(2),
+	.bInterval = 1,
+};
+
+static struct usb_endpoint_descriptor hs_ac_int_ep_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_INT,
+	.wMaxPacketSize = cpu_to_le16(2),
+	.bInterval = 4,
+};
+
+static struct usb_endpoint_descriptor ss_ac_int_ep_desc = {
 	.bLength = USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType = USB_DT_ENDPOINT,
 	.bEndpointAddress = USB_DIR_IN,
@@ -137,6 +155,14 @@ static struct usb_endpoint_descriptor ac_int_ep_desc = {
 	.bInterval = 4,
 };
 
+static struct usb_ss_ep_comp_descriptor ss_ac_int_ep_desc_comp = {
+	.bLength = sizeof(ss_ac_int_ep_desc_comp),
+	.bDescriptorType = USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst = 0,
+	.bmAttributes = 0,
+	.wBytesPerInterval = cpu_to_le16(2),
+};
+
 /* B.4.1  Standard AS Interface Descriptor */
 static struct usb_interface_descriptor as_out_interface_alt_0_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
@@ -208,7 +234,17 @@ static struct uac_format_type_i_discrete_descriptor as_out_type_i_desc = {
 };
 
 /* Standard ISO OUT Endpoint Descriptor */
-static struct usb_endpoint_descriptor as_out_ep_desc  = {
+static struct usb_endpoint_descriptor fs_as_out_ep_desc  = {
+	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_OUT,
+	.bmAttributes =		USB_ENDPOINT_SYNC_ADAPTIVE
+				| USB_ENDPOINT_XFER_ISOC,
+	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+	.bInterval =		1,
+};
+
+static struct usb_endpoint_descriptor hs_as_out_ep_desc  = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
 	.bEndpointAddress =	USB_DIR_OUT,
@@ -238,8 +274,18 @@ static struct uac_format_type_i_discrete_descriptor as_in_type_i_desc = {
 	.bSamFreqType =		0, /* filled on rate setup */
 };
 
-/* Standard ISO OUT Endpoint Descriptor */
-static struct usb_endpoint_descriptor as_in_ep_desc  = {
+/* Standard ISO IN Endpoint Descriptor */
+static struct usb_endpoint_descriptor fs_as_in_ep_desc  = {
+	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_SYNC_ASYNC
+				| USB_ENDPOINT_XFER_ISOC,
+	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
+	.bInterval =		1,
+};
+
+static struct usb_endpoint_descriptor hs_as_in_ep_desc  = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
 	.bEndpointAddress =	USB_DIR_IN,
@@ -249,7 +295,7 @@ static struct usb_endpoint_descriptor as_in_ep_desc  = {
 	.bInterval =		4,
 };
 
-/* Class-specific AS ISO OUT Endpoint Descriptor */
+/* Class-specific AS ISO IN Endpoint Descriptor */
 static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.bLength =		UAC_ISO_ENDPOINT_DESC_SIZE,
 	.bDescriptorType =	USB_DT_CS_ENDPOINT,
@@ -259,7 +305,41 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.wLockDelay =		0,
 };
 
-static struct usb_descriptor_header *f_audio_desc[] = {
+static struct usb_descriptor_header *f_audio_fs_desc[] = {
+	(struct usb_descriptor_header *)&ac_interface_desc,
+	(struct usb_descriptor_header *)&ac_header_desc,
+
+	(struct usb_descriptor_header *)&usb_out_it_desc,
+	(struct usb_descriptor_header *)&io_out_ot_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&io_in_it_desc,
+	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&fs_ac_int_ep_desc,
+
+	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_out_header_desc,
+
+	(struct usb_descriptor_header *)&as_out_type_i_desc,
+
+	(struct usb_descriptor_header *)&fs_as_out_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_out_desc,
+
+	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
+	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
+	(struct usb_descriptor_header *)&as_in_header_desc,
+
+	(struct usb_descriptor_header *)&as_in_type_i_desc,
+
+	(struct usb_descriptor_header *)&fs_as_in_ep_desc,
+	(struct usb_descriptor_header *)&as_iso_in_desc,
+	NULL,
+};
+
+static struct usb_descriptor_header *f_audio_hs_desc[] = {
 	(struct usb_descriptor_header *)&ac_interface_desc,
 	(struct usb_descriptor_header *)&ac_header_desc,
 
@@ -271,7 +351,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 	(struct usb_descriptor_header *)&usb_in_ot_desc,
 	(struct usb_descriptor_header *)&in_feature_unit_desc,
 
-	(struct usb_descriptor_header *)&ac_int_ep_desc,
+	(struct usb_descriptor_header *)&hs_ac_int_ep_desc,
 
 	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
@@ -279,7 +359,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 
 	(struct usb_descriptor_header *)&as_out_type_i_desc,
 
-	(struct usb_descriptor_header *)&as_out_ep_desc,
+	(struct usb_descriptor_header *)&hs_as_out_ep_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
@@ -288,7 +368,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 
 	(struct usb_descriptor_header *)&as_in_type_i_desc,
 
-	(struct usb_descriptor_header *)&as_in_ep_desc,
+	(struct usb_descriptor_header *)&hs_as_in_ep_desc,
 	(struct usb_descriptor_header *)&as_iso_in_desc,
 	NULL,
 };
@@ -312,7 +392,7 @@ static struct usb_ss_ep_comp_descriptor ss_as_out_ep_desc_comp = {
 	/* wBytesPerInterval = DYNAMIC */
 };
 
-/* Standard ISO OUT Endpoint Descriptor */
+/* Standard ISO IN Endpoint Descriptor */
 static struct usb_endpoint_descriptor ss_as_in_ep_desc  = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
@@ -337,8 +417,14 @@ static struct usb_descriptor_header *f_audio_ss_desc[] = {
 
 	(struct usb_descriptor_header *)&usb_out_it_desc,
 	(struct usb_descriptor_header *)&io_out_ot_desc,
+	(struct usb_descriptor_header *)&out_feature_unit_desc,
+
 	(struct usb_descriptor_header *)&io_in_it_desc,
 	(struct usb_descriptor_header *)&usb_in_ot_desc,
+	(struct usb_descriptor_header *)&in_feature_unit_desc,
+
+	(struct usb_descriptor_header *)&ss_ac_int_ep_desc,
+	(struct usb_descriptor_header *)&ss_ac_int_ep_desc_comp,
 
 	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
@@ -346,7 +432,6 @@ static struct usb_descriptor_header *f_audio_ss_desc[] = {
 
 	(struct usb_descriptor_header *)&as_out_type_i_desc,
 
-	//(struct usb_descriptor_header *)&as_out_ep_desc,
 	(struct usb_descriptor_header *)&ss_as_out_ep_desc,
 	(struct usb_descriptor_header *)&ss_as_out_ep_desc_comp,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
@@ -357,7 +442,6 @@ static struct usb_descriptor_header *f_audio_ss_desc[] = {
 
 	(struct usb_descriptor_header *)&as_in_type_i_desc,
 
-	//(struct usb_descriptor_header *)&as_in_ep_desc,
 	(struct usb_descriptor_header *)&ss_as_in_ep_desc,
 	(struct usb_descriptor_header *)&ss_as_in_ep_desc_comp,
 	(struct usb_descriptor_header *)&as_iso_in_desc,
@@ -1082,6 +1166,10 @@ uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
 /* Use macro to overcome line length limitation */
 #define USBDHDR(p) (struct usb_descriptor_header *)(p)
 
+static void setup_headers(struct f_uac1_opts *opts,
+			  struct usb_descriptor_header **headers,
+			  enum usb_device_speed speed);
+
 static void setup_descriptor(struct f_uac1_opts *opts)
 {
 	/* patch descriptors */
@@ -1137,44 +1225,90 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		ac_header_desc->wTotalLength = cpu_to_le16(len);
 	}
 
+	setup_headers(opts, f_audio_fs_desc, USB_SPEED_FULL);
+	setup_headers(opts, f_audio_hs_desc, USB_SPEED_HIGH);
+	setup_headers(opts, f_audio_ss_desc, USB_SPEED_SUPER);
+}
+
+static void setup_headers(struct f_uac1_opts *opts,
+			  struct usb_descriptor_header **headers,
+			  enum usb_device_speed speed)
+{
+	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
+	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
+	struct usb_endpoint_descriptor *epout_desc;
+	struct usb_endpoint_descriptor *epin_desc;
+	struct usb_endpoint_descriptor *ep_int_desc;
+	int i;
+
+	switch (speed) {
+	case USB_SPEED_FULL:
+		epout_desc = &fs_as_out_ep_desc;
+		epin_desc = &fs_as_in_ep_desc;
+		ep_int_desc = &fs_ac_int_ep_desc;
+		break;
+	case USB_SPEED_HIGH:
+		epout_desc = &hs_as_out_ep_desc;
+		epin_desc = &hs_as_in_ep_desc;
+		ep_int_desc = &hs_ac_int_ep_desc;
+		break;
+	default:
+		epout_desc = &ss_as_out_ep_desc;
+		epin_desc = &ss_as_in_ep_desc;
+		epout_desc_comp = &ss_as_out_ep_desc_comp;
+		epin_desc_comp = &ss_as_in_ep_desc_comp;
+		ep_int_desc = &ss_ac_int_ep_desc;
+		ep_int_desc_comp = &ss_ac_int_ep_desc_comp;
+	}
+
 	i = 0;
-	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
-	f_audio_desc[i++] = USBDHDR(ac_header_desc);
+	headers[i++] = USBDHDR(&ac_interface_desc);
+	headers[i++] = USBDHDR(ac_header_desc);
 
 	if (EPOUT_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&usb_out_it_desc);
-		f_audio_desc[i++] = USBDHDR(&io_out_ot_desc);
+		headers[i++] = USBDHDR(&usb_out_it_desc);
+		headers[i++] = USBDHDR(&io_out_ot_desc);
 		if (FUOUT_EN(opts))
-			f_audio_desc[i++] = USBDHDR(out_feature_unit_desc);
+			headers[i++] = USBDHDR(out_feature_unit_desc);
 	}
 
 	if (EPIN_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&io_in_it_desc);
-		f_audio_desc[i++] = USBDHDR(&usb_in_ot_desc);
+		headers[i++] = USBDHDR(&io_in_it_desc);
+		headers[i++] = USBDHDR(&usb_in_ot_desc);
 		if (FUIN_EN(opts))
-			f_audio_desc[i++] = USBDHDR(in_feature_unit_desc);
+			headers[i++] = USBDHDR(in_feature_unit_desc);
 	}
 
-	if (FUOUT_EN(opts) || FUIN_EN(opts))
-		f_audio_desc[i++] = USBDHDR(&ac_int_ep_desc);
+	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
+		headers[i++] = USBDHDR(ep_int_desc);
+		if (ep_int_desc_comp)
+			headers[i++] = USBDHDR(ep_int_desc_comp);
+	}
 
 	if (EPOUT_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_0_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_interface_alt_1_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_header_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_type_i_desc);
-		f_audio_desc[i++] = USBDHDR(&as_out_ep_desc);
-		f_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
+		headers[i++] = USBDHDR(&as_out_interface_alt_0_desc);
+		headers[i++] = USBDHDR(&as_out_interface_alt_1_desc);
+		headers[i++] = USBDHDR(&as_out_header_desc);
+		headers[i++] = USBDHDR(&as_out_type_i_desc);
+		headers[i++] = USBDHDR(epout_desc);
+		if (epout_desc_comp)
+			headers[i++] = USBDHDR(epout_desc_comp);
+
+		headers[i++] = USBDHDR(&as_iso_out_desc);
 	}
 	if (EPIN_EN(opts)) {
-		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_0_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_1_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_header_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_type_i_desc);
-		f_audio_desc[i++] = USBDHDR(&as_in_ep_desc);
-		f_audio_desc[i++] = USBDHDR(&as_iso_in_desc);
+		headers[i++] = USBDHDR(&as_in_interface_alt_0_desc);
+		headers[i++] = USBDHDR(&as_in_interface_alt_1_desc);
+		headers[i++] = USBDHDR(&as_in_header_desc);
+		headers[i++] = USBDHDR(&as_in_type_i_desc);
+		headers[i++] = USBDHDR(epin_desc);
+		if (epin_desc_comp)
+			headers[i++] = USBDHDR(epin_desc_comp);
+
+		headers[i++] = USBDHDR(&as_iso_in_desc);
 	}
-	f_audio_desc[i] = NULL;
+	headers[i] = NULL;
 }
 
 static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
@@ -1410,44 +1544,66 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* allocate AC interrupt endpoint */
 	if (FUOUT_EN(audio_opts) || FUIN_EN(audio_opts)) {
-		ep = usb_ep_autoconfig(cdev->gadget, &ac_int_ep_desc);
+		ep = usb_ep_autoconfig(cdev->gadget, &fs_ac_int_ep_desc);
 		if (!ep)
 			goto err_free_fu;
+
+		hs_ac_int_ep_desc.bEndpointAddress = fs_ac_int_ep_desc.bEndpointAddress;
+		ss_ac_int_ep_desc.bEndpointAddress = fs_ac_int_ep_desc.bEndpointAddress;
+
 		uac1->int_ep = ep;
-		uac1->int_ep->desc = &ac_int_ep_desc;
+		uac1->int_ep->desc = &fs_ac_int_ep_desc;
 
 		ac_interface_desc.bNumEndpoints = 1;
 	}
 
 	/* allocate instance-specific endpoints */
 	if (EPOUT_EN(audio_opts)) {
-		ep = usb_ep_autoconfig(cdev->gadget, &as_out_ep_desc);
+		ep = usb_ep_autoconfig(cdev->gadget, &fs_as_out_ep_desc);
 		if (!ep)
 			goto err_free_fu;
-		ss_as_out_ep_desc.bEndpointAddress = as_out_ep_desc.bEndpointAddress;
+
+		hs_as_out_ep_desc.bEndpointAddress = fs_as_out_ep_desc.bEndpointAddress;
+		ss_as_out_ep_desc.bEndpointAddress = fs_as_out_ep_desc.bEndpointAddress;
+		ss_as_out_ep_desc_comp.wBytesPerInterval = ss_as_out_ep_desc.wMaxPacketSize;
+
 		audio->out_ep = ep;
-		audio->out_ep->desc = &as_out_ep_desc;
+		audio->out_ep->desc = &fs_as_out_ep_desc;
 	}
 
 	if (EPIN_EN(audio_opts)) {
-		ep = usb_ep_autoconfig(cdev->gadget, &as_in_ep_desc);
+		ep = usb_ep_autoconfig(cdev->gadget, &fs_as_in_ep_desc);
 		if (!ep)
 			goto err_free_fu;
-		ss_as_in_ep_desc.bEndpointAddress = as_in_ep_desc.bEndpointAddress;
+
+		hs_as_in_ep_desc.bEndpointAddress = fs_as_in_ep_desc.bEndpointAddress;
+		ss_as_in_ep_desc.bEndpointAddress = fs_as_in_ep_desc.bEndpointAddress;
+		ss_as_in_ep_desc_comp.wBytesPerInterval = ss_as_in_ep_desc.wMaxPacketSize;
+
 		audio->in_ep = ep;
-		audio->in_ep->desc = &as_in_ep_desc;
+		audio->in_ep->desc = &fs_as_in_ep_desc;
 	}
 
 	setup_descriptor(audio_opts);
 
 	/* copy descriptors, and track endpoint copies */
-	status = usb_assign_descriptors(f, f_audio_desc, f_audio_desc, f_audio_ss_desc,
+	status = usb_assign_descriptors(f, f_audio_fs_desc, f_audio_hs_desc, f_audio_ss_desc,
 					f_audio_ss_desc);
 	if (status)
 		goto err_free_fu;
 
-	audio->out_ep_maxpsize = le16_to_cpu(as_out_ep_desc.wMaxPacketSize);
-	audio->in_ep_maxpsize = le16_to_cpu(as_in_ep_desc.wMaxPacketSize);
+	audio->in_ep_maxpsize = max_t(u16,
+				le16_to_cpu(fs_as_in_ep_desc.wMaxPacketSize),
+				le16_to_cpu(hs_as_in_ep_desc.wMaxPacketSize));
+	audio->out_ep_maxpsize = max_t(u16,
+				le16_to_cpu(fs_as_out_ep_desc.wMaxPacketSize),
+				le16_to_cpu(hs_as_out_ep_desc.wMaxPacketSize));
+
+	audio->in_ep_maxpsize = max_t(u16, audio->in_ep_maxpsize,
+				le16_to_cpu(ss_as_in_ep_desc.wMaxPacketSize));
+	audio->out_ep_maxpsize = max_t(u16, audio->out_ep_maxpsize,
+				le16_to_cpu(ss_as_out_ep_desc.wMaxPacketSize));
+
 	audio->params.c_chmask = audio_opts->c_chmask;
 	memcpy(audio->params.c_srates, audio_opts->c_srates,
 			sizeof(audio->params.c_srates));
-- 
2.43.0


