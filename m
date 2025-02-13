Return-Path: <linux-kernel+bounces-513307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B848A348AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424977A3840
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE61C863C;
	Thu, 13 Feb 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqTKEFJO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124D18DF9D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462261; cv=none; b=a2sVKKRTbtRghWOEJGucuYif1iA90DgL80Iy/lbTuB1+9mUuGgs7dSjksfvam0c9nGPZo4YwTZ1bT4XHZXvyGrSG7l2N5QYf20HL2OES8pDt/4u4Ys22WvbbYpjlZm0IztBL2SA/YtWhjRSQxL5F4RmobMprQ3kjvoRu4WSfyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462261; c=relaxed/simple;
	bh=frjmkr3xCPkO6AhMmYzJCUdfBDQUprIUBclYA5ZTRZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6JzWOLLS6AKKYfYjGzhu17U85E/dIWE2Q6IFbH+wHk8m8yojgorIP+T/PYfrwvEKYZYHYMPuXaIJdgAQoyiFvd3tETf2GtYU6Fp0tzQx2/OnQ12wdD5BaybEEz9Dupk8Hec5UxlKuUy62FXeI10zZ6/1F3ryfrRvpjbhrL9af4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqTKEFJO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7f9d87b96so168690066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739462258; x=1740067058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZ7Cx13VrPkP8+VctSLdTrFIVV214IFQtD/nhF57l7Q=;
        b=gqTKEFJO+AomWXRN9HA7VDm/nxelvTNwQh7S+UmRqQ0HLMpulKT7mg86dWnX2yfmLo
         OT68bOQikZcCqifbXyekRMCR8NGFqtR0wUZZV/nh4U6LJw6AfUFzgHgxkOzgRcZWSHE4
         QGA0SgGZtRHZO47o2qj0yEWeRFjqV/fXhTIjZtHpxZScL4SEp1V0AkbcO0pVcgmk814l
         jXUHHS6dQ1LFuVbPeUjxgXHZPxS+mhMhNtRw4G8+ALS23wi8bHBxs/9Ndl4X01rnDT2W
         o0bf1hvh2es+0N6oyBLnIIW4F+hda5AXGERnzGVKtneSfAJfyFbk7XTdWkv62Jp9i/LX
         dhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462258; x=1740067058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ7Cx13VrPkP8+VctSLdTrFIVV214IFQtD/nhF57l7Q=;
        b=eDiNUhh1r1ivtlLjnxon4KwIQjPRKRgflzAzN4VTdShYtRsAFq4S+bqWKetECbGRv7
         b7re9WNwM1UTbenm3zd2ip+CSxUEEZapgPZl4JstSB6p1VqZHoQdrepV9IQ1M1iID9aj
         gzpCbFQgw4Q5q/sHH7gIFWlDNSUHgmlJENE98YNEZZgVyfEHlif6GMWqn7+A2H4984+P
         SdPx5aCwzMY3wLAUzlzgaDlfRZz0pIruDM0VhMRKzKGwGbqIqF3/vc2oanbyzCHk13PS
         O/pVQmcp5DpreGGBEY5u5ruynb27QMToI/sA2KzxKmq+bl439hSfPls96c3+7xs4XPgx
         vZIg==
X-Gm-Message-State: AOJu0YwzEI8yt0/YoeqJ7dGaJGNtHVRRoJ7XNIwtt1LZbWEnfiPf0ksA
	r8KpmPtTA/vz/nCUjZYUHDQuSAXoDd3IDgn1VYVjb+Fcob3xjn7A/xkcmjvCMzo=
X-Gm-Gg: ASbGncsu0rLvU9sss0Rh5m4+mcTSWXtMd3HnXm3ygUbQOaWzlP4zqQ1v2lpGC6m4jmZ
	OS7cbe2DKaa07IDPyV2aDMGgVYCIzJYRazJnXzUb2fB+Q4309Pwt3Ge19G27ONcFh9zuTa5KLYh
	A/xbUVyMrLwNzcsbB9qsQm9njJ0l3Ha78d9v/dJnnB+4FYVS0kx2t+G9JJ20wxMC7LEHoUnBMfJ
	2epKqidpM1KSiqirVGmO8hdXALgReN0iOHiJ46xi1Exvwmk3ZvX++WOQRD2zMJGwO8JQ5yLX8wb
	Owy+zWXWRBOSlB9yEtY=
X-Google-Smtp-Source: AGHT+IHhqe1wbcVZq5bYL05C/nHzZU3ubfoUcIbOrRCAGceVtB02UDx0Y5OoVZE9bABlHjUFF9FIJg==
X-Received: by 2002:a17:906:f8cd:b0:aba:620a:acf8 with SMTP id a640c23a62f3a-aba620accdbmr14943566b.24.1739462257718;
        Thu, 13 Feb 2025 07:57:37 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376af2sm155974866b.119.2025.02.13.07.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:57:37 -0800 (PST)
Message-ID: <0631f7fb-423a-40a8-a6c1-1f307c1efe96@suse.com>
Date: Thu, 13 Feb 2025 16:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] kernel: param: rename locate_module_kobject
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 code@tyhicks.com, linux@rasmusvillemoes.dk, christophe.leroy@csgroup.eu,
 hch@infradead.org, mcgrof@kernel.org, frkaya@linux.microsoft.com,
 vijayb@linux.microsoft.com, petr.pavlu@suse.com, linux@weissschuh.net,
 samitolvanen@google.com, da.gomez@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-2-shyamsaini@linux.microsoft.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250211214842.1806521-2-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 22:48, Shyam Saini wrote:
> The locate_module_kobject() function looks up an existing
> module_kobject for a given module name. If it cannot find the
> corresponding module_kobject, it creates one for the given name.
> 
> This commit renames locate_module_kobject() to
> lookup_or_create_module_kobject() to better describe its operations.
> 
> This doesn't change anything functionality wise.
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  kernel/params.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 0074d29c9b80..4b43baaf7c83 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -763,7 +763,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>  			params[i].ops->free(params[i].arg);
>  }
>  
> -static struct module_kobject * __init locate_module_kobject(const char *name)
> +static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
>  {
>  	struct module_kobject *mk;
>  	struct kobject *kobj;
> @@ -805,10 +805,9 @@ static void __init kernel_add_sysfs_param(const char *name,
>  	struct module_kobject *mk;
>  	int err;
>  
> -	mk = locate_module_kobject(name);
> +	mk = lookup_or_create_module_kobject(name);
>  	if (!mk)
>  		return;
> -
>  	/* We need to remove old parameters before adding more. */
>  	if (mk->mp)
>  		sysfs_remove_group(&mk->kobj, &mk->mp->grp);

Nit: Please restore the accidentally removed empty line.

-- 
Thanks,
Petr

