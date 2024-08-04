Return-Path: <linux-kernel+bounces-273617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BAE946B8B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6711C21413
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CB1C20;
	Sun,  4 Aug 2024 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuvDCmDb"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A3A34;
	Sun,  4 Aug 2024 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722730795; cv=none; b=juXH8PJyoIpFnos7xT3FH+4YXy5LSXacq/TYrOCh7L6Mgec8C0eHwWBD1LnxhNDxr+faq0moZY2W5OJ4wMFzvdC5BrB5tC3z0On1WREevgccGHliXeDrtBFKE3JVdORIe/u+yPiBhgAhHY9KbncHEragk6+M+7MRdK0VYr6Rq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722730795; c=relaxed/simple;
	bh=BGHDPKrql5LN4piFT5ulVEGXGzD3DCzy1SMudGPYTCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVn8fQ1mYLmSv6MyovIoa/U5jLqPKW9Lkj8jIxyVodAalKXbLPW5f0axklJskcyo/5JoJAnc3UJIOsf2NFE3FYc4HK5oaH0xbNakRuST0AZe2jvx7zyh7WKY3RvYFRrRrEtVIsr6CEStAb+/5GKJzREt1Xq37MydUSY4HBbMr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuvDCmDb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1e31bc1efso569727385a.3;
        Sat, 03 Aug 2024 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722730792; x=1723335592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFoxCtLYXTtbb3nGl+PK9aCZ8V0tm8K09Eg3TaXXej0=;
        b=DuvDCmDbOywJpTZ2cyKtR3tWJZl6e4OaFyJLChT+pP+rdCQZ5yBGLG+a32hfOBO70a
         muugz+jxvTxvbx7q8YxpXKlNMOHMk9egFP/fmX/WUowP2UNsqFszyvNUYwIE+VRu7LqM
         1xRgfyPPNbUI/R65s4Ki5gAjm8xgFkhtQFblB62v3onNezQRQACGmJTXOPPPQ7ONFWW4
         SnVkL6wpyxF+GuXd97keM1wcUqVOQkRa9cmDwnt+uSfaN45GKsDlDTOh3uXlEKuKaoMf
         dIvjOX64OcTfwyqrsZSsrvpN0aER3dR6dueETDQN+uATHLeqmxgfbtW7WlY6Oj9F3aZ8
         UmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722730792; x=1723335592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFoxCtLYXTtbb3nGl+PK9aCZ8V0tm8K09Eg3TaXXej0=;
        b=ddrXdBK4zae0hwn4csojXvQXTawBekTeMOXHNVqcnMwd+CnpqMrUsYTmYKrpgjC8+K
         uK/wrIzN4mAnO1o1LA5KioeNVowAnIPN2aYbPf2o64zAT6STzaGvsu7yQ5JHntAPzYtj
         m0p1u4LBSfmfLyh0ErvezdGG0I43jaF/IeIAWsPrH/G82hOx6YKYeJGszVoUiKGR9e3K
         pCdRRLL6GGEMUXxKhYByQIMqXQycoyZB4HCvvF3tkQLJqHKXSBHWkCs0GDrSxG5ilwb7
         Dq6WcvmV+HufDewUMi4dsPKhPm+N6aFHniF9YO7/Dl7nNGU80sZVoi/2PC6NOZjb0QlR
         vD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVT1n9Tuzeo4qHLRIRgOUDebnf1LfJCpa6Xig3gBArbPs5/IrHE21d/fCkMirIbyX6DGOlAYDGbPyIuPvYO1aF79xHJdtjj8F16xHq
X-Gm-Message-State: AOJu0YzZJs2zvfUFb+RE+HUHiOcx4HwRboMG63lV3KSuEVhS1xV4sSIc
	MWIhIS7JD8iPTQCCmkCdzDRaXaxO4ZTDrSKeUVP3Q1+x1oEV7w1FKGI0Wv3g
