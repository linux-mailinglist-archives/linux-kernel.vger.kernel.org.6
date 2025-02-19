Return-Path: <linux-kernel+bounces-522415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFEA3CA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C298B17CED1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52523BFA9;
	Wed, 19 Feb 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUp4LSbx"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6B22FAD4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997330; cv=none; b=ZnK4nxF6ewEBcIAvtcQHzpI5Bc/F0F162EZL4KzJNI+3Ndz8+lQBU1aEbYYNhhLdlLcd4OD+mINcQ0vwDM6aKAuzdU6wQzzhYV5vUDSyv4sy5xflYdjpx/PADBch+voL8I6HwTgD/ggnKibgTN/iHzyc6sxj0TchVGpW4G835W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997330; c=relaxed/simple;
	bh=ROZqbh2Qg6Ad5oKSmFH7mIsUfFOlgPmcrnGM6Tglzmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLa762InM+SvMzMSLj3t1/kOVBzM13VaauMPGW6SfTHsoclMCs0/2V8vAMZmdPI2hGGuPW51uZc7GjBUJ4Dye7Jrnn9bRW8YefZAn4PKovOCKx1Fuo+KcDqlx9uesSk2EVgscRQ1UmeQy/sEBlL50sgL2KGfciUcpokv3Nbg8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUp4LSbx; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bc56e74e75so72584fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997328; x=1740602128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qF6byaGxocqUlKytAtTVyV3di31gjbWmAaIxQWjqr+s=;
        b=DUp4LSbxpdZLqzXRuK8znehgKrFO9Z2RgSDkkS6zxn3p+I4ZSZHi/BqKDkeq86B7iv
         o0yjUxeWe9sy8mCZrK5yg6r3eaOWNPsV7B6lI2gIq4ZJ+YBxm5q4P5HKICxSQFDwUQGw
         QHQRoUs0umUDe3jb7nE+p0q8wBebRJLruA+40dFYNd8V6P8+ugXEykHEdoAL1dHesCVc
         DUmyoSMHJIpquzMBW+h3E/tc21+MX8BNiN7d2dCcp4ZEFt4qyvxFkgu+04oXe1W5yG9m
         2NNJaGMUWRpjRip1I4bU62NU2Y6rnnJSeeX3byIiQ6ItherT9c7i2twyamT24koLxl6f
         5XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997328; x=1740602128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF6byaGxocqUlKytAtTVyV3di31gjbWmAaIxQWjqr+s=;
        b=w0BlEtFv98aS6f//Z47kEzqV+kWMhWxxxM6mjnKdGr2TFEQQp4GGDdZCWvcAEU3InC
         9RPcS5FFYbk9vRTc0z0xWAVW8NBboSWnvUjjHsTGCcEj3aMERQihdn+xScq+JXW2zVEK
         I+Spm+ckjnx1tEv8L+SeyqDpVL9bD2RfkOoGIzv1qCjLMfJkqbWQS/9WXcSvQB7IHvoW
         fgZLDpb5JPkJGwTvNxl3pWMJGlijBVT8cQ8fa0XBTImg5lTKASNCg6PXk7DtECfenFzT
         A+Vqb8M459DOkXd6k/kdHlx+QLFF+lW/JXgQWREJOt45YM2cH2gvJnaAn6OsiiW2GAca
         boww==
X-Forwarded-Encrypted: i=1; AJvYcCWEcP6wJ+khTSAY/rYgy82EvU0fdxH4+ZpAkAcVVYS1SqDCgpQMoasmH7J2KfrPAJgfuZnjJ/LeAPBT5cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFWFrS4savZ8N0ei7/eHpNU8uZ1X73x1oEt6MNdi/kU4au1lz
	14NopjoWFGoYoiz6IF90OX/TKVicRQEdQH1+6O2r/nSwCW4l7GO3
X-Gm-Gg: ASbGncvLBoo/W3FsxMMOav/7WfqEVwpJ2vf4o1UCQ0+Y8q16Zv8DTvOcWuvQDxdvVhq
	A3TtHvnmdfssSjIZRxvBUgNeFO4Za/MWf97dC5nCVloIpPtVaipRGxuaZ5yDTC1TSbLLzKrpj/Z
	Nka3AMhX3Mfs9ko+OMrjXf3GH4BK+gpUIgJX5Ig+xTbNrZuQU9Z2kq7AGa8ey+xXSb1+bKmarmy
	DqP2menKV3LFbMNe77QHN5Ch2uQQPcQOuCrBvxSqOI19NIPfltNF9v0+ZukNfaGMxCpRb/kwGXA
	fO5jkTp/WISw5e501fXmTZ3iVIw=
X-Google-Smtp-Source: AGHT+IE6qltG02nF4A1uSuMf3R9p2vF+yakqPv2uaD2pz2sN9FI+O4F2Hv3HvRqj1OpBJie9FSuniw==
X-Received: by 2002:a05:6870:d10b:b0:29e:8485:197b with SMTP id 586e51a60fabf-2bc99a34836mr14585003fac.2.1739997327844;
        Wed, 19 Feb 2025 12:35:27 -0800 (PST)
Received: from [10.69.34.139] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548200d1sm5940798fac.3.2025.02.19.12.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:35:27 -0800 (PST)
Message-ID: <a50c223f-f439-4cbf-b061-ed1015e1ee68@gmail.com>
Date: Wed, 19 Feb 2025 12:35:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/topology: clear freecpu bit on detach
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
References: <20250114230404.661569-1-opendmb@gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20250114230404.661569-1-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Does anyone have any additional feedback or suggestions for a better 
solution to this issue, or should I resubmit without the RFC prefix?

Thanks,
     Doug

On 1/14/2025 3:04 PM, Doug Berger wrote:
> There is a hazard in the deadline scheduler where an offlined CPU
> can have its free_cpus bit left set in the def_root_domain when
> the schedutil cpufreq governor is used. This can allow a deadline
> thread to be pushed to the runqueue of a powered down CPU which
> breaks scheduling. The details can be found here:
> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
> 
> The free_cpus mask is expected to be cleared by set_rq_offline();
> however, the hazard occurs before the root domain is made online
> during CPU hotplug so that function is not invoked for the CPU
> that is being made active.
> 
> This commit works around the issue by ensuring the free_cpus bit
> for a CPU is always cleared when the CPU is removed from a
> root_domain. This likely makes the call of cpudl_clear_freecpu()
> in rq_offline_dl() fully redundant, but I have not removed it
> here because I am not certain of all flows.
> 
> It seems likely that a better solution is possible from someone
> more familiar with the scheduler implementation, but this
> approach is minimally invasive from someone who is not.
> 
> Fixes: 120455c514f7 ("sched: Fix hotplug vs CPU bandwidth control")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   kernel/sched/topology.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index da33ec9e94ab..3cbc14953c36 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -499,6 +499,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>   			set_rq_offline(rq);
>   
>   		cpumask_clear_cpu(rq->cpu, old_rd->span);
> +		cpudl_clear_freecpu(&old_rd->cpudl, rq->cpu);
>   
>   		/*
>   		 * If we don't want to free the old_rd yet then


