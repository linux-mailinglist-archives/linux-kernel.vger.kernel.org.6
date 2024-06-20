Return-Path: <linux-kernel+bounces-222108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B290FCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75D91C220C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1B3BBED;
	Thu, 20 Jun 2024 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/aSBiR8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8852BAF3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865719; cv=none; b=ZqSpheJU+slMJhsns8t+t+Oc9sWlwhIFZNmoSi7hOmbbv2iM87114IPaOI8HXDxzGwu/IDLZ3j6S37vvzfI/SPvgXV98BzHVIK/Ao1R5WZdJ9JIphynjdR5qetvvhO/woyL5V4A3rR+FzwAncMe3Ev5iWpWSutGe1WRSKdgG1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865719; c=relaxed/simple;
	bh=tb928V7CTVRFot+5ESqLZusjuwiX9iT5P/mdmtwizOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGbXreyqjHkPLXHmc/a0EUPpJIQKgZguDia/pkB9gYjuejN1el/6ph/9wna7KnqIvqh54S3jK7FmgAGfetH5h55GlwAWhYe02GjTourAmmg1s5NM2+70BqsNOgjxPimz4JcrrC5rVd2cwhNY7EnPWqnqpvaTJAPCkpBO3D422Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/aSBiR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718865717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZO/EfLRsDXCmwFcUbDx0U6joA4mxei7V1KzI9kct1Nc=;
	b=F/aSBiR8OT9oKw+zdi3mCLebncGZxmPn9igC5szkA43F2Cny7UO40VedIDBQuYo1nYaaI/
	DSQuWWXlRgzCL9Q7NC2anxaXOwmh7mx8mQcGyo3GKxyR6eBdDmxvps+UgOOydvU3xJ1pv+
	rhj46MBELYfxo9zpJRc2h5oo7RAtx5g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Yk4_u7_uNyyaeSAH4tYBsg-1; Thu, 20 Jun 2024 02:41:55 -0400
X-MC-Unique: Yk4_u7_uNyyaeSAH4tYBsg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c968340c8so490605e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865714; x=1719470514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZO/EfLRsDXCmwFcUbDx0U6joA4mxei7V1KzI9kct1Nc=;
        b=USVy/sTVz0y2/89QNnMyUDzqShs6iyfKLGVbVzWniFjtNQOxijtD/xt2KBWoUsdoUA
         Mt7U5TqRwRgoXgEikj24hQvziWm/IbUNHjRIqfHF2OI3wky0PRgDcYxupK/41NDIXD5P
         3KecTqbLAxQbA/lFVSmBQZn08U+QmkKTDCK3Eits1xqleDdDBSbWxVZoDkxsSwU/wLuV
         emBfjrrvlYkQp73QgM437Lyjaylpu3jKp1rvFxR/mreexuvhhtvzKVXbHOovX4IjojNn
         JNbVRZoh51I/U35S1if2ooDBClfB+TK+ne4ed2MO8+cwKvXH9JzHj+6Tk3rXhfZ0x7xa
         abNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0NZxZ7RlZ1q/23aSyjC+oJLBm8MddJD0pSXv85T08hHF6cli86F+MLqFBsHApX3cudYfNljtXfHIY76LSb+J4jkU7AsudhyZdy+ME
X-Gm-Message-State: AOJu0YzBeA12N+as5KRylEPm85VmAv95dkcqKagY3vkZbSzvlSrglXh6
	mGo43OUGf3OCc8THLd+S12CyT7N4iBI0cyTVt8eWFxZR3eiKstL/qXXXsQe1WcEgsR51im+uCr5
	XPje6CrlYPeOPWnVJobP+9OfxO47YoHkVlcOmTZZEDbMPP/z3S37NrYx/UF9Jfw==
X-Received: by 2002:a05:6512:3a90:b0:52c:cbb4:7810 with SMTP id 2adb3069b0e04-52ccbb478afmr3734651e87.8.1718865713889;
        Wed, 19 Jun 2024 23:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdyyRmw9pW44BIEJakpDWNryDAcWB4ZcqzI3IPQXFsbSwD2ceBUzgjfefh7fftudE/4WnVhQ==
