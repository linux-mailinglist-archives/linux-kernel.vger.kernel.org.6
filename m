Return-Path: <linux-kernel+bounces-240628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012A927019
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706F71C213A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148B1A2C1A;
	Thu,  4 Jul 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEHGGDgX"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685761A2C09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076062; cv=none; b=KVyoF1iohdcn8Fj6gIp2AKxSe4YXakhmIU5Wp8UnxdrC5ZOBWJ+hwTWIMoihTTwOM6dzZaAv8Vpi5+KBNcwWuaZFvQ4LTb7wPEynVMvt5yi8CbSLSVkn5cGW53F5CQT4bh0c107QnQ9YVYX0QGRKwwR8ZJJipYPzNrE02S6LbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076062; c=relaxed/simple;
	bh=p3g4yOXFGrC+1v+U9pGXCG8xiA5NUBZG/HMlE2fajnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=te3R338CKFEbLM4tgB5aj96boX4TD5zTLWQSxKUkEN0e+PuZBBEqKXvWep2JJPw8FRkBVB4Por54/CNbAN9sx5QxSa4G1kGv5Gxz7wgCXd76R3WlcEvFmHA3QjUQ028nMdmcM2c26y+M/54kP32IwseAk1N+nPB/CjeWh13tUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEHGGDgX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-701b0b0be38so257928b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076061; x=1720680861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6xrWhuQO/F2V4yv6AaPs7D8YwIWXmiw86tXq5hUOyc=;
        b=gEHGGDgXeN9uRQ5mQw8cfJZXr8+lNd+O50G9phLkH7cV6VUefbWGzTnZzw8SMiPj/h
         haHP+74LUYBFYjrbSRqTB8X2sevpShKRfg9O4yNS3ljN25xpXnK782YUiyPmQ6LLnWKg
         JYFmMgwU80Ako40+PKnfCvTLHMKSLMkrSQ6ED1Po4DZ0nTUWJ1RC63/FyCCjn9KapZjU
         +VmnmJ4AQ3gSbiDe49qtTcS3lk4kEJ4GFaSE61DFYFoAuDBD/XGFmpVk68mD+Jpj/QQW
         eQ9ZX0avPtt0/XVYuCrXmOmJxJDqae++fub3eo6mWONPs+FArLda2GZ7BkZchegEuUcw
         nrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076061; x=1720680861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6xrWhuQO/F2V4yv6AaPs7D8YwIWXmiw86tXq5hUOyc=;
        b=JQ59BBmSHjd89hpHpn01iH0X6WmUT7qhRtfU2o/bExWutA1D1MfIk/Yqt+w2l8/CCy
         ai6SmmE4wOD+8Va4dswHsgv2551TmxEPeRw70kqHx49ubpk/uMhkFaXr05y6xdcWPkSZ
         Xh8eUjJ1Lr/XtOSZ6tMAmVaqySt42i5nG/mxj9ElesR/0Ou8DW9NAta9wt7BgIL7uBbJ
         8gFexxzF+UfwLiYJ9BbujGiwjiBH1nCRIlczlGtyjZBHaNjhbDn1J/KF5/A3lyiXIIvS
         3RmQNodlMDLQvDX0VoLMCZ2D3sC89xr4z2XmtqQmYME/hMEapX1kd5O/X9vJbd+4g8uh
         ETZw==
X-Forwarded-Encrypted: i=1; AJvYcCUflfnQy7tHVu74umOrGmTPNXezxoXGSDMbL0jzfEtApyHS6H2WwGLfRLdO79qGAnwrwEKZlBrerjeJxP0/PFEDsiRp/ZusSvlz9FJG
X-Gm-Message-State: AOJu0YylduIj+YJwFrIMkYUv7dkZGLiJi+xaWZPu5qwpLW1KHef0AwLc
	QC84WBJQUjj332PCqYPmsKes3t2UL6D94iEdWpLHQfvNxfcOg3NlFzdAZcFdhWg=
X-Google-Smtp-Source: AGHT+IGnPnbN5hoDog45bSFXx983A7/UJMbl0GjEfYUbedd3XUIpEPJwHqdYZ6FsK+nT7KO4hY8SRw==
X-Received: by 2002:a05:6a00:1784:b0:708:11f:d151 with SMTP id d2e1a72fcca58-70b009695cbmr851143b3a.16.1720076060590;
        Wed, 03 Jul 2024 23:54:20 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b03a9d996sm245894b3a.96.2024.07.03.23.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: pcc: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:54 +0530
Message-Id: <02fbaba9bfee5814b2446a747785746fc242e92a.1720075640.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720075640.git.viresh.kumar@linaro.org>
References: <cover.1720075640.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit() callback is optional, remove the empty one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 6f8b5ea7aeae..771efbf51a48 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -562,18 +562,12 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 }
 
-static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver pcc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.get = pcc_get_freq,
 	.verify = pcc_cpufreq_verify,
 	.target = pcc_cpufreq_target,
 	.init = pcc_cpufreq_cpu_init,
-	.exit = pcc_cpufreq_cpu_exit,
 	.name = "pcc-cpufreq",
 };
 
-- 
2.31.1.272.g89b43f80a514


