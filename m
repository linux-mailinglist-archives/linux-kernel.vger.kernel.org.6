Return-Path: <linux-kernel+bounces-293040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86392957896
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A5F1F22613
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF511DF68F;
	Mon, 19 Aug 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUld07nM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6B3C6BA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109786; cv=none; b=btTiv+u4kxDn/16TGLgEM+bdX5TQTbITv/yUZpDdVmvZOZxrR+IVu+9wr71GGRUzuSqUfp45ruLPaasC3Z5hqy+KqFNG84seDfupMsNOhVW3ZpTY8cvNDTYetv/EsREQky+bgzsFMuYvYjciYaJT83SsW3R5sZbDLISn0YBJNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109786; c=relaxed/simple;
	bh=i2DLyl8buGbPkl6JZw7wHlrUnacC63KEMxQxiL8QmEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI4Uicm9AVVOXaxUYprjCl5uvF1pwM5VpsmDOsDhBYjY/KYZYbecVvW5tLTWT1hcoqFSD5FLwNtT2ny3El53hi0Q7uRwbo1+m/LJr7pkxYHNRZujA0k9yb8IqVrze4bZloFWrBK2bgN2kAgTy2Lk8RaKq04cyvU6leppDAjS7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUld07nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B497FC32782;
	Mon, 19 Aug 2024 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724109785;
	bh=i2DLyl8buGbPkl6JZw7wHlrUnacC63KEMxQxiL8QmEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PUld07nM5iA3DTKK77flqWCxrG3bAA+w+xZiRSqpHw4J8I9hiO2XZPlT9Xu6MBXhV
	 iDc8xKJnuWcOCvMJEPZaYAOkpbq2gCclZ+9DCeXXyLZIbidVgaJsRGhXgI+hIFbny+
	 0AvhIe+YJdVop/Gbi7VtCQ8JLC09fswU2iYENNWiWwWLd7Fz9bgRUtip7cpzO1Qhze
	 s9EdeMIOwDdQr38z1wBT9lPfF1bGaIR/OZyhkpuTcQM8yeMrn8dStZK8uXZDcSbhNX
	 5itq+8Z23pOOpPWy5hsIuCX5k1nRI9l8t0EIZ6s4qJXkpQKZrpwDmteipdIof0/na7
	 srugzdVCqUsDA==
Message-ID: <65fd31b2-51c1-458c-a3fa-fadbde5039fb@kernel.org>
Date: Tue, 20 Aug 2024 01:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
To: akpm@linux-foundation.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240812223707.32049-1-dakr@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20240812223707.32049-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 12:34 AM, Danilo Krummrich wrote:

Gentle reminder on this one.

> As long as krealloc() is called with __GFP_ZERO consistently, starting
> with the initial memory allocation, __GFP_ZERO should be fully honored.
> 
> However, if for an existing allocation krealloc() is called with a
> decreased size, it is not ensured that the spare portion the allocation
> is zeroed. Thus, if krealloc() is subsequently called with a larger size
> again, __GFP_ZERO can't be fully honored, since we don't know the
> previous size, but only the bucket size.
> 
> Example:
> 
> 	buf = kzalloc(64, GFP_KERNEL);
> 	memset(buf, 0xff, 64);
> 
> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> 
> 	/* After this call the last 16 bytes are still 0xff. */
> 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);
> 
> Fix this, by explicitly setting spare memory to zero, when shrinking an
> allocation with __GFP_ZERO flag set or init_on_alloc enabled.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I think I forgot to add:

Cc: stable@vger.kernel.org

Not sure if there is a useful commit for "Fixes" though. AFAICT, this has been 
broken since forever.

> ---
>   mm/slab_common.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b8..cff602cedf8e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>   
>   	/* If the object still fits, repoison it precisely. */
>   	if (ks >= new_size) {
> +		/* Zero out spare memory. */
> +		if (want_init_on_alloc(flags)) {
> +			kasan_disable_current();
> +			memset((void *)p + new_size, 0, ks - new_size);
> +			kasan_enable_current();
> +		}
> +
>   		p = kasan_krealloc((void *)p, new_size, flags);
>   		return (void *)p;
>   	}
> 
> base-commit: b8dbbb7fe1db26c450a9d2c3302013154b3431df

