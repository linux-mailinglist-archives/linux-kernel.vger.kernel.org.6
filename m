Return-Path: <linux-kernel+bounces-275540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E2948700
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5661B1C2223D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D695FBF0;
	Tue,  6 Aug 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXltVDaJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1AB65C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907683; cv=none; b=gaw7bAUHzThOoY/02Mqe+dh0bjQBJpVsIMeo8NR68DwI3DNv4iml96V+NtF4NZc7/tjhUjeBsu7CALEXJz81tLeUvZHFZ+WznLDHeseZ/FLR96g5MXYV4+MQb2mEfW0pwtxweqBwgHcXtcvhwL2v4xWNDZqoDQrndb/gBRww1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907683; c=relaxed/simple;
	bh=1i9OZ5kYFOHnn8yyarxxp4Ja57O53M1Z2RbHEOca1tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prBGEr70tJv2JVUA4NOs84MI7XvSNle4L/iUVrLHXeLIAEBCi99K1j7gonFAML5ZOp+PkdFa2V3Dt/WqNd7aMM3NDW8Id6SJGHQfDKUMAi7Cw0H7wn8LqayYhseRyMmG1yTzJViZlwO4CRdthhvURLh1z/9icpBS/zP1jqq3NWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXltVDaJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722907680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+bdAM/DkGOA/Zs1QvQLk45BV0xvOdfS2m9pTY/3ctI=;
	b=gXltVDaJwhzoAEytTz1F6dXHOlMbmabuB2XyQkYfA3UgNaEYYUBmymfzTcoUyShuKNfzr9
	RUrpaWvf7iCbn0qMsgWwO+dryD3G8yRdT1gU1p5lydeVubmwce8yFXvyE6dKeTsHSWC2rA
	hQnqbwiADiSbid+bZNwQ1WoU5x9Rm44=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-nnEXIJAgOyu_UeSWzu0Ffw-1; Mon,
 05 Aug 2024 21:27:57 -0400
X-MC-Unique: nnEXIJAgOyu_UeSWzu0Ffw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBB79195609E;
	Tue,  6 Aug 2024 01:27:55 +0000 (UTC)
Received: from [10.22.32.51] (unknown [10.22.32.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0C351955F40;
	Tue,  6 Aug 2024 01:27:53 +0000 (UTC)
Message-ID: <45ceeb38-06c4-4b8a-8b3f-afe57c891f9a@redhat.com>
Date: Mon, 5 Aug 2024 21:27:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS
 calculation
To: Carlos Llamas <cmllamas@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Huang Ying <ying.huang@intel.com>, "J. R. Okajima" <hooanon05g@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-4-cmllamas@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240806010128.402852-4-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/5/24 21:01, Carlos Llamas wrote:
> Add a comment to document the magic number '5' used in the calculation
> of MAX_LOCKDEP_CHAIN_HLOCKS. This number represents the estimated
> average depth (number of locks held) of a lock chain. This definition
> was added in commit 443cd507ce7f ("lockdep: add lock_class information
> to lock_chain and output it").
>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: J. R. Okajima <hooanon05g@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   kernel/locking/lockdep_internals.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index bbe9000260d0..2b429ed103a8 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -119,6 +119,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>   
>   #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
>   
> +/* We estimate that a chain holds 5 locks on average. */
>   #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
>   
>   extern struct lock_chain lock_chains[];

I think it is better to define another macro like

diff --git a/kernel/locking/lockdep_internals.h 
b/kernel/locking/lockdep_internals.h
index bbe9000260d0..8805122cc9f1 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =

  #define MAX_LOCKDEP_CHAINS     (1UL << MAX_LOCKDEP_CHAINS_BITS)

-#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
+#define AVG_LOCKDEP_CHAIN_DEPTH         5
+#define MAX_LOCKDEP_CHAIN_HLOCKS 
(MAX_LOCKDEP_CHAINS*AVG_LOCKDEP_CHAIN_DEPTH)

  extern struct lock_chain lock_chains[];

Cheers,
Longman


