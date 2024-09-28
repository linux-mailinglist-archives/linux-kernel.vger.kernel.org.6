Return-Path: <linux-kernel+bounces-342522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2770988FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820BA282692
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B68188920;
	Sat, 28 Sep 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwkH0Oe5"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63818786C;
	Sat, 28 Sep 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536177; cv=none; b=iBD4gdov0NLSEogYgkVB831b2wdUArtXJr/zUwSf/X2SzmIqpIwdvYWqp5ojzlKnA6F47K0N7gey10F2tKXcJkw+U2y2Z9QkQn7ZxJjVw0Jeso8BDwsGrhBynxyslasWNkZ8l3SVPuWkvXxRVTT807LJbADGIwFxkPmED+JWYTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536177; c=relaxed/simple;
	bh=OdQWnJdTMpXJN8De8O2WDiJv+DfKAtTFaJYHxL0kmrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaEfzA7jqOoT5TscrEdBM6SiPEsxP7m3B824k3vlTd9sqN0ulg9ep3LH7M+8BfAaVKZoSL2DPGTGwbcWYL7JGfxzqX4Czrw2kDy4pb76E/++M4k8RSf/Lm7z0GUFD2xmYN/ybQq14uFxOZ7tTX5R/qRhemPGZT/SA5tgs06frXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwkH0Oe5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb313711a9so4452156d6.0;
        Sat, 28 Sep 2024 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536173; x=1728140973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3ZmJY6RwEUv236Or6gK4E9hSSjCqNV2s31MqAFEavs=;
        b=mwkH0Oe5zFreR7iyyplPusYg/sEDAmghSF734vTWZTkllq1AM35dlRQs4fyxg34Hoa
         hV8SPo+clKadksT8uG5CKm4LCEvqFTiWAVwhugTdi9VchUta4B2bmIXVo1Yz9eTzXz9M
         btyCQ+FmDUk0lc5AGOOu/wCmfZjQt8WqyULgGRLluKkE5po7ugtr0lbgbJF8eRXONf6W
         xrTRaXLbBQLGW6hGKhUnRFdRRww33AG3FRnkapIbs0P7A/LjVdxVpk1RUaEOj/tSz6LH
         EwnjZPy9m2nVCmXpCRdRz4N4VlqRRaRUboASBEQrJAhpqtlxUNgorB/+xVZPT3pyl37U
         HfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536173; x=1728140973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3ZmJY6RwEUv236Or6gK4E9hSSjCqNV2s31MqAFEavs=;
        b=DNRLp9n+OmXBvOio+WPXqWJwgR2pVCr3YK909C5HGE806KsFIOFxr5tIrZOtj79JpB
         kMUPWrkkw9F5YLDKNtigKl7OVSiQ0AcruagL3ku7N76ICtD8Q9Vib+cttVC4hAkQP1+j
         35PQi95q6Xq1jDFE8fK9/iN3jXF0417U1sMWvWbU4Y6jqOIFOTI8FEB07DjGgS6tFpPC
         CjawzsRF9ZvZxyTFqe7nJMuebCzIj4RJqPWNjXw0QQbf4LbjYDirGVGxc4cPr3YXebQt
         wfBZQBRVYx9CZxzcUW5aF7RgnPgn4FXV7gNl+Phj2AQhEOEQ6LP2zobnGQ2j8Xt6UXzm
         s/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVE2brB6DaWu6QTKnHzvUl1OhhSWizJkOyZbnAfexs67iZ0lN8nqTtDbTHJaattv6XIsYaISyTZvhgAI3zN@vger.kernel.org, AJvYcCXUyXTobv8RZepxApyvz5DEhLpVb2CE9whhxpnqo76p0wIAN1GFhtfLccBb0pzuSsCMzOMEHVQIGh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgS2PFmwxvpitnG+JugBiuJQcu9QsiHpj2ULs7zrEmBNyU+Iru
	o7UCBhB9Y8rl5i4BtDqA106knBapbkeCeECm4d5aEi88J3T4NEfdP9NzMQg3GRc=
