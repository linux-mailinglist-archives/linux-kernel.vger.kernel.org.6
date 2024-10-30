Return-Path: <linux-kernel+bounces-387952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E39B585F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D6C28587B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAD63CB;
	Wed, 30 Oct 2024 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS/rZlWL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EF440C;
	Wed, 30 Oct 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247138; cv=none; b=FIuNW64rSA0C36rYFKAv7GaLdGhXntgFa++Y1UIP2QVru5upPrqUlFWv8i+NwrEfef+BwYnWmmKeu/FJmTwvxg+MZZImkbnrwyblaknvw2Gxy4Vtc44GkluO7Jdn+a+Znex1gV0uB1dPbAvX8ZbtTDJUcOHhWd61C4x2ZLxR57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247138; c=relaxed/simple;
	bh=KIpxIg/fnyHZfZG3oyQ2rRPQXhqDdJpGUafpYV4GJDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0OzeV7kVeWt+uvXplbS027o7CS5qupcEoGrJhx8VQ88N4EhyUxndQurz36Fr0miD8f17j/oGppuDOgd/iw4JKptbUZy1C9Ft3Jp8T9Bq2UlxQHt5zL8KLz+vwlGrBcIebxO7UCtLYwlxosQjLoQIU5dt22oOWdsXgaPlYuarMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS/rZlWL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ce5e3b116so43416805ad.1;
        Tue, 29 Oct 2024 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247135; x=1730851935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4FHs2xo7SoGaE1iiSF7N0/21QZQb33Tz/rJ8tzfDxE=;
        b=JS/rZlWLPSxY3oIHWZIWnA0I76FQyLQ5UOvwdCmvjtmhv3pcBhLF4qvYJCJL4fXU7y
         NhbifZ/mAK0FT/+adOgBMH8VxjYWLqhWuVZjEWRe3e1gzzhikL0UojyTNiqxcSYHoNiq
         FTmj8noF60CrH9MdCh2PzLQBQIiQsYKn50wTvYYLhuTEydNG2HYqjK6pUYZ2aDUg96x/
         dayHsVfGQxd4qsn2Zhs2QLl0qnBgj/HiTsOrcVD7PRy9Bk0Om0c6trrfd/LHU2HDunpC
         Y56eFcNMMJtRKmI+0NhIZ5Ih6DydR0r4ezRtB7jmG1Lvfw3CvOevegq6mU0wS0CTfcYe
         BCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247135; x=1730851935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4FHs2xo7SoGaE1iiSF7N0/21QZQb33Tz/rJ8tzfDxE=;
        b=mmfHtlZ3KvY17MM/ZOj4vRLmwUF5+vgDjMBpFtPTc+mRnqJcA84GepJRpn6Xbp4qoP
         deMXTYFw2GATD0G19+EJRlwQctEanyruHwK4p8cdQWtX4cR4+19TST4hlnf4J9WdFcNQ
         2E7bN4Il8QpnfW1rNrKsREF5oW5GFMPDz1czzm/WcEAtmUH7PGZHOVyjHYhwtAA604ko
         yPvn1nJuFvHSRiNwJbOfKjk6dIuO2t/vdduYy9CzLux0ms1JqMttszfhVCZtRByQeqSI
         ylgYxGGZUmvsjkhw8i1EZKWchCpfqbbuKyw9Lv7TgcWleNdJrTz5bdVG2rKqL4WxptAc
         y1kw==
X-Forwarded-Encrypted: i=1; AJvYcCVXCKA011plF5XPasucsCL6Ls8X75WbUn44tCsIpNMIvsAod4ntz8eLnkIMrApQaeYPigXNHCaEAtGlwxA=@vger.kernel.org, AJvYcCWAQXLBLynao2PTDxEL6mUDTQTvLxsWAvLxzqDlxWsKehWBPeS0Std+KSfaCJzZvXUlAtnNEIMD/P1jUTHG3oTnCIds6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3PbOybT07ikDX3i8j5UYQ6fW9XgIpzKaTGe1TMxhaUFlbFYP
	pPOLvovHsPanLaiaj0rBZ5edoCQ96qzVTLXUf9MFt/78oSRHxkSX
X-Google-Smtp-Source: AGHT+IHNoCah/wFxLMx1qtL536pU9PZINhr9LJEWr6qIyog9JRNVDaSLVg3c5Fgz4YI2kdxNbzBY/g==
X-Received: by 2002:a17:903:32c4:b0:20c:a1a3:5373 with SMTP id d9443c01a7336-210c6c90e6cmr168617105ad.55.1730247135440;
        Tue, 29 Oct 2024 17:12:15 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013462sm72165255ad.178.2024.10.29.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:12:15 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v11 4/5] alienware-wmi: added force module parameters
Date: Tue, 29 Oct 2024 21:11:49 -0300
Message-ID: <20241030001148.7623-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030000904.7205-2-kuurtb@gmail.com>
References: <20241030000904.7205-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added force_platform_profile and force_gmode unsafe module parameters,
allowing users to force `thermal` and `gmode` quirks respectively.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
v11:
 - Removed unnecessary 'alienware-wmi' in pr_warn
v10:
 - Introduced
---
 drivers/platform/x86/dell/alienware-wmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 1d62c2ce7..d74c6edef 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -42,6 +42,14 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
 MODULE_ALIAS("wmi:" WMAX_CONTROL_GUID);
 
+static bool force_platform_profile;
+module_param_unsafe(force_platform_profile, bool, 0);
+MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
+
+static bool force_gmode;
+module_param_unsafe(force_gmode, bool, 0);
+MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
+
 enum INTERFACE_FLAGS {
 	LEGACY,
 	WMAX,
@@ -1075,6 +1083,16 @@ static int __init alienware_wmi_init(void)
 	if (quirks == NULL)
 		quirks = &quirk_unknown;
 
+	if (force_platform_profile)
+		quirks->thermal = true;
+
+	if (force_gmode) {
+		if (quirks->thermal)
+			quirks->gmode = true;
+		else
+			pr_warn("force_gmode requieres platform profile support");
+	}
+
 	ret = platform_driver_register(&platform_driver);
 	if (ret)
 		goto fail_platform_driver;
-- 
2.47.0


