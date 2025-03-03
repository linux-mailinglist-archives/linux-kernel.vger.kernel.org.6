Return-Path: <linux-kernel+bounces-542726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E6A4CCEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E74173507
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E5218589;
	Mon,  3 Mar 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g78RH4U9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13D1E883E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035005; cv=none; b=q4Gx1uulveWg3SJMsrHfI2uXpH3F98uABoe+GvuWBf7w6zMp0fMtBHVnBddhvdtAn/pFWdXK0nQUD77qd5ShyM9IFPZURowDJEUz7xSVEiRe21QqnPUir04XH8flVsULX0xsojFpP3CP5rJ+30ZPK20aAuts11+XF5p5mXSRxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035005; c=relaxed/simple;
	bh=dzZZy9CLhXbbuQEcuPEQWOL+jqJ2l5+arQTW6Ot2USA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDgS+6rzpQtqGk2wZYHXw2OUIpWXWwKeH/6iaa0m33zrQj/t1ZWNIaOATcwGCtEQyD81VbwJZUonSeQ31+lOMzYOkYMWkqKiBc53nXJDKXxKmC9K6CLQKCDV6xNjx+tX0pZmkxY7517gj/rfxSj/j1cv9s7loaOdhoRB2+LS9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g78RH4U9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741035003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s3UFw8zZh78DSBIAsLxm4HJo4B4IGO+D4hmJAbQibqE=;
	b=g78RH4U9R92+I6hsT65E1r+pV8VaPHXUtzINq4MGDOcT74KJUJ3AujfBTbsj1YuCBWOF3+
	6bwVim/NVi3FKRQhGsHTY8mSfthtB6uZ1xutkr3f+dvUL9LXD4ZuMB0mHYhGwecAV0M95S
	J05DNRdBOgJW+HTNnEhJlbPERxm0MEY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-wVQO8tC3Pam7UTwvusOfrA-1; Mon, 03 Mar 2025 15:49:51 -0500
X-MC-Unique: wVQO8tC3Pam7UTwvusOfrA-1
X-Mimecast-MFC-AGG-ID: wVQO8tC3Pam7UTwvusOfrA_1741034990
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e27150dbso4617139f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034990; x=1741639790;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3UFw8zZh78DSBIAsLxm4HJo4B4IGO+D4hmJAbQibqE=;
        b=nEMfTPeeTAwtl1hsme73jJUZCR7YIjyKX6fN5E3TAwdT5dzaPnZsl6wuXYNuNa3mmI
         +YLW7iiV01fo3O6CTdIYLJrSQCCEjB9PXThxDKymb9Kw/2EOMK37YG9FUVUgefny1Tqe
         n8OHbe4dmF5efG/2Gi6aHXO9doHnJQARA2yWU6DKd5J0XtbFWqi55lutCRNA+2+MDRtG
         JNYJOjq7k/QRWv7QUepWPQS5nzqcmaoVz2FHHUbtdfG5b7cZMnOYb1FdA6s33Zoolxv2
         FgMZnhJxdJGGDVIWiYnjl3LubstiOBkTxJDbFO5KS6ZPzmug0vi679Bh7fdfBoK2Y4Ks
         SILw==
X-Forwarded-Encrypted: i=1; AJvYcCXAbQKJR/Cq2ur8rE0+t1Vcjv3YDxc8Y+gv14wxDUj9AWtVpAIhNVat4SywANe2bpc6c7BZhu/ldtvSxmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHfh6ePDUBEwYkmUdkyfSUPf8oxrR5bH9+Tx3hBdPfM0wD1ZH
	jVQqh5Tn/e2sHv5qpFYodmM6PB7BD2r6L7ZJKp50FbE0kjE7aK4vbLvlMOKac2bQWgvlRtlcz8O
	cnc4fdlBbkkmg1LqOoPbUI5NgjAWq54d+Z0naPSU6f40kAG4kkXxnmFF42EB6aw==
X-Gm-Gg: ASbGncsGBWs7iMum15npFWxIKWRJ7/aEpytnyC2jEo3Hw+UdcOSS6oKfq3xyh/IaKaH
	wNDmEZTr6qjwX8ZCDoE/dGVUAASEGdrrck9LUT6iqNGSbzbEqGFRlxG2q4743Yx+vfkE7zVu5pr
	ahTmMerc37XGfwEPWkDHIP11vJeUJqTynPVyRRBbTFQLkHr1hv1Ab9NZ70X5voWboGRItK/tefm
	gBTh4fJYmnA+4Kpbz6/dsqlc7/RIyOR4Juyo8m/0Gls8qk+u3V9Ns+dP/u+uyAFJJnXQt/S/xEc
	ajxuRYy4HX+xibR1bgEro31L/fs1MqbD1RPxBRx/xNbBhp07QgS/JNf9HsvPKqQ2jvZeKsHC8S+
	ljb3EzHiDxnlmZ36nsfvpU1ZB6WFhGUY9wpIAa3UG/2E=
