Return-Path: <linux-kernel+bounces-273613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB0946B7B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 01:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4986E1C20D3E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE8136350;
	Sat,  3 Aug 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2WBe8+M"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8A14A84;
	Sat,  3 Aug 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722727663; cv=none; b=YY/lCErtMk5tcgvmy3u4RXhEFtnyS7LIz09PCnSoW/y/GoRVRsOwb/Q6uNfmyjTasjoIGxbpVG4UKnMm/2kAKM5Fh+UKkVmqr8s1hwa0bEVgY8Q25ntsIbFAi1uz5TgAHRJCqN5XNqkxShaxqZue5wdrj26ImR2GBrAu6IPqOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722727663; c=relaxed/simple;
	bh=83DAMHP7BGG2MxiUrYg6sSbaR2HOIIk+TkMDUC9OQ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/0RWpN2miZGnOf8tYPXOMDmrBgRaKm/zgrkKMaHMUmqCcZwLtSP71YBoVYTJicnnqOMY8Y+rXR1FQzPoz2Qj1n7sSOP4h2tX6m29WsOrBK+vKgFVpJielgNvI0IV7HdrGYnNBohMifC/dsY8hq/lNLzJkCvSVxij5tTbs/CdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2WBe8+M; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so38565026d6.1;
        Sat, 03 Aug 2024 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722727660; x=1723332460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0r0sIPDyVdCafsikVC8Nr/2IBMQyfckS7+b2MfdBds=;
        b=h2WBe8+MW9vk2+7CBy3A69AaIVAmaHQPOy3mm3X8fkR0PSeDKfVEDC9eWIPY6fORGS
         oAXQUznpLxN61keYTW5RIKaTdIhzhlEOfdDJsbPNIPOSqYhVEI3Uomh9r1mg0wAvRyi6
         D/WcslmkYj688Yw8QBqYgReYrA8bg6aKRKzEJDGZ841I5/bUYg+qxU6whPC+IRajxYVV
         8Q+w/0+Ti4XDn9709N8ayzrErjqNpvAGiE7z5kTR+AFHu3kZKCfPUf5/H2n/FjDsY1c0
         W4X4IWYZvrRodYnmZVsH8kh7AD0ZeCVHLG2E4CiMXVuQiTiuON1qpTa5V7ISnHpMEV6/
         0uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722727660; x=1723332460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0r0sIPDyVdCafsikVC8Nr/2IBMQyfckS7+b2MfdBds=;
        b=jRSVhhnXESSP55oGtC2j7PTIWJw/bI3kvm9TmQ9DWAyve7MkC88smD3KxJtbUKsCL3
         p8Yd8jwoxFmBjARduUcbCXv5IecPfdTxfjcSgNQXYDbgOnwWRkqIh1AYNoqDzcTUgi8s
         f+pVMAhDqggpoEh0r9whr6ei4KS7PoDfJNo8g2RrYVtr5XIy88F00J5cedS5/Quq47ra
         1yL7pOgXC8coJzLpuVTcfTQDWYeP46Li6ZxVqdLD+FwK+uyXUm38k4r6I5dMV4PQoLwQ
         XFIFFvJBHk/A63heL3qZ0+qSGo9b3GZTiPezcte8Fy+uEEfapwVAWTUAWc5HavXwCv8+
         0IIw==
X-Forwarded-Encrypted: i=1; AJvYcCWO6fEpliuUMPfiV+3pEvubij1GHDR/aoTcuVy64b6mw/oZFrAdSSsN1eRrl73VFd1X7t2uPmxrKGyvQGw3qRACFKPyrX+CORDqEFeD
X-Gm-Message-State: AOJu0YyaGIRIjuUUCNgMNPKO6RF7SmZL3E5KPKdyfWBGHTd3tEZOa8Yo
	IZlPwMtDCAjd1zeHLyrE4j9k5462105lonLiP7Esc0R1bTxbS2T7V9NAsw==
