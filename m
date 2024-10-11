Return-Path: <linux-kernel+bounces-361378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125399A76A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ED72850CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C92194A66;
	Fri, 11 Oct 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ffhr88EC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C111925B8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660017; cv=none; b=hO9xcpD7FI68lO0Bvk2OpKpQD4znL1SRkNT1k855V0Hf14xqcJ7SNC5x9rSxpoKqJJJnqKhM0Kc93IE2/MXEcVy2IttczxAw+LaFkyk/DZesKO7osBncU52r1XrO2f7i/UzqZ0zGfJYrOEc/IROH2oUmMWrD7ipt2oRuFg2Knl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660017; c=relaxed/simple;
	bh=QyyCDr+XDFpZPpcpRdBxw9m6INREx7DfUX0Go5hHUVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdTIo405E+GPV52SZn99C+9I74jjtkeY7ZplesNK6X8jaxHjqlJpbix75lvZMU5KCnf4eDtc2hDbAz0++oZkyvWXBI6T3nAE9zYQcAyYVSDsMqJt5mpf/heqQprhtRczu4Gc2V/cNDuLVlMNQ/OgpQrtwT/6P+bHxp6OkPQuuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ffhr88EC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a998a5ca499so304126566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728660014; x=1729264814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rs/Y9AH+EkVMh4yGKvg5xJ3wqArgRcUQv4x27SKzh7Y=;
        b=ffhr88EC+cj4EiLBEXG8BQoVLJO6Dmzd0UrMjnaKiKQh8X5QbaMbIcWOkJ4xxZlMT1
         t0bMJpODytO+kXaw5zW0enQPM5/nEwtpsv6q2ZkXySac4jspj3R1sZqo/FKEhakbGLsR
         5/xh1i0udt2KZHF1tiJVBqtt65PGxmTRJnR2aOS+L0RtL4sNhoHCfDBdmV9sGO+9g2KG
         IdUnacqTI3LzNJUxlqJRlT8tnogX5Yt3h4Jd4XfgMq0DRDNAq7WiZtHJJGUybx1M3RSP
         anLqEMgCkkql3EgR+304tjUqEaRqaeDQ6p04RGUB2nD8FBUypiLXdUxYylYpna8jy4xp
         5ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660014; x=1729264814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs/Y9AH+EkVMh4yGKvg5xJ3wqArgRcUQv4x27SKzh7Y=;
        b=KWuzKPULRypJrWd2A8Qrcs/2qJfzDG/uXecuvZp2cWpXtOr++b9evp4vH8e9EDN4Sh
         bskb8RNFDys0EcYREny2klnLsTv0sJluji77mHIGIh7/fFHO4SkXqzHp3jxBQDe38AGf
         Rcr2OxNoGfG82sjOP9BmPSUj6yZizrlBO0/zMrB4F5SNsKqt8n5RC54K2DN4Y/hBCxyD
         mbACzn2JOcnutTSqNsHYE7FolkQJWqYGYFp8yiMjoQfqaien56kDQtLQbrlQMlyu6xmS
         ZQSile4x5iJY/J8k9z377mvrLo0TlP/g/UJN9HaUR0yqMDLIAifOR/CY1ia0IrJm7O/C
         7nZQ==
X-Gm-Message-State: AOJu0Yz4UKkColjwgV99pRyXgG48RvsxVhzxdYuxX0gVdfwRfQeaKIZZ
	rXaelN0XmNjPVyJtTrzJ4DvEOZu6uSPz3DPpx5LWeF3MyTMHBYQU9W/599iKtH0=
X-Google-Smtp-Source: AGHT+IEwg6JHmLhq3E2hwmyCaEeQdGK/8NrPaDQ2Sn5iADWsJzSvQnJLhKo1wvW3EV8uZz/mEc/BpA==
X-Received: by 2002:a17:907:6ea2:b0:a86:799d:f8d1 with SMTP id a640c23a62f3a-a99e3e4487dmr2548466b.47.1728660013663;
        Fri, 11 Oct 2024 08:20:13 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c1ae4sm223016166b.129.2024.10.11.08.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 08:20:13 -0700 (PDT)
Message-ID: <84179edb-dba1-42fd-88a9-70d05d8915ec@suse.com>
Date: Fri, 11 Oct 2024 17:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241010195849.2f77cc3f@gandalf.local.home>
 <1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
 <20241011100132.456f903a@gandalf.local.home>
 <20241011104848.7f5b180b@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241011104848.7f5b180b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 16:48, Steven Rostedt wrote:
