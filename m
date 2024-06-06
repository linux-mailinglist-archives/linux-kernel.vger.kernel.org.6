Return-Path: <linux-kernel+bounces-204981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E178FF5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA71C26780
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5376036;
	Thu,  6 Jun 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPpNpuET"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9ED1DFD1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705323; cv=none; b=KhRlkd593mnHQWcfXkntls98pet2x6lDcZ2qA4Nhw4GSSrOy6rSoq5npxWVTazafYmud/so31oTlhTd0hGpqQqqSjICOtuontXPUElvbjN8dDWDN4k+Y+8kt/MDDD9Gbw2R5oD58bOFkDJBoLea3hHqzIS1aAJjlHuypikSgyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705323; c=relaxed/simple;
	bh=IeQiZi+uIaknNhW7RKTsnQtNTcGv+qZMLSeODc7m2DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ/nqryXNYXN7wSYxQtbh3jjUBHtMA8NYADbIyRXYayS8zkfdmOz1RTvFQLfCHknG9rGWR2rJreGBZo1V4fmTwBnI2fOg43Pt9plZBGNUayzTnk1y0hbDISggjITg+UJ/RUkc81R+RKSoLKkNv26dAp6XRRuF3WcdzAMqFbCgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPpNpuET; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717705320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1l57qOS6QDJXrwd8hP4TJWOIQI8tbRyEdMQkDoTT9Io=;
	b=FPpNpuETAflIjm1idUB6Zj7f8M4UbW4awKzGbW3ezmq/IwwdZNbs6UDp4bF9VzykLzWzlF
	K0+PPaGPvQS3fO0syLdva75wFO6Yr51Dn3arcUr8S/Em1f1Sm6VWHdiEkG+90BfIVg+auS
	sXrcNL1n7SuZJOCREwQHSIKsRCVNeYY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-nA_LwDUBOy-yPbLdX0NFyQ-1; Thu, 06 Jun 2024 16:21:55 -0400
X-MC-Unique: nA_LwDUBOy-yPbLdX0NFyQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52b88765386so1296413e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 13:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705314; x=1718310114;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1l57qOS6QDJXrwd8hP4TJWOIQI8tbRyEdMQkDoTT9Io=;
        b=FDm/m2Vn3yTrHjYRDFTurqmobGET2jqiG5Wevv9RM4nFf5dtlOMcchn+aaLpda20Q3
         M3U6SxY8BaMSxYNRB0W5vEtyGD6FEWUHpB/xb3mK2vk9FomaRGc6FQCxtj9sgf/KUKfW
         bYkf7b52BxhkPfXSkzmdjTjEtntr7FU5stlTRTH2lEAsEjlokaw+xytHsJHdT/OtqCoA
         Q6193kXGiAmv5lYCvEouvvON3weKdzNnPileFB56hvIh2cN+LGq3lysT6C7cqkQi2JwX
         Tu2qQXnTJlb2bF3dg7xxH8jSPFl5y19fspvPNd3ntkElE9/0bp1ehtl5QSYcmNe28fY9
         S4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPICc1RSIJmxlhdKMusYFZAuCEwlVOBqYl5ArdzZSL08zYnrrxEin2VQfsYcBFAkMN4U1fkahTsSKMgD53I+DswghaSKHb6OIOR0fv
X-Gm-Message-State: AOJu0YwI8mWLMbYBtsYe+lC93FWM6fpwM8CZ0jEAJEGBFxbqV7pIxKfn
	Zzh/pksYXgixELbGF/N1uGEM4tNvEHqerVgjuqb5bV6XdZuaaE3uL6q5VUsegVFUTzw4WLfGOLB
	EN5ZeSmiC1X1zoTKTbvGVTc5qkGJ3FcMCR/4PBHo0Cb/fEKilzLWalsIHM9ngKxoCSjX33Q==
X-Received: by 2002:a19:8c5d:0:b0:52a:d87f:60d7 with SMTP id 2adb3069b0e04-52bb9fcc98emr427846e87.46.1717705314114;
        Thu, 06 Jun 2024 13:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFWLjXQOaf77v5Xw3xeqPeDl/4Gaz1r7tflgoHLN/F5UFlfqaQexN4a4/AM7p8Mq2vrnkRwQ==
X-Received: by 2002:a19:8c5d:0:b0:52a:d87f:60d7 with SMTP id 2adb3069b0e04-52bb9fcc98emr427839e87.46.1717705313659;
        Thu, 06 Jun 2024 13:21:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19d52dsm33484935e9.8.2024.06.06.13.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:21:53 -0700 (PDT)
Message-ID: <b50bc8dd-bb1c-4859-83b9-ab90559452e9@redhat.com>
Date: Thu, 6 Jun 2024 22:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com, mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 Zi Yan <zi.yan@sent.com>, Pankaj Raghav <p.raghav@samsung.com>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
 <5b4e7ef2-3ced-4d4a-989c-e99b06598d32@redhat.com>
 <f199d120-2347-4bc0-8940-155c3c465de9@redhat.com>
 <20240606201831.ywmawi7xl6jgj3p4@quentin>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606201831.ywmawi7xl6jgj3p4@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 22:18, Pankaj Raghav (Samsung) wrote:
> On Thu, Jun 06, 2024 at 05:57:21PM +0200, David Hildenbrand wrote:
>> On 06.06.24 17:56, David Hildenbrand wrote:
>>> On 06.06.24 15:58, Pankaj Raghav (Samsung) wrote:
>>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>>
>>>> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
>>>> variable dummy to perform mmap read.
>>>>
>>>> However, this test was skipped even on XFS which has large folio
>>>> support. The issue was compiler (gcc 13.2.0) was optimizing out the
>>>> dummy variable, therefore, not creating huge page in the page cache.
>>>>
>>>> Add volatile keyword to force compiler not to optimize out the loop
>>>> where we read from the mmaped addr.
>>>>
>>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>>> ---
>>>>     tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> index d3c7f5fb3e7b..c573a58f80ab 100644
>>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>>>>     		char **addr)
>>>>     {
>>>>     	size_t i;
>>>> -	int __attribute__((unused)) dummy = 0;
>>>> +	volatile int __attribute__((unused)) dummy = 0;
>>>>     	srand(time(NULL));
>>>>
>>>> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
>>>
>>> The rick we do in some other tests is:
>>>
>>> char *tmp;
>>>
>>> tmp = *whatever;
>>> asm volatile("" : "+r" (tmp));
>>
>> char tmp; of course. See cow.c as an example.
> Thanks David! I remember also seeing this when I grepped for volatile in
> the selftests directory.
> 
> Willy gave the idea of making it as a global variable [1]. But your
> trick also works :)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index d3c7f5fb3e7b..9c957703c1f7 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -341,6 +341,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>   
>          for (size_t i = 0; i < fd_size; i++)
>                  dummy += *(*addr + i);
> +       asm volatile("" : "+r" (dummy));
>   
>          if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
>                  ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
> 
> I am fine with either solutions. But using the trick asm volatile is more
> cleaner than making it a global variable IMO and makes it more uniform
> across the other mm tests.

You can then even the "__attribute__((unused))", because the compile 
must assume that it is used inside the asm statement.

-- 
Cheers,

David / dhildenb


