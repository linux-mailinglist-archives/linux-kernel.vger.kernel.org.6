Return-Path: <linux-kernel+bounces-285788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630319512B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874ED1C2132D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A232BAE8;
	Wed, 14 Aug 2024 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BdGEuErE"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF3111A1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604000; cv=none; b=CToSmPa3JV1fDmIrh8WBmoE8Eci7JE/NHBd+yKkdRoT5xOh4gbYsAXtUW//ltwXPEFzkUh7AX0vuorMxZoD6vizRZNdB1Npd77TQaf9TUjS94q0+T7pn6oERBKp31FTHSkVxpdFHpiXlIT/2YwItNyKzZCGVc35URURIcIlN0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604000; c=relaxed/simple;
	bh=7DjNYabiBH6/SFc/YvnPO63gIGfDRJMAplBsENx4ZoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHrjjvR86A52vQhJe9K3g2REmkXONFCrfXka5jYl8LOrlQd1GkECebuNYUDRGd13j071VqtejDEFjlZmfQeQGFOCO0PEmElmyxg+pdyxyiBijVXCeN9VUyiEg9OH5jsoUHdzimn+tIXQmyjmoVoYo+ibEf2D12cxpz0yjhznUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BdGEuErE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3d9a5e050so2435480a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723603997; x=1724208797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lArg9n0qjjH1VkwcEWIeblrXgYKx2EkQEyzg90L2fAU=;
        b=BdGEuErEst0P/DmxlsUt9XYF/PX69x8Aq420E2Vejvjk1hoZZ5ORGCbzwjDH5sQhVa
         7L1jOPKfixfbMl8V8DFhvCTJDoVL+XdPCHcn2ehDJ4+K/8TBP5QZso5XxrewNh837Dz2
         GzbY9bNUHT+38dxTzG5JrjhzLIYKIJPqnqSTzMmUIwYa4SSQ0ln9i5imPI77k7fQmZwr
         t3fh0CrrE0ueDcRkN5GKEDPBzikim/ydXQ4yWtm2sSPH7s73+sY48gQSMpTG0m/nrHF5
         9qHtdk9z/0dDWYLH1IEJIK2IRIltlKhA52dB4i88oIwqb01fD9Y8oVyJhIuIrZXyGt0f
         hk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723603997; x=1724208797;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lArg9n0qjjH1VkwcEWIeblrXgYKx2EkQEyzg90L2fAU=;
        b=vOq8L5Z5MlBrJ1bX8lR/CdsdOlaplPu7joLp/GZTp/6t0/YmE8CjbKYNpThyoRAUlo
         Fw6eF9JafF00LDXLBT2sX+Ef0uuGwM0h1KsOblLZ4qQ4B+rCPV+CefwsMx1o1qxvMXQY
         uTWSk0rfvFZPrS+bm4Vd+ZWTADLNDhFza6kskiBbelgdfYol6R6dj6nr5Mg8JnKXRNin
         HBlJVdLA4vIP3rttoMOYP2ibLN/r3TFQgQRU0SrlHuFQoWi5VhRPKTHeFJYbFE264ITg
         hTt1anPxBzsyOulIKnuRQvq/9T3sLRKquQGIK2qtFWXErP39onm+rRWiqJVw6hhEPbqg
         v7aw==
X-Forwarded-Encrypted: i=1; AJvYcCVtsMY9K+cPU+8wDJxKtCoBDgfh9beUwkcHWKyUM3aegm2Gy+DNcoNgSSY9VZD9pGGlSzjH3fkJwQjS2oPy6THpO2EHv8na16bNSXpn
X-Gm-Message-State: AOJu0Ywwbfl08KutEdVglfWEvZNq7NzU7gUdUyGqU1wo5vYr2cOlCZq6
	cxTaRQ9G31ldjtRU+1CRSberxyGk9xcy1ED0gZBzqF+aZfjDpy+UldaMijiUczk=
X-Google-Smtp-Source: AGHT+IGmTPYxVwkvf2rhwL8zU/NZGHnbiAZydgzI8r2rGWnrG/18tz3oiCnUqIQIWLdj7FEj0JEz3A==
X-Received: by 2002:a05:6a21:150b:b0:1c3:aec6:7663 with SMTP id adf61e73a8af0-1c8eaf47d0emr2025198637.39.1723603997448;
        Tue, 13 Aug 2024 19:53:17 -0700 (PDT)
Received: from [192.168.6.6] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac8306fcsm348436a91.54.2024.08.13.19.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 19:53:17 -0700 (PDT)
Message-ID: <fa57bdec-0b29-4e6f-92c8-a223cdbd9ff0@bytedance.com>
Date: Wed, 14 Aug 2024 10:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] lib: test_objpool: Use kthread_run_on_cpu()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240807160228.26206-1-frederic@kernel.org>
 <20240807160228.26206-10-frederic@kernel.org>
Content-Language: en-US
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <20240807160228.26206-10-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/8 00:02, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   lib/test_objpool.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> index bfdb81599832..2c09dd91e731 100644
> --- a/lib/test_objpool.c
> +++ b/lib/test_objpool.c
> @@ -371,14 +371,10 @@ static int ot_start_sync(struct ot_test *test)
>   		if (!cpu_online(cpu))
>   			continue;
>   
> -		work = kthread_create_on_node(ot_thread_worker, item,
> -				cpu_to_node(cpu), "ot_worker_%d", cpu);
> -		if (IS_ERR(work)) {
> +		work = kthread_run_on_cpu(ot_thread_worker, item,
> +					  cpu, "ot_worker_%d");
> +		if (IS_ERR(work))
>   			pr_err("failed to create thread for cpu %d\n", cpu);
> -		} else {
> -			kthread_bind(work, cpu);
> -			wake_up_process(work);
> -		}
>   	}
>   
>   	/* wait a while to make sure all threads waiting at start line */
> @@ -562,14 +558,9 @@ static int ot_start_async(struct ot_test *test)
>   		if (!cpu_online(cpu))
>   			continue;
>   
> -		work = kthread_create_on_node(ot_thread_worker, item,
> -				cpu_to_node(cpu), "ot_worker_%d", cpu);
> -		if (IS_ERR(work)) {
> +		work = kthread_run_on_cpu(ot_thread_worker, item, cpu, "ot_worker_%d");
> +		if (IS_ERR(work))
>   			pr_err("failed to create thread for cpu %d\n", cpu);
> -		} else {
> -			kthread_bind(work, cpu);
> -			wake_up_process(work);
> -		}
>   	}
>   
>   	/* wait a while to make sure all threads waiting at start line */

Looks good to me. Thanks for the simplification.

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>

