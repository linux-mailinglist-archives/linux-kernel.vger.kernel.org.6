Return-Path: <linux-kernel+bounces-342524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C462F988FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754171F210D0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05F188CB5;
	Sat, 28 Sep 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7OiYr/T"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6718893A;
	Sat, 28 Sep 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536180; cv=none; b=n2FqQ88Fzo1J0blUEdXAQRs74AUeGL95DGux4G5aj6eNXD21dsiGCXoa9KuuIX2uwoQ8Oqa/9scN5VQLqbTI2MtsqBzNrgOaH2vZ7cu3CQ6rRGFkjGaYNsyaVABK93HpBDcIjbOwdQU6FmPSChCKBaRMPGUHjp6svddgsRspV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536180; c=relaxed/simple;
	bh=BbZCf5/FOhIKEJagMoX+Au0eH3BJVRYm+kHMoEfdGKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eItbiQs/I5HcHZKb7q/IvTmbCuM/PCw5GLxSFj3y0xTqY0dpK/7PSQ5XIPSb9iVG1DvK5nQ94GIIFvImn+GMC2MHCkT/kAl+D4RfoQPQBQwsJQ/76JQqOOzJbAi3ekr1YIWO1XtMH2qcFrTgEuTpijF72frczFJleWGthp23Zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7OiYr/T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45813fcf59aso1577061cf.3;
        Sat, 28 Sep 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536178; x=1728140978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BSQWlQuRshKpUj3tpPdY61OirhldWjZ0UVfk07xzic=;
        b=N7OiYr/TKu2ZvaLWvsONwfnRL5O8B5aG8xnWOd8ChTcagR2rQI6E1vYDG6Jd3cG2ue
         znrEOtVdiz0eNrPxrTdNi8kLA+i/myNQuW+b3iY1uX7qBWZBnS4R7OGKt7v/OG3fvb5+
         QyC12BzHDzu1Ho9nx3CZP/khBQUmeagX9MOKwBpwXM8XOrHgIu1nD51fyaZCWsA7otEV
         y6n/bO2CAH78/eNkQlHZ0uxRWLMYuWobl96+4PyQF04JcRvyUdHywcMCzqb7QxlOv9J7
         Glm0n/HXr0Jtec4YL26+S2lNBpJLd+hE/3YJHAkRq0+4m2oMUO2M40Cut6SRq1Ew/64D
         Ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536178; x=1728140978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BSQWlQuRshKpUj3tpPdY61OirhldWjZ0UVfk07xzic=;
        b=uDQ3fen5XQIzrqOrnpiKRDNofFKhvs7eU8Y1juYtlcF2gyuAUJD/vsVO5KuuKoq8mh
         NzAs+UB71mRPyF239FM0j8/nlUkL+nGOdQYRvyZTPLkqGSTCS4H+PyofcX0We3WXCToo
         CFOTA3vYX1sXRUujfV5bjU5/QZX3qmbtK0f6S9b02VwSyr9p3UG8yIyLdMPMY5+e+6Sp
         LOIxKrAHolzOMGc+q6HZtCGlNQgfRjuj3ogCI5BVwqZuIDDil71zf9MHNqRfqD07kkgB
         Fd7xgLjjN6G+Z+/c8RG4jZN4dGw+qrubd35uUR2kfNCJthj4JO00/kkbHMycoZvZXsU0
         hrzw==
X-Forwarded-Encrypted: i=1; AJvYcCXS9nLROXv6l+9hxFso3xpiX8lSnzNUJ5ohi2ZU6bCuJmeA79BmQhA5mf9NLYQzH1X7V79kh0qQZsWKI/hj@vger.kernel.org, AJvYcCXZ/sZx55+n9sFoQ1OWnmYioJHrkvi44cUaTGdHDZ0xSegD3flmWIDEFXYlp3TMG9eT+j946hVTnOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAvn9IepnXlsSaLjAzfXaPKayHNpy5FgQHk7l4s6TKEp1Wtzo
	CQUgZQdKKWhzpyUXqnQPS8JPEXPqsh1Dhh17r3pM4a4Km2GBJhk0SZSw8hNtyTk=
