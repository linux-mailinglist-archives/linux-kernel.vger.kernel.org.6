Return-Path: <linux-kernel+bounces-441621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00159ED0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BC216770C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99811DBB31;
	Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5TS8ffB"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FF1D9665
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933244; cv=none; b=etMYijLGTZOCBNMy6wy3XyjnP5ckoL6FJJ3c0Hq7nRXrjFO6RwPA7OdsCnUw0moMo0HOWkydeaWA8HHBGFYgePKlc660pBIeL+/o+e4lTxFAoZLJJXnV8xtdDo+UgtOMsYbUfWOgEcouBhezpDOtC5IWhZuRj0cBh4CLkJMQkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933244; c=relaxed/simple;
	bh=Kqe+G/l8nHfp8psC13t6cysIquELOSvwbRiUrehr9ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hrm5bXPuopxPSCbpg9lyw/uXdPmV+bh76v9MXc5FBlJsPJoWHgHOkGVBCd/wP2SlUHVGDHoZDryV7Bso6qE3mQa+Wl/Rg81B3vNRmC4MGuw4aWzW7RnjKO0i7MPPwd089G0D1rAKLv7F+f2gHCoVgLiM4tItR0nygHuqRLlh2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l5TS8ffB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d89a727a19so7788766d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933242; x=1734538042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=l5TS8ffBdfP1JSSz98T1X9wrtUMJYH89rkasMjLAv+aJQ+MyEBSWmYEdTWKlXOtRRU
         VXAGVR2hzdYTgl73KDLBaDvOHHb6zDegiRtCNVb7k30SbTNDTGjZ9calhKeYhm15T5OA
         c5bOlgVxxNnKgstRaDKyX92W15MxKsq5OsDxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933242; x=1734538042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=U/8AZs/BVKvZ03Y3Sa3rFpimXqrzyJ9iTjWQDUZV9f5NTI7daxMjj5S7jaZ5XsyV2B
         FSlmiOFIL8G4yWvf1heDKVMUoeiHCaeM014Efxl/0GT+f7RyUhEmOwdGjO6D5vfRfG/Y
         Kbp4huKHmcxf/Gxh58y4dCCgI77+zhmJRk/UrZgQTPUdxL2zdP/mkt87OPblwCC4YzEv
         EWQK9P+YGBsD2rEaQblpf6KqhLQdHOWA9fq+WN7i5mwPfoPNt6XAca6p7kKhX0vwD9TG
         UnzmK2rxcclDmdtp/pyp1+3/bdJMaqmcgrqZQEVYlToVGulbVVdC1XvqLqgGi9qRWfiL
         mLCg==
X-Forwarded-Encrypted: i=1; AJvYcCVNeKJPuodb2T3iaNG0BQuEWojWMfBNRrh1h82wyxF2gWwtHV+q4214yYpn45zKMrrrMgdTi6Mfuqt3boU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7OkFMvLOI1enBQE+3V/3YSojvsYlLb3JiUEhhdRnFyhvPfSC
	UucyRwLW5eUDTdGzQk6ULw0zN+SKTwAQ8xwlkyh467qSwZ3mhgbS2dz1I5myYg==
X-Gm-Gg: ASbGncuQ+nZfJOfao3lWme3J9rJp27sJvSsHNAZ4PE8B2TkMvQL3VlH0vezQ3AQBv3b
	ZdG7lHv3Zi79oSLH/jPLZprphCMarKNqNW0aTZJoTGQZpGC5yAA6uYJEJ5X99mQNb1PS1g28zxu
	8rJHR7OeQiLQa6DtWWoStKMwzvCsOC8EzUp5CBykTYWsoC6lxoGVfO6ck6tsUx8AFnXJ14Qf244
	wreRFvzItK8nVlOlMDAY2zRgio68LfgkUNz1CZapzDHT36bBvnD5wRAVvhDd6MONoXctkEtoPHm
	viKEpy6oRgNzrJcY/AYxW77o/QW6GXE=
X-Google-Smtp-Source: AGHT+IEtktKFv3qaTtZ9OL5m9Tz4Oa3HoUJP5EJ7WrirQArVIj8ul98ZYjRW1cJOo6oehSupJehWdQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:b5dd:7699 with SMTP id 6a1803df08f44-6d9352f1ce0mr58803916d6.17.1733933242384;
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:18 +0000
Subject: [PATCH v4 2/6] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2b09e513ecf3..b312a72f48ad 100644
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
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog


