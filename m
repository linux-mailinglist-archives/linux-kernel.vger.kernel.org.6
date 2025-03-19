Return-Path: <linux-kernel+bounces-567853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB0A68B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2E4172581
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7152580C4;
	Wed, 19 Mar 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPabIxQ5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5E257AFB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382449; cv=none; b=IvhhexB3lPJFpwApvn95Yr3duk2nOG4xVzCxCjtFKiHwIcj+HkdsuIjmQiPo20JOmtnKmya9BeKLK3vv5YTP5Z5XhiLmeWkr1DaDgxPDvN1SIXbH0ZKT9FyW9qllfcBGxtJGDtJNbxd4jlXdoW7h/tW8AVEHT+MxZm+N2ioLqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382449; c=relaxed/simple;
	bh=V7dnjgSOaPShHTJHnLkk4uVfV24+2liXv4TjR8ZYT6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZqXXcHNcnqJLb55ospsSPn7/KWcBG6M/Opl7MGAQmPJfN8ym1iv0Ia4v2BSV8+YcWAzkJCHiREUH/O9MRvtL/kKaka0fp1qPZq7QGcK6g4/wxOP9+knunFOGaDkALr0sQhGTJ2M9A0JJZ5D0rhOQsFf3qCEgBodpeWFjalomdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPabIxQ5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so77458866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742382446; x=1742987246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKth9YYSeQRUxPMZS4Rugv1nLNWtYjr2cOnVsFp6ZvY=;
        b=oPabIxQ5HE11HuSgkAoIq6HpU0H8KV8iUVKF9ED2WCN2+NHOIusEhc1omhpgEzeeg7
         b77ACM2thQXXYSea+a+NkV+bveh6L1aJ4xW4WgFelR7VCUgofiScdMWkZWeKGuT/iazv
         1BaIxPKWh8lwyg1EjEaRLkbKZK+v1hcy0//7QIzX01GbKRWpw0272k37vhS+yKwg+scQ
         mjASY52vAnca4ED35kX6bY4mbU+qPkr28ftcW28foM0GAd6qTzaUnjmVOfOuqmWomOCB
         wZyMHfLvgB48a6MkFTblp40M2QVm7TkGrI7DI9e0m78YpKjk/oPk07pl30k0PfmhwrKw
         xApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382446; x=1742987246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKth9YYSeQRUxPMZS4Rugv1nLNWtYjr2cOnVsFp6ZvY=;
        b=oopG+AppnbMQdRJq/61XsQzeIHUZxrT73WCkAKZ6IcFFJr5y8MsPhd7m5ZPB3enOQl
         BE9MEtQE5w/8K3egYQkJ8pwdKDg2ww5rrdd06DuLDRnHjdGhZnH5c00pZvHuRkSc22fa
         8kicMdelpq51sz8C1UTTLh3rAIsXlwnypRd5ZmOG8zlCG0Zoxp+h7/WppamhxvcOm3ys
         +OAiuc9eHaMe/ye6QQnfhJXfNeEVSaDoO6PJRbIOS75Ka6OyyQVnZRr7AOVjTtBW0hpx
         V8U7TluO4Yc/N25DOpMAGp/T5GnYej6EcKauOe2mVrJ8nuwswb/LU8ZB0d7tr8O7YAab
         5YWg==
X-Forwarded-Encrypted: i=1; AJvYcCUTzs8ErDzNR8mp90F62eT9FgGrjXBmqf7M+2sc+2hJgIjs2lmZ6PDpc9MmnYXAIjws60/O+bHBaTzI51A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoq/VH3GuEprFlQFNSXoZUQLSTWXzP3tFFCqmSU6Bc2l3S8+u
	drzweT+i5jhSoN4Zy/x66Do7wK4PfBJpjIcXbZHxFAyjdoXW0QsecVkbCtRgHnoJpwpwW4lb3pb
	uiZTTsWVi1oI5RSERJeIQdyspJdCRaWidot2DKg==
X-Gm-Gg: ASbGncvQXMpzfEhJi9Tpub+ip9bnTqqbiD4beveFZRaoVhhzMxmwQFsPRbWy5wA2Ssf
	gpRPuZ0d/9pZVp6pOw5XazY9MEhD4Td2k8IPM12kNfHHkLE79N/Zgz6nrSL0CUZSUDTEh4UOGQq
	urXExsdaiWFkNoj+XJDLNrjBJG
X-Google-Smtp-Source: AGHT+IGKeT2wDfY4ZigO545idf3cTw1k7fKRDc9S4FJOYQPGGXo8FPoBJ8v4e3F/Atp223ImhHwWW1Ndp6Cuj2DK46E=
X-Received: by 2002:a17:907:84a:b0:abf:750b:93b8 with SMTP id
 a640c23a62f3a-ac3b7d8492bmr216018166b.22.1742382445948; Wed, 19 Mar 2025
 04:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba823a10-3199-4702-8821-03dd88d45212@arm.com>
In-Reply-To: <ba823a10-3199-4702-8821-03dd88d45212@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 12:07:14 +0100
X-Gm-Features: AQ5f1Jr7-M99V1VLuWgRBazhWeS3nrFzVefQh1l8b0Hav6ZaN5vOVwvjM3pgYAo
Message-ID: <CAKfTPtCEEqjOw+5k9d9a-5P_iu5doNT65EiMmhdhXytDnXdmMw@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Fix sched_is_eas_possible() prints
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 11:59, Christian Loehle <christian.loehle@arm.com> wrote:
>
> Add the missing newline on two failure prints to ensure EAS abort
> reasons don't go missing.

Would be good to have a Fixes tag

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..18e804b416f5 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -245,7 +245,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>
>         if (!arch_scale_freq_invariant()) {
>                 if (sched_debug()) {
> -                       pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
> +                       pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported\n",
>                                 cpumask_pr_args(cpu_mask));
>                 }
>                 return false;
> @@ -256,7 +256,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>                 policy = cpufreq_cpu_get(i);
>                 if (!policy) {
>                         if (sched_debug()) {
> -                               pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
> +                               pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d\n",
>                                         cpumask_pr_args(cpu_mask), i);
>                         }
>                         return false;
> --
> 2.34.1

