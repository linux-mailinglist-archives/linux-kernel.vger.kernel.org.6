Return-Path: <linux-kernel+bounces-195600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14E8D4F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AADB28595
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123DB17F506;
	Thu, 30 May 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RwxRXyhJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CC176246
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083021; cv=none; b=pJRLGk27sccETFrBa6ZW4gqxT1SG3oMc/lWkPU9OISaXnjuybxrRxiTeZUkrXqX2EF0aWS61optLoN3nLh5VXuGwGem9BIQSJlg30V4twZ+Ohs4k5xnflaF0GI4qMxJK4dVET1jCeeZVQ0cPRK3H+5D38aO7c3JLjYQTdcLTb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083021; c=relaxed/simple;
	bh=iaQfvQSJKPuqC/g7uIa9elYYZ+csDMb2TH/hJRRLu2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG8OnY5aywvOGGd+84pbf5mXFSOgk6rAzNicWjoDGofZvo2nk69xiJCKVeYVIHynbD/+8rP+0AqwXsqtLdiFAXKnDNxDbaoN7yvjhB2ja0lw+KcnF3/xICSakZWGpEYHk6aDiCsXpccX7fqLANcK2HdLKlfjg8xuq0idiSw6kgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RwxRXyhJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421124a04d6so11061385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717083017; x=1717687817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfRTfm9PXIfDsjwFwFKFqJQ/IgaytwUE/fEPjM3ptoM=;
        b=RwxRXyhJhkRItncwlXfKJajxvWK4y60x3N+EzuX6Kk62gFA3h1T1X9dDFfuVzRAQsS
         +h1tAuPkp7DiDB+us1DEpFjc2MUU0arDklSNBr22EoGhwsf5cimeZxMcPGes/NQG83Df
         eSzLJJuzEjIv/WVrkDrCWKIb541kyddFLhRNs23+LkTcj/IBoqvXVdvrzSGS6MfXDlE7
         Pq1JXtyfpeqp0zDFm9RPU6Tl0AqEe+/9NcHp5avMdEiNafywN55O9A+PGgWzIE5pJUdZ
         356DtD4a1uyseP4XUL3G4Iv3pg63PrH4IogdwoU2qb7/UDNkEWIwvW52j6crzEJpZHgq
         sXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083017; x=1717687817;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfRTfm9PXIfDsjwFwFKFqJQ/IgaytwUE/fEPjM3ptoM=;
        b=m1S6JP2lM0VmAnG6IPk5dQ2/pwOXImRCgttDOOxw0qtxSsRyBWOGdvXMxRgc3A04hV
         7g/jXcd/K/ThPLj2lAQpfHPy186qRXrHeFs6USrxhUIlszL9uUBXSukU4d1o7agEHAuo
         pp4SMpXw7tYAmsS3tsjwLQgMe8ptk/Q4sIjX/gwbSM8VDUzjKrenqm4X5ccvbKEz3reO
         cB/RO95S8Nrc+eDDrti4whpohNNDyqekEp14KDSulcSfYqZXrV6hoTwaFWILX0vNoJrr
         C9yP+390IY6z4w8Y4OCxg4SkebdH+ARJlQi0t2UDc2cnWqRZACyWkD/pjTCzTmHMWZk5
         P/jA==
X-Forwarded-Encrypted: i=1; AJvYcCUUyOou67yoV2E5L/43G9Exyrw+8dIHnxkP58KXnwQ/UU7sXwSieKyXAVb5HcoaIlSr+pg1vEzCt/gMMitKBojr6wdsEqxuUffaSjTW
X-Gm-Message-State: AOJu0YxId96FUVWCE3DTN8ay2xEBZH8a9PwMXWI4tzrP/0/VZOUatyCt
	idQuNIEieiHKUaa4jldZTPvb666/IXIAUAbfyD3hA/7YqoYVyNGDTxA9lMd4QIc=
X-Google-Smtp-Source: AGHT+IGG1oTknVJBn2jB+FyeaYyisX4fTAtHZFR8cnWyGDDbZhWRb+CCfMPl6Eoi3fkG0umZ+H0w7g==
X-Received: by 2002:a05:600c:3d8b:b0:421:29e1:998 with SMTP id 5b1f17b1804b1-42129e10af2mr9062085e9.39.1717083017479;
        Thu, 30 May 2024 08:30:17 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:a23:f1c3:862a:5eac? ([2a10:bac0:b000:5de0:a23:f1c3:862a:5eac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706c952sm28153545e9.26.2024.05.30.08.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:30:17 -0700 (PDT)
Message-ID: <186d2d79-b7c2-4fab-8243-4c7080412074@suse.com>
Date: Thu, 30 May 2024 18:30:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prefetch: Add ARCH_HAS_PREFETCH definition when the
 architecture is not defined
To: Youling Tang <youling.tang@linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Mateusz Guzik <mjguzik@gmail.com>, Youling Tang <tangyouling@kylinos.cn>
References: <20240529032059.899347-1-youling.tang@linux.dev>
 <20240529032059.899347-2-youling.tang@linux.dev>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240529032059.899347-2-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.05.24 г. 6:20 ч., Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> After commit ab483570a13b ("x86 & generic: change to __builtin_prefetch()"), the
> __builtin_prefetch implementation will be used by default, so add its definition
> to return to a state similar to before commit[1].

I find those references to the past state somewhat confusing and not 
really adding sustenance to the explanation.

> 
> Currently prefetch_range() will be empty implemented under the x86_64 architecture,
> there was a concrete implementation before "x86 & generic: change to
> __builtin_prefetch()", so fix it.

Actually prefetch_range will be empty for every architecture which 
doesn't defined ARCH_HAS_PREFETCH and since we have a working generic 
fallback this indeed seems backwards. So defining ARCH_HAS_PREFETCH 
makes sense.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> 
> No similar changes have been made to ARCH_HAS_PREFETCHW at this time.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/include/linux/prefetch.h?id=8e4f2fd31bf737abb392e694898a1496157623b5
> 
> Fixes: ab483570a13b ("x86 & generic: change to __builtin_prefetch()")
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   include/linux/prefetch.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/prefetch.h b/include/linux/prefetch.h
> index b068e2e60939..162b7105e37c 100644
> --- a/include/linux/prefetch.h
> +++ b/include/linux/prefetch.h
> @@ -36,6 +36,7 @@ struct page;
>   */
>   
>   #ifndef ARCH_HAS_PREFETCH
> +#define ARCH_HAS_PREFETCH
>   #define prefetch(x) __builtin_prefetch(x)
>   #endif
>   

