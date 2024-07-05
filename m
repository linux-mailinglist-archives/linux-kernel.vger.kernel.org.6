Return-Path: <linux-kernel+bounces-242058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE1928322
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CD11C21494
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD2148304;
	Fri,  5 Jul 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AauD6eqr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340F1474C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165761; cv=none; b=Gqz0kl5dNG5rGtUQoTCZXtkUM98M266mFY/2HN+14oPudzMDn0A0TR8xRygSthLkkXScd51menQkNYKsQ7EO63OjTq5SzOW+UkGdWSZS6DUDWDfxRgJtdfRCi0YyN/dkWUIptAwS4wencB+i0ykJBiGdqMZgnp9C9yzGdg9+/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165761; c=relaxed/simple;
	bh=HvS834gnhs5PyAS4sXod0ksL1IUfM8w2goWQNFgtWj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVU1HPkID4bCG+ckMZ3oNB6NxHmn3Adx1Sqde+1fDAKKj48nsqNiHIUwDLXzThGcsn6BljOit/T0uvE9tFQ/lhuRExfinG3DV35wi2mdRBk4V4z8cFb7MfXhZz9B38womxC0WIkQSe0ZfK9ULeO/66UAhNORR9m2Cg5z4g08DjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AauD6eqr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367339bd00aso996446f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165758; x=1720770558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8ptIZmYCIZH4/flhXIpF5GExhEPlVju099CxJvkDGw=;
        b=AauD6eqrcDgg7fgWhli/VR6A19tiZYu8XjSBIqRduSOy+gkpaw6JYphFGagc2N7UXF
         jXWO+GLp/dxyq2Rw4nZiaF8EcRBqOfK+tyW9doexm3WAyqXjMR/tvMCxkWYTLPGZ5OX5
         cSpbea02iABULgneTYK6inhhwu3gMhHmRpw1RW0xljaV+YB0dCX4sfwcPWBUJXuLBiYM
         389XdAJSHnJLpFEWzZ6Vp16H3V+/42+WBD9xJasLKanAGL7+LWR+pjIjSMYt8ffJzum1
         tQ0DN7XrkEnEReaNGXrzoZxO8VndXm07MTZbtQCO4t80z7UtHxGbwKHlpggKw8N5jg+h
         Lp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165758; x=1720770558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8ptIZmYCIZH4/flhXIpF5GExhEPlVju099CxJvkDGw=;
        b=CBgPkgDFPXFuY+G25xIHLriuHHXFyvNe2Gr7iNR2z6V1F9+YKldk9oQOVeWRNs2rDM
         e7pXa/Nq9pw8fvdDTuWN+8nqE158PuMopOreihhC1XtwZYFHswj4Ukse60jG4AhGpm6K
         9gT2LJphBlgQkpPIvELa/C5VQuekbQhY+VqRWDrCqSDPWKAzBPbctHjeKWez7y3MbTii
         bYrkh8oK0b5kGmKkzKLIQ0rnHkdreDhp/6SpRoJH3DzbJp4PsTOGnd8MZZGtdCKDTFR8
         ZiBrMbg63I5w5M0bZIhjyrL9eESs4WQmF96OpbJVEvDoY57YaDyh3POKiMMdd8bZVuVo
         284Q==
X-Gm-Message-State: AOJu0YzbGOsNKGflunMh+un6/LvHGuT20xYZtjINZ2j9398YUPJYCSFl
	LMThklQaBqGuLRZ6NcggT7Ub7BokDDxQNFauS0883bmsIWD53aFoba7mc2S5BKB5mhUVhiuh2py
	DpDs=
X-Google-Smtp-Source: AGHT+IGVZdLJBGX7WTg8vWJs+eoOGk16/TWo89XOVk2DXqiTE/4+MU6/n5ssZZGF9O/Z25QQ1XRzeQ==
X-Received: by 2002:adf:fe8d:0:b0:367:916e:4206 with SMTP id ffacd0b85a97d-3679dd67de8mr2629270f8f.46.1720165758314;
        Fri, 05 Jul 2024 00:49:18 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:17 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/15] nvmem: core: drop unnecessary range checks in sysfs callbacks
Date: Fri,  5 Jul 2024 08:48:48 +0100
Message-Id: <20240705074852.423202-12-srinivas.kandagatla@linaro.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

The same checks have already been done in sysfs_kf_bin_write() and
sysfs_kf_bin_read() just before the callbacks are invoked.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 015e6b9e0b60..ec31c1fe9a99 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -203,19 +203,12 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
-	/* Stop the user from reading */
-	if (pos >= nvmem->size)
-		return 0;
-
 	if (!IS_ALIGNED(pos, nvmem->stride))
 		return -EINVAL;
 
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
 	count = round_down(count, nvmem->word_size);
 
 	if (!nvmem->reg_read)
@@ -243,19 +236,12 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
-	/* Stop the user from writing */
-	if (pos >= nvmem->size)
-		return -EFBIG;
-
 	if (!IS_ALIGNED(pos, nvmem->stride))
 		return -EINVAL;
 
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
 	count = round_down(count, nvmem->word_size);
 
 	if (!nvmem->reg_write)
-- 
2.25.1


