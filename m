Return-Path: <linux-kernel+bounces-433775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BD9E5CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DE51882061
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A522259A;
	Thu,  5 Dec 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5Hm8IP7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4421D5AC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419127; cv=none; b=sUcV3H/8ahAdSacHv1l4hwDgXuk3nEgQUH5fSRA0ipMhIUT5qfga8WGe5Xfx211YBeDdoZFLq7KR/WypUegVnAT0dOsp1DYLz9bpA0jnUcRsVQ+5wRD2odGlJMaia5Om9wyaziPuyQkaBjZuzuZsXCXiu4Vmyi5hQICm0TKpq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419127; c=relaxed/simple;
	bh=chG2n5hrmgL3UMm6k2RMiG0qdLL1izLKwBPgpFTnpNY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q1YOYWkSbxFzy+XC+ZdEJl/uwLFH6yl54WI5pEfSwAkcsBPbJxG0ehAVSp+sh+u36CAGF6X1HbNJ/++VmHjiK9Sb4fDBlnrzoGPSdWudVUWQXEyV7yoMxmXUosxeMNv+YZaCblo2cBcvZ60W3EJOrTmP6pr4ufO+GvaUQmf0uNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5Hm8IP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733419124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqiU3+pQr/wEU/ncmXTCwgAK5M7t1qujHo4DXhL8Oe4=;
	b=K5Hm8IP7Xieor/u9gyu6MSKr9VeGC7xMrIwE6mnaXRU9W0E+DCkjFRmWJk9YeklkC/Q9zc
	DPv4Uvencfm6IkeqLcMa9p19SjbCVzRSAvawsFKVO0Nz5fFBuNvODhRXdLt1KQiP15gMZ1
	oKJ5ofKDO4TWKQ/5zUqdqDJaZ2sAsg4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593--mytXKktPqaq9gc2eKH5eQ-1; Thu, 05 Dec 2024 12:18:43 -0500
X-MC-Unique: -mytXKktPqaq9gc2eKH5eQ-1
X-Mimecast-MFC-AGG-ID: -mytXKktPqaq9gc2eKH5eQ
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8419f8859f7so85345839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419122; x=1734023922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqiU3+pQr/wEU/ncmXTCwgAK5M7t1qujHo4DXhL8Oe4=;
        b=j6H53tyAQe6wTJpcc5OASYO6dGF9LPK/yKq6vBDyBRbjZHQGqiX67q30sHSsaIJWWH
         nG+grClOLTAxEjCW/FhKuULObdxllRcDCZ9wa95PBSgSZHlVdCEgPWl9A0qdZhdnIksF
         99TD2rqSu8K/L1mRrnO5Qpx49mqStKHOYlebjh1yZHXVDBLAH+HGn8nyeLxjuUCWLXV9
         hqNjhVppWNGteg3c4QX5EOEHYTed1KEVEZq+1+/dbK2+RT+v8yyv/eP5QIVrMVcrNaWD
         Rs9mDq1qTp/KqlOeIl5iw1t2uDW5mVQ+B0yz7dcFV9PrRGBY83nn6wVDdhKDcAIoP258
         5SHA==
X-Forwarded-Encrypted: i=1; AJvYcCX+W5mzlmdp6buc0K+tD9v/RELbgWfom7TKnXOv/0CBtNaNObLF7Zrl98iNEKwdXeccbhYTRhUJAWWkp4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLriC+rUrppj0AAmDJrksrg/0KY2yUuvpUhdfgfyHyHiz7Og8E
	Rx24wvcWRCnZyRKbp25mwP4KKiDbzd2jIKvTHgz45jswv1n0PCblE6nF3GDpyQqwCx0X2OKotNZ
	qaZaaeaw2r8e+adANCdsh5KWGg72mE+VWNBD5+YL8RwOCajRnJWGJ6myPABX4rw==
X-Gm-Gg: ASbGncvYUkrnr7ainp3Fn8qsYwbxsQPeFjSZ3v8VkCVK4DsuNUl6ibdfGFoP9gxUdbz
	0+ygKJbmuggGtwxWzU6k6xGHQOtDbeVrpk7lcySie7V9fMakvf2ZAcORc84W+APktpe8uj3KPmN
	Zdr1hVi+rqkzmA0gxwCQE9CxHm4vTGVE+85oqgpkajWAfZFiTc8b/f8FUW5d4CKZd7liD0QBFLR
	8WFw68PTApurNaysQOXhPLNKjxi64unTuuN+d9ri/NYXPEP5jc1ADi/9Bdoc6S36foYRJre0LOJ
	k2fyjGHCVIpRq1EgMg==
X-Received: by 2002:a05:6602:48e:b0:841:a652:b0c8 with SMTP id ca18e2360f4ac-8447e1fee85mr2352239f.3.1733419122473;
        Thu, 05 Dec 2024 09:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMnOeUjsq2hbax64jR9skfv5bpkcLdqTNjX8PaOOk6irZEJ9Ejkdka4bhjYuKgHFM/Ly9FqA==
X-Received: by 2002:a05:6602:48e:b0:841:a652:b0c8 with SMTP id ca18e2360f4ac-8447e1fee85mr2349339f.3.1733419122180;
        Thu, 05 Dec 2024 09:18:42 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844738d1011sm44593739f.14.2024.12.05.09.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:18:41 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2486c017-dfe0-45ee-bd44-e05acdec4f3f@redhat.com>
Date: Thu, 5 Dec 2024 12:18:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/spinlock/debug: Fix data-race in
 do_raw_write_lock
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Adrian Freihofer <adrian.freihofer@siemens.com>
References: <20241205170143.4105094-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
In-Reply-To: <20241205170143.4105094-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/24 12:01 PM, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> KCSAN reports:
>
> BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock
>
> write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
>   do_raw_write_lock+0x120/0x204
>   _raw_write_lock_irq
>   do_exit
>   call_usermodehelper_exec_async
>   ret_from_fork
>
> read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
>   do_raw_write_lock+0x88/0x204
>   _raw_write_lock_irq
>   do_exit
>   call_usermodehelper_exec_async
>   ret_from_fork
>
> value changed: 0xffffffff -> 0x00000001
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111
>
> Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
> adressed most of these races, but seems to be not consistent/not complete.
>
>  From do_raw_write_lock() only debug_write_lock_after() part has been
> converted to WRITE_ONCE(), but not debug_write_lock_before() part.
> Do it now.
>
> Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
> Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> There are still some inconsistencies remaining IMO:
> - lock->magic is sometimes accessed with READ_ONCE() even though it's only
> being plain-written;
> - debug_spin_unlock() and debug_write_unlock() both do WRITE_ONCE() on
> lock->owner and lock->owner_cpu, but examine them with plain read accesses.
>
>   kernel/locking/spinlock_debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
> index 87b03d2e41dbb..2338b3adfb55f 100644
> --- a/kernel/locking/spinlock_debug.c
> +++ b/kernel/locking/spinlock_debug.c
> @@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
>   static inline void debug_write_lock_before(rwlock_t *lock)
>   {
>   	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
> -	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
> -	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
> +	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
> +	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
>   							lock, "cpu recursion");
>   }
>   

LGTM

Acked-by: Waiman Long <longman@redhat.com>


