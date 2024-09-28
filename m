Return-Path: <linux-kernel+bounces-342529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43141989000
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B041F21145
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65A18CBFE;
	Sat, 28 Sep 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krL+FYxR"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DA18BC36;
	Sat, 28 Sep 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536192; cv=none; b=K1JGq3S/OEBd89d0zVE2aAXhPVvkqL2Qu6PCs7Sih6/9vBfYUlslCmdgqaxqIu76gjQW3yQGB4F1+5Dkmll2DeceuVGx5XhVbr8raLohL7hAoDskG9WTFNHcVtkEAaoVD9n9k1o/YK/sU2RL/VsjcJRxla311PJ6vXRFXFbzbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536192; c=relaxed/simple;
	bh=Fy6I94nc+1V40lt4e3qFmMV5zy3ba9bIWTfNuWdiaY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjzBabNzqhphU+NuK1OqDHJsHStEhncvaDLIw5SQP/0ictRdaSgInvYdP1t/gJpTUbOh+EDBOtBc290oCcsmLlwyOW4K4F48z4FTODgvjIKWa6pgaA4iCEAKBXAPrFxG/e84a7GNUNowQMxbCrctBC6LDJzTQkzLnIGxjUgmnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krL+FYxR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb3648c894so3835496d6.2;
        Sat, 28 Sep 2024 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536189; x=1728140989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38DUzai26Am3YIcMwNP/ofkUCUtRlhDt+jxJLAqbPNA=;
        b=krL+FYxR5ZOOkyw42Utar2qRTea4uqemJIh7bjMu3CsLdwdVh/te6vjUmehTYlQNgI
         t/2oyu3HjzMSlBmtXapJBUV1tDRHZsKCHyR2CVFuPTMiWoFhDPsDbZl4nBnd9VwNQjR9
         VfZE/H2KRwWBFopOwbMAJ7xXBp7rVUdLaMwrs2nsBHLaEGg+pAn3Dr/K4dHaaRZCWE6A
         AjQeh4IRMvL/rDDJpr5U3/qa1/5wjAPmkayAJVB4K/7z1eJREAgES7uR5oIF2QF/4i89
         WpaRhZczrEjXAy5/PZhzvVUFeDBzxS8uHnuq+crl9M4UupzlBn94mJT947/FEQpNUNZs
         macw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536189; x=1728140989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38DUzai26Am3YIcMwNP/ofkUCUtRlhDt+jxJLAqbPNA=;
        b=Wgmor88zv/iptX1AmXDErP3ZaotUjfxo2Vhn0u4KUG4Z1kw6zEGM3PHWw3Dd8+yUH4
         vMZXTPxh9QLj8OKH0fCZ0oUEKneVmU0ppUEQ/JCsXOWfCX8Jpcp2h5iL5qCkfUosjvm8
         saJ7ZTPo0z4YADxmy6usTLVABXH8CI64kkGKvMcIennKjz94VifrRPpLfWCx+pdwDyDu
         iqk3twxZVVweR+7XQEeOJly5vIbsmvPpo7mtN/ffUTl18vVYLar4007tIXXBhJ49Y7MU
         83CsvZN1i54yjW5xYRC/zC++K5ef1eYXXIpsJjRK9uYU53mUu2mE+JLqOk/wmGtkJ7AM
         PjtA==
X-Forwarded-Encrypted: i=1; AJvYcCW7khrH6+vjs8uZ+LKZoAJcExAVU8UbeOw9d/PtKJdpLBrqYdn/kD5+Ygas2BDz3zMKEAK/7ywStw4=@vger.kernel.org, AJvYcCXyyW4FpZuDkTEe3h+HEyBQ7KYdSl/mjkuwmCIVc4Ol1M72GOwAYbEYie5y97OwZr6GE0G6aPhmOMH6n3cf@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7zzBUNRrFdZVIzYQ1IY9OkAbPc03DRHTpdRcSkGlyNoblR45
	GRCE7/xhvEeNmRBH9+pdGUxBAToCtEJTuzik0Nixy5ZpzBgwPh3CSBOD+9hCN3k=
X-Google-Smtp-Source: AGHT+IGqLS0ZiLea/j1PV95EuAVVUKMwBls8xzYkV1BXHKzipBM57ZI3/j/tBdo2wggi+jpEorORMw==
X-Received: by 2002:a05:622a:146:b0:458:21b2:4904 with SMTP id d75a77b69052e-45cadd38a2bmr18009661cf.14.1727536188916;
        Sat, 28 Sep 2024 08:09:48 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:47 -0700 (PDT)
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
Subject: [PATCH RFC 14/14] usb: gadget: f_uac2: support ganged volume/mute controls
Date: Sat, 28 Sep 2024 11:09:05 -0400
Message-ID: <20240928150905.2616313-15-crwulff@gmail.com>
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
 drivers/usb/gadget/function/f_uac2.c | 171 +++++++++++++++++++++------
 1 file changed, 133 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index c30fbd062793..427a95b043db 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -35,8 +35,8 @@
  */
 #define USB_OUT_CLK_ID	(out_clk_src_desc.bClockID)
 #define USB_IN_CLK_ID	(in_clk_src_desc.bClockID)
