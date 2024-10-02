Return-Path: <linux-kernel+bounces-347871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B798DFBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4594286EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA801D14E8;
	Wed,  2 Oct 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4oYKUeg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2F1D0DCE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884059; cv=none; b=JHxCUxtUUzH/WsMa5N1DH54CTeU35gtrMOktL8DKnrIBM2MK7WRwvgPx9M9kyXZgUTiSiy6dXCd15H1v7ywlZQdVfOdzBDA++76OgCiTRDT9h2z6SgQbEudDtJWknKu5D7gDSrg4AdtLKuecSCITTWtBlwZeLVA32JUNIk54Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884059; c=relaxed/simple;
	bh=qCQ3cJQO/dmNN5LYmhf/URBLj67ELKxqLnDObLENWvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMc0QVZ3gznPf0Nar1t/bhI5UhLuOJVJVVJhoS3DDwxQhqV/HALrzlu7Kz1g/ipb7mqSzlQu2cm7q251IInhbCmSnBNJWsispKxYZeMiUOp5KCsFSMRsn54uwbULtFt5DLeylZt2lze2F8QZ+Fr3lSI8myPWoff7TnIUJij+QVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4oYKUeg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727884057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIKG9Pade4XNA56GbZC5vpcwmOHLWrTX3p/LHndtqD4=;
	b=Y4oYKUegyorAcrtjyBYv77w52ftGrf/0/zOA0x5SBNLEzBm374tXeXWKdh2mnDvN//oXnG
	zYpgq0YLShw1py+lz/noWGbXioLDGdpBYEdr9weMnoVOdLFwl4q1J8CGJigRwEGmr3o/DJ
	zqyZII5ue8HVPoV3GGBMgwhyGrGF/lY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-PHMEOgtXO8iudI1D9pvYlA-1; Wed,
 02 Oct 2024 11:47:34 -0400
X-MC-Unique: PHMEOgtXO8iudI1D9pvYlA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C55E1954239;
	Wed,  2 Oct 2024 15:47:32 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C22019560A2;
	Wed,  2 Oct 2024 15:47:31 +0000 (UTC)
Message-ID: <905c96ba-c11f-4829-b8a4-c67edc511ae9@redhat.com>
Date: Wed, 2 Oct 2024 11:47:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/osq_lock: Use atomic_try_cmpxchg_release() in
 osq_unlock()
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20241001114606.820277-1-ubizjak@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20241001114606.820277-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/1/24 07:45, Uros Bizjak wrote:
> Replace this pattern in osq_unlock():
>
>      atomic_cmpxchg(*ptr, old, new) == old
>
> ... with the simpler and faster:
>
>      atomic_try_cmpxchg(*ptr, &old, new)
>
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after the CMPXCHG.  The code
> in the fast path of osq_unlock() improves from:
>
>   11b:	31 c9                	xor    %ecx,%ecx
>   11d:	8d 50 01             	lea    0x1(%rax),%edx
>   120:	89 d0                	mov    %edx,%eax
>   122:	f0 0f b1 0f          	lock cmpxchg %ecx,(%rdi)
>   126:	39 c2                	cmp    %eax,%edx
>   128:	75 05                	jne    12f <...>
>
> to:
>
>   12b:	31 d2                	xor    %edx,%edx
>   12d:	83 c0 01             	add    $0x1,%eax
>   130:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
>   134:	75 05                	jne    13b <...>
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   kernel/locking/osq_lock.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 75a6f6133866..b4233dc2c2b0 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -215,8 +215,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>   	/*
>   	 * Fast path for the uncontended case.
>   	 */
> -	if (likely(atomic_cmpxchg_release(&lock->tail, curr,
> -					  OSQ_UNLOCKED_VAL) == curr))
> +	if (atomic_try_cmpxchg_release(&lock->tail, &curr, OSQ_UNLOCKED_VAL))
>   		return;
>   
>   	/*

LGTM

Acked-by: Waiman Long <longman@redhat.com>


