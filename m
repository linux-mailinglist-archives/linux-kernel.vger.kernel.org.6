Return-Path: <linux-kernel+bounces-281300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310AF94D53D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D05282477
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB63B298;
	Fri,  9 Aug 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d13KmiUe"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9A3A8D0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223586; cv=none; b=cjkwJfH2HgFDtxJw4Q0c0ZTGONOiylbJQHf8NdJvVOmdvilH6WJscXI6CeSL+NbwcSB3lKUGdR1FUODkzHqrT0wC/KjaLi0nMF9Znf1a9jznTkIxCek4XYv259Ak+4KkMlHyiLEUaKj7YM4OMAmwdIKuyOMjOTFDIVE2tGrFbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223586; c=relaxed/simple;
	bh=3TqZz5N6WxSgno/+bh9ePYPrgBPJQ6XW36Y+21kuaVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yrvv0hm8eVURkVnuhAxncspjZUSCFgC24ewRelbn/UANQPfesFmdjoVsB7CqjcNVqmSk1cXyG7n1pnM2JmtaP2DkRaEJwAoibWO/XybKOChbj1TuCtPHOwx/sa6DUpQ1o+xsqWcWZManxqZiKiW7b5J41lcQ8M8LuZahnV4MKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d13KmiUe; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fdcd41e4cso7353539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723223584; x=1723828384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Axmz1138R8c0Rv8tx79G9j2E5WenurXLDxEEM4p5OU=;
        b=d13KmiUevQdYeNXNLDZrhoaqKuaf6CQdvOh+QNi1h2O+dWnCTJ/N9rQ9HE9frt4D6i
         bzq6ucNWhEpAcAbjfMZ7ypRQvDVoBZKAv/9CVOoa7CXLSufYOkmEOoyXr4t1UtP/c2BR
         3Qyec2+vafMQYW3z3wSV1Cex7zsjKfXCvRLZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223584; x=1723828384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Axmz1138R8c0Rv8tx79G9j2E5WenurXLDxEEM4p5OU=;
        b=cyf1Pgugf16YZyRHqiLdgYtjK+QK21FNfbMlOr9EpnSaaYXplJ1HFWfz0UdAZHUNKD
         OoAD3nSrjI7QQ4nnhN0WKcI/XZRps4+cZop6c6ArgU5hMTb0TVbAQWArRfaGyoWgUrKv
         LPMjh4Yre1HiSNfPWaTVetAEN6T87h/muetR3dV17Vq++5CdhLOHm13C8TSnLhZZ3zBq
         3kRp3kXCAtfyXV5i1snSFbHmh9R/Ar/fr/vgp0FlDN3KJSz9LZXGJe9sykgM/4Q6XhXi
         Wtui+79X/iB7ABCuXnHjcht3gqhliiQsphWLox+TtFUs/Oyn567MSpXYVOEVBPIry6rU
         Bknw==
X-Forwarded-Encrypted: i=1; AJvYcCVxmkG8LbV5HK76j9rsd+IKYbd0edNkSxLJ5jZuK4q62kl8UWMRu/lR/agOMLJqXb21/vNhFtLgAayxyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGgocjazrW21xhtKEX8mOxnW5tB0WoMKVtujtpIdcmewoP+9U
	jszzm6nMDSh3hWmYg/y2cBUXQ+xd7hk2R9ksnpjhGfkTk0Ww98fRMgxpJOpwXUQ=
X-Google-Smtp-Source: AGHT+IF+fCct+358RjirWTjwBGkiFJaSbrNLE4ozb3RU2AEnZIooYLpIPxpsAMP9++rs2g3JkG8KUQ==
X-Received: by 2002:a05:6602:2193:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-8225ece0b3dmr147119639f.1.1723223584073;
        Fri, 09 Aug 2024 10:13:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76a5d227sm10391173.162.2024.08.09.10.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:13:03 -0700 (PDT)
Message-ID: <e3bf3d2b-eb19-4678-916e-7a7f572b2936@linuxfoundation.org>
Date: Fri, 9 Aug 2024 11:13:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: Do not fail test for a single migration
 failure
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org,
 david@redhat.com, willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-3-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809103129.365029-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 04:31, Dev Jain wrote:
> Do not fail the test for just a single instance of migration failure,
> since migration is a best-effort service.

The cover letter says:

"Given that migration is a best-effort service, it is wrong to fail the
test for just a single failure; hence, fail the test after 100 consecutive
failures (where 100 is still a subjective choice)."

You do want to mention the above here.

The reason being, I would like to know what this does to the run-time of
this test if migration fails and retried 100 times.

> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Tested-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/migration.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 6908569ef406..64bcbb7151cf 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -15,10 +15,10 @@
>   #include <signal.h>
>   #include <time.h>
>   
> -#define TWOMEG (2<<20)
> -#define RUNTIME (20)
> -
> -#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
> +#define TWOMEG		(2<<20)
> +#define RUNTIME		(20)
> +#define MAX_RETRIES	100
> +#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))
>   
>   FIXTURE(migration)
>   {
> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>   	int ret, tmp;
>   	int status = 0;
>   	struct timespec ts1, ts2;
> +	int failures = 0;
>   
>   	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>   		return -1;
> @@ -79,13 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>   		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>   				MPOL_MF_MOVE_ALL);
>   		if (ret) {
> -			if (ret > 0)
> +			if (ret > 0) {
> +				/* Migration is best effort; try again */
> +				if (++failures < MAX_RETRIES)
> +					continue;
>   				printf("Didn't migrate %d pages\n", ret);
> +			}
>   			else
>   				perror("Couldn't migrate pages");
>   			return -2;
>   		}
> -
> +		failures = 0;
>   		tmp = n2;
>   		n2 = n1;
>   		n1 = tmp;

thanks,
-- Shuah

