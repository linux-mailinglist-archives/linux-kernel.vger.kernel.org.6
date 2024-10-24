Return-Path: <linux-kernel+bounces-380526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015119AF04D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14301F22D40
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F6216A0B;
	Thu, 24 Oct 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEUW+tcY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13031FE0E8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796456; cv=none; b=aQGsaTVBehLVbV9Kj0PJvqvAmC23PAjhDxnUTgSMCp1TfYDwyBqikKpCU42R80LVE3E5IhxnyroarKSjVsqgkH16tysTy0i6LhjY+4dEu+lpsbDYIm2fovegstl8ue7trj5D+AXSovZcht9NHEu/vKQF/gaP6CPh2MTeQgl1HyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796456; c=relaxed/simple;
	bh=t/Z+p0VKnoRUCF7jWgJnzZiAHmV4AUAAs9CJEqjGjj0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YhHYfHubA2+tgpdUDfTqoccFCtklwi8FOGTbRSGlxANMKZ8hL7xT9UFXawoOA8dJzLNrZK+nEctF14M40f/4rA5G+dBYEvdgDvM2ECaFSSSu9WSTjnSANb2xzU/Ehe9pKsK58fC4yL9fiAnhyM9CXl1pq/PINhHqGwjTSns1s00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEUW+tcY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729796452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwDmyKf+PA3myY/P5hhkcyKtlISireBxFg2TAhYe9rg=;
	b=GEUW+tcY3oJtFO1fxh/2LrhT9zdMZ/abVx83rVrxzbu/UYbd76Lu2zB5NykCiZDeTv4yTB
	GKCHEztLQTjahjElWdx4OJdazrAhJm7qZGKHYpsNA6aV8T6q5kKib9aQD2nHtYd64TtX80
	uK1gqZrNAnHRu8Ig0NzYUVhWFkmtnwg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-6ufCNjf_Pz6M8nkDjEU7HQ-1; Thu, 24 Oct 2024 15:00:51 -0400
X-MC-Unique: 6ufCNjf_Pz6M8nkDjEU7HQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb7ed1d6deso866617eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796450; x=1730401250;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwDmyKf+PA3myY/P5hhkcyKtlISireBxFg2TAhYe9rg=;
        b=d96FFnHrFHpU8VLNNWBIv/DHYMgLqp0CWX12fxaGE9plGlCCkpoAgjC4HZf79AJ5Lu
         dA6z5ZfYXo7lGsmTASalzYW/udc5typPJ/ZbOKDImNWpDSW5HDiqeCXAsnxzL8/mpybl
         +8fHGvaGN1XV9d33Jv1NZkaAZHZ4eFyuxd06/YL4TNsI5Bdg/YYZPT4JPKye4Zm13o2l
         RgfQQg/hVCDTInT93F76gWYryv8f9xIg85COhzH7HYQ8FrtYEqbE1X6QRkSxChLE56cZ
         8epOr77x7aaswUTiXqlzWqRn22HowaI/pZYW4/6d/dz0mDQYb0Jn0SA2B1bFXwwB8IRb
         MjYA==
X-Gm-Message-State: AOJu0YzGYuGLlCufraadP04BVSYWFd+ldor5cp9KUJLkRqP0b7SaDZwa
	SuF6WVHJFBuLQVzlE3wBwUtFVpMe5nnwUXZoHsoJ64EXNtFbbIYnXYNQFHmej7AhgtESN+j1upe
	nQ8ZdanJAofBITbEFa1ILXEeVJJitJ110sHG6ZUzab9SePa8cSnmAJDmoFXokEg==
X-Received: by 2002:a05:6358:2c93:b0:1c3:39ad:7c6c with SMTP id e5c5f4694b2df-1c3d819d79dmr574465355d.17.1729796450370;
        Thu, 24 Oct 2024 12:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHwD9z+lDh40t9ZTZAslpEWw4SMaATkLrufi+j9ewgL3Ksww1cxdVG7hCpc0Vrp8zNTEcUAg==
X-Received: by 2002:a05:6358:2c93:b0:1c3:39ad:7c6c with SMTP id e5c5f4694b2df-1c3d819d79dmr574460755d.17.1729796449837;
        Thu, 24 Oct 2024 12:00:49 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cd0eaesm55042361cf.54.2024.10.24.12.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 12:00:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <19e32325-8e1b-4a9b-ae74-22448847d189@redhat.com>
Date: Thu, 24 Oct 2024 15:00:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
References: <20241024183631.643450-1-cmllamas@google.com>
 <20241024183631.643450-3-cmllamas@google.com>
Content-Language: en-US
In-Reply-To: <20241024183631.643450-3-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 2:36 PM, Carlos Llamas wrote:
> The LOCKDEP_*_BITS configs control the size of internal structures used
> by lockdep. The size is calculated as a power of two of the configured
> value (e.g. 16 => 64KB). Update these descriptions to more accurately
> reflect this, as "Bitsize" can be misleading.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   lib/Kconfig.debug | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c8b1db37abe6..5a769cbf4bb2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1522,7 +1522,7 @@ config LOCKDEP_SMALL
>   	bool
>   
>   config LOCKDEP_BITS
> -	int "Bitsize for MAX_LOCKDEP_ENTRIES"
> +	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 24
>   	default 15
> @@ -1530,7 +1530,7 @@ config LOCKDEP_BITS
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
>   
>   config LOCKDEP_CHAINS_BITS
> -	int "Bitsize for MAX_LOCKDEP_CHAINS"
> +	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 21
>   	default 16
> @@ -1538,7 +1538,7 @@ config LOCKDEP_CHAINS_BITS
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
>   
>   config LOCKDEP_STACK_TRACE_BITS
> -	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
> +	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 26
>   	default 19
> @@ -1546,7 +1546,7 @@ config LOCKDEP_STACK_TRACE_BITS
>   	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
>   
>   config LOCKDEP_STACK_TRACE_HASH_BITS
> -	int "Bitsize for STACK_TRACE_HASH_SIZE"
> +	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 26
>   	default 14
> @@ -1554,7 +1554,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
>   	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
>   
>   config LOCKDEP_CIRCULAR_QUEUE_BITS
> -	int "Bitsize for elements in circular_queue struct"
> +	int "Size for elements in circular_queue struct (as Nth power of 2)"
>   	depends on LOCKDEP
>   	range 10 26
>   	default 12
Acked-by: Waiman Long <longman@redhat.com>


