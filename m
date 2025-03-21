Return-Path: <linux-kernel+bounces-571433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C23A6BD14
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB03B7380
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3115530C;
	Fri, 21 Mar 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEVOUwqP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC921C863C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567731; cv=none; b=jchUbSMKw5zhOyyKy+sFLkNbSqj2GeDH84me5MCCT+8KIiTN+X0f1SXu+54NSUZ3f99W9kF43Mf6sZsmMwpuQgb2iIMIdXPXvxgHkVh0A4Fv1NjQLae/y20d+5wO6UaaOj8P4CPK4kIyiUydTGTOp1cNapeSx4EZVBvfaj02BwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567731; c=relaxed/simple;
	bh=Isvn7ydRNc9Mk0jmBqV2imH7i9rYp5Er5f4uLrHFcZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pdx3BXHDIaGVyaxcOlyV3GrH2DCHjnI5fF3oEoZHDVyA3SRotdLZbyUT7R+kcrvKouJaKvMMqOqHajUVfqvS/bomKrVjCO+KtdUBTmhbIo4sz+jU6UuKEBjR1pXohyKcGLjzOH18kOyLE0ecFVT+y1h92rZLu+LgVZdzJcwBqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEVOUwqP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3996af42857so2084912f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567728; x=1743172528; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpObnI5CWZY4zn2RHNz53FQ4gJRPrxvKsQP+9BpYcsQ=;
        b=FEVOUwqPcx5H5bPXY5GK3e53txtdgZJDHDfqNfZsb6pit+Q6K4VZw4bv0JjnorW+f3
         a6TN9f3SBPDvREJTXvsrLBlwofrdXBu0LiIxKpUB/XQ1POXM8JfanwK1XQGcoisiWAC2
         bkEIBLXL7aReP2iTJZzkSXN370uZC/cMOB0m/W0tzPNTanvJplm38o+8il261qHQTJJJ
         dG5029aDf/xdUFRfDTf7OcSFJH8t4vDkqJYKB5rOyFU/MJE+G1dtHNa0p8Hp0AdEzlaP
         SXT/Qm6oT0SOtfF8AGKnArF4Zwx6Gry2/q9TTh+nUue5eujBHfWEMo5P3bJON3/YMPGR
         BObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567728; x=1743172528;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpObnI5CWZY4zn2RHNz53FQ4gJRPrxvKsQP+9BpYcsQ=;
        b=MoDV1gvSGsVrXRTa6cy2oaUH/PkHfFsAL8csIFbZ5qkzHsoSSRK22ILpOnC0qreojj
         KfC0iG0Gz1Xuq1hUpNYwD/j4YZWMMsm+B7RskNx/P1aMz5N71aYUuyX3rZD7c7Rf8XRe
         TaHxSXl2fQJv4B++b/JXyy7bMtfoj2PCSoX1YM4ScYhBXEpxgFWg/+0R1i1M5REP944z
         uMIGZ8zI2OLEeoCyFKyyW0oZfgCjXCTcoxmXaxIqu/euNuTyMSXvH1r+yMFyDUD+qRgu
         oK3JbyEgGLoMHi/ZAQr4RV1OjUXBHmG2qcHNVCsQYzaY1Em+2FXzt/BowRyVAKnW0O35
         Bd6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGv5D6u8Hyu0MACqhsEjD62t3HPj/MofoOx+h36GI+0vjOl1u+2jTr3kkBkgZHFKA8E+Guii/MyFISPd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLxv2Bo0u52EAiDVoeoLkI7jua0eM2zdGIr5+RcyW2DCwt/OZ
	n6WR2cviyXd8mz2vp1Db/DqwGYFwY1kz79Gnczwtnq5UHbMUZGKLKZl7JN5IwFk=
X-Gm-Gg: ASbGncsdviKfFnrkPqyxLMbL+YUFAByaH3h9UtPbAf4PZ++lo3yIgeTAOQ6+kKStjaT
	3Z1LFGRs8JuKnJZneFCK7IVbjJrx1Mks3oZwnoZt+o22iOUFdqngAYjfnCM/edh4CsvMacnjsvR
	k09WE7uXFXmkltlcuPGmksI3TQb6N0QQx2gCQXlJdL4ko7kdr91k7OdOZTzNW+i/9fkF2j9Hpo5
	qBV9W5cOC+TXRGkPZBiV+zKtZuhbf3fn8uYC4DbcPMFN7jmhiN4i2FL0X0jy7XZaSJ7v5rZ/7BL
	iL29fYqFOVG1xRk8hxua8nE/+G6t6waTJKRBCBeNGVKwcUj4ZWeyXJkuMCtu
X-Google-Smtp-Source: AGHT+IGFDNIHBWCzsRoL4N2P5NIU7s1oc9Lf7MrF47BI5GNVMNU0v7aRuRhv89k5EDIHXs8yNuMIBg==
X-Received: by 2002:a05:6000:1548:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-39979556803mr7439315f8f.1.1742567727661;
        Fri, 21 Mar 2025 07:35:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d3ae040f9sm83159355e9.0.2025.03.21.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:27 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ASoC: sma1307: Fix error handling in
 sma1307_setting_loaded()
Message-ID: <8d32dd96-1404-4373-9b6c-c612a9c18c4c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are a couple bugs in this code:

1) The cleanup code calls kfree(sma1307->set.header) and
   kfree(sma1307->set.def) but those functions were allocated using
   devm_kzalloc().  It results in a double free.  Delete all these
   kfree() calls.

2) A missing call to kfree(data) if the checksum was wrong on this error
   path:
	if ((sma1307->set.checksum >> 8) != SMA1307_SETTING_CHECKSUM) {
   Since the "data" pointer is supposed to be freed on every return, I
   changed that to use the __free(kfree) cleanup attribute.

Fixes: 0ec6bd16705f ("ASoC: sma1307: Add NULL check in sma1307_setting_loaded()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/sma1307.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index f5c303d4bb62..498189ab691c 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1705,7 +1705,7 @@ static void sma1307_check_fault_worker(struct work_struct *work)
 static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *file)
 {
 	const struct firmware *fw;
-	int *data, size, offset, num_mode;
+	int size, offset, num_mode;
 	int ret;
 
 	ret = request_firmware(&fw, file, sma1307->dev);
@@ -1722,7 +1722,7 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		return;
 	}
 
-	data = kzalloc(fw->size, GFP_KERNEL);
+	int *data __free(kfree) = kzalloc(fw->size, GFP_KERNEL);
 	if (!data) {
 		release_firmware(fw);
 		sma1307->set.status = false;
@@ -1742,7 +1742,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 					   sma1307->set.header_size,
 					   GFP_KERNEL);
 	if (!sma1307->set.header) {
-		kfree(data);
 		sma1307->set.status = false;
 		return;
 	}
@@ -1763,8 +1762,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	    = devm_kzalloc(sma1307->dev,
 			   sma1307->set.def_size * sizeof(int), GFP_KERNEL);
 	if (!sma1307->set.def) {
-		kfree(data);
-		kfree(sma1307->set.header);
 		sma1307->set.status = false;
 		return;
 	}
@@ -1782,9 +1779,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
 		if (!sma1307->set.mode_set[i]) {
-			kfree(data);
-			kfree(sma1307->set.header);
-			kfree(sma1307->set.def);
 			for (int j = 0; j < i; j++)
 				kfree(sma1307->set.mode_set[j]);
 			sma1307->set.status = false;
@@ -1799,7 +1793,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		}
 	}
 
-	kfree(data);
 	sma1307->set.status = true;
 
 }
-- 
2.47.2


