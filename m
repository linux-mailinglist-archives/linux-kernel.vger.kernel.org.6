Return-Path: <linux-kernel+bounces-342521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD7C988FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B892811D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEA187FF1;
	Sat, 28 Sep 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKGGF1Wa"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAC18660A;
	Sat, 28 Sep 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536174; cv=none; b=E2qbIKV9NDFgR2IikFdjcgBDR1drWk79TxCHoNRaYduE6uWCXcsqhoxytOub1yqaHPuuP1B5KbF9qF6UtEfxJK6aEC+RNXWKH63RMyAk1JvKZNK9D56Zp06sdTxLr8ugkcvO6Xe1P+H99MngYa+pn69oQNjshFYlSeHeDKTHm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536174; c=relaxed/simple;
	bh=jR0aK5J1Ve9PA8YKuivBGsnUOqKXfycl/5IT7QgZFCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVHUzcgV42cr/IM+VQMipPPA1jkdKpp8sjz2O3xusWCSnX5fTByT55qdKyjd6Qs5j9wFVzJfNUSwv4MCU7Sj29gfOKPtDD7/3QZ5rIMOhRAA39izZnPbMp9HN/w5vNXZmyPEZVFdv7dcWJJXBa4PS0OLv4RuxBs4pimwtlYvj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKGGF1Wa; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb3eb30527so3001406d6.0;
        Sat, 28 Sep 2024 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536171; x=1728140971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v00na+4yIcf48dJU0rMJdnHmwBuRKAUkLcZ85/QIWus=;
        b=cKGGF1Wa5Z7zzkK3KHx/1Nv0MRgAqhMT3hW0UUz7HEixtm7efMgCBsjA2LMTTvEK80
         WxhkHi0An+iCBQg0itBwSGL8A5kKWaJ7W7OmWHaLFTD0d7sE4+1hsFuejdrDjeZLzCYl
         iVe8twicu0TajCFhunfw/UmabaIevWFhahAJLZWopO0lw1vz4s/fbHyVvYYGAJa+/n6q
         J077Me2lHFLksWG5FueQxBtWXDAjYlTq25ni6H8oWZp34Lb4bbi/w+GhAnvVUX4//sVD
         OLFbPIZ54aINALZ6G89jF1jfaJ26ex1yUvq0mxtXZfhWMjvBfRDYSnm0qaGy4TEz+H+i
         TwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536171; x=1728140971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v00na+4yIcf48dJU0rMJdnHmwBuRKAUkLcZ85/QIWus=;
        b=a9tNSZrOAVc3wCBSgahAdqRa3Jps6833wE6JrxXS1glql4Hw5KU6cJ7N6+X/HsanJ9
         5/DbSQ5TXOF2UAPMalM79k0Dkm2jrQHrcQZYWPEkgN0vkMPga3S4mLJ2S5gBl0qsi9Hs
         Z+N5gtQX2/Agod+ayCLGCAeHONVCxgBLwne3R3KoxB2BcVpACm5/QTRm4zz5LfJHd2Vp
         fAsVmTydOjCCytxxCdQNGp0/Pk8diqZcHQqB5sJ152MM6yCrB1PoTZ+jYxH34TreHDDY
         Z9WEIwuK4sHRZu96m93C6tjQoqmbBwP/BvHvOJu07Z6ni4LZccBkBWX8zHAvZDRfRUX2
         8nSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjENW5dNPxMXobYEB8DAxt1FMH9C9DlBO2wR5gCVDOJV7qIxOB7hXA5bYy/myhO7ro7jilWJyXH0KixZMx@vger.kernel.org, AJvYcCXgFz8egtCF2ffXJUbkIMIoNJ3Ak2T+2QJzJdH/V7MZ9LJg5Ts/FDZ9szuc+dwcrKidwroEbn8Zt9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMDYPu+c5AxbTsWLFIo/gtJo5t92xRaY7UYsTaXaxvmRPo/wd
	VTS1h2XyWcA+TtT7I5QxSzph4KJqwzCfTM1JSnsSQnF6qGBNFOSlAh97LHPy3wE=
