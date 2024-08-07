Return-Path: <linux-kernel+bounces-278274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DB94AE27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEE21F270E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B513E043;
	Wed,  7 Aug 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1VhqleM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37C13E021
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048143; cv=none; b=LQeDH+WV0eNBZIS5bRynLLK1N+EazLbDddV9nOy4IV4McPeSIKBK8HSe93+aP6KI5aLrLqHUZtyvoiw59UwPkiDLgD+wCJ08rh46faFB4Lx8dF61AeVCgo8dV9Geo5kOcJgjg4kTty8bdV1RHhYiT26bODSRX5Gfa3bp+bbJ+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048143; c=relaxed/simple;
	bh=/coQMA7ggJEUL7+TaTT35wfbLG0bd9m9ZsDwrUEupoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oL8H/V5vtUDtxdrmSXderhStr60Q1llqN91AVCp2RR7rYHWO28P1P+nZn/CC9iNTFxwTMpHOlzY62cqHGy+rgs002mi5g8rz/sI7sVxCbkmrUqw+DpX4Y1SW9skYIqgeWgb5NVVsI4FTQMCa8G3DNwF97IzPJck8w2lCJExPzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1VhqleM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723048140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8qeCgkTXPnoyMwT6NB/HY3bNOSPK3Im4qaWKdjX50M=;
	b=e1VhqleME4V1YA8LJdn40UCLgnYG1B8UV5ABHFoVTNnjc/gpx171S0iCojsnwywN4R0GSU
	LbSgycG5Ha9Rfj2LsvnYdEJM0NtkbRml2Veh+yfrDPRaBDKZ+YfNMeI6AcmVAYyvwdspi0
	4mORL3rcgtFwNrGepabtdxfTKq6sHFY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-HGtyom85Moq4ktEB0W6F0w-1; Wed,
 07 Aug 2024 12:28:57 -0400
X-MC-Unique: HGtyom85Moq4ktEB0W6F0w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80A221944CCC;
	Wed,  7 Aug 2024 16:28:55 +0000 (UTC)
Received: from [10.2.16.123] (unknown [10.2.16.123])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8477319560A3;
	Wed,  7 Aug 2024 16:28:53 +0000 (UTC)
Message-ID: <cfef6a18-4428-4568-8d16-5ac68ddbe7a4@redhat.com>
Date: Wed, 7 Aug 2024 12:28:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS
 calculation
To: Carlos Llamas <cmllamas@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, "J. R. Okajima" <hooanon05g@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20240807143922.919604-1-cmllamas@google.com>
 <20240807143922.919604-4-cmllamas@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240807143922.919604-4-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/7/24 10:39, Carlos Llamas wrote:
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
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
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


