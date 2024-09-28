Return-Path: <linux-kernel+bounces-342526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C11988FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15E3B21599
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10F18BBB0;
	Sat, 28 Sep 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIuSy7wZ"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBF1898E9;
	Sat, 28 Sep 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536187; cv=none; b=QQzBOu0Z31neIYNRv5YLx0br2hLeLKUZW13s/HVGOMU0pVXZVqW132uoq+pW3PgtkusRlojb9nMmhtxjUnoB64HcWuwRXOJbuppM4AjNN0p4FMS9OUoEvsQ8ikmtxuGljjM2yYpJkpiJ6vchzxgUIy2KDkuY0aw0yd1PAkVDDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536187; c=relaxed/simple;
	bh=yNV8sLxNXxiZeJ6Rgy7TXgUmJwPPlKIVSQBfX5iLMZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd2x1ax3lzCqN1H5Ggp6GrIwZN8jZ78sXpNDVP5ialy4FXPNIPE8LaQdck3rlLfifWOtFDN3tDw60xqp/axdOqAieRRhuW7O17TjduoBsLUc+VWe0QinHBkH3KDJbvR2DAs+ldO5ht5U1CxWkphNbRML7RLCslATzL+Oze4+d7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIuSy7wZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45817098ad5so1346811cf.2;
        Sat, 28 Sep 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536182; x=1728140982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLZJIs/hfIYLMWubtMu+GJHJ1qhaAzZe28T/ApzhN7o=;
        b=JIuSy7wZ1nKrkGC+atF5nMZukolbw8cV9qiYw4VwmlEVNcMY6ZNzvrVJnCjnGCe1Ch
         2bEXgwqgRROE5y0bbdvp+RgvIjry2NLRATMGhzkKEvaEu7QIrLJhmeWer+khBX7F0GGp
         L/zaketg1v9sqBjBbnB6eBaUxdNVNjXfAQ/8+e2BvzgIFPwOyI170dmYCMhGZRbHL+vb
         /BWeLQ6ZYMKvCCho2NeqMwkl0YCyQUCVTW5SaJth4FiXYleW6Jq+6up+gj77gnvnVV4y
         R59mPXc5uLlvg7TyyGYwfz6XX0BrUb9fVEC6kXyZ8Y7V4HlU+7gyBAL+Ep5TxU3sbq+r
         ld7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536182; x=1728140982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLZJIs/hfIYLMWubtMu+GJHJ1qhaAzZe28T/ApzhN7o=;
        b=UTwp/ifYdujEpk1XMAtzPwlwKj1ZDEXcs/QLvxzX/0SZig8VLyiw/uSIZgikVkOaLO
         9fPmRe4iyOYnmonfWZ/be5KMS4Hqh/0Chjd2Q15PcDPpfeUq8nG2uf4SxVjtNq7Z7qIb
         Obi9i9vQV6mlXei7a3rWZfN0awIaC4weLZwuCuKdmJ47la0jFTDN+11/Egki5OaEyKeL
         Wgo5v3te4h6GJr+zwhT+XDo/STQz5LaChHkKGiSWVDiHL+nWEcnBfUTYGWvft23vCTuH
         D3PXPzUUHVRs1N6UVC7xQk8QThitVr+vZbiUGjlHth0Aimq+qviwcwrfmktmXO+Gxsrb
         FU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdW9E6LBj+f7FjCSQEjU8E9uMp7Hq1NYynG14bC/DNKKO+NM19KPfByAVCIQC8AZKs7kjWy0L8JXA=@vger.kernel.org, AJvYcCWr+MQAdbookbDbcjaoKqid3k2pJk8dCQftUiYI3EQbxK9xghZFA2MT7QBQRjP+byPxXV9RY7uL4sQpuv4w@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+vS0yTXqpW0CxDTtVYAxh/eaKmIL+af8MhHdzG/JcvFU1KPW
	0/hIXSCr86UvWMX0Tnv0gzPbb76oiys8dCMKpzjDJysMrdY50kWI2gMXiVnjVFc=
X-Google-Smtp-Source: AGHT+IEWXfM7gW6UXczhVXuinhDrqcsOpyJqewD2J3HLA9GnrrPKnuPdyMZum6oLB0Qc2Z8Z5Cnddw==
X-Received: by 2002:a05:622a:c8:b0:458:21b3:63f with SMTP id d75a77b69052e-45c9f317f50mr47047581cf.13.1727536181653;
        Sat, 28 Sep 2024 08:09:41 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:41 -0700 (PDT)
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
Subject: [PATCH RFC 11/14] usb: gadget: f_uac1: Generate dynamic descriptors based on alt opts
Date: Sat, 28 Sep 2024 11:09:02 -0400
Message-ID: <20240928150905.2616313-12-crwulff@gmail.com>
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

Descriptors are now generated based on what alt modes are configured.
The lifetime of allocations has changed a bit with this such that we
deallocate our copy of the descriptors as soon as they've been registered.

Many of the descriptors that were static are now attached to their alt mode
opts and initialized with a function.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c | 1390 +++++++++++++-------------
 drivers/usb/gadget/function/u_uac1.h |   38 +
 2 files changed, 709 insertions(+), 719 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 3484aa237354..7803957e4f82 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -27,16 +27,36 @@
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
 
-#define USB_OUT_FU_ID	(out_feature_unit_desc->bUnitID)
-#define USB_IN_FU_ID	(in_feature_unit_desc->bUnitID)
+#define USB_OUT_FU_ID(_opts)	(_opts->c_alt_1_opts.fu_id)
+#define USB_IN_FU_ID(_opts)	(_opts->p_alt_1_opts.fu_id)
 
-#define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
-#define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
+#define EP_EN(_alt_opts) ((_alt_opts) && ((_alt_opts)->chmask != 0))
 #define FUIN_EN(_opts) ((_opts)->p_mute_present \
 			|| (_opts)->p_volume_present)
 #define FUOUT_EN(_opts) ((_opts)->c_mute_present \
 			|| (_opts)->c_volume_present)
