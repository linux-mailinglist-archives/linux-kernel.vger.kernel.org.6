Return-Path: <linux-kernel+bounces-273551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DCF946A76
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BC12812C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C271552F6;
	Sat,  3 Aug 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B79fXtZ5"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725212C486;
	Sat,  3 Aug 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700370; cv=none; b=uAHag8owAjHCWnih6M1MtGxBdO6Dknj6ug4FfAdSVkOgBGWh+Fyu+iprxLUgA5MucyUgtKqN0oM8JAUV8E8bHvl/SBUMINyP0gEIoY9iAydCPh6Hv6gnbBXwMLUKA2mqfKf9tDjhb+PtvnuC+X+NHFLD7KV2VHoOed8owHzqFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700370; c=relaxed/simple;
	bh=QCo6DJOh0XVew2hy4ZdA2XI7aEGm3XiEvn2Enw5x1F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6HRLUMf1uV1+y/cXnZifJ8NNaBv2iS0LSELWskyaSiEZPxhIyrHssX1ULlz/IGIN5h7hF7yqFJ6Onfn3McwnStXza+EM2dt1fokIWoM7ztc1W3vvh6iB/AZFGvKHZ2Y0eMy/VLjXiU3k8jjqMKwXQmDMugzdBOXf8pTkd9YY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B79fXtZ5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1df0a93eeso509811285a.1;
        Sat, 03 Aug 2024 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722700367; x=1723305167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ogw+NxKj0NGUdKahZJHWHKokxgMy9a+B39dL2benM=;
        b=B79fXtZ5J9+oHP6NT68BzG+1FYFctBlFrYvZ7eRrPdQZNcp3a4iH0GoHcERWM4wYNw
         NYBePbNYEplm5FhyJs6WoIYAXx4+fL7KhIrCtmoXk3udLu9qMT4P6eIT33n2dQadjRjp
         3e+89vzodTm6qTfcse/jlon2QiZunmWVGCSPWZWchxB0s4TurXhu5iJj8MsU/+DNedDw
         4pbc5TIJITVeG1+P+IxSIjiy2OOwWCFxEinEj5rGYdY63NCqFowfPLDNLMgsE4tLcVpd
         1doknieKoPiYMbLjugvN8EVuMdmsF6AvoxmGuvh7H8XF5+KW8gZfZ/4IyXTS3Wi7TLOo
         mPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722700367; x=1723305167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7ogw+NxKj0NGUdKahZJHWHKokxgMy9a+B39dL2benM=;
        b=OpcJoElulW94Ne1WdNY4yPALTC9wR/3Vlx2vmFB8Z/SYw7moYI6IXG7Wo/dgF56Trw
         ejzKKqRXFjmJR6WDnsbPjqaXm/vGpJYvvq/KUWoOYjxtFxuNsK33+2COPTBkkKxuG71c
         vgeCmpn5hoC2yGrMTOWFiU4/RXNS9kuuceYp/esHIi5rpyqaO774cRNL4f1+QjWmfsI/
         QdvGNWX2ZKOs1LDUBnD0Kb6uCak0cb3tvCPZVUzJ8ynjBkzbyFdMIafbnddl4QCQV9F0
         g2krttnm4yuE1KepBv/KqpfitklYw5A9z0vh/4+11KdV5xSucI7jO5zSQL0HmpGbp7tZ
         edsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlyotClg7/sf7fEkPRg5xRZk8fcDSP17dKt3EOnWouJXA5wvH0ofs0bNVwvbEokLQjDUKC+p1aHYH6t4fo3E7reiGodZAaOO+maqn7
X-Gm-Message-State: AOJu0Yy7Y9txRVr4GHK22sU4RlysNzIj5zSfX428nnBNiupgS5a2ND8f
	bbZ6kAM18pD95qGH4vY24bO9Ljf++8QzKwoEPLEwcxdjD0hhay+x1kKYOw==
X-Google-Smtp-Source: AGHT+IFS6oEOYSwIZhBzdGwoQ1u+EN/ku/VAdLPwmjM4kUmI2bQC7SB94xt23mOrM2UJ8qZOEx9Lpg==
X-Received: by 2002:a05:620a:1aa1:b0:79e:ff18:b4f7 with SMTP id af79cd13be357-7a34efac0d2mr870086085a.50.1722700367328;
        Sat, 03 Aug 2024 08:52:47 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f798193sm184190385a.136.2024.08.03.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:52:46 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Perr Zhang <perr@usb7.net>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH] usb: gadget: f_uac1: Change volume name and remove alt names
Date: Sat,  3 Aug 2024 11:52:16 -0400
Message-ID: <20240803155215.2746444-2-crwulff@gmail.com>
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

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
discussion thread for api changes for alt mode settings:
https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/
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


