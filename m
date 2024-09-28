Return-Path: <linux-kernel+bounces-342516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBC988FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3105B1C20B57
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D481292CE;
	Sat, 28 Sep 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP0/n/QE"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3A3C08A;
	Sat, 28 Sep 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536162; cv=none; b=DXoVqwAA5qfnukHkfFQRF6LuTRknBrGEp+NAVzhlOpXKwSHdrznv/NiaXlN6DyQAXaFSPlcDtSFR7VAFjwEOhd4+FdO4AvETBSkitaedEf0UA4SGMK7tHPVUofuELt3YXPu/L7QOJ6DLB0K1UBlySpo3PtGNHN+iRZUNY81Xcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536162; c=relaxed/simple;
	bh=Qt6MiSN7hcJhIbF/xI9yzS3PeHn2vFP7W3G9V78dp3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5aysG4oKlUzANOq33cj8AkViEIqX7s5zFRZqNv0vyyhGmv5ZZZmhbqSKYiPtZgDhjODCdtXZZPtMSsyT9ekgnB38h7boeU+hAJdGU3Ov3cSKqr3XYPQ/5cenGjQzO6Y0O9OnyBeUuxkeWihw37lQuVnsbepDrcngpCMqNnRHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP0/n/QE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9a62c6734so26985585a.3;
        Sat, 28 Sep 2024 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727536159; x=1728140959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+92T4M0KkpvzaSGDK4NkdBg9rU8udS1E0OYHQLIDTH8=;
        b=IP0/n/QE+mDFaReOR9lDSlXjCwhi9IzrUbgCq77mqzZwldsKcv2ktg4zvgcCQokr/p
         XZLr6w1On6J9LwfMArHL0CY6/q6TvziExkOIabW5qJ4buMtVsEZnEXEVzm0jLVEs27El
         uRBA0bXB7gm46FXrTyhvJWcQbCJvqjYJ4F8+ZZC/OUjBhHFcwA5oUZNY7YzcEi7yZXko
         dPq4TosoOhG86QKhAUgYHnWiSEvE896r0dqALbJ1sLaSyRbihDA+eVHHbqtLc+7qbb3i
         kMLijXJT+TfPZtyuT0I2LvRfR5lQoT7K5vXRV03pj5lu1YGEfnOZtYhHTUWOD6TwOiTJ
         ms6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727536159; x=1728140959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+92T4M0KkpvzaSGDK4NkdBg9rU8udS1E0OYHQLIDTH8=;
        b=Kf04pxcJh44gNP95xJvo6Qd8WjoRNiSha0gbxogIHjtcfo97OMt4hI3M9QsZz+hAHn
         qplkWRuIjRiKAXcumQt4bX90UevgQwOMt4Mg075Gd7tzF7kAZ2MOB/rR6EewZJMzofjR
         0apOwV0Iw+vaoHnjBMfnMOi8bT955VDbMlBJ1XbD2XvvYDZ2+9H3eDOBhO2uiU5SUGWH
         Y4z9n8C1QorXPWu0QXLrEBlYNtCGRQs0HZc0n/atki9ujLhr2UCj9HTEdAu85v7J14iI
         sG8xvcDHUB/50g6fSIgBi44ppiMyOBjTgYdbJcose2O97IbmXuM3gQrxXgqT46CnUuHQ
         Edlw==
X-Forwarded-Encrypted: i=1; AJvYcCWRnB1GI2yQ4wDp5oe4ZBfWstH3HcfjHKYthu2SDYS3ahCbFRo+x1Jpl9Df2zYF+tTu8uOMdj4Wk9M=@vger.kernel.org, AJvYcCXmyJvoSGUYpu9IyCO4DQh3g/Hn/CF4ssiZvSfeX1RBqcclfqbUvMDhRxLewj+K+0ttoKegxA57Lqz6udvu@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBtgr3iZniaRofwNT7enp5L75ZcOJIGbZaLNlfu6sko990g7j
	KwOt4YNDa5QPvODruF5kOJourwA0c6zljUJvVZzZczf6v0CajyT7Jv3ZK4rs8wU=
