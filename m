Return-Path: <linux-kernel+bounces-380527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7929AF04E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2931F22EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90855216A0B;
	Thu, 24 Oct 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRORcC1Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F4216A0D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796480; cv=none; b=BD0TW0eYCqCTjNjvGYC3rPOniDDgJ72oBDXQCLpWIJx6jSpRRVdWbLIsYHSzC4Off6IJdYvRDulnzjwsKB4kIL+wHarfKLnCLJFGbFujGnoLv3yzS2Qlw5gsnkuHwtoR5QyHrov/p+cheTwnn1l/U+D2WjMkwc2JzIrYqrXc1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796480; c=relaxed/simple;
	bh=Bery8U7y6ZZU1b1l+QJe45aNPvdl9AatLCBxxA7kl3Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e2PMwXCjXZfbD66xZiKYes+xdeAQmzaYTV0CCLFv11NVoVPqfJv2sqI/0vVLLztgF2IRB+gOoTNSVyjtlCL8/9WhJZYb17e2AcJUtbpxjmDIc01nCkoLoT2PmhcNfzvwXiBZQh1FNnSaStRK56zlOmeWADKRqB8J76k7yst3dRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRORcC1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729796477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfqXLVp70xawKXgQpkZfJdG0EuWxNhIZycIE926U/Xo=;
	b=KRORcC1YieQbcuSpeoCF34oGt7LO4R3xR3tJsOYRg8k3EFL1sb+3Mf7RKWI78eqowS+xL5
	YrFNwW6iXConnuTt+k0zqEs741/J4/Dqe2zbXAQtOoj64K5Q/EZeDqbncKp4UeCmQU06Yz
	GmJdholukR2EAOPWSQfkobVvNRQsuQw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-r-VnWwG6M9a3B2nGrtSqYw-1; Thu, 24 Oct 2024 15:01:15 -0400
X-MC-Unique: r-VnWwG6M9a3B2nGrtSqYw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460b35f820fso15702161cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796475; x=1730401275;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfqXLVp70xawKXgQpkZfJdG0EuWxNhIZycIE926U/Xo=;
        b=SqOs5kb5Z5oyGF8g3uC0wwA762kOglMoIRqCcHkRCPZrEMGXwSwFF6CbLlCjRPReQj
         VSHYcTo1ISCsfmP0x/col27rcwp0uCRm3dSUGH3dSUMRwo1NvZ+cfqP7wzatdLTqZFw+
         1bCykTq5h5RTrJTauLXT6YmVv2VDVT8EqLRdG1YNh+lLu5/Kf6clr3KgfwWfzushpoLx
         Zsvb1DugslSXM3blrJZBjfHU66aKULLJWgfZ7Q53XfX7KB5yxf1quax7smQBJ1vfVCjw
         qLSr8ahxeIXLC8iT7kJ94yWDgy7J59tb51emc36hEfLV2lNqpzMY53jtR1Gn2B12laXf
         bYJw==
X-Gm-Message-State: AOJu0YwoQHY/UQPDLC0/KMJc0zuwc9LFU9+IpakisQsP6I0YMj0jlBSt
	P9c59cL85eUumpxNXWmWZLV1XUWSIxhS4G/+I4XY3zfSTj6MFHekzACmFyG0zVRNjfOcE01qIy5
	knnND3mnnmxxHxj0nfzGq9lyeCXowLeIimWpbEHyffSQx3DAcenniNiB1qy6buw==
X-Received: by 2002:a05:622a:1b88:b0:461:2146:3a59 with SMTP id d75a77b69052e-461258c8b35mr36591241cf.11.1729796474611;
        Thu, 24 Oct 2024 12:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZv3fnDB6Xwxcthc8m7SpOeN8Ztx1w4np1+KxQo/PZA9r6x64gIIMYabFNcXIsyJiAjuRmog==
X-Received: by 2002:a05:622a:1b88:b0:461:2146:3a59 with SMTP id d75a77b69052e-461258c8b35mr36590801cf.11.1729796474075;
        Thu, 24 Oct 2024 12:01:14 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3ffd8sm54332881cf.8.2024.10.24.12.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 12:01:13 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b0cae30d-03d9-40cd-aba6-88ce9bd4d906@redhat.com>
Date: Thu, 24 Oct 2024 15:01:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS
 calculation
To: Carlos Llamas <cmllamas@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Huang Ying <ying.huang@intel.com>, "J. R. Okajima" <hooanon05g@gmail.com>
References: <20241024183631.643450-1-cmllamas@google.com>
 <20241024183631.643450-4-cmllamas@google.com>
Content-Language: en-US
In-Reply-To: <20241024183631.643450-4-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 2:36 PM, Carlos Llamas wrote:
> Define a macro AVG_LOCKDEP_CHAIN_DEPTH to document the magic number '5'
> used in the calculation of MAX_LOCKDEP_CHAIN_HLOCKS. The number
> represents the estimated average depth (number of locks held) of a lock
> chain. The calculation of MAX_LOCKDEP_CHAIN_HLOCKS was first added in
> commit 443cd507ce7f ("lockdep: add lock_class information to lock_chain
> and output it").
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: J. R. Okajima <hooanon05g@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v3: collect tags
> v2: switched the comment for a macro as suggested by Waiman Long.
>
>   kernel/locking/lockdep_internals.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index bbe9000260d0..20f9ef58d3d0 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>   
>   #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
>   
> -#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
> +#define AVG_LOCKDEP_CHAIN_DEPTH		5
> +#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS * AVG_LOCKDEP_CHAIN_DEPTH)
>   
>   extern struct lock_chain lock_chains[];
>   
Acked-by: Waiman Long <longman@redhat.com>


