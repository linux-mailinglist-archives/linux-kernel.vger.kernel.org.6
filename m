Return-Path: <linux-kernel+bounces-243051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB569290F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A752283F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7AA7CF33;
	Sat,  6 Jul 2024 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ka9pMRTO"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F9763E7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241845; cv=none; b=EM4eXF0jMldrTr64QOu9HRJFe8feK+nTBd+iUv9JWpOK1C1w18pfa1PD3PpYIzIwrp7ykwpzqM7Bsce9p4DPiN+27Q9//PG3vE1Rc/ATZMaXnaI2QWt5Qxve6DfQT3nO5X7t6rWJIFRCnvnJtabGcSazKk7BPmi486SaXheXNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241845; c=relaxed/simple;
	bh=HcNkB8JxsPku3lgBoXrRyLCr/wQaOl/b/A7+lr8k6+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa9aOBlnJy4pwM7Zx70owODJfV4dDsqjfIlw40Aq1dwT1jpjC5zakf/pPDUFyBn7zDGtZ5bn75QE4+EbfgERk5nSf/JE6ZBhTu84cIulun7KZPYerIPsSgVmHDlad1VenxwreXgA56VRvwaYz+GhOAwxStNis4aAcCGrQNErjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ka9pMRTO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9234b77dfso294099b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241843; x=1720846643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRl8rO13pUtwD5y4kvoIkAPkStq8x/JmnNOrgmlShMo=;
        b=ka9pMRTOYpSU3KfzRzjy1Zo+pimB6S6tZ8vFvXRkIhopCmvmkJOpN/qabjRIy76mDE
         hBujYOvn3YQam8qDiOQDOo6sSxM+b9JHEHTXUH6Nyv3KL56GFaldKoKVzoNszCYjqKsw
         Zj8n0AyGK9NKxw87VmrYR/uq09rg2J8PLkNtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241843; x=1720846643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRl8rO13pUtwD5y4kvoIkAPkStq8x/JmnNOrgmlShMo=;
        b=nJ6PL/flYRpYeKqtz7/6rqaQkYLLT80Kk75E0yYrOKkrA24gNTu1AQNfjl23JCayJB
         2DyRlYZC6PyC3+UwTc/+8JG5ywlTs+uP+DPBvTmOqIXiavHP/e1dKHBh7uH0el5ti/ic
         jpwEPchdvEqj+8pemjz5oSLtYsxbCLZTE1Bck+d9lULUqS5ILKiLTdsK5aC+OrwsDQzP
         giYANP/wGPR2Zq1G4dSnIo9ZHyC1AMmv04MGOcFSjDuUlhGTjCyznMhVpwb6z+vrItBH
         HfriLCS+oDRv8hfBriJNANvOKjBNc2tmW+XR0jweQux9WZVKjWYstZMk1IJe1v76Vd1+
         HguQ==
X-Gm-Message-State: AOJu0YzExjWppp/EAdWMIo3whVTorE9twfo0rZ8aXGp6agz3341/21sd
	C0d4TOfOgikMTiPY208mIGMPZykMHRY5m7PdSRH7+7DwMZecFgrOMQS4R6BEhQ==
X-Google-Smtp-Source: AGHT+IEa1DFVnS7VxDRrsxAhjdMjQcszmyX5KHF6huvxiCujMuKmb83PI1C9BnF3Crsjz0oijaETiQ==
X-Received: by 2002:a05:6808:13ce:b0:3d6:2b42:82e3 with SMTP id 5614622812f47-3d914c51bc2mr7099384b6e.4.1720241843098;
        Fri, 05 Jul 2024 21:57:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:22 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 15/23] zram: extend comp_algorithm attr write handling
Date: Sat,  6 Jul 2024 13:56:17 +0900
Message-ID: <20240706045641.631961-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 +++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 84757f0c8166..a2c23ca033b5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -998,6 +998,12 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
+static int comp_params_store(struct zram *zram, u32 prio, s32 level)
+{
+	zram->params[prio].level = level;
+	return 0;
+}
+
 static ssize_t comp_algorithm_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1013,9 +1019,43 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
+	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = comp_params_store(zram, ZRAM_PRIMARY_COMP, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
@@ -1048,6 +1088,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1068,6 +1109,13 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1076,7 +1124,9 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, prio, alg);
+	ret = comp_params_store(zram, prio, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
 #endif
-- 
2.45.2.803.g4e1b14247a-goog


