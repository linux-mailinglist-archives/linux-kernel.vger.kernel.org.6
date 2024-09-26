Return-Path: <linux-kernel+bounces-340733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EFD98772F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D15B25DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FF156C74;
	Thu, 26 Sep 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F868qumm"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF31BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366635; cv=none; b=HOSdH644uzFR2FDEm3O4hDYhIhRjq+R4zu8z194DYlaM4hAhCPybpiyxxnepNYqH8c8nCp7GfRzriQFCoJOBF5jpIMeV4UBZIigfFNsmb6QnwDOe6yDCchZTABCIqQ9IuZJpiqV4eO1dhNSh16QrC7e6jzXpxVRVhJf7DpanM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366635; c=relaxed/simple;
	bh=RCbWaVdkpNKmgGJq2L3D+EvSQFwN0XWkCmjsWGwaEww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCdf2pEKiGuPcbQuQM+0/wVDmgk1E7f8o1GoMVgLxxzQTxt9oR7UOAi1B63Z/Apab+CjLALrPycIH4+DDJ8kHsPB+2NUzSDambkTOSzt5foenV1Xx/kpBSjnsGsMayEYX8ADOSE3G1OTHPYMaG8BTZQAk/zAXYXgmx5skC4UetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F868qumm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e08085596eso1059943a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727366633; x=1727971433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7bPPk0kAmsAXYjb0/D93cH5UC48AsXEk9c6DNPfZ9Q=;
        b=F868qumm9tpJ2qqRbWddNPp3TGMKvpBu+wfVqjAwgXsQqLGMjIw1i1v0aUYg1BBAs6
         qW7bkXOIKsLU627+QRxDNHJLhCUePykaWdr62jhflaJoDx17EgpOzp+1hK9IM/JR7F1H
         qPyaeNYnwiYZyEYbM8SbcEexfY1Tr5AMqNH5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366633; x=1727971433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7bPPk0kAmsAXYjb0/D93cH5UC48AsXEk9c6DNPfZ9Q=;
        b=gM0QUMYihFZZK3LTpzSM/4AFqsGJWg+LsiFlW/V13oGvEIJDH/gFEEmbhHxtbfLxWQ
         0lDkNXdJ4KxOnBdSvY03EGi8tvyQ/X8OSyJyiW/rSNsEDMK6vfQlphGY+Wm3L6R3hLxV
         AAko9Qu4cyM9wkVcZXDFz3yXFC3fZyYsmaEGbpSl7Mh3POiRMk3rKJfk4Yyul2mYk6sb
         SjnDWUVV9WuFP2MH0TW+dhy7OZSoPiYYlVBtJWaJ123jYcpfrazfucWPbOfEiwqtcMFq
         F9338IBqY9rzHvFgh6KiCYMcGX7a09BhL3WqWBSeuj6FzUQSW7b1+ba5vu2QZBNEbkpA
         MT+w==
X-Forwarded-Encrypted: i=1; AJvYcCX6xADTPw+foe6MA8jC0/aS6/Xe0bzqdkdJRo9+tEDe5++YTCbHrWOXKXBIMUUNcmQUN/grqAsu8Ilhbik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSO8l4lJU6Yku7ZmCNtFCyjzAIpkMSE9YiAylHckF5+w+1h7U
	lMR7mk79GaapCotD353quS50bCSPFt8MaNEJDXeOdJ0qrP7T5zA7Tj5v6DBftAg=
X-Google-Smtp-Source: AGHT+IHTpMcYmF9z2kltnsJqkihXDzYulmllfE5WCQAP4YEs16N79sFK7tcp+DcdzifQ+u5hSHcozA==
X-Received: by 2002:a17:90a:8a8c:b0:2e0:94da:bfd2 with SMTP id 98e67ed59e1d1-2e0b899cc3amr225520a91.8.1727366632896;
        Thu, 26 Sep 2024 09:03:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c33f8sm21149173.89.2024.09.26.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:03:52 -0700 (PDT)
Message-ID: <5d9c8052-e7ca-4819-bd0c-d7f88905c7a1@linuxfoundation.org>
Date: Thu, 26 Sep 2024 10:03:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] selftests/mm: hugetlb_fault_after_madv: use
 default hguetlb page size
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Mario Casquero <mcasquer@redhat.com>, Breno Leitao <leitao@debian.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240926152044.2205129-1-david@redhat.com>
 <20240926152044.2205129-2-david@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240926152044.2205129-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/24 09:20, David Hildenbrand wrote:
> We currently assume that the hugetlb page size is 2 MiB, which is
> why we mmap() a 2 MiB range.
> 
> Is the default hugetlb size is larger, mmap() will fail because the
> range is not suitable. If the default hugetlb size is smaller (e.g.,
> s390x), mmap() will fail because we would need more than one hugetlb
> page, but just asserted that we have exactly one.
> 
> So let's simply use the default hugetlb page size instead of hard-coded
> 2 MiB, so the test isn't unconditionally skipped on architectures like
> s390x.
> 
> Before this patch on s390x:
> $ ./hugetlb_fault_after_madv
> 	1..0 # SKIP Failed to allocated huge page
> 
> With this change on s390x:
> 	$ ./hugetlb_fault_after_madv
> 
> While at it, make "huge_ptr" static.
> 
> Reported-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   .../selftests/mm/hugetlb_fault_after_madv.c        | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> index 73b81c632366..ff3ba675278d 100644
> --- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> +++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> @@ -9,10 +9,10 @@
>   #include "vm_util.h"
>   #include "../kselftest.h"
>   
> -#define MMAP_SIZE (1 << 21)
>   #define INLOOP_ITER 100
>   
> -char *huge_ptr;
> +static char *huge_ptr;
> +static size_t huge_page_size;
>   
>   /* Touch the memory while it is being madvised() */
>   void *touch(void *unused)
> @@ -30,7 +30,7 @@ void *madv(void *unused)
>   	usleep(rand() % 10);
>   
>   	for (int i = 0; i < INLOOP_ITER; i++)
> -		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
> +		madvise(huge_ptr, huge_page_size, MADV_DONTNEED);

Magical effects of hard-coded values :)

Thank you for fixing this

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