X-Google-Smtp-Source: AGHT+IGNdUzIqzXX/P+/cQtiq1Gf916Wi79LL2yrUhiS4EdsJN5gw2YgjBvbbIgk24AUpv2NaPLnXg==
X-Received: by 2002:ac8:5787:0:b0:458:2c28:ebac with SMTP id d75a77b69052e-45cadb6922amr19064901cf.4.1727536172814;
        Sat, 28 Sep 2024 08:09:32 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:32 -0700 (PDT)
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
Subject: [PATCH RFC 07/14] usb: gadget: f_uac1: Add alt mode settings interface
Date: Sat, 28 Sep 2024 11:08:58 -0400
Message-ID: <20240928150905.2616313-8-crwulff@gmail.com>
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

Add the ability to create c_alt.x and p_alt.x directories to
have different configurations for channels/sample size/sync mode. This
patch only implements the user interface and does not yet alter the
behavior of the function.

Initial values for the alt mode settings are copied from the main settings
at the time the alt mode directory is created.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 Documentation/usb/gadget-testing.rst |  19 ++
 drivers/usb/gadget/function/f_uac1.c | 311 ++++++++++++++++++++++++---
 drivers/usb/gadget/function/u_uac1.h |  79 +++++--
 3 files changed, 367 insertions(+), 42 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 53c2518dbf50..5aaf03cf8ebf 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -982,10 +982,29 @@ The uac1 function provides these attributes in its function directory:
 	c_fu_vol_name    capture mute/volume functional unit name
 	c_terminal_type  code of the capture terminal type
 	p_terminal_type  code of the playback terminal type
+	c_alt.x/         alternate capture setting x (0-255)
+	p_alt.x/         alternate playback setting x (0-255)
 	================ ====================================================
 
 The attributes have sane default values.
 
+Alternate settings have these attributes settable. Defaults are copied
+from the associated function-wide settings. Alternate setting 0 only
+has a name and no other settings. If p/c_alt.1 doesn't exist
+function-wide settings will be used for alternate setting 1.
+
+	================ ====================================================
+	name             alternate setting name
+	chmask           channel mask
+	ssize            sample size (bytes)
+	sync             synchronization type (async/adaptive) *capture only*
+	hs_bint          bInterval for HS/SS (1-4: fixed, 0: auto)
+	it_name          input terminal name
+	it_ch_name       first input channel name
+	ot_name          output terminal name
+	fu_vol_name      mute/volume functional unit name
+	================ ====================================================
+
 Testing the UAC1 function
 -------------------------
 
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 5813fe3e7146..e7bfc32387bf 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -21,6 +21,9 @@
 #include "u_uac1.h"
 #include "u_uac_utils.h"
 
+#define HOST_TO_DEVICE 0
+#define DEVICE_TO_HOST 1
+
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
 
@@ -1160,29 +1163,14 @@ f_audio_suspend(struct usb_function *f)
 
 /*-------------------------------------------------------------------------*/
 
-static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_opts *opts,
-	struct usb_endpoint_descriptor *ep_desc,
-	enum usb_device_speed speed, bool is_playback)
+static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_alt_opts *alt_opts,
+					struct usb_endpoint_descriptor *ep_desc,
+					enum usb_device_speed speed, bool is_playback)
 {
-	int chmask, srate, ssize, hs_bint, sync;
-
-	if (is_playback) {
-		chmask = opts->p_chmask;
-		srate = get_max_srate(opts->p_srates);
-		ssize = opts->p_ssize;
-		hs_bint = opts->p_hs_bint;
-		sync = USB_ENDPOINT_SYNC_ASYNC;
-	} else {
-		chmask = opts->c_chmask;
-		srate = get_max_srate(opts->c_srates);
-		ssize = opts->c_ssize;
-		hs_bint = opts->c_hs_bint;
-		sync = opts->c_sync;
-	}
-
 	return uac_set_ep_max_packet_size_bint(
-		dev, ep_desc, speed, is_playback, hs_bint, chmask,
-		srate, ssize, sync, opts->fb_max);
+		dev, ep_desc, speed, is_playback, alt_opts->hs_bint,
+		alt_opts->chmask, get_max_srate(alt_opts->srates),
+		alt_opts->ssize, alt_opts->sync, alt_opts->c.opts->fb_max);
 }
 
 static struct uac_feature_unit_descriptor *build_fu_desc(int chmask)