X-Google-Smtp-Source: AGHT+IGoyQHPwclH7cy8lnrM1d4NqthlwOgWGzvxp28sHFIal1zMwQ2OSSiINymLvJFfMK1qUCXT3w==
X-Received: by 2002:a05:6214:5c4a:b0:6bb:53aa:46e8 with SMTP id 6a1803df08f44-6bb986df5f4mr134662386d6.10.1722727659713;
        Sat, 03 Aug 2024 16:27:39 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78b0a6sm20659556d6.32.2024.08.03.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 16:27:39 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Perr Zhang <perr@usb7.net>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH v2] usb: gadget: f_uac1: Change volume name and remove alt names
Date: Sat,  3 Aug 2024 19:27:23 -0400
Message-ID: <20240803232722.3220995-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <crwulff@gmail.com>

This changes the UAPI to align with disussion of alt settings work.

fu_name is renamed to fu_vol_name, and alt settings mode names
are removed for now in favor of future work where they will be
settable in subdirectories for each alt mode.

discussion thread for api changes for alt mode settings:
https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
v2: Moved discussion thread tidbit into commit message
v1: https://lore.kernel.org/all/20240803155215.2746444-2-crwulff@gmail.com/
---
 .../ABI/testing/configfs-usb-gadget-uac1      |  8 ++---
 Documentation/usb/gadget-testing.rst          |  8 ++---
 drivers/usb/gadget/function/f_uac1.c          | 36 +++++++------------
 drivers/usb/gadget/function/u_uac1.h          |  8 ++---
 4 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
index cf93b98b274d..64188a85592b 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
@@ -33,13 +33,9 @@ Description:
 		p_it_name		playback input terminal name
 		p_it_ch_name		playback channels name
 		p_ot_name		playback output terminal name
-		p_fu_name		playback functional unit name
-		p_alt0_name		playback alt mode 0 name
-		p_alt1_name		playback alt mode 1 name
+		p_fu_vol_name		playback mute/volume functional unit name
 		c_it_name		capture input terminal name
 		c_it_ch_name		capture channels name
 		c_ot_name		capture output terminal name
-		c_fu_name		capture functional unit name
-		c_alt0_name		capture alt mode 0 name
-		c_alt1_name		capture alt mode 1 name
+		c_fu_vol_name		capture mute/volume functional unit name
 		=====================	=======================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index a89b49e639c3..7a94490fb2fd 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -960,15 +960,11 @@ The uac1 function provides these attributes in its function directory:
 	p_it_name        playback input terminal name
 	p_it_ch_name     playback channels name
 	p_ot_name        playback output terminal name
-	p_fu_name        playback functional unit name
-	p_alt0_name      playback alt mode 0 name
-	p_alt1_name      playback alt mode 1 name
+	p_fu_vol_name    playback mute/volume functional unit name
 	c_it_name        capture input terminal name
 	c_it_ch_name     capture channels name
 	c_ot_name        capture output terminal name
-	c_fu_name        capture functional unit name
-	c_alt0_name      capture alt mode 0 name
-	c_alt1_name      capture alt mode 1 name
+	c_fu_vol_name    capture mute/volume functional unit name
 	================ ====================================================
 
 The attributes have sane default values.
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 06a220fb7a87..bb36ce2be569 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1254,16 +1254,16 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	strings_uac1[STR_USB_OUT_IT].s = audio_opts->p_it_name;
 	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s = audio_opts->p_it_ch_name;
 	strings_uac1[STR_IO_OUT_OT].s = audio_opts->p_ot_name;
-	strings_uac1[STR_FU_OUT].s = audio_opts->p_fu_name;
-	strings_uac1[STR_AS_OUT_IF_ALT0].s = audio_opts->p_alt0_name;
-	strings_uac1[STR_AS_OUT_IF_ALT1].s = audio_opts->p_alt1_name;
+	strings_uac1[STR_FU_OUT].s = audio_opts->p_fu_vol_name;
+	strings_uac1[STR_AS_OUT_IF_ALT0].s = "Playback Inactive";
+	strings_uac1[STR_AS_OUT_IF_ALT1].s = "Playback Active";
 
 	strings_uac1[STR_IO_IN_IT].s = audio_opts->c_it_name;
 	strings_uac1[STR_IO_IN_IT_CH_NAMES].s = audio_opts->c_it_ch_name;
 	strings_uac1[STR_USB_IN_OT].s = audio_opts->c_ot_name;
