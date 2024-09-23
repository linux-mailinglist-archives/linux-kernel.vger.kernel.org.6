Return-Path: <linux-kernel+bounces-336070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C497EEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CD0281621
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDF47F4A;
	Mon, 23 Sep 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRAown0/"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214946BA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107296; cv=none; b=WczLUvifQxf7bmPPskV/7k8w92TiGmYij+9QVAVJ7oj0OQBH79BYdF8Wl8nJKJ9ht+1I6OqPrQ/JsP4IQA9jmYfWQmGIqtxPpDlhCt3LL+Ws2JTjN1/V5YcVveRSZnouAjpkzpKjOA6Nk8tt16UQPiehyEm0TR8nWrU4DuTeRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107296; c=relaxed/simple;
	bh=yspVqEEveq6ZyrJvWKmdhNPB1+L73B7yIVlcbXkjREk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5TXu40l+2CVh316hEK8c1NRy12ityyNhmGJOaH+K5DCeHP/91wkyRH4jn384RD4ynzRqZBMmqrHsMD8VGvCBm++lfwB+EenA4gSuHpp9zxq9XDnqIKwQ3ym9Ol8bO1kaIMwM7x+HF47MZKWnpQiYlr2rVzGAQZx2RiuaixVEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRAown0/; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8323b555a68so5472139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727107294; x=1727712094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEml613ScxlbxV2rYvuLeC1V8WRj6hDYMm4pZjj0Dbk=;
        b=cRAown0/DK4sI6Izpm2MnU5EVHW6aSyonp/kPVwmARNCUjwP7/WJ29mROR0Yuqw/3a
         1CEupIiUt8O1a3VV67WncL0tLPvFPVS9+ku8aDRxPGs39W6/s9VAX1iFnGUu6shm92UP
         ZHejrxISjz4BMYeNvmI7Gu8RJq+QOw4lO0nNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107294; x=1727712094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEml613ScxlbxV2rYvuLeC1V8WRj6hDYMm4pZjj0Dbk=;
        b=X/4mHNCKrEIph6OD1RfYrVFpDXPoqAksBl2E1FfzxMREj65nK31GogePPGuORQasLy
         LJARbQo7UkvdQM21OEvjy1NUGZoKbgZrpqTUhX7QwY3RQkM7qfSqJj7kd8PyBzEiBL5o
         vNDuVcnfsbBPvksAZsFerMLSF3wPGELt7v549Hg3MINOejh4o4OUptNOZMurG05x9Uir
         dzaewx6UsiE8fp72GbauBdq47hjCF6apvGxWVKbPtw251gAYwH+8LhTnrY17NlgL/BWb
         7CErWl96lcccPvIsgZtjH+6kiLtRbW0ZkW1092mGiS3gcy89azvplCKwDZhNBOXmX6TS
         FNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZWTo7QwTjFiRPeiQwPKm2tr2vf++mIqLBKSd/hsPEq8xYUzV745Fj9XZysNhNuE3eti/euSN1USRr3cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL205mB4BnzNmQQGlqpS2xsGB8o6hstWbionZwps816tMnvKP8
	ZjtMBRQS9NIzqpVmjRa0o3yMshMDJ1MjhL21Za2JHSA6Be2zL778QWQ9Cx/Yd8Q=
X-Google-Smtp-Source: AGHT+IH1YGCGJJ3r++ctoT2ootUH7ze8FehY9Z9KUJuVPkNr2J3rM+XTA+PCfIdF8RFkh6IHB4QBAg==
X-Received: by 2002:a05:6602:6d08:b0:82c:ec62:6602 with SMTP id ca18e2360f4ac-8320b328ce5mr990358739f.12.1727107294259;
        Mon, 23 Sep 2024 09:01:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492b9676sm562541739f.33.2024.09.23.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:01:33 -0700 (PDT)
Message-ID: <92f63189-851c-44d1-951e-6a6c39eb223f@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:01:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 23:38, Muhammad Usama Anjum wrote:
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
> __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
> __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that:
> x86	374
> x86_64	323
> 
> The value of __NR_userfaultfd was changed to 282 when
> asm-generic/unistd.h was included. It makes the test to fail every time
> as the correct number of this syscall on x86_64 is 323. Fix the header
> to asm/unistd.h.
> 
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

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