X-Received: by 2002:a05:6512:3a90:b0:52c:cbb4:7810 with SMTP id 2adb3069b0e04-52ccbb478afmr3734618e87.8.1718865713363;
        Wed, 19 Jun 2024 23:41:53 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23102.dip0.t-ipconnect.de. [79.242.49.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211ae0sm13704265e9.41.2024.06.19.23.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:52 -0700 (PDT)
Message-ID: <a14632e8-6f60-43f0-b80d-fea98491975c@redhat.com>
Date: Thu, 20 Jun 2024 08:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Bresticker <abrestic@rivosinc.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
 <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
 <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <20240619183357.2ee5a818f8de1d4773be2ff6@linux-foundation.org>
 <5f8a6e2e-8a51-dcad-a8a1-37e44349b716@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5f8a6e2e-8a51-dcad-a8a1-37e44349b716@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 05:59, Hugh Dickins wrote:
> On Wed, 19 Jun 2024, Andrew Morton wrote:
>> On Wed, 19 Jun 2024 01:16:42 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>>> On Wed, 19 Jun 2024, Baolin Wang wrote:
>>>> On 2024/6/19 04:05, Andrew Morton wrote:
>>>>> On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>> Shmem will support large folio allocation [1] [2] to get a better
>>>>>> performance,
>>>>>> however, the memory reclaim still splits the precious large folios when
>>>>>> trying
>>>>>> to swap-out shmem, which may lead to the memory fragmentation issue and can
>>>>>> not
>>>>>> take advantage of the large folio for shmeme.
>>>>>>
>>>>>> Moreover, the swap code already supports for swapping out large folio
>>>>>> without
>>>>>> split, and large folio swap-in[3] series is queued into mm-unstable branch.
>>>>>> Hence this patch set also supports the large folio swap-out and swap-in for
>>>>>> shmem.
>>>>>
>>>>> I'll add this to mm-unstable for some exposure, but I wonder how much
>>>>> testing it will have recieved by the time the next merge window opens?
>>>>
>>>> Thanks Andrew. I am fine with this series going to 6.12 if you are concerned
>>>> about insufficient testing (and let's also wait for Hugh's comments). Since we
>>>> (Daniel and I) have some follow-up patches that will rely on this swap series,
>>>> hope this series can be tested as extensively as possible to ensure its
>>>> stability in the mm branch.
>>>
>>> Thanks for giving it the exposure, Andrew, but please drop it from
>>> mm-unstable until the next cycle.
>>
>> Thanks, dropped.
> 
> Thanks. I'll add a little more info in other mail, against the further
> 2024-06-18 problems I reported, but tl;dr is they are still a mystery:
> I cannot yet say "drop this" or "drop that" or "here's a fix".
> 
>>
>>> p.s. I think Andrew Bresticker's do_set_pmd() fix has soaked
>>> long enough, and deserves promotion to hotfix and Linus soon.
>>
>> Oh, OK, done.
>>
>> And it's cc:stable.  I didn't get any sens of urgency for this one -
>> what is your thinking here?
> 
> I thought you were right to add the cc:stable. The current v6.8..v6.10
> state does not result in any crashes or warnings, but it totally (well,
> 511 times out of 512, in some workloads anyway) defeats the purpose of
> shmem+file huge pages - the kernel is going to all the trouble of trying
> to allocate those huge pages, but then refuses to map them by PMD unless
> the fault happens to occur within the first 4096 bytes (talking x86_64).
> 
> I imagine that this causes a significant performance degradation in
> some workloads which ask for and are used to getting huge pages there;
> and they might also exceed their memory quotas, since a page table has
> to be allocated where a PMD-mapping needs none (anon THPs reserve a page
> table anyway, to rely on later if splitting, but shmem+file THPs do not).
> And it's surprising that no tests were reported as failing.

Exactly my thinking. Either lack of tests or it doesn't really happen 
that often where khugepaged doesn't fix it up.

After all it's been two kernel releases ....

-- 
Cheers,

David / dhildenb


