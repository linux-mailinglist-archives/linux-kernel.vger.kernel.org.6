Return-Path: <linux-kernel+bounces-342527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58639988FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10950280A69
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0E18C35C;
	Sat, 28 Sep 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCPcXD0N"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61918A921;
	Sat, 28 Sep 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536189; cv=none; b=Knmr5S/7ZoKeLw5gKVvvsEZyXocaG6RlTtbKcjVQpINbKyqpmWm1PNbo6yHCOEKPlQrJDanyuficcHcJvZfFTVeNZoPrOT83w5YNxjSOEG0992l+JyKB5imHNegJYt0Re3PU7u4AtnvLkVqZR33tnodhWAvE7sjcSRagKvf/ZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536189; c=relaxed/simple;
	bh=o7XGOokJ+e+sOjGGkTJZ+wTHZqR1vPtWH8P+uQmd+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVm2I067jH7C3lnuyBlXwrIPsgXyiAJXzkoxMzngbdKAxA6exrYFAxx3gccIR1UHniImuVtYJDHlrW4x3p5HMVZfXNcF4I68/tLX4fIVRVT+QlF+cg83L3mcznn7YXTzTlNUa0XfawLq6Lzg57mIn/je9SuPwYnzUk51J6qMhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCPcXD0N; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9a62c6734so26991685a.3;
        Sat, 28 Sep 2024 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536184; x=1728140984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz6QLjUN8djoup62DDAPYZRS4zR0AtcHy88IlKr36fM=;
        b=QCPcXD0Nr3JK9Cukco75Dcqk4FcoksSuc4VD4eAIsVbc/ALC5a4+6ldmje8kWp1adp
         OsdEvfXFr3SoCrkAIkMfxCoQlJJsYlHjfK6TY8M5YvrLoj/PBE+PfEJMpGdqd5sgZv1j
         Uz+QpuTI4NIC86uyERcsGWTuGpoAPb/aUtSgLOEiTsAyE8RYgOvgmR0Mjg5w1et1iew4
         MPFGqG2hPQxsYpdexbnRCuLjK2uzR1GDWh3kY0V5rR9yJfGXbUrt0dIpGj5qs7E8CqGx
         DOYCs+uRuoVzPegd6AZfG8T+MxMvePxfsW+x63kLhNqYyumLQocWPEULueXfabWfrWkD
         T+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536184; x=1728140984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz6QLjUN8djoup62DDAPYZRS4zR0AtcHy88IlKr36fM=;
        b=GG4oUQflhHXpM8R0K3WVMMzoAdSKHXobURtXuTCpnq5dNawZ+dp2Jc7hIVb4gJclLI
         mp2ldd2byXhiooQ931HnMohsakS+AhQ2OS979WX2Rgs8b5LwP5meHnZCAH0wyfdSTPQp
         We3ooA9Fxr9GfXs/zX9nM4/8CXSM8JccewACM8f7lQP8mm+t09eo6v+ymr3oeLeJ7pEo
         8/eLWoicxJeBJSOVBjpbUqrhXP3/NxegSpBhnz+JUCkMX3pJVYjSUDxqd6jr65zbX6ax
         i75zFqFP2dQRtvywoo29y1E9dA3d8DNu0OjrLHC8TlgtfE7iasBQrAYDlgIogkX6p7pN
         oJNA==
X-Forwarded-Encrypted: i=1; AJvYcCUiMUcFusSoICCW6I24sFnSVtDHUPw6aVb9pA/pcZ+pvMvh7pvWZd3BIykAZzTKjGr+xWJ5zv32XgM=@vger.kernel.org, AJvYcCXirBry8pB6RyR5bX4boEP1XtaeR/P3VJidWUi5UNJFfQBmIAAZLZ6hjcjApEuJV6Z8zNZStKx/7n8I2n40@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfJPqI5/qb0J8bn2lMAGGyd749ZX3yOBC/Vosga7G+Z58wPCo
	Ozr8UHBMlDlVIE7mGt7siikBWaH1wjO+VsWaUHyg7+TGzzXp/A8cNoHQJwP/DKc=
X-Google-Smtp-Source: AGHT+IGW4JQk4HIYPMoWaFCttCnWvXK9oy4qBu+P1iXTm5F+1j3cswuwN649ZVJisD3Ih3NEm03E3w==
X-Received: by 2002:a05:620a:1707:b0:7a9:bf88:7d9a with SMTP id af79cd13be357-7ae378c355dmr419970585a.10.1727536184033;
        Sat, 28 Sep 2024 08:09:44 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:43 -0700 (PDT)
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
Subject: [PATCH RFC 12/14] usb: gadget: f_uac2: Generate dynamic descriptors based on alt opts
Date: Sat, 28 Sep 2024 11:09:03 -0400
Message-ID: <20240928150905.2616313-13-crwulff@gmail.com>
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
 drivers/usb/gadget/function/f_uac2.c | 1322 ++++++++++++--------------
 drivers/usb/gadget/function/u_uac2.h |   32 +
 2 files changed, 654 insertions(+), 700 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 54702888855d..c30fbd062793 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -35,8 +35,8 @@
  */
 #define USB_OUT_CLK_ID	(out_clk_src_desc.bClockID)
 #define USB_IN_CLK_ID	(in_clk_src_desc.bClockID)
-#define USB_OUT_FU_ID	(out_feature_unit_desc->bUnitID)
-#define USB_IN_FU_ID	(in_feature_unit_desc->bUnitID)
+#define USB_OUT_FU_ID(_opts)	(_opts->c_alt_1_opts.fu_id)
+#define USB_IN_FU_ID(_opts)	(_opts->p_alt_1_opts.fu_id)
 
 #define CONTROL_ABSENT	0
 #define CONTROL_RDONLY	1
@@ -54,15 +54,36 @@
 #define UNFLW_CTRL	8
 #define OVFLW_CTRL	10
 
-#define EPIN_EN(_opts) ((_opts)->p_chmask != 0)
-#define EPOUT_EN(_opts) ((_opts)->c_chmask != 0)
-#define FUIN_EN(_opts) (EPIN_EN(_opts) \
+
+#define EP_EN(_alt_opts) ((_alt_opts) && ((_alt_opts)->chmask != 0))
+#define FUIN_EN(_opts) (EP_EN(&_opts->p_alt_1_opts) \
 				&& ((_opts)->p_mute_present \
 				|| (_opts)->p_volume_present))
-#define FUOUT_EN(_opts) (EPOUT_EN(_opts) \
+#define FUOUT_EN(_opts) (EP_EN(&_opts->c_alt_1_opts) \
 				&& ((_opts)->c_mute_present \
 				|| (_opts)->c_volume_present))