-	strings_uac1[STR_FU_IN].s = audio_opts->c_fu_name;
-	strings_uac1[STR_AS_IN_IF_ALT0].s = audio_opts->c_alt0_name;
-	strings_uac1[STR_AS_IN_IF_ALT1].s = audio_opts->c_alt1_name;
+	strings_uac1[STR_FU_IN].s = audio_opts->c_fu_vol_name;
+	strings_uac1[STR_AS_IN_IF_ALT0].s = "Capture Inactive";
+	strings_uac1[STR_AS_IN_IF_ALT1].s = "Capture Active";
 
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
@@ -1687,16 +1687,12 @@ UAC1_ATTRIBUTE_STRING(function_name);
 UAC1_ATTRIBUTE_STRING(p_it_name);
 UAC1_ATTRIBUTE_STRING(p_it_ch_name);
 UAC1_ATTRIBUTE_STRING(p_ot_name);
-UAC1_ATTRIBUTE_STRING(p_fu_name);
-UAC1_ATTRIBUTE_STRING(p_alt0_name);
-UAC1_ATTRIBUTE_STRING(p_alt1_name);
+UAC1_ATTRIBUTE_STRING(p_fu_vol_name);
 
 UAC1_ATTRIBUTE_STRING(c_it_name);
 UAC1_ATTRIBUTE_STRING(c_it_ch_name);
 UAC1_ATTRIBUTE_STRING(c_ot_name);
-UAC1_ATTRIBUTE_STRING(c_fu_name);
-UAC1_ATTRIBUTE_STRING(c_alt0_name);
-UAC1_ATTRIBUTE_STRING(c_alt1_name);
+UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
 
 static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_c_chmask,
@@ -1724,16 +1720,12 @@ static struct configfs_attribute *f_uac1_attrs[] = {
 	&f_uac1_opts_attr_p_it_name,
 	&f_uac1_opts_attr_p_it_ch_name,
 	&f_uac1_opts_attr_p_ot_name,
-	&f_uac1_opts_attr_p_fu_name,
-	&f_uac1_opts_attr_p_alt0_name,
-	&f_uac1_opts_attr_p_alt1_name,
+	&f_uac1_opts_attr_p_fu_vol_name,
 
 	&f_uac1_opts_attr_c_it_name,
 	&f_uac1_opts_attr_c_it_ch_name,
 	&f_uac1_opts_attr_c_ot_name,
-	&f_uac1_opts_attr_c_fu_name,
-	&f_uac1_opts_attr_c_alt0_name,
-	&f_uac1_opts_attr_c_alt1_name,
+	&f_uac1_opts_attr_c_fu_vol_name,
 
 	NULL,
 };
@@ -1792,16 +1784,12 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Input terminal");
 	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playback Channels");
 	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Output terminal");
-	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");
-	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactive");
-	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active");
+	scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Playback Volume");
 
 	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Input terminal");
 	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Capture Channels");
 	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Output terminal");
-	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");
-	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive");
-	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active");
+	scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Capture Volume");
 
 	return &opts->func_inst;
 }
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 67784de9782b..feb6eb76462f 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -57,16 +57,12 @@ struct f_uac1_opts {
 	char			p_it_name[USB_MAX_STRING_LEN];
 	char			p_it_ch_name[USB_MAX_STRING_LEN];
 	char			p_ot_name[USB_MAX_STRING_LEN];
-	char			p_fu_name[USB_MAX_STRING_LEN];
-	char			p_alt0_name[USB_MAX_STRING_LEN];
-	char			p_alt1_name[USB_MAX_STRING_LEN];
+	char			p_fu_vol_name[USB_MAX_STRING_LEN];
 
 	char			c_it_name[USB_MAX_STRING_LEN];
 	char			c_it_ch_name[USB_MAX_STRING_LEN];
 	char			c_ot_name[USB_MAX_STRING_LEN];
-	char			c_fu_name[USB_MAX_STRING_LEN];
-	char			c_alt0_name[USB_MAX_STRING_LEN];
-	char			c_alt1_name[USB_MAX_STRING_LEN];
+	char			c_fu_vol_name[USB_MAX_STRING_LEN];
 
 	struct mutex			lock;
 	int				refcnt;
-- 
2.43.0


