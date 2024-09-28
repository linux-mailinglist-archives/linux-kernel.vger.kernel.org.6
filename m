Return-Path: <linux-kernel+bounces-342525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D4988FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EC5B224B6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AE189F58;
	Sat, 28 Sep 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN4h8o89"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A303188CD8;
	Sat, 28 Sep 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536183; cv=none; b=mHv04QgwACHw+WnLdI/54f2GbRSUy0wI45HxVEFT1yOnvCMtSJQQHWtkhTA+tpq5KJtwZeINyXyEw8tOwSbnJUrT4opT1svBkY0FE7kkgZHEoee6hkTwrXlTe/+plZhKyp4Osjnbe8xDUmz8zhbUJIt7Gir8sZLc4+3ADoOAscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536183; c=relaxed/simple;
	bh=fPcMh6PG41cvs/Q1a1dSMWkRJEIvelySKraIvjb9LPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXae/xdAyIlqrTX4CCGFkXx5OedhKBB9ZS7CEnQDRvXe5MesW2MJGtusB0Jz8e052LSJjBJ8eHCPcD7RFbEpB5ye1vHgqDL0yo2dsMPE0KnXe4Wz35TUVQOpbveSLCSFqz5u01uLvXBXg2VN10fkXw2GaKaoGt8UFaLGaDnLgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN4h8o89; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb48e77b16so1927546d6.0;
        Sat, 28 Sep 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536180; x=1728140980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ2/UCKUW8V+Esq59seZMzO5ku0C95dG3qrFNZ1EHjI=;
        b=GN4h8o89zqQIplofN6SrlCcncXRgR/hc511dAHoKAwC61WGPI/xN2lAwjrTPSU6GIf
         6sp+kSE2jlxbxxYzO7JDGqyh91xDDfZJSyUM8LW4xJSTXfm6sDpmFz/2Vpu2rPA8JXtx
         cwzklzjBjn9jwulD7TTyJCEHYy8Gmsooo55jPFpFhhATr8APmiFBCcIUFeG6K8LvEZW0
         LjoaD7AZGzwrluHAQ+uizrTxPWIokbz1TdeN8elujxpqmUpX7JvnlKs8DxnIYox5shLj
         GwptwPl8A3DD6dkDy/fZWxfHfsgVPBl/iWtqSQkQyl2MLGihAOUpelotl1CmIaZk3tXT
         X7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536180; x=1728140980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ2/UCKUW8V+Esq59seZMzO5ku0C95dG3qrFNZ1EHjI=;
        b=emC/UfB75HbN1J7PVmJUlUKBcK6IHTjj3LE90svFYdK3Q1VvW9zIr/VrsSYsBr5FBb
         2duUTbHCRvymebVS3tyfIPaZBNXiZp5v9A18HhETo3LKjQWqjh596tiolzF2+0kriYLm
         ICF4JCriFqBWn187zPUgBzXlVyjPOf0GmOgwaXTQpzd0CtsyZSTjyzwL1n8DVOq1ENsa
         fjCAv77G1vkCOpFMdbciEScvZn1dhEG/tSAk9LHHEQ+HtMC4TtgD4s4eYyhXqvaW0lZc
         yCdQIhuTjJg1b8J4N+EV8F1bCZxHmxsFuNiB/sB8ijT/UlH4wdGYo8x4pwou9QYaxJJ3
         5fwA==
X-Forwarded-Encrypted: i=1; AJvYcCVymSqSR+K0jJRvyF7+pmH8ErJLrjLmJzVjJsaweFBt/uOKUoZlDwiBRb5rxO2xiw0DXNmu7eyZ0MA=@vger.kernel.org, AJvYcCWPr3xr8Os/54cYM41Ss379dqYPPM3kvERCZ1KlO+WHWwFrXpjYzVZv5B8lQt3UMZjXOBGY43DfrmDVNKRD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhfzf5dnZ1kVgRWyUA1Bd7mBLbzGKsdY/bnYrQO3+ohffVl8IC
	NdZyH+KacNf3OWo1VT2vbJ7LeKxaifD5BN1aFm4J4ugefdsOpBQlEXpJVBIPksE=
