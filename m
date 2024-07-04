Return-Path: <linux-kernel+bounces-240626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E189A927012
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5B28580D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B711A0B11;
	Thu,  4 Jul 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRBavK1J"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C31A0B10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076056; cv=none; b=MQflDSpTy2OV2NsngGai07x3O2q7+HL2ygHfoJxJqHYrRX944HmsCVKwCKofqnWCKFpqWuEFkeLDSErwYonmBv0fasAx+AWz8XjM1Z164VLG7nJfdclu06hv6de9BESsI1a40xurDdWjuKoLASaXe8g7k+6gXZHAJHGkKXv4WGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076056; c=relaxed/simple;
	bh=TZ8lUJ+EdtbvrUI0mVlJgpMBTSp9t3SM/Ev/g7RgE8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiEwq8bvzRMegkJBoJRwUR+v+PxTM9M7FPXz6roq8YQ8aKqDwIyMZwlEQtBN6xluugwVto0fNHl+xaBwFxnJVcIuQXi+TPGTFrKAB8JBH4ldhM0OmmlHqjBzvwbKoBddFL8vg4JEceUPFpZkK5C97AAxFf/ESZhyDyn4+mEtlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRBavK1J; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25da8a19acaso196477fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076054; x=1720680854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=646R/nei8b6Pjif+wq+djuFAbamOolETBvkXxk7jQQ0=;
        b=MRBavK1JZPakSgqoy4vTWxOX76XkauuQIrDUA5J5mELIglsym0dlX+aRPFKgkblf2J
         c+13Zp1ZCOvsKmvkENeJRom3KhDFb+7KYetyjJkNH0PZPUysXXu1ImP6NbktVQW4/9EM
         uttPyuH0dkQ0ccnuNHlBN3EIMJvZaqJWlKH6W+0e2qDq8aqndTpMeYO2Hc9qkSXSrkxo
         9BwmVuxOEaKdGUJDWM8r9GvFPS9DCo0L6mPVn/zSDOYKf7shA0bJmqZrXix5aEwJSWF/
         WlA8AlUsqru07w3GnlpkjUytmDE96obAKLB01zRPVlcR6Th9dPn3oSYsdres9imwqQOR
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076054; x=1720680854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=646R/nei8b6Pjif+wq+djuFAbamOolETBvkXxk7jQQ0=;
        b=HtD99KV+QjlONeRz9byda5d/7Kg/9eUA9UXoddUkm/JClKfd0O58xGtxHmtJntZXza
         znKHuvXAiVy4DjjBIfpiw9RB7pe+zOJOqhSCeg/Mq8xsCmgVPE3u8anwCPcLJeVazl5h
         yT0wVAoGDmybBvCRS2PUWePbSomt5Q6OfTU3ngqmrpAetzCVIhLQQdFDnAaivTsgOzED
         WbzEX0QZIIvdk6R2gq2aULRgpYZdTHun1UiNpr6GFUdA1biowVPJqkiKCah4ZcynBbMx
         2bEY4ui451fCrCVEf68r985MOGPWu6ZiGjWnqs+l62ZvCJBqGURM2EXVDAJrmNR/YCJf
         GlVA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1QNiBJebLcyzawgPXUULYq2UzX+pCLxgmlJEt2mJNREr8fIJPwKTIj830PeCgDGLR404riDFiMI5l14exwGp1a9JW3gEj+HPIJSX
X-Gm-Message-State: AOJu0YwZ//QFmIiO7aES3Pv9nGhhqd7tZFRZfBpQgA7XPCnUPVJVZAYt
	dhCEarMhoX89YwEqtQWTTpytXsp1C+qR8g6rGNGzU27oEGNSpFgs/gz9m3nTvts=
X-Google-Smtp-Source: AGHT+IGjYh1lTXxVRjoahxmOdu63Hv9FjAowD7DcCHLak2Or+s2oM/b9Q24N9BhJjSId5owDNnm2wQ==
X-Received: by 2002:a05:6870:8a0d:b0:254:9ba7:488b with SMTP id 586e51a60fabf-25e2bed77a3mr690546fac.40.1720076054170;
        Wed, 03 Jul 2024 23:54:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802565b3asm11476391b3a.53.2024.07.03.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cpufreq: nforce2: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:52 +0530
Message-Id: <5f62b0af67ca9ebe2f28a379d807b47a7f54a824.1720075640.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-nforce2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index f7a7bcf6f52e..fedad1081973 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -359,11 +359,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int nforce2_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver nforce2_driver = {
 	.name = "nforce2",
 	.flags = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
@@ -371,7 +366,6 @@ static struct cpufreq_driver nforce2_driver = {
 	.target = nforce2_target,
 	.get = nforce2_get,
 	.init = nforce2_cpu_init,
-	.exit = nforce2_cpu_exit,
 };
 
 #ifdef MODULE
-- 
2.31.1.272.g89b43f80a514