-#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
+#define EPOUT_FBACK_IN_EN(_alt_opts) ((_alt_opts)->sync == USB_ENDPOINT_SYNC_ASYNC)
+
+/* Check if any alt mode has option enabled */
+#define EN_ANY(single, fn, cp)						\
+static int fn(struct f_uac1_opts *opts)					\
+{									\
+	struct f_uac1_alt_opts *alt_opts;				\
+									\
+	if (single(&opts->cp##_alt_1_opts))				\
+		return 1;						\
+									\
+	list_for_each_entry(alt_opts, &opts->cp##_alt_opts, list) {	\
+		if (single(alt_opts))					\
+			return 1;					\
+	}								\
+									\
+	return 0;							\
+}
+
+EN_ANY(EP_EN, epout_en_any, c)
+EN_ANY(EP_EN, epin_en_any, p)
+EN_ANY(EPOUT_FBACK_IN_EN, epout_fback_in_en_any, p)
 
 struct f_uac1 {
 	struct g_audio g_audio;
@@ -88,49 +108,6 @@ static struct usb_interface_descriptor ac_interface_desc = {
 /* B.3.2  Class-Specific AC Interface Descriptor */
 static struct uac1_ac_header_descriptor *ac_header_desc;
 
-static struct uac_input_terminal_descriptor usb_out_it_desc = {
-	.bLength =		UAC_DT_INPUT_TERMINAL_SIZE,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_INPUT_TERMINAL,
-	/* .bTerminalID =	DYNAMIC */
-	.wTerminalType =	cpu_to_le16(UAC_TERMINAL_STREAMING),
-	.bAssocTerminal =	0,
-	.wChannelConfig =	cpu_to_le16(0x3),
-};
-
-static struct uac1_output_terminal_descriptor io_out_ot_desc = {
-	.bLength		= UAC_DT_OUTPUT_TERMINAL_SIZE,
-	.bDescriptorType	= USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype	= UAC_OUTPUT_TERMINAL,
-	/* .bTerminalID =	DYNAMIC */
-	.wTerminalType		= cpu_to_le16(UAC_OUTPUT_TERMINAL_SPEAKER),
-	.bAssocTerminal		= 0,
-	/* .bSourceID =		DYNAMIC */
-};
-
-static struct uac_input_terminal_descriptor io_in_it_desc = {
-	.bLength		= UAC_DT_INPUT_TERMINAL_SIZE,
-	.bDescriptorType	= USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype	= UAC_INPUT_TERMINAL,
-	/* .bTerminalID		= DYNAMIC */
-	.wTerminalType		= cpu_to_le16(UAC_INPUT_TERMINAL_MICROPHONE),
-	.bAssocTerminal		= 0,
-	.wChannelConfig		= cpu_to_le16(0x3),
-};
-
-static struct uac1_output_terminal_descriptor usb_in_ot_desc = {
-	.bLength =		UAC_DT_OUTPUT_TERMINAL_SIZE,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_OUTPUT_TERMINAL,
-	/* .bTerminalID =	DYNAMIC */
-	.wTerminalType =	cpu_to_le16(UAC_TERMINAL_STREAMING),
-	.bAssocTerminal =	0,
-	/* .bSourceID =		DYNAMIC */
-};
-
-static struct uac_feature_unit_descriptor *in_feature_unit_desc;
-static struct uac_feature_unit_descriptor *out_feature_unit_desc;
-
 /* AC IN Interrupt Endpoint */
 static struct usb_endpoint_descriptor fs_ac_int_ep_desc = {
 	.bLength = USB_DT_ENDPOINT_SIZE,
@@ -167,97 +144,6 @@ static struct usb_ss_ep_comp_descriptor ss_ac_int_ep_desc_comp = {
 	.wBytesPerInterval = cpu_to_le16(2),
 };
 
-/* B.4.1  Standard AS Interface Descriptor */
-static struct usb_interface_descriptor as_out_interface_alt_0_desc = {
-	.bLength =		USB_DT_INTERFACE_SIZE,
-	.bDescriptorType =	USB_DT_INTERFACE,
-	.bAlternateSetting =	0,
-	.bNumEndpoints =	0,
-	.bInterfaceClass =	USB_CLASS_AUDIO,
-	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING,
-};
-
-static struct usb_interface_descriptor as_out_interface_alt_1_desc = {
-	.bLength =		USB_DT_INTERFACE_SIZE,
-	.bDescriptorType =	USB_DT_INTERFACE,
-	.bAlternateSetting =	1,
-	.bNumEndpoints =	1,
-	.bInterfaceClass =	USB_CLASS_AUDIO,
-	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING,
-};
-
-static struct usb_interface_descriptor as_in_interface_alt_0_desc = {
-	.bLength =		USB_DT_INTERFACE_SIZE,
-	.bDescriptorType =	USB_DT_INTERFACE,
-	.bAlternateSetting =	0,
-	.bNumEndpoints =	0,
-	.bInterfaceClass =	USB_CLASS_AUDIO,
-	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING,
-};
-
-static struct usb_interface_descriptor as_in_interface_alt_1_desc = {
-	.bLength =		USB_DT_INTERFACE_SIZE,
-	.bDescriptorType =	USB_DT_INTERFACE,
-	.bAlternateSetting =	1,
-	.bNumEndpoints =	1,
-	.bInterfaceClass =	USB_CLASS_AUDIO,
-	.bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING,
-};
-
-/* B.4.2  Class-Specific AS Interface Descriptor */
-static struct uac1_as_header_descriptor as_out_header_desc = {
-	.bLength =		UAC_DT_AS_HEADER_SIZE,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_AS_GENERAL,
-	/* .bTerminalLink =	DYNAMIC */
-	.bDelay =		1,
-	.wFormatTag =		cpu_to_le16(UAC_FORMAT_TYPE_I_PCM),
-};
-
-static struct uac1_as_header_descriptor as_in_header_desc = {
-	.bLength =		UAC_DT_AS_HEADER_SIZE,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_AS_GENERAL,
-	/* .bTerminalLink =	DYNAMIC */
-	.bDelay =		1,
-	.wFormatTag =		cpu_to_le16(UAC_FORMAT_TYPE_I_PCM),
-};
-
-DECLARE_UAC_FORMAT_TYPE_I_DISCRETE_DESC(UAC_MAX_RATES);
-#define uac_format_type_i_discrete_descriptor			\
-	uac_format_type_i_discrete_descriptor_##UAC_MAX_RATES
-
-static struct uac_format_type_i_discrete_descriptor as_out_type_i_desc = {
-	.bLength =		0, /* filled on rate setup */
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_FORMAT_TYPE,
-	.bFormatType =		UAC_FORMAT_TYPE_I,
-	.bSubframeSize =	2,
-	.bBitResolution =	16,
-	.bSamFreqType =		0, /* filled on rate setup */
-};
-
-/* Standard ISO OUT Endpoint Descriptor */
-static struct usb_endpoint_descriptor fs_as_out_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_OUT,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ADAPTIVE
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		1,
-};
-
-static struct usb_endpoint_descriptor hs_as_out_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_OUT,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ADAPTIVE
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		4,
-};
-
 /* Class-specific AS ISO OUT Endpoint Descriptor */
 static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
 	.bLength =		UAC_ISO_ENDPOINT_DESC_SIZE,
@@ -268,37 +154,6 @@ static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
 	.wLockDelay =		cpu_to_le16(1),
 };
 
-static struct uac_format_type_i_discrete_descriptor as_in_type_i_desc = {
-	.bLength =		0, /* filled on rate setup */
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	UAC_FORMAT_TYPE,
-	.bFormatType =		UAC_FORMAT_TYPE_I,
-	.bSubframeSize =	2,
-	.bBitResolution =	16,
-	.bSamFreqType =		0, /* filled on rate setup */
-};
-
-/* Standard ISO IN Endpoint Descriptor */
-static struct usb_endpoint_descriptor fs_as_in_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_IN,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ASYNC
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		1,
-};
-
-static struct usb_endpoint_descriptor hs_as_in_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_IN,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ASYNC
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		4,
-};
-
 /* Class-specific AS ISO IN Endpoint Descriptor */
 static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
 	.bLength =		UAC_ISO_ENDPOINT_DESC_SIZE,
@@ -351,153 +206,6 @@ static struct usb_ss_ep_comp_descriptor ss_as_in_fback_desc_comp = {
 	.wBytesPerInterval	= cpu_to_le16(4),
 };
 
