Return-Path: <linux-kernel+bounces-349680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29498F9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B9B284407
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AF1CDFC9;
	Thu,  3 Oct 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TPB9nAmL"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF231ABEC5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995249; cv=none; b=c83eiIh8UsY0lqBqsakYh9VF/FY8g8OPNn4KbA/PsNpXsfDPZ/8ZfYC9W7fjOETa0GT18sO4x6BgUXVuxPG8Rduh3AYCGdkmcAFNaQUokMRb4IIaXGYFUmSRwDz/OsT1M8toTeYrBtPsJCYEyENQZA/aBJ2S+lGhVgqjw8Fz9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995249; c=relaxed/simple;
	bh=3VXruAsdmGDyoMg+wtBOf4bKnPT8e1z4kvY3ahtR3N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRaRQ1R9bTpk9PZOcpGazsdSQz+1s3Hmvi5fm5blxlYQPA4p/ryYc6R1sMy1wRTO4dSjYNx8Mzo5tyH2JmSgjSq5GqX5YvvKU045KbL49HsmlXvqH1Q5fO8w94VTelTsR6K9WJlPwrNkj7vqi0Ejn37BvMHH/twuGEXyT4Za/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TPB9nAmL; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd93a6617so64696139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727995246; x=1728600046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/JhzNNbvX+G8AtyPVkto0Jw9UMbIoTZigBBnzxMFk=;
        b=TPB9nAmLQLygAIzO1xp/AOwpSury1JkWIpSHu21eb7lIMinoxmyCl/7qCMfs640XN3
         D3M8GVaMo0Atc3KhqWkXeZDaDlxScBT8CuKoiKdSp3i04IOOcaIsuZvpI4T6sW4d3TcP
         yz2o/E2q9DIXue382pXwDkKuKwtptQv/KSKxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995246; x=1728600046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/JhzNNbvX+G8AtyPVkto0Jw9UMbIoTZigBBnzxMFk=;
        b=O6BslgNwR/QfKeK3IyceQJFEh/AOkwnIHTsJNushTpvRDMXVySRE1T9MBsgAnu3Qn0
         WQKvQd4IbETZE28na8+gtRuOHBMNt5MAExbF18IK49MaW+uMcPLuRb95KYgvn9c+xAJ+
         gcyOvmvipJ7FpfBhBeL3L8NLaubDPyiwOXlrZ7JQvaAZhV5Sv5t6oaTxZhzMpV8DYFuJ
         dP/PZNnlwrYTSvtAWyY2V2wpFe7s6DlJPnvPneWXuwUJjDey0o1ebjwWAiCOB3pyGmZ2
         LgUacKDTI+tRXjWc6wBUDGxvSkB03Z0CQOc5I/B6qCslN2bedRNlwx3i6aWF4tHinfQU
         HBMw==
X-Gm-Message-State: AOJu0YxoqXupm7iKNKsDIiptpQArupYo8bzGltO7G/d2QRXIVB+Al3aA
	fvivCcPxOrlB4eWI9HIytxwX4Ptrwo8iV7ic42EY/qB0UnqSpqS2q2sGyKPOkfw+9GzvBhuP6R9
	B
X-Google-Smtp-Source: AGHT+IEvp/0Cj5ZJb47Qe1uiq6W8Oxbhsdw3zwI/pXSBjoAng21khXzV8zn07FouMk4OVv6lTkynRQ==
X-Received: by 2002:a05:6e02:174f:b0:3a0:922f:8e9a with SMTP id e9e14a558f8ab-3a375bb2a3bmr6417805ab.17.1727995246480;
        Thu, 03 Oct 2024 15:40:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55969155sm481461173.47.2024.10.03.15.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:40:46 -0700 (PDT)
