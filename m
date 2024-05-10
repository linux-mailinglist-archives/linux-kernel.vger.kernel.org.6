Return-Path: <linux-kernel+bounces-175516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C78C20A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBAF282904
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F675165FB5;
	Fri, 10 May 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHBlixpG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E715F3F4
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332566; cv=none; b=Dvo85f/0SPzF1Cz+b58Gsgdod6gQqte2jYQjojds2D7XfHoiZcFXQ5xZla6y7G2KZfC3d3tnC7AEADVvWMTrR+ZxdyRKTkmW783dVPuHYicB+mslVW1Hvclve8kYqO4emPVZKrZ50pZdwMD4XB2veaXqq/V6TQVn2jVmDi5zdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332566; c=relaxed/simple;
	bh=HWu44pF+DLC7+OfJU4KJn5l5wLlFFEdPfIVbdoQIhpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiiwMEArKI3JW/PNeWd0DKeAF1g3JbI9da+JVzxeZbDIKj7K/3x3wVkn/+Ae0hM+h4BbdpY1GD1RMltkR0ArGCBJC+IEAvBgwv/vFazJjWe00vB6Ijviq2P+NoIT9xJ2HY1CgITxaJayAuPj/LU1JbiF63uTzRX/dP8gPPQ9h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHBlixpG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715332564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CGAYugjQIzZh8nENjyz8O6qgSZSL8G5H0JtkpNkkeyU=;
	b=XHBlixpGxwCk2bSKnl4h7J8Cq1ro4T8Yg6LwwDBaRn325hzucHVD9f9gQ7c2P8VrLW0+rZ
	HMNo3uBefGWXupg1bS802/SOmkLq9Dw+N6ZSDvh6Ctkm4vn8K59ne/FnNPzpQATOrQKQY4
	1b9RRQUN689ovamkKWllaxamvjG7PPk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-p-MI4YVJNKGdbm9FSYawEA-1; Fri, 10 May 2024 05:16:02 -0400
X-MC-Unique: p-MI4YVJNKGdbm9FSYawEA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e21d6edfe9so15160881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332561; x=1715937361;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGAYugjQIzZh8nENjyz8O6qgSZSL8G5H0JtkpNkkeyU=;
        b=iapYJazvuwAJOsg3NZ7CmCUpYzPx80DJ1lGlU50d4kfieZlnIO/zhqBZS8N6Zy435i
         LyiPSvtnSDEz0Ngyiyf9kh4rWXJj2OH1p7N+97U2oRlSzETKoYYj2mFuQc/EuC3VNskj
         gfIwIQ0a4XRXeSpvqXxvUVS7RPY9CZTXOjQ7dUhfv+rmqA7wDGPIZtIpEmLJPQeXWlcP
         uxM1kZIyEXYT2CxqZtARhlmyu1f970OtsTXxXILrFDIATGuwbHF0z/ub+jpjRDKGC+vD
         zNJfInB2spLF8NYSgAVEDawMuX32uzXDpatNn8LbqGMv060LPMlBNYoBFL75Shxuo0OA
         RixQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYWnkODumiINgFADcqVdlnqE8M2zbYqR4x/lGyAwFNoqhL4zRbQk9v/oIjZUaZPCJT+XNnH0yWmvdYp8GyHQu8au9tw9LIUpbnQ6PO
X-Gm-Message-State: AOJu0YwI23DcagY1o/9vR4SWS0lV+hOAE05VKs3zfjSEgqaVGQjKi9YF
	DTWY2CHG2KLmxCxJSqPftp/mzYOTuWeEBT+9mlFxTQ0VFcFJ/ebv+ROBF7KE+sCCNR56MvVfU2N
	Fh1E3HneLX9l5vIgfKFXpHkkSrvzrRNDhxDfb9RCjq2qMeKxlkeOBdSXKXt5TjQ==
X-Received: by 2002:a2e:9b4e:0:b0:2e1:bb65:8306 with SMTP id 38308e7fff4ca-2e5204b1d89mr11927611fa.44.1715332561074;
        Fri, 10 May 2024 02:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzdm1OBnUiNZetvy0ZrGTlWSq2mPd1L2oiERSDerUIW8BnOEBdFB5c1cgyWig2lszR5VO/bQ==
X-Received: by 2002:a2e:9b4e:0:b0:2e1:bb65:8306 with SMTP id 38308e7fff4ca-2e5204b1d89mr11927401fa.44.1715332560495;
        Fri, 10 May 2024 02:16:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:2b00:9c9f:9357:3f4c:5358? (p200300cbc7102b009c9f93573f4c5358.dip0.t-ipconnect.de. [2003:cb:c710:2b00:9c9f:9357:3f4c:5358])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce7464sm57231675e9.23.2024.05.10.02.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:16:00 -0700 (PDT)
Message-ID: <c36689df-cfad-46f5-835e-54073b6454a4@redhat.com>
Date: Fri, 10 May 2024 11:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 linux-mm@kvack.org
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home> <Zjyt-nX3el5nnDPm@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zjyt-nX3el5nnDPm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.24 13:05, Vincent Donnefort wrote:
> On Tue, May 07, 2024 at 10:34:02PM -0400, Steven Rostedt wrote:
>> On Tue, 30 Apr 2024 12:13:51 +0100
>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>
>>> +#ifdef CONFIG_MMU
>>> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>>> +			struct vm_area_struct *vma)
>>> +{
>>> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
>>> +	unsigned int subbuf_pages, subbuf_order;
>>> +	struct page **pages;
>>> +	int p = 0, s = 0;
>>> +	int err;
>>> +
>>> +	/* Refuse MP_PRIVATE or writable mappings */
>>> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
>>> +	    !(vma->vm_flags & VM_MAYSHARE))
>>> +		return -EPERM;
>>> +
>>> +	/*
>>> +	 * Make sure the mapping cannot become writable later. Also tell the VM
>>> +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
>>> +	 * prevent migration, GUP and dump (VM_IO).
>>> +	 */
>>> +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
>>
>> Do we really need the VM_IO?
>>
>> When testing this in gdb, I would get:
>>
>> (gdb) p tmap->map->subbuf_size
>> Cannot access memory at address 0x7ffff7fc2008
>>
>> It appears that you can't ptrace IO memory. When I removed that flag,
>> gdb has no problem reading that memory.
> 
> Yeah, VM_IO indeed implies DONTDUMP. VM_IO was part of Linus recommendations.

Yes, the VM should recognize that memory to some degree as being special 
already due to VM_MIXEDMAP and VM_DONTEXPAND.

#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)

So any of these flag achieve that (e.g., mlock_fixup() checks 
VM_SPECIAL). KSM similarly skips VM_DONTEXPAND and VM_MIXEDMAP (likely 
we should be using VM_SPECIAL in vma_ksm_compatible()). Not sure about 
page migration, likely its fine.

Thinking about MADV_DONTNEED, I can spot in 
madvise_dontneed_free_valid_vma() only that we disallow primarily VM_PFNMAP.

.. I assume if user space MADV_DONTNEED's some pages we'll simply get a 
page fault later on access that will SIGBUS, handling that gracefully 
(we should double-check!).


> But perhaps, VM_DONTEXPAND and MIXEDMAP (implicitely set by vm_insert_pages) are
> enough protection?

Do we want to dump these pages? VM_DONTDUMP might be reasonabe then.

> 
> I don't see how anything could use GUP there and as David pointed-out on the
> previous version, it doesn't event prevent the GUP-fast path.

Yes, GUP-fast would still have worked under some conditions.

-- 
Cheers,

David / dhildenb


