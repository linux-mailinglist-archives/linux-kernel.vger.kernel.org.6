Return-Path: <linux-kernel+bounces-317779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45E96E3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386961C22920
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287B18FC92;
	Thu,  5 Sep 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6Ie6RHg"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39917839C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566942; cv=none; b=DYZhX4ziq+z4Vj6eUqRHGTy5nF3osxujkaM5GA9gYpi0Ay0JvQuDEv82rjK1hNMG2no1aOllzHwCqV9ngHfzZDct/MhXK2lQBHX2uRhm4z3a6wqqLEfdxapW321O9b6PsFyCqs5rZ18wdCbhcPV4n5sSiq6Cx6JAhnkbKLYNYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566942; c=relaxed/simple;
	bh=KVfppO/OEu4JSFxqsp6+rk9JU9GAKkSR3UpeROLFBAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIVTfQWGn+5Jtj+CNH8jWo0k4QUdQNmjQq8jcix97BOJE1x0+la9q8aZZnUisd8AZYjFEWEGKRLEAl3ZXz/dB+GaGlEreF62wrRWHU+pOffnEa0EzYvbshbzwnf7ldZjgR8DHsUh6NpTQCJCL4QXs4MwphyTbRDdGN7mNvqLTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6Ie6RHg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f9339e534so48097439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725566939; x=1726171739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQESoE5jrIQuvbeZ06q7SVpcM4ff6P+vp6Cc+thN/90=;
        b=e6Ie6RHgezgyFmoCu5iRc74BCZyRvM6UUXwcQQ5F/m+tzq41lVLA9Qo6XXz6D806r1
         qjm9IK8PazZumYPG2p3H/GU0gYNajQDFcCofLrXah3LqHAkjdsm3YpiGNm4wszwNzcBK
         IXLeH+ggdF87oiBMeuc7Qx620CkNq6pomxrH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725566939; x=1726171739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQESoE5jrIQuvbeZ06q7SVpcM4ff6P+vp6Cc+thN/90=;
        b=ekS2pi7Mpzy8QjRZ+YNumy0Mx+zftGZpyb/zBcD/+ixWEefWO/qRQ7jtDPYTzB4dnT
         YCxA0sgTKN8Gyges5FQNla9EK2018r1kgNvTKswozNKn6PDhl8uTmHoAhuMTEK/aH1Uu
         ipoO8Cdr4k4sBWYf+1oG9PPxcVBz0RPaKcJxQJBBvX3HOanE80jLV2U1URRghJpZqMqL
         oBA5OB61lNnWCW/AqMlvtBF9GHUCrQ1yCSM6G+7Flcu3a1k/dRupqh74H+hb2pzvhaKi
         CQlS5yBbIbwe59LSHznXr7SlZNPSYYt8ZbjBroIAgRWQA9orPsa7VWdpW2M9PaD378P2
         bMPw==
X-Gm-Message-State: AOJu0YxxiNZl08nnZWzmtX/C9F2YKHtGeh5x0kQmPqZdyKNPSw9Iv4ck
	bVtmEtA5Z1yO4Zrwh4iHsXcCmoVZxMk+Lgv+fg/VN1C56wKuReFj6DXkK6PrFPs=
X-Google-Smtp-Source: AGHT+IHiZ1DErnBMIrtFLTypn2tBl4B8H3wXTt6ZpGSN1L/aP8INtS+n6Zwr53XItltNhGLDUYkIfQ==
X-Received: by 2002:a05:6e02:144e:b0:39f:5efe:ae73 with SMTP id e9e14a558f8ab-39f5efeb18amr171392625ab.5.1725566939478;
        Thu, 05 Sep 2024 13:08:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc65b2sm43824365ab.47.2024.09.05.13.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:08:59 -0700 (PDT)
Message-ID: <88a9bf6d-099a-43fc-ac71-b12380ae586e@linuxfoundation.org>
Date: Thu, 5 Sep 2024 14:08:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: futex: Fix missing free in main
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mingo@redhat.com, shuah@kernel.org, tglx@linutronix.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905020125.2830-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905020125.2830-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 20:01, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> By readind the code, I found there is no free() after asprintf().
> Just free it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
> v1->v2:
> 	Set a flag to determine if test_name needs free.
> 	
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 215c6cb539b4..d78bb5112fce 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -362,6 +362,7 @@ int main(int argc, char *argv[])
>   {
>   	char *test_name;
>   	int c, ret;
> +	int need_f = 1;

This can be a bool which - better to set it to false as a initial
value.

>   
>   	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
>   		switch (c) {
> @@ -404,6 +405,7 @@ int main(int argc, char *argv[])
>   		       "%s broadcast=%d locked=%d owner=%d timeout=%ldns",
>   		       TEST_NAME, broadcast, locked, owner, timeout_ns);
>   	if (ret < 0) {
> +		need_f = 0;

You would set it to TRUE here.

>   		ksft_print_msg("Failed to generate test name\n");
>   		test_name = TEST_NAME;
>   	}
> @@ -416,5 +418,7 @@ int main(int argc, char *argv[])
>   	ret = unit_test(broadcast, locked, owner, timeout_ns);
>   
>   	print_result(test_name, ret);
> +	if (need_f)

Check against TRUE

> +		free(test_name);
>   	return ret;
>   }

thanks,
-- Shuah

