Return-Path: <linux-kernel+bounces-529765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E71A42A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C4A3A6D60
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FEF2661BC;
	Mon, 24 Feb 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjdsIjBk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CA265CC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420247; cv=none; b=Zb7bijCsde9mtJ7t57/JkPiJjxj3DwvQ+jm0y2mTyHrtQehgCYVVEWT0QTRMgk98PTWRWSqoOqxZfA0ZQeiaPkRxhWumvI32Z6y5kN8nPcJ5WcftDs4rvTppZeRIgsPvVrAKREe19I3v2dvanhOiiY9OW9aT/Ss+2HLqha8KdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420247; c=relaxed/simple;
	bh=C0oe1Ya2EZLRxlAQ0L8g/GFjD5Xv4b7G7R1GBfyoduM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm65Rx3ymPclbCE63VQxSyHWF0bVpcJCXsIgeuT3jHxP4Cki56ZciBwmqrnLA09M+gwUT4MyeiB8HzYVEtqr977c55Qy4bRVKRmMLwOO1Q7Q6wo2oHEqEu9N62umxBG1NuInmZhy+CzZ3iDKVyyrQSzFkf7fFHInO4odweCAshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjdsIjBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740420244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FKhJDB5I9/Akcs9qeehefKWvAKLmf9oiYnEk3pKbOsI=;
	b=PjdsIjBkXf5/A+NKEyc2gl7dMhQxKmm7H3fxRjp6raOToLnVS1+c+cRSmbv7iXouezLPTa
	KCep1FZbNpKIyDGelQW/5RcJ0Bc5aL9Vrl2tdHgVV7VY7jyDGZR9qL92r1a/LpoWtYwdwS
	e9nQWMcep4GWo70Wx3mz9xcAB7938EM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Y47yq8svPVeonTaLkSq8uw-1; Mon, 24 Feb 2025 13:04:03 -0500
X-MC-Unique: Y47yq8svPVeonTaLkSq8uw-1
X-Mimecast-MFC-AGG-ID: Y47yq8svPVeonTaLkSq8uw_1740420242
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43943bd1409so33160045e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420242; x=1741025042;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKhJDB5I9/Akcs9qeehefKWvAKLmf9oiYnEk3pKbOsI=;
        b=kTgqno+ObRjf/dHl8P+f0HW87m3ZJieLYHZiwBMBzIt0pN/PUKRC2aSGHjR7tQLVIR
         Pam0E+qkioXrzUyszf0tVFPQpOoAWc3WQ4OCxXt4slCC9KplYHSQY0bH2Vr6HMyGl6FF
         NCRYkUAPAF5BoWn0w1/V4MnWB86uX2TSyTwgwIfsuULoTlQtpSrw8Bh1FDc7jgtmWuGg
         fXpQk8Kw7Gty0Gn6c/4jnb0plvZF9p/b2t0fjM0Dj0iTPDefy1G/N8edmMwEUBi1h6Ih
         nGyUC0IleE7iz0oolc4Dpn5/jKNW0VoH++O4LpwbCZloYlQzlPlsj53swYAnwUEHrlY2
         NiEA==
X-Forwarded-Encrypted: i=1; AJvYcCUG5on0kZ4CAPoTfhmC/m8FgKRX26IEg9UfPca08+bzn5hHeAr19XS4YTOPdP3+vwMo6AsAnvyH5N/44W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTJzf+CXsySBg7hDH3sBvBmO+cGCMPrrpPMQO8PVGvo13KtTr
	iAX+EIrsP1mviHat3OvOOLnlydzGzat8IC9Ln1li/Db3aiM+QkdhRCwE7u4nP+1JqVnKUeltckL
	jc39lZEi7imCun4XxM3kd+K7mKO3p6R+EO4oid+LbkfTX45jklz7CbL/aqC0AZg==
