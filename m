Return-Path: <linux-kernel+bounces-281305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1C94D553
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89132282BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF684D8AD;
	Fri,  9 Aug 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNzLhwPm"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D23219F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224053; cv=none; b=Z/eUDE4JSLIlTYhKrQ23XFlB6F1A/m2CGk+7REBu46orhRtYC98v5lx3R8bS0j1yRoQMwMEnOBrWEOz1QGsROxyUGUS4SsPZI1d28FtmjScgbWV+iNayeyFnuSjGrTl/VBu3iWSntcI0lOExktHX6vlaAAvOrVoqrDkMH4Uy/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224053; c=relaxed/simple;
	bh=VX0GHmStDkrYMdFhonCa5iBMpED55dhUQufG4AGVFbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0v+Kk12c15HxxBnJTs2ofTahfOo1dumIHatt7ow7pErTmaWMDazdF3bscDenKcYGtvOSbFDLcUeD4lwj/MkV0VsPmX+b2fbsl3B0FkzHO0KSzZNqXEkpFXcw4I8l7/O5LTO8zMuSL4IEkUnabFgJ/8VpOXnzny2iLfkGZXOYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNzLhwPm; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8223c72bfcfso8765739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723224050; x=1723828850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0VlmBrSrKPI0nvLOBL3lacDzUDCnPoKiOWhQVarU+s=;
        b=UNzLhwPmbH71csQ4hTt2BRT2yjrbaD2HoXPdX911ai05lPTjOpkIiex212lLVMRTtv
         9XrODhQfbY1qETG1anDW5GVgQdNcpDliw465t8D1+n3qmmHHGdC8foXVLmxA3dR6/VtI
         4EWsDLe6OSlbYFvWXASZOuUDqL912ab9ce9nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224050; x=1723828850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0VlmBrSrKPI0nvLOBL3lacDzUDCnPoKiOWhQVarU+s=;
        b=LDdFNDxTaHZrN9cFbs/IzifijVlOHMQC1zBfGQ5LvW8+moxWoelK+XudvVtT5Cd0jy
         mEPXa3HHELwD05ITBQXOfphlcwv4H4ONpLhPi5zKFTGbKYfyRFaCM+ZAEaz/3CzJVyu2
         G5m6ETbU2Zeov0IZ4+9vkCNRYLMmVw/aTq35Q5QR4y5/z4d04NqlxFZ/MBAdKhma1exP
         BkfJ6/8V7srjsn4UY8bFfbGnYK8XjWAt0kSZ2mpd39Hz87S/oanhqBKxAHqujnECmDhg
         RkF6sixdCCiFwA6pSaEgf5A+VE4bT+0+1vJJBR+io8mAb/bAt72dBITaocZZ3ksgJ+g2
         RoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdodD46qMt6Fx2AhQjuOP6TVGZGkJesYbAhWApNbnZK8xej9b2fhRFS4DZ7NQkL+HojEIxlv2EY5EcD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5udixk38HMIft6Ktzuwk9/fb5sj42iiy1ApMcsqyDdfPEXfH
	cRGjITeF2xmjqvtTpzJMtgeXlS9ymfQtY+e0nK5HvumR6DYRXXSgF1a3SncIeEQ=
X-Google-Smtp-Source: AGHT+IFCIxawOy6BLCebkOf6m3SU/t1bf8oP/2bn7t0rnS01Eibjkom6BbLknNPEfkJ4Vfow8JDQhw==
X-Received: by 2002:a5d:97ce:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-8225ecc63d8mr174936339f.0.1723224049926;
        Fri, 09 Aug 2024 10:20:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769102e2sm19814173.10.2024.08.09.10.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:20:49 -0700 (PDT)
Message-ID: <4c709253-50de-45ee-9cbf-8bed65eff857@linuxfoundation.org>
Date: Fri, 9 Aug 2024 11:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: compaction_test: Fix off by one in
 check_compaction()
To: Dan Carpenter <dan.carpenter@linaro.org>, Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 06:32, Dan Carpenter wrote:
> The "initial_nr_hugepages" variable is unsigned long so it takes up to
> 20 characters to print, plus 1 more character for the NUL terminator.
> Unfortunately, this buffer is not quite large enough for the terminator
> to fit.  Also use snprintf() for a belt and suspenders approach.
> 
> Fixes: fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   tools/testing/selftests/mm/compaction_test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index e140558e6f53..2c3a0eb6b22d 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -89,9 +89,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
>   	int fd, ret = -1;
>   	int compaction_index = 0;
>   	char nr_hugepages[20] = {0};
> -	char init_nr_hugepages[20] = {0};
> +	char init_nr_hugepages[24] = {0};

Can we exceed this limit too? Can you make this a define?

>   
> -	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
> +	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
> +		 "%lu", initial_nr_hugepages);
>   
>   	/* We want to test with 80% of available memory. Else, OOM killer comes
>   	   in to play */

With that change:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

