Return-Path: <linux-kernel+bounces-177380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23848C3DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1066D1C214D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0C1487E9;
	Mon, 13 May 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="DBEa6AXi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306B14882C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591317; cv=none; b=Cj3qvXA5Dm5FHhKRYo6NfJBIhWHCstCydW9VdB64JBGMYAvJlTHszEkyM1hMB0pD008R6+PkkJLJ1s+gMo0qKcBzvqbLJWqzN1Qp0MF/8Vwq8pFnseCKxWGvg0V1aziqA14jubnqSKReXEye8kEJoFxEdb6snm6CEh/6m+7qOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591317; c=relaxed/simple;
	bh=2QsXDwcelsfu46sr9efR6lHGYf2IlIuBQCye7ipXK/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3g462AjhehmN8+3RtVq93CHzyUxiLMWeBiLDHmXrKaBJgMGeUhR6uRN1K94Pcl7yr+8YBcJFUAu38VR4wzC/3ZnB31R3tqviAdZ4w7TBgNuglJscwJI7FpTpUCywR5BrsvKYSX4mjLWqaT7a+yLo5HouH2NKnhDJtY6uAAaWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=DBEa6AXi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so21912835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1715591315; x=1716196115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr22ximAHVRceMZ/0HBVL4r+nNUIEc69bm0wOS15KTw=;
        b=DBEa6AXiYOFigWXpvgZIH4qeQUtuAwJkEmF0pwxKN+lxaG597nejTVFWovL8y9jk3y
         aQNZWYOZtcOEyn3AG7nilSm9xqDh6wld5L5NA3tHy1ABjj9SHgyUWPWtLygDvlu4SEez
         huxGyq8GS6ZynI3eJ5APdlIPXvFI0V2bE4AGjoaSSruS+kf8ZlFFriNN2vzQ5f6PLcM9
         npQb8RNT5uTzfdW22z4ZKmWSMH94KNHwv+dB3lAsVHVr4ZFEFvDpY4NG5EOd2z7nx3qH
         bdl/i6NHjKWTw8CpEb0PQe2jIl0IR1vqg4lQCbF9xRLBJkgL+PgtQotx+nB7cz7kZmh9
         yX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591315; x=1716196115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yr22ximAHVRceMZ/0HBVL4r+nNUIEc69bm0wOS15KTw=;
        b=TIn+95FbiZeM0O332nM/pNjsAFk+MXgzs2O0LX50XPsd6ZgizsL6bZYP+VdvccharD
         ULu+iLhNZ9H8ILGV0iIsY2sIKzsFTjHplZs6ufw/n8gdxxfaeX6kQp7veoFLPOzu4W9A
         MbuXa6l0DklVWlEHmnqxjtb4Awwwjriouuw9Qamu5TPKZdy3OuC+PMiJCe7KpKNwaek8
         l5ZUPmGfN/SP0XQFsphiZPybAPKjM39O3uOFlk1WCil3lvbuCHtuQR0r2ZMCz1KQGyp0
         FzO3trVDYmQDB/QMyVpWrnwP2TAYv9YSuqZ2xgwhFKZBALLgwKWqDYsPgfuuKYJoMaPE
         Qdag==
X-Forwarded-Encrypted: i=1; AJvYcCVRzM/rnhqUP5CLxG4bAmoJf/WuaQPU9Q5/CEXgPqbkyiu2KcV66BZZ6527+GxZI7hWx7ssG4fdYXmbxI90bYw9PX1LM7KZT8iLNPJm
X-Gm-Message-State: AOJu0YwjgP/Sl8rSfo6jYt7XIy/u34N4bMveMQMMPeuaflOyxLiitK3m
	FohiBL1cZ706RzVd9GhXemiimkV8tOpLA2Ipd1iNAQrwLTsFPWZUwEReXxKnaMs=
X-Google-Smtp-Source: AGHT+IEEEvsJPkxM92hjdodHUe8faM9sXqweFuG1/9ugwLJMqHFY9fzJEdXZLRRP8Df5tuHImd2xEw==
X-Received: by 2002:a17:902:7b82:b0:1ec:585e:5363 with SMTP id d9443c01a7336-1ef43d2e2ffmr77255545ad.29.1715591315222;
        Mon, 13 May 2024 02:08:35 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d385esm76252305ad.38.2024.05.13.02.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:08:34 -0700 (PDT)
Message-ID: <ebc541b4-f115-4a15-bd07-7844463346e0@shopee.com>
Date: Mon, 13 May 2024 17:08:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing wakeup when waiting for context
 reference
To: Mark Rutland <mark.rutland@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, frederic@kernel.org,
 acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418114209.22233-1-haifeng.xu@shopee.com>
 <ZieH-g8fWn60z-ev@FVFF77S0Q05N>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZieH-g8fWn60z-ev@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/23 18:05, Mark Rutland wrote:
