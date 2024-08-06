Return-Path: <linux-kernel+bounces-275541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E4948701
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993711C22217
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62218A947;
	Tue,  6 Aug 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix9hG5sZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C48C1E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907795; cv=none; b=D+zQOXEVryGOuhWf1NGrzMohW1GJ98jUmsWwB7+3XxntXkhnwTTX57xXxMTAKDhtvwwmukSlci2LswjuYMC1YPFjfTy0/hashg4DNchdBWnHhLOfghU0vVsKlx58qauOHnMPZJnXIiV3/zc4WsaS468b53LEVMFCqXgKL3GcTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907795; c=relaxed/simple;
	bh=kVVgZOJlzLRXPWcFJzGsGUhi6HbcKC0vLlag1sQKgW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkleNgH0oKq97XB4MCJAwxCq4Ot3LHqj6RR5w6JK0sQrRhGSuAbAcd1xfGOsIjtbWgrf6rHA1OJYgJVlK7pW32yFmvax2NhGyvsb1ZWiDeaxMU+T0v/DlnOsXscC37Q4LUHGmdNPp8h2ILJK/kKubZLurE3aQF8KU9sCRX8Yjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix9hG5sZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722907792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQSq9AZazdPqVoT3zkbF9dfRsf1pS0rQsrMyZs84kiE=;
	b=ix9hG5sZ2PY2VWbXiRFYmHWdrrl5misfU7XZCSThJ6Hn5HdPrPfpr7BYSMRthEuvyLKvLj
	lUc+zACL7gQyISSmPf8QVUUMwt0/bLrBONc79/38rendajlYzGjMjj9sZhoMY5aPpht7zs
	1c7V6I2to5ElY1QXtvx8L9v4q3mm2uU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-Bkm65-gCNjqM8lOKq205uw-1; Mon,
 05 Aug 2024 21:29:49 -0400
X-MC-Unique: Bkm65-gCNjqM8lOKq205uw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD0411955D52;
	Tue,  6 Aug 2024 01:29:47 +0000 (UTC)
Received: from [10.22.32.51] (unknown [10.22.32.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12ED31955D42;
	Tue,  6 Aug 2024 01:29:45 +0000 (UTC)
Message-ID: <0299406c-b316-4e79-848d-b6641dda0031@redhat.com>
Date: Mon, 5 Aug 2024 21:29:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 "J. R. Okajima" <hooanon05g@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-2-cmllamas@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240806010128.402852-2-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 8/5/24 21:01, Carlos Llamas wrote:
> Lockdep has a set of configs used to determine the size of the static
> arrays that it uses. However, the upper limit that was initially setup
> for these configs is too high (30 bit shift). This equates to several
> GiB of static memory for individual symbols. Using such high values
> leads to linker errors:
>
>    $ make defconfig
>    $ ./scripts/config -e PROVE_LOCKING --set-val LOCKDEP_BITS 30
>    $ make olddefconfig all
>    [...]
>    ld: kernel image bigger than KERNEL_IMAGE_SIZE
>    ld: section .bss VMA wraps around address space
>
> Adjust the upper limits to the maximum values that avoid these issues.
> The need for anything more, likely points to a problem elsewhere. Note
> that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
> had a different symptom and has already been fixed [1].
>
> Reported-by: J. R. Okajima <hooanon05g@gmail.com>
> Closes: https://lore.kernel.org/all/30795.1620913191@jrobl/ [1]
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   lib/Kconfig.debug | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a81d452941ce..baaaedfde0cb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1507,7 +1507,7 @@ config LOCKDEP_SMALL
>   config LOCKDEP_BITS
>   	int "Bitsize for MAX_LOCKDEP_ENTRIES"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 30
> +	range 10 24
>   	default 15
>   	help
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
> @@ -1523,7 +1523,7 @@ config LOCKDEP_CHAINS_BITS
>   config LOCKDEP_STACK_TRACE_BITS
>   	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 30
> +	range 10 26
>   	default 19
>   	help
>   	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
> @@ -1531,7 +1531,7 @@ config LOCKDEP_STACK_TRACE_BITS
>   config LOCKDEP_STACK_TRACE_HASH_BITS
>   	int "Bitsize for STACK_TRACE_HASH_SIZE"
>   	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 30
> +	range 10 26
>   	default 14
>   	help
>   	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
> @@ -1539,7 +1539,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
>   config LOCKDEP_CIRCULAR_QUEUE_BITS
>   	int "Bitsize for elements in circular_queue struct"
>   	depends on LOCKDEP
> -	range 10 30
> +	range 10 26
>   	default 12
>   	help
>   	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.

I agree that we should further limit the max values.

Acked-by: Waiman Long <longman@redhat.com>


