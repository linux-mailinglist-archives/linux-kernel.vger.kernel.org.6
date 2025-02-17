Return-Path: <linux-kernel+bounces-517374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D67A37FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39208166E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE0217661;
	Mon, 17 Feb 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pc5mzDyn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAC219A89
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787483; cv=none; b=CQWkjG6x8e3LOqFVRGBRKRwuQE+H5EwhCZTLxQajMK5ClcdTcTRdXh1hnZ2eGpP0Yu2VcdhIY5dfae8TMH16TmYjxvtnX/Ey01/LGPdM/V4p3wqICrd2k9x9x33QElmMyhzh2A45aj3mDUGEl0z+rd0MnNMlC0KVogZnJK/WSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787483; c=relaxed/simple;
	bh=CNpLokpmqxK7vPDH6UkXrNYj7YYXuynUbdaQ5h4wAQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHY6C0R+UTgwmRw+a1q5eR7xPc1tZMhZ/YacOuqJ1iDJyx2tMmjH4Fd4zmQtu0lnaBFP2WqQZqkHXZjsQZGJZKcQrl/Yj6sPZbkCBhtrHfOiuGnSmsaP3liQdRl2od53xLFIEsU8LdQ88Dpr0WJixLgBwmhz/6exVHDy/Yk3AAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pc5mzDyn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb86beea8cso248946566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787480; x=1740392280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3eOW8UrFuxRaUp3//DxYdvLP38s+Fnhi3jsogW/ejs=;
        b=pc5mzDyniinfOd1in2GkaK0Fp6HaIaDEwOduwxetcvHN0BwowymNhe2d8ZXcIUFabD
         NaWeA9L56HLnDC0QH2nS6DY82hXS4E400Oj1CjDMUv+UvEmbtvo4igP8AVNrFyLpXTZg
         OPHYeJylTyP6DysKSlW+dorkAFVZxO08qw8bf40jFxlC18WV2kSBO9WXO0oe/ycKpDdn
         L9VjlOhks7Y4pKKRCyc8gh+gy2UVMUIhUvTNz0DcbfLvSbQZfEi0dtVvwQF4UUex/1aE
         6n/XgZr/kUMSADmZglzQCFoRmhjkGL9YpXZTriUxVYb2G5a8cMbJ8ulQvbiu/yFBgi8S
         ad8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787480; x=1740392280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3eOW8UrFuxRaUp3//DxYdvLP38s+Fnhi3jsogW/ejs=;
        b=rQLxUGmutOxZvVfps2+URUNTNoRGWPG9qgYImqRNcoPDg8EoNLCTYK/itdgB7zyIas
         kaMe5am1prRUCv9xL+Vaq6EebxJz2jrhEJdsIVDsw/RPnyRzTHME4yFEfDdBt1K0qTee
         RQwODyOmlHt4gPzp23WqRhnij6oaTBxq65wEE1WqhgLeSko30KDaqBl0yl4pouV86Fmu
         tljJb47T3mlXkRgkdI5HTsa15br7R2KnJkqFn5RICzldkdZfXpCjAPOPp+fLVq+PhCyI
         5PGC5v4cpvPhV9oG5swgVdYyUxx4+yAqyqGwlycTTTHBknTst6deZFlVjyKTmHQDI9bT
         1EFA==
X-Gm-Message-State: AOJu0YyZvluzBUHbn53UTzi5Fe7MYyJtmI6OxMQAg3KFR3X+CXOgGa6D
	BEES26Im0CZbID4pmqeefsnwd2sxUdn+iNfw2Xrl5NgscrMaXs5EnzNUMDoz2+w=
X-Gm-Gg: ASbGnctlmfICwTC8oTM8E28lQlUtYaFS2v03LnP+G7+hCaOCwJCQKep+E20adtQtTkA
	xRUlC0N/IpZ5U5AkGD4AppEeKNA7H690+eERJxNt08ZAIDRGJMSkLtFUw/Df/HwgantSbxlmBsP
	huj3hlv//F4ZLeMf3w+jBgf6qrH0YthSJffzSV89AZjMfBhdXfLiLU/qhQZwqa0eiVLWLpO22a1
	aFWU24/F8mrilw7i3BuACLkJ8qPUie6Soqj/kGbjvTHf4RQzPU1K0mvMyEqqLeg7HEAoBjWlWxq
	WD4i+0V4i0p3FfU0L64E0o/W
X-Google-Smtp-Source: AGHT+IFMyTV+7dHiqvFGQ0qFOxy54cnyzBe3bzzybDkILWKhJuv8kUgpRDn4pTMEScsdo+ewcWeQ8g==
X-Received: by 2002:a17:907:7f27:b0:ab2:da92:d0bc with SMTP id a640c23a62f3a-abb70c01ecemr899083166b.3.1739787479826;
        Mon, 17 Feb 2025 02:17:59 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:59 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 09/10] devcoredump: add devcd_{un}register_core_area API
Date: Mon, 17 Feb 2025 12:17:05 +0200
Message-ID: <20250217101706.2104498-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add API for registering device core area for saving into pstore.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/base/devcoredump.c  | 13 +++++++++++++
 include/linux/devcoredump.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 2a0e0b2fdb98..2cf17b148c5a 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/devcoredump.h>
 #include <linux/list.h>
+#include <linux/pstore.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
@@ -76,6 +77,18 @@ static struct devcd_entry *dev_to_devcd(struct device *dev)
 	return container_of(dev, struct devcd_entry, devcd_dev);
 }
 
+int devcd_register_core_area(struct device *dev, void *area, size_t size)
+{
+	return pstore_register_core_area(dev->driver->name, area, size);
+}
+EXPORT_SYMBOL_GPL(devcd_register_core_area);
+
+int devcd_unregister_core_area(struct device *dev, void *area, size_t size)
+{
+	return pstore_unregister_core_area(dev->driver->name, area, size);
+}
+EXPORT_SYMBOL_GPL(devcd_unregister_core_area);
+
 static void devcd_dev_release(struct device *dev)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index 377892604ff4..9d80e4ac91ff 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -69,6 +69,9 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
 
 void dev_coredump_put(struct device *dev);
+
+int devcd_register_core_area(struct device *, void *, size_t);
+int devcd_unregister_core_area(struct device *, void *, size_t);
 #else
 static inline void dev_coredumpv(struct device *dev, void *data,
 				 size_t datalen, gfp_t gfp)
-- 
2.43.0