X-Google-Smtp-Source: AGHT+IEDd4w4H7Q7DYWVzaJjwpit+wPVgXAuJtL6pnE/ho7t1kqM7y6929uHpfk7tUZZB4lV3GfRHA==
X-Received: by 2002:a05:622a:1a0d:b0:458:4126:ec4e with SMTP id d75a77b69052e-45c9f301e26mr44196931cf.11.1727536158662;
        Sat, 28 Sep 2024 08:09:18 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f35392esm18662881cf.82.2024.09.28.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 08:09:17 -0700 (PDT)
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
Subject: [PATCH RFC 01/14] usb: gadget: f_uac: Refactor common configfs attribute defines used in UAC1/2.
Date: Sat, 28 Sep 2024 11:08:52 -0400
Message-ID: <20240928150905.2616313-2-crwulff@gmail.com>
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

Consolidate a bunch of common #defines used by both f_uac1 and f_uac2
to make it easier to maintain. Only the #defines moved and the same static
functions get created in each module as before. Formatters are also #define
which makes slightly smaller code.

Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/f_uac1.c      | 148 +--------------
 drivers/usb/gadget/function/f_uac2.c      | 207 +--------------------
 drivers/usb/gadget/function/u_uac_utils.h | 217 ++++++++++++++++++++++
 3 files changed, 235 insertions(+), 337 deletions(-)
 create mode 100644 drivers/usb/gadget/function/u_uac_utils.h

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index c87e74afc881..eeedcfa61fa1 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -19,6 +19,7 @@
 
 #include "u_audio.h"
 #include "u_uac1.h"
+#include "u_uac_utils.h"
 
 /* UAC1 spec: 3.7.2.3 Audio Channel Cluster Format */
 #define UAC1_CHANNEL_MASK 0x0FFF
@@ -1516,151 +1517,18 @@ static struct configfs_item_operations f_uac1_item_ops = {
 	.release	= f_uac1_attr_release,
 };
 
-#define uac1_kstrtou32			kstrtou32
-#define uac1_kstrtos16			kstrtos16
-#define uac1_kstrtobool(s, base, res)	kstrtobool((s), (res))
-
-static const char *u32_fmt = "%u\n";
-static const char *s16_fmt = "%hd\n";
-static const char *bool_fmt = "%u\n";
-
+#define UAC1_ATTR_TO_OPTS struct f_uac1_opts *opts = to_f_uac1_opts(item)
 #define UAC1_ATTRIBUTE(type, name)					\
-static ssize_t f_uac1_opts_##name##_show(				\
-					  struct config_item *item,	\
-					  char *page)			\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	int result;							\
-									\
-	mutex_lock(&opts->lock);					\
-	result = sprintf(page, type##_fmt, opts->name);			\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac1_opts_##name##_store(				\
-					  struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	int ret;							\
-	type num;							\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	ret = uac1_kstrto##type(page, 0, &num);				\
-	if (ret)							\
-		goto end;						\
-									\
-	opts->name = num;						\
-	ret = len;							\
-									\
-end:									\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac1_opts_, name)
+	UAC_ATTRIBUTE(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,		\
+		      opts->lock, opts->refcnt, type, name)
 
 #define UAC1_RATE_ATTRIBUTE(name)					\