X-Google-Smtp-Source: AGHT+IEUP5LqqEqsLbpNBu89htWKblore6ffKLnWKAR3pLtsmxu7nHapkDkhR7kxZxPc/CNyBrkcaw==
X-Received: by 2002:ac8:5fd3:0:b0:458:21b3:640 with SMTP id d75a77b69052e-45c9f31988amr39139511cf.14.1727536177565;
        Sat, 28 Sep 2024 08:09:37 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:36 -0700 (PDT)
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
Subject: [PATCH RFC 09/14] usb: gadget: f_uac1: Make string table dynamic with strings from all alt modes
Date: Sat, 28 Sep 2024 11:09:00 -0400
Message-ID: <20240928150905.2616313-10-crwulff@gmail.com>
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
 drivers/usb/gadget/function/f_uac1.c | 168 ++++++++++++++++++---------
 1 file changed, 110 insertions(+), 58 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index e7bfc32387bf..3484aa237354 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -498,35 +498,6 @@ static struct usb_descriptor_header *f_audio_ss_desc[] = {
 	NULL,
 };
 
-enum {
-	STR_AC_IF,
-	STR_USB_OUT_IT,
-	STR_USB_OUT_IT_CH_NAMES,
-	STR_IO_OUT_OT,
-	STR_IO_IN_IT,
-	STR_IO_IN_IT_CH_NAMES,
-	STR_USB_IN_OT,
-	STR_FU_IN,
-	STR_FU_OUT,
-	STR_AS_OUT_IF_ALT0,
-	STR_AS_OUT_IF_ALT1,
-	STR_AS_IN_IF_ALT0,
-	STR_AS_IN_IF_ALT1,
-	NUM_STR_DESCRIPTORS,
-};
-
-static struct usb_string strings_uac1[NUM_STR_DESCRIPTORS + 1] = {};
-
-static struct usb_gadget_strings str_uac1 = {
-	.language = 0x0409,	/* en-us */
-	.strings = strings_uac1,
-};
-
-static struct usb_gadget_strings *uac1_strings[] = {
-	&str_uac1,
-	NULL,
-};
-
 /*
  * This function is an ALSA sound card following USB Audio Class Spec 1.0.
  */
@@ -1163,6 +1134,93 @@ f_audio_suspend(struct usb_function *f)
 
 /*-------------------------------------------------------------------------*/
 
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
+static void add_alt_strings(struct usb_string *strings, struct f_uac1_alt_opts *alt_opts, bool fu)
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
+					 struct f_uac1_opts *audio_opts)
+{
+	struct usb_string	*strings = kzalloc(sizeof(struct usb_string) * MAX_STRINGS,
+						   GFP_KERNEL);
+	struct f_uac1_alt_opts	*alt_opts;
+	struct usb_string	*us;
+	int			strings_uac1_length;
+
+	struct usb_gadget_strings str_uac1 = {
+		.language = 0x0409,	/* en-us */
+		.strings = strings
+	};
+
+	struct usb_gadget_strings *uac1_strings[] = {
+		&str_uac1,
+		NULL,
+	};
+
+	if (!strings)
+		return ERR_PTR(-ENOMEM);
+
+	/* Add all the strings from all the alt mode options */
+	add_string(strings, audio_opts->function_name);
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
+	for (strings_uac1_length = 0; strings[strings_uac1_length].s; strings_uac1_length++)
+		;
+
+	/* Attach strings to the composite device and get string IDs assigned */
+	us = usb_gstrings_attach(cdev, uac1_strings, strings_uac1_length);
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
 static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_alt_opts *alt_opts,
 					struct usb_endpoint_descriptor *ep_desc,
 					enum usb_device_speed speed, bool is_playback)
@@ -1526,23 +1584,11 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	if (status)
 		return status;
 
