Return-Path: <linux-kernel+bounces-282872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002D94E9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21935B221EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903116D4E6;
	Mon, 12 Aug 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qyl1BQTA"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD420323
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455332; cv=none; b=GzKkReUmgQaaFroaoSq4jFAewVogbWQ9QbuiMFPskMt6vGVkYsF7B9UxHw9NDt7of0ySzokACs88ti4JxNRpyryNlkMHAZQanht29WpVY4GXoh/QwgY9R1jTTLDFrm8hTC3FQNEyAlJh5ziw3M5hSLQpo/069QLxP2kWIQ7d/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455332; c=relaxed/simple;
	bh=PNupUm463iQE7T43+Zrxo6foOwsAjT1hssbqJKvS1nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQCTsZABMVgcb5iR2H4q3XtEs8Vfw4HzjTd+IBK+yvt6OoLqMZ4uNZpBgrEyQ5h+r7ZF/nPpveQkhq7HnnqGGy9h6DTu/WKPB4CyX7MIHfabrxT8YOTb7TV/a/DfCx3dDANgTgMx8DrugBltL4eQ47DbKZsANHjKBRsO1vj1xX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qyl1BQTA; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so497089fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723455329; x=1724060129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LezxPZ2pblaIeFvj/f40IQFP8Cd13qWLMfSEX26uTrg=;
        b=Qyl1BQTAHySkQ/pKl3Ih7zqE/4ejNF7mQNvms43yYPNRhHzvqETqUiTEl2rpK17vkq
         Gcct5H9Njkg9NwOShXwwi6kr0+ygms1u9a+em798UjXcewizt5PnhR7zC4duRE5QTIWc
         9Go6W5HgCmH7pZeb4OnHIJLK5NY3IoSc77FE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455329; x=1724060129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LezxPZ2pblaIeFvj/f40IQFP8Cd13qWLMfSEX26uTrg=;
        b=SUxDzO3WsCjD19BaoCbU9waKN0aCgDWpCTJqOxPuHZUeDzyVhwQanDijRfrB+TpdPE
         JyJ4eP+vDv9qK9geWqHM9pBWIXFZmrQ0FIlQoyKXr2PugdMKSF0CL9LcNHSr/1WDqK2a
         hbrooVIAR/oMHhhXhWDbErEzNj6ZOFNFEmqzG2V8bIKMHxp5imhufx8ariL+C5FzafzD
         HPCZG6K11nBiH6dPrdZPUXol1BMuM2KvYegpyOimkX4N7H/I5Fqe7eHa0j1VFKRrLlUY
         al1HH6i1c2cuzeVENA05LNLVb/kw4UXjJQ5FjjrrEPLd50pQkd619BF4M6WEjEMmCEMn
         lY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyNsXYFSIlc8sOHxM6s1rD0dX85p74EObTwSQ+xIuKJm4N8St+OJ9Xcp2oggXTYyWdvmCrp0nyekrNHvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOw6+hnYhX+zfue+ShRtAksfpEy2GLw0JdLJEZjY5AFIg19RRL
	C31mSuRNmgHTCzaZIkUMsKUEyBIF8oTVUjQ+lcZpiMf0a+3uF+FPaIXpsU7aVcU=
X-Google-Smtp-Source: AGHT+IEvaBJ1EAoM7XMitug7a/NQNwZ2GMcuPj+9Pyp+pxqnYpN4Y2JKVJZhBJ6VgvqO4qrwmTDuKQ==
X-Received: by 2002:a05:6871:3390:b0:261:b94:b0b with SMTP id 586e51a60fabf-26c62c1a506mr5354178fac.1.1723455329347;
        Mon, 12 Aug 2024 02:35:29 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a8f22sm3595976b3a.46.2024.08.12.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:35:28 -0700 (PDT)
Message-ID: <7612504c-cd56-4fcd-a287-d3fbc89162ea@linuxfoundation.org>
Date: Mon, 12 Aug 2024 03:35:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/cgroup: Add missing newline in test_zswap.c
To: Mohammed Anees <pvmohammedanees2003@gmail.com>, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 tj@kernel.org, lizefan.x@bytedance.com, mkoutny@suse.com, shuah@kernel.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240811145900.433711-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240811145900.433711-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/24 08:58, Mohammed Anees wrote:

Missing change log

> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   tools/testing/selftests/cgroup/test_zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index 190096017..7c849d836 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -351,7 +351,7 @@ static int test_zswap_writeback(const char *root, bool wb)
>   		goto out;
>   
>   	if (wb != !!zswpwb_after) {
> -		ksft_print_msg("zswpwb_after is %ld while wb is %s",
> +		ksft_print_msg("zswpwb_after is %ld while wb is %s\n",
>   				zswpwb_after, wb ? "enabled" : "disabled");
>   		goto out;
>   	}

The change looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