X-Received: by 2002:a05:6000:401f:b0:38d:d664:67d8 with SMTP id ffacd0b85a97d-390ec7c6738mr14004765f8f.11.1741034990470;
        Mon, 03 Mar 2025 12:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX0xcMXIts61Om7/SpehlApV/d450ZAX3Mj0Pgb9lO92rYVarLhdnuB8e8Fr5ctA5HmrVL1Q==
X-Received: by 2002:a05:6000:401f:b0:38d:d664:67d8 with SMTP id ffacd0b85a97d-390ec7c6738mr14004752f8f.11.1741034990099;
        Mon, 03 Mar 2025 12:49:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm15635940f8f.91.2025.03.03.12.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 12:49:49 -0800 (PST)
Message-ID: <8cae1e56-239f-4f67-a18c-b4f4d09f40d0@redhat.com>
Date: Mon, 3 Mar 2025 21:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
 <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 21:01, Mathieu Desnoyers wrote:
> On 2025-02-28 17:32, Peter Xu wrote:
>> On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
>>> On 2025-02-28 11:32, Peter Xu wrote:
>>>> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>>>>> For the VM use-case, I wonder if we could just add a userfaultfd
>>>>> "COW" event that would notify userspace when a COW happens ?
>>>>
>>>> I don't know what's the best for KSM and how well this will work, but we
>>>> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
>>>>
>>>> https://man7.org/linux/man-pages/man2/userfaultfd.2.html
>>>
>>> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
>>> resulting from a mmap mapping, but returns EINVAL if I pass a
>>> page-aligned address which sits within a private file mapping
>>> (e.g. executable data).
>>
>> Yes, so far sync traps only supports RAM-based file systems, or anonymous.
>> Generic private file mappings (that stores executables and libraries) are
>> not yet supported.
>>
>>>
>>> Also, I notice that do_wp_page() only calls handle_userfault
>>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>>> set.
>>
>> AFAICT that's expected, unshare should only be set on reads, never writes.
>> So uffd-wp shouldn't trap any of those.
>>
>>>
>>> AFAIU, as it stands now userfaultfd would not help tracking COW faults
>>> caused by stores to private file mappings. Am I missing something ?
>>
>> I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should work on
>> most mappings.  That one is async, though, so more like soft-dirty.  It
>> might be doable to try making it sync too without a lot of changes based on
>> how async tracking works.
> 
> I'm looking more closely at admin-guide/mm/pagemap.rst and it appears to
> be a good fit. Here is what I have in mind to replace the ksmd scanning
> thread for the VM use-case by a purely user-space driven scanning:
> 
> Within qemu or similar user-space process:
> 
> 1) Track guest memory with the userfaultfd UFFD_FEATURE_WP_ASYNC feature and
>      UFFDIO_REGISTER_MODE_WP mode.
> 
> 2) Protect user-space memory with the PAGEMAP_SCAN ioctl PM_SCAN_WP_MATCHING flag
>      to detect memory which stays invariant for a long time.
> 
> 3) Use the PAGEMAP_SCAN ioctl with PAGE_IS_WRITTEN to detect which pages are written to.
>      Keep track of memory which is frequently modified, so it can be left alone and
>      not write-protected nor merged anymore.
> 
> 4) Whenever pages stay invariant for a given lapse of time, merge them with the new
>      madvise(2) KSM_MERGE behavior.
> 
> Let me know if that makes sense.

Note that one of the strengths of ksm in the kernel right now is that we 
write-protect + try-deduplicate only when we are fairly sure that we can 
deduplicate (unstable tree), and that the interaction with THPs / large 
folios is fairly well thought-through.

Also note that, just because data hasn't been written in some time 
interval, doesn't mean that it should be deduplicated and result in CoW 
on next write access.

One probably would have to mimic what the KSM implementation in the 
kernel does, and built something like the unstable tree, to find 
candidates where we can actually deduplciate. Then, have a way to 
not-deduplicate if the content changed.

-- 
Cheers,

David / dhildenb


