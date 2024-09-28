Return-Path: <linux-kernel+bounces-342520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E053988FE5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36601F21501
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD117C8B;
	Sat, 28 Sep 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkseW/4W"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F884169AE6;
	Sat, 28 Sep 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536171; cv=none; b=XX0tOyKst4PIqx6PIF0vHL2WZItJRJTV06iY/n/dkz+ghB5dcFrCPzJg3MvDQu4FfZkOAnI2tXfBf8W/KN0CnziY/hdzDEN1jPTDK68S3iwNZNd+RNgG4/Rc4jzRfler1lQ+YZ4F6K1X8ExyTWq6S4XH/i2y94sYiqTTJlDM3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536171; c=relaxed/simple;
	bh=AoBAcBCN9g5FrQCnEpiLYuw/boCK8ant09G0B3P6MYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnMONyCozA80pA9Q84SY/enFzmTDSZnNIa161XCG6wHaw+3xR/JgSU5p8X4QQadcDgkrJm4LB9/bCNFPrJ5jb56FOEvn5bvrKPuL+k+BvuxVT1HYgwReWL8mlIjqwCDNVgES7Llwmzfo/kmmGqBpTnqQ9jovFk6Ka0BDWBJqQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkseW/4W; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb3d95ce6eso2590726d6.1;
        Sat, 28 Sep 2024 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536169; x=1728140969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8IRxut/74qoISFME/SEWZ1q6xKA0k5dTsizuBxIsU0=;
        b=HkseW/4Wr27U47qE1DslFqx+cLwrqwdgJi4znK5XXUx5ELGnKC0UBr7dP/enOsu5S8
         ImEwgY4EGplPCVb2fEbpfqpnZKhQrFHos+zPbc5D7/gxnvKQuWAb8wJYOLLiSy2pJTka
         1Vb0sOZJMVFvuyH17k9tQ92NY8ty8LtAuwDhXHD8G+WEf1g5xU6v1gh//F30XfUQHOY7
         Dk86lzRYYCdEdBjZyDJDvjOFK6gT4+Lpt8DuDWwQgANaROkAaQtQItTBRZjSzJh0z0AS
         /esbDe74i8+CyyZjyq6qFR23HxKspVW5iAWe34p6WTQZC1ghNHjUsOeqO9xMNAzb5dcp
         RGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536169; x=1728140969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8IRxut/74qoISFME/SEWZ1q6xKA0k5dTsizuBxIsU0=;
        b=Lu7+Jq1RQ4DF37tLeRnQRUJg7LUXLqvOBGArMDCY4DqQhHRcHkCle7lVP2+ykIowOd
         WiF7dbboWm1vuyiOALcP4cxOGl1Y0Ppfr+xU72hTXeC7uHATJdJzcjGkJ/HV9AJjzcaR
         8eR03RGM+70lpB3AmyBGO9/Eru96KFFqmpfxGLQtLr4sOQh7p67DjLY7qTmFErQpF191
         oXW23DCKk7ME3Cb275g1UOIBSnL/fHhiFK07gLLj/gzk1xlIvfzAMKsMfLsBAQ9uYtrM
         kSQ+9aKrEJHMg2ZfXOKrW7D/O0pqlOVvqJ5oqPnRSklXmwpeBxa73P99p9BCn2Jk6fiE
         bSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUDgQmXzCCxNSj5Jq80Ei+FgakXfl3/xLdrKpY1MNC9Rh5tY5juF6dckyV+cYi4ggXxq2xUiSaLd4Q=@vger.kernel.org, AJvYcCXW/LmJZj6q/FUYzWu+NJRJsykklsPJMtr6a6iB0BMWR3F0+ELXo9TU7ZLGR9dR1NDfJDXK1VnVwYmoovf1@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKDekfw7vPH7Ayh3tFhl8ki4TizwzIFTQfNZKxQlqfjq9DoYK
	5wD9PICQpKVakj++lmc+jb52QKL7Tyfy9cb/AkIdMOwnUyay1l2BBcP/HxnWeM8=
X-Google-Smtp-Source: AGHT+IHqGQU6r8XhBlMDKXXQv6v91Izp4drHo7CON+oRNDupU4Qo0F1r/aOXjVdIbCA/JhLRKO3/bg==
X-Received: by 2002:a05:622a:1998:b0:458:2860:c8f4 with SMTP id d75a77b69052e-45cadb3829emr22131471cf.2.1727536168595;
        Sat, 28 Sep 2024 08:09:28 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:27 -0700 (PDT)
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
Subject: [PATCH RFC 05/14] usb: gadget: f_uac1: Add hs_bint to configfs.
Date: Sat, 28 Sep 2024 11:08:56 -0400
Message-ID: <20240928150905.2616313-6-crwulff@gmail.com>
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

