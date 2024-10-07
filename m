Return-Path: <linux-kernel+bounces-353346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6E992C88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B52DB2401A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692FA1D2785;
	Mon,  7 Oct 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFMutevu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389461E519
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306333; cv=none; b=uhWtJqI2g89z4g4mQJIW0vgHUBL1WNgu6ZM6TWtMq1Oh6/xcDoaUsBrm/DnAoVWN67S8TyMuk6M1beLsXAlQdagj6ALsJ7a+6Z0lnt3Hw1phmYVFJ31qylLp+PVQgWMKa+cFOVszDJ5Ge0fPc0RIBk/hZ5wBpQcJZ9G2LTNr1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306333; c=relaxed/simple;
	bh=DjrHSzN1XAwmzmVKiB4xm5OphK+HPOwkBB6Y+iFijy8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LeoYyp5rro6ok7OoefynVh69XJY1k4VBHprR8areP/omE2MvArs2QXrLBwcoMVeDK5WZCX3byBx7JaGX36s6ClzmdAwECSipOUN2+WJiW7MqqTLHLOiNdibZI5FVmMsB/aWEMH3t7QakhZ6tKJ+jCpfPLPm0uIiwSgC2lMIIBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFMutevu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728306330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILs4ztWFA/upvY6uIhv3dtSVKzJgCuwEj4Rpb4fjCxQ=;
	b=JFMutevueyjDIBCG2frCnO6zPJStvrizhBe9MibgoSk+NieUth69Itsrq2N6DceEpm2fFf
	k2V07R0P2vENRpb7tzyYOZ5DFpyyWwc3LhdapU3YoqwObp255+83PKmGja2CjqYCXAvDEk
	JzURokLPXGqOPSCZltRwOZy/UVXIlok=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-Rvk3Q7wEOpKR2lMrJ1WPDQ-1; Mon, 07 Oct 2024 09:05:29 -0400
X-MC-Unique: Rvk3Q7wEOpKR2lMrJ1WPDQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-287d59f8ac4so3095259fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306328; x=1728911128;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILs4ztWFA/upvY6uIhv3dtSVKzJgCuwEj4Rpb4fjCxQ=;
        b=K1kUrPB0v9NqxOjWEwzTDxtWUcs/deQ6yWNVBajHZAyBT5tDoTabjVfgvMZu4Do5nx
         u8ZARHlL8MvEHLIZitH1aEB2EVN5TKAHWKn3gDn3O8GzK8wo1ElqP1QxJzHp/k1o1hWg
         M8ofT2WIyWZqfAQDLBXS+Ad+c2EShjruyyVIpMvekuQ9B64cLBPHCHaQ6q0s+OWDXSlK
         qbumNnqEe5MXLKh0azNcKPMR2STDXSbe9FofJ94CcQEqPKlk5Eum+seRYn07InzPwURs
         sWN2bXdvUZANH1gJTBEj+AaD8G/A9JnnEhNZIhUdOT94dNY9PspG9D6ll606KPC14s64
         v7jA==
X-Gm-Message-State: AOJu0YyP7ey6BQanjALH8VafKPxa1AI3axA11HISho3k6Ty8iFo3HRXe
	oQMpbMMbXFkJauOFaMAmMwSdjBTvzGcxOQJhD+hKFKBL/oLfuO6zEa3M3SrdoXao/Kny17iSG7C
	zVBYYBZUqBPMFT7lr5Jz7kXXRkQC2ZaYuskCYm2avEMTcZp3v0O2ZwqSo9MJqA2TrfqrG6Zf7
X-Received: by 2002:a05:6870:1689:b0:270:276d:fb54 with SMTP id 586e51a60fabf-287c1e18cb1mr6274729fac.21.1728306328295;
        Mon, 07 Oct 2024 06:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+7r2/Fgd9rjJ1csIlmo0a7eVgPE1xvwDN0wHcd1eN3Uc94/vHJzcr2191bOjw6RBebtH/Qw==
X-Received: by 2002:a05:6870:1689:b0:270:276d:fb54 with SMTP id 586e51a60fabf-287c1e18cb1mr6274699fac.21.1728306328008;
        Mon, 07 Oct 2024 06:05:28 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8e5868f6sm160224173.112.2024.10.07.06.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:05:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8d2becc9-a8cd-4352-a338-7fadf9460793@redhat.com>
Date: Mon, 7 Oct 2024 09:05:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Use info level for lockdep initial info messages
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20241007065457.20128-1-jirislaby@kernel.org>
Content-Language: en-US
In-Reply-To: <20241007065457.20128-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 2:54 AM, Jiri Slaby (SUSE) wrote:
> All those:
>   Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
>   ... MAX_LOCKDEP_SUBCLASSES:  8
>   ... MAX_LOCK_DEPTH:          48
>   ... MAX_LOCKDEP_KEYS:        8192
> and so on are dumped with the KERN_WARNING level. It is due to missing
> KERN_* annotation.
>
> Use pr_info() instead of bare print() to dump the info with the info
> level.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   kernel/locking/lockdep.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 536bd471557f..ae8750157099 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6576,17 +6576,17 @@ EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>   
>   void __init lockdep_init(void)
>   {
> -	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
> +	pr_info("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
>   
> -	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
> -	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
> -	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
> -	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
> -	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
> -	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
> -	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
> +	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
> +	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
> +	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
> +	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
> +	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
> +	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
> +	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
>   
> -	printk(" memory used by lock dependency info: %zu kB\n",
> +	pr_info(" memory used by lock dependency info: %zu kB\n",
>   	       (sizeof(lock_classes) +
>   		sizeof(lock_classes_in_use) +
>   		sizeof(classhash_table) +
> @@ -6604,12 +6604,12 @@ void __init lockdep_init(void)
>   		);
>   
>   #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
> -	printk(" memory used for stack traces: %zu kB\n",
> +	pr_info(" memory used for stack traces: %zu kB\n",
>   	       (sizeof(stack_trace) + sizeof(stack_trace_hash)) / 1024
>   	       );
>   #endif
>   
> -	printk(" per task-struct memory footprint: %zu bytes\n",
> +	pr_info(" per task-struct memory footprint: %zu bytes\n",
>   	       sizeof(((struct task_struct *)NULL)->held_locks));
>   }
>   

Make sense!

Reviewed-by: Waiman Long <longman@redhat.com>