X-Google-Smtp-Source: AGHT+IELuNqfcY3qT32fQoVJsBKpciKW9lWJLuuLAfyyxPgCEAHfHbGvdp2T4yp6i3+kfNe6r7JK5A==
X-Received: by 2002:a05:622a:1486:b0:458:2021:6148 with SMTP id d75a77b69052e-45cadcc99femr19198791cf.9.1727536180143;
        Sat, 28 Sep 2024 08:09:40 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:38 -0700 (PDT)
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
Subject: [PATCH RFC 10/14] usb: gadget: f_uac2: Make string table dynamic with strings from all alt modes
Date: Sat, 28 Sep 2024 11:09:01 -0400
Message-ID: <20240928150905.2616313-11-crwulff@gmail.com>
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

The number of strings is now dependent on how many alt modes exist and
what their strings are set to. This allows the strings to be dynamically
consolidated where alt modes use the same strings, or separate when
different strings are configured in some alt modes.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c | 181 +++++++++++++++++----------
 1 file changed, 113 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index e9f951215c26..54702888855d 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -93,38 +93,6 @@ static int afunc_notify(struct g_audio *agdev, int unit_id, int cs);
 
 /* --------- USB Function Interface ------------- */
 
-enum {
-	STR_ASSOC,
-	STR_IF_CTRL,
-	STR_CLKSRC_IN,
-	STR_CLKSRC_OUT,
-	STR_USB_IT,
-	STR_USB_IT_CH,
-	STR_IO_IT,
-	STR_IO_IT_CH,
-	STR_USB_OT,
-	STR_IO_OT,
-	STR_FU_IN,
-	STR_FU_OUT,
-	STR_AS_OUT_ALT0,
-	STR_AS_OUT_ALT1,
-	STR_AS_IN_ALT0,
-	STR_AS_IN_ALT1,
-	NUM_STR_DESCRIPTORS,
-};
-
-static struct usb_string strings_fn[NUM_STR_DESCRIPTORS + 1] = {};
-
-static struct usb_gadget_strings str_fn = {
-	.language = 0x0409,	/* en-us */
-	.strings = strings_fn,
-};
-
-static struct usb_gadget_strings *fn_strings[] = {
-	&str_fn,
-	NULL,
-};
-
 static struct usb_interface_assoc_descriptor iad_desc = {
 	.bLength = sizeof iad_desc,
 	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
@@ -649,6 +617,98 @@ struct cntrl_subrange_lay3 {
 
 DECLARE_UAC2_CNTRL_RANGES_LAY3(srates, UAC_MAX_RATES);
 
+/*-------------------------------------------------------------------------*/
+
+/*
+ * String handling
+ */
+
+#define MAX_STRINGS 256
+
+static int add_string(struct usb_string *strings, const char *s)
+{
+	int i;
+
+	if (!s || s[0] == '\0')
+		return 0;
+
+	for (i = 0; i < MAX_STRINGS; i++) {
+		if (!strings[i].s) {
+			strings[i].s = s;
+			return 0; /* IDs aren't allocated yet */
+		}
+
+		if (!strcmp(s, strings[i].s))
+			return strings[i].id;
+	}
+
+	return -1;
+}
+
+static void add_alt_strings(struct usb_string *strings, struct f_uac2_alt_opts *alt_opts, bool fu)
+{
+	add_string(strings, alt_opts->name);
+	add_string(strings, alt_opts->it_name);
+	add_string(strings, alt_opts->it_ch_name);
+	add_string(strings, alt_opts->ot_name);
+	if (fu)
+		add_string(strings, alt_opts->fu_vol_name);
+}
+
+static struct usb_string *attach_strings(struct usb_composite_dev *cdev,
+					 struct f_uac2_opts *audio_opts)
+{
+	struct usb_string	*strings = kzalloc(sizeof(struct usb_string) * MAX_STRINGS,
+						   GFP_KERNEL);
+	struct f_uac2_alt_opts	*alt_opts;
+	struct usb_string	*us;
+	int			strings_fn_length;
+
+	struct usb_gadget_strings strings_fn = {
+		.language = 0x0409,	/* en-us */
+		.strings = strings
+	};
+
+	struct usb_gadget_strings *fn_strings[] = {
+		&strings_fn,
+		NULL,
+	};
+
+	if (!strings)
+		return ERR_PTR(-ENOMEM);
+
+	/* Add all the strings from all the alt mode options */
+	add_string(strings, audio_opts->function_name);
+	add_string(strings, audio_opts->if_ctrl_name);
+	add_string(strings, audio_opts->clksrc_in_name);
+	add_string(strings, audio_opts->clksrc_out_name);
+	add_string(strings, audio_opts->c_alt_0_opts.name);
+	add_string(strings, audio_opts->p_alt_0_opts.name);
+	add_alt_strings(strings, &audio_opts->c_alt_1_opts, FUOUT_EN(audio_opts));
+	add_alt_strings(strings, &audio_opts->p_alt_1_opts, FUIN_EN(audio_opts));
+	list_for_each_entry(alt_opts, &audio_opts->c_alt_opts, list) {
+		add_alt_strings(strings, alt_opts, FUOUT_EN(audio_opts));
+	}
+	list_for_each_entry(alt_opts, &audio_opts->p_alt_opts, list) {
+		add_alt_strings(strings, alt_opts, FUIN_EN(audio_opts));
+	}
+
+	for (strings_fn_length = 0; strings[strings_fn_length].s; strings_fn_length++)
+		;
+
+	/* Attach strings to the composite device and get string IDs assigned */
+	us = usb_gstrings_attach(cdev, fn_strings, strings_fn_length);
+
+	/* Strings are now copied to the composite device and we use the
+	 * copy in "us" going forward, that has all the string IDs.
+	 */
+	kfree(strings);
+
+	return us;
+}
+
+/*-------------------------------------------------------------------------*/
+
 static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_alt_opts *alt_opts,
 	struct usb_endpoint_descriptor *ep_desc,
 	enum usb_device_speed speed, bool is_playback)
@@ -994,26 +1054,11 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	if (ret)
 		return ret;
 
-	strings_fn[STR_ASSOC].s = uac2_opts->function_name;
-	strings_fn[STR_IF_CTRL].s = uac2_opts->if_ctrl_name;
-	strings_fn[STR_CLKSRC_IN].s = uac2_opts->clksrc_in_name;
-	strings_fn[STR_CLKSRC_OUT].s = uac2_opts->clksrc_out_name;
-
-	strings_fn[STR_USB_IT].s = uac2_opts->c_it_name;
-	strings_fn[STR_USB_IT_CH].s = uac2_opts->c_it_ch_name;
-	strings_fn[STR_IO_OT].s = uac2_opts->c_ot_name;
-	strings_fn[STR_FU_OUT].s = uac2_opts->c_fu_vol_name;
-	strings_fn[STR_AS_OUT_ALT0].s = "Playback Inactive";
-	strings_fn[STR_AS_OUT_ALT1].s = "Playback Active";
-
-	strings_fn[STR_IO_IT].s = uac2_opts->p_it_name;
-	strings_fn[STR_IO_IT_CH].s = uac2_opts->p_it_ch_name;
-	strings_fn[STR_USB_OT].s = uac2_opts->p_ot_name;
-	strings_fn[STR_FU_IN].s = uac2_opts->p_fu_vol_name;
-	strings_fn[STR_AS_IN_ALT0].s = "Capture Inactive";
-	strings_fn[STR_AS_IN_ALT1].s = "Capture Active";
-
-	us = usb_gstrings_attach(cdev, fn_strings, ARRAY_SIZE(strings_fn));
+	/* Past this point, all settings that apply to an alt mode should
+	 * be used from their alt mode opts.
+	 */
+
+	us = attach_strings(cdev, uac2_opts);
 	if (IS_ERR(us))
 		return PTR_ERR(us);
 
@@ -1030,30 +1075,30 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		}
 	}
 
