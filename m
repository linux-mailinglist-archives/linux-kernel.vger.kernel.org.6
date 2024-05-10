Return-Path: <linux-kernel+bounces-175863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582E98C2655
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD7285307
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810917082F;
	Fri, 10 May 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COolcQO3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240617082E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349980; cv=none; b=QJIMJjF1ojpwZ9xcFHIQlhdMNcY2VYAIJ7R4Q+NqrNr7ug++kpOkgw72V+jxPmc4stl17wFOsPD9WE9Wdh4rRHCMwHKNTJNvyyT8v8R4MsnuwYC7qdtOYltRdethIXTu+eayxAC63r7WuJ622goaNjS5jCEIlEH0H5Z7f/QscLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349980; c=relaxed/simple;
	bh=8F3nLxuyj5sILE69mGYhK4qtPRkt1IcpwTh03aeMgHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3g8VBemt+afz4qpZIe0yhlKmFfMLU8W3z2qIkl4MH0GKC9usNS1ekNSU9dmkB/pPNde/2Je9UdpFIiHzZs5fMMSaL+LF4NAusFM6/VfMncqyuwYraz+Axz3sRND1+5zHyFxEPC+lh1GiZT2cfh2t8tVwUM1STn5Xrprfw/DMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COolcQO3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715349977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TOV43Oh1Zd4ivgQx0nc3nJZYtSz/7Wqu4LsaQ8C3h4Q=;
	b=COolcQO3QWijHzvM4y40aHk9wNkf2u1Fu4czxT8yzHuNZ10q3m1aEcmXqkrfwZXEbkWl2P
	r5UQGXmsXpVyh6zcZU+5+xBcDjjDEMcCK98HzsZYOdc0gh5d8NU4zVaYSKs9O4EB2TyCt7
	jp2CvgGJqkTgrOuljN5B0DfqceGHWJQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-LF-9oQwnO0KYYufyL-wbXg-1; Fri, 10 May 2024 10:06:12 -0400
X-MC-Unique: LF-9oQwnO0KYYufyL-wbXg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e237935dfdso18048011fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349971; x=1715954771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOV43Oh1Zd4ivgQx0nc3nJZYtSz/7Wqu4LsaQ8C3h4Q=;
        b=whR9/bfqYN5bqJolv1DldO7Mto2SLXScS6UuptnTod18zJITB+lU3iq77gwFyhsIN1
         Fk9FybR5qCktJzKMhhz+h5Srkgn0IEu9COJF6LbboyiCBm7uWDqnzBIAA6BzwVvDecVT
         3rnIQiU4cKwxyeGplbLnEvIb5mn0/uzILxyeCjMhfAYz4Yq6Xl62pLO81t61w4BtoEDx
         uT98dF+aZiqw94B4qXEEnOtXzMh1WcQixLzPZxAo7mXyQqYzNxF7tLA6eHW9KA0ZPUV7
         7wrtJGn68nzqRbfKC38cTJ++oEfFkXmv116VjuaRewVIr9N/BS5bkGGggmJbvv7PKAd3
         F2RA==
X-Forwarded-Encrypted: i=1; AJvYcCVCW8ddsADrv/vKRroDqvOaXX5D8dYCsSn35l7rwTeW+DvB6pOWSOMCuFLYAT1PzvYnjusA1EAz0CUTr8mLC9BHnQc/ZqIMoiAH1nmj
X-Gm-Message-State: AOJu0YzHgu5tOp4jp9gKcEijlp7ZWxa4NEKM/Cs6PGunWAIVp3ectzgp
	Omn72dY6rxdcO+VptIdsdZjwmSvC3XdIGzAeH14MaWZXYblYFoALgKeWI/te1dN6X3UKyc3pKHJ
	tFDbAlKwspvtIBCJO6OEHSOcfDnOnRyOQtMtStQaaJmEwWoLsELuzt59H2mh1zA==
X-Received: by 2002:a2e:91cc:0:b0:2e5:a9e:30c1 with SMTP id 38308e7fff4ca-2e51ff4d5b0mr17225881fa.15.1715349971308;
        Fri, 10 May 2024 07:06:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDzKwVZUhYdD2pmtk4m3ieNSa6oKxl2MPPTUI2TJyfxgYPI74LUbwxwC/PyPcV1MFU6qhVg==
X-Received: by 2002:a2e:91cc:0:b0:2e5:a9e:30c1 with SMTP id 38308e7fff4ca-2e51ff4d5b0mr17225521fa.15.1715349970602;
        Fri, 10 May 2024 07:06:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:2b00:9c9f:9357:3f4c:5358? (p200300cbc7102b009c9f93573f4c5358.dip0.t-ipconnect.de. [2003:cb:c710:2b00:9c9f:9357:3f4c:5358])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9426sm64467785e9.25.2024.05.10.07.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 07:06:10 -0700 (PDT)
