Return-Path: <linux-kernel+bounces-214897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E9E908BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EE8282145
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C8C193075;
	Fri, 14 Jun 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMbqWjvw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5E7E574
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368294; cv=none; b=SbOmBm62QT/hxTed1bk7w2WAkHIHvY2Mx3IMdrvrorw+Zmp84emOSPv3fpaiueL0LXncJTvO3zNOoZ0fx7XSF3k+KlDzztDvUS9CMNWNr6wuPw1sgU6iOCI5+BpChIK7gsvl9M+BlXEDlZT0IBQ+KHxywTV1XOPMaWbc/RHdpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368294; c=relaxed/simple;
	bh=1foHEJZ2AgWP/jXKAqpboSK8aKD0+BWLStyImLGSVoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPdM+aqyK/m8VmwhGBZRrFQEzb91YlVOhx4lgUpkWIOk41z+7RU4w88AlHmVXVyPil1A/fMjz1m2EPuTtJbLNbZpeP+m84u3TUy/vuvwWX+JSR3raWtIN2mti4n9498Ptc8uJnwalWLuEnqSlPEBlxHBZDFR6kjXxXxPPKbGOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMbqWjvw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718368291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ew/FZZEC4sTrez8tNLGwBrr3I/RGY3w5LpbK17nwm8g=;
	b=IMbqWjvwVwBZ76sfD39oK2O3yrddNOC6W1XNKvd/2C4T0oIS2fL+IPQ6Uh2rCpoUQfaC9A
	9Spl+YFCzOH2gRBKUCfFzyBs3vw+vBWb3nAPqslq0ZqQm/k5WobfGoa+gg8VYiiA6ri1fb
	+ou55lMJeIhXQ1avZHBGO/SJ5zkMycM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-QTKsW1KkMlyymeGDdAO97w-1; Fri, 14 Jun 2024 08:31:30 -0400
X-MC-Unique: QTKsW1KkMlyymeGDdAO97w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-422a0f21366so16360505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368289; x=1718973089;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ew/FZZEC4sTrez8tNLGwBrr3I/RGY3w5LpbK17nwm8g=;
        b=kg7Qgg7nacPIi2DJVsZjnh/NeVsNy7+cz65qzvOk0U6J2Gny9jEGtuWS2k5MLlZGAV
         WN75yDBt1xmX1G0u5JZXVzgUimUto3HQNqe35VeypM0YZDyWQRnxxbnWQd3XV9Hua6o0
         UCyZDapXLB84SMm30iJ7+kgwereVXUcw4b+kTasyrl4jwOesynsjNkIkux3fO+vLQ2V8
         tMxjFt4hbQZ+uEcIAcO79HuS3sni+VEmx+XIJgPSMt5AHA5XSDKg5pH78+K/aPDdYzX+
         IguBkrrGWlzHa5HkRb775h97h69RgQyfSCWDiY3Q+oNWIA+T6bFutd4a8oc6USlWLxnF
         6V4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0IbAOZ3ak8e1RVKtxR+wPz13hjEx/n0Qo9BLnEVbWvGM4cdapYLx2lADqidDJ3NV5l3Mm0z1yr6aMi3faah/TvLg5eAI7zYszZ03f
X-Gm-Message-State: AOJu0Yz3tpT8xhZxy/Jf26GWLRgIA+wDb7gN7sqZOm3Va/jya61g3lUU
	gg0pNnl7VAW3uQ4Ufn4Q7rmspLnWp0rc6/2khPyJH/FJFQ2Q0w4FStHIKq8UHVp7VhRe9feiytl
	iSBZQQtnVzcpDxY6Pp1c3fIB8LUAkGpisH+djVKctQ+GfuYcvsgRiwdZOlDJIDg==
X-Received: by 2002:a05:600c:3d8f:b0:422:5d3d:34cd with SMTP id 5b1f17b1804b1-42304828c67mr28631525e9.16.1718368289187;
        Fri, 14 Jun 2024 05:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEilsGkYX9QIjJ0txMGDNjVEpCbnBHQEM7cdmx8BxYa7HtZktEg/yA4D/RZXU7H8H0kuUE74Q==
X-Received: by 2002:a05:600c:3d8f:b0:422:5d3d:34cd with SMTP id 5b1f17b1804b1-42304828c67mr28631225e9.16.1718368288733;
        Fri, 14 Jun 2024 05:31:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a5b4sm59225685e9.41.2024.06.14.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:31:28 -0700 (PDT)
Message-ID: <56effc69-b7c6-4e89-8cd3-e344f673d750@redhat.com>
Date: Fri, 14 Jun 2024 14:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] selftests/mm: kvm, mdwe fixes to avoid requiring
 "make headers"
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-6-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614023009.221547-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 04:30, John Hubbard wrote:
> On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
> missing a few items that are found in prctl.h. Here is an excerpt of the
> build failures:
> 
> ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
> ...
> mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
> mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'
> 
> Fix these errors by adding the missing items to vm_util.h, and include
> vm_util.h from mdwe_test.c.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mdwe_test.c |  1 +
>   tools/testing/selftests/mm/vm_util.h   | 15 +++++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index 200bedcdc32e..cfe0b64d1567 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -15,6 +15,7 @@
>   #include <unistd.h>
>   
>   #include "../kselftest_harness.h"
> +#include "vm_util.h"
>   
>   #ifndef __aarch64__
>   # define PROT_BTI	0
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 9007c420d52c..99cbb7c0ea9d 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -61,3 +61,18 @@ unsigned long get_free_hugepages(void);
>   
>   #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
>   #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> +
> +#ifndef PR_SET_MEMORY_MERGE
> +#define PR_SET_MEMORY_MERGE		67
> +#endif
> +
> +#ifndef PR_GET_MEMORY_MERGE
> +#define PR_GET_MEMORY_MERGE		68
> +#endif
> +
> +#ifndef PR_SET_MDWE
> +#define PR_SET_MDWE			65
> +#define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
> +#define PR_MDWE_NO_INHERIT		(1UL << 1)
> +#define PR_GET_MDWE			66
> +#endif

What's the reason we don't target "linux/prctl.h" here? :)

-- 
Cheers,

David / dhildenb


