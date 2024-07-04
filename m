Return-Path: <linux-kernel+bounces-240627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7CC927016
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B610285A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D11A2574;
	Thu,  4 Jul 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wX98WCi6"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8601A255B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076059; cv=none; b=V5lo/w7RzQXo9Eeo/risZYlnD6jHWncfcdjXhamIC5lqh8uB8K424fUhwXXeV4T2zGuOZtYP4ZTa/Qxxc7N3QcmHqYg8DKRvrlBIRnGG1ffPaXilCNzxzk8sr+zIgiOGwPxAGpR+Y8zX96pC/ilNVKclUeGoP+0CmEg+4+H8pjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076059; c=relaxed/simple;
	bh=rvmbprnMHM6RuihnA3iI8+faiVS/K3OKoDAAx/cTilc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvCIMrsoSfkr134l/wLYPheqTfAp9Cz0rrmIbH45yntPMLBCfbJi6JN4YhlFAuIvMM/k26kLa1WLVKKo3YNtBVdAPAlMmevgbnA4RB/9u94hSHD7WACjPlQkiXr5cpLFDRzqpmd4BCprn+POMi2sTQzIfxCfGnF88IzeIeOWhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wX98WCi6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c8911c84daso225661a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076057; x=1720680857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqt2bqXZTu+jtLjs9BXsNPr4gZaqVWVCViCBOTfKtXs=;
        b=wX98WCi66wvL9ePxOdfS4OnbQRyI/c0FgklI6XAqYMeWTSYJI9wvkDc4tbLNK+A1OI
         yLMVzJqwrNHu6pGKzqfymgYL0DFOJCFeQ9h7uaGAHUcynbWP+KEzTCBjAgRMpgGF61xV
         NFvoYL70Af6sfdWub3ODW6qZi5SbkI8bsHalsjjJQKB3GTZ33ABxNpdzGOOdi7Mm2qmM
         EfbP6hZQh+MpznRkdzuBWBCdt9YvGEZepyUCO3HS+U+qtbXdqj0iuGPhlzVgB0Wwicwo
         0I5rYG4E3hVC/2rMVvpYj+Rx9mSjwdZ9Bc5xbKvd7nHidr26Cy2O+YVZv9UjY9KJw3M3
         FHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076057; x=1720680857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqt2bqXZTu+jtLjs9BXsNPr4gZaqVWVCViCBOTfKtXs=;
        b=phRu0aSAHZnompo+7gFKN3m2yd1uqXRLrLKepiBw1yfV78wbl31JQopEgOtV+2pgF5
         v+5dkccWX65aH7PEhD+xRYXV3NE68u1599nVlKswCUZmwGp7zeIU03NJzvY7R1n746z9
         c9UjgVldONMZSj264NO4aODp6eQG3rtj/hdgCdk/7bxBJQn/xyZg8E6fR0B9mTAHaBRL
         sKi+HzT770pgwZ10ZnxBbGyE0IoS7oJQ5DezjQrqsPR8Yx2Kh9ULYUj70kG/1Djd1p45
         YNWhe1kJpFQZgKWRV+uHoh9qA5fC/6apZzuFIU8G4ycjtN4B6g2/Ft1GsjNIbgd+gD+T
         bdYg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+UO1E8zw5WGPQdO+H8NZCDtE1BSE8Ihs3Vf+YUwqhtwlX7FIQiEYeJZ8xmQvGrU/1YIyc7M2Z5U2quZebZdRvnPztNgAgnWZwgWk
X-Gm-Message-State: AOJu0YxYAegkLzRH2VruOEB6oHViNMPEUiP/0pqQHIutH55ZpKqw7igx
	eISycehlAW9Edw+5IrODIxJeF8LSaPgIMMIHaN/kjMem2pmUCAy5Nv/lRs7A87c=
X-Google-Smtp-Source: AGHT+IE6fNB2yrW6RNftQOsnBHViWmextONFWbrX8jTlqq5TSpm4UeSlu7EdPmVmpu6y90sy4DvlNg==
X-Received: by 2002:a17:90b:4b04:b0:2c9:6791:a752 with SMTP id 98e67ed59e1d1-2c99c6d0948mr487823a91.44.1720076057304;
        Wed, 03 Jul 2024 23:54:17 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a947485sm706021a91.4.2024.07.03.23.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:16 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpufreq: loongson2: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:53 +0530
Message-Id: <f09ee1fa731db0c1565b5d4b919d54d5f258957b.1720075640.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/loongson2_cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index afc59b292153..6a8e97896d38 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -85,18 +85,12 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.name = "loongson2",
 	.init = loongson2_cpufreq_cpu_init,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = loongson2_cpufreq_target,
 	.get = cpufreq_generic_get,
-	.exit = loongson2_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514


