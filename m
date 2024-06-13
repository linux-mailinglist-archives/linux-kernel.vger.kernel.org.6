Return-Path: <linux-kernel+bounces-212937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC759906871
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610F22873E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496613D8A6;
	Thu, 13 Jun 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c98QJvKJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED713D26B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270460; cv=none; b=VCuXIe5jonfhiyT3Hte63NzF/4mVLoCEKSYWn+fDI3C2Nk7UWdTkcXOS2x3DU1m0m0/IwNCOqv0OoQFWylxz21t6hZqa8WCCbW1+7vJqrLtKicjKNIJLHRJsJh8SK8NUfuxts8DJQkHMdXYhC0NZUYaNIiLGkPxxrXYkYnGre84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270460; c=relaxed/simple;
	bh=alNyO9/sj1YRmgy/7Nt69dqKXHxEncHp72eRrpWp2kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzGDVnDLO7+Bgwd874GF8PhuXr1WSC+ZHJJdNCy4bm9MeUrOK/DgiaLrCaVoQGB61OTlPuk8AvzR80m1JxemoEhqnyxGe/GCNBdNeYsjT0fzET3guUJNCCgOuy+bh7VCzKNvZGfKuOgUnt+jf+XewrpzYOm0i4vE9QOGpAtga2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c98QJvKJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f64ecb1766so6747345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718270458; x=1718875258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEP3MgFKp5YZRNheHta5OmSF5R3qRkcckrOw8cWXEiY=;
        b=c98QJvKJLvxHRchJwe1OAeGi8a3f9XnoH7q/dOkZH74LESTimHfqkY8U34X3upLXlV
         uDsKz2i0NTeLFvtdGIdrDZznyfwmSWqHkSnTap+pbJ1/oJeCiE0cjAEdqN0n38ecEj0P
         YPE13CAG9KHHmIxOmmpsuZxCEvBrQD3+nWWr4Ms1+0MRlfVqzPEjOelXnggEiZoCMyc0
         VyDSTpB14LJXNFQHG+lJdQO/AN8Nr0mtvUU0/ymcK2svtqB5ykhzuOhRMVcbNAQ6nU7t
         Ls0krQzTznFrBpONJNrZ4MWKpkA7acVwdve+ZFJlNXC0c+UdR7mmBRR3uRLfVz33dWJc
         lGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270458; x=1718875258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEP3MgFKp5YZRNheHta5OmSF5R3qRkcckrOw8cWXEiY=;
        b=CfT/hY77he/kqWoke4/7PzWwWwpyPBoIXsy0H0B9hY7VeJ6bVcOCDcbbtS4EUU0x6i
         EstFwxNC5BNUUiS6SuTbq8s05teLPK/1CU0P3XNR2r/TBgEjWIvs4a8OSCn/TUsvnbjm
         nJAO4QgRZZpAMi2a06FPIeQTPiAeGEeFhwXQFYj4G+Z7CroRClFm71QIqwZFuNAcpRdd
         SHSxKs55WjPXQBjL98VcfhgGBev4vhH3hYF2YOsA0cFL6lSg1Nuc8Hhoxt0T+nRWm5eD
         x3v3L9arZUoFyGoqaUNEUAmrqbDDrw7AjGnJsiS+pxwiPCtrnm6qDJBVzhEGQDacx2sA
         goOQ==
X-Gm-Message-State: AOJu0Yzxoq44rGiDpUNIMCqiwn88xEh+18r2FDv184GpAKeKUL6UPaNV
	K+jUMQ6hg3r84Sxmt52L47xDPtE/2BtEd/yp8dPhqOG3GBl8k3fyoZn8arWUVWQ=
X-Google-Smtp-Source: AGHT+IHY4mtcH0EaPDbLamBRJaLJfGhaEvqnuTUowWgzf2jmKqKPj9g2XmtfD0ZcA5Q5yUh94ns2bQ==
X-Received: by 2002:a17:903:2301:b0:1f7:243d:821f with SMTP id d9443c01a7336-1f83b6fb72bmr45345845ad.35.1718270457557;
        Thu, 13 Jun 2024 02:20:57 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6fdf0sm9035435ad.74.2024.06.13.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:20:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:50:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: PoShao Chen <poshao.chen@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, clive.lin@mediatek.com, ccj.yeh@mediatek.com,
	ching-hao.hsu@mediatek.com
Subject: Re: [PATCH v2] cpufreq: Fix per-policy boost behavior after CPU
 hotplug
Message-ID: <20240613092054.f6obecbvf45frcqw@vireshk-i7>
References: <20240612033112.29343-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612033112.29343-1-poshao.chen@mediatek.com>

On 12-06-24, 11:31, PoShao Chen wrote:
> This patch fixes the behavior of the cpufreq boost when the
> global boost flag is toggled during CPU hotplug offline. This action
> previously led to incorrect scaling_max_freq values when the CPU was
> brought back online. The issue also manifested as incorrect
> scaling_cur_freq under the performance governor.
> 
> For example, after the following operations, even if the global boost
> is disabled, the resulting scaling_max_freq and scaling_cur_freq
> will still reflect the settings of an enabled boost.
> 
> $ echo performance > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3200000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3200000
> 
> $ echo 1 > /sys/devices/system/cpu/cpufreq/boost
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3250000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3250000
> 
> $ echo 0 > /sys/devices/system/cpu/cpu7/online
> $ echo 0 > /sys/devices/system/cpu/cpufreq/boost
> $ echo 1 > /sys/devices/system/cpu/cpu7/online
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3250000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3250000

Please try this instead:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c6879efe9ef..bd9fe2b0f032 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -43,6 +43,9 @@ static LIST_HEAD(cpufreq_policy_list);
 #define for_each_inactive_policy(__policy)             \
        for_each_suitable_policy(__policy, false)

+#define for_each_policy(__policy)                       \
+       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)                          \
@@ -2815,7 +2818,7 @@ int cpufreq_boost_trigger_state(int state)
        write_unlock_irqrestore(&cpufreq_driver_lock, flags);

        cpus_read_lock();
-       for_each_active_policy(policy) {
+       for_each_policy(policy) {
                policy->boost_enabled = state;
                ret = cpufreq_driver->set_boost(policy, state);
                if (ret) {

-- 
viresh