-#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
+#define EPOUT_FBACK_IN_EN(_alt_opts) ((_alt_opts)->sync == USB_ENDPOINT_SYNC_ASYNC)
+
+/* Check if any alt mode has option enabled */
+#define EN_ANY(single, fn, cp)						\
+static int fn(struct f_uac2_opts *opts)					\
+{									\
+	struct f_uac2_alt_opts *alt_opts;				\
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
 
 struct f_uac2 {
 	struct g_audio g_audio;
@@ -94,7 +115,7 @@ static int afunc_notify(struct g_audio *agdev, int unit_id, int cs);
 /* --------- USB Function Interface ------------- */
 
 static struct usb_interface_assoc_descriptor iad_desc = {
-	.bLength = sizeof iad_desc,
+	.bLength = sizeof(iad_desc),
 	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
 
 	.bFirstInterface = 0,
@@ -140,65 +161,6 @@ static struct uac_clock_source_descriptor out_clk_src_desc = {
 	.bAssocTerminal = 0,
 };
 
-/* Input Terminal for USB_OUT */
-static struct uac2_input_terminal_descriptor usb_out_it_desc = {
-	.bLength = sizeof usb_out_it_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_INPUT_TERMINAL,
-	/* .bTerminalID = DYNAMIC */
-	.wTerminalType = cpu_to_le16(UAC_TERMINAL_STREAMING),
-	.bAssocTerminal = 0,
-	/* .bCSourceID = DYNAMIC */
-	.iChannelNames = 0,
-	.bmControls = cpu_to_le16(CONTROL_RDWR << COPY_CTRL),
-};
-
-/* Input Terminal for I/O-In */
-static struct uac2_input_terminal_descriptor io_in_it_desc = {
-	.bLength = sizeof io_in_it_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_INPUT_TERMINAL,
-	/* .bTerminalID = DYNAMIC */
-	/* .wTerminalType = DYNAMIC */
-	.bAssocTerminal = 0,
-	/* .bCSourceID = DYNAMIC */
-	.iChannelNames = 0,
-	.bmControls = cpu_to_le16(CONTROL_RDWR << COPY_CTRL),
-};
-
-/* Ouput Terminal for USB_IN */
-static struct uac2_output_terminal_descriptor usb_in_ot_desc = {
-	.bLength = sizeof usb_in_ot_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_OUTPUT_TERMINAL,
-	/* .bTerminalID = DYNAMIC */
-	.wTerminalType = cpu_to_le16(UAC_TERMINAL_STREAMING),
-	.bAssocTerminal = 0,
-	/* .bSourceID = DYNAMIC */
-	/* .bCSourceID = DYNAMIC */
-	.bmControls = cpu_to_le16(CONTROL_RDWR << COPY_CTRL),
-};
-
-/* Ouput Terminal for I/O-Out */
-static struct uac2_output_terminal_descriptor io_out_ot_desc = {
-	.bLength = sizeof io_out_ot_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_OUTPUT_TERMINAL,
-	/* .bTerminalID = DYNAMIC */
-	/* .wTerminalType = DYNAMIC */
-	.bAssocTerminal = 0,
-	/* .bSourceID = DYNAMIC */
-	/* .bCSourceID = DYNAMIC */
-	.bmControls = cpu_to_le16(CONTROL_RDWR << COPY_CTRL),
-};
-
-static struct uac2_feature_unit_descriptor *in_feature_unit_desc;
-static struct uac2_feature_unit_descriptor *out_feature_unit_desc;
-
 static struct uac2_ac_header_descriptor ac_hdr_desc = {
 	.bLength = sizeof ac_hdr_desc,
 	.bDescriptorType = USB_DT_CS_INTERFACE,
@@ -246,89 +208,6 @@ static struct usb_ss_ep_comp_descriptor ss_ep_int_desc_comp = {
 	.wBytesPerInterval = cpu_to_le16(6),
 };
 
-/* Audio Streaming OUT Interface - Alt0 */
-static struct usb_interface_descriptor std_as_out_if0_desc = {
-	.bLength = sizeof std_as_out_if0_desc,
-	.bDescriptorType = USB_DT_INTERFACE,
-
-	.bAlternateSetting = 0,
-	.bNumEndpoints = 0,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
-	.bInterfaceProtocol = UAC_VERSION_2,
-};
-
-/* Audio Streaming OUT Interface - Alt1 */
-static struct usb_interface_descriptor std_as_out_if1_desc = {
-	.bLength = sizeof std_as_out_if1_desc,
-	.bDescriptorType = USB_DT_INTERFACE,
-
-	.bAlternateSetting = 1,
-	.bNumEndpoints = 1,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
-	.bInterfaceProtocol = UAC_VERSION_2,
-};
-
-/* Audio Stream OUT Intface Desc */
-static struct uac2_as_header_descriptor as_out_hdr_desc = {
-	.bLength = sizeof as_out_hdr_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_AS_GENERAL,
-	/* .bTerminalLink = DYNAMIC */
-	.bmControls = 0,
-	.bFormatType = UAC_FORMAT_TYPE_I,
-	.bmFormats = cpu_to_le32(UAC_FORMAT_TYPE_I_PCM),
-	.iChannelNames = 0,
-};
-
-/* Audio USB_OUT Format */
-static struct uac2_format_type_i_descriptor as_out_fmt1_desc = {
-	.bLength = sizeof as_out_fmt1_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype = UAC_FORMAT_TYPE,
-	.bFormatType = UAC_FORMAT_TYPE_I,
-};
-
-/* STD AS ISO OUT Endpoint */
-static struct usb_endpoint_descriptor fs_epout_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	.bEndpointAddress = USB_DIR_OUT,
-	/* .bmAttributes = DYNAMIC */
-	/* .wMaxPacketSize = DYNAMIC */
-	.bInterval = 1,
-};
-
-static struct usb_endpoint_descriptor hs_epout_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	/* .bmAttributes = DYNAMIC */
-	/* .wMaxPacketSize = DYNAMIC */
-	/* .bInterval = DYNAMIC */
-};
-
-static struct usb_endpoint_descriptor ss_epout_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	.bEndpointAddress = USB_DIR_OUT,
-	/* .bmAttributes = DYNAMIC */
-	/* .wMaxPacketSize = DYNAMIC */
-	/* .bInterval = DYNAMIC */
-};
-
-static struct usb_ss_ep_comp_descriptor ss_epout_desc_comp = {
-	.bLength		= sizeof(ss_epout_desc_comp),
-	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst		= 0,
-	.bmAttributes		= 0,
-	/* wBytesPerInterval = DYNAMIC */
-};
-
 /* CS AS ISO OUT Endpoint */
 static struct uac2_iso_endpoint_descriptor as_iso_out_desc = {
 	.bLength = sizeof as_iso_out_desc,
@@ -379,90 +258,6 @@ static struct usb_ss_ep_comp_descriptor ss_epin_fback_desc_comp = {
 	.wBytesPerInterval	= cpu_to_le16(4),
 };
 
-
-/* Audio Streaming IN Interface - Alt0 */
-static struct usb_interface_descriptor std_as_in_if0_desc = {
-	.bLength = sizeof std_as_in_if0_desc,
-	.bDescriptorType = USB_DT_INTERFACE,
-
-	.bAlternateSetting = 0,
-	.bNumEndpoints = 0,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
-	.bInterfaceProtocol = UAC_VERSION_2,
-};
-
-/* Audio Streaming IN Interface - Alt1 */
-static struct usb_interface_descriptor std_as_in_if1_desc = {
-	.bLength = sizeof std_as_in_if1_desc,
-	.bDescriptorType = USB_DT_INTERFACE,
-
-	.bAlternateSetting = 1,
-	.bNumEndpoints = 1,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
-	.bInterfaceProtocol = UAC_VERSION_2,
-};
-
-/* Audio Stream IN Intface Desc */
-static struct uac2_as_header_descriptor as_in_hdr_desc = {
-	.bLength = sizeof as_in_hdr_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-
-	.bDescriptorSubtype = UAC_AS_GENERAL,
-	/* .bTerminalLink = DYNAMIC */
-	.bmControls = 0,
-	.bFormatType = UAC_FORMAT_TYPE_I,
-	.bmFormats = cpu_to_le32(UAC_FORMAT_TYPE_I_PCM),
-	.iChannelNames = 0,
-};
-
-/* Audio USB_IN Format */
-static struct uac2_format_type_i_descriptor as_in_fmt1_desc = {
-	.bLength = sizeof as_in_fmt1_desc,
-	.bDescriptorType = USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype = UAC_FORMAT_TYPE,
-	.bFormatType = UAC_FORMAT_TYPE_I,
-};
-
-/* STD AS ISO IN Endpoint */
-static struct usb_endpoint_descriptor fs_epin_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	.bEndpointAddress = USB_DIR_IN,
-	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	/* .wMaxPacketSize = DYNAMIC */
-	.bInterval = 1,
-};
-
-static struct usb_endpoint_descriptor hs_epin_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	/* .wMaxPacketSize = DYNAMIC */
-	/* .bInterval = DYNAMIC */
-};
-
-static struct usb_endpoint_descriptor ss_epin_desc = {
-	.bLength = USB_DT_ENDPOINT_SIZE,
-	.bDescriptorType = USB_DT_ENDPOINT,
-
-	.bEndpointAddress = USB_DIR_IN,
-	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	/* .wMaxPacketSize = DYNAMIC */
-	/* .bInterval = DYNAMIC */
-};
-
-static struct usb_ss_ep_comp_descriptor ss_epin_desc_comp = {
-	.bLength		= sizeof(ss_epin_desc_comp),
-	.bDescriptorType	= USB_DT_SS_ENDPOINT_COMP,
-	.bMaxBurst		= 0,
-	.bmAttributes		= 0,
-	/* wBytesPerInterval = DYNAMIC */
-};
-
 /* CS AS ISO IN Endpoint */
 static struct uac2_iso_endpoint_descriptor as_iso_in_desc = {
 	.bLength = sizeof as_iso_in_desc,
@@ -475,115 +270,6 @@ static struct uac2_iso_endpoint_descriptor as_iso_in_desc = {
 	.wLockDelay = 0,
 };
 
-static struct usb_descriptor_header *fs_audio_desc[] = {
-	(struct usb_descriptor_header *)&iad_desc,
-	(struct usb_descriptor_header *)&std_ac_if_desc,
-
-	(struct usb_descriptor_header *)&ac_hdr_desc,
-	(struct usb_descriptor_header *)&in_clk_src_desc,
-	(struct usb_descriptor_header *)&out_clk_src_desc,
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-	(struct usb_descriptor_header *)&out_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-
-	(struct usb_descriptor_header *)&fs_ep_int_desc,
-
-	(struct usb_descriptor_header *)&std_as_out_if0_desc,
-	(struct usb_descriptor_header *)&std_as_out_if1_desc,
-
-	(struct usb_descriptor_header *)&as_out_hdr_desc,
-	(struct usb_descriptor_header *)&as_out_fmt1_desc,
-	(struct usb_descriptor_header *)&fs_epout_desc,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&fs_epin_fback_desc,
-
-	(struct usb_descriptor_header *)&std_as_in_if0_desc,
-	(struct usb_descriptor_header *)&std_as_in_if1_desc,
-
-	(struct usb_descriptor_header *)&as_in_hdr_desc,
-	(struct usb_descriptor_header *)&as_in_fmt1_desc,
-	(struct usb_descriptor_header *)&fs_epin_desc,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
-static struct usb_descriptor_header *hs_audio_desc[] = {
-	(struct usb_descriptor_header *)&iad_desc,
-	(struct usb_descriptor_header *)&std_ac_if_desc,
-
-	(struct usb_descriptor_header *)&ac_hdr_desc,
-	(struct usb_descriptor_header *)&in_clk_src_desc,
-	(struct usb_descriptor_header *)&out_clk_src_desc,
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-	(struct usb_descriptor_header *)&out_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-
-	(struct usb_descriptor_header *)&hs_ep_int_desc,
-
-	(struct usb_descriptor_header *)&std_as_out_if0_desc,
-	(struct usb_descriptor_header *)&std_as_out_if1_desc,
-
-	(struct usb_descriptor_header *)&as_out_hdr_desc,
-	(struct usb_descriptor_header *)&as_out_fmt1_desc,
-	(struct usb_descriptor_header *)&hs_epout_desc,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&hs_epin_fback_desc,
-
-	(struct usb_descriptor_header *)&std_as_in_if0_desc,
-	(struct usb_descriptor_header *)&std_as_in_if1_desc,
-
-	(struct usb_descriptor_header *)&as_in_hdr_desc,
-	(struct usb_descriptor_header *)&as_in_fmt1_desc,
-	(struct usb_descriptor_header *)&hs_epin_desc,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
-static struct usb_descriptor_header *ss_audio_desc[] = {
-	(struct usb_descriptor_header *)&iad_desc,
-	(struct usb_descriptor_header *)&std_ac_if_desc,
-
-	(struct usb_descriptor_header *)&ac_hdr_desc,
-	(struct usb_descriptor_header *)&in_clk_src_desc,
-	(struct usb_descriptor_header *)&out_clk_src_desc,
-	(struct usb_descriptor_header *)&usb_out_it_desc,
-  (struct usb_descriptor_header *)&out_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_in_it_desc,
-	(struct usb_descriptor_header *)&usb_in_ot_desc,
-	(struct usb_descriptor_header *)&in_feature_unit_desc,
-	(struct usb_descriptor_header *)&io_out_ot_desc,
-
-	(struct usb_descriptor_header *)&ss_ep_int_desc,
-	(struct usb_descriptor_header *)&ss_ep_int_desc_comp,
-
-	(struct usb_descriptor_header *)&std_as_out_if0_desc,
-	(struct usb_descriptor_header *)&std_as_out_if1_desc,
-
-	(struct usb_descriptor_header *)&as_out_hdr_desc,
-	(struct usb_descriptor_header *)&as_out_fmt1_desc,
-	(struct usb_descriptor_header *)&ss_epout_desc,
-	(struct usb_descriptor_header *)&ss_epout_desc_comp,
-	(struct usb_descriptor_header *)&as_iso_out_desc,
-	(struct usb_descriptor_header *)&ss_epin_fback_desc,
-	(struct usb_descriptor_header *)&ss_epin_fback_desc_comp,
-
-	(struct usb_descriptor_header *)&std_as_in_if0_desc,
-	(struct usb_descriptor_header *)&std_as_in_if1_desc,
-
-	(struct usb_descriptor_header *)&as_in_hdr_desc,
-	(struct usb_descriptor_header *)&as_in_fmt1_desc,
-	(struct usb_descriptor_header *)&ss_epin_desc,
-	(struct usb_descriptor_header *)&ss_epin_desc_comp,
-	(struct usb_descriptor_header *)&as_iso_in_desc,
-	NULL,
-};
-
 struct cntrl_cur_lay2 {
 	__le16	wCUR;
 };
@@ -720,11 +406,65 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_a
 		alt_opts->ssize, alt_opts->sync, alt_opts->c.opts->fb_max);
 }
 
-static struct uac2_feature_unit_descriptor *build_fu_desc(int chmask)
+struct path_params {
+	int dir;
+	int id;
+	struct f_uac2_opts *opts;
+	struct usb_string *strings;
+};
+
+/* Audio20 4.7.2.4 Input Terminal Descriptor */
+static void init_it_desc(struct uac2_input_terminal_descriptor *it_desc,
+			 struct f_uac2_alt_opts *alt_opts,
+			 struct path_params *params)
+{
+	it_desc->bLength =		sizeof(*it_desc);
+	it_desc->bDescriptorType =	USB_DT_CS_INTERFACE;
+	it_desc->bDescriptorSubtype =	UAC_INPUT_TERMINAL;
+	it_desc->bTerminalID =		params->id++;
+	it_desc->wTerminalType =	cpu_to_le16((params->dir == HOST_TO_DEVICE) ?
+							UAC_TERMINAL_STREAMING :
+							alt_opts->terminal_type);
+	it_desc->bAssocTerminal =	0;
+	it_desc->bCSourceID =		(params->dir == HOST_TO_DEVICE) ? out_clk_src_desc.bClockID
+									: in_clk_src_desc.bClockID;
+	it_desc->bNrChannels =		num_channels(alt_opts->chmask);
+	it_desc->bmChannelConfig =	cpu_to_le32(alt_opts->chmask);
+	it_desc->iChannelNames =	add_string(params->strings, alt_opts->it_ch_name);
+	it_desc->bmControls =		cpu_to_le16(CONTROL_RDWR << COPY_CTRL);
+	it_desc->iTerminal =		add_string(params->strings, alt_opts->it_name);
+}
+
+/* Audio20 4.7.2.5 Output Terminal Descriptor */
+static void init_ot_desc(struct uac2_output_terminal_descriptor *ot_desc,
+			 struct f_uac2_alt_opts *alt_opts,
+			 struct path_params *params, int src_id)
+{
+	ot_desc->bLength =		sizeof(*ot_desc);
+	ot_desc->bDescriptorType =	USB_DT_CS_INTERFACE;
+	ot_desc->bDescriptorSubtype =	UAC_OUTPUT_TERMINAL;
+	ot_desc->bTerminalID =		params->id++;
+	ot_desc->wTerminalType =	cpu_to_le16((params->dir == HOST_TO_DEVICE) ?
+							alt_opts->terminal_type :
+							UAC_TERMINAL_STREAMING);
+	ot_desc->bAssocTerminal =	0;
+	ot_desc->bSourceID =		src_id;
+	ot_desc->bCSourceID =		(params->dir == HOST_TO_DEVICE) ? out_clk_src_desc.bClockID
+									: in_clk_src_desc.bClockID;
+	ot_desc->bmControls =		cpu_to_le16(CONTROL_RDWR << COPY_CTRL);
+	ot_desc->iTerminal =		add_string(params->strings, alt_opts->ot_name);
+}
+
+/* Audio20 4.7.2.8 Feature Unit Descriptor */
+static struct uac2_feature_unit_descriptor *build_fu_desc(struct f_uac2_alt_opts *alt_opts,
+							  struct path_params *params, int src_id)
 {
 	struct uac2_feature_unit_descriptor *fu_desc;
-	int channels = num_channels(chmask);
+	int channels = num_channels(alt_opts->chmask);
 	int fu_desc_size = UAC2_DT_FEATURE_UNIT_SIZE(channels);
+	__le32 *bma;
+	u32 control = 0;
+	u8 *i_feature;
 
 	fu_desc = kzalloc(fu_desc_size, GFP_KERNEL);
 	if (!fu_desc)
@@ -732,218 +472,520 @@ static struct uac2_feature_unit_descriptor *build_fu_desc(int chmask)
 
 	fu_desc->bLength = fu_desc_size;
 	fu_desc->bDescriptorType = USB_DT_CS_INTERFACE;
-
 	fu_desc->bDescriptorSubtype = UAC_FEATURE_UNIT;
+	fu_desc->bUnitID = params->id++;
+	fu_desc->bSourceID = src_id;
 
 	/* bUnitID, bSourceID and bmaControls will be defined later */
+	if (params->dir == HOST_TO_DEVICE) {
+		if (params->opts->c_mute_present)
+			control |= CONTROL_RDWR << FU_MUTE_CTRL;
+		if (params->opts->c_volume_present)
+			control |= CONTROL_RDWR << FU_VOL_CTRL;
+	}
+
+	if (params->dir == DEVICE_TO_HOST) {
+		if (params->opts->p_mute_present)
+			control |= CONTROL_RDWR << FU_MUTE_CTRL;
+		if (params->opts->p_volume_present)
+			control |= CONTROL_RDWR << FU_VOL_CTRL;
+	}
+
+	/* Only master volume/mute is supported. Per-channel controls are all zero. */
+	bma = (__le32 *)&fu_desc->bmaControls[0];
+	*bma = cpu_to_le32(control);
+
+	/* iFeature is located after all channel controls */
+	i_feature = (u8 *)fu_desc + fu_desc->bLength - 1;
+	*i_feature = add_string(params->strings, alt_opts->fu_vol_name);
 
 	return fu_desc;
 }
 
+/* Audio20 4.9.1  Standard AS Interface Descriptor */
+static void init_as_interface_desc(struct usb_interface_descriptor *iface_desc,
+				   u8 ifnum, u8 alt, u8 endpoints, const char *name,
+				   struct usb_string *strings)
+{
+	iface_desc->bLength =			sizeof(*iface_desc);
+	iface_desc->bDescriptorType =		USB_DT_INTERFACE;
+	iface_desc->bInterfaceNumber =		ifnum;
+	iface_desc->bAlternateSetting =		alt;
+	iface_desc->bNumEndpoints =		endpoints;
+	iface_desc->bInterfaceClass =		USB_CLASS_AUDIO;
+	iface_desc->bInterfaceSubClass =	USB_SUBCLASS_AUDIOSTREAMING;
+	iface_desc->bInterfaceProtocol =	UAC_VERSION_2;
+	iface_desc->iInterface =		add_string(strings, name);
+}
+
+/* Audio20 4.9.2  Class-Specific AS Interface Descriptor */
+static void init_as_header_desc(struct f_uac2_alt_opts *alt_opts, int terminalId)
+{
+	alt_opts->as_header_desc.bLength =		sizeof(alt_opts->as_header_desc);
+	alt_opts->as_header_desc.bDescriptorType =	USB_DT_CS_INTERFACE;
+	alt_opts->as_header_desc.bDescriptorSubtype =	UAC_AS_GENERAL;
+	alt_opts->as_header_desc.bTerminalLink =	terminalId;
+	alt_opts->as_header_desc.bmControls =		0;
+	alt_opts->as_header_desc.bFormatType =		UAC_FORMAT_TYPE_I;
+	alt_opts->as_header_desc.bmFormats =		cpu_to_le32(UAC_FORMAT_TYPE_I_PCM);
+	alt_opts->as_header_desc.bNrChannels =		num_channels(alt_opts->chmask);
+	alt_opts->as_header_desc.bmChannelConfig =	cpu_to_le32(alt_opts->chmask);
+	alt_opts->as_header_desc.iChannelNames =	0;
+}
+
+/* Audio20 4.9.3 Class-Specific AS Format Type Descriptor */
+static void init_uac_format_type_i_discrete_desc(struct f_uac2_alt_opts *alt_opts)
+{
+	alt_opts->fmt_desc.bLength =		sizeof(alt_opts->fmt_desc);
+	alt_opts->fmt_desc.bDescriptorType =	USB_DT_CS_INTERFACE;
+	alt_opts->fmt_desc.bDescriptorSubtype =	UAC_FORMAT_TYPE;
+	alt_opts->fmt_desc.bFormatType =	UAC_FORMAT_TYPE_I;
+	alt_opts->fmt_desc.bSubslotSize =	alt_opts->ssize;
+	alt_opts->fmt_desc.bBitResolution =	alt_opts->ssize * 8;
+}
+
+static int init_isoc_ep_descriptor(struct device *dev, struct usb_endpoint_descriptor *ep_desc,
+				   struct f_uac2_alt_opts *alt_opts, int dir,
+				   enum usb_device_speed speed, u8 addr)
+{
+	ep_desc->bLength =		USB_DT_ENDPOINT_SIZE;
+	ep_desc->bDescriptorType =	USB_DT_ENDPOINT;
+	ep_desc->bEndpointAddress =	addr;
+	ep_desc->bmAttributes =		USB_ENDPOINT_XFER_ISOC |
+					(((dir == HOST_TO_DEVICE) && !EPOUT_FBACK_IN_EN(alt_opts))
+						? USB_ENDPOINT_SYNC_ADAPTIVE
+						: USB_ENDPOINT_SYNC_ASYNC);
+	ep_desc->bInterval =		1; /* For FS. For HS/SS, this is set later from hs_bint. */
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
+static int init_alt_descriptors(struct device *dev, struct f_uac2_alt_opts *alt_opts, int ifnum,
+				u8 epaddr, int endpoints, int terminalID, int dir,
+				struct usb_string *strings)
+{
+	int status = 0;
+
+	init_as_header_desc(alt_opts, terminalID);
+	init_as_interface_desc(&alt_opts->intf_desc, ifnum, alt_opts->c.alt_num,
+			       endpoints, alt_opts->name, strings);
+	init_uac_format_type_i_discrete_desc(alt_opts);
+
+	status = init_isoc_ep_descriptor(dev, &alt_opts->fs_iso_ep_desc, alt_opts,
+					 dir, USB_SPEED_FULL, epaddr);
+	if (!status)
+		status = init_isoc_ep_descriptor(dev, &alt_opts->hs_iso_ep_desc, alt_opts,
+						 dir, USB_SPEED_HIGH, epaddr);
+	if (!status)
+		status = init_isoc_ep_descriptor(dev, &alt_opts->ss_iso_ep_desc, alt_opts,
+						 dir, USB_SPEED_SUPER, epaddr);
+
+	init_isoc_ep_descriptor_comp(&alt_opts->ss_iso_ep_desc_comp, &alt_opts->ss_iso_ep_desc);
+
+	return status;
+}
+
+static struct f_uac2_path_descriptors *build_path_descriptors(struct path_params *params,
+							      struct f_uac2_alt_opts *alt_opts)
+{
+	struct f_uac2_path_descriptors *path_descs;
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
+		if (!path_descs->fu_desc) {
+			kfree(path_descs);
+			return NULL;
+		}
+		srcId = path_descs->fu_desc->bUnitID;
+	}
+
+	init_ot_desc(&path_descs->ot_desc, alt_opts, params, srcId);
+
+	return path_descs;
+}
+
+static void free_path_descriptors(struct f_uac2_path_descriptors *path_descs)
+{
+	kfree(path_descs->fu_desc);
+	kfree(path_descs);
+}
+
+static struct f_uac2_path_descriptors *find_path_descriptors(struct list_head *list,
+							   struct f_uac2_alt_opts *alt_opts,
+							   int dir)
+{
+	struct f_uac2_path_descriptors *path_descs;
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
+static int add_path_descriptors(struct list_head *list, struct path_params *params,
+				struct f_uac2_alt_opts *alt_opts)
+{
+	int len = 0;
+	struct f_uac2_path_descriptors *path_descs;
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
-#define USBDHDR(p) (struct usb_descriptor_header *)(p)
+#define USBDHDR(p) ((struct usb_descriptor_header *)(p))
 
-static void setup_headers(struct f_uac2_opts *opts,
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
+			       struct f_uac2_alt_opts *alt_opts, enum usb_device_speed speed)
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
+
+static int setup_headers(struct f_uac2_opts *opts,
+			 struct usb_descriptor_header **headers,
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
-		epout_desc = &fs_epout_desc;
-		epin_desc = &fs_epin_desc;
 		epin_fback_desc = &fs_epin_fback_desc;
 		ep_int_desc = &fs_ep_int_desc;
 		break;
 	case USB_SPEED_HIGH:
-		epout_desc = &hs_epout_desc;
-		epin_desc = &hs_epin_desc;
 		epin_fback_desc = &hs_epin_fback_desc;
 		ep_int_desc = &hs_ep_int_desc;
 		break;
 	default:
-		epout_desc = &ss_epout_desc;
-		epin_desc = &ss_epin_desc;
-		epout_desc_comp = &ss_epout_desc_comp;
-		epin_desc_comp = &ss_epin_desc_comp;
 		epin_fback_desc = &ss_epin_fback_desc;
 		epin_fback_desc_comp = &ss_epin_fback_desc_comp;
 		ep_int_desc = &ss_ep_int_desc;
 		ep_int_desc_comp = &ss_ep_int_desc_comp;
 	}
 
-	i = 0;
-	headers[i++] = USBDHDR(&iad_desc);
-	headers[i++] = USBDHDR(&std_ac_if_desc);
-	headers[i++] = USBDHDR(&ac_hdr_desc);
-	if (EPIN_EN(opts))
-		headers[i++] = USBDHDR(&in_clk_src_desc);
-	if (EPOUT_EN(opts)) {
-		headers[i++] = USBDHDR(&out_clk_src_desc);
-		headers[i++] = USBDHDR(&usb_out_it_desc);
-
-		if (FUOUT_EN(opts))
-			headers[i++] = USBDHDR(out_feature_unit_desc);
+	add_descriptor(i++, headers, USBDHDR(&iad_desc));
+	add_descriptor(i++, headers, USBDHDR(&std_ac_if_desc));
+	add_descriptor(i++, headers, USBDHDR(&ac_hdr_desc));
+	if (epin_en_any(opts))
+		add_descriptor(i++, headers, USBDHDR(&in_clk_src_desc));
+	if (epout_en_any(opts))
+		add_descriptor(i++, headers, USBDHDR(&out_clk_src_desc));
+
+	list_for_each(pos, path_descs) {
+		struct f_uac2_path_descriptors *path_desc =
+			container_of(pos, struct f_uac2_path_descriptors, list);
+		add_descriptor(i++, headers, USBDHDR(&path_desc->it_desc));
+		if (path_desc->fu_desc)
+			add_descriptor(i++, headers, USBDHDR(path_desc->fu_desc));
+		add_descriptor(i++, headers, USBDHDR(&path_desc->ot_desc));
 	}
 
-	if (EPIN_EN(opts)) {
-		headers[i++] = USBDHDR(&io_in_it_desc);
+	// If any FU exists, add the interrupt endpoint descriptor
+	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
+		add_descriptor(i++, headers, USBDHDR(ep_int_desc));
+		if (ep_int_desc_comp)
+			add_descriptor(i++, headers, USBDHDR(ep_int_desc_comp));
+	}
 
-		if (FUIN_EN(opts))
-			headers[i++] = USBDHDR(in_feature_unit_desc);
+	// If any capture interface is active
+	if (epout_en_any(opts)) {
+		struct f_uac2_alt_opts *alt_opts;
 
-		headers[i++] = USBDHDR(&usb_in_ot_desc);
-	}
+		add_descriptor(i++, headers, USBDHDR(&opts->c_alt_0_opts.intf_desc));
 
-	if (EPOUT_EN(opts))
-		headers[i++] = USBDHDR(&io_out_ot_desc);
+		if (EP_EN(&opts->c_alt_1_opts)) {
+			i = add_alt_descriptors(i, headers, &opts->c_alt_1_opts, speed);
 
-	if (FUOUT_EN(opts) || FUIN_EN(opts)) {
-		headers[i++] = USBDHDR(ep_int_desc);
-		if (ep_int_desc_comp)
-			headers[i++] = USBDHDR(ep_int_desc_comp);
-	}
+			add_descriptor(i++, headers, USBDHDR(&as_iso_out_desc));
+			if (EPOUT_FBACK_IN_EN(&opts->c_alt_1_opts)) {
+				add_descriptor(i++, headers, USBDHDR(epin_fback_desc));
+				if (epin_fback_desc_comp)
+					add_descriptor(i++, headers, USBDHDR(epin_fback_desc_comp));
+			}
+		}
 
-	if (EPOUT_EN(opts)) {
-		headers[i++] = USBDHDR(&std_as_out_if0_desc);
-		headers[i++] = USBDHDR(&std_as_out_if1_desc);
-		headers[i++] = USBDHDR(&as_out_hdr_desc);
-		headers[i++] = USBDHDR(&as_out_fmt1_desc);
-		headers[i++] = USBDHDR(epout_desc);
-		if (epout_desc_comp)
-			headers[i++] = USBDHDR(epout_desc_comp);
-
-		headers[i++] = USBDHDR(&as_iso_out_desc);
-
-		if (EPOUT_FBACK_IN_EN(opts)) {
-			headers[i++] = USBDHDR(epin_fback_desc);
-			if (epin_fback_desc_comp)
-				headers[i++] = USBDHDR(epin_fback_desc_comp);
+		list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+			if (EP_EN(alt_opts)) {
+				i = add_alt_descriptors(i, headers, alt_opts, speed);
+
+				add_descriptor(i++, headers, USBDHDR(&as_iso_out_desc));
+				if (EPOUT_FBACK_IN_EN(alt_opts)) {
+					add_descriptor(i++, headers, USBDHDR(epin_fback_desc));
+					if (epin_fback_desc_comp)
+						add_descriptor(i++, headers,
+							       USBDHDR(epin_fback_desc_comp));
+				}
+			}
 		}
 	}
 
-	if (EPIN_EN(opts)) {
-		headers[i++] = USBDHDR(&std_as_in_if0_desc);
-		headers[i++] = USBDHDR(&std_as_in_if1_desc);
-		headers[i++] = USBDHDR(&as_in_hdr_desc);
-		headers[i++] = USBDHDR(&as_in_fmt1_desc);
-		headers[i++] = USBDHDR(epin_desc);
-		if (epin_desc_comp)
-			headers[i++] = USBDHDR(epin_desc_comp);
+	// If any playback interface is active
+	if (epin_en_any(opts)) {
+		struct f_uac2_alt_opts *alt_opts;
+
+		add_descriptor(i++, headers, USBDHDR(&opts->p_alt_0_opts.intf_desc));
+
+		if (EP_EN(&opts->p_alt_1_opts)) {
+			i = add_alt_descriptors(i, headers, &opts->p_alt_1_opts, speed);
 
-		headers[i++] = USBDHDR(&as_iso_in_desc);
+			add_descriptor(i++, headers, USBDHDR(&as_iso_in_desc));
+		}
+
+		list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+			if (EP_EN(alt_opts)) {
+				i = add_alt_descriptors(i, headers, alt_opts, speed);
+
+				add_descriptor(i++, headers, USBDHDR(&as_iso_in_desc));
+			}
+		}
 	}
-	headers[i] = NULL;
+
+	add_descriptor(i++, headers, NULL);
+
+	return i;
 }
 
-static void setup_descriptor(struct f_uac2_opts *opts)
+static int setup_descriptor(struct device *dev, struct f_uac2 *uac2, struct f_uac2_opts *opts,
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
-	if (EPOUT_EN(opts))
-		out_clk_src_desc.bClockID = i++;
-	if (EPIN_EN(opts))
-		in_clk_src_desc.bClockID = i++;
-
-	usb_out_it_desc.bCSourceID = out_clk_src_desc.bClockID;
-
-	if (FUIN_EN(opts)) {
-		usb_in_ot_desc.bSourceID = in_feature_unit_desc->bUnitID;
-		in_feature_unit_desc->bSourceID = io_in_it_desc.bTerminalID;
-	} else {
-		usb_in_ot_desc.bSourceID = io_in_it_desc.bTerminalID;
-	}
+	int len;
+	struct list_head path_descs = LIST_HEAD_INIT(path_descs);
+	int fs_num, hs_num, ss_ssp_num;
+	struct f_uac2_alt_opts *alt_opts;
+	struct list_head *path_desc, *tmp;
+	struct path_params params;
 
-	usb_in_ot_desc.bCSourceID = in_clk_src_desc.bClockID;
-	io_in_it_desc.bCSourceID = in_clk_src_desc.bClockID;
-	io_out_ot_desc.bCSourceID = out_clk_src_desc.bClockID;
+	params.id = 1; /* ID's start with 1 */
+	params.opts = opts;
+	params.strings = strings;
 
-	if (FUOUT_EN(opts)) {
-		io_out_ot_desc.bSourceID = out_feature_unit_desc->bUnitID;
-		out_feature_unit_desc->bSourceID = usb_out_it_desc.bTerminalID;
-	} else {
-		io_out_ot_desc.bSourceID = usb_out_it_desc.bTerminalID;
-	}
+	len = sizeof(ac_hdr_desc);
 
-	as_out_hdr_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
-	as_in_hdr_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
+	if (uac2->g_audio.out_ep) {
+		params.dir = HOST_TO_DEVICE;
+		out_clk_src_desc.bClockID = params.id++;
+		len += sizeof(out_clk_src_desc);
 
-	iad_desc.bInterfaceCount = 1;
-	ac_hdr_desc.wTotalLength = cpu_to_le16(sizeof(ac_hdr_desc));
+		init_as_interface_desc(&opts->c_alt_0_opts.intf_desc, uac2->as_out_intf, 0, 0,
+				       opts->c_alt_0_opts.name, strings);
 
-	if (EPIN_EN(opts)) {
-		u16 len = le16_to_cpu(ac_hdr_desc.wTotalLength);
+		/* Audio path descriptors (input terminal -> <feature unit> -> output terminal) */
+		len += add_path_descriptors(&path_descs, &params, &opts->c_alt_1_opts);
 
+		status = init_alt_descriptors(dev, &opts->c_alt_1_opts, uac2->as_out_intf,
+					     uac2->g_audio.out_ep->address,
+					     EPOUT_FBACK_IN_EN(&opts->c_alt_1_opts) ? 2 : 1,
+					     opts->c_alt_1_opts.it_id, HOST_TO_DEVICE, strings);
+		if (status) {
+			dev_err(dev, "Failed to init alt descs for capture alt %d (%d)\n",
+				1, status);
+			goto cleanup;
+		}
+
+		list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+			len += add_path_descriptors(&path_descs, &params, alt_opts);
+
+			status = init_alt_descriptors(dev, alt_opts, uac2->as_out_intf,
+						      uac2->g_audio.out_ep->address,
+						      EPOUT_FBACK_IN_EN(alt_opts) ? 2 : 1,
+						      alt_opts->it_id, HOST_TO_DEVICE, strings);
+			if (status) {
+				dev_err(dev, "Failed to init alt descs for capture alt %d (%d)\n",
+					alt_opts->c.alt_num, status);
+				goto cleanup;
+			}
+		}
+	}
+
+	if (uac2->g_audio.in_ep) {
+		params.dir = DEVICE_TO_HOST;
+		in_clk_src_desc.bClockID = params.id++;
 		len += sizeof(in_clk_src_desc);
-		len += sizeof(usb_in_ot_desc);
 
-		if (FUIN_EN(opts))
-			len += in_feature_unit_desc->bLength;
+		init_as_interface_desc(&opts->p_alt_0_opts.intf_desc, uac2->as_in_intf, 0, 0,
+				       opts->p_alt_0_opts.name, strings);
 
-		len += sizeof(io_in_it_desc);
-		ac_hdr_desc.wTotalLength = cpu_to_le16(len);
-		iad_desc.bInterfaceCount++;
+		/* Audio path descriptors (input terminal -> <feature unit> -> output terminal) */
+		len += add_path_descriptors(&path_descs, &params, &opts->p_alt_1_opts);
+
+		status = init_alt_descriptors(dev, &opts->p_alt_1_opts, uac2->as_in_intf,
+					      uac2->g_audio.in_ep->address, 1,
+					      opts->p_alt_1_opts.ot_id, DEVICE_TO_HOST, strings);
+		if (status) {
+			dev_err(dev, "Failed to init alt descs for playback alt %d (%d)\n",
+				1, status);
+			goto cleanup;
+		}
+
+		list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+			len += add_path_descriptors(&path_descs, &params, alt_opts);
+
+			status = init_alt_descriptors(dev, alt_opts, uac2->as_in_intf,
+						      uac2->g_audio.in_ep->address, 1,
+						      alt_opts->ot_id, DEVICE_TO_HOST, strings);
+			if (status) {
+				dev_err(dev, "Failed to init alt descs for playback alt %d (%d)\n",
+					alt_opts->c.alt_num, status);
+				goto cleanup;
+			}
+		}
 	}
-	if (EPOUT_EN(opts)) {
-		u16 len = le16_to_cpu(ac_hdr_desc.wTotalLength);
 
-		len += sizeof(out_clk_src_desc);
-		len += sizeof(usb_out_it_desc);
+	ac_hdr_desc.wTotalLength = cpu_to_le16(len);
 
-		if (FUOUT_EN(opts))
-			len += out_feature_unit_desc->bLength;
+	/* Count how many descriptors we have and then allocate and populate */
+	fs_num = setup_headers(opts, NULL, &path_descs, USB_SPEED_FULL);
+	hs_num = setup_headers(opts, NULL, &path_descs, USB_SPEED_HIGH);
+	ss_ssp_num = setup_headers(opts, NULL, &path_descs, USB_SPEED_SUPER);
 
-		len += sizeof(io_out_ot_desc);
-		ac_hdr_desc.wTotalLength = cpu_to_le16(len);
-		iad_desc.bInterfaceCount++;
+	fs_desc_list = kzalloc((fs_num + hs_num + ss_ssp_num) * sizeof(*fs_desc_list), GFP_KERNEL);
+	if (!fs_desc_list) {
+		status = -ENOMEM;
+		goto cleanup;
 	}
+	hs_desc_list = fs_desc_list + fs_num;
+	ss_ssp_desc_list = hs_desc_list + hs_num;
+
+	(void) setup_headers(opts, fs_desc_list, &path_descs, USB_SPEED_FULL);
+	(void) setup_headers(opts, hs_desc_list, &path_descs, USB_SPEED_HIGH);
+	(void) setup_headers(opts, ss_ssp_desc_list, &path_descs, USB_SPEED_SUPER);
 
-	io_in_it_desc.wTerminalType = cpu_to_le16(opts->c_terminal_type);
-	io_out_ot_desc.wTerminalType = cpu_to_le16(opts->p_terminal_type);
+	/* copy descriptors, and track endpoint copies */
+	status = usb_assign_descriptors(&uac2->g_audio.func, fs_desc_list, hs_desc_list,
+					ss_ssp_desc_list, ss_ssp_desc_list);
 
-	setup_headers(opts, fs_audio_desc, USB_SPEED_FULL);
-	setup_headers(opts, hs_audio_desc, USB_SPEED_HIGH);
-	setup_headers(opts, ss_audio_desc, USB_SPEED_SUPER);
+	if (status)
+		dev_err(dev, "Failed to assign descriptors (%d)\n", status);
+
+	kfree(fs_desc_list);
+
+cleanup:
+	list_for_each_safe(path_desc, tmp, &path_descs) {
+		free_path_descriptors(
+			container_of(path_desc, struct f_uac2_path_descriptors, list));
+	}
+
+	return status;
 }
 
 static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 {
 	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	struct f_uac2_alt_opts *alt_opts;
 	const char *msg = NULL;
 
-	if (!opts->p_chmask && !opts->c_chmask)
+	if (!epin_en_any(opts) && !epout_en_any(opts))
 		msg = "no playback and capture channels";
-	else if (opts->p_chmask & ~UAC2_CHANNEL_MASK)
-		msg = "unsupported playback channels mask";
-	else if (opts->c_chmask & ~UAC2_CHANNEL_MASK)
-		msg = "unsupported capture channels mask";
-	else if ((opts->p_ssize < 1) || (opts->p_ssize > 4))
-		msg = "incorrect playback sample size";
-	else if ((opts->c_ssize < 1) || (opts->c_ssize > 4))
-		msg = "incorrect capture sample size";
-	else if (!opts->p_srates[0])
+
+	list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+		if (alt_opts->chmask & ~UAC2_CHANNEL_MASK)
+			msg = "unsupported playback channels mask";
+		else if ((alt_opts->ssize < 1) || (alt_opts->ssize > 4))
+			msg = "incorrect playback sample size";
+		else if ((alt_opts->hs_bint < 0) || (alt_opts->hs_bint > 4))
+			msg = "incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)";
+	}
+
+	list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+		if (alt_opts->chmask & ~UAC2_CHANNEL_MASK)
+			msg = "unsupported capture channels mask";
+		else if ((alt_opts->ssize < 1) || (alt_opts->ssize > 4))
+			msg = "incorrect capture sample size";
+		else if ((alt_opts->hs_bint < 0) || (alt_opts->hs_bint > 4))
+			msg = "incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)";
+	}
+
+	if (!opts->p_srates[0])
 		msg = "incorrect playback sampling rate";
 	else if (!opts->c_srates[0])
 		msg = "incorrect capture sampling rate";
@@ -962,11 +1004,6 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	else if ((opts->c_volume_max - opts->c_volume_min) % opts->c_volume_res)
 		msg = "incorrect capture volume resolution";
 
-	else if ((opts->p_hs_bint < 0) || (opts->p_hs_bint > 4))
-		msg = "incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)";
-	else if ((opts->c_hs_bint < 0) || (opts->c_hs_bint > 4))
-		msg = "incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)";
-
 	if (msg) {
 		dev_err(dev, "Error: %s\n", msg);
 		return -EINVAL;
@@ -1025,6 +1062,25 @@ static void init_alt_opts(struct f_uac2_alt_opts *alt_opts, struct f_uac2_opts *
 	alt_opts->terminal_type = (!playback) ? opts->p_terminal_type : opts->c_terminal_type;
 }
 
+static u16 get_max_packet_size(struct f_uac2_alt_opts *alt_opts, struct list_head *list)
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
 
 static int
 afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
@@ -1062,272 +1118,147 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	if (IS_ERR(us))
 		return PTR_ERR(us);
 
-	if (FUOUT_EN(uac2_opts)) {
-		out_feature_unit_desc = build_fu_desc(uac2_opts->c_chmask);
-		if (!out_feature_unit_desc)
-			return -ENOMEM;
-	}
-	if (FUIN_EN(uac2_opts)) {
-		in_feature_unit_desc = build_fu_desc(uac2_opts->p_chmask);
-		if (!in_feature_unit_desc) {
-			ret = -ENOMEM;
-			goto err_free_fu;
-		}
-	}
-
 	iad_desc.iFunction = add_string(us, uac2_opts->function_name);
 	std_ac_if_desc.iInterface = add_string(us, uac2_opts->if_ctrl_name);
 	in_clk_src_desc.iClockSource = add_string(us, uac2_opts->clksrc_in_name);
 	out_clk_src_desc.iClockSource = add_string(us, uac2_opts->clksrc_out_name);
-	usb_out_it_desc.iTerminal = add_string(us, uac2_opts->c_alt_1_opts.it_name);
-	usb_out_it_desc.iChannelNames = add_string(us, uac2_opts->c_alt_1_opts.it_ch_name);
-	io_in_it_desc.iTerminal = add_string(us, uac2_opts->p_alt_1_opts.it_name);
-	io_in_it_desc.iChannelNames = add_string(us, uac2_opts->p_alt_1_opts.it_ch_name);
-	usb_in_ot_desc.iTerminal = add_string(us, uac2_opts->p_alt_1_opts.ot_name);
-	io_out_ot_desc.iTerminal = add_string(us, uac2_opts->c_alt_1_opts.ot_name);
-	std_as_out_if0_desc.iInterface = add_string(us, uac2_opts->c_alt_0_opts.name);
-	std_as_out_if1_desc.iInterface = add_string(us, uac2_opts->c_alt_1_opts.name);
-	std_as_in_if0_desc.iInterface = add_string(us, uac2_opts->p_alt_0_opts.name);
-	std_as_in_if1_desc.iInterface = add_string(us, uac2_opts->p_alt_0_opts.name);
-
-	if (FUOUT_EN(uac2_opts)) {
-		u8 *i_feature = (u8 *)out_feature_unit_desc +
-				out_feature_unit_desc->bLength - 1;
-		*i_feature = add_string(us, uac2_opts->c_alt_1_opts.fu_vol_name);
-	}
-	if (FUIN_EN(uac2_opts)) {
-		u8 *i_feature = (u8 *)in_feature_unit_desc +
-				in_feature_unit_desc->bLength - 1;
-		*i_feature = add_string(us, uac2_opts->p_alt_1_opts.fu_vol_name);
-	}
-
-
-	/* Initialize the configurable parameters */
-	usb_out_it_desc.bNrChannels = num_channels(uac2_opts->c_chmask);
-	usb_out_it_desc.bmChannelConfig = cpu_to_le32(uac2_opts->c_chmask);
-	io_in_it_desc.bNrChannels = num_channels(uac2_opts->p_chmask);
-	io_in_it_desc.bmChannelConfig = cpu_to_le32(uac2_opts->p_chmask);
-	as_out_hdr_desc.bNrChannels = num_channels(uac2_opts->c_chmask);
-	as_out_hdr_desc.bmChannelConfig = cpu_to_le32(uac2_opts->c_chmask);
-	as_in_hdr_desc.bNrChannels = num_channels(uac2_opts->p_chmask);
-	as_in_hdr_desc.bmChannelConfig = cpu_to_le32(uac2_opts->p_chmask);
-	as_out_fmt1_desc.bSubslotSize = uac2_opts->c_ssize;
-	as_out_fmt1_desc.bBitResolution = uac2_opts->c_ssize * 8;
-	as_in_fmt1_desc.bSubslotSize = uac2_opts->p_ssize;
-	as_in_fmt1_desc.bBitResolution = uac2_opts->p_ssize * 8;
-	if (FUOUT_EN(uac2_opts)) {
-		__le32 *bma = (__le32 *)&out_feature_unit_desc->bmaControls[0];
-		u32 control = 0;
-
-		if (uac2_opts->c_mute_present)
-			control |= CONTROL_RDWR << FU_MUTE_CTRL;
-		if (uac2_opts->c_volume_present)
-			control |= CONTROL_RDWR << FU_VOL_CTRL;
-		*bma = cpu_to_le32(control);
-	}
-	if (FUIN_EN(uac2_opts)) {
-		__le32 *bma = (__le32 *)&in_feature_unit_desc->bmaControls[0];
-		u32 control = 0;
-
-		if (uac2_opts->p_mute_present)
-			control |= CONTROL_RDWR << FU_MUTE_CTRL;
-		if (uac2_opts->p_volume_present)
-			control |= CONTROL_RDWR << FU_VOL_CTRL;
-		*bma = cpu_to_le32(control);
-	}
 
+	/* allocate instance-specific interface IDs */
 	ret = usb_interface_id(cfg, fn);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		goto err_free_fu;
+		goto fail;
 	}
 	iad_desc.bFirstInterface = ret;
+	iad_desc.bInterfaceCount = 1;
 
 	std_ac_if_desc.bInterfaceNumber = ret;
 	uac2->ac_intf = ret;
 	uac2->ac_alt = 0;
 
-	if (EPOUT_EN(uac2_opts)) {
+	if (epout_en_any(uac2_opts)) {
 		ret = usb_interface_id(cfg, fn);
 		if (ret < 0) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			goto err_free_fu;
+			goto fail;
 		}
-		std_as_out_if0_desc.bInterfaceNumber = ret;
-		std_as_out_if1_desc.bInterfaceNumber = ret;
-		std_as_out_if1_desc.bNumEndpoints = 1;
+
+		iad_desc.bInterfaceCount++;
+
 		uac2->as_out_intf = ret;
 		uac2->as_out_alt = 0;
-
-		if (EPOUT_FBACK_IN_EN(uac2_opts)) {
-			fs_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			hs_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			ss_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
-			std_as_out_if1_desc.bNumEndpoints++;
-		} else {
-			fs_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-			hs_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-			ss_epout_desc.bmAttributes =
-			  USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ADAPTIVE;
-		}
 	}
 
-	if (EPIN_EN(uac2_opts)) {
+	if (epin_en_any(uac2_opts)) {
 		ret = usb_interface_id(cfg, fn);
 		if (ret < 0) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-			goto err_free_fu;
+			goto fail;
 		}
-		std_as_in_if0_desc.bInterfaceNumber = ret;
-		std_as_in_if1_desc.bInterfaceNumber = ret;
+
+		iad_desc.bInterfaceCount++;
+
 		uac2->as_in_intf = ret;
 		uac2->as_in_alt = 0;
 	}
 
+	/* allocate AC interrupt endpoint */
 	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts)) {
 		uac2->int_ep = usb_ep_autoconfig(gadget, &fs_ep_int_desc);
 		if (!uac2->int_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			ret = -ENODEV;
-			goto err_free_fu;
+			goto fail;
 		}
+		hs_ep_int_desc.bEndpointAddress = fs_ep_int_desc.bEndpointAddress;
+		ss_ep_int_desc.bEndpointAddress = fs_ep_int_desc.bEndpointAddress;
 
 		std_ac_if_desc.bNumEndpoints = 1;
 	}
 