Message-ID: <1e98eecf-617e-49d5-a1c1-43895f050d9b@redhat.com>
Date: Fri, 10 May 2024 16:06:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-3-vdonnefort@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240510140435.3550353-3-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.05.24 16:04, Vincent Donnefort wrote:
> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>    ring_buffer_{map,unmap}()
> 
> And controls on the ring-buffer:
> 
>    ring_buffer_map_get_reader()  /* swap reader and head */
> 
> Mapping the ring-buffer also involves:
> 
>    A unique ID for each subbuf of the ring-buffer, currently they are
>    only identified through their in-kernel VA.
> 
>    A meta-page, where are stored ring-buffer statistics and a
>    description for the current reader
> 
> The linear mapping exposes the meta-page, and each subbuf of the
> ring-buffer, ordered following their unique ID, assigned during the
> first mapping.
> 
> Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> size will remain unmodified and the splice enabling functions will in
> reality simply memcpy the data instead of swapping subbufs.
> 
> CC: <linux-mm@kvack.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index dc5ae4e96aee..96d2140b471e 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -6,6 +6,8 @@
>   #include <linux/seq_file.h>
>   #include <linux/poll.h>
>   
> +#include <uapi/linux/trace_mmap.h>
> +
>   struct trace_buffer;
>   struct ring_buffer_iter;
>   
> @@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>   #define trace_rb_cpu_prepare	NULL
>   #endif
>   
> +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> +		    struct vm_area_struct *vma);
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>   #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> new file mode 100644
> index 000000000000..b682e9925539
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _TRACE_MMAP_H_
> +#define _TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct trace_buffer_meta - Ring-buffer Meta-page description
> + * @meta_page_size:	Size of this meta-page.
> + * @meta_struct_len:	Size of this structure.
> + * @subbuf_size:	Size of each sub-buffer.
> + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
> + * @reader.read:	Number of bytes read on the reader subbuf.
> + * @flags:		Placeholder for now, 0 until new features are supported.
> + * @entries:		Number of entries in the ring-buffer.
> + * @overrun:		Number of entries lost in the ring-buffer.
> + * @read:		Number of entries that have been read.
> + * @Reserved1:		Internal use only.
> + * @Reserved2:		Internal use only.
> + */
> +struct trace_buffer_meta {
> +	__u32		meta_page_size;
> +	__u32		meta_struct_len;
> +
> +	__u32		subbuf_size;
> +	__u32		nr_subbufs;
> +
> +	struct {
> +		__u64	lost_events;
> +		__u32	id;
> +		__u32	read;
> +	} reader;
> +
> +	__u64	flags;
> +
> +	__u64	entries;
> +	__u64	overrun;
> +	__u64	read;
> +
> +	__u64	Reserved1;
> +	__u64	Reserved2;
> +};
> +
> +#endif /* _TRACE_MMAP_H_ */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index cc9ebe593571..849f6942bb96 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -9,6 +9,7 @@
>   #include <linux/ring_buffer.h>
>   #include <linux/trace_clock.h>
>   #include <linux/sched/clock.h>
> +#include <linux/cacheflush.h>
>   #include <linux/trace_seq.h>
>   #include <linux/spinlock.h>
>   #include <linux/irq_work.h>
> @@ -26,6 +27,7 @@
>   #include <linux/list.h>
>   #include <linux/cpu.h>
>   #include <linux/oom.h>
> +#include <linux/mm.h>
>   
>   #include <asm/local64.h>
>   #include <asm/local.h>
> @@ -338,6 +340,7 @@ struct buffer_page {
>   	local_t		 entries;	/* entries on this page */
>   	unsigned long	 real_end;	/* real end of data */
>   	unsigned	 order;		/* order of the page */
> +	u32		 id;		/* ID for external mapping */
>   	struct buffer_data_page *page;	/* Actual data page */
>   };
>   
> @@ -484,6 +487,12 @@ struct ring_buffer_per_cpu {
>   	u64				read_stamp;
>   	/* pages removed since last reset */
>   	unsigned long			pages_removed;
> +
> +	unsigned int			mapped;
> +	struct mutex			mapping_lock;
> +	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
> +	struct trace_buffer_meta	*meta_page;
> +
>   	/* ring buffer pages to update, > 0 to add, < 0 to remove */
>   	long				nr_pages_to_update;
>   	struct list_head		new_pages; /* new pages to add */
> @@ -1599,6 +1608,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>   	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>   	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>   	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> +	mutex_init(&cpu_buffer->mapping_lock);
>   
>   	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>   			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -1789,8 +1799,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
>   	return buffer->time_stamp_abs;
>   }
>   
> -static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
> -
>   static inline unsigned long rb_page_entries(struct buffer_page *bpage)
>   {
>   	return local_read(&bpage->entries) & RB_WRITE_MASK;
> @@ -5211,6 +5219,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>   	page->read = 0;
>   }
>   
> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	meta->reader.read = cpu_buffer->reader_page->read;
> +	meta->reader.id = cpu_buffer->reader_page->id;
> +	meta->reader.lost_events = cpu_buffer->lost_events;
> +
> +	meta->entries = local_read(&cpu_buffer->entries);
> +	meta->overrun = local_read(&cpu_buffer->overrun);
> +	meta->read = cpu_buffer->read;
> +
> +	/* Some archs do not have data cache coherency between kernel and user-space */
> +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> +}
> +
>   static void
>   rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>   {
> @@ -5255,6 +5279,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>   	cpu_buffer->lost_events = 0;
>   	cpu_buffer->last_overrun = 0;
>   
> +	if (cpu_buffer->mapped)
> +		rb_update_meta_page(cpu_buffer);
> +
>   	rb_head_page_activate(cpu_buffer);
>   	cpu_buffer->pages_removed = 0;
>   }
> @@ -5469,6 +5496,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>   	cpu_buffer_a = buffer_a->buffers[cpu];
>   	cpu_buffer_b = buffer_b->buffers[cpu];
>   
> +	/* It's up to the callers to not try to swap mapped buffers */
> +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>   	/* At least make sure the two buffers are somewhat the same */
>   	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
>   		goto out;
> @@ -5733,7 +5766,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>   	 * Otherwise, we can simply swap the page with the one passed in.
>   	 */
>   	if (read || (len < (commit - read)) ||
> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> +	    cpu_buffer->mapped) {
>   		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>   		unsigned int rpos = read;
>   		unsigned int pos = 0;
> @@ -5956,6 +5990,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>   
>   		cpu_buffer = buffer->buffers[cpu];
>   
> +		if (cpu_buffer->mapped) {
> +			err = -EBUSY;
> +			goto error;
> +		}
> +
>   		/* Update the number of pages to match the new size */
>   		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
>   		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> @@ -6057,6 +6096,375 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>   }
>   EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
>   
> +static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct page *page;
> +
> +	if (cpu_buffer->meta_page)
> +		return 0;
> +
> +	page = alloc_page(GFP_USER | __GFP_ZERO);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	cpu_buffer->meta_page = page_to_virt(page);
> +
> +	return 0;
> +}
> +
> +static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
> +
> +	free_page(addr);
> +	cpu_buffer->meta_page = NULL;
> +}
> +
> +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> +				   unsigned long *subbuf_ids)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> +	struct buffer_page *first_subbuf, *subbuf;
> +	int id = 0;
> +
> +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> +	cpu_buffer->reader_page->id = id++;
> +
> +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> +	do {
> +		if (WARN_ON(id >= nr_subbufs))
> +			break;
> +
> +		subbuf_ids[id] = (unsigned long)subbuf->page;
> +		subbuf->id = id;
> +
> +		rb_inc_page(&subbuf);
> +		id++;
> +	} while (subbuf != first_subbuf);
> +
> +	/* install subbuf ID to kern VA translation */
> +	cpu_buffer->subbuf_ids = subbuf_ids;
> +
> +	meta->meta_page_size = PAGE_SIZE;
> +	meta->meta_struct_len = sizeof(*meta);
> +	meta->nr_subbufs = nr_subbufs;
> +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> +
> +	rb_update_meta_page(cpu_buffer);
> +}
> +
> +static struct ring_buffer_per_cpu *
> +rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return ERR_PTR(-EINVAL);
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (!cpu_buffer->mapped) {
> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return cpu_buffer;
> +}
> +
> +static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +}
> +
> +/*
> + * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
> + * to be set-up or torn-down.
> + */
> +static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
> +			       bool inc)
> +{
> +	unsigned long flags;
> +
> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> +
> +	if (inc && cpu_buffer->mapped == UINT_MAX)
> +		return -EBUSY;
> +
> +	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
> +		return -EINVAL;
> +
> +	mutex_lock(&cpu_buffer->buffer->mutex);
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	if (inc)
> +		cpu_buffer->mapped++;
> +	else
> +		cpu_buffer->mapped--;
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	mutex_unlock(&cpu_buffer->buffer->mutex);
> +
> +	return 0;
> +}
> +
> +/*
> + *   +--------------+  pgoff == 0
> + *   |   meta page  |
> + *   +--------------+  pgoff == 1
> + *   | subbuffer 0  |
> + *   |              |
> + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> + *   | subbuffer 1  |
> + *   |              |
> + *         ...
> + */
> +#ifdef CONFIG_MMU
> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> +			struct vm_area_struct *vma)
> +{
> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> +	unsigned int subbuf_pages, subbuf_order;
> +	struct page **pages;
> +	int p = 0, s = 0;
> +	int err;
> +
> +	/* Refuse MP_PRIVATE or writable mappings */
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +
> +	/*
> +	 * Make sure the mapping cannot become writable later. Also tell the VM
> +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND).

Coment a bit outdated.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


