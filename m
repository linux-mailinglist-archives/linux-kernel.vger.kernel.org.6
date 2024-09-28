Return-Path: <linux-kernel+bounces-342523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5E988FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BE1F21254
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE342AA4;
	Sat, 28 Sep 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ4uxlDO"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183C1885B2;
	Sat, 28 Sep 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536178; cv=none; b=it8Uj0gXvQ8jYEheJHG1VUsMHNMgfZ1UhpM1r2d+feGAqmnpWyBUkrdg2yEHcG/RNOmbVPr0V2N06TQxmx6aWWJZHZhqAj3RahUyJpYuPFFybxIxkhKiWgYq9WmIYiyGfS0gvFeDbczEeqlFurX7af90rUcU/KlaUtiBB8/fiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536178; c=relaxed/simple;
	bh=hbscq2OOJ0gv/BSvUFXETU2H7thYLLa+UttHXS8QaXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEKJgQ0tnHY2xvXoFvKme+ne6PzL9eQ5qpRNVsc/IzYXz10jotm3ajOr3Ov9JSDJbOLd0CL+arlE7skHW/bgdyfDJy8ZZxfwTInvc1toCYQHAo4QeAHIVs/yHd2rQmkEnErxL4XUIbclXWaZi1WEKoQDbi8gMnsclDXZMwXG2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ4uxlDO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb316db199so4544986d6.2;
        Sat, 28 Sep 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536175; x=1728140975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57dniUL3gyaElSNWffcZ2ps14gArsQhpLIP8r97nfis=;
        b=RJ4uxlDOpbIJ7hdWyQI79yPBbVNl8caxSKNNazgmDooSFpJjMBpp8yCkfImaZ+4StL
         7+SHBqjPyOQ8yV72oXVRqoa7y39D9ImNIBb7GUCYTtG2hpzoUw9W83VqK43BamcHDEDG
         DY9Wypc2F1bZnp44Y7gAcer4mcTnTsgHh90nOeoA5Ws4516fkKBtfJkGl1cJZaet9Bid
         gADk1+rldNZhShfea/MfrD9yP5PdCINKpSb/6XPGkr38SyD9bdxviddVBQK1kVPKFTYp
         RuZ36wywFyYxNsF26Eeh9Uo1cpo1BUaB1tYFGB6YFm/w2qNrsfsS3J89+U9ptb964DLZ
         wL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536175; x=1728140975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57dniUL3gyaElSNWffcZ2ps14gArsQhpLIP8r97nfis=;
        b=EXUdPAJiW0krHgifVID9mz2DZLtX4J1tnzZX923lQniONhcPeQbJmnNSdRiosBfW8V
         n4+1drb5GSiPehoXP2dpvcMpZX6wUiEaBDSUAFwBRIoeRcAfDSQEsyTqGjFRw+GWGoWp
         K9tsoL1fwKmcwloOyaQpSsRvEydMY9jei12/lo7BEFVfEBYy5ay2OqM3ZxXnO3cDy+AE
         xn0ffi8AGy/74cibaACmGNCmo+j0WPoomb0DYIr94nQoxRFRFM0Hq4KmY2MPILl+HTuE
         rTMlczgCcFKMPvQAAGTawHu2jrgvdQBcLLlj83pRy2K2Ti342XAKg3Vc83N3sNgXBeM9
         OswQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtUvJbSdmg/n2n+eQr9OY44q9NTN7JNlcf736ZFbumMGV01pnrfmRG6mhymhFZ12EgRlFvTgmfQAJpapg+@vger.kernel.org, AJvYcCXwKySGaD1ze2+Avla30HGy+4Vg3hAXZOwA/9qpBu/QF1RBbFYTDaLedIVMIVdyqQZoYtFLdeH7d3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EIv6TF2QuBwGB9Zk9RaP3/Usu4ikg/iceihdg3SbY4gSA7X3
	9J2T4fDB7jGT3ly/+h+9BY+Mxdlc24bKuJrtCxyomrSLbvPT/HX4CPbHsrwgsOw=