This matches options from f_uac2. This only adds the options but using
it requires additional descriptors added later.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 .../ABI/testing/configfs-usb-gadget-uac1      |  2 +
 Documentation/usb/gadget-testing.rst          |  2 +
 drivers/usb/gadget/function/f_uac1.c          | 89 +++++++++++++++++++
 drivers/usb/gadget/function/u_uac1.h          |  4 +
 4 files changed, 97 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index 758b8c9a988a..fed8567b10ec 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -8,6 +8,7 @@ Description:
 		c_chmask		capture channel mask
 		c_srate			list of capture sampling rates (comma-separated)
 		c_ssize			capture sample size (bytes)
+		c_hs_bint		capture bInterval for HS/SS (1-4: fixed, 0: auto)
 		c_sync			capture synchronization type
 					(async/adaptive)
 		c_mute_present		capture mute control enable
@@ -22,6 +23,7 @@ Description:
 		p_chmask		playback channel mask
 		p_srate			list of playback sampling rates (comma-separated)
 		p_ssize			playback sample size (bytes)
+		p_hs_bint		playback bInterval for HS/SS (1-4: fixed, 0: auto)
 		p_mute_present		playback mute control enable
 		p_volume_present	playback volume control enable
 		p_volume_min		playback volume control min value
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 68fc0011b388..bdb82b58b260 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -958,6 +958,7 @@ The uac1 function provides these attributes in its function directory:
 	c_volume_min     capture volume control min value (in 1/256 dB)
 	c_volume_max     capture volume control max value (in 1/256 dB)
 	c_volume_res     capture volume control resolution (in 1/256 dB)
+	c_hs_bint        capture bInterval for HS/SS (1-4: fixed, 0: auto)
 	fb_max           maximum extra bandwidth in async mode
 	p_chmask         playback channel mask
 	p_srate          list of playback sampling rates (comma-separated)
@@ -967,6 +968,7 @@ The uac1 function provides these attributes in its function directory:
 	p_volume_min     playback volume control min value (in 1/256 dB)
 	p_volume_max     playback volume control max value (in 1/256 dB)
 	p_volume_res     playback volume control resolution (in 1/256 dB)
+	p_hs_bint        playback bInterval for HS/SS (1-4: fixed, 0: auto)
 	req_number       the number of pre-allocated requests for both capture
 	                 and playback
 	function_name    name of the interface
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 84423d9a8bd7..861e6219552e 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1159,6 +1159,32 @@ f_audio_suspend(struct usb_function *f)
 }
 
 /*-------------------------------------------------------------------------*/
+
+static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac1_opts *opts,
+	struct usb_endpoint_descriptor *ep_desc,
+	enum usb_device_speed speed, bool is_playback)
+{
+	int chmask, srate, ssize, hs_bint, sync;
+
+	if (is_playback) {
+		chmask = opts->p_chmask;
+		srate = get_max_srate(opts->p_srates);
+		ssize = opts->p_ssize;
+		hs_bint = opts->p_hs_bint;
+		sync = USB_ENDPOINT_SYNC_ASYNC;
+	} else {
+		chmask = opts->c_chmask;
+		srate = get_max_srate(opts->c_srates);
+		ssize = opts->c_ssize;
+		hs_bint = opts->c_hs_bint;
+		sync = opts->c_sync;
+	}
+
+	return uac_set_ep_max_packet_size_bint(
+		dev, ep_desc, speed, is_playback, hs_bint, chmask,
+		srate, ssize, sync, opts->fb_max);
+}
+
 static struct uac_feature_unit_descriptor *build_fu_desc(int chmask)
 {
 	struct uac_feature_unit_descriptor *fu_desc;
@@ -1419,6 +1445,15 @@ static int f_audio_validate_opts(struct g_audio *audio, struct device *dev)
 		return -EINVAL;
 	}
 
