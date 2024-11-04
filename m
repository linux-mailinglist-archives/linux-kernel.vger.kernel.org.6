Return-Path: <linux-kernel+bounces-395142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3E39BB913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E7B1F223C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0651BF804;
	Mon,  4 Nov 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8yc4lDU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67313C827
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734592; cv=none; b=bTxMS5+f+MS8WMhoRmFYbIEbQ20n0wf9ISGNMFbem0BnS/6O9JT+fnZ3GOh7wZAQowYN0tl29kG7PJoRKIBO9yOZPpzkyfmjdcEcFujTTSCqytE/noNEWB7saQGmM6ojiamGMs05GoeKhHYG8318r3EpatMOIc4D84WBSvDQHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734592; c=relaxed/simple;
	bh=FTxyyNtpjjEJ8pmJ46Ma08R/3lLHfHVUUIJ/tfMeDW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k97oV7IQvX4i8ZoJBybMNm418YXmOrY3hU3Ytf7hJWHFj9suPCutPQhmZq3F1eRSiU/j8gnQE4XF1CJY5YT3XeZmSsMVTCbXKv9WfVFcf2bLPg/QGfyqpqZ/nyRt9c5rx0JmuJzHnl8ZrHbrLP7YBYyUu7Z7mDT+y1PkcSqk8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8yc4lDU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a850270e2so730791166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730734589; x=1731339389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ4JKX2LorURTLXKxWOksbQI0A4yoB4RGsDEqwmYGRk=;
        b=i8yc4lDUq8Q1qmMU8gen1SYY9m9PasqC5lqlplMTbGEUoglxK04pyGMQvOyTpPJHSa
         g5WYv9kDDDyrIl4IH1LuxLWx16hAaPiwSuBeNQVLaaXYgy38/Oshxu5Ebb72PkJI8+9B
         QqCfhP8aAb+V35fNqb41riU0RwtnrTdbq4Og31TvDlq5P0qqNNiltI1YvcCCxde3LClB
         bcskKa4aTD1FE/hxjzJAX/G5RqzewT8kR9t957g41TPGMxj1fQmnIB9GsGpL07bpa5s3
         bS7Y1OZW2WnrNXkV0qOKMPphXHUIvaQPEHOButNb96QJuPU9eIsm/wb7YpOeim+oQVwR
         6KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734589; x=1731339389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ4JKX2LorURTLXKxWOksbQI0A4yoB4RGsDEqwmYGRk=;
        b=aSSi9MzMBrT5WCwbbbG9ztR+INBoo9h2trxqeGT7BOhTQ13rRYptvCNeTm8tFpUDn4
         7t7Fe97Sr17h52WTdBtBxGUJUaOQOS1g/ny1u/sNmWM6AvfnRnHn8Obk1sLoNpoOxS/N
         qUxBe466o9nkvQlD/vOFZY+fKq9da3gQlaLSfrxMmNBeC9r+TklMpWAQ6LLHCoD7EgjC
         k7OekeuH/ExhMAegdzlximcRsQL3yez7M6X4diI+1o6eUCQrxN3Sww72ggvzT2CGUosm
         wB5vZcA8fArpISyo4KpZLnf2dx81PoMSeZSwRjGPWvCSu+8aMn201W/EQjwy3mgz60s3
         85QQ==
X-Gm-Message-State: AOJu0YyfV8sPxYfsj3BfWh2w0/zp+puRYr9hWQdEKaP0rdcNDGb2gbw/
	4Fwd4niM9HuOf5LZwbsC6vk8/2ss1SrzvCI/rTNuTaNFn2+H6Dn8
X-Google-Smtp-Source: AGHT+IGbuqxlPK+WlcGvI2zXPinuwZlTD4rpgt/wgraslP9/65dYiROBkdZaAagn720RVFaIlBEwGA==
X-Received: by 2002:a17:907:9408:b0:a99:f887:ec09 with SMTP id a640c23a62f3a-a9e655b92b0mr1167778466b.35.1730734588391;
        Mon, 04 Nov 2024 07:36:28 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5664d165sm566991266b.185.2024.11.04.07.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:36:27 -0800 (PST)
Message-ID: <0dac9a18-e993-d60d-9b13-da2cd0c3bd4c@gmail.com>
Date: Mon, 4 Nov 2024 16:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/19] perf: Fix perf_pmu_register() vs perf_init_event()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
References: <20241104133909.669111662@infradead.org>
 <20241104135517.858805880@infradead.org>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20241104135517.858805880@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4. 11. 24 14:39, Peter Zijlstra wrote:
> There is a fairly obvious race between perf_init_event() doing
> idr_find() and perf_pmu_register() doing idr_alloc() with an
> incompletely initialized pmu pointer.
> 
> Avoid by doing idr_alloc() on a NULL pointer to register the id, and
> swizzling the real pmu pointer at the end using idr_replace().
> 
> Also making sure to not set pmu members after publishing the pmu, duh.
> 
> [ introduce idr_cmpxchg() in order to better handle the idr_replace()
>    error case -- if it were to return an unexpected pointer, it will
>    already have replaced the value and there is no going back. ]
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/events/core.c |   28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11739,6 +11739,21 @@ static int pmu_dev_alloc(struct pmu *pmu
>   static struct lock_class_key cpuctx_mutex;
>   static struct lock_class_key cpuctx_lock;
>   
> +static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
> +{
> +	void *tmp, *val = idr_find(idr, id);
> +
> +	if (val != old)
> +		return false;
> +
> +	tmp = idr_replace(idr, new, id);
> +	if (IS_ERR(tmp))
> +		return false;
> +
> +	WARN_ON_ONCE(tmp != val);
> +	return true;
> +}

Can the above function be named idr_try_cmpxchg?

cmpxchg family of functions return an old value from the location and 
one would expect that idr_cmpxchg() returns an old value from *idr, too. 
idr_cmpxchg() function however returns success/failure status, and this 
is also what functions from try_cmpxchg family return.

Uros.