X-Google-Smtp-Source: AGHT+IHNk2Y4KS9JOIrcFQ+dHiEueHwBJReggiYVq6sUBxfVRSCa71e+SaAtYNQku+F0dyDrfM/D7Q==
X-Received: by 2002:a05:622a:1a99:b0:451:9e79:a100 with SMTP id d75a77b69052e-45cadb4f84amr25136951cf.3.1727536174785;
        Sat, 28 Sep 2024 08:09:34 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:34 -0700 (PDT)
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
Subject: [PATCH RFC 08/14] usb: gadget: f_uac2: Add alt mode settings interface
Date: Sat, 28 Sep 2024 11:08:59 -0400
Message-ID: <20240928150905.2616313-9-crwulff@gmail.com>
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
 Documentation/usb/gadget-testing.rst |  21 +-
 drivers/usb/gadget/function/f_uac2.c | 313 ++++++++++++++++++++++++---
 drivers/usb/gadget/function/u_uac2.h |  91 ++++++--
 3 files changed, 379 insertions(+), 46 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 5aaf03cf8ebf..67cae833f246 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -762,7 +762,7 @@ The uac2 function provides these attributes in its function directory:
 	p_volume_max     playback volume control max value (in 1/256 dB)
 	p_volume_res     playback volume control resolution (in 1/256 dB)
 	p_hs_bint        playback bInterval for HS/SS (1-4: fixed, 0: auto)
-	req_number       the number of pre-allocated request for both capture
+	req_number       the number of pre-allocated requests for both capture
 	                 and playback
 	function_name    name of the interface
 	if_ctrl_name     topology control name
@@ -778,10 +778,29 @@ The uac2 function provides these attributes in its function directory:
 	c_fu_vol_name    capture functional unit name
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
 Testing the UAC2 function
 -------------------------
 
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 050789d2d3c9..e9f951215c26 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -19,6 +19,9 @@
 #include "u_uac2.h"
 #include "u_uac_utils.h"
 
+#define HOST_TO_DEVICE 0
+#define DEVICE_TO_HOST 1
+
 /* UAC2 spec: 4.1 Audio Channel Cluster Descriptor */
 #define UAC2_CHANNEL_MASK 0x07FFFFFF
 
@@ -646,29 +649,15 @@ struct cntrl_subrange_lay3 {
 
 DECLARE_UAC2_CNTRL_RANGES_LAY3(srates, UAC_MAX_RATES);
 
-static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_opts *uac2_opts,
+static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_alt_opts *alt_opts,
 	struct usb_endpoint_descriptor *ep_desc,
 	enum usb_device_speed speed, bool is_playback)
 {
-	int chmask, srate, ssize, hs_bint, sync;
-
-	if (is_playback) {
-		chmask = uac2_opts->p_chmask;
-		srate = get_max_srate(uac2_opts->p_srates);
-		ssize = uac2_opts->p_ssize;
-		hs_bint = uac2_opts->p_hs_bint;
-		sync = USB_ENDPOINT_SYNC_ASYNC;
-	} else {
-		chmask = uac2_opts->c_chmask;
-		srate = get_max_srate(uac2_opts->c_srates);
-		ssize = uac2_opts->c_ssize;
-		hs_bint = uac2_opts->c_hs_bint;
-		sync = uac2_opts->c_sync;
-	}
-
 	return uac_set_ep_max_packet_size_bint(
-		dev, ep_desc, speed, is_playback, hs_bint, chmask,
-		srate, ssize, sync, uac2_opts->fb_max);
+		dev, ep_desc, speed, is_playback, alt_opts->hs_bint, alt_opts->chmask,
+		get_max_srate(is_playback ? alt_opts->c.opts->p_srates
+					  : alt_opts->c.opts->c_srates),
+		alt_opts->ssize, alt_opts->sync, alt_opts->c.opts->fb_max);
 }
 
 static struct uac2_feature_unit_descriptor *build_fu_desc(int chmask)