-static struct usb_descriptor_header *f_audio_fs_desc[] = {
-	(struct usb_descriptor_header *)&ac_interface_desc,
-	(struct usb_descriptor_header *)&ac_header_desc,
-
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-	(struct usb_descriptor_header *)&out_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&fs_ac_int_ep_desc,
-
-	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_out_header_desc,
-
-	(struct usb_descriptor_header *)&as_out_type_i_desc,
-
-	(struct usb_descriptor_header *)&fs_as_out_ep_desc,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&fs_as_in_fback_desc,
-
-	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_in_header_desc,
-
-	(struct usb_descriptor_header *)&as_in_type_i_desc,
-
-	(struct usb_descriptor_header *)&fs_as_in_ep_desc,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
-static struct usb_descriptor_header *f_audio_hs_desc[] = {
-	(struct usb_descriptor_header *)&ac_interface_desc,
-	(struct usb_descriptor_header *)&ac_header_desc,
-
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-	(struct usb_descriptor_header *)&out_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&hs_ac_int_ep_desc,
-
-	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_out_header_desc,
-
-	(struct usb_descriptor_header *)&as_out_type_i_desc,
-
-	(struct usb_descriptor_header *)&hs_as_out_ep_desc,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&hs_as_in_fback_desc,
-
-	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_in_header_desc,
-
-	(struct usb_descriptor_header *)&as_in_type_i_desc,
-
-	(struct usb_descriptor_header *)&hs_as_in_ep_desc,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
-/* Standard ISO OUT Endpoint Descriptor */
-static struct usb_endpoint_descriptor ss_as_out_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_OUT,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ADAPTIVE
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		4,
-};
-
-static struct usb_ss_ep_comp_descriptor ss_as_out_ep_desc_comp = {
-	.bLength		= sizeof(ss_as_out_ep_desc_comp),
-	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst		= 0,
-	.bmAttributes		= 0,
-	/* wBytesPerInterval = DYNAMIC */
-};
-
-/* Standard ISO IN Endpoint Descriptor */
-static struct usb_endpoint_descriptor ss_as_in_ep_desc  = {
-	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
-	.bDescriptorType =	USB_DT_ENDPOINT,
-	.bEndpointAddress =	USB_DIR_IN,
-	.bmAttributes =		USB_ENDPOINT_SYNC_ASYNC
-				| USB_ENDPOINT_XFER_ISOC,
-	.wMaxPacketSize	=	cpu_to_le16(UAC1_OUT_EP_MAX_PACKET_SIZE),
-	.bInterval =		4,
-};
-
-static struct usb_ss_ep_comp_descriptor ss_as_in_ep_desc_comp = {
-	.bLength		= sizeof(ss_as_in_ep_desc_comp),
-	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst		= 0,
-	.bmAttributes		= 0,
-	/* wBytesPerInterval = DYNAMIC */
-};
-
-static struct usb_descriptor_header *f_audio_ss_desc[] = {
-	(struct usb_descriptor_header *)&ac_interface_desc,
-	(struct usb_descriptor_header *)&ac_header_desc,
-
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-	(struct usb_descriptor_header *)&out_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-
-	(struct usb_descriptor_header *)&ss_ac_int_ep_desc,
-	(struct usb_descriptor_header *)&ss_ac_int_ep_desc_comp,
-
-	(struct usb_descriptor_header *)&as_out_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_out_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_out_header_desc,
-
-	(struct usb_descriptor_header *)&as_out_type_i_desc,
-
-	(struct usb_descriptor_header *)&ss_as_out_ep_desc,
-	(struct usb_descriptor_header *)&ss_as_out_ep_desc_comp,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&ss_as_in_fback_desc,
-	(struct usb_descriptor_header *)&ss_as_in_fback_desc_comp,
-
-	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
-	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
-	(struct usb_descriptor_header *)&as_in_header_desc,
-
-	(struct usb_descriptor_header *)&as_in_type_i_desc,
-
-	(struct usb_descriptor_header *)&ss_as_in_ep_desc,
-	(struct usb_descriptor_header *)&ss_as_in_ep_desc_comp,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
 /*
  * This function is an ALSA sound card following USB Audio Class Spec 1.0.
  */
@@ -602,11 +310,11 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_MUTE) {
@@ -653,11 +361,11 @@ in_rq_min(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_VOLUME) {
@@ -700,11 +408,11 @@ in_rq_max(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_VOLUME) {
@@ -747,11 +455,11 @@ in_rq_res(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_VOLUME) {
@@ -799,11 +507,11 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_MUTE) {
@@ -848,8 +556,8 @@ out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		memcpy(&uac1->setup_cr, cr, sizeof(*cr));
 		req->context = audio;
 		req->complete = out_rq_cur_complete;
@@ -1221,6 +929,10 @@ static struct usb_string *attach_strings(struct usb_composite_dev *cdev,
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Descriptor building functions
+ */
+
 static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_alt_opts *alt_opts,
 					struct usb_endpoint_descriptor *ep_desc,
 					enum usb_device_speed speed, bool is_playback)
@@ -1231,11 +943,59 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_a
 		alt_opts->ssize, alt_opts->sync, alt_opts->c.opts->fb_max);
 }
 
-static struct uac_feature_unit_descriptor *build_fu_desc(int chmask)
+struct path_params {
+	int dir;
+	int id;
+	struct f_uac1_opts *opts;
+	struct usb_string *strings;
+};
+
+/* 4.3.2.1 Input Terminal Descriptor */
+static void init_it_desc(struct uac_input_terminal_descriptor *it_desc,
+			 struct f_uac1_alt_opts *alt_opts,
+			 struct path_params *params)
+{
+	it_desc->bLength =		UAC_DT_INPUT_TERMINAL_SIZE;
+	it_desc->bDescriptorType =	USB_DT_CS_INTERFACE;
+	it_desc->bDescriptorSubtype =	UAC_INPUT_TERMINAL;
+	it_desc->bTerminalID =		params->id++;
+	it_desc->wTerminalType =	cpu_to_le16((params->dir == HOST_TO_DEVICE)
+							?  UAC_TERMINAL_STREAMING
+							: alt_opts->terminal_type);
+	it_desc->bAssocTerminal =	0;
+	it_desc->bNrChannels =		num_channels(alt_opts->chmask);
+	it_desc->wChannelConfig =	cpu_to_le16(alt_opts->chmask);
+	it_desc->iTerminal =		add_string(params->strings, alt_opts->it_name);
+	it_desc->iChannelNames =	add_string(params->strings, alt_opts->it_ch_name);
+}
+
+/* 4.3.2.2 Output Terminal Descriptor */
+static void init_ot_desc(struct uac1_output_terminal_descriptor *ot_desc,
+			 struct f_uac1_alt_opts *alt_opts,
+			 struct path_params *params, int src_id)
+{
+	ot_desc->bLength =		UAC_DT_OUTPUT_TERMINAL_SIZE;
+	ot_desc->bDescriptorType =	USB_DT_CS_INTERFACE;
+	ot_desc->bDescriptorSubtype =	UAC_OUTPUT_TERMINAL;
+	ot_desc->bTerminalID =		params->id++;
+	ot_desc->wTerminalType =	cpu_to_le16((params->dir == HOST_TO_DEVICE)
+							? alt_opts->terminal_type
+							: UAC_TERMINAL_STREAMING);
+	ot_desc->bAssocTerminal =	0;
+	ot_desc->bSourceID =		src_id;
+	ot_desc->iTerminal =		add_string(params->strings, alt_opts->ot_name);
+}
+
+/* 4.3.2.5 Feature Unit Descriptor */
+static struct uac_feature_unit_descriptor *build_fu_desc(struct f_uac1_alt_opts *alt_opts,
+							 struct path_params *params,
+							 int src_id)
 {
 	struct uac_feature_unit_descriptor *fu_desc;
-	int channels = num_channels(chmask);
+	int channels = num_channels(alt_opts->chmask);
 	int fu_desc_size = UAC_DT_FEATURE_UNIT_SIZE(channels);
+	u32 control = 0;
+	u8 *i_feature;
 
 	fu_desc = kzalloc(fu_desc_size, GFP_KERNEL);
 	if (!fu_desc)
@@ -1243,29 +1003,46 @@ static struct uac_feature_unit_descriptor *build_fu_desc(int chmask)
 
 	fu_desc->bLength = fu_desc_size;
 	fu_desc->bDescriptorType = USB_DT_CS_INTERFACE;
-
 	fu_desc->bDescriptorSubtype = UAC_FEATURE_UNIT;
+	fu_desc->bUnitID = params->id++;
+	fu_desc->bSourceID = src_id;
 	fu_desc->bControlSize  = 2;
 
-	/* bUnitID, bSourceID and bmaControls will be defined later */
+	if (params->dir == HOST_TO_DEVICE) {
+		if (params->opts->c_mute_present)
+			control |= UAC_FU_MUTE;
+		if (params->opts->c_volume_present)
+			control |= UAC_FU_VOLUME;
+	}
+
+	if (params->dir == DEVICE_TO_HOST) {
+		if (params->opts->p_mute_present)
+			control |= UAC_FU_MUTE;
+		if (params->opts->p_volume_present)
+			control |= UAC_FU_VOLUME;
+	}
+
+	/* Only master volume/mute is supported. Per-channel controls are all zero. */
+	fu_desc->bmaControls[0] = cpu_to_le16(control);
+
+	/* iFeature is located after all channel controls */
+	i_feature = (u8 *)fu_desc + fu_desc->bLength - 1;
+	*i_feature = add_string(params->strings, alt_opts->fu_vol_name);
 
 	return fu_desc;
 }
 
-/* B.3.2  Class-Specific AC Interface Descriptor */
+/* 4.3.2  Class-Specific AC Interface Descriptor */
 static struct
-uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
+uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1 *uac1, struct f_uac1_opts *opts)
 {
 	struct uac1_ac_header_descriptor *ac_desc;
 	int ac_header_desc_size;
-	int num_ifaces = 0;
-
-	if (EPOUT_EN(opts))
-		num_ifaces++;
-	if (EPIN_EN(opts))
-		num_ifaces++;
+	int capture = epout_en_any(opts);
+	int playback = epin_en_any(opts);
+	int ba_iface_id = 0;
 
-	ac_header_desc_size = UAC_DT_AC_HEADER_SIZE(num_ifaces);
+	ac_header_desc_size = UAC_DT_AC_HEADER_SIZE(capture + playback);
 
 	ac_desc = kzalloc(ac_header_desc_size, GFP_KERNEL);
 	if (!ac_desc)
@@ -1275,195 +1052,530 @@ uac1_ac_header_descriptor *build_ac_header_desc(struct f_uac1_opts *opts)
 	ac_desc->bDescriptorType = USB_DT_CS_INTERFACE;
 	ac_desc->bDescriptorSubtype = UAC_HEADER;
 	ac_desc->bcdADC = cpu_to_le16(0x0100);
-	ac_desc->bInCollection = num_ifaces;
+	ac_desc->bInCollection = capture + playback;
+
+	if (capture)
+		ac_desc->baInterfaceNr[ba_iface_id++] = uac1->as_out_intf;
+
+	if (playback)
+		ac_desc->baInterfaceNr[ba_iface_id++] = uac1->as_in_intf;
 
-	/* wTotalLength and baInterfaceNr will be defined later */
+	/* wTotalLength will be defined later */
 
 	return ac_desc;
 }
 
+/* 4.5.1  Standard AS Interface Descriptor */
+static void init_as_interface_desc(struct usb_interface_descriptor *iface_desc,
+				   u8 ifnum, u8 alt, u8 endpoints, const char *name,
+				   struct usb_string *strings)
+{
+	iface_desc->bLength =			USB_DT_INTERFACE_SIZE;
+	iface_desc->bDescriptorType =		USB_DT_INTERFACE;
+	iface_desc->bInterfaceNumber =		ifnum;
+	iface_desc->bAlternateSetting =		alt;
+	iface_desc->bNumEndpoints =		endpoints;
+	iface_desc->bInterfaceClass =		USB_CLASS_AUDIO;
+	iface_desc->bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING;
+	iface_desc->bInterfaceProtocol =	0;
+	iface_desc->iInterface =		add_string(strings, name);
+}
+
+/* 4.5.2  Class-Specific AS Interface Descriptor */
+static void init_as_header_desc(struct uac1_as_header_descriptor *as_header_desc, int terminalId)
+{
+	as_header_desc->bLength =		UAC_DT_AS_HEADER_SIZE;
+	as_header_desc->bDescriptorType =	USB_DT_CS_INTERFACE;
+	as_header_desc->bDescriptorSubtype =	UAC_AS_GENERAL;
+	as_header_desc->bTerminalLink =		terminalId;
+	as_header_desc->bDelay =		1;
+	as_header_desc->wFormatTag =		cpu_to_le16(UAC_FORMAT_TYPE_I_PCM);
+}
+
+/* 4.5.3 Class-Specific AS Format Type Descriptor */
+static void init_uac_format_type_i_discrete_desc(struct f_uac1_alt_opts *alt_opts)
+{
+	int idx, i;
+
+	alt_opts->fmt_desc.bDescriptorType = USB_DT_CS_INTERFACE;
+	alt_opts->fmt_desc.bDescriptorSubtype = UAC_FORMAT_TYPE;
+	alt_opts->fmt_desc.bFormatType = UAC_FORMAT_TYPE_I;
+	alt_opts->fmt_desc.bNrChannels = num_channels(alt_opts->chmask);
+	alt_opts->fmt_desc.bSubframeSize = alt_opts->ssize;
+	alt_opts->fmt_desc.bBitResolution = alt_opts->ssize * 8;
+
+	/* Set sample rates */
+	for (i = 0, idx = 0; i < UAC_MAX_RATES; i++) {
+		if (alt_opts->srates[i] == 0)
+			break;
+		memcpy(alt_opts->fmt_desc.tSamFreq[idx++],
+			&alt_opts->srates[i], 3);
+	}
+	alt_opts->fmt_desc.bLength = UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(idx);
+	alt_opts->fmt_desc.bSamFreqType = idx;
+}
+
+static int init_isoc_ep_descriptor(struct device *dev, struct usb_endpoint_descriptor *ep_desc,
+				   struct f_uac1_alt_opts *alt_opts, int dir,
+				   enum usb_device_speed speed, u8 addr)
+{
+	ep_desc->bLength =		USB_DT_ENDPOINT_AUDIO_SIZE;
+	ep_desc->bDescriptorType =	USB_DT_ENDPOINT;
+	ep_desc->bEndpointAddress =	addr;
+	ep_desc->bmAttributes =		USB_ENDPOINT_XFER_ISOC |
+					(((dir == HOST_TO_DEVICE) && !EPOUT_FBACK_IN_EN(alt_opts))
+						? USB_ENDPOINT_SYNC_ADAPTIVE
+						: USB_ENDPOINT_SYNC_ASYNC);
+	ep_desc->bInterval =		1; /* For FS. For HS/SS, this is set later from hs_bint. */
+	ep_desc->bRefresh =		0;
+	ep_desc->bSynchAddress =	EPOUT_FBACK_IN_EN(alt_opts)
+						? fs_as_in_fback_desc.bEndpointAddress : 0;
+
+	return set_ep_max_packet_size_bint(dev, alt_opts, ep_desc, speed, (dir == DEVICE_TO_HOST));
+}
+
+static void init_isoc_ep_descriptor_comp(struct usb_ss_ep_comp_descriptor *ep_desc_comp,
+					 struct usb_endpoint_descriptor *ep_desc)
+{
+	ep_desc_comp->bLength		= sizeof(*ep_desc_comp),
+	ep_desc_comp->bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
+	ep_desc_comp->bMaxBurst		= 0,
+	ep_desc_comp->bmAttributes	= 0,
+	ep_desc_comp->wBytesPerInterval = ep_desc->wMaxPacketSize;
+}
+
+static int init_alt_descriptors(struct device *dev, struct f_uac1_alt_opts *alt_opts, int ifnum,
+				u8 epaddr, int endpoints, int terminalID, int dir,
+				struct usb_string *strings)
+{
+	int status = 0;
+
+	init_as_header_desc(&alt_opts->as_header_desc, terminalID);
+	init_as_interface_desc(&alt_opts->intf_desc, ifnum, alt_opts->c.alt_num, endpoints,
+			       alt_opts->name, strings);
+	init_uac_format_type_i_discrete_desc(alt_opts);
+
+	status = init_isoc_ep_descriptor(dev, &alt_opts->fs_iso_ep_desc, alt_opts, dir,
+					 USB_SPEED_FULL, epaddr);
+	if (!status)
+		status = init_isoc_ep_descriptor(dev, &alt_opts->hs_iso_ep_desc, alt_opts, dir,
+						 USB_SPEED_HIGH, epaddr);
+	if (!status)
+		status = init_isoc_ep_descriptor(dev, &alt_opts->ss_iso_ep_desc, alt_opts, dir,
+						 USB_SPEED_SUPER, epaddr);
+
+	init_isoc_ep_descriptor_comp(&alt_opts->ss_iso_ep_desc_comp, &alt_opts->ss_iso_ep_desc);
+
+	return status;
+}
+
+static struct f_uac1_path_descriptors *
+build_path_descriptors(struct path_params *params, struct f_uac1_alt_opts *alt_opts)
+{
+	struct f_uac1_path_descriptors *path_descs;
+	u8 srcId;
+
+	path_descs = kzalloc(sizeof(*path_descs), GFP_KERNEL);
+	if (!path_descs)
+		return NULL;
+
+	path_descs->dir = params->dir;
+	path_descs->alt_opts = alt_opts;
+
+	init_it_desc(&path_descs->it_desc, alt_opts, params);
+	srcId = path_descs->it_desc.bTerminalID;
+
+	if (((params->dir == HOST_TO_DEVICE) && FUOUT_EN(params->opts)) ||
+	    ((params->dir == DEVICE_TO_HOST) && FUIN_EN(params->opts))) {
+		path_descs->fu_desc = build_fu_desc(alt_opts, params,
+						    path_descs->it_desc.bTerminalID);
+		srcId = path_descs->fu_desc->bUnitID;
+	}
+
+	init_ot_desc(&path_descs->ot_desc, alt_opts, params, srcId);
+
+	return path_descs;
+}
+
+static void free_path_descriptors(struct f_uac1_path_descriptors *path_descs)
+{
+	kfree(path_descs->fu_desc);
+	kfree(path_descs);
+}
+
+static struct f_uac1_path_descriptors *find_path_descriptors(struct list_head *list,
+							     struct f_uac1_alt_opts *alt_opts,
+							     int dir)
+{
+	struct f_uac1_path_descriptors *path_descs;
+
+	list_for_each_entry(path_descs, list, list) {
+		/* Check that all options used in the path descriptors are the same */
+		if ((path_descs->dir == dir) &&
+		    (!strncmp(path_descs->alt_opts->name, alt_opts->name,
+			      sizeof(alt_opts->name))) &&
+		    (!strncmp(path_descs->alt_opts->it_name, alt_opts->it_name,
+			      sizeof(alt_opts->it_name))) &&
+		    (!strncmp(path_descs->alt_opts->it_ch_name, alt_opts->it_ch_name,
+			      sizeof(alt_opts->it_ch_name))) &&
+		    (!strncmp(path_descs->alt_opts->ot_name, alt_opts->ot_name,
+			      sizeof(alt_opts->ot_name))) &&
+		    (path_descs->alt_opts->chmask == alt_opts->chmask) &&
+		    (path_descs->alt_opts->terminal_type == alt_opts->terminal_type))
+			return path_descs;
+	}
+	return NULL;
+}
+
+static int add_path_descriptors(struct list_head *list,
+				struct path_params *params,
+				struct f_uac1_alt_opts *alt_opts)
+{
+	int len = 0;
+	struct f_uac1_path_descriptors *path_descs;
+
+	if (!EP_EN(alt_opts))
+		return 0;
+
+	path_descs = find_path_descriptors(list, alt_opts, params->dir);
+
+	if (!path_descs) {
+		path_descs = build_path_descriptors(params, alt_opts);
+		if (path_descs) {
+			list_add_tail(&path_descs->list, list);
+			len += sizeof(path_descs->it_desc);
+			len += sizeof(path_descs->ot_desc);
+			if (path_descs->fu_desc)
+				len += path_descs->fu_desc->bLength;
+		}
+	}
+
+	if (path_descs) {
+		alt_opts->as_header_desc.bTerminalLink =
+			(params->dir == HOST_TO_DEVICE) ? path_descs->it_desc.bTerminalID
+							: path_descs->ot_desc.bTerminalID;
+		alt_opts->it_id = path_descs->it_desc.bTerminalID;
+		alt_opts->fu_id = path_descs->fu_desc ? path_descs->fu_desc->bUnitID : 0;
+		alt_opts->ot_id = path_descs->ot_desc.bTerminalID;
+	}
+
+	return len;
+}
+
 /* Use macro to overcome line length limitation */
 #define USBDHDR(p) (struct usb_descriptor_header *)(p)
 
-static void setup_headers(struct f_uac1_opts *opts,
-			  struct usb_descriptor_header **headers,
-			  enum usb_device_speed speed);
+static int setup_headers(struct usb_descriptor_header **desc_list,
+			 struct f_uac1 *uac1,
+			 struct f_uac1_opts *opts,
+			 struct list_head *path_descs,
+			 enum usb_device_speed speed);
 
-static void setup_descriptor(struct f_uac1_opts *opts)
+static int setup_descriptor(struct device *dev, struct f_uac1 *uac1, struct f_uac1_opts *opts,
+			    struct usb_string *strings)
 {
+	int status;
+	struct usb_descriptor_header **fs_desc_list, **hs_desc_list, **ss_ssp_desc_list;
+
 	/* patch descriptors */
-	int i = 1; /* ID's start with 1 */
-
-	if (EPOUT_EN(opts))
-		usb_out_it_desc.bTerminalID = i++;
-	if (EPIN_EN(opts))
-		io_in_it_desc.bTerminalID = i++;
-	if (EPOUT_EN(opts))
-		io_out_ot_desc.bTerminalID = i++;
-	if (EPIN_EN(opts))
-		usb_in_ot_desc.bTerminalID = i++;
-	if (FUOUT_EN(opts))
-		out_feature_unit_desc->bUnitID = i++;
-	if (FUIN_EN(opts))
-		in_feature_unit_desc->bUnitID = i++;
-
-	if (FUIN_EN(opts)) {
-		usb_in_ot_desc.bSourceID = in_feature_unit_desc->bUnitID;
-		in_feature_unit_desc->bSourceID = io_in_it_desc.bTerminalID;
-	} else {
-		usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
-	}
-	if (FUOUT_EN(opts)) {
-		io_out_ot_desc.bSourceID = out_feature_unit_desc->bUnitID;
-		out_feature_unit_desc->bSourceID = usb_out_it_desc.bTerminalID;
-	} else {
-		io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
+	int len;
+	struct list_head path_descs = LIST_HEAD_INIT(path_descs);
+	int fs_num, hs_num, ss_ssp_num;
+	struct f_uac1_alt_opts *alt_opts;
+	struct list_head *path_desc, *tmp;
+	struct path_params params;
+
+	params.id = 1; /* ID's start with 1 */
+	params.opts = opts;
+	params.strings = strings;
+
+	ac_header_desc = build_ac_header_desc(uac1, opts);
+	if (!ac_header_desc)
+		return -ENOMEM;
+
+	len = ac_header_desc->bLength;
+
+	if (uac1->g_audio.out_ep) {
+		params.dir = HOST_TO_DEVICE;
+		init_as_interface_desc(&opts->c_alt_0_opts.intf_desc, uac1->as_out_intf, 0, 0,
+				       opts->c_alt_0_opts.name, strings);
+
+		/* Audio path descriptors (input terminal -> <feature unit> -> output terminal) */
+		len += add_path_descriptors(&path_descs, &params, &opts->c_alt_1_opts);
+
+		status = init_alt_descriptors(dev, &opts->c_alt_1_opts, uac1->as_out_intf,
+					      uac1->g_audio.out_ep->address,
+					      EPOUT_FBACK_IN_EN(&opts->c_alt_1_opts) ? 2 : 1,
+					      opts->c_alt_1_opts.it_id, HOST_TO_DEVICE, strings);
+		if (status) {
+			dev_err(dev, "Failed to init alt descs for capture alt %d (%d)\n",
+				1, status);
+			goto cleanup;
+		}
+
+		list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+			len += add_path_descriptors(&path_descs, &params, alt_opts);
+
+			status = init_alt_descriptors(dev, alt_opts, uac1->as_out_intf,
+						      uac1->g_audio.out_ep->address,
+						      EPOUT_FBACK_IN_EN(alt_opts) ? 2 : 1,
+						      alt_opts->it_id, HOST_TO_DEVICE, strings);
+			if (status) {
+				dev_err(dev, "Failed to init alt descs for capture alt %d (%d)\n",
+					alt_opts->c.alt_num, status);
+				goto cleanup;
+			}
+		}
 	}
 
-	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
-	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
+	if (uac1->g_audio.in_ep) {
+		params.dir = DEVICE_TO_HOST;
+		init_as_interface_desc(&opts->p_alt_0_opts.intf_desc, uac1->as_in_intf, 0, 0,
+				       opts->p_alt_0_opts.name, strings);
 
-	io_in_it_desc.wTerminalType = cpu_to_le16(opts->c_terminal_type);
-	io_out_ot_desc.wTerminalType = cpu_to_le16(opts->p_terminal_type);
-	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
+		/* Audio path descriptors (input terminal -> <feature unit> -> output terminal) */
+		len += add_path_descriptors(&path_descs, &params, &opts->p_alt_1_opts);
 
-	if (EPIN_EN(opts)) {
-		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
+		status = init_alt_descriptors(dev, &opts->p_alt_1_opts, uac1->as_in_intf,
+					      uac1->g_audio.in_ep->address, 1,
+					      opts->p_alt_1_opts.ot_id, DEVICE_TO_HOST, strings);
+		if (status) {
+			dev_err(dev, "Failed to init alt descs for playback alt %d (%d)\n",
+				1, status);
+			goto cleanup;
+		}
 
-		len += sizeof(usb_in_ot_desc);
-		len += sizeof(io_in_it_desc);
-		if (FUIN_EN(opts))
-			len += in_feature_unit_desc->bLength;
-		ac_header_desc->wTotalLength = cpu_to_le16(len);
+		list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+			len += add_path_descriptors(&path_descs, &params, alt_opts);
+
+			status = init_alt_descriptors(dev, alt_opts, uac1->as_in_intf,
+						      uac1->g_audio.in_ep->address, 1,
+						      alt_opts->ot_id, DEVICE_TO_HOST, strings);
+			if (status) {
+				dev_err(dev, "Failed to init alt descs for playback alt %d (%d)\n",
+					alt_opts->c.alt_num, status);
+				goto cleanup;
+			}
+		}
 	}
-	if (EPOUT_EN(opts)) {
-		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
 
-		len += sizeof(usb_out_it_desc);
-		len += sizeof(io_out_ot_desc);
-		if (FUOUT_EN(opts))
-			len += out_feature_unit_desc->bLength;
-		ac_header_desc->wTotalLength = cpu_to_le16(len);
+	ac_header_desc->wTotalLength = cpu_to_le16(len);
+
+	/* Count how many descriptors we have and then allocate and populate */
+	fs_num = setup_headers(NULL, uac1, opts, &path_descs, USB_SPEED_FULL);
+	hs_num = setup_headers(NULL, uac1, opts, &path_descs, USB_SPEED_HIGH);
+	ss_ssp_num = setup_headers(NULL, uac1, opts, &path_descs, USB_SPEED_SUPER);
+
+	fs_desc_list = kzalloc((fs_num + hs_num + ss_ssp_num) * sizeof(*fs_desc_list), GFP_KERNEL);
+	if (!fs_desc_list) {
+		status = -ENOMEM;
+		goto cleanup;
 	}
+	hs_desc_list = fs_desc_list + fs_num;
+	ss_ssp_desc_list = hs_desc_list + hs_num;
 
-	setup_headers(opts, f_audio_fs_desc, USB_SPEED_FULL);
-	setup_headers(opts, f_audio_hs_desc, USB_SPEED_HIGH);
-	setup_headers(opts, f_audio_ss_desc, USB_SPEED_SUPER);
+	(void) setup_headers(fs_desc_list, uac1, opts, &path_descs, USB_SPEED_FULL);
+	(void) setup_headers(hs_desc_list, uac1, opts, &path_descs, USB_SPEED_HIGH);
+	(void) setup_headers(ss_ssp_desc_list, uac1, opts, &path_descs, USB_SPEED_SUPER);
+
+	/* copy descriptors, and track endpoint copies */
+	status = usb_assign_descriptors(&uac1->g_audio.func, fs_desc_list, hs_desc_list,
+					ss_ssp_desc_list, ss_ssp_desc_list);
+
+	if (status)
+		dev_err(dev, "Failed to assign descriptors (%d)\n", status);
+
+	kfree(fs_desc_list);
+
+cleanup:
+	list_for_each_safe(path_desc, tmp, &path_descs) {
+		free_path_descriptors(
+			container_of(path_desc, struct f_uac1_path_descriptors, list));
+	}
+	kfree(ac_header_desc);
+	ac_header_desc = NULL;
+
+	return status;
 }
 
-static void setup_headers(struct f_uac1_opts *opts,
-			  struct usb_descriptor_header **headers,
-			  enum usb_device_speed speed)
+static inline void add_descriptor(int i, struct usb_descriptor_header **desc_list,
+				  struct usb_descriptor_header *desc)
+{
+	if (desc_list)
+		desc_list[i] = desc;
+}
+
+static int add_alt_descriptors(int i, struct usb_descriptor_header **desc_list,
+			       struct f_uac1_alt_opts *alt_opts, enum usb_device_speed speed)
+{
+	add_descriptor(i++, desc_list, USBDHDR(&alt_opts->intf_desc));
+	add_descriptor(i++, desc_list, USBDHDR(&alt_opts->as_header_desc));
+	add_descriptor(i++, desc_list, USBDHDR(&alt_opts->fmt_desc));
+	if (speed == USB_SPEED_FULL)
+		add_descriptor(i++, desc_list, USBDHDR(&alt_opts->fs_iso_ep_desc));
+	else if (speed == USB_SPEED_HIGH)
+		add_descriptor(i++, desc_list, USBDHDR(&alt_opts->hs_iso_ep_desc));
+	else if (speed == USB_SPEED_SUPER || speed == USB_SPEED_SUPER_PLUS) {
+		add_descriptor(i++, desc_list, USBDHDR(&alt_opts->ss_iso_ep_desc));
+		add_descriptor(i++, desc_list, USBDHDR(&alt_opts->ss_iso_ep_desc_comp));
+	}
+
+	return i;
+}
+
+static int setup_headers(struct usb_descriptor_header **desc_list,
+			 struct f_uac1 *uac1,
+			 struct f_uac1_opts *opts,
+			 struct list_head *path_descs,
+			 enum usb_device_speed speed)
 {
-	struct usb_ss_ep_comp_descriptor *epout_desc_comp = NULL;
-	struct usb_ss_ep_comp_descriptor *epin_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *epin_fback_desc_comp = NULL;
 	struct usb_ss_ep_comp_descriptor *ep_int_desc_comp = NULL;
-	struct usb_endpoint_descriptor *epout_desc;
-	struct usb_endpoint_descriptor *epin_desc;
 	struct usb_endpoint_descriptor *epin_fback_desc;
 	struct usb_endpoint_descriptor *ep_int_desc;
-	int i;
+
+	int i = 0;
+	struct list_head *pos;
 
 	switch (speed) {
 	case USB_SPEED_FULL:
-		epout_desc = &fs_as_out_ep_desc;
-		epin_desc = &fs_as_in_ep_desc;
 		epin_fback_desc = &fs_as_in_fback_desc;
 		ep_int_desc = &fs_ac_int_ep_desc;
 		break;
 	case USB_SPEED_HIGH:
-		epout_desc = &hs_as_out_ep_desc;
-		epin_desc = &hs_as_in_ep_desc;
 		epin_fback_desc = &hs_as_in_fback_desc;
 		ep_int_desc = &hs_ac_int_ep_desc;
 		break;
 	default:
-		epout_desc = &ss_as_out_ep_desc;
-		epin_desc = &ss_as_in_ep_desc;
-		epout_desc_comp = &ss_as_out_ep_desc_comp;
-		epin_desc_comp = &ss_as_in_ep_desc_comp;
 		epin_fback_desc = &ss_as_in_fback_desc;
 		epin_fback_desc_comp = &ss_as_in_fback_desc_comp;
 		ep_int_desc = &ss_ac_int_ep_desc;
 		ep_int_desc_comp = &ss_ac_int_ep_desc_comp;
 	}
 
-	i = 0;
-	headers[i++] = USBDHDR(&ac_interface_desc);
-	headers[i++] = USBDHDR(ac_header_desc);
+	add_descriptor(i++, desc_list, USBDHDR(&ac_interface_desc));
+	add_descriptor(i++, desc_list, USBDHDR(ac_header_desc));
 
-	if (EPOUT_EN(opts)) {
-		headers[i++] = USBDHDR(&usb_out_it_desc);
-		headers[i++] = USBDHDR(&io_out_ot_desc);
-		if (FUOUT_EN(opts))
-			headers[i++] = USBDHDR(out_feature_unit_desc);
-	}
-
-	if (EPIN_EN(opts)) {
-		headers[i++] = USBDHDR(&io_in_it_desc);
-		headers[i++] = USBDHDR(&usb_in_ot_desc);
-		if (FUIN_EN(opts))
-			headers[i++] = USBDHDR(in_feature_unit_desc);
+	list_for_each(pos, path_descs) {
+		struct f_uac1_path_descriptors *path_desc =
+			container_of(pos, struct f_uac1_path_descriptors, list);
+		add_descriptor(i++, desc_list, USBDHDR(&path_desc->it_desc));
+		add_descriptor(i++, desc_list, USBDHDR(&path_desc->ot_desc));
+		if (path_desc->fu_desc)
+			add_descriptor(i++, desc_list, USBDHDR(path_desc->fu_desc));
 	}
 
+	// If any FU exists, add the interrupt endpoint descriptor
 	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
-		headers[i++] = USBDHDR(ep_int_desc);
+		add_descriptor(i++, desc_list, USBDHDR(ep_int_desc));
 		if (ep_int_desc_comp)
-			headers[i++] = USBDHDR(ep_int_desc_comp);
+			add_descriptor(i++, desc_list, USBDHDR(ep_int_desc_comp));
 	}
 
-	if (EPOUT_EN(opts)) {
-		headers[i++] = USBDHDR(&as_out_interface_alt_0_desc);
-		headers[i++] = USBDHDR(&as_out_interface_alt_1_desc);
-		headers[i++] = USBDHDR(&as_out_header_desc);
-		headers[i++] = USBDHDR(&as_out_type_i_desc);
-		headers[i++] = USBDHDR(epout_desc);
-		if (epout_desc_comp)
-			headers[i++] = USBDHDR(epout_desc_comp);
+	// If any capture interface is active
+	if (epout_en_any(opts)) {
+		struct f_uac1_alt_opts *alt_opts;
+
+		add_descriptor(i++, desc_list, USBDHDR(&opts->c_alt_0_opts.intf_desc));
 
-		headers[i++] = USBDHDR(&as_iso_out_desc);
+		if (EP_EN(&opts->c_alt_1_opts)) {
+			i = add_alt_descriptors(i, desc_list, &opts->c_alt_1_opts, speed);
 
-		if (EPOUT_FBACK_IN_EN(opts)) {
-			headers[i++] = USBDHDR(epin_fback_desc);
-			if (epin_fback_desc_comp)
-				headers[i++] = USBDHDR(epin_fback_desc_comp);
+			add_descriptor(i++, desc_list, USBDHDR(&as_iso_out_desc));
+			if (EPOUT_FBACK_IN_EN(&opts->c_alt_1_opts)) {
+				add_descriptor(i++, desc_list, USBDHDR(epin_fback_desc));
+				if (epin_fback_desc_comp)
+					add_descriptor(i++, desc_list,
+						       USBDHDR(epin_fback_desc_comp));
+			}
+		}
+
+		list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+			if (EP_EN(alt_opts)) {
+				i = add_alt_descriptors(i, desc_list, alt_opts, speed);
+
+				add_descriptor(i++, desc_list, USBDHDR(&as_iso_out_desc));
+				if (EPOUT_FBACK_IN_EN(alt_opts)) {
+					add_descriptor(i++, desc_list, USBDHDR(epin_fback_desc));
+					if (epin_fback_desc_comp)
+						add_descriptor(i++, desc_list,
+							       USBDHDR(epin_fback_desc_comp));
+				}
+			}
 		}
 	}
-	if (EPIN_EN(opts)) {
-		headers[i++] = USBDHDR(&as_in_interface_alt_0_desc);
-		headers[i++] = USBDHDR(&as_in_interface_alt_1_desc);
-		headers[i++] = USBDHDR(&as_in_header_desc);
-		headers[i++] = USBDHDR(&as_in_type_i_desc);
-		headers[i++] = USBDHDR(epin_desc);
-		if (epin_desc_comp)
-			headers[i++] = USBDHDR(epin_desc_comp);
 
-		headers[i++] = USBDHDR(&as_iso_in_desc);
+	// If any playback interface is active
+	if (epin_en_any(opts)) {
+		struct f_uac1_alt_opts *alt_opts;
+
+		add_descriptor(i++, desc_list, USBDHDR(&opts->p_alt_0_opts.intf_desc));
+
+		if (EP_EN(&opts->p_alt_1_opts)) {
+			i = add_alt_descriptors(i, desc_list, &opts->p_alt_1_opts, speed);
+
+			add_descriptor(i++, desc_list, USBDHDR(&as_iso_in_desc));
+		}
+
+		list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+			if (EP_EN(alt_opts)) {
+				i = add_alt_descriptors(i, desc_list, alt_opts, speed);
+
+				add_descriptor(i++, desc_list, USBDHDR(&as_iso_in_desc));
+			}
+		}
 	}
-	headers[i] = NULL;
+
+	add_descriptor(i++, desc_list, NULL);
+
+	return i;
 }
 
 static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
 {
 	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	struct f_uac1_alt_opts *alt_opts;
 
-	if (!opts->p_chmask && !opts->c_chmask) {
+	if (!epin_en_any(opts) && !epout_en_any(opts)) {
 		dev_err(dev, "Error: no playback and capture channels\n");
 		return -EINVAL;
-	} else if (opts->p_chmask & ~UAC1_CHANNEL_MASK) {
-		dev_err(dev, "Error: unsupported playback channels mask\n");
-		return -EINVAL;
-	} else if (opts->c_chmask & ~UAC1_CHANNEL_MASK) {
-		dev_err(dev, "Error: unsupported capture channels mask\n");
-		return -EINVAL;
-	} else if ((opts->p_ssize < 1) || (opts->p_ssize > 4)) {
-		dev_err(dev, "Error: incorrect playback sample size\n");
-		return -EINVAL;
-	} else if ((opts->c_ssize < 1) || (opts->c_ssize > 4)) {
-		dev_err(dev, "Error: incorrect capture sample size\n");
-		return -EINVAL;
-	} else if (!opts->p_srates[0]) {
+	}
+
+	list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+		if (alt_opts->chmask & ~UAC1_CHANNEL_MASK) {
+			dev_err(dev, "Error: unsupported playback channels mask for alt %d\n",
+				alt_opts->c.alt_num);
+			return -EINVAL;
+		} else if ((alt_opts->ssize < 1) || (alt_opts->ssize > 4)) {
+			dev_err(dev, "Error: incorrect playback sample size for alt %d\n",
+				alt_opts->c.alt_num);
+			return -EINVAL;
+		} else if ((alt_opts->hs_bint < 0) || (alt_opts->hs_bint > 4)) {
+			dev_err(dev, "Error: incorrect playback HS/SS bInterval (1-4: fixed, 0: auto) for alt %d\n",
+				alt_opts->c.alt_num);
+
+			return -EINVAL;
+		}
+	}
+
+	list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+		if (alt_opts->chmask & ~UAC1_CHANNEL_MASK) {
+			dev_err(dev, "Error: unsupported capture channels mask for alt %d\n",
+				alt_opts->c.alt_num);
+			return -EINVAL;
+		} else if ((alt_opts->ssize < 1) || (alt_opts->ssize > 4)) {
+			dev_err(dev, "Error: incorrect capture sample size for alt %d\n",
+				alt_opts->c.alt_num);
+			return -EINVAL;
+		} else if ((alt_opts->hs_bint < 0) || (alt_opts->hs_bint > 4)) {
+			dev_err(dev, "Error: incorrect capture HS/SS bInterval (1-4: fixed, 0: auto) for alt %d\n",
+				alt_opts->c.alt_num);
+
+			return -EINVAL;
+		}
+	}
+
+	if (!opts->p_srates[0]) {
 		dev_err(dev, "Error: incorrect playback sampling rate\n");
 		return -EINVAL;
 	} else if (!opts->c_srates[0]) {
@@ -1493,15 +1605,6 @@ static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
 		return -EINVAL;
 	}
 
-	if ((opts->p_hs_bint < 0) || (opts->p_hs_bint > 4)) {
-		dev_err(dev, "Error: incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)\n");
-		return -EINVAL;
-	}
-	if ((opts->c_hs_bint < 0) || (opts->c_hs_bint > 4)) {
-		dev_err(dev, "Error: incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -1551,6 +1654,26 @@ static void init_alt_opts(struct f_uac1_alt_opts *alt_opts, struct f_uac1_opts *
 	alt_opts->terminal_type = (playback) ? opts->p_terminal_type : opts->c_terminal_type;
 }
 
+static u16 get_max_packet_size(struct f_uac1_alt_opts *alt_opts, struct list_head *list)
+{
+	u16 max_psize = max_t(u16,
+				le16_to_cpu(alt_opts->fs_iso_ep_desc.wMaxPacketSize),
+				le16_to_cpu(alt_opts->hs_iso_ep_desc.wMaxPacketSize));
+	max_psize = max_t(u16, max_psize,
+			le16_to_cpu(alt_opts->ss_iso_ep_desc.wMaxPacketSize));
+
+	list_for_each_entry(alt_opts, list, list) {
+		max_psize = max_t(u16, max_psize,
+				 le16_to_cpu(alt_opts->fs_iso_ep_desc.wMaxPacketSize));
+		max_psize = max_t(u16, max_psize,
+				 le16_to_cpu(alt_opts->hs_iso_ep_desc.wMaxPacketSize));
+		max_psize = max_t(u16, max_psize,
+				 le16_to_cpu(alt_opts->ss_iso_ep_desc.wMaxPacketSize));
+	}
+
+	return max_psize;
+}
+
 /* audio function driver setup/binding */
 static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 {
@@ -1562,9 +1685,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	struct f_uac1_opts		*audio_opts;
 	struct usb_ep			*ep = NULL;
 	struct usb_string		*us;
-	int				ba_iface_id;
 	int				status;
-	int				idx, i;
+	struct list_head		strings = LIST_HEAD_INIT(strings);
 
 	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
 
@@ -1588,214 +1710,41 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	 * be used from their alt mode opts.
 	 */
 
-	us = attach_strings(cdev, audio_opts);
-	if (IS_ERR(us))
-		return PTR_ERR(us);
-
-	ac_header_desc = build_ac_header_desc(audio_opts);
-	if (!ac_header_desc)
-		return -ENOMEM;
-
-	if (FUOUT_EN(audio_opts)) {
-		out_feature_unit_desc = build_fu_desc(audio_opts->c_chmask);
-		if (!out_feature_unit_desc) {
-			status = -ENOMEM;
-			goto fail;
-		}
-	}
-	if (FUIN_EN(audio_opts)) {
-		in_feature_unit_desc = build_fu_desc(audio_opts->p_chmask);
-		if (!in_feature_unit_desc) {
-			status = -ENOMEM;
-			goto err_free_fu;
-		}
-	}
-
-	ac_interface_desc.iInterface = add_string(us, audio_opts->function_name);
-	usb_out_it_desc.iTerminal = add_string(us, audio_opts->c_alt_1_opts.it_name);
-	usb_out_it_desc.iChannelNames = add_string(us, audio_opts->c_alt_1_opts.it_ch_name);
-	io_out_ot_desc.iTerminal = add_string(us, audio_opts->c_alt_1_opts.ot_name);
-	as_out_interface_alt_0_desc.iInterface = add_string(us, audio_opts->c_alt_0_opts.name);
-	as_out_interface_alt_1_desc.iInterface = add_string(us, audio_opts->c_alt_1_opts.name);
-	io_in_it_desc.iTerminal = add_string(us, audio_opts->p_alt_1_opts.it_name);
-	io_in_it_desc.iChannelNames = add_string(us, audio_opts->p_alt_1_opts.it_ch_name);
-	usb_in_ot_desc.iTerminal = add_string(us, audio_opts->p_alt_1_opts.ot_name);
-	as_in_interface_alt_0_desc.iInterface = add_string(us, audio_opts->p_alt_0_opts.name);
-	as_in_interface_alt_1_desc.iInterface = add_string(us, audio_opts->p_alt_1_opts.name);
-
-	if (FUOUT_EN(audio_opts)) {
-		u8 *i_feature;
-
-		i_feature = (u8 *)out_feature_unit_desc +
-					out_feature_unit_desc->bLength - 1;
-		*i_feature = add_string(us, audio_opts->c_alt_1_opts.fu_vol_name);
-	}
-	if (FUIN_EN(audio_opts)) {
-		u8 *i_feature;
-
-		i_feature = (u8 *)in_feature_unit_desc +
-					in_feature_unit_desc->bLength - 1;
-		*i_feature = add_string(us, audio_opts->p_alt_1_opts.fu_vol_name);
-	}
-
 	us = attach_strings(cdev, audio_opts);
 	if (IS_ERR(us)) {
 		status = PTR_ERR(us);
 		goto fail;
 	}
 
-	/* Set channel numbers */
-	usb_out_it_desc.bNrChannels = num_channels(audio_opts->c_chmask);
-	usb_out_it_desc.wChannelConfig = cpu_to_le16(audio_opts->c_chmask);
-	as_out_type_i_desc.bNrChannels = num_channels(audio_opts->c_chmask);
-	as_out_type_i_desc.bSubframeSize = audio_opts->c_ssize;
-	as_out_type_i_desc.bBitResolution = audio_opts->c_ssize * 8;
-	io_in_it_desc.bNrChannels = num_channels(audio_opts->p_chmask);
-	io_in_it_desc.wChannelConfig = cpu_to_le16(audio_opts->p_chmask);
-	as_in_type_i_desc.bNrChannels = num_channels(audio_opts->p_chmask);
-	as_in_type_i_desc.bSubframeSize = audio_opts->p_ssize;
-	as_in_type_i_desc.bBitResolution = audio_opts->p_ssize * 8;
-
-	if (FUOUT_EN(audio_opts)) {
-		__le16 *bma = (__le16 *)&out_feature_unit_desc->bmaControls[0];
-		u32 control = 0;
-
-		if (audio_opts->c_mute_present)
-			control |= UAC_FU_MUTE;
-		if (audio_opts->c_volume_present)
-			control |= UAC_FU_VOLUME;
-		*bma = cpu_to_le16(control);
-	}
-	if (FUIN_EN(audio_opts)) {
-		__le16 *bma = (__le16 *)&in_feature_unit_desc->bmaControls[0];
-		u32 control = 0;
-
-		if (audio_opts->p_mute_present)
-			control |= UAC_FU_MUTE;
-		if (audio_opts->p_volume_present)
-			control |= UAC_FU_VOLUME;
-		*bma = cpu_to_le16(control);
-	}
-
-	/* Set sample rates */
-	for (i = 0, idx = 0; i < UAC_MAX_RATES; i++) {
-		if (audio_opts->c_srates[i] == 0)
-			break;
-		memcpy(as_out_type_i_desc.tSamFreq[idx++],
-				&audio_opts->c_srates[i], 3);
-	}
-	as_out_type_i_desc.bLength = UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(idx);
-	as_out_type_i_desc.bSamFreqType = idx;
+	ac_interface_desc.iInterface = add_string(us, audio_opts->function_name);
 
-	for (i = 0, idx = 0; i < UAC_MAX_RATES; i++) {
-		if (audio_opts->p_srates[i] == 0)
-			break;
-		memcpy(as_in_type_i_desc.tSamFreq[idx++],
-				&audio_opts->p_srates[i], 3);
-	}
-	as_in_type_i_desc.bLength = UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(idx);
-	as_in_type_i_desc.bSamFreqType = idx;
 	uac1->p_srate = audio_opts->p_srates[0];
 	uac1->c_srate = audio_opts->c_srates[0];
 
-	/* allocate instance-specific interface IDs, and patch descriptors */
+	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto err_free_fu;
+		goto fail;
 	ac_interface_desc.bInterfaceNumber = status;
-	ac_interface_desc.bNumEndpoints = 1;
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
 
-	ba_iface_id = 0;
-
-	if (EPOUT_EN(audio_opts)) {
+	if (epout_en_any(audio_opts)) {
 		status = usb_interface_id(c, f);
 		if (status < 0)
-			goto err_free_fu;
-		as_out_interface_alt_0_desc.bInterfaceNumber = status;
-		as_out_interface_alt_1_desc.bInterfaceNumber = status;
-		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
+			goto fail;
 		uac1->as_out_intf = status;
 		uac1->as_out_alt = 0;
-
-		if (EPOUT_FBACK_IN_EN(audio_opts)) {
-			fs_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			hs_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			ss_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			ac_interface_desc.bNumEndpoints++;
-		} else {
-			fs_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-			hs_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-			ss_as_out_ep_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-		}
 	}
 
-	if (EPIN_EN(audio_opts)) {
+	if (epin_en_any(audio_opts)) {
 		status = usb_interface_id(c, f);
 		if (status < 0)
-			goto err_free_fu;
-		as_in_interface_alt_0_desc.bInterfaceNumber = status;
-		as_in_interface_alt_1_desc.bInterfaceNumber = status;
-		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
+			goto fail;
 		uac1->as_in_intf = status;
 		uac1->as_in_alt = 0;
 	}
 
-	hs_as_in_ep_desc.bInterval = audio_opts->p_hs_bint;
-	ss_as_in_ep_desc.bInterval = audio_opts->p_hs_bint;
-	hs_as_out_ep_desc.bInterval = audio_opts->c_hs_bint;
-	ss_as_out_ep_desc.bInterval = audio_opts->c_hs_bint;
-
-	/* Calculate wMaxPacketSize according to audio bandwidth */
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &fs_as_in_ep_desc,
-					     USB_SPEED_FULL, true);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &fs_as_out_ep_desc,
-					     USB_SPEED_FULL, false);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &hs_as_in_ep_desc,
-					     USB_SPEED_HIGH, true);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &hs_as_out_ep_desc,
-					     USB_SPEED_HIGH, false);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &ss_as_in_ep_desc,
-					     USB_SPEED_SUPER, true);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
-	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &hs_as_out_ep_desc,
-					     USB_SPEED_SUPER, false);
-	if (status < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
-	}
-
 	audio->gadget = gadget;
 
 	status = -ENODEV;
@@ -1805,36 +1754,49 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate AC interrupt endpoint */
 	if (FUOUT_EN(audio_opts) || FUIN_EN(audio_opts)) {
 		ep = usb_ep_autoconfig(cdev->gadget, &fs_ac_int_ep_desc);
-		if (!ep)
-			goto err_free_fu;
-
+		if (!ep) {
+			status = -EINVAL;
+			dev_err(dev, "Failed to allocate interrupt endpoint\n");
+			goto fail;
+		}
 		hs_ac_int_ep_desc.bEndpointAddress = fs_ac_int_ep_desc.bEndpointAddress;
 		ss_ac_int_ep_desc.bEndpointAddress = fs_ac_int_ep_desc.bEndpointAddress;
 
 		uac1->int_ep = ep;
-		uac1->int_ep->desc = &fs_ac_int_ep_desc;
 
 		ac_interface_desc.bNumEndpoints = 1;
 	}
 
-	/* allocate instance-specific endpoints */
-	if (EPOUT_EN(audio_opts)) {
-		ep = usb_ep_autoconfig(cdev->gadget, &fs_as_out_ep_desc);
-		if (!ep)
-			goto err_free_fu;
-
-		hs_as_out_ep_desc.bEndpointAddress = fs_as_out_ep_desc.bEndpointAddress;
-		ss_as_out_ep_desc.bEndpointAddress = fs_as_out_ep_desc.bEndpointAddress;
-		ss_as_out_ep_desc_comp.wBytesPerInterval = ss_as_out_ep_desc.wMaxPacketSize;
+	/* Allocate instance-specific endpoints. These use the FS version for alt mode 1.
+	 * All other alt modes and speeds will be initialized to the same endpoint address
+	 * during the setup_descriptor() call. The u_audio code will update the currently
+	 * selected endpoint descriptor when the alt mode changes.
+	 */
+	if (epout_en_any(audio_opts)) {
+		status = init_isoc_ep_descriptor(dev, &audio_opts->c_alt_1_opts.fs_iso_ep_desc,
+						 &audio_opts->c_alt_1_opts, HOST_TO_DEVICE,
+						 USB_SPEED_FULL, USB_DIR_OUT);
+		if (status) {
+			dev_err(dev, "Failed to init FS isoc ep descriptor for capture (%d)\n",
+				status);
+			goto fail;
+		}
 
+		ep = usb_ep_autoconfig(cdev->gadget, &audio_opts->c_alt_1_opts.fs_iso_ep_desc);
+		if (!ep) {
+			status = -EINVAL;
+			dev_err(dev, "Failed to allocate isoc endpoint for capture\n");
+			goto fail;
+		}
 		audio->out_ep = ep;
-		audio->out_ep->desc = &fs_as_out_ep_desc;
 
-		if (EPOUT_FBACK_IN_EN(audio_opts)) {
+		if (epout_fback_in_en_any(audio_opts)) {
 			ep = usb_ep_autoconfig(cdev->gadget, &fs_as_in_fback_desc);
-			if (!ep)
-				goto err_free_fu;
-
+			if (!ep) {
+				status = -EINVAL;
+				dev_err(dev, "Failed to allocate feedback endpoint for capture\n");
+				goto fail;
+			}
 			hs_as_in_fback_desc.bEndpointAddress = fs_as_in_fback_desc.bEndpointAddress;
 			ss_as_in_fback_desc.bEndpointAddress = fs_as_in_fback_desc.bEndpointAddress;
 
@@ -1842,45 +1804,44 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 	}
 
-	if (EPIN_EN(audio_opts)) {
-		ep = usb_ep_autoconfig(cdev->gadget, &fs_as_in_ep_desc);
-		if (!ep)
-			goto err_free_fu;
-
-		hs_as_in_ep_desc.bEndpointAddress = fs_as_in_ep_desc.bEndpointAddress;
-		ss_as_in_ep_desc.bEndpointAddress = fs_as_in_ep_desc.bEndpointAddress;
-		ss_as_in_ep_desc_comp.wBytesPerInterval = ss_as_in_ep_desc.wMaxPacketSize;
+	if (epin_en_any(audio_opts)) {
+		status = init_isoc_ep_descriptor(dev, &audio_opts->p_alt_1_opts.fs_iso_ep_desc,
+						 &audio_opts->p_alt_1_opts, HOST_TO_DEVICE,
+						 USB_SPEED_FULL, USB_DIR_IN);
+		if (status) {
+			dev_err(dev, "Failed to init FS isoc ep descriptor for playback (%d)\n",
+				status);
+			goto fail;
+		}
 
+		ep = usb_ep_autoconfig(cdev->gadget, &audio_opts->p_alt_1_opts.fs_iso_ep_desc);
+		if (!ep) {
+			status = -EINVAL;
+			dev_err(dev, "Failed to allocate isoc endpoint for playback\n");
+			goto fail;
+		}
 		audio->in_ep = ep;
-		audio->in_ep->desc = &fs_as_in_ep_desc;
 	}
 
-	setup_descriptor(audio_opts);
+	status = setup_descriptor(dev, uac1, audio_opts, us);
 
-	/* copy descriptors, and track endpoint copies */
-	status = usb_assign_descriptors(f, f_audio_fs_desc, f_audio_hs_desc, f_audio_ss_desc,
-					f_audio_ss_desc);
 	if (status)
-		goto err_free_fu;
-
-	audio->in_ep_maxpsize = max_t(u16,
-				le16_to_cpu(fs_as_in_ep_desc.wMaxPacketSize),
-				le16_to_cpu(hs_as_in_ep_desc.wMaxPacketSize));
-	audio->out_ep_maxpsize = max_t(u16,
-				le16_to_cpu(fs_as_out_ep_desc.wMaxPacketSize),
-				le16_to_cpu(hs_as_out_ep_desc.wMaxPacketSize));
+		goto fail;
 
-	audio->in_ep_maxpsize = max_t(u16, audio->in_ep_maxpsize,
-				le16_to_cpu(ss_as_in_ep_desc.wMaxPacketSize));
-	audio->out_ep_maxpsize = max_t(u16, audio->out_ep_maxpsize,
-				le16_to_cpu(ss_as_out_ep_desc.wMaxPacketSize));
+	// Set max packet size for all alt modes. These are used to allocate the buffers in u_audio.
+	audio->out_ep_maxpsize = get_max_packet_size(&audio_opts->c_alt_1_opts,
+						     &audio_opts->c_alt_opts);
+	audio->in_ep_maxpsize = get_max_packet_size(&audio_opts->p_alt_1_opts,
+						    &audio_opts->p_alt_opts);
 
+	// TODO: This may need some change with the audio params for the current alt mode
 	audio->params.c_chmask = audio_opts->c_chmask;
 	memcpy(audio->params.c_srates, audio_opts->c_srates,
 			sizeof(audio->params.c_srates));
 	audio->params.c_ssize = audio_opts->c_ssize;
+
 	if (FUIN_EN(audio_opts)) {
-		audio->params.p_fu.id = USB_IN_FU_ID;
+		audio->params.p_fu.id = USB_IN_FU_ID(audio_opts);
 		audio->params.p_fu.mute_present = audio_opts->p_mute_present;
 		audio->params.p_fu.volume_present =
 				audio_opts->p_volume_present;
@@ -1888,12 +1849,15 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		audio->params.p_fu.volume_max = audio_opts->p_volume_max;
 		audio->params.p_fu.volume_res = audio_opts->p_volume_res;
 	}
+
+	// TODO: This may need some change with the audio params for the current alt mode
 	audio->params.p_chmask = audio_opts->p_chmask;
 	memcpy(audio->params.p_srates, audio_opts->p_srates,
 			sizeof(audio->params.p_srates));
 	audio->params.p_ssize = audio_opts->p_ssize;
+
 	if (FUOUT_EN(audio_opts)) {
-		audio->params.c_fu.id = USB_OUT_FU_ID;
+		audio->params.c_fu.id = USB_OUT_FU_ID(audio_opts);
 		audio->params.c_fu.mute_present = audio_opts->c_mute_present;
 		audio->params.c_fu.volume_present =
 				audio_opts->c_volume_present;
@@ -1914,14 +1878,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 err_card_register:
 	usb_free_all_descriptors(f);
-err_free_fu:
-	kfree(out_feature_unit_desc);
-	out_feature_unit_desc = NULL;
-	kfree(in_feature_unit_desc);
-	in_feature_unit_desc = NULL;
 fail:
-	kfree(ac_header_desc);
-	ac_header_desc = NULL;
 	return status;
 }
 
@@ -2342,11 +2299,6 @@ static void f_audio_unbind(struct usb_configuration *c, struct usb_function *f)
 	g_audio_cleanup(audio);
 	usb_free_all_descriptors(f);
 
-	kfree(out_feature_unit_desc);
-	out_feature_unit_desc = NULL;
-	kfree(in_feature_unit_desc);
-	in_feature_unit_desc = NULL;
-
 	kfree(ac_header_desc);
 	ac_header_desc = NULL;
 
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index ae69f1eb872d..e45bd17eb92f 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -9,6 +9,7 @@
 #define __U_UAC1_H
 
 #include <linux/usb/composite.h>
+#include <linux/usb/audio.h>
 #include "uac_common.h"
 
 #define UAC1_OUT_EP_MAX_PACKET_SIZE	200
@@ -47,8 +48,15 @@ struct f_uac1_alt_0_opts {
 	struct f_uac1_alt_opts_common c;
 
 	char			name[USB_MAX_STRING_LEN];
+
+	/* Descriptors */
+	struct usb_interface_descriptor	intf_desc;
 };
 
+DECLARE_UAC_FORMAT_TYPE_I_DISCRETE_DESC(UAC_MAX_RATES);
+#define uac_format_type_i_discrete_descriptor			\
+	uac_format_type_i_discrete_descriptor_##UAC_MAX_RATES
+
 /* Alt modes 1+ */
 struct f_uac1_alt_opts {
 	struct f_uac1_alt_opts_common c;
@@ -70,6 +78,36 @@ struct f_uac1_alt_opts {
 	u8			hs_bint;
 	s16			terminal_type;
 
+	/* Descriptors */
+	struct usb_interface_descriptor			intf_desc;
+	struct uac1_as_header_descriptor		as_header_desc;
+	struct uac_format_type_i_discrete_descriptor	fmt_desc;
+
+	struct usb_endpoint_descriptor			fs_iso_ep_desc;
+	struct usb_endpoint_descriptor			hs_iso_ep_desc;
+	struct usb_endpoint_descriptor			ss_iso_ep_desc;
+	struct usb_ss_ep_comp_descriptor		ss_iso_ep_desc_comp;
+
+	u8 it_id; /* Input Terminal Descriptor bTerminalID */
+	u8 fu_id; /* Feature Unit Descriptor bUnitID */
+	u8 ot_id; /* Output Terminal Descriptor bTerminalID */
+};
+
+#undef uac_format_type_i_discrete_descriptor
+
+struct f_uac1_path_descriptors {
+	struct list_head list;
+
+	int dir; /* HOST_TO_DEVICE or DEVICE_TO_HOST */
+
+	/* Alt mode opts this path descriptor is from */
+	struct f_uac1_alt_opts *alt_opts;
+
+	struct uac_input_terminal_descriptor it_desc;
+	struct uac1_output_terminal_descriptor ot_desc;
+
+	/* Feature unit is optional */
+	struct uac_feature_unit_descriptor *fu_desc;
 };
 
 struct f_uac1_opts {
-- 
2.43.0


