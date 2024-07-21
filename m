Return-Path: <linux-kernel+bounces-258314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DC93861E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4624C1C20B38
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 20:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DC1667FA;
	Sun, 21 Jul 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKNp0XpS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398C1CFBC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721594769; cv=none; b=pCLlAup1XUAlRwy92AwFbw/fO89CuYfveS1KaUgVFR2QPBthNyl4ePcBEbWDmACeWW7O0BQ1JvIX+nJ9EONX2PhZKgWly4Y6nG7/LlbjzA/MOA7X8KhfWsMTR3nnb21PMtlUiNpAlyEhmFaNl1b1uBKpTlLfY+ZKjokAUPv2lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721594769; c=relaxed/simple;
	bh=MKWVvgheYTCo70EPAsdPS986eP5VlvZPS0bvVsZ64TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZiUDuFYH5zdlXF4wU6OwADa48TZaGo63K8l4UMGo0PQbQRlYEi3Qyl0lGf3AoEQ1st1Pvn57lPFLH0EXkUZM5wosxVX4h/5e78kQBg/Zy2xochkiGB8WJu75TihkNgkIciIed/g5jAyYDlVlyZIoyJ/2Lc61VGs65i9LNiI2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKNp0XpS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721594763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjJn0OeY3E+WnT9B+1I6JsdpgdiGkZmLcpPp16iKBxM=;
	b=eKNp0XpSgAs+NCqQB6+cQxrdNs+wef6FIVo62x1MC73fFleEGGZMQrHil74mM5nsYdBtdU
	fCNoOVG/EKxRcZmhrkBTzOf4o3L/gPphcWGQWtlzDqh9lUPSP8U5/hveXBMTOYiMb7m+o7
	O+lChQVX2vvysUqEFWjykB+Mm8BT1xY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-NOd0V5H_PL-D3ztk6n4jig-1; Sun,
 21 Jul 2024 16:45:57 -0400
X-MC-Unique: NOd0V5H_PL-D3ztk6n4jig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8901955F0D;
	Sun, 21 Jul 2024 20:45:55 +0000 (UTC)
Received: from [10.22.64.60] (unknown [10.22.64.60])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B8C41955D44;
	Sun, 21 Jul 2024 20:45:52 +0000 (UTC)
Message-ID: <f63f46c0-bf30-4332-accc-7562a259309e@redhat.com>
Date: Sun, 21 Jul 2024 16:45:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/pvqspinlock: Correct the type of "old" variable
 in pv_kick_node()
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <20240721164552.50175-1-ubizjak@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240721164552.50175-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 7/21/24 12:45, Uros Bizjak wrote:
> "enum vcpu_state" is not compatible with "u8" type for all targets,
> resulting in:
>
> error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *'
>
> for LoongArch. Correct the type of "old" variable to "u8".
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h")
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/
> ---
>   kernel/locking/qspinlock_paravirt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index f5a36e67b593..ac2e22502741 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>   static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>   {
>   	struct pv_node *pn = (struct pv_node *)node;
> -	enum vcpu_state old = vcpu_halted;
> +	u8 old = vcpu_halted;
>   	/*
>   	 * If the vCPU is indeed halted, advance its state to match that of
>   	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
Acked-by: Waiman Long <longman@redhat.com>