-	iad_desc.iFunction = us[STR_ASSOC].id;
-	std_ac_if_desc.iInterface = us[STR_IF_CTRL].id;
-	in_clk_src_desc.iClockSource = us[STR_CLKSRC_IN].id;
-	out_clk_src_desc.iClockSource = us[STR_CLKSRC_OUT].id;
-	usb_out_it_desc.iTerminal = us[STR_USB_IT].id;
-	usb_out_it_desc.iChannelNames = us[STR_USB_IT_CH].id;
-	io_in_it_desc.iTerminal = us[STR_IO_IT].id;
-	io_in_it_desc.iChannelNames = us[STR_IO_IT_CH].id;
-	usb_in_ot_desc.iTerminal = us[STR_USB_OT].id;
-	io_out_ot_desc.iTerminal = us[STR_IO_OT].id;
-	std_as_out_if0_desc.iInterface = us[STR_AS_OUT_ALT0].id;
-	std_as_out_if1_desc.iInterface = us[STR_AS_OUT_ALT1].id;
-	std_as_in_if0_desc.iInterface = us[STR_AS_IN_ALT0].id;
-	std_as_in_if1_desc.iInterface = us[STR_AS_IN_ALT1].id;
+	iad_desc.iFunction = add_string(us, uac2_opts->function_name);
+	std_ac_if_desc.iInterface = add_string(us, uac2_opts->if_ctrl_name);
+	in_clk_src_desc.iClockSource = add_string(us, uac2_opts->clksrc_in_name);
+	out_clk_src_desc.iClockSource = add_string(us, uac2_opts->clksrc_out_name);
+	usb_out_it_desc.iTerminal = add_string(us, uac2_opts->c_alt_1_opts.it_name);
+	usb_out_it_desc.iChannelNames = add_string(us, uac2_opts->c_alt_1_opts.it_ch_name);
+	io_in_it_desc.iTerminal = add_string(us, uac2_opts->p_alt_1_opts.it_name);
+	io_in_it_desc.iChannelNames = add_string(us, uac2_opts->p_alt_1_opts.it_ch_name);
+	usb_in_ot_desc.iTerminal = add_string(us, uac2_opts->p_alt_1_opts.ot_name);
+	io_out_ot_desc.iTerminal = add_string(us, uac2_opts->c_alt_1_opts.ot_name);
+	std_as_out_if0_desc.iInterface = add_string(us, uac2_opts->c_alt_0_opts.name);
+	std_as_out_if1_desc.iInterface = add_string(us, uac2_opts->c_alt_1_opts.name);
+	std_as_in_if0_desc.iInterface = add_string(us, uac2_opts->p_alt_0_opts.name);
+	std_as_in_if1_desc.iInterface = add_string(us, uac2_opts->p_alt_0_opts.name);
 
 	if (FUOUT_EN(uac2_opts)) {
 		u8 *i_feature = (u8 *)out_feature_unit_desc +
 				out_feature_unit_desc->bLength - 1;
-		*i_feature = us[STR_FU_OUT].id;
+		*i_feature = add_string(us, uac2_opts->c_alt_1_opts.fu_vol_name);
 	}
 	if (FUIN_EN(uac2_opts)) {
 		u8 *i_feature = (u8 *)in_feature_unit_desc +
 				in_feature_unit_desc->bLength - 1;
-		*i_feature = us[STR_FU_IN].id;
+		*i_feature = add_string(us, uac2_opts->p_alt_1_opts.fu_vol_name);
 	}
 
 
-- 
2.43.0


