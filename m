Return-Path: <linux-kernel+bounces-342528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD0988FFB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B1A1F21EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19718C03D;
	Sat, 28 Sep 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv1JbIDI"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97218B46E;
	Sat, 28 Sep 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536190; cv=none; b=tQYibFSw+FNcYEb61LaCXKfSLceHQgRpw2MSUdnbCfeEp6QxFS1MEnytaasfjzbiB9l8UKHOECsfaDwsiXFgZ6B3Mg8WHLy8RXX2Gy8OZAXjiLltAKQJKuyIzfG3OCxJdBD3cfC8TrGrFDOPxlbYTLJH4dZj9ZKc9DxPRt9/kyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536190; c=relaxed/simple;
	bh=ZUHywjTgyAgorv+P4vGuQHmf7hYZIps+djPVQa06mX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSJjbgDZwT+HLbAOcvCOLxcf4HxyqGxw3v88cWP4gHEzv7Zq9z+9okCwyeuZsQuTHXtaML1SWXk18wnrF+So5ZUfjzsCktxk/Vt3Y3f+KcBZXswI6UDcE1c8apgKRGWwmMxxfW1cpaKTdr3SuoG+sBothLnKO+4eAW2TwqnPXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv1JbIDI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cb45ccf4c5so2035576d6.3;
        Sat, 28 Sep 2024 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536186; x=1728140986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQT3vCU4G2dOz3SaAnxPwSTdt0kd5jqB6slZV1QyU88=;
        b=Yv1JbIDIOSGyODmVH8lpfMYXDOSKlD0cegJr/EKwI1GUVfwl9CTps07QVDJcIn78VA
         WP5/76KNqx0Z4nu3DwZP1aFrCi9jEs0CfKpy7hT/3lDPuBZAfmfe0VFn7SnUTfS5szL4
         OSZRBgc9eFPqbtU2axCOktyYawOU2KNuk6ARh5ryjecv/NUvaTrWt249Z39dTI1XCfmM
         6EtFDr/8o/Y/sf20dq/zuhfjJfAFv6JbjKvXmgVyE6u0cM7ZMEdU8vk9roZEH1Y7Q7W0
         ruIoKPl37/bztWZSGpYHsfWQMxYVOF13UzvBrs/iL5rRgeOBhkGAFcdAIwT3XeLOZZu4
         D0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536186; x=1728140986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQT3vCU4G2dOz3SaAnxPwSTdt0kd5jqB6slZV1QyU88=;
        b=BxjH8Yu2ZYXjPg8Q1bAJnlWhH1GBoXeEz69fPWGiH2rRtjZh7ZKfzk/JBvTEdVU9Fy
         wlbGSPkwj7Gs/FmTiS9/GHb269MZcHjl4vNyf7npuqNfosvmGMJ6/ltGlFjpcftoMETr
         razNPP0N9suIDvNJ0ng0ci6DcEF3QgscKilgF8h6zViceBKmYcU+716PDSS7KovBUrwG
         wTJ4Htwb8svua7aEUJY+jl+SCc0Nw5LFbsLLuKVvOxWZE+gFBzKn657d5IJ8/4Vq+DON
         nIMfEXlZf3Q4y6WX91+TOkTImgWrpzMMLKnK2IzSWzwsQ3HlgSPWRTCZOAXdjfMRvoHK
         T35w==
X-Forwarded-Encrypted: i=1; AJvYcCVK11GGKrA7U6RG8x7ByU7SSpL0QLe5uFjG4ePStyllG+Bz9zOOFujfEWk0cp5focddjbIKrssMN64=@vger.kernel.org, AJvYcCXXFOcfyy7WCwNCtVf+veKOmViuI58scbaHmPZE2plLNu/pbYAcsmGA5gTxXHFIIG1halfjJ6jYLtxkGAKW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6c0ZPAx5vupGLlCV7kA+BFrU4OTF6XjpWhsajTLt82Kk0A6S0
	6hU4GCWmV27f73bZKh4VFjBM8tYimyGX3k0S1f0wy6Q1maTodIw+TOTCbGY64AY=
X-Google-Smtp-Source: AGHT+IFQPNxvBusz5TCd3f3HKa/fc1BQS4PC55vb99SfY9Er2er5hhcHT8wjNS27/JRFfXhMpTHcnw==
X-Received: by 2002:a05:620a:191f:b0:7a9:b52a:a6db with SMTP id af79cd13be357-7ae40613946mr196687585a.7.1727536186227;
        Sat, 28 Sep 2024 08:09:46 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:45 -0700 (PDT)
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
Subject: [PATCH RFC 13/14] usb: gadget: f_uac1: support ganged volume/mute controls
Date: Sat, 28 Sep 2024 11:09:04 -0400
Message-ID: <20240928150905.2616313-14-crwulff@gmail.com>
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

