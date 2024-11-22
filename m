Return-Path: <linux-kernel+bounces-418046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF69D5C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89341F2112C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292721DF25E;
	Fri, 22 Nov 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGHAPEzL"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872F1DEFCC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268911; cv=none; b=XV3jIbdUBRLmFfC4Z+V+gWYX/Fw1qcAfTDrUk+CRxTlruEr2El/TLYyPmrlSJvnW8IWro8OlYUyn4du4gNQoFMRcmTBRy3HwDjCeWXXME+93NlrGN8RAWYuN6ZsvDfh1wSuajeWFexfPWwTuQx3H8hwLU2VWtnlQXbiduSoJFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268911; c=relaxed/simple;
	bh=4cTEN9eOVpTN9Nyc7Cl2/7/R18o2ZkyvA49rT4c3S24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMM5T7W3Fa5N8wMbDfBGfJg3JdH+UNGf5ZourFO1Chh9+PV0eysojHskgM9w8Sr4NapzkPLb/wKrSt4KlyXFNf8xT3jvn5fMtJ3u0naNWWFi9WHDvqk+8RIo1iYy6AFUA66mpwiSja7ewstvGc5sv+6km0EhOnVA3SJeD2p3am0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGHAPEzL; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso680318241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268908; x=1732873708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/QkgKOmc9/c2cCjRI19/30uaM7Ny2Es4XuDA0KGTSM=;
        b=fGHAPEzLf/8i13EPFHoTmj473H/jY0wXpMLEXQ6qPP1kqgSowGlK9ov9Xz2q43SUc0
         hdNUQlHFpKUT9LcEoTIKnuN8ChpDpvRqYyzLvRvpm3xCgIwVn9hu5TOl7KiBhusTzigt
         fVIawulg6IUZGsEB0W2zeJKG6vb7bcKkAXDp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268908; x=1732873708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/QkgKOmc9/c2cCjRI19/30uaM7Ny2Es4XuDA0KGTSM=;
        b=PgyaU7ZLz3dfDMLkacJO9bcAxQ6FN/39BnsEF0hoPF9Pz3a7pjJDzhIk43mAtNTS6n
         IgjpP5o4gIrNbErakKqT6dzSvU4038JubZlrhGFSFaNDpI/2QwBG6XLRa/QSm3p2dGNv
         5xP70UZDJDQOzt+7LiyMXQ5+z0DRb3t3CFp1RS4PkXSdet5rd7ISdw6q/obacHhGer9T
         9SOySRpqL0gFN3hvX2ZvpgLCO+FcIuJnKARFLdZi4F0j5bEMonLjLpXOQrfSL5/A3X8D
         1DSPIoPHVGw7d/WIuc7vwL3NsLaLExneOsJLPXYJIpvZYPeVoLVQdd5FyzF1i369nWia
         v2wA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/vIlGjs9L0+7DnjgbYA/t0ldk3zm5Kx0Ccp6P8P0rgauyN2Owz9ZMuvdODCCMecadI8mJQpPM3NGQkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIxh1sWDXLklMmCql0wJsVybi2AGursrZpCncbk1TWRxePCXN
	u3YQ/LIo9nFJfPyfnVAWMEU4HL8ULPbrGVQVKYOpl1SVYuK2FyU2+HSCdsZVRQ==
X-Gm-Gg: ASbGncvwW2cJfMuNcP1b8L3KOHNMuuIWhpFedIQS4T15PfBPfyLE6igK0q/gs2kBIl6
	KhMIG5MvRfCEPgEGhp9AqZJ4CzqI6M9skGNgUfQhD9LDt81AUhAM7ivwo+EvE8okS5yOppMU23y
	j1ve+RvQHZUtNSDNgRudWkgQKxa7WgtKL3KBXT6eyKuIqgIuFmE7Y09SXm+RmYLaGkI2B0HZmgY
	bewRfs/uS3l4NIJg03gbeFEC6xsKyiTbiDCcs4RBKjSYQ+ctwmD2jVPq/4gyiwAQ7O5JUhxOGD8
	AlH8Hp0UoqESgJjCneJr3pUj
X-Google-Smtp-Source: AGHT+IFUbTeZHYJsenOKlTvdD0U5qrkMPADbncarGrIZ0AbdaxBfQXQNtKr0lRUxMa4p5cx4/MlDgA==
X-Received: by 2002:a05:6102:374c:b0:4aa:fafa:e100 with SMTP id ada2fe7eead31-4addcecef0fmr2390924137.26.1732268907770;
        Fri, 22 Nov 2024 01:48:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:03 +0000
Subject: [PATCH v2 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-6-bba65856e9ff@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 57298c7cfb5d..cb1b38245f15 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define acpi_device_hid(device) ""
+
 #define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
 
 #define for_each_acpi_consumer_dev(supplier, consumer)			\

-- 
2.47.0.371.ga323438b13-goog