Message-ID: <ee987900-85ff-49f4-b393-4bbb889554dc@linuxfoundation.org>
Date: Thu, 3 Oct 2024 16:40:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/rseq: Adapt to glibc __rseq_size feature
 detection
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241003175157.1634301-1-mathieu.desnoyers@efficios.com>
 <20241003175157.1634301-3-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241003175157.1634301-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 11:51, Mathieu Desnoyers wrote:
> Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:
> 
> commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")
> 
> Wihout this fix, rseq selftests for mm_cid fail:

Without

Can you change the short log to say "Fix mm_cid test failure"

This way it is clear that this fixes a test failure. You can
add "Adapt to glibc __rseq_size feature detection: in the
chabeg log for context.

> 
> ./run_param_test.sh
> Default parameters
> Running test spinlock
> Running compare-twice test spinlock
> Running mm_cid test spinlock
> Error: cpu id getter unavailable
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> CC: Carlos O'Donell <carlos@redhat.com>
> CC: Florian Weimer <fweimer@redhat.com>
> ---
>   tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
>   tools/testing/selftests/rseq/rseq.h |  10 +--
>   2 files changed, 76 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 96e812bdf8a4..3797bb0881da 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -60,12 +60,6 @@ unsigned int rseq_size = -1U;
>   /* Flags used during rseq registration.  */
>   unsigned int rseq_flags;
>   
> -/*
> - * rseq feature size supported by the kernel. 0 if the registration was
> - * unsuccessful.
> - */
> -unsigned int rseq_feature_size = -1U;
> -
>   static int rseq_ownership;
>   static int rseq_reg_success;	/* At least one rseq registration has succeded. */
>   
> @@ -111,6 +105,43 @@ int rseq_available(void)
>   	}
>   }
>   
> +/* The rseq areas need to be at least 32 bytes. */
> +static
> +unsigned get_rseq_min_alloc_size(void)
> +{
> +	unsigned int alloc_size = rseq_size;
> +
> +	if (alloc_size < ORIG_RSEQ_ALLOC_SIZE)
> +		alloc_size = ORIG_RSEQ_ALLOC_SIZE;
> +	return alloc_size;
> +}
> +
> +/*
> + * Return the feature size supported by the kernel.
> + *
> + * Depending on the value returned by getauxval(AT_RSEQ_FEATURE_SIZE):
> + *
> + * 0:   Return ORIG_RSEQ_FEATURE_SIZE (20)
> + * > 0: Return the value from getauxval(AT_RSEQ_FEATURE_SIZE).
> + *
> + * It should never return a value below ORIG_RSEQ_FEATURE_SIZE.
> + */
> +static
> +unsigned int get_rseq_kernel_feature_size(void)
> +{
> +	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
> +
> +	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
> +	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> +
> +	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
> +	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> +	if (auxv_rseq_feature_size)
> +		return auxv_rseq_feature_size;
> +	else
> +		return ORIG_RSEQ_FEATURE_SIZE;
> +}
> +
>   int rseq_register_current_thread(void)
>   {
>   	int rc;
> @@ -119,7 +150,7 @@ int rseq_register_current_thread(void)
>   		/* Treat libc's ownership as a successful registration. */
>   		return 0;
>   	}
> -	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
> +	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
>   	if (rc) {
>   		if (RSEQ_READ_ONCE(rseq_reg_success)) {
>   			/* Incoherent success/failure within process. */
> @@ -140,28 +171,12 @@ int rseq_unregister_current_thread(void)
>   		/* Treat libc's ownership as a successful unregistration. */
>   		return 0;
>   	}
> -	rc = sys_rseq(&__rseq_abi, rseq_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
> +	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
>   	if (rc)
>   		return -1;
>   	return 0;
>   }
>   
> -static
> -unsigned int get_rseq_feature_size(void)
> -{
> -	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
> -
> -	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
> -	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> -
> -	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
> -	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
> -	if (auxv_rseq_feature_size)
> -		return auxv_rseq_feature_size;
> -	else
> -		return ORIG_RSEQ_FEATURE_SIZE;
> -}
> -
>   static __attribute__((constructor))
>   void rseq_init(void)
>   {
> @@ -178,28 +193,53 @@ void rseq_init(void)
>   	}
>   	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
>   			*libc_rseq_size_p != 0) {
> +		unsigned int libc_rseq_size;
> +
>   		/* rseq registration owned by glibc */
>   		rseq_offset = *libc_rseq_offset_p;
> -		rseq_size = *libc_rseq_size_p;
> +		libc_rseq_size = *libc_rseq_size_p;
>   		rseq_flags = *libc_rseq_flags_p;
> -		rseq_feature_size = get_rseq_feature_size();
> -		if (rseq_feature_size > rseq_size)
> -			rseq_feature_size = rseq_size;
> +
> +		/*
> +		 * Previous versions of glibc expose the value
> +		 * 32 even though the kernel only supported 20
> +		 * bytes initially. Therefore treat 32 as a
> +		 * special-case. glibc 2.40 exposes a 20 bytes
> +		 * __rseq_size without using getauxval(3) to
> +		 * query the supported size, while still allocating a 32
> +		 * bytes area. Also treat 20 as a special-case.
> +		 *
> +		 * Special-cases are handled by using the following
> +		 * value as active feature set size:
> +		 *
> +		 *   rseq_size = min(32, get_rseq_kernel_feature_size())
> +		 */
> +		switch (libc_rseq_size) {
> +		case ORIG_RSEQ_FEATURE_SIZE:	/* Fallthrough. */
> +		case ORIG_RSEQ_ALLOC_SIZE:
> +		{
> +			unsigned int rseq_kernel_feature_size = get_rseq_kernel_feature_size();
> +
> +			if (rseq_kernel_feature_size < ORIG_RSEQ_ALLOC_SIZE)
> +				rseq_size = rseq_kernel_feature_size;
> +			else
> +				rseq_size = ORIG_RSEQ_ALLOC_SIZE;
> +			break;
> +		}
> +		default:
> +			/* Otherwise just use the __rseq_size from libc as rseq_size. */
> +			rseq_size = libc_rseq_size;
> +			break;
> +		}
>   		return;
>   	}
>   	rseq_ownership = 1;
>   	if (!rseq_available()) {
>   		rseq_size = 0;
> -		rseq_feature_size = 0;
>   		return;
>   	}
>   	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
>   	rseq_flags = 0;
> -	rseq_feature_size = get_rseq_feature_size();
> -	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
> -		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
> -	else
> -		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;
>   }
>   
>   static __attribute__((destructor))
> @@ -209,7 +249,6 @@ void rseq_exit(void)
>   		return;
>   	rseq_offset = 0;
>   	rseq_size = -1U;
> -	rseq_feature_size = -1U;
>   	rseq_ownership = 0;
>   }
>   
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index d7364ea4d201..4e217b620e0c 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -68,12 +68,6 @@ extern unsigned int rseq_size;
>   /* Flags used during rseq registration. */
>   extern unsigned int rseq_flags;
>   
> -/*
> - * rseq feature size supported by the kernel. 0 if the registration was
> - * unsuccessful.
> - */
> -extern unsigned int rseq_feature_size;
> -
>   enum rseq_mo {
>   	RSEQ_MO_RELAXED = 0,
>   	RSEQ_MO_CONSUME = 1,	/* Unused */
> @@ -193,7 +187,7 @@ static inline uint32_t rseq_current_cpu(void)
>   
>   static inline bool rseq_node_id_available(void)
>   {
> -	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id);
> +	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, node_id);
>   }
>   
>   /*
> @@ -207,7 +201,7 @@ static inline uint32_t rseq_current_node_id(void)
>   
>   static inline bool rseq_mm_cid_available(void)
>   {
> -	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
> +	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
>   }
>   
>   static inline uint32_t rseq_current_mm_cid(void)

thanks,
-- Shuah