> On Thu, Apr 18, 2024 at 11:42:09AM +0000, Haifeng Xu wrote:
>> In our production environment, we found many hung tasks which are
>> blocked for more than 18 hours. Their call traces are like this:
>>
>> [346278.191038] __schedule+0x2d8/0x890
>> [346278.191046] schedule+0x4e/0xb0
>> [346278.191049] perf_event_free_task+0x220/0x270
>> [346278.191056] ? init_wait_var_entry+0x50/0x50
>> [346278.191060] copy_process+0x663/0x18d0
>> [346278.191068] kernel_clone+0x9d/0x3d0
>> [346278.191072] __do_sys_clone+0x5d/0x80
>> [346278.191076] __x64_sys_clone+0x25/0x30
>> [346278.191079] do_syscall_64+0x5c/0xc0
>> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
>> [346278.191086] ? do_syscall_64+0x69/0xc0
>> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
>> [346278.191092] ? irqentry_exit+0x19/0x30
>> [346278.191095] ? exc_page_fault+0x89/0x160
>> [346278.191097] ? asm_exc_page_fault+0x8/0x30
>> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The task was waiting for the refcount become to 1, but from the vmcore,
>> we found the refcount has already been 1. It seems that the task didn't
>> get woken up by perf_event_release_kernel() and got stuck forever. The
>> below scenario may cause the problem.
>>
>> Thread A					Thread B
>> ...						...
>> perf_event_free_task				perf_event_release_kernel
>> 						   ...
>> 						   acquire event->child_mutex
>> 						   ...
>> 						   get_ctx
>>    ...						   release event->child_mutex
>>    acquire ctx->mutex
>>    ...
>>    perf_free_event (acquire/release event->child_mutex)
>>    ...
>>    release ctx->mutex
>>    wait_var_event
>> 						   acquire ctx->mutex
>> 						   acquire event->child_mutex
>> 						   # move existing events to free_list
>> 						   release event->child_mutex
>> 						   release ctx->mutex
>> 						   put_ctx
>> ...						...
>>
>> In this case, all events of the ctx have been freed, so we couldn't
>> find the ctx in free_list and Thread A will miss the wakeup. It's thus
>> necessary to add a wakeup after dropping the reference.
>>
>> Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> FWIW, this looks good to me, but I haven't yet been able to write a test to
> exercise this: perf_event_free_task() is only called if
> perf_event_init_context() fails or of copy_process() fails partway through, and
> while it should be possible to make the latter fail consistently by messing
> with cgroups, I haven't had the time to work all that out.
> 

Hi, Mark.

This problem seems similar to this bug reported by syzbot.
https://lore.kernel.org/all/00000000000057102e058e722bba@google.com/T/#mbb1d50748ff3190738a9754bdff118e640fbb3a3

> So I think there's a reliable DoS here, but I haven't had the time to go write
> that myself. It would be nice if we actually had a test for this.
> 
> I reckon that in addition to the Fixes tag, this needs:
> 
> Cc: stable@vger.kernel.org
> 

Ok, I'll add this tag next version.

>> ---
>> Changes since v1:
>> - Add the fixed tag.
>> - Simplify v1's patch. (Frederic)
>>
>> Changes since v2:
>> - Use Reviewed-by tag instead of Signed-off-by tag.
>> ---
>>  kernel/events/core.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4f0c45ab8d7d..15c35070db6a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5340,6 +5340,7 @@ int perf_event_release_kernel(struct perf_event *event)
>>  again:
>>  	mutex_lock(&event->child_mutex);
>>  	list_for_each_entry(child, &event->child_list, child_list) {
>> +		void *var = NULL;
>>  
>>  		/*
>>  		 * Cannot change, child events are not migrated, see the
>> @@ -5380,11 +5381,23 @@ int perf_event_release_kernel(struct perf_event *event)
>>  			 * this can't be the last reference.
>>  			 */
>>  			put_event(event);
>> +		} else {
>> +			var = &ctx->refcount;
>>  		}
>>  
>>  		mutex_unlock(&event->child_mutex);
>>  		mutex_unlock(&ctx->mutex);
>>  		put_ctx(ctx);
>> +
>> +		if (var) {
>> +			/*
>> +			 * If perf_event_free_task() has deleted all events from the
>> +			 * ctx while the child_mutex got released above, make sure to
>> +			 * notify about the preceding put_ctx().
>> +			 */
>> +			smp_mb(); /* pairs with wait_var_event() */
>> +			wake_up_var(var);
>> +		}
>>  		goto again;
>>  	}
>>  	mutex_unlock(&event->child_mutex);
> 
> I was a bit worrited that we're doing the wakeup with the event->child_mutex
> held; 

Actually the event->child_mutex has been released before doing the wakeup.


AFAICT that looks to be safe, but I'm not a scheduler expert.
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.

Thanks!

> 
>> -- 
>> 2.25.1
>>

