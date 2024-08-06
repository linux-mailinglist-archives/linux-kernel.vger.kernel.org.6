Return-Path: <linux-kernel+bounces-275543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D952948706
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37D91F2374B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF63A947;
	Tue,  6 Aug 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFAlwiQi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8164A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908214; cv=none; b=YqmtvOAvjWueNOQ4jJqObMJwB/LCxgYcJwR2QOlOmvB6lXXWbOPGni7OhV86XG8MDcg5VzrnrMF1P+CD+tvLR/PUldjGsQunObc7082/wDk0CkOJE8MU88YAdcI5PdnMnljSA/cx5OezXirgPxNmQGmzWZJLcmNJUiKSCoP1DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908214; c=relaxed/simple;
	bh=ZWIc9UiiQFPiR8u4e0A0kpQqLGQVVtnBuEwmNS0uIiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZE8gvz2oDF6VKcrw3kg1bvOJXAsSdmbBl1ct2JcbWLm8yQfLPzeKvZ/rrFiR4MylAf/PiDAebk3Uy6QC2xGIB4KKWPiYyXypTcMmM20VdAM/NmdONMELuzWFdrLnKqWOsvwyDP4wX94qxlIn9YVWBmRGpgvQvT2yYRrqlYiEv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFAlwiQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722908211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcEhLUCnxr7i/FrVr2sXDzvhlO4CjTTmW0PE+1dyQyA=;
	b=KFAlwiQiZNchro7toeVR8u92kcQixBHJpjTmIB1XW52Rp8fKxBHn0f3ENId504zXEGm54Z
	xGaWAym6IQbS6k9/ERZsKtaRdueYHD+IGm5yBwfg5QrqAjdcoJ7oYn8nY6BGFI8YN0CKil
	Iq054wmE0nbDv0+jbl4rQ3IZ7ie3ID8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-XsOgrf39M7iwiP_Lsp_wlA-1; Mon,
 05 Aug 2024 21:36:47 -0400
X-MC-Unique: XsOgrf39M7iwiP_Lsp_wlA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 051061955F43;
	Tue,  6 Aug 2024 01:36:46 +0000 (UTC)
Received: from [10.22.32.51] (unknown [10.22.32.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44D3130001AD;
	Tue,  6 Aug 2024 01:36:44 +0000 (UTC)
Message-ID: <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>
Date: Mon, 5 Aug 2024 21:36:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-3-cmllamas@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240806010128.402852-3-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/5/24 21:01, Carlos Llamas wrote:
> The LOCKDEP_*_BITS configs control the size of internal structures used
> by lockdep. The size is calculated as a power of two of the configured
> value (e.g. 16 => 64KB). Update these descriptions to more accurately
> reflect this, as "Bitsize" can be misleading.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   lib/Kconfig.debug | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index baaaedfde0cb..e0614a415348 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1505,7 +1505,7 @@ config LOCKDEP_SMALL
>   	bool
>   
>   config LOCKDEP_BITS
> -	int "Bitsize for MAX_LOCKDEP_ENTRIES"
> +	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 24
>   	default 15
> @@ -1513,7 +1513,7 @@ config LOCKDEP_BITS
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
>   
>   config LOCKDEP_CHAINS_BITS
> -	int "Bitsize for MAX_LOCKDEP_CHAINS"
> +	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 21
>   	default 16
> @@ -1521,7 +1521,7 @@ config LOCKDEP_CHAINS_BITS
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
>   
>   config LOCKDEP_STACK_TRACE_BITS
> -	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
> +	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 26
>   	default 19
> @@ -1529,7 +1529,7 @@ config LOCKDEP_STACK_TRACE_BITS
>   	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
>   
>   config LOCKDEP_STACK_TRACE_HASH_BITS
> -	int "Bitsize for STACK_TRACE_HASH_SIZE"
> +	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
>   	range 10 26
>   	default 14
> @@ -1537,7 +1537,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
>   	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
>   
>   config LOCKDEP_CIRCULAR_QUEUE_BITS
> -	int "Bitsize for elements in circular_queue struct"
> +	int "Size for elements in circular_queue struct (as Nth power of 2)"
>   	depends on LOCKDEP
>   	range 10 26
>   	default 12

Many kernel developers understand that BITS refers to a size of 2^n. 
Besides LOCKDEP, there are also many instances of such use in other 
kconfig entries. It can be a bit odd to explicitly state that just for 
LOCKDEP.

Cheers,
Longman