-static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	int result = 0;							\
-	int i;								\
-									\
-	mutex_lock(&opts->lock);					\
-	page[0] = '\0';							\
-	for (i = 0; i < UAC_MAX_RATES; i++) {				\
-		if (opts->name##s[i] == 0)				\
-			break;						\
-		result += sprintf(page + strlen(page), "%u,",		\
-				opts->name##s[i]);			\
-	}								\
-	if (strlen(page) > 0)						\
-		page[strlen(page) - 1] = '\n';				\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac1_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	char *split_page = NULL;					\
-	int ret = -EINVAL;						\
-	char *token;							\
-	u32 num;							\
-	int i;								\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	i = 0;								\
-	memset(opts->name##s, 0x00, sizeof(opts->name##s));		\
-	split_page = kstrdup(page, GFP_KERNEL);				\
-	while ((token = strsep(&split_page, ",")) != NULL) {		\
-		ret = kstrtou32(token, 0, &num);			\
-		if (ret)						\
-			goto end;					\
-									\
-		opts->name##s[i++] = num;				\
-		ret = len;						\
-	};								\
-									\
-end:									\
-	kfree(split_page);						\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac1_opts_, name)
+	UAC_RATE_ATTRIBUTE(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,	\
+			   opts->lock, opts->refcnt, name)
 
 #define UAC1_ATTRIBUTE_STRING(name)					\
-static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	int result;							\
-									\
-	mutex_lock(&opts->lock);					\
-	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac1_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac1_opts *opts = to_f_uac1_opts(item);		\
-	int ret = 0;							\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	ret = scnprintf(opts->name, min(sizeof(opts->name), len),	\
-			"%s", page);					\
-									\
-end:									\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac1_opts_, name)
+	UAC_ATTRIBUTE_STRING(f_uac1_opts, UAC1_ATTR_TO_OPTS, opts,	\
+			     opts->lock, opts->refcnt, name)
 
 UAC1_ATTRIBUTE(u32, c_chmask);
 UAC1_RATE_ATTRIBUTE(c_srate);
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 1cdda44455b3..2142a0951f71 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -17,6 +17,7 @@
 #include "u_audio.h"
 
 #include "u_uac2.h"
+#include "u_uac_utils.h"
 
 /* UAC2 spec: 4.1 Audio Channel Cluster Descriptor */
 #define UAC2_CHANNEL_MASK 0x07FFFFFF
@@ -1877,210 +1878,22 @@ static struct configfs_item_operations f_uac2_item_ops = {
 	.release	= f_uac2_attr_release,
 };
 
-#define uac2_kstrtou8 kstrtou8
-#define uac2_kstrtou32 kstrtou32
-#define uac2_kstrtos16 kstrtos16
-#define uac2_kstrtobool(s, base, res) kstrtobool((s), (res))
-
-static const char *u8_fmt = "%u\n";
-static const char *u32_fmt = "%u\n";
-static const char *s16_fmt = "%hd\n";
-static const char *bool_fmt = "%u\n";
-
+#define UAC2_ATTR_TO_OPTS struct f_uac2_opts *opts = to_f_uac2_opts(item)
 #define UAC2_ATTRIBUTE(type, name)					\
-static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int result;							\
-									\
-	mutex_lock(&opts->lock);					\
-	result = sprintf(page, type##_fmt, opts->name);			\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret;							\
-	type num;							\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	ret = uac2_kstrto##type(page, 0, &num);				\
-	if (ret)							\
-		goto end;						\
-									\
-	opts->name = num;						\
-	ret = len;							\
-									\
-end:									\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac2_opts_, name)
+	UAC_ATTRIBUTE(f_uac2_opts, UAC2_ATTR_TO_OPTS, opts,		\
+		      opts->lock, opts->refcnt, type, name)
 
 #define UAC2_ATTRIBUTE_SYNC(name)					\
-static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int result;							\
-	char *str;							\
-									\
-	mutex_lock(&opts->lock);					\
-	switch (opts->name) {						\
-	case USB_ENDPOINT_SYNC_ASYNC:					\
-		str = "async";						\
-		break;							\
-	case USB_ENDPOINT_SYNC_ADAPTIVE:				\
-		str = "adaptive";					\
-		break;							\
-	default:							\
-		str = "unknown";					\
-		break;							\
-	}								\
-	result = sprintf(page, "%s\n", str);				\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret = 0;							\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	if (!strncmp(page, "async", 5))					\
-		opts->name = USB_ENDPOINT_SYNC_ASYNC;			\
-	else if (!strncmp(page, "adaptive", 8))				\
-		opts->name = USB_ENDPOINT_SYNC_ADAPTIVE;		\
-	else {								\
-		ret = -EINVAL;						\
-		goto end;						\
-	}								\
-									\
-	ret = len;							\
-									\
-end:									\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac2_opts_, name)
+	UAC_ATTRIBUTE_SYNC(f_uac2_opts, UAC2_ATTR_TO_OPTS, opts,	\
+			   opts->lock, opts->refcnt, name)
 
 #define UAC2_RATE_ATTRIBUTE(name)					\