-#define USB_OUT_FU_ID(_opts)	(_opts->c_alt_1_opts.fu_id)
-#define USB_IN_FU_ID(_opts)	(_opts->p_alt_1_opts.fu_id)
+#define USB_FU_ID(_alt_opts) ((_alt_opts) ? (_alt_opts)->fu_id : 0)
+
 
 #define CONTROL_ABSENT	0
 #define CONTROL_RDONLY	1
@@ -54,7 +54,6 @@
 #define UNFLW_CTRL	8
 #define OVFLW_CTRL	10
 
-
 #define EP_EN(_alt_opts) ((_alt_opts) && ((_alt_opts)->chmask != 0))
 #define FUIN_EN(_opts) (EP_EN(&_opts->p_alt_1_opts) \
 				&& ((_opts)->p_mute_present \
@@ -112,6 +111,59 @@ struct f_uac2_opts *g_audio_to_uac2_opts(struct g_audio *agdev)
 
 static int afunc_notify(struct g_audio *agdev, int unit_id, int cs);
 
+static inline struct f_uac2_alt_opts *get_alt_opts(struct f_uac2_opts *opts, int alt, int dir)
+{
+	struct f_uac2_alt_opts *alt_opts;
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
+static struct f_uac2_alt_opts *
+find_feature_unit(struct f_uac2_opts *opts, u8 entity_id, int *is_playback)
+{
+	struct f_uac2_alt_opts *alt_opts;
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
 /* --------- USB Function Interface ------------- */
 
 static struct usb_interface_assoc_descriptor iad_desc = {
@@ -1243,7 +1295,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	agdev->params.p_ssize = uac2_opts->p_ssize;
 
 	if (FUIN_EN(uac2_opts)) {
-		agdev->params.p_fu.id = USB_IN_FU_ID(uac2_opts);
+		agdev->params.p_fu.id = USB_FU_ID(&uac2_opts->p_alt_1_opts);
 		agdev->params.p_fu.mute_present = uac2_opts->p_mute_present;
 		agdev->params.p_fu.volume_present = uac2_opts->p_volume_present;
 		agdev->params.p_fu.volume_min = uac2_opts->p_volume_min;
@@ -1258,7 +1310,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	agdev->params.c_ssize = uac2_opts->c_ssize;
 
 	if (FUOUT_EN(uac2_opts)) {
-		agdev->params.c_fu.id = USB_OUT_FU_ID(uac2_opts);
+		agdev->params.c_fu.id = USB_FU_ID(&uac2_opts->c_alt_1_opts);
 		agdev->params.c_fu.mute_present = uac2_opts->c_mute_present;
 		agdev->params.c_fu.volume_present = uac2_opts->c_volume_present;
 		agdev->params.c_fu.volume_min = uac2_opts->c_volume_min;
@@ -1295,8 +1347,49 @@ afunc_notify_complete(struct usb_ep *_ep, struct usb_request *req)
 	usb_ep_free_request(_ep, req);
 }
 
+static int afunc_notify_one(struct g_audio *agdev, int unit_id, int cs);
+
+static int afunc_notify_multiple(struct g_audio *agdev, int unit_id, int cs, int source_id)
+{
+	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	int ret;
+	struct f_uac2_alt_opts *alt_opts;
+	struct list_head *alt_opts_list;
+
+	if (!uac2->int_ep->enabled)
+		return 0;
+
+	if (unit_id != source_id) {
+		ret = afunc_notify_one(agdev, unit_id, cs);
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
+			ret = afunc_notify_one(agdev, unit_id, cs);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int
 afunc_notify(struct g_audio *agdev, int unit_id, int cs)
+{
+	return afunc_notify_multiple(agdev, unit_id, cs, 0);
+}
+
+static int
+afunc_notify_one(struct g_audio *agdev, int unit_id, int cs)
 {
 	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
 	struct usb_request *req;
@@ -1304,9 +1397,6 @@ afunc_notify(struct g_audio *agdev, int unit_id, int cs)
 	u16 w_index, w_value;
 	int ret;
 
-	if (!uac2->int_ep->enabled)
-		return 0;
-
 	if (atomic_inc_return(&uac2->int_count) > UAC2_DEF_INT_REQ_NUM) {
 		atomic_dec(&uac2->int_count);
 		return 0;
@@ -1360,16 +1450,12 @@ afunc_set_alt(struct usb_function *fn, unsigned int intf, unsigned int alt)
 	struct usb_composite_dev *cdev = fn->config->cdev;
 	struct f_uac2 *uac2 = func_to_uac2(fn);
 	struct g_audio *agdev = func_to_g_audio(fn);
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
+	struct f_uac2_alt_opts *alt_opts = NULL;
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
 	int ret = 0;
 
-	/* No i/f has more than 2 alt settings */
-	if (alt > 1) {
-		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
-		return -EINVAL;
-	}
-
 	if (intf == uac2->ac_intf) {
 		/* Control I/f has only 1 AltSetting - 0 */
 		if (alt) {
@@ -1388,6 +1474,12 @@ afunc_set_alt(struct usb_function *fn, unsigned int intf, unsigned int alt)
 	}
 
 	if (intf == uac2->as_out_intf) {
+		alt_opts = get_alt_opts(opts, alt, HOST_TO_DEVICE);
+		if (alt && !alt_opts) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			return -EINVAL;
+		}
+
 		uac2->as_out_alt = alt;
 
 		if (alt)
@@ -1395,6 +1487,12 @@ afunc_set_alt(struct usb_function *fn, unsigned int intf, unsigned int alt)
 		else
 			u_audio_stop_capture(&uac2->g_audio);
 	} else if (intf == uac2->as_in_intf) {
+		alt_opts = get_alt_opts(opts, alt, DEVICE_TO_HOST);
+		if (alt && !alt_opts) {
+			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+			return -EINVAL;
+		}
+
 		uac2->as_in_alt = alt;
 
 		if (alt)
@@ -1463,6 +1561,8 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
 	u32 p_srate, c_srate;
+	unsigned int is_playback = 0;
+	struct f_uac2_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
 	u_audio_get_playback_srate(agdev, &p_srate);
 	u_audio_get_capture_srate(agdev, &c_srate);
@@ -1488,13 +1588,7 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 				"%s:%d control_selector=%d TODO!\n",
 				__func__, __LINE__, control_selector);
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	} else if (alt_opts) {
 		if (control_selector == UAC_FU_MUTE) {
 			unsigned int mute;
 
@@ -1539,6 +1633,8 @@ in_rq_range(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
 	int value = -EOPNOTSUPP;
+	unsigned int is_playback = 0;
+	struct f_uac2_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
 	if ((entity_id == USB_IN_CLK_ID) || (entity_id == USB_OUT_CLK_ID)) {
 		if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
@@ -1577,13 +1673,7 @@ in_rq_range(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 				"%s:%d control_selector=%d TODO!\n",
 				__func__, __LINE__, control_selector);
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	} else if (alt_opts) {
 		if (control_selector == UAC_FU_VOLUME) {
 			struct cntrl_range_lay2 r;
 			s16 max_db, min_db, res_db;
@@ -1654,31 +1744,32 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct g_audio *agdev = req->context;
 	struct usb_composite_dev *cdev = agdev->func.config->cdev;
-	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
 	struct f_uac2 *uac2 = func_to_uac2(&agdev->func);
+	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
 	struct usb_ctrlrequest *cr = &uac2->setup_cr;
 	u16 w_index = le16_to_cpu(cr->wIndex);
 	u16 w_value = le16_to_cpu(cr->wValue);
 	u8 entity_id = (w_index >> 8) & 0xff;
 	u8 control_selector = w_value >> 8;
+	unsigned int is_playback;
+	struct f_uac2_alt_opts *alt_opts = find_feature_unit(opts, entity_id, &is_playback);
 
 	if (req->status != 0) {
 		dev_dbg(&cdev->gadget->dev, "completion err %d\n", req->status);
 		return;
 	}
 
-	if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-		(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
-		unsigned int is_playback = 0;
-
-		if (FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts)))
-			is_playback = 1;
-
+	if (alt_opts) {
 		if (control_selector == UAC_FU_MUTE) {
 			u8 mute = *(u8 *)req->buf;
 
 			u_audio_set_mute(agdev, is_playback, mute);
 
+			/* We also need to send notify for ganged controls */
+			afunc_notify_multiple(agdev, USB_FU_ID(is_playback ? &opts->p_alt_1_opts
+									   : &opts->c_alt_1_opts),
+					      control_selector, entity_id);
+
 			return;
 		} else if (control_selector == UAC_FU_VOLUME) {
 			struct cntrl_cur_lay2 *c = req->buf;
@@ -1687,6 +1778,11 @@ out_rq_cur_complete(struct usb_ep *ep, struct usb_request *req)
 			volume = le16_to_cpu(c->wCUR);
 			u_audio_set_volume(agdev, is_playback, volume);
 
+			/* We also need to send notify for ganged controls */
+			afunc_notify_multiple(agdev, USB_FU_ID(is_playback ? &opts->p_alt_1_opts
+									   : &opts->c_alt_1_opts),
+					      control_selector, entity_id);
+
 			return;
 		} else {
 			dev_err(&agdev->gadget->dev,
@@ -1721,8 +1817,7 @@ out_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 			req->complete = uac2_cs_control_sam_freq;
 			return w_length;
 		}
-	} else if ((FUIN_EN(opts) && (entity_id == USB_IN_FU_ID(opts))) ||
-			(FUOUT_EN(opts) && (entity_id == USB_OUT_FU_ID(opts)))) {
+	} else if (find_feature_unit(opts, entity_id, NULL)) {
 		memcpy(&uac2->setup_cr, cr, sizeof(*cr));
 		req->context = agdev;
 		req->complete = out_rq_cur_complete;
-- 
2.43.0