X-Google-Smtp-Source: AGHT+IF9fGE8lWH9Aclp7zYidSuxON1rFBJ3WGX6nLYnn1/X/h5PmYv2J1tTMn1AvnRYvG9ysV6FSA==
X-Received: by 2002:a05:620a:25d0:b0:79f:14ef:40cf with SMTP id af79cd13be357-7a34efe307emr744319785a.56.1722730792237;
        Sat, 03 Aug 2024 17:19:52 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6e5c40sm18166691cf.45.2024.08.03.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 17:19:51 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	James Gruber <jimmyjgruber@gmail.com>,
	John Keeping <jkeeping@inmusicbrands.com>,
	Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <Chris.Wulff@biamp.com>,
	Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH v3] usb: gadget: f_uac2: Expose all string descriptors through configfs.
Date: Sat,  3 Aug 2024 20:19:24 -0400
Message-ID: <20240804001923.3279431-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <Chris.Wulff@biamp.com>

This makes all string descriptors configurable for the UAC2 gadget
so the user can configure names of terminals and controls. Alt mode
names are not included for now and will be in future work related
to adding alternate settings.

discussion thread for api changes for alt mode settings:
https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/

Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
---
v3:
Removed alt mode names (will be added in alt mode subdirectories later)
Fixed up feature unit names to match alt settings discussion
Fixed direction of the names to match the c_/p_ semantics being device centric.

v2: Improved naming of parameters to be mode user friendly. Added documentation.
https://lore.kernel.org/all/CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com/

v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419B50F94A0014647542931E10D2@CO1PR17MB5419.namprd17.prod.outlook.com/
---
 .../ABI/testing/configfs-usb-gadget-uac2      | 11 +++
 Documentation/usb/gadget-testing.rst          | 11 +++
 drivers/usb/gadget/function/f_uac2.c          | 80 +++++++++++++++----
 drivers/usb/gadget/function/u_uac2.h          | 15 +++-
 4 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index a2bf4fd82a5b..133e995c3e92 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -35,6 +35,17 @@ Description:
 		req_number		the number of pre-allocated requests
 					for both capture and playback
 		function_name		name of the interface
+		if_ctrl_name		topology control name
+		clksrc_in_name		input clock name
+		clksrc_out_name		output clock name
+		p_it_name		playback input terminal name
+		p_it_ch_name		playback input first channel name
+		p_ot_name		playback output terminal name
+		p_fu_vol_name		playback mute/volume function unit name
+		c_it_name		capture input terminal name
+		c_it_ch_name		capture input first channel name
+		c_ot_name		capture output terminal name
+		c_fu_vol_name		capture mute/volume functional unit name
 		c_terminal_type		code of the capture terminal type
 		p_terminal_type		code of the playback terminal type
 		=====================	=======================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index a89b49e639c3..8092e250ec27 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -765,6 +765,17 @@ The uac2 function provides these attributes in its function directory:
 	req_number       the number of pre-allocated request for both capture
 	                 and playback
 	function_name    name of the interface