@@ -926,6 +915,57 @@ static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 	return 0;
 }
 
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Configfs alt mode handling
+ */
+
+static void init_alt_0_opts(struct f_uac2_alt_0_opts *alt_0_opts,
+			    struct f_uac2_opts *opts, int playback)
+{
+	alt_0_opts->c.opts = opts;
+	alt_0_opts->c.alt_num = 0;
+
+	// Note: Strings are from the host perspective, opt prefixes are from the device perspective
+	scnprintf(alt_0_opts->name, sizeof(alt_0_opts->name),
+		  (!playback) ? "Playback Inactive" : "Capture Inactive");
+}
+
+static void init_alt_opts(struct f_uac2_alt_opts *alt_opts, struct f_uac2_opts *opts,
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
+	alt_opts->sync = (playback) ? USB_ENDPOINT_SYNC_ASYNC : opts->c_sync; /* only for capture */
+	alt_opts->hs_bint = (playback) ? opts->p_hs_bint : opts->c_hs_bint;
+
+	/* NOTE: These are backwards with relation to other c_/p_ settings in the existing
+	 * userspace API. Correct terminal type is copied into c/p_alt.x
+	 * (eg p_termial_type == c_alt.x/terminal_type)
+	 */
+	alt_opts->terminal_type = (!playback) ? opts->p_terminal_type : opts->c_terminal_type;
+}
+
+
 static int
 afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 {
@@ -938,6 +978,18 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	struct usb_string *us;
 	int ret;
 
+	/* Copy main options to alt modes 0/1 if the groups don't exist
+	 * before validation since they will be checked.
+	 */
+	if (!uac2_opts->c_alt_0_opts.c.group.cg_item.ci_name)
+		init_alt_0_opts(&uac2_opts->c_alt_0_opts, uac2_opts, HOST_TO_DEVICE);
+	if (!uac2_opts->p_alt_0_opts.c.group.cg_item.ci_name)
+		init_alt_0_opts(&uac2_opts->p_alt_0_opts, uac2_opts, DEVICE_TO_HOST);
+	if (!uac2_opts->c_alt_1_opts.c.group.cg_item.ci_name)
+		init_alt_opts(&uac2_opts->c_alt_1_opts, uac2_opts, 1, HOST_TO_DEVICE);
+	if (!uac2_opts->p_alt_1_opts.c.group.cg_item.ci_name)
+		init_alt_opts(&uac2_opts->p_alt_1_opts, uac2_opts, 1, DEVICE_TO_HOST);
+
 	ret = afunc_validate_opts(agdev, dev);
 	if (ret)
 		return ret;
@@ -1109,42 +1161,42 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	ss_epout_desc.bInterval = uac2_opts->c_hs_bint;
 
 	/* Calculate wMaxPacketSize according to audio bandwidth */
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &fs_epin_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &fs_epin_desc,
 					USB_SPEED_FULL, true);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
 
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &fs_epout_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &fs_epout_desc,
 					USB_SPEED_FULL, false);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
 
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &hs_epin_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &hs_epin_desc,
 					USB_SPEED_HIGH, true);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
 
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &hs_epout_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &hs_epout_desc,
 					USB_SPEED_HIGH, false);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
 
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &ss_epin_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->p_alt_1_opts, &ss_epin_desc,
 					USB_SPEED_SUPER, true);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return ret;
 	}
 
-	ret = set_ep_max_packet_size_bint(dev, uac2_opts, &ss_epout_desc,
+	ret = set_ep_max_packet_size_bint(dev, &uac2_opts->c_alt_1_opts, &ss_epout_desc,
 					USB_SPEED_SUPER, false);
 	if (ret < 0) {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
@@ -1773,6 +1825,110 @@ static inline struct f_uac2_opts *to_f_uac2_opts(struct config_item *item)
 			    func_inst.group);
 }
 
