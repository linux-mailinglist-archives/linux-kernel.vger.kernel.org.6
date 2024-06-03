Return-Path: <linux-kernel+bounces-199413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B78D86E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D911C211C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1D135A7F;
	Mon,  3 Jun 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drTWvcZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83513440A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430768; cv=none; b=lmurdkUX2VwnuB1FNtg+YWFtDYPQEzWq9/QsibMLREjIzDjtZbn38IBIWz0QHa3kGeAQZ231rGVnpcvjRElE1RsOX3NZhWTv3pIJGllDVkvEL8gX4ijyD/kFHX6xl/vV6WUKWbLdvuwdTVwX/NiZiry40hvqr5LqxeLrzY7Hm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430768; c=relaxed/simple;
	bh=zYNxgr3mh86TTFviDHIf0to4jRAG5zs+1pwawyqvWWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQr7LLG+hyUbMawtfSnkJuCFLtW5YmUj0YljoJq40/sNOaG9Jr+TSCV8FE17nEzePJ3PHx1U6fAz4M79pcMzdNTzup19FtbP5xIEOXd6he39voRUzGepeAOdfuEKrozRhw4xibx4zRPg+//H2T74j9jPKWiXhaKg95vdzAc171A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drTWvcZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717430765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6YYOmc9J0jvCNTXsCieefmRf3VmfB99xriXTk6X1dRE=;
	b=drTWvcZrjew8XwprDv/qJnW+JaxZja6qaVMPSIp8khdHKe7yO22ITcgP5CSowooZO58JOE
	T/BVMzgaAXo/B5p1Qq5f6w0JBDRcdlVYbOuPGzHtkbbomwExb1OvlyVV5grzkgbrFmF6WT
	NAHcFG52KcVbW8RN/E3HOm6Yl8a2AHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-9tH_zdYfOBqpupsQVcWIAg-1; Mon, 03 Jun 2024 12:06:01 -0400
X-MC-Unique: 9tH_zdYfOBqpupsQVcWIAg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4212a921370so31952155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430761; x=1718035561;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YYOmc9J0jvCNTXsCieefmRf3VmfB99xriXTk6X1dRE=;
        b=TtwQyggsLP9rxN/FdPE0BA6V/Qi3zsyBFzNnkSmFlPBAeHDGf21Py+lfkqVgPVcQtW
         +ayEo2HpQnlkJQOAxnuoIUGFdhc1GrkosctSwVaGBzFP7IOdpt8eZBr8jLnK76VmLj9R
         Ivigri4Bd8QtXVBbNgeX/+uDgRB7xVaFX7Jn5vJav3Q4PrI5gZ8OrCfhTV7skJQWHzrg
         ey3zo7KpkrPPr0+WpPDZymghYS0jB2AxfKRx/1Af9gg74BPkvDQrt2QGC+JgoQvPv0MF
         2dl/ZvNdCfGiCFoFfdYZMtSke4l+JVAaY97w7/rub8CBTH489USJt58onyyLEAq0veFF
         YSDw==
X-Forwarded-Encrypted: i=1; AJvYcCW2HS7rcZD5DegNflGlliR+ye1h27vdhfYg4wugF00sZENl6q084ZTm3V1oNnVr6F2c5UM/QQroEUjcKchSkViNcBkeCvfdRm/Gd9FG
X-Gm-Message-State: AOJu0Yy9eFgopvvwc3r8KLVtU/02Gz3d+HVC8p+FHbFyvss/tIz70ysY
	XJDb0MHMkMMTWxD8EH7rVG7ZFEbVOl3Kw1AJ1VKq+i3HYJoGQeue2+uACHtcRlmQpa8nW0ZK/+J
	N1iOQfaAto3fd2m8gm0y+Bn2lJxWkJOnGn2sE6JNUXOZTEvElKS4RyJS3yfLY4A==
X-Received: by 2002:adf:f9d2:0:b0:354:f447:9f27 with SMTP id ffacd0b85a97d-35e0f325bd0mr8480532f8f.55.1717430760784;
        Mon, 03 Jun 2024 09:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnGVCU2M5Mi9wlZTX+o9uuWC8bZL+Zru5IKS3M/wNKQmcr9eS8/UrSZF4LiuclAxxxzzttlg==
X-Received: by 2002:adf:f9d2:0:b0:354:f447:9f27 with SMTP id ffacd0b85a97d-35e0f325bd0mr8480499f8f.55.1717430760307;
        Mon, 03 Jun 2024 09:06:00 -0700 (PDT)
Received: from ?IPV6:2a01:599:908:c963:af9b:c64c:dfd8:5999? ([2a01:599:908:c963:af9b:c64c:dfd8:5999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd066eb35sm9016009f8f.115.2024.06.03.09.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:05:59 -0700 (PDT)
Message-ID: <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
Date: Mon, 3 Jun 2024 18:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Dave Hansen <dave.hansen@intel.com>, Byungchul Park <byungchul@sk.com>
Cc: Byungchul Park <lkml.byungchul.park@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 akpm@linux-foundation.org, ying.huang@intel.com, vernhao@tencent.com,
 mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
 peterz@infradead.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 15:23, Dave Hansen wrote:
> On 6/3/24 02:35, Byungchul Park wrote:
> ...> In luf's point of view, the points where the deferred flush should be
>> performed are simply:
>>
>> 	1. when changing the vma maps, that might be luf'ed.
>> 	2. when updating data of the pages, that might be luf'ed.
> 
> It's simple, but the devil is in the details as always.
> 
>> All we need to do is to indentify the points:
>>
>> 	1. when changing the vma maps, that might be luf'ed.
>>
>> 	   a) mmap and munmap e.i. fault handler or unmap_region().
>> 	   b) permission to writable e.i. mprotect or fault handler.
>> 	   c) what I'm missing.
> 
> I'd say it even more generally: anything that installs a PTE which is
> inconsistent with the original PTE.  That, of course, includes writes.
> But it also includes crazy things that we do like uprobes.  Take a look
> at __replace_page().
> 
> I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
> there.  But it needs some really thorough review.
> 
> But the bigger concern is that, if there was a problem, I can't think of
> a systematic way to find it.

Fully agreed!

> 
>> 	2. when updating data of the pages, that might be luf'ed.
>>
>> 	   a) updating files through vfs e.g. file_end_write().
>> 	   b) updating files through writable maps e.i. 1-a) or 1-b).
>> 	   c) what I'm missing.
> 
> Filesystems or block devices that change content without a "write" from
> the local system.  Network filesystems and block devices come to mind.
> I honestly don't know what all the rules are around these, but they
> could certainly be troublesome.
> 
> There appear to be some interactions for NFS between file locking and
> page cache flushing.
> 
> But, stepping back ...
> 
> I'd honestly be a lot more comfortable if there was even a debugging LUF
> mode that enforced a rule that said:
> 
>    1. A LUF'd PTE can't be rewritten until after a luf_flush() occurs

I was playing with the idea of using a PTE marker. Then it's clear for 
munmap/mremap/page faults that there is an outstanding flush required. 
the alternative might be a VMA flag, but that's harder to actually 
enforce an invariant.

>    2. A LUF'd page's position in the page cache can't be replaced until
>       after a luf_flush()

That's the most tricky bit. I think these are the VFS concerns like

1) Page migration/reclaim ends up freeing the old page. TLB not flushed.
2) write() to the new page / write from other process to the new page
3) CPU reads stale content from old page

PTE markers can't handle that.

-- 
Cheers,

David / dhildenb


