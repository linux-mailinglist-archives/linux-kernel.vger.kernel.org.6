Return-Path: <linux-kernel+bounces-273620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAC946B92
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DF81F2156A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8E6116;
	Sun,  4 Aug 2024 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czSPOoqs"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D05A3D;
	Sun,  4 Aug 2024 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722731402; cv=none; b=aAJDgQjb7aTEQ2EtvKIlEXA3cJVMt3VDgs70nOq26JtDzy02rIUkpVNdYbIwmPLozSEbEX0F7lhHKgV0LvJgmdeqACaU9RrhvJd6vHUh9+NmFfWGFSPz9ZbE8p0XrVFpzLeTh0sA5hPTYxcPFHsAI9U9fvvhvYEqn3NRRMKf5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722731402; c=relaxed/simple;
	bh=QZP6fXatbjy0UA+pBTY8AjBzO08DWSXSVlfbpZOen6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSILkDLLffI96dev5HCKgw+5TSOZI5WqW66QZ/e+DpIPZyLKUYbd2+4l2l79IwQKdQk90NcjnRlziz/CYIDrMYEebXk6VAXdCc9pwTaztgYJjtfrx+qfF33uV1nM7HG6fIaNOx/Ujey3ect6LmGLWv0FNg0IFJ2ThJlBHWQQIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czSPOoqs; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b797234b09so39610366d6.0;
        Sat, 03 Aug 2024 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722731399; x=1723336199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7psPIO64HcfKCFgvdxP3NwRKcQSQNJW1hN8CEMUfmPo=;
        b=czSPOoqsQphhNcCssxPm62jmTemdQOBlaxQXaytzpBQJI1s5pjZJxRJcRbZztEIA0L
         ffItluZrIcUWlpFA7YivADERAt8G/7m66FUtb3Dzq60zO5DT0vck564McQ2JSXHYTwk4
         i2ejTJg+MP9n6Vi3W++u9UGXQEJyufptSlSKkiUDghGtGJV3v5ZTZG6/p+HKwfVFUVpe
         NuvwaAM0ybyrsAYPS2t8rlmGIv15YlWtV85Q7HkosphWB9EN8lyg1k+52I80myzcPHPW
         cJCf9d7+IjCg9mhbOAmwSqthh5MUGoNOuWcq1jJvSiKyGBTwrBxl6an3QRSCJsZeEXUA
         BjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722731399; x=1723336199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7psPIO64HcfKCFgvdxP3NwRKcQSQNJW1hN8CEMUfmPo=;
        b=nuHH8DdBMlyhNjknXj+nN9SjUHVspzVB3latIMUj6Vy29K+0AyMiCKUpPHf2ZgHwEM
         aM6NuKyCA2wRs/YZFQ8/d+PQK3qIoqjjvBstLmARMeGbdIuRe906s+jyM/JOJmpMIEfV
         vR7ngxROKv2SGw3Cd40vnoUWRTtshbSHkIdbgMrt/SFzU4ggCc1ECg3TFVXjU+1UReJk
         5rRA1F3A2Om0oFPC7LS2SPjQkvBhaQUvhltCPr3A3joqpgBCbK69okz45Z9S0J+9t6Rs
         0fXW/wdVlDd4x7Abm0Ekx14EBBNhWZgjhWxFJSKQvSbtADQJ8QUax2f7nYkQKgz7anZ1
         RQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvQ+UYG22D1v2h/GmerC0Uh4VQXMF4TJyaUl6m8MPwIbT36q4RvD86TBj2qVFIz1cJyKyekkZyGqCSbYV/uigu8f1I6QDLFO7dMAuS
X-Gm-Message-State: AOJu0Yw7oXHlYvKw2v9z8U9WxUJM+DYMHv5y9MeQ3byeBghoAOBWoH7Q
	bM+NjvH9DLIx/8BR25FbxeA8A1fxgpTpML37vTSWonoDipXPglywqYED9g==
