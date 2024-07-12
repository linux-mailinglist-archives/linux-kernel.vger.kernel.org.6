Return-Path: <linux-kernel+bounces-250479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5E92F846
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0096B1C21C29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180B158DBC;
	Fri, 12 Jul 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzFaNTv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C015157E84
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777639; cv=none; b=fJVNYhb4SO1gcXVSQ/YDZD8GBu+JK9/B15rMEsBpSoh0W4hHNapQ3/mVqMG/n0pplNRXEv09YbzNMa9NHuvzM5T5bBtpLRDPsDFdDPnky+ud8KMlvU9kdMgUc62MsmY+u+awVRqVhrod6P9lCoibjyL+dv+wfJ7kJoCZErJcofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777639; c=relaxed/simple;
	bh=pkNCmajtAiJIVCimdoJ81IqJgTJyoyKycbV64ArqR1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj2fqe2Td15pl2n09SEHeFLKY660sxGlAdvTpQfthGxMYv7pJkJdSGc3RG3rgRUuEK33FDUbfvuTL2af+W5bpVSwyoV+HN40B/4x4yC8OAD7YK/qBMv3g3PkFB3wkc5zhWJHzR6mwYfY8b/3urep0eNS11sZ1Hp8lCGNygroBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPzFaNTv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso17072705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720777636; x=1721382436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ud2L63m6lfr/M2Mr6IxkqT38hdjkayIOqwQmf5TTp54=;
        b=dPzFaNTvnRXYpsxm0ZUFmm6ecrWOGNyQmGQb1W26Ej4ko1jPQ7dQ4Fbacz/vzcCEfY
         l1oWTcBbrPBvSBo+B1+7LA8K7lgblGbj35CxHtJGCgkqjXGNdSG9mqde29B/kOpqr9+p
         n6+XhEq7Ke/DBz/3jbn5NCI/IrftppQdD129VEy6DczTZuZcvRUemxGlWQkACDnq5o9s
         rAswtrQZztNJR/ebTcleyj2U691g53fbDmguXu92EJa1GPvMlBhSEwqNSD+Ub16WA+M4
         m4v97jymrWY0mJ/GGNL6XLCrRSmOoZ5YsXcwCx4DjDAh0ADOgQlGCTUY3Rb1VJqnHRzj
         5X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720777636; x=1721382436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ud2L63m6lfr/M2Mr6IxkqT38hdjkayIOqwQmf5TTp54=;
        b=YZe3+vqR73SkY4N9emVW5eMRaNE+eXcwdSoMAmBYLqMAQRDJxSu6YypUGBS6X18X8v
         cFYEKzxn2lHVR7QYYWo3UDTLVn99QAtbqgKBikoJQum1lPl0qNHG3kWIgh73G8XnfB0P
         iXdiK2/npVZhNiVxE0txC1wTxGx5NyPevuW4NjW3REok6wvhR43T5BsZmHtfpIbPIgqM
         UP2HsVAxJ0zABvTb/eYQedMwh+WaW4BmFjoArXKVFuHrLPd0IkUD1sgo4Ih84R3bb5M3
         /uqndQmyvw474TIJKS68RSLpmzIkmt3sNZfmlkinRxWPPwuNTfF6ulU4Ctk/dWnLlIty
         eglg==
X-Forwarded-Encrypted: i=1; AJvYcCV5z4Py3wEEYPnAdasgkwpZRMatyuT8cPVgD35TEFcNjrp7DygLn0m05e0TsvW6oDnoKSeQ9Xswm8IcLQTQBv24aboRRhNzkm5QzlC4
X-Gm-Message-State: AOJu0YxjHQ5ct7tw29wNgxdu6nmLi+7pthPkOhj9e4YZrtW+Zyug/Gx7
	wBkYBG0B08zeGpoHl27taNeDjOiIwATBqmn/GVyyUpP/6x+bjsKO
X-Google-Smtp-Source: AGHT+IEPUFi5MlXgBv9LSjC/pr8ipgokcpefZ4i/vCVHWcpF6o8Q9FVgwFHOk8Xsbc1xLXl/ya6ZLw==
X-Received: by 2002:a05:600c:3ba1:b0:426:618a:a092 with SMTP id 5b1f17b1804b1-4279da3a68dmr18451435e9.13.1720777636126;
        Fri, 12 Jul 2024 02:47:16 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:356c:31eb:bcaa:d0aa? (2a02-8389-41cf-e200-356c-31eb-bcaa-d0aa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:356c:31eb:bcaa:d0aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc42esm17722215e9.32.2024.07.12.02.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 02:47:15 -0700 (PDT)
Message-ID: <2917e82b-eaf7-4db2-9c16-d164568df1bc@gmail.com>
Date: Fri, 12 Jul 2024 11:47:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: devtree: fix missing device_node cleanup
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, linux@armlinux.org.uk,
 robh@kernel.org, rmk+kernel@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20240712094448.159784-1-vincenzo.mezzela@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240712094448.159784-1-vincenzo.mezzela@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 11:44, Vincenzo Mezzela wrote:
> Device node `cpus` is allocated but never released using `of_node_put`.
> 
> This patch introduces the __free attribute for `cpus` device_node that
> automatically handle the cleanup of the resource by adding a call to
> `of_node_put` at the end of the current scope. This enhancement aims to
> mitigate memory management issues associated with forgetting to release
> the resources.
> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  arch/arm/kernel/devtree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index fdb74e64206a..223d66a5fff3 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -70,14 +70,14 @@ void __init arm_dt_init_cpu_maps(void)
>  	 * contain a list of MPIDR[23:0] values where MPIDR[31:24] must
>  	 * read as 0.
>  	 */
> -	struct device_node *cpu, *cpus;
>  	int found_method = 0;
>  	u32 i, j, cpuidx = 1;
>  	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
>  
>  	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
>  	bool bootcpu_valid = false;
> -	cpus = of_find_node_by_path("/cpus");
> +	struct device_node *cpu;
> +	struct device_node *cpus __free(device_node) = of_find_node_by_path("/cpus");
>  
>  	if (!cpus)
>  		return;

Hello Vincenzo,

If this is a fix, please provide the Fixes: tag as well as Cc: for
stable if it applies.

Best regards,
Javier Carrasco

