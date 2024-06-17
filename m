Return-Path: <linux-kernel+bounces-218040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF490B870
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D311F22495
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364C118EFF2;
	Mon, 17 Jun 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFxdszFy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97A10A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646588; cv=none; b=aVL5vyuHAu+CsnYLwnReojedBnBTDtialCkroV7DqX0vnMSmBizEAhBEFgsUlCfa12oJgTxHWPf4T9SbpKweay4o7+GzBM3eHus2Mm4aahToAwXJzR0pT5B6wDkRm+AU1O4cHc/HpacMut9w/OZbKl3iI0TtWnX9iGAtQY+sPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646588; c=relaxed/simple;
	bh=fVD6F1fNKafAjqnwqV/B27y0H5t5ImzaPa0DnD96ITY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxwIa92EvWaPdaa/RYX049WJidrDfW+0zXTc/q4HTSTan3fNtBOHOSO/ERZK7mYO7x7Nw6DvFv/31Li9bSkq+1IXJL2U95+HIcPvCwTN1ldCWL+w5fn76/EyZXcJtW7UGDC/XRU8M71b5A38BzOATsccd6GPjrxADKs3fWHSYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFxdszFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718646585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lc7rrDbtSLsPMONVGxktGUVosC8E7zyGVSTi1wgmlOQ=;
	b=PFxdszFyOjKskudS6li7poAa1SZFwa+SmU9doDVU0S+OHyjwW8zWw6qNCi6hFFZNxmfYj9
	rRh7lMBbKhtHBJtRS2PUJJF4sWYS/moBl2uRJHXosLt4WJDl5CwCssDb42icGpUdVdUBPh
	tftgr3+agS61piHpPP0DIVtS9kjwHNs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Yggog1F7P7OFrDYlsN8JwA-1; Mon, 17 Jun 2024 13:49:43 -0400
X-MC-Unique: Yggog1F7P7OFrDYlsN8JwA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1f358e59so2382167f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718646583; x=1719251383;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lc7rrDbtSLsPMONVGxktGUVosC8E7zyGVSTi1wgmlOQ=;
        b=hmiOIC9z0ngmjqR9vz5hAWQjgCXLwMJvE56x3QY2pTheZtoCFfm95hNEdg8uqfx1uI
         fKNPFTIhTPFG7X1se/0U0Pyq4YNWil95pb8VBvU0pFbgkbYiYenVOPZCmVVQbmnowPtQ
         348whw6ExTaVaMpz3LqtWev4VilJl7Biwy77Au8ByRRhtqNQ4CEiClpzVrU31nBc0x6Z
         ugH9375ve7vnOU5Vi5vHsG66ow2NQV4ArcJz1LK63ON2vPjv3qYPetOyGHMU9yss4RtB
         A8k0u1zNtm+YmBPJ3OnkL7Rx2BUvPLIPtAoh9SrRHYl3WuSf7yaYc4WGxh7U1lJe9FPb
         P5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWicsqXvGlBdz7pXt1jsnOKDYnQ1SGqGzsmwF5pSARinSE3Y0+PN2OBTEUAs+UfBIzGSa//ztC0t0bgeEdUp/Dzg+7CSB9oviHymGIG
X-Gm-Message-State: AOJu0YwDm71N55WtIS+T8it46rDk8o3/0tUoZIY9mTFIXdnxnF4SOL+T
	0TX/ezdjFBP/bgLVA7auCaypPIBuEP87AHh4dyv4OUWoQcUHVUTC3x61C1EITM4B0VFWLYnrGzX
	QVl8qRQudnY6OsWXX/dojHi6eizhxeg/2GJdCGZWO1sDTvhG76z8HoCZz9m5ukA==
X-Received: by 2002:a05:6000:ec5:b0:35f:1c95:4042 with SMTP id ffacd0b85a97d-3609ea52ac3mr309135f8f.4.1718646582780;
        Mon, 17 Jun 2024 10:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVfcp+bFCArt/GpyLvmCzWGVhK63vjPmL4R+3ov3xKN4sv27UDcjdrn/45rFaFWwE6mRQKig==
X-Received: by 2002:a05:6000:ec5:b0:35f:1c95:4042 with SMTP id ffacd0b85a97d-3609ea52ac3mr309124f8f.4.1718646582353;
        Mon, 17 Jun 2024 10:49:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2200:95d8:cbf4:fffd:7f81? (p200300cbc740220095d8cbf4fffd7f81.dip0.t-ipconnect.de. [2003:cb:c740:2200:95d8:cbf4:fffd:7f81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6419e38sm167784235e9.39.2024.06.17.10.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:49:41 -0700 (PDT)
Message-ID: <86b29391-ad2a-4c4b-b9a8-974d1876632c@redhat.com>
Date: Mon, 17 Jun 2024 19:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <aaf9a7d7-647f-41bf-91b4-e362ff5df6b0@redhat.com>
 <f2fbf466-f722-4fd3-9883-189145e599f4@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f2fbf466-f722-4fd3-9883-189145e599f4@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> No strong opinion, something synchronous sounds to me like the
>> low-hanging fruit, that could add the infrastructure to be used by
>> something more advanced/synchronously :)
> 
> Got it, I will try to do the following in the next version.
> 
> a. for MADV_DONTNEED case, try synchronous reclaim as you said
> 

I think that really is the low hanging fruit that would cover quite some 
cases already: (1) reclaim when MADV_DONTNEED spans the complete page table.

Then, there is (2) reclaim when MADV_DONTNEED spans only part of the 
page table (e.g., single PTE), but my best guess is that it's better to 
scan for that asynchronously than making possibly each MADV_DONTNEED 
sycall invocation slower.

(1) would already help a lot and showcase how the locking/machinery 
would work.


> b. for MADV_FREE case:
> 
> 	- add a madvise option for synchronous reclaim
> 
> 	- add another madvise option to mark the vma, then add its
>             corresponding mm to a global list, and then traverse
>             the list and reclaim it when the memory is tight and
>             enters the system reclaim path.
>             (maybe there is an option to unmark)
> 
> c. for s390 case you mentioned, create a CONFIG_FREE_PT first, and
>      then s390 will not select this config until the problem is solved.
> 
> d. for lockless scan, try using disabling IRQ or (mmap read lock +
> pte_offset_map_nolock).

Although d) really only is desired when scanning asynchronously I think. 
During (1) above, we know that the table will be very likely empty 
(unless weird race).

-- 
Cheers,

David / dhildenb