-	hs_epin_desc.bInterval = uac2_opts->p_hs_bint;
-	ss_epin_desc.bInterval = uac2_opts->p_hs_bint;
-	hs_epout_desc.bInterval = uac2_opts->c_hs_bint;
-	ss_epout_desc.bInterval = uac2_opts->c_hs_bint;
-
-	/* Calculate wMaxPacketSize according to audio bandwidth */
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &fs_epin_desc,
-					USB_SPEED_FULL, true);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
-
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &fs_epout_desc,
-					USB_SPEED_FULL, false);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
-
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &hs_epin_desc,
-					USB_SPEED_HIGH, true);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
-
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &hs_epout_desc,
-					USB_SPEED_HIGH, false);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
-
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &ss_epin_desc,
-					USB_SPEED_SUPER, true);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
-
-	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &ss_epout_desc,
-					USB_SPEED_SUPER, false);
-	if (ret < 0) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return ret;
-	}
+	/* Allocate instance-specific endpoints. These use the FS version for alt mode 1.
+	 * All other alt modes and speeds will be initialized to the same endpoint address
+	 * during the setup_descriptor() call. The u_audio code will update the currently
+	 * selected endpoint descriptor when the alt mode changes.
+	 */
+	if (epout_en_any(uac2_opts)) {
+		ret = init_isoc_ep_descriptor(dev, &uac2_opts->c_alt_1_opts.fs_iso_ep_desc,
+					      &uac2_opts->c_alt_1_opts, HOST_TO_DEVICE,
+					      USB_SPEED_FULL, USB_DIR_OUT);
+		if (ret) {
+			dev_err(dev, "Failed to init FS isoc ep desc for capture (%d)\n", ret);
+			goto fail;
+		}
 
-	if (EPOUT_EN(uac2_opts)) {
-		agdev->out_ep = usb_ep_autoconfig(gadget, &fs_epout_desc);
+		agdev->out_ep = usb_ep_autoconfig(gadget, &uac2_opts->c_alt_1_opts.fs_iso_ep_desc);
 		if (!agdev->out_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			ret = -ENODEV;
-			goto err_free_fu;
+			goto fail;
 		}
-		if (EPOUT_FBACK_IN_EN(uac2_opts)) {
+		if (epout_fback_in_en_any(uac2_opts)) {
 			agdev->in_ep_fback = usb_ep_autoconfig(gadget,
 						       &fs_epin_fback_desc);
 			if (!agdev->in_ep_fback) {
 				dev_err(dev, "%s:%d Error!\n",
 					__func__, __LINE__);
 				ret = -ENODEV;
-				goto err_free_fu;
+				goto fail;
 			}
+			hs_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
+			ss_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
 		}
 	}
 
-	if (EPIN_EN(uac2_opts)) {
-		agdev->in_ep = usb_ep_autoconfig(gadget, &fs_epin_desc);
+	if (epin_en_any(uac2_opts)) {
+		ret = init_isoc_ep_descriptor(dev, &uac2_opts->p_alt_1_opts.fs_iso_ep_desc,
+					      &uac2_opts->p_alt_1_opts, HOST_TO_DEVICE,
+					      USB_SPEED_FULL, USB_DIR_IN);
+		if (ret) {
+			dev_err(dev, "Failed to init FS isoc ep desc for playback (%d)\n", ret);
+			goto fail;
+		}
+
+		agdev->in_ep = usb_ep_autoconfig(gadget, &uac2_opts->p_alt_1_opts.fs_iso_ep_desc);
 		if (!agdev->in_ep) {
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 			ret = -ENODEV;
-			goto err_free_fu;
+			goto fail;
 		}
 	}
 
-	agdev->in_ep_maxpsize = max_t(u16,
-				le16_to_cpu(fs_epin_desc.wMaxPacketSize),
-				le16_to_cpu(hs_epin_desc.wMaxPacketSize));
-	agdev->out_ep_maxpsize = max_t(u16,
-				le16_to_cpu(fs_epout_desc.wMaxPacketSize),
-				le16_to_cpu(hs_epout_desc.wMaxPacketSize));
-
-	agdev->in_ep_maxpsize = max_t(u16, agdev->in_ep_maxpsize,
-				le16_to_cpu(ss_epin_desc.wMaxPacketSize));
-	agdev->out_ep_maxpsize = max_t(u16, agdev->out_ep_maxpsize,
-				le16_to_cpu(ss_epout_desc.wMaxPacketSize));
-
-	ss_epin_desc_comp.wBytesPerInterval = ss_epin_desc.wMaxPacketSize;
-	ss_epout_desc_comp.wBytesPerInterval = ss_epout_desc.wMaxPacketSize;
-
-	// HS and SS endpoint addresses are copied from autoconfigured FS descriptors
-	hs_ep_int_desc.bEndpointAddress = fs_ep_int_desc.bEndpointAddress;
-	hs_epout_desc.bEndpointAddress = fs_epout_desc.bEndpointAddress;
-	hs_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
-	hs_epin_desc.bEndpointAddress = fs_epin_desc.bEndpointAddress;
-	ss_epout_desc.bEndpointAddress = fs_epout_desc.bEndpointAddress;
-	ss_epin_fback_desc.bEndpointAddress = fs_epin_fback_desc.bEndpointAddress;
-	ss_epin_desc.bEndpointAddress = fs_epin_desc.bEndpointAddress;
-	ss_ep_int_desc.bEndpointAddress = fs_ep_int_desc.bEndpointAddress;
-
-	setup_descriptor(uac2_opts);
-
-	ret = usb_assign_descriptors(fn, fs_audio_desc, hs_audio_desc, ss_audio_desc,
-				     ss_audio_desc);
-	if (ret)
-		goto err_free_fu;
+	agdev->out_ep_maxpsize = get_max_packet_size(&uac2_opts->c_alt_1_opts,
+						     &uac2_opts->c_alt_opts);
+	agdev->in_ep_maxpsize = get_max_packet_size(&uac2_opts->p_alt_1_opts,
+						    &uac2_opts->p_alt_opts);
+
+	setup_descriptor(dev, uac2, uac2_opts, us);
 
 	agdev->gadget = gadget;
 
+	// TODO: This may need some change with the audio params for the current alt mode
 	agdev->params.p_chmask = uac2_opts->p_chmask;
 	memcpy(agdev->params.p_srates, uac2_opts->p_srates,
 			sizeof(agdev->params.p_srates));
 	agdev->params.p_ssize = uac2_opts->p_ssize;
+
 	if (FUIN_EN(uac2_opts)) {
-		agdev->params.p_fu.id = USB_IN_FU_ID;
+		agdev->params.p_fu.id = USB_IN_FU_ID(uac2_opts);
 		agdev->params.p_fu.mute_present = uac2_opts->p_mute_present;
 		agdev->params.p_fu.volume_present = uac2_opts->p_volume_present;
 		agdev->params.p_fu.volume_min = uac2_opts->p_volume_min;
 		agdev->params.p_fu.volume_max = uac2_opts->p_volume_max;
 		agdev->params.p_fu.volume_res = uac2_opts->p_volume_res;
 	}
+
+	// TODO: This may need some change with the audio params for the current alt mode
 	agdev->params.c_chmask = uac2_opts->c_chmask;
 	memcpy(agdev->params.c_srates, uac2_opts->c_srates,
 			sizeof(agdev->params.c_srates));
 	agdev->params.c_ssize = uac2_opts->c_ssize;
+
 	if (FUOUT_EN(uac2_opts)) {
-		agdev->params.c_fu.id = USB_OUT_FU_ID;
+		agdev->params.c_fu.id = USB_OUT_FU_ID(uac2_opts);
 		agdev->params.c_fu.mute_present = uac2_opts->c_mute_present;
 		agdev->params.c_fu.volume_present = uac2_opts->c_volume_present;
 		agdev->params.c_fu.volume_min = uac2_opts->c_volume_min;
@@ -1338,7 +1269,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	agdev->params.fb_max = uac2_opts->fb_max;
 
 	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts))
-    agdev->notify = afunc_notify;
+		agdev->notify = afunc_notify;
 
 	ret = g_audio_setup(agdev, "UAC2 PCM", "UAC2_Gadget");
 	if (ret)
@@ -1349,11 +1280,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 err_free_descs:
 	usb_free_all_descriptors(fn);
 	agdev->gadget = NULL;
-err_free_fu:
-	kfree(out_feature_unit_desc);
-	out_feature_unit_desc = NULL;
-	kfree(in_feature_unit_desc);
-	in_feature_unit_desc = NULL;
+fail:
 	return ret;
 }
 
@@ -1428,7 +1355,7 @@ afunc_notify(struct g_audio *agdev, int unit_id, int cs)
 }
 
 static int
-afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
+afunc_set_alt(struct usb_function *fn, unsigned int intf, unsigned int alt)
 {
 	struct usb_composite_dev *cdev = fn->config->cdev;
 	struct f_uac2 *uac2 = func_to_uac2(fn);
@@ -1483,7 +1410,7 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 }
 
 static int
-afunc_get_alt(struct usb_function *fn, unsigned intf)
+afunc_get_alt(struct usb_function *fn, unsigned int intf)
 {
 	struct f_uac2 *uac2 = func_to_uac2(fn);
 	struct g_audio *agdev = func_to_g_audio(fn);
@@ -1561,11 +1488,11 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 				"%s:%d control_selector=%d TODO!\n",
 				__func__, __LINE__, control_selector);
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_MUTE) {
@@ -1650,11 +1577,11 @@ in_rq_range(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 				"%s:%d control_selector=%d TODO!\n",
 				__func__, __LINE__, control_selector);
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_VOLUME) {
@@ -1740,11 +1667,11 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-		(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+		(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		unsigned int is_playback = 0;
 
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID))
+		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
 			is_playback = 1;
 
 		if (control_selector == UAC_FU_MUTE) {
@@ -1794,8 +1721,8 @@ out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 			req->complete = uac2_cs_control_sam_freq;
 			return w_length;
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID)) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID))) {
+	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
+			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
 		memcpy(&uac2->setup_cr, cr, sizeof(*cr));
 		req->context = agdev;
 		req->complete = out_rq_cur_complete;
@@ -2292,11 +2219,6 @@ static void afunc_unbind(struct usb_configuration *c, struct usb_function *f)
 	usb_free_all_descriptors(f);
 
 	agdev->gadget = NULL;
-
-	kfree(out_feature_unit_desc);
-	out_feature_unit_desc = NULL;
-	kfree(in_feature_unit_desc);
-	in_feature_unit_desc = NULL;
 }
 
 static struct usb_function *afunc_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 8c061e588324..91171c6e493a 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -53,6 +53,9 @@ struct f_uac2_alt_0_opts {
 	struct f_uac2_alt_opts_common c;
 
 	char			name[USB_MAX_STRING_LEN];
+
+	/* Descriptors */
+	struct usb_interface_descriptor	intf_desc;
 };
 
 /* Alt modes 1+ */