-static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int result = 0;							\
-	int i;								\
-									\
-	mutex_lock(&opts->lock);					\
-	page[0] = '\0';							\
-	for (i = 0; i < UAC_MAX_RATES; i++) {				\
-		if (opts->name##s[i] == 0)				\
-			break;						\
-		result += sprintf(page + strlen(page), "%u,",		\
-				opts->name##s[i]);			\
-	}								\
-	if (strlen(page) > 0)						\
-		page[strlen(page) - 1] = '\n';				\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	char *split_page = NULL;					\
-	int ret = -EINVAL;						\
-	char *token;							\
-	u32 num;							\
-	int i;								\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	i = 0;								\
-	memset(opts->name##s, 0x00, sizeof(opts->name##s));		\
-	split_page = kstrdup(page, GFP_KERNEL);				\
-	while ((token = strsep(&split_page, ",")) != NULL) {		\
-		ret = kstrtou32(token, 0, &num);			\
-		if (ret)						\
-			goto end;					\
-									\
-		opts->name##s[i++] = num;				\
-		ret = len;						\
-	};								\
-									\
-end:									\
-	kfree(split_page);						\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac2_opts_, name)
+	UAC_RATE_ATTRIBUTE(f_uac2_opts, UAC2_ATTR_TO_OPTS, opts,	\
+			   opts->lock, opts->refcnt, name)
 
 #define UAC2_ATTRIBUTE_STRING(name)					\
-static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
-					 char *page)			\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int result;							\
-									\
-	mutex_lock(&opts->lock);					\
-	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
-	mutex_unlock(&opts->lock);					\
-									\
-	return result;							\
-}									\
-									\
-static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
-					  const char *page, size_t len)	\
-{									\
-	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret = 0;							\
-									\
-	mutex_lock(&opts->lock);					\
-	if (opts->refcnt) {						\
-		ret = -EBUSY;						\
-		goto end;						\
-	}								\
-									\
-	if (len && page[len - 1] == '\n')				\
-		len--;							\
-									\
-	ret = scnprintf(opts->name, min(sizeof(opts->name), len + 1),	\
-			"%s", page);					\
-									\
-end:									\
-	mutex_unlock(&opts->lock);					\
-	return ret;							\
-}									\
-									\
-CONFIGFS_ATTR(f_uac2_opts_, name)
+	UAC_ATTRIBUTE_STRING(f_uac2_opts, UAC2_ATTR_TO_OPTS, opts,	\
+			     opts->lock, opts->refcnt, name)
 
 UAC2_ATTRIBUTE(u32, p_chmask);
 UAC2_RATE_ATTRIBUTE(p_srate);
