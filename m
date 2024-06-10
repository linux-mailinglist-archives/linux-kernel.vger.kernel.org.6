Return-Path: <linux-kernel+bounces-207838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B2901CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE511C21BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2E6F30D;
	Mon, 10 Jun 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUirGyiP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052F4D8BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007776; cv=none; b=FF5NRBGulZyqgrX/7UKRw7YGPk5ZCjQdAUivgDVszb2rDogIrqsZcOCGtyHhvmrEeE5dVpy1GKNbuByAwB1TpSB1xNvClMNZgMlQ+btPbhP1uXgyKFMZTwpCXG3rufyxguJvV4JfUz6JUEJO4Jna6h4a0LapnInT5mcKRNIaUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007776; c=relaxed/simple;
	bh=hEBukUBlcmDWfYdPsb5ySeXNcf/nzndX3LGPcIab4XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGcYME/4YmsbMDOOY0iBbKIA+cr4HCVSzatxO8ZbNg3MY8oqrKuuWQcsLaQteLA8CrR4cR/qjyu+OU3mnCD7HGw8Eotsa8JYd5ir4bXyuB41Z5AKoQ0tqB6Rg9CajeEiMBWQD1YVU/NE7tHRmh/toE3jdqLN5IjDrwk92Q1tcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUirGyiP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718007774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uQm94nL2wcwwj4Yok2tcIqgLd6gdn6Bo1KbQpN6pxO4=;
	b=fUirGyiPJUe5H7hBq96F67l8d1L7C4QTL0wUI4mBADjaan5K73wYqISPqHgdm0E2gHVaGg
	CllXUpXvq7Vf7BBD/nY1jBK5Lkj1yxB+6uJBTC+pWxfIC60cdT+xudPSsso8GDJei307xm
	tGXruz6nW26vcci42Qxi4otYOvJutTk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-q9P2er48MjqfalDM4RINtA-1; Mon, 10 Jun 2024 04:22:52 -0400
X-MC-Unique: q9P2er48MjqfalDM4RINtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42181c64596so6464985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718007771; x=1718612571;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uQm94nL2wcwwj4Yok2tcIqgLd6gdn6Bo1KbQpN6pxO4=;
        b=ANyilXV9kozKXOQdlBRqIX9FVqp7Zwz4H/N/Y9K07HFNhFrAfN+wv73vdXEc3l/YFt
         TFISRN7AoeTUBOp/uUWSqsba01+TlSi52wLzlIBKLSe59xUIDORZH+b8DUm0EQ/jUf0A
         KS9R+STV2pIgaK4LAZWDZDTDdy3rGXORWqFuE1t9tBNm5lGlafVWxMUFC66+OIVbFjV4
         mBQJ4Vm0Xv5CuT4aM2MeA3MASMZQI2xlqMBqCGT9XjoVvz7R4O1tadZZqXWDCZPbm6m0
         HR3g/XwTZS8l5cI/HT5e69Hucd9rntAevyZ81s0thnR5mhujNNPPJP1SGnuEGCsgCCGQ
         Wo0Q==
X-Gm-Message-State: AOJu0Yw4lBqQg/tw8SH1SOarJrWFs8Kr8zoPt2BXLPL9aKiUwWNXBguT
	fjD9IklRue1hhUQiN3Pw+mDmnLfGNP6ud4F03P4DKMGWQrvtXljcJn2CBn7yY2vOQX04FxYbEKM
	Lv7ITrGNz4y/EcpRQR0M8tM7MWPaErC06aY3vnGdTycmshtPWhCveEJqRa5qDpw==
X-Received: by 2002:a05:600c:4fc2:b0:421:f73e:f8f9 with SMTP id 5b1f17b1804b1-421f73efc1cmr7437415e9.20.1718007771216;
        Mon, 10 Jun 2024 01:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfUoeL/w8zp+aKFdBRrJU7RWMxen1rSihCIKXIWfSKhVR/jt2hqJ8auH9cttn9H6Jhkm0Pcg==
X-Received: by 2002:a05:600c:4fc2:b0:421:f73e:f8f9 with SMTP id 5b1f17b1804b1-421f73efc1cmr7437225e9.20.1718007770661;
        Mon, 10 Jun 2024 01:22:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66d0esm10333805f8f.51.2024.06.10.01.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:22:50 -0700 (PDT)
Message-ID: <99073d55-5b18-4ed2-b860-8c09e056f585@redhat.com>
Date: Mon, 10 Jun 2024 10:22:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
 <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmZ1x6QQYPFSOd7O@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 05:40, Oscar Salvador wrote:
> On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>> It looks rather weird that totalhigh_pages() returns an
>> "unsigned long" but nr_free_highpages() returns an "unsigned int".
>>
>> Let's return an "unsigned long" from nr_free_highpages() to be
>> consistent.
>>
>> While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>> totalhigh_pages() implementation, to make these look alike as well.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> ...
>> -static inline unsigned int nr_free_highpages(void) { return 0; }
>> -static inline unsigned long totalhigh_pages(void) { return 0UL; }
>> +static inline unsigned long nr_free_highpages(void) { return 0; }
>> +static inline unsigned long totalhigh_pages(void) { return 0; }
> 
> Although I doubt it has any consequences, I would just leave them both with UL,
> so the return type is consistent with what we are returning.

These suffixes are only required when using constants that would not fit
into the native (int) type, or converting from that native (int) type to
something else automatically by the compiler would mess things up (for example,
undesired sign extension). For 0 that is certainly impossible :)


That's also the reason why in include/linux we now have:

t14s: ~/git/linux/include/linux $ git grep "return 0UL;"
skbuff.h:       return 0UL;
uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }
t14s: ~/git/linux/include/linux $ git grep "0UL;"
bitmap.h:               *dst = ~0UL;
dax.h:          return ~0UL;
mtd/map.h:                      r.x[i] = ~0UL;
netfilter.h:    return ((ul1[0] ^ ul2[0]) | (ul1[1] ^ ul2[1])) == 0UL;
skbuff.h:       return 0UL;
uaccess.h:static inline unsigned long user_access_save(void) { return 0UL; }


... compared to a long list if "unsigned long" functions that simply "return 0;"


So I prefer to just drop it.

Thanks!

-- 
Cheers,

David / dhildenb