When multiple feature units exist due to differences
in other terminal descriptors, they still represent
the same volume/mute controls.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c | 186 ++++++++++++++++++++-------
 1 file changed, 136 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 7803957e4f82..c29cbe4cea14 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -27,8 +27,7 @@
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
 
-#define USB_OUT_FU_ID(_opts)	(_opts->c_alt_1_opts.fu_id)
-#define USB_IN_FU_ID(_opts)	(_opts->p_alt_1_opts.fu_id)
+#define USB_FU_ID(_alt_opts) ((_alt_opts) ? (_alt_opts)->fu_id : 0)
 
 #define EP_EN(_alt_opts) ((_alt_opts) && ((_alt_opts)->chmask != 0))
 #define FUIN_EN(_opts) ((_opts)->p_mute_present \
@@ -83,6 +82,25 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
 	return container_of(audio->func.fi, struct f_uac1_opts, func_inst);
 }
 
+static inline struct f_uac1_alt_opts *get_alt_opts(struct f_uac1_opts *opts, int alt, int dir)
+{
+	struct f_uac1_alt_opts *alt_opts;
+
+	if (alt == 0)
+		return NULL;
+
+	if (alt == 1)
+		return (dir == HOST_TO_DEVICE) ? &opts->c_alt_1_opts : &opts->p_alt_1_opts;
+
+	list_for_each_entry(alt_opts, (dir == HOST_TO_DEVICE) ? &opts->c_alt_opts
+							      : &opts->p_alt_opts, list) {
+		if (alt_opts->c.alt_num == alt)
+			return alt_opts;
+	}
+
+	return NULL;
+}
+
 /*
  * DESCRIPTORS ... most are static, but strings and full
  * configuration descriptors are built on demand.
@@ -244,16 +262,53 @@ static void audio_notify_complete(struct usb_ep *_ep, struct usb_request *req)
 	usb_ep_free_request(_ep, req);
 }
 
-static int audio_notify(struct g_audio *audio, int unit_id, int cs)
+static int audio_notify_one(struct g_audio *audio, int unit_id, int cs);
+
+static int audio_notify_multiple(struct g_audio *audio, int unit_id, int cs, int source_id)
 {
 	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
-	struct usb_request *req;
-	struct uac1_status_word *msg;
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
 	int ret;
+	struct f_uac1_alt_opts *alt_opts;
+	struct list_head *alt_opts_list;
 
 	if (!uac1->int_ep->enabled)
 		return 0;
 
+	if (unit_id != source_id) {
+		ret = audio_notify_one(audio, unit_id, cs);
+		if (ret)
+			return ret;
+	}
+
+	alt_opts_list = (unit_id == USB_FU_ID(&opts->c_alt_1_opts)) ? &opts->c_alt_opts
+								    : &opts->p_alt_opts;
+
+	/* Notify all other ganged controls */
+	list_for_each_entry(alt_opts, alt_opts_list, list) {
+		if ((USB_FU_ID(alt_opts) > unit_id) && (USB_FU_ID(alt_opts) != source_id)) {
+			unit_id = USB_FU_ID(alt_opts);
+			ret = audio_notify_one(audio, unit_id, cs);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int audio_notify(struct g_audio *audio, int unit_id, int cs)
+{
+	return audio_notify_multiple(audio, unit_id, cs, 0);
+}
+
+static int audio_notify_one(struct g_audio *audio, int unit_id, int cs)
+{
+	struct f_uac1 *uac1 = func_to_uac1(&audio->func);
+	struct usb_request *req;
+	struct uac1_status_word *msg;
+	int ret;
+
 	if (atomic_inc_return(&uac1->int_count) > UAC1_DEF_INT_REQ_NUM) {
 		atomic_dec(&uac1->int_count);
 		return 0;
@@ -297,6 +352,40 @@ static int audio_notify(struct g_audio *audio, int unit_id, int cs)
 	return ret;
 }
 
+static struct f_uac1_alt_opts *
+find_feature_unit(struct f_uac1_opts *opts, u8 entity_id, int *is_playback)
+{
+	struct f_uac1_alt_opts *alt_opts;
+
+	if (FUOUT_EN(opts)) {
+		if (is_playback)
+			*is_playback = 0;
+
+		if (entity_id == USB_FU_ID(&opts->c_alt_1_opts))
+			return &opts->c_alt_1_opts;
+
+		list_for_each_entry(alt_opts, &opts->c_alt_opts, list) {
+			if (entity_id == USB_FU_ID(alt_opts))
+				return alt_opts;
+		}
+	}
+
+	if (FUIN_EN(opts)) {
+		if (is_playback)
+			*is_playback = 1;
+
+		if (entity_id == USB_FU_ID(&opts->p_alt_1_opts))
+			return &opts->p_alt_1_opts;
+
+		list_for_each_entry(alt_opts, &opts->p_alt_opts, list) {
+			if (entity_id == USB_FU_ID(alt_opts))
+				return alt_opts;
+		}
+	}
+
+	return NULL;
+}
+
 static int
 in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 {
@@ -309,14 +398,10 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
+	unsigned int is_playback = 0;
+	struct f_uac1_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_MUTE) {
 			unsigned int mute;
 
@@ -360,14 +445,10 @@ in_rq_min(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
+	unsigned int is_playback = 0;
+	struct f_uac1_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_VOLUME) {
 			__le16 r;
 			s16 min_db;
@@ -407,14 +488,10 @@ in_rq_max(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
+	unsigned int is_playback = 0;
+	struct f_uac1_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_VOLUME) {
 			__le16 r;
 			s16 max_db;
@@ -454,14 +531,10 @@ in_rq_res(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
+	unsigned int is_playback = 0;
+	struct f_uac1_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_VOLUME) {
 			__le16 r;
 			s16 res_db;
@@ -501,24 +574,25 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 	u16 w_value = le16_to_cpu(cr->wValue);
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
+	unsigned int is_playback = 0;
+	struct f_uac1_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
 	if (req->status != 0) {
 		dev_dbg(&cdev->gadget->dev, "completion err %d\n", req->status);
 		return;
 	}
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_MUTE) {
 			u8 mute = *(u8 *)req->buf;
 
 			u_audio_set_mute(audio, is_playback, mute);
 
+			/* We also need to send notify for ganged controls */
+			audio_notify_multiple(audio, USB_FU_ID(is_playback ? &opts->p_alt_1_opts
+									   : &opts->c_alt_1_opts),
+					      control_selector, entity_id);
+
 			return;
 		} else if (control_selector == UAC_FU_VOLUME) {
 			__le16 *c = req->buf;
@@ -527,6 +601,11 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 			volume = le16_to_cpu(*c);
 			u_audio_set_volume(audio, is_playback, volume);
 
+			/* We also need to send notify for ganged controls */
+			audio_notify_multiple(audio, USB_FU_ID(is_playback ? &opts->p_alt_1_opts
+									   : &opts->c_alt_1_opts),
+					      control_selector, entity_id);
+
 			return;
 		} else {
 			dev_err(&audio->gadget->dev,
@@ -556,8 +635,7 @@ out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
+	if (find_feature_unit(opts, entity_id, NULL)) {
 		memcpy(&uac1->setup_cr, cr, sizeof(*cr));
 		req->context = audio;
 		req->complete = out_rq_cur_complete;
@@ -751,14 +829,10 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	struct device *dev = &gadget->dev;
 	struct g_audio *audio = func_to_g_audio(f);
 	struct f_uac1 *uac1 = func_to_uac1(f);
+	struct f_uac1_opts *opts = g_audio_to_uac1_opts(audio);
+	struct f_uac1_alt_opts *alt_opts = NULL;
 	int ret = 0;
 
-	/* No i/f has more than 2 alt settings */
-	if (alt > 1) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return -EINVAL;
-	}
-
 	if (intf == uac1->ac_intf) {
 		/* Control I/f has only 1 AltSetting - 0 */
 		if (alt) {
@@ -777,6 +851,12 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	}
 
 	if (intf == uac1->as_out_intf) {
+		alt_opts = get_alt_opts(opts, alt, HOST_TO_DEVICE);
+		if (alt && !alt_opts) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			return -EINVAL;
+		}
+
 		uac1->as_out_alt = alt;
 
 		if (alt)
@@ -784,6 +864,12 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		else
 			u_audio_stop_capture(&uac1->g_audio);
 	} else if (intf == uac1->as_in_intf) {
+		alt_opts = get_alt_opts(opts, alt, DEVICE_TO_HOST);
+		if (alt && !alt_opts) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			return -EINVAL;
+		}
+
 		uac1->as_in_alt = alt;
 
 		if (alt)
@@ -1841,7 +1927,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	audio->params.c_ssize = audio_opts->c_ssize;
 
 	if (FUIN_EN(audio_opts)) {
-		audio->params.p_fu.id = USB_IN_FU_ID(audio_opts);
+		audio->params.p_fu.id = USB_FU_ID(&audio_opts->p_alt_1_opts);
 		audio->params.p_fu.mute_present = audio_opts->p_mute_present;
 		audio->params.p_fu.volume_present =
 				audio_opts->p_volume_present;
@@ -1857,7 +1943,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	audio->params.p_ssize = audio_opts->p_ssize;
 
 	if (FUOUT_EN(audio_opts)) {
-		audio->params.c_fu.id = USB_OUT_FU_ID(audio_opts);
+		audio->params.c_fu.id = USB_FU_ID(&audio_opts->c_alt_1_opts);
 		audio->params.c_fu.mute_present = audio_opts->c_mute_present;
 		audio->params.c_fu.volume_present =
 				audio_opts->c_volume_present;
-- 
2.43.0


