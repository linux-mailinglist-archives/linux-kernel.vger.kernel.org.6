Return-Path: <linux-kernel+bounces-343627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B7989D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0721F22A01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C59184528;
	Mon, 30 Sep 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKZqTW52"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B6181334
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686698; cv=none; b=HtNPuZ8+Shr6T7SBSdc27zQCzfcxpp/hk50vBpJ+1BI0dFjQfpEhywEAhP/PqoKEKitfZRUABsKoRubBoEUzqPZLBly+m62oE0hdEPRb+JPrEr9symIqYkCK/djzyAnJ/Yw0srnu09viViMx+6KS1Gaei3thdtjMS69QOlPmOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686698; c=relaxed/simple;
	bh=jiG+zd12v7M9QTJgIy9eY7/iFuv2pD3i9NmBIp2MQSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cwaf8PV1VAqBfQcDH7kCb5oxwa9VCupI2zPTnsacEJ1GkltSTa0/UczELQe1Rx5kgYU0OuxhtTcaFrxugwBbOqISMiLwIfzBj8wjFjiSm55/w5OxVq4Fr/IntoHQZkK8hexr/7EvWa3Kvf9C3TxiPZWI5hdNv99YkJWZE/ZoD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKZqTW52; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727686695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cf862QE3DJSwzt+WRGJivYd4bfR0GFwJXPFnH6kObYA=;
	b=OKZqTW52TYuNCqxGt7urTtbk5wiCpwb+LwsH9TxR1ES2Je63rLG0JrdP8+yX6Gc8Wb1OlP
	8i8d54uioPFWU0L6puU+clid8prmk5JUGzFAFKG3ziSYQIMVFnvkZ051b/AU88lh1t5YU0
	gPXKIy7wV0bZInEvQJtxGdMb5XtAdIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-N31Xb-zIM-CQDD3Als-MyA-1; Mon, 30 Sep 2024 04:58:13 -0400
X-MC-Unique: N31Xb-zIM-CQDD3Als-MyA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42e611963c2so31490985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686692; x=1728291492;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf862QE3DJSwzt+WRGJivYd4bfR0GFwJXPFnH6kObYA=;
        b=rmFpPO56hx7Cs49KN3+m6T0Y5Mmj7lznQ0Kxdwj69k/850OK1EgSaBCTVt/0NOYJBg
         xF9SDHZ/wK5UPEShR0IEvUnXSzsa9e/Nida2I5bMQg2qgflc8/DeVwLoXoziOSGHYHZA
         CwFmyzgcLtPspEe5rDI9L5PWXidiZfm5+iJTBnkBn/SdXlPmwE74rediXwlKSu4CqBT9
         Rmlgb1at7lpUisMps1EnUSzNbKugAk/lRO4pPNp7lziBtSo9Yol/3b012MAEBkeUGSl6
         nv2lsi1c+i4wv45q9IXhn1Igo832rxxj7FFcejqcrGhM9SXKIe0NOvrZrhv1Br54x9G2
         Fj8g==
X-Forwarded-Encrypted: i=1; AJvYcCW7YxiECM9JHnnaPRmB5vip9byB7t0MvaaClyXUTzWF9USDT0YlROV2RbWhspiFh0WT2ITq2zuFWCdU+Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1CtsOzjcJPESWdHSlDKAyqOaF/ASeUenqdX3eGokPbWQNgVO
	9rNrzZu7L1T9wai7DjTqhwhv4+6C3Fd9WnqvsHk3cScmSqoN1d1QPp/z5bZyYc+TaUEnezx6Wta
	odQsOakeMXgGAo0n0oHZyeSRuKSAp8zVPR8KphpdbbC3XRVnmMYHfK+YDWkIyQA==
X-Received: by 2002:a05:600c:1d97:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42f58464a07mr104400355e9.22.1727686691737;
        Mon, 30 Sep 2024 01:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp7HodyhYb64/Q8tTfraakrNR9kAN2Vct4EdIAZtddMLmLB6H999czvl8h40Q3FXFNlc8mPQ==
X-Received: by 2002:a05:600c:1d97:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42f58464a07mr104400035e9.22.1727686691353;
        Mon, 30 Sep 2024 01:58:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddfc9sm144410695e9.5.2024.09.30.01.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:58:10 -0700 (PDT)
Message-ID: <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
Date: Mon, 30 Sep 2024 10:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
To: Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, linux-coco@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20240930055112.344206-1-ying.huang@intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240930055112.344206-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.24 07:51, Huang Ying wrote:
> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> hot-added must be checked for compatibility by TDX.  This is currently
> implemented through memory hotplug notifiers for each memory_block.
> If a memory range which isn't TDX compatible is hot-added, for
> example, some CXL memory, the command line as follows,
> 
>    $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> 
> will report something like,
> 
>    bash: echo: write error: Operation not permitted
> 
> If pr_debug() is enabled, the error message like below will be shown
> in the kernel log,
> 
>    online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> 
> Both are too general to root cause the problem.  This will confuse
> users.  One solution is to print some error messages in the TDX memory
> hotplug notifier.  However, memory hotplug notifiers are called for
> each memory block, so this may lead to a large volume of messages in
> the kernel log if a large number of memory blocks are onlined with a
> script or automatically.  For example, the typical size of memory
> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> will be logged.

ratelimiting would likely help here a lot, but I agree that it is 
suboptimal.

> 
> Therefore, in this patch, the whole hot-adding memory range is checked
> for TDX compatibility through a newly added architecture specific
> function (arch_check_hotplug_memory_range()).  If rejected, the memory
> hot-adding will be aborted with a proper kernel log message.  Which
> looks like something as below,
> 
>    virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
 > > The target use case is to support CXL memory on TDX enabled systems.
> If the CXL memory isn't compatible with TDX, the whole CXL memory
> range hot-adding will be rejected.  While the CXL memory can still be
> used via devdax interface.

I'm curious, why can that memory be used through devdax but not through 
the buddy? I'm probably missing something important :)

> 
> This also makes the original TDX memory hotplug notifier useless, so
> delete it.

The online-notifier would even be too late when used with the 
memmap-on-memory feature I assume, as we might be touching that memory 
even before being able to call memory online notifiers.

One way to handle that would be to switch to the MEM_PREPARE_ONLINE 
notifier, but it's still called per-memory block.

Nothing jumped at me, so

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


