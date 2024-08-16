Return-Path: <linux-kernel+bounces-288872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C02953FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFCB258A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330964EB45;
	Fri, 16 Aug 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="McTcq31j"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977F1C14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776931; cv=none; b=p46WYLlGOGs59KdfK6zMRuaNlKYydtkj+eBDGaobz+10YrOJY2KXRaSLyaJHhcqrjkOB0l3PuNlv4EOktXoUuptDhv51zpUnUgkMMAndBdb6E8picx/f4tAnlHEGTAutJSZpWG8uAk6pzcHpKoXzi4nAiSdMucIzUFaqIje/BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776931; c=relaxed/simple;
	bh=VIEL98twTaVi8gjY6QKhKADvE1Qf6nVqa9f3OH7GY6Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ByI6aWPMAmkUtMmeDnxu9U4HY9cfI86o9A3vZEpV/DEaGyCevEgsQhBcFM0jGchayHolVO60eDiYuXsUVWvWI1PIRCkoF113QNaqihwFzlSLGsC91xHCtK+WJ6ioikKMZPNb2jdV+rvmOb84tqT2e+ke3Iv14uokTmyRJfPSXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=McTcq31j; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-78f86e56b4cso188144a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723776929; x=1724381729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A3MM3HTnGOWLPIhXEINwFz0r0R05nhRmbTyOZGrrRY=;
        b=McTcq31jeqkCmGO2S7QED0xKcIAGL700iJzJNRAApCzSs77cBNBRsxAZ6ZZm9D2jkc
         GY3bxwiFFB2JQcWSDA7g8ZCQHu0bvgvGWxb213sffOTSQtTyA2Jtao9qn7RjED0H4Cpb
         UOVFK4COQTiigpidQoTu1Dmk/YjSgzLTF1I1Z36gs1H9zO7FapjsWegc1YD5GEn6EVaE
         gukPxo7TX2NxWFzv3Xd1j0wd9acZBZbe9v5MTQOPKRGuy42YMuGWXt7gFtsJOaHuOOvC
         RifRUczMd6J+L5tzF6dr9H5rVAm8ejoVNl5Trza0TN2V0EUaFelL4uj2SjSSTD32BRtF
         PlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723776929; x=1724381729;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A3MM3HTnGOWLPIhXEINwFz0r0R05nhRmbTyOZGrrRY=;
        b=MkDkbUUjRRVwu76TJQ/UQZVtblelbl25jR2Oa0LxaCVMq8Zf4Gm+yf3HxcDq/4YqVd
         kEM2GFW5vUbLs/ZOB+N0QiFmIFOC6E4rHdxijXWuguTVMoM7/i3HaXl2aSF8ycKzwAKK
         00fpD1y/F+Jh5m40UMm3DeuScRkL1lLs7rliIVHu6LidrJ9BuFTwbah6tklhq4h/vvoq
         XgubHS0pc84Wwu1vIvJ0QetJIb1t+zpyeeDz9asF20Wg/hBLeudOEz+okod9muTpFyE7
         I10lkZfP6bNZHZk+xwv4bUzNJe9uWNfddae7VR9tnfzYRyhtg9zY16RjS6RrifSEl75j
         X5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXhqOc6JErqOUTCB4beevnNhBSxNqwwN4J92PbBwoSE7DkdtZvLGWn3cKnBJGXcR65GJ13irE1wdp1v23g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLJtwFzP9vZ3/VIgYOvvtUkPFA+0UYtkJQfhr5JP52Q8Tatdg
	WoUdkE1i/8b+ta0TCQwcfCf3OnY80+uS4UeCaoXzr1Nzg/Zf7yw7x2FMeml5PDw=
