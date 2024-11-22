Return-Path: <linux-kernel+bounces-418042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB89D5C37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850572817DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A951DDC32;
	Fri, 22 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKlev80f"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A31DE3BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268904; cv=none; b=as7gkLFFfU9T7ekLjnF4FD9vcjgtjDOQEJqUOG0hrbSA69I4/C/zKEPfPLYwMgA2mY+4UlXWjQf5DunKODPSEpylIzfPGHc9a2fAllU2U1GZOYjF+16BdvJleUwZnpCRjNWpYuBJJPyonuP470g00Bb/qTbBBwYQK6ewIaoTB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268904; c=relaxed/simple;
	bh=sHpIqPIcR2Hbo49SEnSkc9fxU6SdQ6Gky5F7X03Wuxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/qKnHA84PbN1JOE3guR93VvvQsrEV/cagqXzrbI/AhwkkOs2UhukxbnV32BAdV5etrBrFbMr/bkZwXTiDE5RQIt8sliy3UGYGn3FqKSeW6N5r+kohFscamYivmrWqxFxpVjruRea+/eWZ1NTbOfzFj05WkegNdEr34oPQjHExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XKlev80f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460ad98b031so12176771cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268902; x=1732873702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=XKlev80fU0zJRVhQchANLOn003FtfmXIhADc9RkN5HhvL4TZs5vbqbSQTSq5LIZfsI
         jrLrxLYzGBoOBXJ7uNx4hLU2NItVB1JtpZ1tc7zy45EFMLjAQSWKqWLohz9SKSedIekJ
         jF9U3fl2dxHT5ZhqOTnrcvZMKFQAO+Ej1xqAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268902; x=1732873702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=tBoJP02IO8alEshnHmMRTQp8XrBsd/MrVDC4D30vbKZvcnesZPm5Qa7qgeeW/fpqyg
         bNH2dlZy941e3lJfFuDypg7/4vHoBJcnKE+wRtFqpgRd/skrRNxmYcrpU7pk44Zic6vC
         NiV+KlI9PFEI0Ke0T/DsIeu/+Ri8UFZBtM284Fcy0Qy+GSuYH6pngFjjTrIEsJ88GRuz
         NhbW1/GhA+NvWuQaQ8rC0J0zP3G7IUTIT0AL4mLNDgU+gZcdMpe1ERI4RdIN8bNEe7gt
         kV4ltzWGqIdl8Zc8b42645SqjgAgCArO4Pla9rp7xQisIsU4aUORjwaLp3JEPcNdCVKR
         DpTg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZmpPc1sQMaYOno6ngHZNyi2z8OrcZt7LLSybfeXk0qCgFUB8Su7kW1EUgvMfdteMg3LYDG2pS9g1HiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfS7nO3PqRUROSL2PREGyJN2+uVuhdxurP36Ex2lBKVKvDaWQ2
	IVTvw8MwEdFLm9Yx4aLDwiR5OgiCo0i+LSspuE+LdXTz/YeQF8Zu8P8msYNo9Q==
X-Gm-Gg: ASbGncs6Fes5mIOYOWN6uC+OYHL+nBKp2Vu0/wwR3js6IweEz07NrQCcqx4t6OlX9tZ
	9i3oSHaYwTCPY/XKV7x6QrI24xk+weke1f6onUlzRaf3tCjtgPEKTUw+wjDvX+2u8mQxPsiW7N/
	zlZx2oF8Mg+9B+GgrqBspgOipS9O3n8ISQbLf8RFdVuXZRsNZmKxiC3jXY9teqcUZjvIZv02xz5
	qfPd8yZxTUF8+uD1cLCqGbqAiJJeNqxQZVLCifjQ9F6fvkVH+PUB+rrFWvkawaN3YzFP3+qSZkj
	7yLGRClmj+jsG4ws/glXxZ4F
X-Google-Smtp-Source: AGHT+IF2+E7hA5csqndp9Lp4Yhj03h88SxplMlYhJShe/LVL3nGthWIokV9jzsEcGM0TTVk5jNqFjg==
X-Received: by 2002:a05:622a:590f:b0:458:33ce:dcfc with SMTP id d75a77b69052e-4653d62c171mr29716911cf.48.1732268901824;
        Fri, 22 Nov 2024 01:48:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:59 +0000
Subject: [PATCH v2 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-2-bba65856e9ff@chromium.org>
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

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..eaafca41cf02 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv);)
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.371.ga323438b13-goog


