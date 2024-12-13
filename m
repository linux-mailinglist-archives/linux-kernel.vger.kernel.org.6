Return-Path: <linux-kernel+bounces-445707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728909F1A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A12188E0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9651E3DEF;
	Fri, 13 Dec 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fdfu34mm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C71B6D1A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132958; cv=none; b=LqGtD5naw2MrjOj514lDMUlNTBQCdzpE6coQAGLiGTpWNh5F0Jd7F0AQkpNucSyQAUUDt8YfPEerihBVYy6I3WFBfuKa77dQtfL7zYLwszGoC3mAal89hacsg4en4fZH7OLFs/jj6iHFgjDl4KB5J8auxSTHdzWECy3MX/32jcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132958; c=relaxed/simple;
	bh=KVAPKHKDIi6ZozifLwAVFGy3NJHCm9SP5tWGLFajcC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkJYOsQxhvKWQKEjdi106DM72VSCDCX7yQgBqwPxN6igBXlGU3mlA1w52lZIZ9tAXyPYqhWYayW4Nb0THFaJvH30auHrqVabNNBF9tH/DmxCk9fGgZewfNamMkzC4KblQ62YZhvG9YBYfv+E43lpOSGlek3KcD78H87uSG4qgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fdfu34mm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21628b3fe7dso19416415ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132955; x=1734737755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2joRXiX4ZDmMc5H+1DaNrFqQcCzYSVBFrBBIReWvLhM=;
        b=Fdfu34mmqoOVPo5nCP07/Aa4QjoNnHgW9mSoHDOE+O/w/pYQV9HR6r1KFvRe8OBK06
         czigsFX4vQk6QgjgrHqmhp3TSGabY6o3CEBMDjascaDLnojaXQOr2QHIT9k7pULJ3au+
         tQxsWRHYGTSHQeKJraJCq2j3ardfCI5l8Uoqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132955; x=1734737755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2joRXiX4ZDmMc5H+1DaNrFqQcCzYSVBFrBBIReWvLhM=;
        b=T4ar20FnCj7mu39V4tokYowsdeIWJiaAw6fkorrV3q/YCsaXQXZL2M5+afPMsl6MQD
         EQ+fPOdSa2+sx8GQjVBOX/ylsqGhjubKItsH/KD2z9/R3YeqYQm3mo51TpvPx8tg2+lJ
         i06VkI9/qsMeThWRSe5IplmB9hDVGl4mu7HkvMIT+hAdkWKcAAOKgggurwzJ8yV77YIe
         rH5LMZNrOUK7+RN0TNkGvyT38spNa7xmnB2Mzz+sYS7Q5xQ864aA3PnibF7VNow/8yw2
         KM1bgQqoSNLw2MStpAf7HEabiZs4rjKjiHlVUFxu/UC2aZHVQildaqF+GNRAAjfdmIp6
         B9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV1Q7+cnLIjtGbvN7zI9yYG7VbM4zUvvv53Qeln9YtecCaRDgg0sKkfViaRYNFphkkfDKmjW3XygFSL34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R4t/g1k41O9j04NHZzFjkZLIIIX5hLXcrA50lQoC2l2DPGf9
	HXYZFVBfuRXqUHCwdCInRSUCIjsLjvq+kDRPpjjoseuF652GruBIn44qwkvKnQ==
X-Gm-Gg: ASbGnctQCWwEqdK1IF1DIFxlVXtnhc+L8Fssr+lGg7P+ybdvjib5xT9WA2fy6MYXIC7
	kv+nfGBqjwjxB0xApX0Os9y5yYP8GNQuw2lcesL4eCeaBgIA52T7g3Pzbf+2V3UDIfLh4z/Qmcu
	nnFTQJr8cU7pJM8BeYih+V8Ck91dHXNAWs091TtHA8lwC/QW0GjZoA66teaiCXgWiShdjpG52wG
	bCSnCDkSbxIolaUplJbYutvl07zXrGvhDaWMxQJk5tH51H+S0d5iEdGmvX9glkZtIa7NsUDJheR
	pOMLsfiZNdojwfYEq59u0IeStzwaXpc=
X-Google-Smtp-Source: AGHT+IH8ZFuDs0emt0+PPLGZ5/ZYn4/Duplxh1Ipgr1sWzkwTO40N5VOvKe8sHcnYfrW2a/CsJ7WdA==
X-Received: by 2002:a17:903:41c5:b0:215:9a73:6c45 with SMTP id d9443c01a7336-218929d8326mr65691895ad.22.1734132955475;
        Fri, 13 Dec 2024 15:35:55 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e5404csm2923585ad.150.2024.12.13.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:35:55 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	sboyd@kernel.org,
	pmalani@chromium.org,
	badhri@google.com,
	rdbabiera@google.com,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] usb: typec: Only use SVID for matching altmodes
