Return-Path: <linux-kernel+bounces-542325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FBA4C888
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74390189A04C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673C238154;
	Mon,  3 Mar 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/oHpa6E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1551218589
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019803; cv=none; b=VqjSvOExvBsefNhdyuzKCuM3KuDFc1tqEVTBbQmuWkRicInyvsZnzD4KgDEwzcqQIXcCgBLc8lVg00YQ5OeRR2rYAvVXLOFbJNKjYgLbmu+4MkPTo8wk/Rz6hUZoLxFO0ZRxDsUBSE/meJfv7pARyuzUE/llOG2SFspZrpFxg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019803; c=relaxed/simple;
	bh=Fc2kUAM6s5SaGDhGwwKJILNPy5IjQwKqRkdV3RlftTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDJDJ/YJCZeRKgSvrv03q0EE2k88ATYJBgrhzRsJnN6XHAYq4fV8pUJqFd8ejF55G8/i3oYpVjvE5RUnWMKTARa+CE4COJ0D5zuvpRt/jzTQtv5M6MUyBiczU+F+epN0A8Fq1c47HmE42Nu3Ivmih/i+BEeJjWofzlXzEMw7maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/oHpa6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2LrCtkoyU78xagoZzZJ6iLBDRUKzV46lGVRqOJ5f45E=;
	b=a/oHpa6EU0tNQSnsuc6ldMRTdFd8ANwxueS1/Z/c4jOotOrS1wHdz9ishWVhvhUj1HP/iT
	GPflz6hxkQqfQvPRccF2uN+RKLAaKlbaRSBC1Gb0uYpUFoEBuE9p8SN3mlckj+NT75wPaC
	5r5Og6aQu4d4DyFJ+hszom6/WyuK3VQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Rk9ogz3VPrSSAJ--fg7dsQ-1; Mon, 03 Mar 2025 11:36:29 -0500
X-MC-Unique: Rk9ogz3VPrSSAJ--fg7dsQ-1
X-Mimecast-MFC-AGG-ID: Rk9ogz3VPrSSAJ--fg7dsQ_1741019788
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso34157925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019788; x=1741624588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LrCtkoyU78xagoZzZJ6iLBDRUKzV46lGVRqOJ5f45E=;
        b=BjOLPPtGxpkSz5c/+WoIlkZ9PbnZx9aUR2uljywV+N+dvQP4Ya3ftFjHREeznGZkON
         ztRb+48EPFPqrbHBIK9WLVeophQtGD6o/+U+wHO1fXjIYKHMkQpOZ5RmV7aAOoXKZaJd
         6Cod9VwNmfCUvgTJ/pff+CrDHnMfeaSXauqmUrZYYBNhx6Mg8/CpEAT+/fmRXlOl9+eF
         Canu2IZmyv8z5ekwiS5t44vaxy/nlQtRgUNarsDQLhF2c9bKWpOteuHAq0ulgAajJvTt
         d1DPXXup3SdGmrOsbgCDbIslUE+XEDPkMlAXkZ79oYohJHe9m6Z251fMsktKs3GSD2+n
         ZKeg==
X-Forwarded-Encrypted: i=1; AJvYcCX+CCniq26MHWI4Eyds5bqpe/cA6bRzI7TYYTugGryR7WWyiYp0b61VXY0c4uwzsE78H5YTcbMML8/YdFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvNh+1cKKpV4VDPVh67gZQBvsmRE6anpTkoebYE9/giGcCU91
	l8nVVJdLcX5Ci0FuypJIvPm6DyB5cDug/n7q67TvLrRnCVLF6aY/f7N8J13KXAkVzC/YsLcWIeZ
	8/3mxSjF+Oq0PbkVXErbhJ/U9hyqWga2bEIo50A0iXL2ssBNP1pylFAuTlljcSg==
X-Gm-Gg: ASbGncv8RpkmRr11VDyWFbAj8znfpfKhJ1RVX/NWZVDYSn7epaxEiKwM5wDYJbodqV1
	3JDXMzsYUfJkCOlbpdeR20nMH2vdSD4CkENU6DqJjJ7MR646gtwqpOu5QlK/slgaX6YoDcD2Ua4
	kMLR20AN4/up6OZXaBMBEBoQ9AbXAa7PxErlOp9U7wz6Gxbcu4aSra3/gSGCoVDtxPbauPtPva7
	bKv/ZE1HT3eZQZusgO47bp9w+fZJr7gTyfoUpazP0JZcLqRtH0H9/bqPCcZmbdsbG15LvHFtKy/
	k1E/kG4oj6tgQSyX8/ornQrtgTv4EEnXXHC4kgJhF742Zyni4w3wzGwP1p9+hLcYb9GkWlqXuH+
	6QMK7Xqd/+ou6TRu/pxdGO4GO4t31OIxARSdCiwU+hdg=
X-Received: by 2002:a7b:c450:0:b0:43b:ae66:bc6e with SMTP id 5b1f17b1804b1-43bae66bc89mr76908195e9.20.1741019787882;
        Mon, 03 Mar 2025 08:36:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgAIQQ8uuODxNulw67VXymJ0smhyAOt71cxnSEGmCl7Do/gGQm8YZtMDueL4E5QXlI4EqDpg==
X-Received: by 2002:a7b:c450:0:b0:43b:ae66:bc6e with SMTP id 5b1f17b1804b1-43bae66bc89mr76907975e9.20.1741019787567;
        Mon, 03 Mar 2025 08:36:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2edf84sm52002545e9.40.2025.03.03.08.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:36:26 -0800 (PST)
Message-ID: <c35cf981-3530-4496-8400-912f230cfd06@redhat.com>
Date: Mon, 3 Mar 2025 17:36:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Peter Xu <peterx@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <e14516c2-bd7c-4bf1-b2af-314d23d8f59a@efficios.com>
 <Z8XEZsZ2LZfqwfhu@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8XEZsZ2LZfqwfhu@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 16:01, Peter Xu wrote:
> On Sat, Mar 01, 2025 at 10:44:22AM -0500, Mathieu Desnoyers wrote:
>>>> Also, I notice that do_wp_page() only calls handle_userfault
>>>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>>>> set.
>>>
>>> AFAICT that's expected, unshare should only be set on reads, never writes.
>>> So uffd-wp shouldn't trap any of those.
>>
>> I'm confused by your comment. I thought unshare only applies to
>> *write* faults. What am I missing ?
> 
> The major path so far to set unshare is here in GUP (ignoring two corner
> cases used in either s390 and ksm):

"unshare" fault, in contrast to a write fault, will not turn the PTE 
writable.

That's why it does not trigger userfaultfd-wp: there is no write access, 
write-protection is left unchanged.

-- 
Cheers,

David / dhildenb