X-Gm-Gg: ASbGnctyjsxFspFh5l2pvlVL5W6d9G4kL63yOTkPixVKtzbsr3cJF0SzGpgMKS7gTWq
	+iwI5dJi4++VaHcEBd4Y998zEOFF9K5WlnwlKPj37KSJPMNuqIM4tUOOFNX51cLEM1DSDLI104W
	nH/V0BbSW2e08jyjnKEYYG1dmjnkgxsq8tN+iTi3Yz4a44Z3CxXYSCx29POtYsf5OSLlVraKK1O
	Dls2Wc8geqSbuMPtFrMSbh9kmBYDXvIlVZrLUu8Vxwy/b+il6AKAHvx/fTlH++yRhoPoWrRFO0U
	noqoJhoVzHCyDhrLlJE3N9WRtWYXsQauYks1LwrUiEUYIQ==
X-Received: by 2002:a05:600c:3c9f:b0:439:34dd:c3cc with SMTP id 5b1f17b1804b1-439ae2197d1mr99189335e9.22.1740420241796;
        Mon, 24 Feb 2025 10:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0qisyK2TmyiUHxqGDOo+VFtcO9MSPSIVtTFeVJRq9q6wtNqxhOQqdWsjAGVkrBH4KkE69kA==
X-Received: by 2002:a05:600c:3c9f:b0:439:34dd:c3cc with SMTP id 5b1f17b1804b1-439ae2197d1mr99188955e9.22.1740420241360;
        Mon, 24 Feb 2025 10:04:01 -0800 (PST)
