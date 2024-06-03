Return-Path: <linux-kernel+bounces-198608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF278D7AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E97C1F21338
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ADE210FF;
	Mon,  3 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIwXTP8S"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC71865;
	Mon,  3 Jun 2024 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391841; cv=none; b=AkKDP9wHc9YD8EvWY8BAtlXZv+DhU0C3/dzLdPbraUYAcFrkQWvgSpiAP5JjiskkPkRUNuOMV9eGfR2Sqe43cpox79tiVst7bC/Fz24weImMwfW9bnG+AgGOhoM0m6QTe+KbxX2BTE+yzHagtIGl6B1KBSE76Zmsei3Rq6AB6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391841; c=relaxed/simple;
	bh=c4EQ395EVEkHUx+UJHZgCvWRXfP5MgXRBB/M9EYRGdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXtEud+Qs/VF5s6/C9QN/y0pU7MXBxmqP2ZuIXnW6NGv6ZIKoUHMHCrkmkS7lHrfbKKLJhPU+zatc2XsLhS1LetGq/d1WD0ARYPTh/eiovRsVaGDgb6As54ogUHeH7sJGQDEkFHKD2aOSA/cAJpUvLJLGB+jD9EEdAgPaFbcxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIwXTP8S; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b91f655d1so1256077e87.1;
        Sun, 02 Jun 2024 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717391838; x=1717996638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RnV9JsvJmhBYbpToQy8QZUnR+UwLKF/Ba+00hn07p1s=;
        b=gIwXTP8SKd5KKn6oRbfn5As2uAvzjRFNnhqMMZ1K3QNUouipyJ8B7/U+qaC/cj4KH0
         2uTo2bpMxf9DmnjqpY4OGK35HeAkHh9uJSj1S24KTkFSU4cNwT//klKas0heJo1UzZu1
         LUXGZ4vncfW2mGdlnYtdcXuhq0eoElv+7J1xgKe2DtCWWQW1ZiwyZT2uYl+eH5HKDRr+
         IWcPO04NXQICP0xsPZ9c79+IBUp3hyQC38FqQGRqhkKauekkqfZr9hLuuK1GF+gAoThL
         3MTk83GLpcyqM3vEGQ2Hk7SKDvQHEjNGEEn3I4+KbxaoyqMdb98BAvUmnrfsSiBTpm2H
         VQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717391838; x=1717996638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnV9JsvJmhBYbpToQy8QZUnR+UwLKF/Ba+00hn07p1s=;
        b=EoI7laz8SbjpXuSDRHiGOP2iXzImi5buqN5gvUFzYvWchr+vXPmoREpjnAD8qvJDZa
         HUtFo/c+rL2MP8Ai0okIC4x9L3ByQ3uDi9a6IGDFzrIoAHM/QNpiX3JC9zQgPUQ52kee
         TzcWP4IiZGYs8G3GIY4+FscF65ei0KYWl1zaeLbkxoHSmmLGnHX6EbOI0nuYKrXNn8Rb
         yBOMgPjy5+EgMwVKYW+3GI7d89cqkWvW6/8rEM3G1bSsaa/DjhKArPOGffZ7ISBgV8Ci
         yxMDabshQ1761+lSD0oYsTCusAZftPy6ajsGCfoTSR5cgFyYQBtR9CP+uBqgeg5ugVG4
         Q5mg==
X-Forwarded-Encrypted: i=1; AJvYcCWxkworGv5pf8d2zoyQxySfC25/WN7N/GCCWASqkbi22udmNiy7zqm62gi95j511kjfbchqSfxnv5jPHiw/6Zsw8AtDsW5CxKfK6/71A2uC
X-Gm-Message-State: AOJu0YxiGEKLH2UyCnZC+Lfgewfofht4IA8hapccF1yTzOkCyUs3saH/
	qG4hmBHU3G/AXq37lQYCdJ026MG35wRu4RSPmVe5l1WB7yHs4br4HXTiug==
X-Google-Smtp-Source: AGHT+IF4HrQPKLc2NftBOh/eK28mNaOEqqulHXXdJl3wqXGJ6359k6gYaOwg7MRhcvKqGTDO3jUVgw==
X-Received: by 2002:a05:6512:239f:b0:52b:9034:ef06 with SMTP id 2adb3069b0e04-52b9034f082mr1516863e87.24.1717391838104;
        Sun, 02 Jun 2024 22:17:18 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75da1sm1109642e87.176.2024.06.02.22.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 22:17:17 -0700 (PDT)
Message-ID: <9db9583a-4552-474d-bec1-f2fd1e486c9e@gmail.com>
Date: Mon, 3 Jun 2024 08:17:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/test_linear_ranges: add missing MODULE_DESCRIPTION()
 macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240531-md-lib-test_linear_ranges-v1-1-053a1aad37c6@quicinc.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240531-md-lib-test_linear_ranges-v1-1-053a1aad37c6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/24 02:45, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_linear_ranges.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

> ---
>   lib/test_linear_ranges.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/test_linear_ranges.c b/lib/test_linear_ranges.c
> index c18f9c0f1f25..f482be00f1bc 100644
> --- a/lib/test_linear_ranges.c
> +++ b/lib/test_linear_ranges.c
> @@ -216,4 +216,5 @@ static struct kunit_suite range_test_module = {
>   
>   kunit_test_suites(&range_test_module);
>   
> +MODULE_DESCRIPTION("KUnit test for the linear_ranges helper");
>   MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240531-md-lib-test_linear_ranges-6807dcb18e7e
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