Date: Fri, 13 Dec 2024 15:35:42 -0800
Message-ID: <20241213153543.v5.1.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213233552.451927-1-abhishekpandit@chromium.org>
References: <20241213233552.451927-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mode in struct typec_altmode is used to indicate the index of the
altmode on a port, partner or plug. It is used in enter mode VDMs but
doesn't make much sense for matching against altmode drivers or for
matching partner to port altmodes.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v5:
- Rebase with module_alias_printf

Changes in v3:
- Removed mode from altmode device ids
- Updated modalias for typecd bus to remove mode
- Re-ordered to start of series

Changes in v2:
- Update altmode_match to ignore mode entirely
- Also apply the same behavior to typec_match

 drivers/usb/typec/altmodes/displayport.c | 2 +-
 drivers/usb/typec/altmodes/nvidia.c      | 2 +-
 drivers/usb/typec/bus.c                  | 6 ++----
 drivers/usb/typec/class.c                | 4 ++--
 scripts/mod/devicetable-offsets.c        | 1 -
 scripts/mod/file2alias.c                 | 9 ++-------
 6 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 2f03190a9873..3245e03d59e6 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -791,7 +791,7 @@ void dp_altmode_remove(struct typec_altmode *alt)
 EXPORT_SYMBOL_GPL(dp_altmode_remove);
 
 static const struct typec_device_id dp_typec_id[] = {
-	{ USB_TYPEC_DP_SID, USB_TYPEC_DP_MODE },
+	{ USB_TYPEC_DP_SID },
 	{ },
 };
 MODULE_DEVICE_TABLE(typec, dp_typec_id);
diff --git a/drivers/usb/typec/altmodes/nvidia.c b/drivers/usb/typec/altmodes/nvidia.c
index fe70b36f078f..2b77d931e494 100644
--- a/drivers/usb/typec/altmodes/nvidia.c
+++ b/drivers/usb/typec/altmodes/nvidia.c
@@ -24,7 +24,7 @@ static void nvidia_altmode_remove(struct typec_altmode *alt)
 }
 
 static const struct typec_device_id nvidia_typec_id[] = {
-	{ USB_TYPEC_NVIDIA_VLINK_SID, TYPEC_ANY_MODE },
+	{ USB_TYPEC_NVIDIA_VLINK_SID },
 	{ },
 };
 MODULE_DEVICE_TABLE(typec, nvidia_typec_id);
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index aa879253d3b8..ae90688d23e4 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -454,8 +454,7 @@ static int typec_match(struct device *dev, const struct device_driver *driver)
 	const struct typec_device_id *id;
 
 	for (id = drv->id_table; id->svid; id++)
-		if (id->svid == altmode->svid &&
-		    (id->mode == TYPEC_ANY_MODE || id->mode == altmode->mode))
+		if (id->svid == altmode->svid)
 			return 1;
 	return 0;
 }
@@ -470,8 +469,7 @@ static int typec_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODE=%u", altmode->mode))
 		return -ENOMEM;
 
-	return add_uevent_var(env, "MODALIAS=typec:id%04Xm%02X",
-			      altmode->svid, altmode->mode);
+	return add_uevent_var(env, "MODALIAS=typec:id%04X", altmode->svid);
 }
 
 static int typec_altmode_create_links(struct altmode *alt)
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 4b3047e055a3..febe453b96be 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -237,13 +237,13 @@ static int altmode_match(struct device *dev, void *data)
 	if (!is_typec_altmode(dev))
 		return 0;
 
-	return ((adev->svid == id->svid) && (adev->mode == id->mode));
+	return (adev->svid == id->svid);
 }
 
 static void typec_altmode_set_partner(struct altmode *altmode)
 {
 	struct typec_altmode *adev = &altmode->adev;
-	struct typec_device_id id = { adev->svid, adev->mode, };
+	struct typec_device_id id = { adev->svid };
 	struct typec_port *port = typec_altmode2port(adev);
 	struct altmode *partner;
 	struct device *dev;
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 9c7b404defbd..d3d00e85edf7 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -237,7 +237,6 @@ int main(void)
 
 	DEVID(typec_device_id);
 	DEVID_FIELD(typec_device_id, svid);
-	DEVID_FIELD(typec_device_id, mode);
 
 	DEVID(tee_client_device_id);
 	DEVID_FIELD(tee_client_device_id, uuid);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5b5745f00eb3..7049c31062c6 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1221,17 +1221,12 @@ static void do_tbsvc_entry(struct module *mod, void *symval)
 	module_alias_printf(mod, true, "tbsvc:%s", alias);
 }
 
-/* Looks like: typec:idNmN */
+/* Looks like: typec:idN */
 static void do_typec_entry(struct module *mod, void *symval)
 {
-	char alias[256] = {};
-
 	DEF_FIELD(symval, typec_device_id, svid);
-	DEF_FIELD(symval, typec_device_id, mode);
-
-	ADD(alias, "m", mode != TYPEC_ANY_MODE, mode);
 
-	module_alias_printf(mod, false, "typec:id%04X%s", svid, alias);
+	module_alias_printf(mod, false, "typec:id%04X", svid);
 }
 
 /* Looks like: tee:uuid */
-- 
2.47.1.613.gc27f4b7a9f-goog


