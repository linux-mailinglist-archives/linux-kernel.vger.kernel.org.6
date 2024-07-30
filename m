Return-Path: <linux-kernel+bounces-268165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4876194210D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0BAB25B08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACE418CC07;
	Tue, 30 Jul 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFKKoCgi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F4149C41
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369001; cv=none; b=IHuJ/hTwSPEM03ljHLaidjoxROBs4QzjlouiOkJYoriK3hkYho8TfoHhQz53Ug91Df3O6AWtT+zPHJtQVrK0FvtTtq6Ijo+mNL+YL4WzLnITYcHoA/WWop5L6MXQxodHaub2EEYZjkmHF6y/Uf+2tIxEFMcoV/qMqm2MWvwvxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369001; c=relaxed/simple;
	bh=cu1uBW36s/ellgN1RvdzGNfXw9mtejQ5D6M4oS/I2n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWu8VO6ZFMdEcoTEtTbLX3B2pC4A5XsVApbp1fO6Hhz3xHgkNljEE8E7B6kJGW5TCelOltkQUI9cNvCUrPURN5PKuBGemZRYvr/eZOijK2Dlc8XLJpWx40fIMkQCN258pqZMlPmO5wl9Q4GWAVfmpkb/PTlvyh0WSbSAEGcwerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFKKoCgi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722368999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/cPUYd++DCCgFjvaC+qtPn26fnGx0vD9xb+HXplenM=;
	b=cFKKoCgi6KMhhve9jjZu2cXS5/WEc404JJTYy9WhoJ8lt1ToR/aV5It+3zP77YRoSj74b/
	pIomUo+XkfIPe9gSMvbtswSBYsHZYnWVOkGs7bNZzAgMoRK/AEy5g6nbXCW9/e69ZWHvWm
	LhRJpfQyGcZC5PEZPlGkj1jzoOx/S6w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-FdE34CPzPFG9C1FCZnpHGA-1; Tue, 30 Jul 2024 15:49:57 -0400
X-MC-Unique: FdE34CPzPFG9C1FCZnpHGA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b119a74so30878385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368996; x=1722973796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/cPUYd++DCCgFjvaC+qtPn26fnGx0vD9xb+HXplenM=;
        b=Bc9ads0+el86fXpijGM091wx/YzYbRVohNzWZDbUikyuIYIs4fYSHawUHg0Vev05Sv
         Fh9lKaoecpUk22G1qHQSlKrM8Bb0HfWZnrrT7/Z2HDPNEnzK+AYkLAXEw4NtS6aLgxRI
         ynJg2V8F0QAeD4T5k8/X61DUkpxK1LgJisX2+uMLHspP7y+XTlS1P7+mT7bBpmr8rFZZ
         doF8ExVhSFtplvo3zsRjFLZoNgRHo2lERlX2vjcoB3gISSszwPdeBSkNVkn/yY3IJwvs
         kFWR+l0wIYYOYDXD0TO/f7GlMnnp42vIaAjYiPwzMspj+hpJRsm7SSJlZR+onxFXAbPR
         fAIg==
X-Gm-Message-State: AOJu0YwVWw0C70ASRVkOm1ecy0pzI110/G02hZ+O5jUXfuLot/cKdNyF
	hI8DMvIEJlsnJqKdX3WHRByK5djVkftEMM0atuEcAtoxY/S0Rm9mTNTGIxhYp0V+kYKEJzR4D4T
	hG99WBQGL+rtAIcF12nVDQorCLH7P2aLBIhzZfiCYXnlRWE5nifkfab+i7VtgBA==
X-Received: by 2002:a05:600c:1550:b0:426:668f:5eca with SMTP id 5b1f17b1804b1-42811d6dc2fmr75100965e9.7.1722368996582;
        Tue, 30 Jul 2024 12:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5qxn0fX9rUzVMPmPO/89pH/Zs+VF1jKd3xGD6SN6qGjJWew7HyHgAwXtPyvRDKa1cixgeA==
X-Received: by 2002:a05:600c:1550:b0:426:668f:5eca with SMTP id 5b1f17b1804b1-42811d6dc2fmr75100825e9.7.1722368996075;
        Tue, 30 Jul 2024 12:49:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b0e8sm231690805e9.26.2024.07.30.12.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:49:55 -0700 (PDT)
Message-ID: <96ae32c7-8e49-4802-a9ed-c5428b3a1f14@redhat.com>
Date: Tue, 30 Jul 2024 21:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Hugh Dickins <hughd@google.com>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com> <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com> <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com> <ZqfCmFUFyPU3WGES@x1n>
 <ZqfF2hhe60TE8xhQ@x1n> <da433043-d17c-43e0-ab6f-c4897061b4a1@redhat.com>
 <Zqk0mzD68lImF3y4@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zqk0mzD68lImF3y4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 20:44, Peter Xu wrote:
> On Mon, Jul 29, 2024 at 07:46:26PM +0200, David Hildenbrand wrote:
>> I see what you mean but this is a very similar pattern as used in
>> collapse_pte_mapped_thp(), no? There we have
>>
>> start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>> ...
>> if (!pml)
>> 	spin_lock(ptl);
>> ...
>> pte_unmap(start_pte);
>> if (!pml)
>> 	spin_unlock(ptl);
>>
>>
>> Again, I don't have a strong opinion on this, but doing it more similar to
>> collapse_pte_mapped_thp() to obtain locks makes it clearer to me. But if I
>> am missing something obvious please shout and I'll change it.
> 
> Right.. I don't think that path can change the pte pgtable either, and
> there is even the line Hugh left showing it's impossible:
> 
> 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> 		goto abort;
> 
> I was thinking maybe the page lock is the critical one, irrelevant of mmap
> lock.
> 
> No strong opinion either.  Not sure whether Hugh has some thoughts.  But
> maybe if we stick with pte_offset_map_nolock() and if there'll be a repost
> anyway, we could add a similar comment like this one showing that the pte
> pgtable should be actually as stable as the ptlock.

I think this all deserves some future cleanups :)

... for the time being I'll have to drop this patch completely. I should 
have known that virt_to_page() does not work on kmap'ed pages, but part 
of me didn't want to believe it.

CONFIG_HIGHPTE wants to make my life challenging :)

-- 
Cheers,

David / dhildenb