+	if_ctrl_name     topology control name
+	clksrc_in_name   input clock name
+	clksrc_out_name  output clock name
+	p_it_name        playback input terminal name
+	p_it_ch_name     playback input first channel name
+	p_ot_name        playback output terminal name
+	p_fu_vol_name    playback function unit name
+	c_it_name        capture input terminal name
+	c_it_ch_name     capture input first channel name
+	c_ot_name        capture output terminal name
+	c_fu_vol_name    capture functional unit name
 	c_terminal_type  code of the capture terminal type
 	p_terminal_type  code of the playback terminal type
 	================ ====================================================
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 2d6d3286ffde..1cdda44455b3 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -95,7 +95,9 @@ enum {
 	STR_CLKSRC_IN,
 	STR_CLKSRC_OUT,
 	STR_USB_IT,
+	STR_USB_IT_CH,
 	STR_IO_IT,
+	STR_IO_IT_CH,
 	STR_USB_OT,
 	STR_IO_OT,
 	STR_FU_IN,
@@ -104,25 +106,10 @@ enum {
 	STR_AS_OUT_ALT1,
 	STR_AS_IN_ALT0,
 	STR_AS_IN_ALT1,
+	NUM_STR_DESCRIPTORS,
 };
 
-static struct usb_string strings_fn[] = {
-	/* [STR_ASSOC].s = DYNAMIC, */
-	[STR_IF_CTRL].s = "Topology Control",
-	[STR_CLKSRC_IN].s = "Input Clock",
-	[STR_CLKSRC_OUT].s = "Output Clock",
-	[STR_USB_IT].s = "USBH Out",
-	[STR_IO_IT].s = "USBD Out",
-	[STR_USB_OT].s = "USBH In",
-	[STR_IO_OT].s = "USBD In",
-	[STR_FU_IN].s = "Capture Volume",
-	[STR_FU_OUT].s = "Playback Volume",
-	[STR_AS_OUT_ALT0].s = "Playback Inactive",
-	[STR_AS_OUT_ALT1].s = "Playback Active",
-	[STR_AS_IN_ALT0].s = "Capture Inactive",
-	[STR_AS_IN_ALT1].s = "Capture Active",
-	{ },
-};
+static struct usb_string strings_fn[NUM_STR_DESCRIPTORS + 1] = {};
 
 static const char *const speed_names[] = {
 	[USB_SPEED_UNKNOWN] = "UNKNOWN",
@@ -1049,6 +1036,23 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		return ret;
 
 	strings_fn[STR_ASSOC].s = uac2_opts->function_name;
+	strings_fn[STR_IF_CTRL].s = uac2_opts->if_ctrl_name;
+	strings_fn[STR_CLKSRC_IN].s = uac2_opts->clksrc_in_name;
+	strings_fn[STR_CLKSRC_OUT].s = uac2_opts->clksrc_out_name;
+
+	strings_fn[STR_USB_IT].s = uac2_opts->c_it_name;
+	strings_fn[STR_USB_IT_CH].s = uac2_opts->c_it_ch_name;
+	strings_fn[STR_IO_OT].s = uac2_opts->c_ot_name;
+	strings_fn[STR_FU_OUT].s = uac2_opts->c_fu_vol_name;
+	strings_fn[STR_AS_OUT_ALT0].s = "Playback Inactive";
+	strings_fn[STR_AS_OUT_ALT1].s = "Playback Active";
+
+	strings_fn[STR_IO_IT].s = uac2_opts->p_it_name;
+	strings_fn[STR_IO_IT_CH].s = uac2_opts->p_it_ch_name;
+	strings_fn[STR_USB_OT].s = uac2_opts->p_ot_name;
+	strings_fn[STR_FU_IN].s = uac2_opts->p_fu_vol_name;
+	strings_fn[STR_AS_IN_ALT0].s = "Capture Inactive";
+	strings_fn[STR_AS_IN_ALT1].s = "Capture Active";
 
 	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
 	if (IS_ERR(us))
@@ -1072,7 +1076,9 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	in_clk_src_desc.iClockSource = us[STR_CLKSRC_IN].id;
 	out_clk_src_desc.iClockSource = us[STR_CLKSRC_OUT].id;
 	usb_out_it_desc.iTerminal = us[STR_USB_IT].id;
+	usb_out_it_desc.iChannelNames = us[STR_USB_IT_CH].id;
 	io_in_it_desc.iTerminal = us[STR_IO_IT].id;
+	io_in_it_desc.iChannelNames = us[STR_IO_IT_CH].id;
 	usb_in_ot_desc.iTerminal = us[STR_USB_OT].id;
 	io_out_ot_desc.iTerminal = us[STR_IO_OT].id;
 	std_as_out_if0_desc.iInterface = us[STR_AS_OUT_ALT0].id;
@@ -2100,10 +2106,24 @@ UAC2_ATTRIBUTE(s16, c_volume_max);
 UAC2_ATTRIBUTE(s16, c_volume_res);
 UAC2_ATTRIBUTE(u32, fb_max);
 UAC2_ATTRIBUTE_STRING(function_name);
+UAC2_ATTRIBUTE_STRING(if_ctrl_name);
+UAC2_ATTRIBUTE_STRING(clksrc_in_name);
+UAC2_ATTRIBUTE_STRING(clksrc_out_name);
+
+UAC2_ATTRIBUTE_STRING(p_it_name);
+UAC2_ATTRIBUTE_STRING(p_it_ch_name);
+UAC2_ATTRIBUTE_STRING(p_ot_name);
+UAC2_ATTRIBUTE_STRING(p_fu_vol_name);
+
+UAC2_ATTRIBUTE_STRING(c_it_name);
+UAC2_ATTRIBUTE_STRING(c_it_ch_name);
+UAC2_ATTRIBUTE_STRING(c_ot_name);
+UAC2_ATTRIBUTE_STRING(c_fu_vol_name);
 
 UAC2_ATTRIBUTE(s16, p_terminal_type);
 UAC2_ATTRIBUTE(s16, c_terminal_type);
 
+
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
 	&f_uac2_opts_attr_p_srate,
@@ -2130,6 +2150,19 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_c_volume_res,
 
 	&f_uac2_opts_attr_function_name,
+	&f_uac2_opts_attr_if_ctrl_name,
+	&f_uac2_opts_attr_clksrc_in_name,
+	&f_uac2_opts_attr_clksrc_out_name,
+
+	&f_uac2_opts_attr_p_it_name,
+	&f_uac2_opts_attr_p_it_ch_name,
+	&f_uac2_opts_attr_p_ot_name,
+	&f_uac2_opts_attr_p_fu_vol_name,
+
+	&f_uac2_opts_attr_c_it_name,
+	&f_uac2_opts_attr_c_it_ch_name,
+	&f_uac2_opts_attr_c_ot_name,
+	&f_uac2_opts_attr_c_fu_vol_name,
 
 	&f_uac2_opts_attr_p_terminal_type,
 	&f_uac2_opts_attr_c_terminal_type,
@@ -2191,6 +2224,19 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->fb_max = FBACK_FAST_MAX;
 
 	scnprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
+	scnprintf(opts->if_ctrl_name, sizeof(opts->if_ctrl_name), "Topology Control");
+	scnprintf(opts->clksrc_in_name, sizeof(opts->clksrc_in_name), "Input Clock");
+	scnprintf(opts->clksrc_out_name, sizeof(opts->clksrc_out_name), "Output Clock");
+
+	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "USBD Out");
+	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Capture Channels");
+	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "USBH In");
+	scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Capture Volume");
+
+	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "USBH Out");
+	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Playback Channels");
+	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "USBD In");
+	scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Playback Volume");
 
 	opts->p_terminal_type = UAC2_DEF_P_TERM_TYPE;
 	opts->c_terminal_type = UAC2_DEF_C_TERM_TYPE;
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 5e81bdd6c5fb..0df808289ded 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -68,7 +68,20 @@ struct f_uac2_opts {
 	int				fb_max;
 	bool			bound;
 
-	char			function_name[32];
+	char			function_name[USB_MAX_STRING_LEN];
+	char			if_ctrl_name[USB_MAX_STRING_LEN];
+	char			clksrc_in_name[USB_MAX_STRING_LEN];
+	char			clksrc_out_name[USB_MAX_STRING_LEN];
+
+	char			p_it_name[USB_MAX_STRING_LEN];
+	char			p_it_ch_name[USB_MAX_STRING_LEN];
+	char			p_ot_name[USB_MAX_STRING_LEN];
+	char			p_fu_vol_name[USB_MAX_STRING_LEN];
+
+	char			c_it_name[USB_MAX_STRING_LEN];
+	char			c_it_ch_name[USB_MAX_STRING_LEN];
+	char			c_ot_name[USB_MAX_STRING_LEN];
+	char			c_fu_vol_name[USB_MAX_STRING_LEN];
 
 	s16				p_terminal_type;
 	s16				c_terminal_type;
-- 
2.43.0


