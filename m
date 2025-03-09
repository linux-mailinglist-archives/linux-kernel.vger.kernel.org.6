Return-Path: <linux-kernel+bounces-552897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A8A5809E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B83ADD7A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7181547FF;
	Sun,  9 Mar 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQjfopDM"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7373145A18;
	Sun,  9 Mar 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741497236; cv=none; b=V8q6DjmhZ8Fqwa1IUr3bfYPEjbd2FeA0aCz1AiqhlgtQrjWhhuCwno6zkhDR1215C5wLv/fdHF6vCVkC/Jetwu3z7gwK84bkiZLws/TVa9BStnCLUkDULkBLRK5VULiJcE1ujfzdUSbUkGCmRf+C5UpKuTa873vydyFaJGTTsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741497236; c=relaxed/simple;
	bh=dAjiu/yWwvAspPsxJlkw4RUfA7t93gSnJV9SzsY9+8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7i49L1r/hlHmis9WAYg8i7KRkQFEtSPg++zxPlS7l0nH0CQoyQSKogOQsKAo98Yptp12f2j8P1AzJPb/Y0nQ2pMgK7qsJKC1WpBelb//gWYi6eZ2Aq4DOo1Ih4rZExfeKyDk8rzNIuYnBTi1vw6YXmo5bdp0YjEdVL9+StCmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQjfopDM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6febbd3b75cso23320137b3.0;
        Sat, 08 Mar 2025 21:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741497233; x=1742102033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cclqe9iQWV2U0fDaf7eY7iycznFLnFRbLLgatWO9y0I=;
        b=fQjfopDM17w8O+0vlVfRNBC7533b7EGjl7frGP91DvkVB3pePratQ+4YeQ36NM8N6o
         piidOUSqy3qVi/yGiilSqxTKQvxmczFQEp0g8Qn2dPItay+IgibGcmdwmVB/vC3uc6Cx
         Yit/ceSWc9QEjIE7wYhODa277lr3SJ29yEVwRk0s0DHjFOPsKrgE/kGsnyD6E8SNceiq
         OPp/27/W+iTnnKTgc5OxufYBo7OBVc7LTziwaIlPx/Yw0d2zD2hZzSLtA91Q0+aj01f1
         Q1SzI/VTrhjQpuX4EMsBmAqqTiBbFwGWO6pW2xyK5k7tSogj2tqNqUsnLVkds86CvT9C
         I05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741497233; x=1742102033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cclqe9iQWV2U0fDaf7eY7iycznFLnFRbLLgatWO9y0I=;
        b=beytTRq0UlgjHwanAQyC5fL8HVYw5H6KpVaVX8wudetAwKaWQUdeJZLyZ1VdTTFxH5
         7ddPcO004uNUg5p9Z8gFE0TFg9QWy39zdQ1CB8RAaLJt0Q+ZobMSxfEKYbptkEvYWxqf
         4sdTo4Xa9t25cqRhQK0F1SH9YHWodM7AqQAZQN/ylswHWWfJKR6qNC7e4+H+fXIQ3xaV
         AldIdMYOfiFc/7NOthVsCibrSZgVyDV3clYMqvAKOaKrFw453kmpO/WY3kgfPdvMktLg
         /yTF5tUY4StyXdGC5dLdWJ8X2mdjsQU2nH/bs54gMDuZVq8umY4MlFc0hHAmNKhdwfQ/
         GF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXotrimmjB//Plk1F+R/qk5LfJhThHG9HEXzIg64bm2P6ursd62KJwYsr6FXakjr7F2GmtHrhQwk6+gYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhJ3DFbBV8iManL+Ze7uJXMQwnGplsOv0FwxMAUbH99AJFJgT
	nYPrBcnvc7LMcibp5t7TkyfDVCF7zToOmC58L2g5nWb/BPqKf0ErMoFfCDKS
X-Gm-Gg: ASbGnctWMjtiRGZ1GEq7godzcdOA8nLf0AswFiPobK+as8uDz9DM15msuAtwmo1qeQM
	KMQFNXrxAu+i3RkGH9NTwVqYEDURCgdBi2j4ohGFkkjvAD847QCUXOT4pSnbqC4qKPtp8yj0Ldi
	2N2nIKT8wYxhOEhfrFSmVFpfpir44D79xuYIw99gyHBQsKTCj5Nki8miN2Gvf6E1z7yTczbx7VX
	zJUUE0wbUqyMaL6xB+dSU+YOj4yCLTbtIgJZXJKqfz3sYU+JAG2Kt96Y7C8oW5ztWfUGMkRbE1F
	Ti+akrSpCUvVkfxWBZI4LzW21qYjzPgLgEzvKwgdLMAQ5w==
X-Google-Smtp-Source: AGHT+IF57dBxKvLHhrEFhZKjQKB1oJd7fiNJroHfSoxnvsFKpmpOMAWjypEIkqCa2PY4iisS0uyhcg==
X-Received: by 2002:a05:690c:2e03:b0:6fb:9c08:496d with SMTP id 00721157ae682-6febf3c2cbcmr99636317b3.30.1741497233570;
        Sat, 08 Mar 2025 21:13:53 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a1bfc5sm15232747b3.24.2025.03.08.21.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:13:52 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 09 Mar 2025 00:13:40 -0500
Subject: [PATCH RFC v2 1/2] platform/x86: wmi: Add
 wmidev_get_acpi_device_uid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-awcc-uid-v2-1-5338c6380b2f@gmail.com>
References: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
In-Reply-To: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Add a non-deprecated version of wmi_get_acpi_device_uid().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/wmi.c | 20 +++++++++++++++++---
 include/linux/wmi.h        |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e46453750d5f1475eb87342b1c5fd04fe20df335..39f379777ad08efd3cda7313f293522c68773dbe 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -636,7 +636,6 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
  */
 char *wmi_get_acpi_device_uid(const char *guid_string)
 {
-	struct wmi_block *wblock;
 	struct wmi_device *wdev;
 	char *uid;
 
@@ -644,8 +643,7 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 	if (IS_ERR(wdev))
 		return NULL;
 
-	wblock = container_of(wdev, struct wmi_block, dev);
-	uid = acpi_device_uid(wblock->acpi_device);
+	uid = wmidev_get_acpi_device_uid(wdev);
 
 	wmi_device_put(wdev);
 
@@ -653,6 +651,22 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
 
+/**
+ * wmidev_get_acpi_device_uid() - Get _UID name of a WMI device
+ * @wdev: A wmi bus device from a driver
+ *
+ * Find the _UID of the ACPI device associated with this WMI device.
+ *
+ * Return: The ACPI _UID field or NULL if there is no _UID
+ */
+char *wmidev_get_acpi_device_uid(struct wmi_device *wdev)
+{
+	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
+
+	return acpi_device_uid(wblock->acpi_device);
+}
+EXPORT_SYMBOL_GPL(wmidev_get_acpi_device_uid);
+
 /*
  * sysfs interface
  */
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 10751c8e5e6a0ad3ac9ae317b6f8ecfb14c9a983..625c52ee125219aaa23cf946333af33ad118aafa 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -46,6 +46,8 @@ extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 
 acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in);
 
+char *wmidev_get_acpi_device_uid(struct wmi_device *wdev);
+
 u8 wmidev_instance_count(struct wmi_device *wdev);
 
 /**

-- 
2.48.1