X-Google-Smtp-Source: AGHT+IFEITycCX5z1l7KTvGHqYMR8Dl0wjrlGTV3lyxtgN4YOp2kSGgcUTdRZBJvq+p6o0b7bLQ4lA==
X-Received: by 2002:a17:90b:4f86:b0:2d3:b9bb:556a with SMTP id 98e67ed59e1d1-2d3dffc0f18mr1041632a91.2.1723776928757;
        Thu, 15 Aug 2024 19:55:28 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2f61fd9sm608109a91.16.2024.08.15.19.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 19:55:28 -0700 (PDT)
Message-ID: <6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com>
Date: Fri, 16 Aug 2024 10:55:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, mgorman@suse.de, vbabka@kernel.org,
 akpm@linux-foundation.org, zokeefe@google.com, rientjes@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <bf9f79df-4821-4053-a1e9-f054f2ca5734@bytedance.com>
In-Reply-To: <bf9f79df-4821-4053-a1e9-f054f2ca5734@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/6 11:31, Qi Zheng wrote:
> Hi all,
> 
> On 2024/8/5 20:55, Qi Zheng wrote:
> 
> [...]
> 
>>
>> 2. When we use mmu_gather to batch flush tlb and free PTE pages, the 
>> TLB is not
>>     flushed before pmd lock is unlocked. This may result in the 
>> following two
>>     situations:
>>
>>     1) Userland can trigger page fault and fill a huge page, which 
>> will cause
>>        the existence of small size TLB and huge TLB for the same address.
>>
>>     2) Userland can also trigger page fault and fill a PTE page, which 
>> will
>>        cause the existence of two small size TLBs, but the PTE page 
>> they map
>>        are different.
>>
>>     For case 1), according to Intel's TLB Application note (317080), 
>> some CPUs of
>>     x86 do not allow it:
>>
>>     ```
>>     If software modifies the paging structures so that the page size 
>> used for a
>>     4-KByte range of linear addresses changes, the TLBs may 
>> subsequently contain
>>     both ordinary and large-page translations for the address range.12 
>> A reference
>>     to a linear address in the address range may use either 
>> translation. Which of
>>     the two translations is used may vary from one execution to 
>> another and the
>>     choice may be implementation-specific.
>>
>>     Software wishing to prevent this uncertainty should not write to a 
>> paging-
>>     structure entry in a way that would change, for any linear 
>> address, both the
>>     page size and either the page frame or attributes. It can instead 
>> use the
>>     following algorithm: first mark the relevant paging-structure 
>> entry (e.g.,
>>     PDE) not present; then invalidate any translations for the 
>> affected linear
>>     addresses (see Section 5.2); and then modify the relevant 
>> paging-structure
>>     entry to mark it present and establish translation(s) for the new 
>> page size.
>>     ```
>>
>>     We can also learn more information from the comments above 
>> pmdp_invalidate()
>>     in __split_huge_pmd_locked().
>>
>>     For case 2), we can see from the comments above ptep_clear_flush() in
>>     wp_page_copy() that this situation is also not allowed. Even without
>>     this patch series, madvise(MADV_DONTNEED) can also cause this 
>> situation:
>>
>>             CPU 0                         CPU 1
>>
>>     madvise (MADV_DONTNEED)
>>     -->  clear pte entry
>>          pte_unmap_unlock
>>                                        touch and tlb miss
>>                       --> set pte entry
>>          mmu_gather flush tlb
>>
>>     But strangely, I didn't see any relevant fix code, maybe I missed 
>> something,
>>     or is this guaranteed by userland?
> 
> I'm still quite confused about this, is there anyone who is familiar
> with this part?

This is not a new issue introduced by this patch series, and I have
sent a separate RFC patch [1] to track this issue.

I will remove this part of the handling in the next version.

[1]. 
https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/

> 
> Thanks,
> Qi
> 
>>
>>     Anyway, this series defines the following two functions to be 
>> implemented by
>>     the architecture. If the architecture does not allow the above two 
>> situations,
>>     then define these two functions to flush the tlb before set_pmd_at().
>>
>>     - arch_flush_tlb_before_set_huge_page
>>     - arch_flush_tlb_before_set_pte_page
>>
> 
> [...]
> 
>>