@@ -1459,6 +1447,52 @@ static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
 	return 0;
 }
 
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Configfs alt mode handling
+ */
+
+static void init_alt_0_opts(struct f_uac1_alt_0_opts *alt_0_opts,
+			    struct f_uac1_opts *opts, int playback)
+{
+	alt_0_opts->c.opts = opts;
+	alt_0_opts->c.alt_num = 0;
+
+	// Note: Strings are from the host perspective, opt prefixes are from the device perspective
+	scnprintf(alt_0_opts->name, sizeof(alt_0_opts->name),
+		  (!playback) ? "Playback Inactive" : "Capture Inactive");
+}
+
+static void init_alt_opts(struct f_uac1_alt_opts *alt_opts, struct f_uac1_opts *opts,
+			  int alt_num, int playback)
+{
+	alt_opts->c.opts = opts;
+	alt_opts->c.alt_num = alt_num;
+
+	INIT_LIST_HEAD(&alt_opts->list);
+
+	// Note: Strings are from the host perspective, opt prefixes are from the device perspective
+	scnprintf(alt_opts->name, sizeof(alt_opts->name),
+		  (!playback) ? "Playback Active" : "Capture Active");
+	strscpy(alt_opts->it_name, (playback) ? opts->p_it_name : opts->c_it_name,
+		sizeof(alt_opts->it_name));
+	strscpy(alt_opts->it_ch_name, (playback) ? opts->p_it_ch_name : opts->c_it_ch_name,
+		sizeof(alt_opts->it_ch_name));
+	strscpy(alt_opts->ot_name, (playback) ? opts->p_ot_name : opts->c_ot_name,
+		sizeof(alt_opts->ot_name));
+	strscpy(alt_opts->fu_vol_name, (playback) ? opts->p_fu_vol_name : opts->c_fu_vol_name,
+		sizeof(alt_opts->fu_vol_name));
+
+	/* Copy default options from the main opts */
+	alt_opts->chmask = (playback) ? opts->p_chmask : opts->c_chmask;
+	alt_opts->ssize = (playback) ? opts->p_ssize : opts->c_ssize;
+	alt_opts->hs_bint = (playback) ? opts->p_hs_bint : opts->c_hs_bint;
+	alt_opts->srates = (playback) ? opts->p_srates : opts->c_srates;
+	alt_opts->sync = (playback) ? 0 : opts->c_sync;
+	alt_opts->terminal_type = (playback) ? opts->p_terminal_type : opts->c_terminal_type;
+}
+
 /* audio function driver setup/binding */
 static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 {
@@ -1474,12 +1508,24 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	int				status;
 	int				idx, i;
 
+	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
+
+	/* Copy main options to alt modes 0/1 if the groups don't exist
+	 * before validation since they will be checked.
+	 */
+	if (!audio_opts->c_alt_0_opts.c.group.cg_item.ci_name)
+		init_alt_0_opts(&audio_opts->c_alt_0_opts, audio_opts, HOST_TO_DEVICE);
+	if (!audio_opts->p_alt_0_opts.c.group.cg_item.ci_name)
+		init_alt_0_opts(&audio_opts->p_alt_0_opts, audio_opts, DEVICE_TO_HOST);
+	if (!audio_opts->c_alt_1_opts.c.group.cg_item.ci_name)
+		init_alt_opts(&audio_opts->c_alt_1_opts, audio_opts, 1, HOST_TO_DEVICE);
+	if (!audio_opts->p_alt_1_opts.c.group.cg_item.ci_name)
+		init_alt_opts(&audio_opts->p_alt_1_opts, audio_opts, 1, DEVICE_TO_HOST);
+
 	status = f_audio_validate_opts(audio, dev);
 	if (status)
 		return status;
 
-	audio_opts = container_of(f->fi, struct f_uac1_opts, func_inst);
-
 	strings_uac1[STR_AC_IF].s = audio_opts->function_name;
 
 	strings_uac1[STR_USB_OUT_IT].s = audio_opts->c_it_name;
@@ -1656,42 +1702,42 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	ss_as_out_ep_desc.bInterval = audio_opts->c_hs_bint;
 
 	/* Calculate wMaxPacketSize according to audio bandwidth */
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &fs_as_in_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &fs_as_in_ep_desc,
 					     USB_SPEED_FULL, true);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		goto err_free_fu;
 	}
 
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &fs_as_out_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &fs_as_out_ep_desc,
 					     USB_SPEED_FULL, false);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		goto err_free_fu;
 	}
 
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_in_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &hs_as_in_ep_desc,
 					     USB_SPEED_HIGH, true);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		goto err_free_fu;
 	}
 
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_out_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &hs_as_out_ep_desc,
 					     USB_SPEED_HIGH, false);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		goto err_free_fu;
 	}
 
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &ss_as_in_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->p_alt_1_opts, &ss_as_in_ep_desc,
 					     USB_SPEED_SUPER, true);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		goto err_free_fu;
 	}
 
