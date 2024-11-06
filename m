Return-Path: <linux-kernel+bounces-398127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239B9BE5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DCE1C22F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3881DED76;
	Wed,  6 Nov 2024 11:44:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723131D619E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893479; cv=none; b=EMCsU79I500N9y6YOi6GdtC0Gd7RwHgh7H45lHoyFvAHYADgZkQJ9ZczVyzY35uzqMsuBYnODP7jmvJE8EiGdVwTwheBYi6b2e0pdH6hSnymucBxTPfSlkdwnVk30sVYU0stUeqYjFtfh5hVicUf7Zrm8n5mVmUxBwNI+Ze1jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893479; c=relaxed/simple;
	bh=L/vsu6Br5m0izzUqaRo2886jDIY90r/38TvrRRq69Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VScx27aMp65BWr3/A+4GVguFZNh5IDiLixOCxxm+HP8Ou0ck/vDUSQcBYYCqQPnmf7jMary4JbIAEinxGEaPjxg2rJXl6yZxdNCBqhgsxIE0VxLWeJvnmdVQLMeyyeHZVaUZZjHL/eCmPhC/HjdHNG7RhOWBk4KA8QYvRXx8r+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E0A1063;
	Wed,  6 Nov 2024 03:45:06 -0800 (PST)
Received: from [10.57.88.115] (unknown [10.57.88.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9C13F6A8;
	Wed,  6 Nov 2024 03:44:35 -0800 (PST)
Message-ID: <3e26ec9a-4dc0-42e7-a383-2c1bd0a08412@arm.com>
Date: Wed, 6 Nov 2024 11:44:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-GB
To: Dave Kleikamp <dave.kleikamp@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/11/2024 20:16, Dave Kleikamp wrote:
> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
> is no longer optimized out with a constant size, so a build bug may
> occur on a path that won't be reached.
> 
> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
> 
> Ryan,
> 
> Please consider incorporating this fix or something similar into your
> mm patch in the boot-time pages size patches.
> 
>  include/linux/slab.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9848296ca6ba..a4c7507ab8ec 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t
> size,
>      if (size <= 1024 * 1024) return 20;
>      if (size <=  2 * 1024 * 1024) return 21;
>  
> -    if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
> +    if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&

Thanks for the patch! I think this may be better as:

       if (PAGE_SHIFT_MIN == PAGE_SHIFT_MAX &&

Since that is independent of the architecture. Your approach wouldn't work if
another arch wanted to enable boot time page size, or if arm64 dropped the
Kconfig because it decided only boot time page size will be supported in future.

Thanks,
Ryan

> +        !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>          BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>      else
>          BUG();