+static inline struct f_uac2_alt_opts *to_f_uac2_alt_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_uac2_alt_opts,
+			    c.group);
+}
+
+#define UAC2_ALT_ATTR_TO_OPTS struct f_uac2_alt_opts *alt_opts = to_f_uac2_alt_opts(item)
+#define UAC2_ALT_ATTRIBUTE(type, name)					\
+	UAC_ATTRIBUTE(f_uac2_alt_opts, UAC2_ALT_ATTR_TO_OPTS, alt_opts,	\
+		      alt_opts->c.opts->lock, alt_opts->c.opts->refcnt,	\
+		      type, name)
+
+#define UAC2_ALT_ATTRIBUTE_SYNC(name)					\
+	UAC_ATTRIBUTE_SYNC(f_uac2_alt_opts, UAC2_ALT_ATTR_TO_OPTS,	\
+			   alt_opts, alt_opts->c.opts->lock,		\
+			   alt_opts->c.opts->refcnt, name)
+
+#define UAC2_ALT_ATTRIBUTE_STRING(name)					\
+	UAC_ATTRIBUTE_STRING(f_uac2_alt_opts, UAC2_ALT_ATTR_TO_OPTS,	\
+			     alt_opts, alt_opts->c.opts->lock,		\
+			     alt_opts->c.opts->refcnt, name)
+
+
+UAC2_ALT_ATTRIBUTE_STRING(name);
+UAC2_ALT_ATTRIBUTE_STRING(it_name);
+UAC2_ALT_ATTRIBUTE_STRING(it_ch_name);
+UAC2_ALT_ATTRIBUTE_STRING(ot_name);
+UAC2_ALT_ATTRIBUTE_STRING(fu_vol_name);
+
+UAC2_ALT_ATTRIBUTE(u32, ssize);
+UAC2_ALT_ATTRIBUTE(u32, chmask);
+UAC2_ALT_ATTRIBUTE_SYNC(sync);
+UAC2_ALT_ATTRIBUTE(u8, hs_bint);
+UAC2_ALT_ATTRIBUTE(s16, terminal_type);
+
+static struct configfs_attribute *f_uac2_alt_0_attrs[] = {
+	&f_uac2_alt_opts_attr_name,
+
+	NULL,
+};
+
+static const struct config_item_type alt_mode_0_type = {
+	.ct_attrs	= f_uac2_alt_0_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct configfs_attribute *f_uac2_alt_attrs_c[] = {
+	&f_uac2_alt_opts_attr_name,
+	&f_uac2_alt_opts_attr_it_name,
+	&f_uac2_alt_opts_attr_it_ch_name,
+	&f_uac2_alt_opts_attr_ot_name,
+	&f_uac2_alt_opts_attr_fu_vol_name,
+	&f_uac2_alt_opts_attr_ssize,
+	&f_uac2_alt_opts_attr_chmask,
+	&f_uac2_alt_opts_attr_sync,
+	&f_uac2_alt_opts_attr_hs_bint,
+	&f_uac2_alt_opts_attr_terminal_type,
+
+	NULL,
+};
+
+static struct configfs_attribute *f_uac2_alt_attrs_p[] = {
+	&f_uac2_alt_opts_attr_name,
+	&f_uac2_alt_opts_attr_it_name,
+	&f_uac2_alt_opts_attr_it_ch_name,
+	&f_uac2_alt_opts_attr_ot_name,
+	&f_uac2_alt_opts_attr_fu_vol_name,
+	&f_uac2_alt_opts_attr_ssize,
+	&f_uac2_alt_opts_attr_chmask,
+	/* Playback does not have sync */
+	&f_uac2_alt_opts_attr_hs_bint,
+	&f_uac2_alt_opts_attr_terminal_type,
+
+	NULL,
+};
+
+
+static void f_uac2_alt_attr_release(struct config_item *item)
+{
+	struct f_uac2_alt_opts *alt_opts = to_f_uac2_alt_opts(item);
+
+	/* Opts 0 and 1 are fixed structures, 2+ are kzalloc'd */
+	if (alt_opts->c.alt_num > 1)
+		kfree(alt_opts);
+}
+
+static struct configfs_item_operations f_uac2_alt_item_ops = {
+	.release	= f_uac2_alt_attr_release,
+};
+
+static const struct config_item_type alt_mode_c_type = {
+	.ct_item_ops	= &f_uac2_alt_item_ops,
+	.ct_attrs	= f_uac2_alt_attrs_c,
+	.ct_owner       = THIS_MODULE,
+};
+
+static const struct config_item_type alt_mode_p_type = {
+	.ct_item_ops	= &f_uac2_alt_item_ops,
+	.ct_attrs	= f_uac2_alt_attrs_p,
+	.ct_owner       = THIS_MODULE,
+};
+
+/*-------------------------------------------------------------------------*/
+
 static void f_uac2_attr_release(struct config_item *item)
 {
 	struct f_uac2_opts *opts = to_f_uac2_opts(item);
@@ -1889,8 +2045,111 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 	NULL,
 };
 
+static struct config_group *f_uac2_group_make(
+		struct config_group *group,
+		const char *name)
+{
+	struct f_uac2_opts *opts = to_f_uac2_opts(&group->cg_item);
+	struct f_uac2_alt_opts *alt_opts;
+	struct f_uac2_alt_opts *pos;
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
+		struct f_uac2_alt_0_opts *alt_0_opts = (playback) ? &opts->p_alt_0_opts
+								  : &opts->c_alt_0_opts;
+
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
+			mutex_unlock(&opts->lock);
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
+static void f_uac2_group_drop(struct config_group *group, struct config_item *item)
+{
+	struct f_uac2_alt_opts *alt_opts = to_f_uac2_alt_opts(item);
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
+static struct configfs_group_operations f_uac2_group_ops = {
+	.make_group     = &f_uac2_group_make,
+	.drop_item      = &f_uac2_group_drop,
+};
+
 static const struct config_item_type f_uac2_func_type = {
 	.ct_item_ops	= &f_uac2_item_ops,
+	.ct_group_ops	= &f_uac2_group_ops,
 	.ct_attrs	= f_uac2_attrs,
 	.ct_owner	= THIS_MODULE,
 };
@@ -1914,6 +2173,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	mutex_init(&opts->lock);
 	opts->func_inst.free_func_inst = afunc_free_inst;
 
+	INIT_LIST_HEAD(&opts->c_alt_opts);
+	INIT_LIST_HEAD(&opts->p_alt_opts);
+
 	config_group_init_type_name(&opts->func_inst.group, "",
 				    &f_uac2_func_type);
 
@@ -1947,6 +2209,7 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	scnprintf(opts->clksrc_in_name, sizeof(opts->clksrc_in_name), "Input Clock");
 	scnprintf(opts->clksrc_out_name, sizeof(opts->clksrc_out_name), "Output Clock");
 
+	// Note: Strings are from the host perspective, opt prefixes are from the device perspective
 	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "USBD Out");
 	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Capture Channels");
 	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "USBH In");
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 0df808289ded..8c061e588324 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -40,8 +40,59 @@
 #define UAC2_DEF_C_TERM_TYPE 0x201
 	/* UAC_INPUT_TERMINAL_MICROPHONE*/
 
+struct f_uac2_opts;
+
+struct f_uac2_alt_opts_common {
+	struct config_group	group;
+	struct f_uac2_opts	*opts;
+	u8			alt_num;
+};
+
+/* Alt mode 0 only has a name */
+struct f_uac2_alt_0_opts {
+	struct f_uac2_alt_opts_common c;
+
+	char			name[USB_MAX_STRING_LEN];
+};
+
+/* Alt modes 1+ */
+struct f_uac2_alt_opts {
+	struct f_uac2_alt_opts_common c;
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
+	int			ssize;
+	int			sync;
+	u8			hs_bint;
+	s16			terminal_type;
+
+};
+
 struct f_uac2_opts {
 	struct usb_function_instance	func_inst;
+
+	/* Alt mode 0 options */
+	struct f_uac2_alt_0_opts	c_alt_0_opts;
+	struct f_uac2_alt_0_opts	p_alt_0_opts;
+
+	/* Alt mode 1 options */
+	struct f_uac2_alt_opts		c_alt_1_opts;
+	struct f_uac2_alt_opts		p_alt_1_opts;
+
+	/* Alt mode 2+ options */
+	struct list_head		c_alt_opts;
+	struct list_head		p_alt_opts;
+
+	/* Default options and Alt mode 1 if no c/p_alt.1 created */
 	int				p_chmask;
 	int				p_srates[UAC_MAX_RATES];
 	int				p_ssize;
@@ -52,36 +103,36 @@ struct f_uac2_opts {
 	int				c_sync;
 	u8				c_hs_bint;
 
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
 
 	int				req_number;
 	int				fb_max;
-	bool			bound;
-
-	char			function_name[USB_MAX_STRING_LEN];
-	char			if_ctrl_name[USB_MAX_STRING_LEN];
-	char			clksrc_in_name[USB_MAX_STRING_LEN];
-	char			clksrc_out_name[USB_MAX_STRING_LEN];
-
-	char			p_it_name[USB_MAX_STRING_LEN];
-	char			p_it_ch_name[USB_MAX_STRING_LEN];
-	char			p_ot_name[USB_MAX_STRING_LEN];
-	char			p_fu_vol_name[USB_MAX_STRING_LEN];
-
-	char			c_it_name[USB_MAX_STRING_LEN];
-	char			c_it_ch_name[USB_MAX_STRING_LEN];
-	char			c_ot_name[USB_MAX_STRING_LEN];
-	char			c_fu_vol_name[USB_MAX_STRING_LEN];
+	bool				bound;
+
+	char				function_name[USB_MAX_STRING_LEN];
+	char				if_ctrl_name[USB_MAX_STRING_LEN];
+	char				clksrc_in_name[USB_MAX_STRING_LEN];
+	char				clksrc_out_name[USB_MAX_STRING_LEN];
+
+	char				p_it_name[USB_MAX_STRING_LEN];
+	char				p_it_ch_name[USB_MAX_STRING_LEN];
+	char				p_ot_name[USB_MAX_STRING_LEN];
+	char				p_fu_vol_name[USB_MAX_STRING_LEN];
+
+	char				c_it_name[USB_MAX_STRING_LEN];
+	char				c_it_ch_name[USB_MAX_STRING_LEN];
+	char				c_ot_name[USB_MAX_STRING_LEN];
+	char				c_fu_vol_name[USB_MAX_STRING_LEN];
 
 	s16				p_terminal_type;
 	s16				c_terminal_type;
-- 
2.43.0