@@ -75,6 +78,35 @@ struct f_uac2_alt_opts {
 	u8			hs_bint;
 	s16			terminal_type;
 
+	/* Descriptors */
+	struct usb_interface_descriptor		intf_desc;
+	struct uac2_as_header_descriptor	as_header_desc;
+	struct uac2_format_type_i_descriptor	fmt_desc;
+
+	struct usb_endpoint_descriptor		fs_iso_ep_desc;
+	struct usb_endpoint_descriptor		hs_iso_ep_desc;
+	struct usb_endpoint_descriptor		ss_iso_ep_desc;
+	struct usb_ss_ep_comp_descriptor	ss_iso_ep_desc_comp;
+
+	u8 clk_id; /* Clock Source Descriptor bClockID */
+	u8 it_id;  /* Input Terminal Descriptor bTerminalID */
+	u8 fu_id;  /* Feature Unit Descriptor bUnitID */
+	u8 ot_id;  /* Output Terminal Descriptor bTerminalID */
+};
+
+struct f_uac2_path_descriptors {
+	struct list_head list;
+
+	int dir; /* HOST_TO_DEVICE or DEVICE_TO_HOST */
+
+	/* Alt mode opts this path descriptor is from */
+	struct f_uac2_alt_opts *alt_opts;
+
+	struct uac2_input_terminal_descriptor it_desc;
+	struct uac2_output_terminal_descriptor ot_desc;
+
+	/* Feature unit is optional */
+	struct uac2_feature_unit_descriptor *fu_desc;
 };
 
 struct f_uac2_opts {
-- 
2.43.0


