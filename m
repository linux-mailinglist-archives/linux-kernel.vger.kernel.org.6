Return-Path: <linux-kernel+bounces-326883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70772976E10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325AE2817D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE11BB6BE;
	Thu, 12 Sep 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmQvjpqN"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058A1B12F6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155861; cv=none; b=NEDc7LsaURPQD3ONH5xNzM7bGwwU07/26cp8XNx8/diY3D9PMjmLj/nh+yaXpiDm8xblVvn3PZ+qiC1i5u6bw3q6/g9FDytv1m+X7zTcuRq+S+8TbVTPX8y4Sr8Jw4GWhn9qBCMk1IfjitNiZGHE8ObJivuvq15CFol+oFQKtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155861; c=relaxed/simple;
	bh=BIjqRB8ExX3XEMpofICKrApiJn7b9V8WKKgZqm8th1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gInv8Rox+iHyHfo7bC270LDiw9N1jX6S5bwzkg3J5NQX0lSvFEboP1uYWebn0OsoHf+sk49Asf2n+rkfVcUj7lhLG9SwjSMb7GZa1A08ZBFxhL7mVIVqCjuzpwnrKt47fzyg3DSVd+sEEiNREnzvBF/YK3RYydZL3ZtiOsxJyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmQvjpqN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82a151a65b8so54726039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726155859; x=1726760659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xzJmJZir7SNhkzAEWBQK9iRI0VrPUIlmQ6Tc4M2oLs=;
        b=AmQvjpqNmPR7LdgktraFhKwjMaKI7xK/bIYoZcJEPdP+pHhaBFaCQGc3LusAHeOVgg
         fEsVP11BOjWDg24O4oqgG/sp9hTbhjDsPbXvwCOKPBMh41M+wqQWBTH3V6lfq4w0knNA
         RfOM/VhcC2XbViSKixDvycIvxVT/6Y7X/49aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155859; x=1726760659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xzJmJZir7SNhkzAEWBQK9iRI0VrPUIlmQ6Tc4M2oLs=;
        b=PVdT9xtYIn+pyHbAkUVF5F2HhBblneG6EJLpsgbz+XAnKUf1nIUN1HKch1EFjDVqVK
         LMVWKgPcBERfrtvCugZXD8mI6VNFE61Tg/efDTsBIZLcL+wgeAADdVJGmFAYm6azeajo
         sh0scsIBHaE4XzgdJsgyAkzRW22vZ/sT1qdRvxPvf+VPrRKjPtS/n39XoEmIZMjhNYD0
         /FL1lvmKCJtbQLXCp2hShM+NFeMPzfN6sS/wcG1bYD386UY0D/AWqWjiawRrnEpcdtG2
         YlShMVmUFxH/C5jT1lbdv0NfpK0nfwuuvKMucylXK7ySDZ4CnnpQ4cA93UB1IZ/IUzx4
         dvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlsce5Aq/gPWK+5eoHYLgXIWje+1rla2Zd2pExQXaNXWr89csN2z2UdfvfOuLlWfNy32Op6Q/Q9DOHzZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIxmpe6SsmaNmP4IbL34nJ/yx3wc+/eUR8RabV/WQZJFPrEpK
	sKCnSNsjHtAub69XJyacli8AeFoMxMX+wPZjjAM3H57neDMUOO5JHxIg6Y+9bqs=
X-Google-Smtp-Source: AGHT+IG6esSlE2W6kArjZrA67ckcdnIzOt6LyndGjqyPFo8xbm61PKfZ5ht422I2fxHXzRSn5KH60g==
X-Received: by 2002:a05:6602:2d93:b0:82c:bdec:1c0e with SMTP id ca18e2360f4ac-82d1f8b3d81mr497735339f.2.1726155858844;
        Thu, 12 Sep 2024 08:44:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8ed815sm654814173.142.2024.09.12.08.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:44:18 -0700 (PDT)
Message-ID: <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
Date: Thu, 12 Sep 2024 09:44:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912103151.1520254-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 04:31, Muhammad Usama Anjum wrote:
> The value of __NR_userfaultfd was changed to 282 when
> asm-generic/unistd.h was included. It makes the test to fail every time
> as the correct number of this syscall on x86_64 is 323. Fix the header
> to asm/unistd.h.
> 

"please elaborate every time" - I just built on my x86_64 and built
just fine. I am not saying this isn't a problem, it is good to
understand why and how it is failing before making the change.

> Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index fc90af2a97b80..bcc73b4e805c6 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -15,7 +15,7 @@
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <math.h>
> -#include <asm-generic/unistd.h>
> +#include <asm/unistd.h>
>   #include <pthread.h>
>   #include <sys/resource.h>
>   #include <assert.h>

Also please generate a series with these two patches with cover-letter.

thanks,
-- Shuah