> On Fri, 11 Oct 2024 10:01:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> Sorry for not replying to your last comment on my patch, I was ill.
>>>
>>> The member ring_buffer_per_cpu.cnt is intended to be accessed under the
>>> reader_lock, same as the pages pointer which it is tied to, so this
>>> change shouldn't be strictly needed.
>>>   
>>
>> Right, but there was one location that the cnt was updated outside the
>> lock. The one I commented on. But instead of adding a lock around it, I
>> decided to just make it an atomic. Then there would be no need for the
>> lock. Hmm, it still needs a memory barrier though. At least a
>> smp_mb__after_atomic().
> 
> Hmm, I don't like how the update in ring_buffer_subbuf_order_set() is
> unprotected. I think this is the proper patch:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 696d422d5b35..0672df07b599 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6774,6 +6774,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	}
>  
>  	for_each_buffer_cpu(buffer, cpu) {
> +		unsigned long flags;
>  
>  		if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  			continue;
> @@ -6800,11 +6801,15 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  						     struct buffer_page, list);
>  		list_del_init(&cpu_buffer->reader_page->list);
>  
> +		/* Synchronize with rb_check_pages() */
> +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
>  		/* The cpu_buffer pages are a link list with no head */
>  		cpu_buffer->pages = cpu_buffer->new_pages.next;
>  		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
>  		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
>  		cpu_buffer->cnt++;
> +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
>  		/* Clear the new_pages list */
>  		INIT_LIST_HEAD(&cpu_buffer->new_pages);
> 
> Even though it's also protected by the buffer->mutex, I feel more
> comfortable with this.

Sorry, I missed context of your comment and that it is about
ring_buffer_subbuf_order_set().

I agree, I also noticed the missing locking in this function and it
looked to me as something that should be fixed. I happen to have
a somewhat more complex patch for it from a few months ago (pasted
below). I think I didn't send it to the list because I then noticed
other potential locking problems with the subbuf code, which I wanted to
examine more closely first.

-- 
Petr


From 359f5aa523bc27ca8600b4efae471eefc0514ce0 Mon Sep 17 00:00:00 2001
From: Petr Pavlu <petr.pavlu@suse.com>
Date: Tue, 16 Jul 2024 11:35:00 +0200
Subject: [PATCH] ring-buffer: Fix reader locking when changing the sub buffer
 order

The function ring_buffer_subbuf_order_set() updates each
ring_buffer_per_cpu and installs new sub buffers that match the requested
page order. This operation may be invoked concurrently with readers that
rely on some of the modified data, such as the head bit (RB_PAGE_HEAD), or
the ring_buffer_per_cpu.pages and reader_page pointers. However, no
exclusive access is acquired by ring_buffer_subbuf_order_set(). Modyfing
the mentioned data while a reader also operates on them can then result in
incorrect memory access and various crashes.

Fix the problem by taking the reader_lock when updating a specific
ring_buffer_per_cpu in ring_buffer_subbuf_order_set().

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/ring_buffer.c | 41 ++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4c24191fa47d..d324f4f9ab9d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6773,36 +6773,38 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+		struct buffer_data_page *old_free_data_page;
+		struct list_head old_pages;
+		unsigned long flags;
 
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
 		/* Clear the head bit to make the link list normal to read */
 		rb_head_page_deactivate(cpu_buffer);
 
-		/* Now walk the list and free all the old sub buffers */
-		list_for_each_entry_safe(bpage, tmp, cpu_buffer->pages, list) {
-			list_del_init(&bpage->list);
-			free_buffer_page(bpage);
-		}
-		/* The above loop stopped an the last page needing to be freed */
-		bpage = list_entry(cpu_buffer->pages, struct buffer_page, list);
-		free_buffer_page(bpage);
-
-		/* Free the current reader page */
-		free_buffer_page(cpu_buffer->reader_page);
+		/*
+		 * Collect buffers from the cpu_buffer pages list and the
+		 * reader_page on old_pages, so they can be freed later when not
+		 * under a spinlock. The pages list is a linked list with no
+		 * head, adding old_pages turns it into a regular list with
+		 * old_pages being the head.
+		 */
+		list_add(&old_pages, cpu_buffer->pages);
+		list_add(&cpu_buffer->reader_page->list, &old_pages);
 
 		/* One page was allocated for the reader page */
 		cpu_buffer->reader_page = list_entry(cpu_buffer->new_pages.next,
 						     struct buffer_page, list);
 		list_del_init(&cpu_buffer->reader_page->list);
 
-		/* The cpu_buffer pages are a link list with no head */
+		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
-		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
-		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
+		list_del(&cpu_buffer->new_pages);
 		cpu_buffer->cnt++;
 
 		/* Clear the new_pages list */
@@ -6815,11 +6817,20 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
-		free_pages((unsigned long)cpu_buffer->free_page, old_order);
+		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
 
 		rb_head_page_activate(cpu_buffer);
 
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+		/* Free old sub buffers */
+		list_for_each_entry_safe(bpage, tmp, &old_pages, list) {
+			list_del_init(&bpage->list);
+			free_buffer_page(bpage);
+		}
+		free_pages((unsigned long)old_free_data_page, old_order);
+
 		rb_check_pages(cpu_buffer);
 	}
 