X-Google-Smtp-Source: AGHT+IEGXo8oDTDDvCOXGJv7xM790EWRNg5JyvjBDWF0utQ1CmZw1BQOEKAWgQs6J/erPDo4oQ6iGQ==
X-Received: by 2002:a05:622a:24e:b0:458:21b3:284 with SMTP id d75a77b69052e-45cadd4006bmr16664361cf.15.1727536171346;
        Sat, 28 Sep 2024 08:09:31 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:30 -0700 (PDT)
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
Subject: [PATCH RFC 06/14] usb: gadget: f_uac1: Add terminal type attributes
Date: Sat, 28 Sep 2024 11:08:57 -0400
Message-ID: <20240928150905.2616313-7-crwulff@gmail.com>
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

Allow the user to set the terminal types. This matches the options
in f_uac2.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |  2 ++
 Documentation/usb/gadget-testing.rst               |  2 ++
 drivers/usb/gadget/function/f_uac1.c               | 11 +++++++++++
 drivers/usb/gadget/function/u_uac1.h               |  5 +++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index fed8567b10ec..9f7f626329e7 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -43,4 +43,6 @@ Description:
 		c_it_ch_name		capture channels name
 		c_ot_name		capture output terminal name
 		c_fu_vol_name		capture mute/volume functional unit name
+		c_terminal_type		code of the capture terminal type
+		p_terminal_type		code of the playback terminal type
 		=====================	=======================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index bdb82b58b260..53c2518dbf50 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -980,6 +980,8 @@ The uac1 function provides these attributes in its function directory:
 	c_it_ch_name     capture channels name
 	c_ot_name        capture output terminal name
 	c_fu_vol_name    capture mute/volume functional unit name
+	c_terminal_type  code of the capture terminal type
+	p_terminal_type  code of the playback terminal type
 	================ ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 861e6219552e..5813fe3e7146 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1277,6 +1277,8 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
 	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
 
+	io_in_it_desc.wTerminalType = cpu_to_le16(opts->c_terminal_type);
+	io_out_ot_desc.wTerminalType = cpu_to_le16(opts->p_terminal_type);
 	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
 
 	if (EPIN_EN(opts)) {
@@ -1898,6 +1900,9 @@ UAC1_ATTRIBUTE_STRING(c_it_ch_name);
 UAC1_ATTRIBUTE_STRING(c_ot_name);
 UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
 
+UAC1_ATTRIBUTE(s16, p_terminal_type);
+UAC1_ATTRIBUTE(s16, c_terminal_type);
+
 static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_chmask,
 	&f_uac1_opts_attr_c_srate,
@@ -1935,6 +1940,9 @@ static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_ot_name,
 	&f_uac1_opts_attr_c_fu_vol_name,
 
+	&f_uac1_opts_attr_p_terminal_type,
+	&f_uac1_opts_attr_c_terminal_type,
+
 	NULL,
 };
 
@@ -2003,6 +2011,9 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Playback Output terminal");
 	scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Playback Volume");
 
+	opts->p_terminal_type = UAC1_DEF_P_TERM_TYPE;
+	opts->c_terminal_type = UAC1_DEF_C_TERM_TYPE;
+
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index c7e7480bf71f..df29018096d3 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -30,6 +30,8 @@
 #define UAC1_DEF_MAX_DB		0		/* 0 dB */
 #define UAC1_DEF_RES_DB		(1*256)	/* 1 dB */
 
+#define UAC1_DEF_P_TERM_TYPE UAC_INPUT_TERMINAL_MICROPHONE
+#define UAC1_DEF_C_TERM_TYPE UAC_OUTPUT_TERMINAL_SPEAKER
 
 struct f_uac1_opts {
 	struct usb_function_instance	func_inst;
@@ -71,6 +73,9 @@ struct f_uac1_opts {
 	char			c_ot_name[USB_MAX_STRING_LEN];
 	char			c_fu_vol_name[USB_MAX_STRING_LEN];
 
+	s16				p_terminal_type;
+	s16				c_terminal_type;
+
 	struct mutex			lock;
 	int				refcnt;
 };
-- 
2.43.0