-	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_out_ep_desc,
+	status = set_ep_max_packet_size_bint(dev, &audio_opts->c_alt_1_opts, &hs_as_out_ep_desc,
 					     USB_SPEED_SUPER, false);
 	if (status < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
@@ -1835,6 +1881,108 @@ static inline struct f_uac1_opts *to_f_uac1_opts(struct config_item *item)
 			    func_inst.group);
 }
 
+static inline struct f_uac1_alt_opts *to_f_uac1_alt_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_uac1_alt_opts,
+			    c.group);
+}
+
+#define UAC1_ALT_ATTR_TO_OPTS struct f_uac1_alt_opts *alt_opts = to_f_uac1_alt_opts(item)
+#define UAC1_ALT_ATTRIBUTE(type, name)					\
+	UAC_ATTRIBUTE(f_uac1_alt_opts, UAC1_ALT_ATTR_TO_OPTS, alt_opts,	\
+		      alt_opts->c.opts->lock, alt_opts->c.opts->refcnt,	\
+		      type, name)
+
+#define UAC1_ALT_ATTRIBUTE_SYNC(name)					\
+	UAC_ATTRIBUTE_SYNC(f_uac1_alt_opts, UAC1_ALT_ATTR_TO_OPTS,	\
+			   alt_opts, alt_opts->c.opts->lock,		\
+			   alt_opts->c.opts->refcnt, name)
+
+#define UAC1_ALT_ATTRIBUTE_STRING(name)					\
+	UAC_ATTRIBUTE_STRING(f_uac1_alt_opts, UAC1_ALT_ATTR_TO_OPTS,	\
+			     alt_opts, alt_opts->c.opts->lock,		\
+			     alt_opts->c.opts->refcnt, name)
+
+
+UAC1_ALT_ATTRIBUTE_STRING(name);
+UAC1_ALT_ATTRIBUTE_STRING(it_name);
+UAC1_ALT_ATTRIBUTE_STRING(it_ch_name);
+UAC1_ALT_ATTRIBUTE_STRING(ot_name);
+UAC1_ALT_ATTRIBUTE_STRING(fu_vol_name);
+
+UAC1_ALT_ATTRIBUTE(u32, ssize);
+UAC1_ALT_ATTRIBUTE(u8, hs_bint);
+UAC1_ALT_ATTRIBUTE(u32, chmask);
+UAC1_ALT_ATTRIBUTE_SYNC(sync);
+UAC1_ALT_ATTRIBUTE(s16, terminal_type);
+
+static struct configfs_attribute *f_uac1_alt_0_attrs[] = {
+	&f_uac1_alt_opts_attr_name,
+
+	NULL,
+};
+
+static const struct config_item_type alt_mode_0_type = {
+	.ct_attrs	= f_uac1_alt_0_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct configfs_attribute *f_uac1_alt_attrs_c[] = {
+	&f_uac1_alt_opts_attr_name,
+	&f_uac1_alt_opts_attr_it_name,
+	&f_uac1_alt_opts_attr_it_ch_name,
+	&f_uac1_alt_opts_attr_ot_name,
+	&f_uac1_alt_opts_attr_fu_vol_name,
+	&f_uac1_alt_opts_attr_ssize,
+	&f_uac1_alt_opts_attr_hs_bint,
+	&f_uac1_alt_opts_attr_chmask,
+	&f_uac1_alt_opts_attr_sync,
+	&f_uac1_alt_opts_attr_terminal_type,
+
+	NULL,
+};
+
+static struct configfs_attribute *f_uac1_alt_attrs_p[] = {
+	&f_uac1_alt_opts_attr_name,
+	&f_uac1_alt_opts_attr_it_name,
+	&f_uac1_alt_opts_attr_it_ch_name,
+	&f_uac1_alt_opts_attr_ot_name,
+	&f_uac1_alt_opts_attr_fu_vol_name,
+	&f_uac1_alt_opts_attr_ssize,
+	&f_uac1_alt_opts_attr_hs_bint,
+	&f_uac1_alt_opts_attr_chmask,
+	&f_uac1_alt_opts_attr_terminal_type,
+
+	NULL,
+};
+
+static void f_uac1_alt_attr_release(struct config_item *item)
+{
+	struct f_uac1_alt_opts *alt_opts = to_f_uac1_alt_opts(item);
+
+	/* Opts 0 and 1 are fixed structures, 2+ are kzalloc'd */
+	if (alt_opts->c.alt_num > 1)
+		kfree(alt_opts);
+}
+
+static struct configfs_item_operations f_uac1_alt_item_ops = {
+	.release	= f_uac1_alt_attr_release,
+};
+
+static const struct config_item_type alt_mode_c_type = {
+	.ct_item_ops	= &f_uac1_alt_item_ops,
+	.ct_attrs	= f_uac1_alt_attrs_c,
+	.ct_owner	= THIS_MODULE,
+};
+
+static const struct config_item_type alt_mode_p_type = {
+	.ct_item_ops	= &f_uac1_alt_item_ops,
+	.ct_attrs	= f_uac1_alt_attrs_p,
+	.ct_owner	= THIS_MODULE,
+};
+
+/*-------------------------------------------------------------------------*/
+
 static void f_uac1_attr_release(struct config_item *item)
 {
 	struct f_uac1_opts *opts = to_f_uac1_opts(item);
@@ -1946,8 +2094,109 @@ static struct configfs_attribute *f_uac1_attrs[] = {
 	NULL,
 };
 
+static struct config_group *f_uac1_group_make(
+		struct config_group *group,
+		const char *name)
+{
+	struct f_uac1_opts *opts = to_f_uac1_opts(&group->cg_item);
+	struct f_uac1_alt_opts *alt_opts;
+	struct f_uac1_alt_opts *pos;
+	struct config_group *ret;
+	unsigned int alt_num;
+	int playback = 0;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = ERR_PTR(-EBUSY);
+		goto end;
+	}
+
+	if (sscanf(name, "c_alt.%u", &alt_num) != 1) {
+		playback = 1;
+		if (sscanf(name, "p_alt.%u", &alt_num) != 1) {
+			ret = ERR_PTR(-EINVAL);
+			goto end;
+		}
+	}
+
+	if (alt_num > 255) {
+		ret = ERR_PTR(-EINVAL);
+		goto end;
+	}
+
+	/* Alt mode 0 has less properties */
+	if (alt_num == 0) {
+		struct f_uac1_alt_0_opts *alt_0_opts = (playback) ? &opts->p_alt_0_opts
+								  : &opts->c_alt_0_opts;
+		init_alt_0_opts(alt_0_opts, opts, playback);
+		config_group_init_type_name(&alt_0_opts->c.group, name, &alt_mode_0_type);
+		ret = &alt_0_opts->c.group;
+		goto end;
+	}
+
+	if (alt_num == 1) {
+		/* Alt mode 1 always exists */
+		alt_opts = (playback) ? &opts->p_alt_1_opts : &opts->c_alt_1_opts;
+	} else {
+		/* Allocate a structure for alt mode 2+ */
+		alt_opts = kzalloc(sizeof(*alt_opts), GFP_KERNEL);
+		if (!alt_opts) {
+			ret = ERR_PTR(-ENOMEM);
+			goto end;
+		}
+	}
+
+	ret = &alt_opts->c.group;
+
+	config_group_init_type_name(&alt_opts->c.group, name, (playback) ? &alt_mode_p_type
+									 : &alt_mode_c_type);
+
+	init_alt_opts(alt_opts, opts, alt_num, playback);
+
+	/* Alt mode 1 doesn't go in the list. It is handled separately to
+	 * also handle the case where the alt.1 group is not created.
+	 */
+	if (alt_num == 1)
+		goto end;
+
+	/* Insert the new alt mode in the list, sorted by alt_num */
+	list_for_each_entry(pos, (playback) ? &opts->p_alt_opts : &opts->c_alt_opts, list) {
+		if (alt_opts->c.alt_num < pos->c.alt_num) {
+			list_add_tail(&alt_opts->list, &pos->list);
+			goto end;
+		}
+	}
+
+	list_add_tail(&alt_opts->list, (playback) ? &opts->p_alt_opts : &opts->c_alt_opts);
+
+end:
+	mutex_unlock(&opts->lock);
+
+	return ret;
+}
+
+static void f_uac1_group_drop(struct config_group *group, struct config_item *item)
+{
+	struct f_uac1_alt_opts *alt_opts = to_f_uac1_alt_opts(item);
+
+	/* Alt modes 0 and 1 are preallocated and not included in the list */
+	if (alt_opts->c.alt_num > 1) {
+		mutex_lock(&alt_opts->c.opts->lock);
+		list_del(&alt_opts->list);
+		mutex_unlock(&alt_opts->c.opts->lock);
+	}
+
+	config_item_put(item);
+}
+
+static struct configfs_group_operations f_uac1_group_ops = {
+	.make_group     = &f_uac1_group_make,
+	.drop_item      = &f_uac1_group_drop,
+};
+
 static const struct config_item_type f_uac1_func_type = {
 	.ct_item_ops	= &f_uac1_item_ops,
+	.ct_group_ops   = &f_uac1_group_ops,
 	.ct_attrs	= f_uac1_attrs,
 	.ct_owner	= THIS_MODULE,
 };
@@ -1971,6 +2220,9 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	mutex_init(&opts->lock);
 	opts->func_inst.free_func_inst = f_audio_free_inst;
 
+	INIT_LIST_HEAD(&opts->c_alt_opts);
+	INIT_LIST_HEAD(&opts->p_alt_opts);
+
 	config_group_init_type_name(&opts->func_inst.group, "",
 				    &f_uac1_func_type);
 
@@ -2001,6 +2253,7 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 
 	scnprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
 
+	// Note: Strings are from the host perspective, opt prefixes are from the device perspective
 	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Capture Input terminal");
 	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Capture Channels");
 	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Capture Output terminal");
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index df29018096d3..ae69f1eb872d 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -33,8 +33,61 @@
 #define UAC1_DEF_P_TERM_TYPE UAC_INPUT_TERMINAL_MICROPHONE
 #define UAC1_DEF_C_TERM_TYPE UAC_OUTPUT_TERMINAL_SPEAKER
 
+
+struct f_uac1_opts;
+
+struct f_uac1_alt_opts_common {
+	struct config_group	group;
+	struct f_uac1_opts	*opts;
+	u8			alt_num;
+};
+
+/* Alt mode 0 only has a name */
+struct f_uac1_alt_0_opts {
+	struct f_uac1_alt_opts_common c;
+
+	char			name[USB_MAX_STRING_LEN];
+};
+
+/* Alt modes 1+ */
+struct f_uac1_alt_opts {
+	struct f_uac1_alt_opts_common c;
+
+	struct list_head	list;
+
+	/* Strings */
+	char			name[USB_MAX_STRING_LEN];
+	char			it_name[USB_MAX_STRING_LEN];
+	char			it_ch_name[USB_MAX_STRING_LEN];
+	char			ot_name[USB_MAX_STRING_LEN];
+	char			fu_vol_name[USB_MAX_STRING_LEN];
+
+	/* Audio options */
+	int			chmask;
+	int			*srates; /* Reference to p/c_srates in opts */
+	int			sync;
+	int			ssize;
+	u8			hs_bint;
+	s16			terminal_type;
+
+};
+
 struct f_uac1_opts {
 	struct usb_function_instance	func_inst;
+
+	/* Alt mode 0 options */
+	struct f_uac1_alt_0_opts	c_alt_0_opts;
+	struct f_uac1_alt_0_opts	p_alt_0_opts;
+
+	/* Alt mode 1 options */
+	struct f_uac1_alt_opts		c_alt_1_opts;
+	struct f_uac1_alt_opts		p_alt_1_opts;
+
+	/* Alt mode 2+ options */
+	struct list_head		c_alt_opts;
+	struct list_head		p_alt_opts;
+
+	/* Default options and Alt mode 1 if no c/p_alt.1 created */
 	int				c_chmask;
 	int				c_srates[UAC_MAX_RATES];
 	int				c_sync;
@@ -45,14 +98,14 @@ struct f_uac1_opts {
 	int				p_ssize;
 	u8				p_hs_bint;
 
-	bool			p_mute_present;
-	bool			p_volume_present;
+	bool				p_mute_present;
+	bool				p_volume_present;
 	s16				p_volume_min;
 	s16				p_volume_max;
 	s16				p_volume_res;
 
-	bool			c_mute_present;
-	bool			c_volume_present;
+	bool				c_mute_present;
+	bool				c_volume_present;
 	s16				c_volume_min;
 	s16				c_volume_max;
 	s16				c_volume_res;
@@ -61,17 +114,17 @@ struct f_uac1_opts {
 	int				fb_max;
 	unsigned			bound:1;
 
-	char			function_name[USB_MAX_STRING_LEN];
+	char				function_name[USB_MAX_STRING_LEN];
 
-	char			p_it_name[USB_MAX_STRING_LEN];
-	char			p_it_ch_name[USB_MAX_STRING_LEN];
-	char			p_ot_name[USB_MAX_STRING_LEN];
-	char			p_fu_vol_name[USB_MAX_STRING_LEN];
+	char				p_it_name[USB_MAX_STRING_LEN];
+	char				p_it_ch_name[USB_MAX_STRING_LEN];
+	char				p_ot_name[USB_MAX_STRING_LEN];
+	char				p_fu_vol_name[USB_MAX_STRING_LEN];
 
-	char			c_it_name[USB_MAX_STRING_LEN];
-	char			c_it_ch_name[USB_MAX_STRING_LEN];
-	char			c_ot_name[USB_MAX_STRING_LEN];
-	char			c_fu_vol_name[USB_MAX_STRING_LEN];
+	char				c_it_name[USB_MAX_STRING_LEN];
+	char				c_it_ch_name[USB_MAX_STRING_LEN];
+	char				c_ot_name[USB_MAX_STRING_LEN];
+	char				c_fu_vol_name[USB_MAX_STRING_LEN];
 
 	s16				p_terminal_type;
 	s16				c_terminal_type;
-- 
2.43.0