X-Google-Smtp-Source: AGHT+IFvfxta/3TaaA37SRbHufoPJhiqMRhgFWO0leCBV5bwI56yi237WDEiF9/yU67iQPDEUt4IBw==
X-Received: by 2002:ad4:46d9:0:b0:6b7:923c:e0b7 with SMTP id 6a1803df08f44-6bb91e7112cmr176340936d6.21.1722731398882;
        Sat, 03 Aug 2024 17:29:58 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c761595sm20857486d6.10.2024.08.03.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 17:29:58 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Perr Zhang <perr@usb7.net>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH v3] usb: gadget: f_uac1: Change volume name and remove alt names
Date: Sat,  3 Aug 2024 20:29:13 -0400
Message-ID: <20240804002912.3293177-2-crwulff@gmail.com>
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
v3: Corrected semantics of c_/p_ strings to match other c_/p_ settings.
v2: Moved discussion thread tidbit into commit message
https://lore.kernel.org/all/20240803232722.3220995-2-crwulff@gmail.com/
v1: https://lore.kernel.org/all/20240803155215.2746444-2-crwulff@gmail.com/
---
 .../ABI/testing/configfs-usb-gadget-uac1      |  8 +--
 Documentation/usb/gadget-testing.rst          |  8 +--
 drivers/usb/gadget/function/f_uac1.c          | 64 ++++++++-----------
 drivers/usb/gadget/function/u_uac1.h          |  8 +--
 4 files changed, 32 insertions(+), 56 deletions(-)

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
index 06a220fb7a87..c87e74afc881 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1251,19 +1251,19 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	strings_uac1[STR_AC_IF].s = audio_opts->function_name;
 
-	strings_uac1[STR_USB_OUT_IT].s = audio_opts->p_it_name;
-	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s = audio_opts->p_it_ch_name;
-	strings_uac1[STR_IO_OUT_OT].s = audio_opts->p_ot_name;
-	strings_uac1[STR_FU_OUT].s = audio_opts->p_fu_name;
-	strings_uac1[STR_AS_OUT_IF_ALT0].s = audio_opts->p_alt0_name;
-	strings_uac1[STR_AS_OUT_IF_ALT1].s = audio_opts->p_alt1_name;
-
-	strings_uac1[STR_IO_IN_IT].s = audio_opts->c_it_name;
-	strings_uac1[STR_IO_IN_IT_CH_NAMES].s = audio_opts->c_it_ch_name;
-	strings_uac1[STR_USB_IN_OT].s = audio_opts->c_ot_name;
-	strings_uac1[STR_FU_IN].s = audio_opts->c_fu_name;
-	strings_uac1[STR_AS_IN_IF_ALT0].s = audio_opts->c_alt0_name;
-	strings_uac1[STR_AS_IN_IF_ALT1].s = audio_opts->c_alt1_name;
+	strings_uac1[STR_USB_OUT_IT].s = audio_opts->c_it_name;
+	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s = audio_opts->c_it_ch_name;
+	strings_uac1[STR_IO_OUT_OT].s = audio_opts->c_ot_name;
+	strings_uac1[STR_FU_OUT].s = audio_opts->c_fu_vol_name;
+	strings_uac1[STR_AS_OUT_IF_ALT0].s = "Playback Inactive";
+	strings_uac1[STR_AS_OUT_IF_ALT1].s = "Playback Active";
+
+	strings_uac1[STR_IO_IN_IT].s = audio_opts->p_it_name;
+	strings_uac1[STR_IO_IN_IT_CH_NAMES].s = audio_opts->p_it_ch_name;
+	strings_uac1[STR_USB_IN_OT].s = audio_opts->p_ot_name;
+	strings_uac1[STR_FU_IN].s = audio_opts->p_fu_vol_name;
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
@@ -1789,19 +1781,15 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 
 	scnprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
 
-	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Input terminal");
-	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playback Channels");
-	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Output terminal");
-	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");
-	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactive");
-	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active");
-
-	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Input terminal");
-	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Capture Channels");
-	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Output terminal");
-	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");
-	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive");
-	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active");
+	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Capture Input terminal");
+	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Capture Channels");
+	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Capture Output terminal");
+	scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Capture Volume");
+
+	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Playback Input terminal");
+	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Playback Channels");
+	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Playback Output terminal");
+	scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Playback Volume");
 
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