+	if ((opts->p_hs_bint < 0) || (opts->p_hs_bint > 4)) {
+		dev_err(dev, "Error: incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)\n");
+		return -EINVAL;
+	}
+	if ((opts->c_hs_bint < 0) || (opts->c_hs_bint > 4)) {
+		dev_err(dev, "Error: incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1613,6 +1648,54 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		uac1->as_in_alt = 0;
 	}
 
+	hs_as_in_ep_desc.bInterval = audio_opts->p_hs_bint;
+	ss_as_in_ep_desc.bInterval = audio_opts->p_hs_bint;
+	hs_as_out_ep_desc.bInterval = audio_opts->c_hs_bint;
+	ss_as_out_ep_desc.bInterval = audio_opts->c_hs_bint;
+
+	/* Calculate wMaxPacketSize according to audio bandwidth */
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &fs_as_in_ep_desc,
+					     USB_SPEED_FULL, true);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &fs_as_out_ep_desc,
+					     USB_SPEED_FULL, false);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_in_ep_desc,
+					     USB_SPEED_HIGH, true);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_out_ep_desc,
+					     USB_SPEED_HIGH, false);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &ss_as_in_ep_desc,
+					     USB_SPEED_SUPER, true);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
+	status = set_ep_max_packet_size_bint(dev, audio_opts, &hs_as_out_ep_desc,
+					     USB_SPEED_SUPER, false);
+	if (status < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		goto err_free_fu;
+	}
+
 	audio->gadget = gadget;
 
 	status = -ENODEV;
@@ -1782,9 +1865,11 @@ UAC1_ATTRIBUTE(u32, c_chmask);
 UAC1_RATE_ATTRIBUTE(c_srate);
 UAC1_ATTRIBUTE_SYNC(c_sync);
 UAC1_ATTRIBUTE(u32, c_ssize);
+UAC1_ATTRIBUTE(u8, c_hs_bint);
 UAC1_ATTRIBUTE(u32, p_chmask);
 UAC1_RATE_ATTRIBUTE(p_srate);
 UAC1_ATTRIBUTE(u32, p_ssize);
+UAC1_ATTRIBUTE(u8, p_hs_bint);
 UAC1_ATTRIBUTE(u32, req_number);
 
 UAC1_ATTRIBUTE(bool, p_mute_present);
@@ -1818,9 +1903,11 @@ static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_srate,
 	&f_uac1_opts_attr_c_sync,
 	&f_uac1_opts_attr_c_ssize,
+	&f_uac1_opts_attr_c_hs_bint,
 	&f_uac1_opts_attr_p_chmask,
 	&f_uac1_opts_attr_p_srate,
 	&f_uac1_opts_attr_p_ssize,
+	&f_uac1_opts_attr_p_hs_bint,
 	&f_uac1_opts_attr_req_number,
 	&f_uac1_opts_attr_fb_max,
 
@@ -1883,9 +1970,11 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	opts->c_srates[0] = UAC1_DEF_CSRATE;
 	opts->c_sync = UAC1_DEF_CSYNC;
 	opts->c_ssize = UAC1_DEF_CSSIZE;
+	opts->c_hs_bint = UAC1_DEF_CHSBINT;
 	opts->p_chmask = UAC1_DEF_PCHMASK;
 	opts->p_srates[0] = UAC1_DEF_PSRATE;
 	opts->p_ssize = UAC1_DEF_PSSIZE;
+	opts->p_hs_bint = UAC1_DEF_PHSBINT;
 
 	opts->p_mute_present = UAC1_DEF_MUTE_PRESENT;
 	opts->p_volume_present = UAC1_DEF_VOLUME_PRESENT;
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 59eac5ca8114..c7e7480bf71f 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -16,9 +16,11 @@
 #define UAC1_DEF_CSRATE		48000
 #define UAC1_DEF_CSYNC		USB_ENDPOINT_SYNC_ADAPTIVE
 #define UAC1_DEF_CSSIZE		2
+#define UAC1_DEF_CHSBINT	0
 #define UAC1_DEF_PCHMASK	0x3
 #define UAC1_DEF_PSRATE		48000
 #define UAC1_DEF_PSSIZE		2
+#define UAC1_DEF_PHSBINT	0
 #define UAC1_DEF_REQ_NUM	2
 #define UAC1_DEF_INT_REQ_NUM	10
 
@@ -35,9 +37,11 @@ struct f_uac1_opts {
 	int				c_srates[UAC_MAX_RATES];
 	int				c_sync;
 	int				c_ssize;
+	u8				c_hs_bint;
 	int				p_chmask;
 	int				p_srates[UAC_MAX_RATES];
 	int				p_ssize;
+	u8				p_hs_bint;
 
 	bool			p_mute_present;
 	bool			p_volume_present;
-- 
2.43.0


