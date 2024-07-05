Return-Path: <linux-kernel+bounces-242048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09134928318
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B188E286119
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA914535E;
	Fri,  5 Jul 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHWCx0/T"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B07132103
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165748; cv=none; b=UQQubH/r0XVSgckgvS3LpgV2o1ICBnmJm2cp3wTG6c0s6YpYJO9rdCXWyBrVMGiAJh52GWsxZU+LdL7JS8SSW/3Icas00qkk7zQ/JdTQvD3XeOecJQ0EDMyNWz6Fflin6VO43Jlp1o2p3zrfzDJlnk4kPUCHGNRfiCzMshPlw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165748; c=relaxed/simple;
	bh=daq+S2dia4dvwaxxlF3p0Tm8Gbg6T+UWn0zRTunJAGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnqOa6qSj3cac99iOmfp0gKRX25kQOmpWBQL19pDiyfpgR///vlJ5us9F+ZOB9heMOlZTZiEIGv9kyFxVABx8IM8CU6g/nhEZxXndMPEkmC7+gAlkIPpY10TnSLCVTgK7JNmx26bejJrDpkLlQ5TbJB8UJ6QGHSwZBHYhv2m0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHWCx0/T; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so601275e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165745; x=1720770545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hxM1M3BJm3U77Yss4ewZ2FyzicKkx3LrbIUqysOnDo=;
        b=QHWCx0/TszFe7rm92KMEsr7Xw+JreblhA1q/tP63Hh+cryM3XvoZjY2BaZNT6g5W/x
         EbpByYmlD1GuURLKSq1jQYkhENTScBatldibOJhK2fA3+/PlfOANGuOVmj33qHbNS68T
         YstsUXRSwOcyC4NMchWXuoBNgwa7D1anOg+6SSaBNy5C18mRC2AfMfekkkKJBgG2ZDyv
         KpJRlrkN5MLsLCHWAXi3anbF16q2aKDp1lV9KMgDf5Uo1toyAQ7pOsUXdEtK1/lLuSfV
         CSpk/BQY5VL2vy0Wp4IHGl6nTr1ZlJRD0w7ipbr99NnYgVYp2Ie/eV24b6ml1tHBnEKk
         4Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165745; x=1720770545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hxM1M3BJm3U77Yss4ewZ2FyzicKkx3LrbIUqysOnDo=;
        b=F0ptH9WLyZpebVBUCsrgPOO9v57T234z8w5/yzBKvc9yQJD/PPYVSsMFFNAbonbiDw
         Y/ggAdSbBxo+4hNGKSoPMAhtKFrJ7z4cXgtgVf5o/zx5dNAwgjoTSHVio/gD5+hYOkEz
         bz6MpDA/ttD6FY2Lpmgr+XpYa0rc+EJSgu9d33urlf7+942esHeMivL1NYflreswkj6f
         lEH8XYpH+ZNShouQ94Wb1R/WsUinz+/TyztUrGvZJ3c995eDq3yXZfpOvLS3ueheOU8e
         ecEGxcj9yq900Tg13hWi47BZDdabIKHfz+Lk6I4sFCRNMxssrMu+bKnEkm0bf3e9O/df
         v+2Q==
X-Gm-Message-State: AOJu0YxDnP2Ksn0s/82y9sgSrs9bVshraLSt54ne0zy+m25l6U9BP/OE
	KZVi1Sy0hKDsrHTpKxvbSAfEwdFv+UHdRSYexDqjaaCoZWw5Tk/8mzpsJlqOxpc=
X-Google-Smtp-Source: AGHT+IGFFsvtj4M3Le6TCSXOus3PbV3V5LQWtu+m/+/n2Gcfa1vJ5/K452PpGYyI8u+0c9NX5VtOvA==
X-Received: by 2002:a05:6512:219:b0:52e:9d2c:1c86 with SMTP id 2adb3069b0e04-52ea0636ae0mr2575937e87.14.1720165744897;
        Fri, 05 Jul 2024 00:49:04 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:03 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/15] nvmem: add missing MODULE_DESCRIPTION() macros
Date: Fri,  5 Jul 2024 08:48:38 +0100
Message-Id: <20240705074852.423202-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/apple-efuses.c | 1 +
 drivers/nvmem/brcm_nvram.c   | 1 +
 drivers/nvmem/u-boot-env.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
index d3d49d22338b..1d1bf84a099f 100644
--- a/drivers/nvmem/apple-efuses.c
+++ b/drivers/nvmem/apple-efuses.c
@@ -78,4 +78,5 @@ static struct platform_driver apple_efuses_driver = {
 module_platform_driver(apple_efuses_driver);
 
 MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple SoC eFuse driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 5cdf339cfbec..3d8c87835f4d 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -253,5 +253,6 @@ static int __init brcm_nvram_init(void)
 subsys_initcall_sync(brcm_nvram_init);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom I/O-mapped NVRAM support driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(of, brcm_nvram_of_match_table);
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index befbab156cda..936e39b20b38 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -249,5 +249,6 @@ static struct platform_driver u_boot_env_driver = {
 module_platform_driver(u_boot_env_driver);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("U-Boot environment variables support module");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
-- 
2.25.1


