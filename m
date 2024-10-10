Return-Path: <linux-kernel+bounces-360119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D69994AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7681A1C22DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3491D1E47A3;
	Thu, 10 Oct 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G1tNDY1r"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CB1BDA83
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597081; cv=none; b=njVgrrlRiC/0+6W4epgCNbU5bsIlMw+2+jd6Z/YtubTqaGV38hwmYBwvVyJIhwqHMsZj4UqCdSe2kRVwhyCttE//HJZKsxtPcIoLd6v08lrQLuT799hXfVBsn3Kzy7qTWD/RY2vDT6E4gVq9gF9NdubLaivacKQC5okaSHJEXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597081; c=relaxed/simple;
	bh=PwwXkCJnspDRZTjE+IzvY3hxePY5F0YKt/vsvQ06YnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDjehFsdduFSo6lc9XZi25v7zGVrlR42VNlkPKvGl5JDV+gIp/eh1yIe9fQAmXq6p9QOtr4zpjsOCp1s5fLGKsThycmaIpkJz1bxrhonpI+D1svDPe/Gp3Y7v2YdtoUAnWZAwykxh1PP86tTmFS2Cm0JQy+/aYh/rlRU9so9xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G1tNDY1r; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8378db14280so4891439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728597078; x=1729201878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uh29BSYlRHYdLt2ocxo/fMoIUs4a5eCJ/P6zRKs85Io=;
        b=G1tNDY1rh8f9Dmv0bmfFaB0A+k8V3Rl1F54XTBKguT0QVbqJuLjMlajyj1KKj5ahHZ
         vSc9+W5InJ6wSNjoCk1yvin/tAn6XT1UbLAFfsRPKu4hS/BNJXp1vt0eo8cNyu1bBhsV
         g98BiZxulhQCd4hst14vSY0Po29G9rJClaZ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597078; x=1729201878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh29BSYlRHYdLt2ocxo/fMoIUs4a5eCJ/P6zRKs85Io=;
        b=TdiQgM+Gu2ODazasvhXpMtr90cgGpestt3Fu45cMVeQ8p33v4Jvtrr2/vKxV8s8Z5+
         2By+lriG80Hr53gh1O6nssN40nX5YqVOMGIcidoSzWONf7D7NlUKAUkSy2zYWJznwp3Q
         aaI9mIQo0bZBNpP4yC1GVQaS384QL+mKKy45PPDWO9MYPgbCn+UMklXN9dNlqRKMHXh4
         9WhN6e2I1WLVyXHbDXNdwMNqkoMMjpIm1fzU9uWxu083U+o/TEfmJL31njFO+KkfBnnw
         klg+mouhQzKIQq8ntIH6y4GagxaV7QeVmPXX/1jgkuu0qp6eAMsvnUWsFcOcNYzk0TxH
         3k6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqDo7L4HfOCpBX1uYOTKdioJsTKEtM0DVaEjUgxohCP0ody5PMoQsRCGm+HeEiWaIvn6pBkUtNr0SZ7Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsW2kc+1sgnM5kVuIh2GIUREuudvrHV8GFSvyXCRH0GC4sH97
	bvqoPwxkjx0W7B+O9AmYaMK+KWcN/G+cmoUBnsjbqZKdKXofB6oIYSCE75nzkTONW8NCPV/tmUf
	+
X-Google-Smtp-Source: AGHT+IGiDgwEJY1ZMq6egYLmaOYSKlkRouWLFZDSNPsrPR3YOwgzGFrvb5pu1BOry26y2sZLkG8dPA==
X-Received: by 2002:a92:c544:0:b0:3a0:4e2b:9ab9 with SMTP id e9e14a558f8ab-3a3b5f7a9b9mr3132295ab.5.1728597078374;
        Thu, 10 Oct 2024 14:51:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdae1a7sm4331785ab.1.2024.10.10.14.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:51:17 -0700 (PDT)
Message-ID: <2d048360-64b8-4af8-a5a5-3b69c5d3247d@linuxfoundation.org>
Date: Thu, 10 Oct 2024 15:51:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mm/execmem: Remove logically deadcode in execmem.c
To: "Everest K.C." <everestkc@everestkc.com.np>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241010181102.5522-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010181102.5522-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 12:10, Everest K.C. wrote:
> NULL check of variable `area` within the `mas_for_each` loop is
> unnecessary, as the varialbe `area` can never be NULL. So, the
> `continue` statement inside the if block is never reached.
> 
> Remove the if block that performs the NULL check.
> 
> This was reported by Coverity Scan:
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600362
> 
> Fixes: d44c3485820e ("execmem: add support for cache of large ROX pages")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   mm/execmem.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 9c6ff9687860..97706d8ed720 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -75,9 +75,6 @@ static void execmem_cache_clean(struct work_struct *work)
>   	mas_for_each(&mas, area, ULONG_MAX) {
>   		size_t size;
>   
> -		if (!area)
> -			continue;
> -

This more of a question than comment:
mas_for_each() says:
Note: may return the zero entry.

Does that mean mas_range_len() can be zero? Does that
need to be handled?


>   		size = mas_range_len(&mas);
>   
>   		if (IS_ALIGNED(size, PMD_SIZE) &&


thanks,
-- Shuah