Received: from [192.168.3.141] (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f252dsm111389435e9.22.2025.02.24.10.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:04:00 -0800 (PST)
Message-ID: <e2917ef8-43bb-4f85-8f0f-712133b88481@redhat.com>
Date: Mon, 24 Feb 2025 19:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
To: Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>
Cc: Liam.Howlett@oracle.com, aarcange@redhat.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, bgeffon@google.com, brauner@kernel.org,
 hughd@google.com, jannh@google.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 mhocko@suse.com, ngeoffray@google.com, rppt@kernel.org,
 ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org,
 zhangpeng362@huawei.com, zhengtangquan@oppo.com, yuzhao@google.com,
 stable@vger.kernel.org
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com> <Z7e7iYNvGweeGsRU@x1.local>
 <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com>
 <Z7fbom4rxRu-NX81@x1.local>
 <CAGsJ_4xb_FoH+3DgRvV7OkkbZqZKiubntPtR25mqiHQ7PLVaNQ@mail.gmail.com>
 <Z7yxY3wkcjg_m-x4@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7yxY3wkcjg_m-x4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.02.25 18:50, Peter Xu wrote:
> On Sun, Feb 23, 2025 at 10:31:37AM +1300, Barry Song wrote:
>> On Fri, Feb 21, 2025 at 2:49 PM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Fri, Feb 21, 2025 at 01:07:24PM +1300, Barry Song wrote:
>>>> On Fri, Feb 21, 2025 at 12:32 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
>>>>>> 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）
>>>>>
>>>>> Could you help explain what guarantees the rmap walk not happen on a
>>>>> swapcache page?
>>>>>
>>>>> I'm not familiar with this path, though at least I see damon can start a
>>>>> rmap walk on PageAnon almost with no locking..  some explanations would be
>>>>> appreciated.
>>>>
>>>> I am observing the following in folio_referenced(), which the anon_vma lock
>>>> was originally intended to protect.
>>>>
>>>>          if (!pra.mapcount)
>>>>                  return 0;
>>>>
>>>> I assume all other rmap walks should do the same?
>>>
>>> Yes normally there'll be a folio_mapcount() check, however..
>>>
>>>>
>>>> int folio_referenced(struct folio *folio, int is_locked,
>>>>                       struct mem_cgroup *memcg, unsigned long *vm_flags)
>>>> {
>>>>
>>>>          bool we_locked = false;
>>>>          struct folio_referenced_arg pra = {
>>>>                  .mapcount = folio_mapcount(folio),
>>>>                  .memcg = memcg,
>>>>          };
>>>>
>>>>          struct rmap_walk_control rwc = {
>>>>                  .rmap_one = folio_referenced_one,
>>>>                  .arg = (void *)&pra,
>>>>                  .anon_lock = folio_lock_anon_vma_read,
>>>>                  .try_lock = true,
>>>>                  .invalid_vma = invalid_folio_referenced_vma,
>>>>          };
>>>>
>>>>          *vm_flags = 0;
>>>>          if (!pra.mapcount)
>>>>                  return 0;
>>>>          ...
>>>> }
>>>>
>>>> By the way, since the folio has been under reclamation in this case and
>>>> isn't in the lru, this should also prevent the rmap walk, right?
>>>
>>> .. I'm not sure whether it's always working.
>>>
>>> The thing is anon doesn't even require folio lock held during (1) checking
>>> mapcount and (2) doing the rmap walk, in all similar cases as above.  I see
>>> nothing blocks it from a concurrent thread zapping that last mapcount:
>>>
>>>                 thread 1                         thread 2
>>>                 --------                         --------
>>>          [whatever scanner]
>>>             check folio_mapcount(), non-zero
>>>                                                  zap the last map.. then mapcount==0
>>>             rmap_walk()
>>>
>>> Not sure if I missed something.
>>>
>>> The other thing is IIUC swapcache page can also have chance to be faulted
>>> in but only if a read not write.  I actually had a feeling that your
>>> reproducer triggered that exact path, causing a read swap in, reusing the
>>> swapcache page, and hit the sanity check there somehow (even as mentioned
>>> in the other reply, I don't yet know why the 1st check didn't seem to
>>> work.. as we do check folio->index twice..).
>>>
>>> Said that, I'm not sure if above concern will happen in this specific case,
>>> as UIFFDIO_MOVE is pretty special, that we check exclusive bit first in swp
>>> entry so we know it's definitely not mapped elsewhere, meanwhile if we hold
>>> pgtable lock so maybe it can't get mapped back.. it is just still tricky,
>>> at least we do some dances all over releasing and retaking locks.
>>>
>>> We could either justify that's safe, or maybe still ok and simpler if we
>>> could take anon_vma write lock, making sure nobody will be able to read the
>>> folio->index when it's prone to an update.
>>
>> What prompted me to do the former is that folio_get_anon_vma() returns
>> NULL for an unmapped folio. As for the latter, we need to carefully evaluate
>> whether the change below is safe.
>>
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -505,7 +505,7 @@ struct anon_vma *folio_get_anon_vma(const struct
>> folio *folio)
>>          anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>>          if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>>                  goto out;
>>
>> -       if (!folio_mapped(folio))
>> +       if (!folio_mapped(folio) && !folio_test_swapcache(folio))
>>                  goto out;
>>
>>          anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
>> @@ -521,7 +521,7 @@ struct anon_vma *folio_get_anon_vma(const struct
>> folio *folio)
>>           * SLAB_TYPESAFE_BY_RCU guarantees that - so the atomic_inc_not_zero()
>>           * above cannot corrupt).
>>           */
> 
> [1]
> 
>>
>> -       if (!folio_mapped(folio)) {
>> +       if (!folio_mapped(folio) && !folio_test_swapcache(folio)) {
>>                  rcu_read_unlock();
>>                  put_anon_vma(anon_vma);
>>                  return NULL;
> 
> Hmm, this let me go back read again on how we manage anon_vma lifespan,
> then I just noticed this may not work.
> 
> See the comment right above [1], here's a full version:
> 
> 	/*
> 	 * If this folio is still mapped, then its anon_vma cannot have been
> 	 * freed.  But if it has been unmapped, we have no security against the
> 	 * anon_vma structure being freed and reused (for another anon_vma:
> 	 * SLAB_TYPESAFE_BY_RCU guarantees that - so the atomic_inc_not_zero()
> 	 * above cannot corrupt).
> 	 */
> 
> So afaiu that means we pretty much very rely upon folio_mapped() check to
> make sure anon_vma being valid at all that we fetched from folio->mapping,
> not to mention the rmap walk later afterwards.
> 
> Then above diff in folio_get_anon_vma() should be problematic, as when
> "folio_mapped()==false && folio_test_swapcache()==true", above change will
> start to return anon_vma pointer even if the anon_vma could have been freed
> and reused by other VMAs.

When splitting a folio, we use folio_get_anon_vma(). That seems to work 
as long as we have the folio locked.

-- 
Cheers,

David / dhildenb