-	strings_uac1[STR_AC_IF].s = audio_opts->function_name;
-
-	strings_uac1[STR_USB_OUT_IT].s = audio_opts->c_it_name;
-	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s = audio_opts->c_it_ch_name;
-	strings_uac1[STR_IO_OUT_OT].s = audio_opts->c_ot_name;
-	strings_uac1[STR_FU_OUT].s = audio_opts->c_fu_vol_name;
-	strings_uac1[STR_AS_OUT_IF_ALT0].s = "Playback Inactive";
-	strings_uac1[STR_AS_OUT_IF_ALT1].s = "Playback Active";
-
-	strings_uac1[STR_IO_IN_IT].s = audio_opts->p_it_name;
-	strings_uac1[STR_IO_IN_IT_CH_NAMES].s = audio_opts->p_it_ch_name;
-	strings_uac1[STR_USB_IN_OT].s = audio_opts->p_ot_name;
-	strings_uac1[STR_FU_IN].s = audio_opts->p_fu_vol_name;
-	strings_uac1[STR_AS_IN_IF_ALT0].s = "Capture Inactive";
-	strings_uac1[STR_AS_IN_IF_ALT1].s = "Capture Active";
+	/* Past this point, all settings that apply to an alt mode should
+	 * be used from their alt mode opts.
+	 */
 
-	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
+	us = attach_strings(cdev, audio_opts);
 	if (IS_ERR(us))
 		return PTR_ERR(us);
 
@@ -1565,31 +1611,37 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 	}
 
-	ac_interface_desc.iInterface = us[STR_AC_IF].id;
-	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
-	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
-	io_out_ot_desc.iTerminal = us[STR_IO_OUT_OT].id;
-	as_out_interface_alt_0_desc.iInterface = us[STR_AS_OUT_IF_ALT0].id;
-	as_out_interface_alt_1_desc.iInterface = us[STR_AS_OUT_IF_ALT1].id;
-	io_in_it_desc.iTerminal = us[STR_IO_IN_IT].id;
-	io_in_it_desc.iChannelNames = us[STR_IO_IN_IT_CH_NAMES].id;
-	usb_in_ot_desc.iTerminal = us[STR_USB_IN_OT].id;
-	as_in_interface_alt_0_desc.iInterface = us[STR_AS_IN_IF_ALT0].id;
-	as_in_interface_alt_1_desc.iInterface = us[STR_AS_IN_IF_ALT1].id;
+	ac_interface_desc.iInterface = add_string(us, audio_opts->function_name);
+	usb_out_it_desc.iTerminal = add_string(us, audio_opts->c_alt_1_opts.it_name);
+	usb_out_it_desc.iChannelNames = add_string(us, audio_opts->c_alt_1_opts.it_ch_name);
+	io_out_ot_desc.iTerminal = add_string(us, audio_opts->c_alt_1_opts.ot_name);
+	as_out_interface_alt_0_desc.iInterface = add_string(us, audio_opts->c_alt_0_opts.name);
+	as_out_interface_alt_1_desc.iInterface = add_string(us, audio_opts->c_alt_1_opts.name);
+	io_in_it_desc.iTerminal = add_string(us, audio_opts->p_alt_1_opts.it_name);
+	io_in_it_desc.iChannelNames = add_string(us, audio_opts->p_alt_1_opts.it_ch_name);
+	usb_in_ot_desc.iTerminal = add_string(us, audio_opts->p_alt_1_opts.ot_name);
+	as_in_interface_alt_0_desc.iInterface = add_string(us, audio_opts->p_alt_0_opts.name);
+	as_in_interface_alt_1_desc.iInterface = add_string(us, audio_opts->p_alt_1_opts.name);
 
 	if (FUOUT_EN(audio_opts)) {
 		u8 *i_feature;
 
 		i_feature = (u8 *)out_feature_unit_desc +
 					out_feature_unit_desc->bLength - 1;
-		*i_feature = us[STR_FU_OUT].id;
+		*i_feature = add_string(us, audio_opts->c_alt_1_opts.fu_vol_name);
 	}
 	if (FUIN_EN(audio_opts)) {
 		u8 *i_feature;
 
 		i_feature = (u8 *)in_feature_unit_desc +
 					in_feature_unit_desc->bLength - 1;
-		*i_feature = us[STR_FU_IN].id;
+		*i_feature = add_string(us, audio_opts->p_alt_1_opts.fu_vol_name);
+	}
+
+	us = attach_strings(cdev, audio_opts);
+	if (IS_ERR(us)) {
+		status = PTR_ERR(us);
+		goto fail;
 	}
 
 	/* Set channel numbers */
-- 
2.43.0


