Return-Path: <linux-kernel+bounces-424226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C319DB1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16EB167325
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60784D29;
	Thu, 28 Nov 2024 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeBha709"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E043B19A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763953; cv=none; b=WOwbWHvjaNs0BkJFLbe1baFp/98GvAN8aA+qs5gYWh+gdq7TN91v4v7EYGx/yxMgGOckUteq1M+QSAnCNUfbI3NaY5ukjWpBzJ/KuGZFgyzFDGSZKZp90oeDvJwCuVhkk/AD4UIy8hbqq0zMZ2p/ZHfnoGS9BCWBh6S4FQWd6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763953; c=relaxed/simple;
	bh=7+za8xzxMsGtpWPcp4SRnds4wLkxI3XXkrih6g2R8xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8GY22Szj6/Uh9eEYeFlglJ++MLLE3vRXbqQTvj+W93dDyVdxGtdKWdoN8RkPA6LypsqodXYXO2EbyKS7NNzHgGjnWw3FRnKMXV6U5QcypCmeMgtNo8hwI32bkHXPGCvN9Gw7Or2XyHMwKxFOnxYA4Dki+TqD/vq8LxVZKuNHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeBha709; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2126408cf31so2312995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763951; x=1733368751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kKvWVWVtQktSAu3SDXPAPMOPSe5VuHZ02dpFknlNf3I=;
        b=WeBha709v6/A8Qdk/ipdfT3DLJF7KqDFSKWZeT1Nj7/mOaUXUvRwjw5r1I6L6WsGUY
         KFULTUD2zXFfQIJH8AnKs3TUywhVMeuFA5JE6amC9f2hUII/mgEKeDIqVjjBBGlf5YAT
         TUfwCQT+VbvfsPhKsxjkJlbJj+4QlJ51LYc668T3fbi7Y2pKV53AE8lQHjkDQaklkgT5
         xBcxW36KacB3takY7oU16Jgwqk50dsKHpFL4/ZYFRdPY4lsSfDHerGiBs2zL856lf92J
         w3NImP0zcVV9M9LaSfERkbKtU8fCI68vy/Hze76OyblpxXZiSGjTiBqK8HNMwb7lsFjy
         G5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763951; x=1733368751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKvWVWVtQktSAu3SDXPAPMOPSe5VuHZ02dpFknlNf3I=;
        b=Scn21MtpNEQd5KEHKARmHQsk/1v6QfaPsGVR4NyGg3kzlEh6k4IApZKntjQ3sy+fAA
         62/VlpDFX9A4y740T6hCl9cwKsSCGOf+JeWxdC82e5QdFsD6GoqaGPZClQYoHR+yt4pT
         SAB/tx/tocmgA7a5TRAaWFXrB5Yvn62vzY0XgM7Lka9njU51p3i5UuDW6eMr1uFaq1bg
         mqA/e59056dyfEjEk6ItHZ9jYLkNxGj0CYqYbN6PIrVxjupq3ynTXpZtEtXkohXJqJ/B
         ILaHi7He8MLF52sdpuDVnrq7W5UXzEj5DYkLERdjLHKo8ONN4jyZeDS2eBuTip2pLWf6
         9HOw==
X-Gm-Message-State: AOJu0Yzv1PHTaBhLeuneum3anuoeG5EWWLm78UlE+8dBne4vX8abU7fo
	zXmXsR0AtB6BqY3wNDAJsEfH84AKyXYs/FJrsXTI7VkyQ2wLtnos
X-Gm-Gg: ASbGncur47LWDJv0XK9rl4gzkRachNWRL9DBNFgBmEE5BJDa4kXIbXjHHtCm6yL7hxs
	4Hge0+Y3f5DH1M+d6qgWazmR+yuW8Ao4vleQFDRH6/zlw1KQLM6+fy2aAUwvdSjPio/Dn9WCVOA
	NVhJXZ3VusDA3Vo20HiAdLjh/2n0fxOUD0aMQzla030Y0dLOkTb9qVDpX7W8tyB6N7KXoC9cO03
	Tzg3rKSiY7pP/dohBrCkS1z6l75WLkBZX7Sa41qoS2/h3IgS9E5T/4dSPhk3ua1Stxu0qch68Yh
	/Cg7MdNHqzxwYf+RptBxes0=
X-Google-Smtp-Source: AGHT+IExgRmBZqtNYrrKFPX06x4TS4jaur2rFEZZbM051780x6VnZb14HV+HrZALrUaz21Lxa5TZpA==
X-Received: by 2002:a17:903:2305:b0:212:6573:a275 with SMTP id d9443c01a7336-21501c59c1cmr71606845ad.46.1732763951103;
        Wed, 27 Nov 2024 19:19:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f591csm3122435ad.8.2024.11.27.19.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 19:19:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6fc258b5-37b8-4739-8f6f-317f06fc6eab@roeck-us.net>
Date: Wed, 27 Nov 2024 19:19:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only
 if ARCH_SUPPORTS_RT
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20241128020009.83347-1-longman@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241128020009.83347-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 18:00, Waiman Long wrote:
> Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
> that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
> they will not be forced to address unimportant raw lock nesting issues
> when they want to enable PROVE_LOCKING.  They do have the option
> to enable it to look for these raw locking nesting problems if they
> choose to.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Waiman Long <longman@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   lib/Kconfig.debug | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1e37c62e8595..942b4cb138bd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1397,9 +1397,9 @@ config PROVE_LOCKING
>   	 For more details, see Documentation/locking/lockdep-design.rst.
>   
>   config PROVE_RAW_LOCK_NESTING
> -	bool
> +	bool "Enable raw_spinlock - spinlock nesting checks" if !ARCH_SUPPORTS_RT
>   	depends on PROVE_LOCKING
> -	default y
> +	default y if ARCH_SUPPORTS_RT
>   	help
>   	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
>   	 that the lock nesting rules for PREEMPT_RT enabled kernels are


