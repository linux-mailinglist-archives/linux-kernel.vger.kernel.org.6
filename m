Return-Path: <linux-kernel+bounces-440223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07F9EBA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732E1283E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727B228C92;
	Tue, 10 Dec 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Da8DHjme"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D15228384
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860579; cv=none; b=t/KMllIsOxwFRAErnpKSiYBRUaTvpDoCMKI0F634Rbtfgj0ZMmYJuwnsTorutC3nZHCZrRvfVIHDBhmY3j+Rv4+an4BdfNu+bbFAD9dpyOTkCZ1q5iLqA4OzONMtb4jbpjjkmuQLhnwKElj/vPturQN9x/2vaOOumdRS6ryQJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860579; c=relaxed/simple;
	bh=chc2biaIGBXBwkFrS62DYUV3DrLJW93SY6ROXf7O2qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoeCLT/ff04FxPJl480MpYKV16OYrnVpIV+r0/gQsl46fv149fIZ6DCra5Su0fQew5qhBeaM3D6MySUxd9CUeUDM2FZnxMBijWAlHNDNo6UDr5RecPXIpPxORMwZ9nR9qGg1HxYTq760BG7eRQoXf9ZAYQIbwQe45/bvEyaCT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Da8DHjme; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso997581241.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860577; x=1734465377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=Da8DHjme4nPG8jec2YpUq3oIuQqq8FayWiTME97aleolJmcMikScO8lPjcHwyw4dyM
         DTOJ0+eP28+CX4SneF2fr5oP238XvlzqceCZTFnHmJcD9vl/Xaf8W/ses+KkUIPavQjI
         HaaVsGVJ/FmelcUieLD0kU3FhS/bYCLs8Hp2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860577; x=1734465377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=VOUX9OBLosOsZxhwxBluMntX4yxTANXamRADdrA6W2+27SFsBjC1MqwB7caXJMjPa8
         dey3tbuXgbGDTO7x+Eo1II+77cjMLhK8L3Y0WJo47YdOaH3QmbW3O9dvvzFgL5UodK+3
         z6N0Cvjy3Pm1YPmL0RksgDMV4lFPl8vo1L22fUTork1V35khaCE1Vd4yky6lGLZ8DSlG
         MqyZ0NcXu32JNzH0ATy4N8cQWUqy5ewdvYT6D621ll9hSnEQJJMmQDTY7t2oJs9loagM
         u8WM51Vqpi94W4uFHn65HCv0cgMs0BbIk4j+BLv31QS+cijmBpioGyhjPx9tsk9t3UTl
         zbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgsTMBQkj4i5V8YvWiObsjqJCiOfokPNYxNqyWqIyKXvmQKYHKN9ufW0j4U5ZwpMNrnHe9ZoXZTw3IU3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8G9XRf06AOSC/cu2t7OWv4JACJJaqSp4XMrJcows4Jx68aO0
	uOQIB1m+D41cTOmb049kqlb58wD5nytyPieVi0IQksCm8ZkmutKdr2yMTe74Hg==
X-Gm-Gg: ASbGncsTjZ+O0mZWAR8AbU106swcuzsiXqzXwqtOrUixWSd96w1SWGwud7lpAHCEnrt
	h2YgDQBOsxmsTGmf0lOQZDP6Gy2TPY+xHNhP/jyNjdFbVUnCzXnIA3httcfVRAQeI4Fukw7w+XY
	N2i9c4P5kfSijK6znPGANqX5zJjcKR01P3MhpcRqrtRNDGHRU8mEGf1U/vOLGyGUa6MV5OErtT8
	go+bBAprKBl6mY3InJXAOkgbXZG7mJ/VsUDqvsa6Dob7XBFg+mcqSWmHIX/tFSuMXNvfuFbbFLD
	DOb5tg27Gsi4Fj+WQuv9ZPNVTcpI
X-Google-Smtp-Source: AGHT+IH0lF25QvlNGwotiz6cjbBqZqy/AoYoxDEDz8EsANwxf772+wFf4srhmhHPIWngtFbdyB/avg==
X-Received: by 2002:a05:6102:d91:b0:4b1:24c0:4274 with SMTP id ada2fe7eead31-4b1291af18emr998015137.26.1733860577115;
        Tue, 10 Dec 2024 11:56:17 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:00 +0000
Subject: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

dasadsd

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index eaafca41cf02..520f12155e7f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,9 +43,6 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-acpi_status
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
-
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
@@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
 #ifdef CONFIG_ACPI
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
+{
+	return AE_ERROR;
+}
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog


