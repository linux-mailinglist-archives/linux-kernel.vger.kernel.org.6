Return-Path: <linux-kernel+bounces-418043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C69D5C55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F42EB228EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6431DE4D1;
	Fri, 22 Nov 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHtnu3GG"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321601DE3AF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268906; cv=none; b=jfrZZ64JzIwfGkpn+gYlpjfj5kVNdGe/7l2duX40TAvzpz+DWlobGi0XX63clRYVmdUsRiNhteHGq4lsW64hCnKPn5m1xD80710bP0GWXAx6AwkO0Y/CMLLLYTS+/Upb0VHS8ha30MLcIcz5dmKfCsNNoNWba/LJs/ZmojmwygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268906; c=relaxed/simple;
	bh=s/RFQ8hC9e/8cn1SLTw55cw7d/tVQKC4RIk8exh03Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXq/rmrOo4K1jLSgdKSdp2h2fQpd+0Mvmzkfaq6xPAXTkXbaF8hFSv1P4WU5yrAdJ4wRz4bHWf0SQcjxUJK3xK+10V+Po8OvUgl3V8vtasORGnM/hhRpzy6NyzXT/Wnq3ruU+cmY9/CY71ZAD3KHfsZufMBGHh/9JOVvZQYD+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SHtnu3GG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609c9b39d0so10329741cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268903; x=1732873703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG7I43DMEh4GfUqzQUdimZGvwsrcdmhPZLNEbgcg8ic=;
        b=SHtnu3GGz5BW3ctFws7PPU9Y6sM2ikaYQwI90aL4/KAKHuMxMisBrBzHwgN41RkxO/
         ID+aTiMzKpRKVkjwWxFjnDP4NSzWp87Z45FqEhRp8vGcOAMOlaw/vy+cEh3y8LzXKjE5
         t/AmNzdpP99aY9TjJtU7KUHlhbvU8vtItYTSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268903; x=1732873703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG7I43DMEh4GfUqzQUdimZGvwsrcdmhPZLNEbgcg8ic=;
        b=NK85QDvAD4LNtktcVJM5fPUtXwNSJv+igAahi8lv6i0YVwfE19pGkTJ1PkCBFS8rVm
         2A25s0CnnNv87H1qsXlC99bgB5zgXD8xbywWdaOTlc8CrRjaMAbTAtkQOaLjbCU22BJU
         Af75xz81i/X25dnlSqsjuzl2WNFvVpUqhDEjfSfIthBs9dOKft3VgT4bCT2dfS9FuaDB
         nRKp6H+/orA6K8VLa/gMaaIoO0pK3yejAXSQgm48vfuJDM6pkF19asxbj43Kcd+fB4x9
         uXBThjC8PWpePSDulTaGwyY56YPilM501Kz/RD+oHw5fGyfwEM5JCSgglazPvmdjVoDO
         yPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXRSCb0SSNnaCOSDZv65p0a7alBVYHoOIUDFGFBU6dGyUZz+/2aR90lzOUL6liYDqgW7Cgqs1tG5btHSwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtgOkaPNrvxysbLCcNcGlAsom15BykyAFLfEvWuDjpGxsH/Ud
	dV0esWZ3sxW1lkvbjFK6S1OgM5Vm2XQgWv16uL5qB6RFQ2YWfSmmF+VTYBQhsQ==
X-Gm-Gg: ASbGncuMWThDP5trZpkj2b5Ot7TVPRUmvxUtpoZNwp7b8F/u3D7eOWJzDoZd/O+fbI0
	l/WbbPWbTyB5nYW82zYOqYlpYOE94s3vFp9eUlRxWCYud1I5Ju9Yns1i4Q6OYd33sJ4ZM40z3Qc
	DsnjV8qg7Zpunqb8XnYuOqTShuCT2fosNprliWxpAIPBfbjH69C+Lgziadw/Mnd9vEH4zco9jMM
	vDGkc14OS1CTrtXjjczlYgGtqmZOq09J3nC8VettSx1iHw5z3gqm/hLuh51EYos2tySdAcSo4SJ
	2PFkRG4CrT6kP6WexTVxOc7R
X-Google-Smtp-Source: AGHT+IGMlQYEruhIl1CbTQvmldwCNjhRHjn9f7tEPvnZRJBnvQVCS4h0diiDqwqoJ+Hs/FtxPNpzMg==
X-Received: by 2002:a05:622a:5919:b0:460:c2f3:7343 with SMTP id d75a77b69052e-4653d5af2dcmr28382081cf.28.1732268903212;
        Fri, 22 Nov 2024 01:48:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:00 +0000
Subject: [PATCH v2 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
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
---
 include/acpi/acpi_bus.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index eaafca41cf02..4888231422ea 100644
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
@@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.371.ga323438b13-goog


