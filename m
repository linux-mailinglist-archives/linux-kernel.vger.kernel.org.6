Return-Path: <linux-kernel+bounces-256710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12D935258
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565EC282F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974F145B0C;
	Thu, 18 Jul 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuvgCAy0"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987413D516
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333322; cv=none; b=eKeIYAQQ3pJaRloN53UEdFeaE4cI3icEpgPYuGNd+Gjs3+qK5/4ek5MQMPCPU1+hxy6BZ7rCBfXl+5Ybc0euHJ6sVG0y7lQrHJkSZ5DIIk+Fi/HzWdMq38nUGgLd8WxwWh9MqO+GmnfctfrdbuvR1zuLsN/vJd75EV3t3MR/hEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333322; c=relaxed/simple;
	bh=roVaJVLQ8Of78HQnsJm4kUqib5zBKHi0p3Ier02zSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VJDPoa386qx21z213N+BOMm9MNloXVzrf8oC6iZn/fyohMJH5beGY499sTdTkNueGWAU92MhYJm6wXyxEMVJgGnISUYizgtTkSqA8hfR2BWyvnccb8b44voKyu9Sia19c8bdiap28/w2XH1+FjzG4y6oTv+u5IUt4u4JKrp3HmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uuvgCAy0; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70365f905b6so745684a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721333319; x=1721938119; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp0oyTo7suZ1p/VJFPY2j+EgXru6EPJQFDcV3HqH2M4=;
        b=uuvgCAy0AtttPne0AEemcnbMuyuiKdn2xkn1jq86RhmgI+TXK+ao1WaOPMVkfWK/2M
         tmcwlJxFbE6gY0cLbbYSDb+rlPnqtHm23KBpPtudQKSzs+s9jFIICsGrl4ZEmccPuyuq
         M5dGRYqf19WtjR3jyrXtwXeJFplY1k2Zk8nN2G+yUXyMgbhUg1MkFNu0ZLdr6dzuAbXn
         tC+KOKmFP0PC+ASkvWY0ha4ai2wW7fSp+DdmxILpBUxuuhMt1G71TdiHYKbq2J1jJTaX
         cZ5VvRyJjDJIvFtCXXMhmIdoVRZrbBsiMePgzU55LrfABZdonzao/CB0nqiqLw2zm5s8
         G9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721333319; x=1721938119;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp0oyTo7suZ1p/VJFPY2j+EgXru6EPJQFDcV3HqH2M4=;
        b=OM0aTxVPYxPbEP58BoA4/bjQRRQQUx4LvGAAzWUn2t+Ys1zljC2OPmZTQkc967EkuQ
         N8uXhBbwRD+dCBXGNH4SDuH5aSeeZwsaFw550LbNTXW1o6gI8Y/uqzwWzQFzufYcpXlV
         LV2cPzNIwMDNOpo+Zj81LCBwpWXydP+b3xx6pFFmb9eRct6iX/umtA2WhGlw0nCm1Phy
         E5xKi4AAdXj3IS7ybjXFywX9GSbOhzT4LQw9ErOQRYnqGrH0a3uzu5UXA5qYcsFHaxAa
         mQzNr1DbvU4vuUocP6FrYOWUitnIub6JnvlyBHrBDkFr7/VYaoVChriUyw0llP3h0lNU
         IoSw==
X-Forwarded-Encrypted: i=1; AJvYcCWFKw5BZ5c/2xDoiv0xYYh6WEo8magomFoHu3yDqAd+3XOfsi70saVmWsQMDkc4QCnSW3a4LmT3Z502/aOdEGoyb9IhDKszR88qgpxD
X-Gm-Message-State: AOJu0YzMAKybJKiYHdFNX/KEcCnjaQbRvoMqBkCqZtneIazkC3rhKLKk
	skNCVpmt6/rvZKkbMU03zjssrzw2RqINc/8CQMf6zGhRia591fNqLnxsn9uWIOw=
X-Google-Smtp-Source: AGHT+IFQkhBljK1MS0GoVn+FbZK4gkfbyBP+j6byThpGUBkHb6s72SWk871XFe5thqyDhAAjoaa/CQ==
X-Received: by 2002:a05:6830:369a:b0:703:6d27:63e0 with SMTP id 46e09a7af769-708e37f0e3amr8445206a34.26.1721333319343;
        Thu, 18 Jul 2024 13:08:39 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8d5a:14eb:55d7:f0ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f6174ee5sm2621a34.55.2024.07.18.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:08:38 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:08:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Perry Yuan <Perry.Yuan@amd.com>
Cc: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
 amd_pstate_cpu_boost_update()
Message-ID: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "ret" could be uninitialized:

  drivers/cpufreq/amd-pstate.c:734 amd_pstate_cpu_boost_update()
  error: uninitialized symbol 'ret'.

This seems like it probably is a real issue.  Initialize "ret" to zero to
be safe.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..358bd88cd0c5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -692,7 +692,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
 	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
-	int ret;
+	int ret = 0;
 
 	highest_perf = READ_ONCE(cpudata->highest_perf);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-- 
2.43.0