diff --git a/drivers/usb/gadget/function/u_uac_utils.h b/drivers/usb/gadget/function/u_uac_utils.h
new file mode 100644
index 000000000000..5f88e31103dd
--- /dev/null
+++ b/drivers/usb/gadget/function/u_uac_utils.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * u_uac_utils.h -- Utilities for UAC1/2 function driver
+ *
+ * Copyright (C) 2024
+ * Author: Chris Wulff <crwulff@gmail.com>
+ */
+
+#ifndef __U_UAC_UTILS_H
+#define __U_UAC_UTILS_H
+
+#define uac_kstrtou8			kstrtou8
+#define uac_kstrtos16			kstrtos16
+#define uac_kstrtou32			kstrtou32
+#define uac_kstrtobool(s, base, res)	kstrtobool((s), (res))
+
+#define u8_FMT "%u\n"
+#define u32_FMT "%u\n"
+#define s16_FMT "%hd\n"
+#define bool_FMT "%u\n"
+
+#define UAC_ATTRIBUTE(prefix, to_struct, var, lock, refcnt, type, name) \
+static ssize_t prefix##_##name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	to_struct;							\
+	int result;							\
+									\
+	mutex_lock(&lock);						\
+	result = sprintf(page, type##_FMT, var->name);			\
+	mutex_unlock(&lock);						\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t prefix##_##name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	to_struct;							\
+	int ret;							\
+	type num;							\
+									\
+	mutex_lock(&lock);						\
+	if (refcnt) {							\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = uac_kstrto##type(page, 0, &num);				\
+	if (ret)							\
+		goto end;						\
+									\
+	var->name = num;						\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&lock);						\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(prefix##_, name)
+
+#define UAC_RATE_ATTRIBUTE(prefix, to_struct, var, lock, refcnt, name)	\
+static ssize_t prefix##_##name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	to_struct;							\
+	int result = 0;							\
+	int i;								\
+									\
+	mutex_lock(&lock);						\
+	page[0] = '\0';							\
+	for (i = 0; i < UAC_MAX_RATES; i++) {				\
+		if (var->name##s[i] == 0)				\
+			break;						\
+		result += sprintf(page + strlen(page), "%u,",		\
+				var->name##s[i]);			\
+	}								\
+	if (strlen(page) > 0)						\
+		page[strlen(page) - 1] = '\n';				\
+	mutex_unlock(&lock);						\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t prefix##_##name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	to_struct;							\
+	char *split_page = NULL;					\
+	int ret = -EINVAL;						\
+	char *token;							\
+	u32 num;							\
+	int i;								\
+									\
+	mutex_lock(&lock);						\
+	if (refcnt) {							\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	i = 0;								\
+	memset(var->name##s, 0x00, sizeof(var->name##s));		\
+	split_page = kstrdup(page, GFP_KERNEL);				\
+	while ((token = strsep(&split_page, ",")) != NULL) {		\
+		ret = kstrtou32(token, 0, &num);			\
+		if (ret)						\
+			goto end;					\
+									\
+		var->name##s[i++] = num;				\
+		ret = len;						\
+	};								\
+									\
+end:									\
+	kfree(split_page);						\
+	mutex_unlock(&lock);						\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(prefix##_, name)
+
+#define UAC_ATTRIBUTE_STRING(prefix, to_struct, var, lock, refcnt, name) \
+static ssize_t prefix##_##name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	to_struct;							\
+	int result;							\
+									\
+	mutex_lock(&lock);						\
+	result = scnprintf(page, sizeof(var->name), "%s", var->name);	\
+	mutex_unlock(&lock);						\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t prefix##_##name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	to_struct;							\
+	int ret = 0;							\
+									\
+	mutex_lock(&lock);						\
+	if (refcnt) {							\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	if (len && page[len - 1] == '\n')				\
+		len--;							\
+									\
+	ret = scnprintf(var->name, min(sizeof(var->name), len + 1),	\
+			"%s", page);					\
+									\
+end:									\
+	mutex_unlock(&lock);						\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(prefix##_, name)
+
+#define UAC_ATTRIBUTE_SYNC(prefix, to_struct, var, lock, refcnt, name)	\
+static ssize_t prefix##_##name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	to_struct;							\
+	int result;							\
+	char *str;							\
+									\
+	mutex_lock(&lock);						\
+	switch (var->name) {						\
+	case USB_ENDPOINT_SYNC_ASYNC:					\
+		str = "async";						\
+		break;							\
+	case USB_ENDPOINT_SYNC_ADAPTIVE:				\
+		str = "adaptive";					\
+		break;							\
+	default:							\
+		str = "unknown";					\
+		break;							\
+	}								\
+	result = sprintf(page, "%s\n", str);				\
+	mutex_unlock(&lock);						\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t prefix##_##name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	to_struct;							\
+	int ret = 0;							\
+									\
+	mutex_lock(&lock);						\
+	if (refcnt) {							\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	if (!strncmp(page, "async", 5))					\
+		var->name = USB_ENDPOINT_SYNC_ASYNC;			\
+	else if (!strncmp(page, "adaptive", 8))				\
+		var->name = USB_ENDPOINT_SYNC_ADAPTIVE;			\
+	else {								\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+									\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&lock);						\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(prefix##_, name)
+
+#endif	/* __U_UAC_UTILS_H */
-- 
2.43.0


