Return-Path: <linux-kernel+bounces-433848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727C9E5DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC79316D094
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770F226EFD;
	Thu,  5 Dec 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK6pr/7o"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AF227B9D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421731; cv=none; b=UBtxUS4NifRUwsJOz3SXLDGvRBQ8/2pdwSVLZ3YrKowIsav/0nPZxhN4wyP/oOz0RJRZBw/v0PyfIRKzhG1GUuTsqMzhVaKw/3Qq7usVC426mVksdEGS9d4NvzFprEQAMWmYcl4q+sjndHo75oz3xFfOBpji93cW7ucImsBWE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421731; c=relaxed/simple;
	bh=IUPkXPm8C/w63Brb8YlUvk50wh9QYwPKoutZ4V9uyMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMytXwa/Rn4QSDFOUth4qM0idbKVYbT7/k7TfQIPtUVU9Tmjz+mRxwnVxneX5fdSww5DX1d2umoLewDzzUzTf2VMTwFWy8GhlW42HaM2/rzYVuOqVvC99NnBcZwa5oX3lg+ECo2j+IfVmdZqikfq+KzWm6eqtfEKA+enDAz8pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK6pr/7o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so12516615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421727; x=1734026527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fwQWQ8p4fSiVsjGQYWImVyS0fCQtF0Xd9Qrli2C/FI=;
        b=bK6pr/7o77tSMIAuzPNEQNk6I6ZlKh6qlR/HrC8JJqd5ByaPrRuuCrF4Jm6x72SWI5
         YFuXgzHIoCtWYcz2itXPjFODig7WtCv1a1DYtiT89MGs/CGUPEXjjtISgIv22wkbvA/Z
         k45MKjqh184LlNQdTwi1dSO3SXH4xyOrJVQWJQDzAkdisruHo74k16wqnkoh54kfsI3R
         9cb57LUWhGeRPU5bYl8utRLhmb3ulRKKpkRNREMlqdKXdTYxc32w3CGZ0Mao228up2v/
         Bjvlkfq6ge1WZSM7t+1W+pAUQ4KZlrnT/jRIuvH6eYrxEMyktNGIBLc3ycvm7Yybld+K
         7eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421727; x=1734026527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fwQWQ8p4fSiVsjGQYWImVyS0fCQtF0Xd9Qrli2C/FI=;
        b=BTEs8g36iaHW+r0cTlzSyFQafcvs7iLy8X16uNrcQfym086OXT37RBkKJvESrsd47U
         TAbR4+KxK7Eyf4rzNLTiLF9m9a6+L7fpuapC9PO/5SO+VZh/f73Etk68nqMsglV+PQMA
         zPXO0P8IUj+wFyh+/rewrGHTejQdwdY8rmgNWu2M/qnVHxzrlNJ9II6cFK6yP5MczZiM
         8IdbLBlYIM0vWVfVwVyICJdg9F8qlEtxbEC08n2aPpOUmE3fO9dQckOF5fSzgVBTEKLE
         ZpLIJb7GQiqmXXUCgqQHtqa35VNSqDuVMQIb65kXuEXhVXYl5rBObDOVRtwpoeD292dE
         9Nzg==
X-Gm-Message-State: AOJu0YzrQVM15upiUFO6zF9jivT+O/yPJBiJ0uCPx9sAYX0mrcZWpZ+z
	82/t5oWrhN7vmGwmlZNc7B64CEA+H3402/fgV3vI7j6q2WsldvhoTBQDknmQ5DOEkPhHJx2gbIN
	GIgA=
X-Gm-Gg: ASbGnctPUxu2GLfoMDid71t227z22UDuWEkxQiPv9V53J11Qzi8vHSJn1VsaSn4Tydj
	IWye9gEAil7UYPSfR1aJW+arLVD6acnbVb0w4j+fax2oK4SXIokR2r+E8AHGZoOSmqgtDkz49Cx
	GgPM8X1QIINbxOinUM3wZ5ojlfqGnTW9EnvNaMp0KH5cxnj6QU8bPHQHz9KCbWw6MlP5fKMcdSd
	lqhEY3uwk8ntyTqkemDNISpb9uBUIAb9agXTGeuGk6W+CRZh7xtajFIeYzc/qQdyJzII0Mj5faW
	mAQeOGXl/kVheUyquVoAWyHXS8taAk2U
X-Google-Smtp-Source: AGHT+IEF0Sy2Q+DDxTeCkIQlhde+ymelj1BdzVhOSZd3iGZysiBbmVwX72aWK/Yxm+/ZlbdpgcXp2g==
X-Received: by 2002:a05:600c:5125:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-434dded663dmr2047465e9.24.1733421726692;
        Thu, 05 Dec 2024 10:02:06 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098d3sm2618228f8f.70.2024.12.05.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:02:06 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 4/4] arm64: defconfig: enable ACPM protocol and exynos mailbox
Date: Thu,  5 Dec 2024 18:02:00 +0000
Message-ID: <20241205180200.203146-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205180200.203146-1-tudor.ambarus@linaro.org>
References: <20241205180200.203146-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Samsung Exynos ACPM protocol and its transport layer, the
exynos mailbox driver. Samsung exynos platforms implement ACPM to
provide support for PMIC, clock frequency scaling, clock configuration
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..91139b1cf813 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -262,6 +262,7 @@ CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_EXYNOS_ACPM_PROTOCOL=m
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
@@ -1378,6 +1379,7 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
+CONFIG_EXYNOS_MBOX=m
 CONFIG_IMX_MBOX=y
 CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
-- 
2.47.0.338.g60cca15819-goog


