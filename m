Return-Path: <linux-kernel+bounces-295874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44EB95A25D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CEA1F21399
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828F14E2DE;
	Wed, 21 Aug 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii6U7QBD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667F14C59B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256290; cv=none; b=oUWYJOYhXzvO167bpjpkQfj8KBEblwOA3dtsBrWUx3C4j/UfZUnB9E48pXX8k4usWbfSUr9S50lHdzZCqtIBfZJVweJIYdBjKduEo0f6If5vDOdjHsoO+5QilbCppTMhnlewCOsqkThHyKBdZI7qc7RfaUzmFIYw67okweq3qbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256290; c=relaxed/simple;
	bh=AlVWMujZb4KMNj53fGB/JwXcf8Z1PSC7AGNyq62/JsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz9J+8wp1TUyqGeFe79rQu61EpGlCZiYAuLpG/Swu73B7QsN9eq2h4R9naTzae2KddzSikZqeQq2todrEciEKnmSkKN6lT+Ur5UcJqIQ2nby1Rg9HOgY0aygmb7incxKs09FAUQLo0e/As/8d3/tDUAlx/bWKfWbvqAtdwxVT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ii6U7QBD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724256288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S01eevrAEs0lxpxuE+gw3u09VxcLdZQUZHokHj/vHXU=;
	b=Ii6U7QBDpUx20Ktu8f6RO0ViO5t4PEw5TwWi7XJh/4VpY8+YLvmM5KbywsJ39DCwyyZroD
	Rm3wDuuyohWgP1uHsDG/2zO/v/yx2e+jQnLy9SfI0CH3RPWtDO3r89PUx3CwoZtB+pdTmP
	WYplrBKP0cLk/knKpZC0ef2b/D40ZvQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-o0r7S2QoO8CNov_laY_I6g-1; Wed, 21 Aug 2024 12:04:44 -0400
X-MC-Unique: o0r7S2QoO8CNov_laY_I6g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3719ee7c72eso3008807f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256283; x=1724861083;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S01eevrAEs0lxpxuE+gw3u09VxcLdZQUZHokHj/vHXU=;
        b=VhvFOln6yDuZ2PpQbpLHyaugRc8EGUNGecwtyFZqIG46g9JaRbFT3StkDVgOg6As+b
         axpr7fR6sqqvvhIYHzcnvUrAntN3SlL3NlfdywTQR8S+wDebam/gm+ut8zGjr+Kw7f+q
         wouuSh78yfdybcvyrjg183IzwtCXwN2dUP1Lmoa2hcs3MYUM/Ga7mabzPwGYNONElIFc
         VlxRGjV7aHPGSKkvTZa8UpUse6a4tuNXwk1JrffwS4DcbXALVHxZaNsaCHHZGU9vX5Y6
         JKsWwIZLGEywOXahjDMYuIWkPgyYnzxqedE0COflT1btmYJD9oz6eBNPg61r08adbpt+
         mCJg==
X-Gm-Message-State: AOJu0YxptuEb5DmVMc/41R/VjjgdCPzMvjbDKmzNkXXzjJXT7FnKcvjF
	dSNhQUd9upyXfizrIgI2JzPbLWEpopeiwI7OcCp+30GoUyMC1RAnmm8io6jCXhxBzms2CwJ0evO
	4hn4OUwYTV/E5ZCFqkfk/+OthT0KryFe1MI6UpetUvrLeraVoS7aTOQ3nklNI+w==
X-Received: by 2002:a05:6000:196b:b0:371:87d4:8f1d with SMTP id ffacd0b85a97d-372fd6da3ebmr1851413f8f.28.1724256283430;
        Wed, 21 Aug 2024 09:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBsdu1qj2IcJaBSV38+AQ+dl1u7gpj99iE4YKjYFE/TwtpOHQNKrY4gGw10COiV5E2nRnbfA==
X-Received: by 2002:a05:6000:196b:b0:371:87d4:8f1d with SMTP id ffacd0b85a97d-372fd6da3ebmr1851369f8f.28.1724256282485;
        Wed, 21 Aug 2024 09:04:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898bb588sm16022125f8f.115.2024.08.21.09.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 09:04:42 -0700 (PDT)
Message-ID: <95a7dbfe-d88f-4d8b-898e-87c18e7d5813@redhat.com>
Date: Wed, 21 Aug 2024 18:04:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Mario Casquero <mcasquer@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Muchun Song <muchun.song@linux.dev>
References: <20240821123115.2068812-1-david@redhat.com>
 <CAHS8izNyDymXoH94usJTGNHG45HB50m7SSkL6H1C+9pxBEDE+g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHS8izNyDymXoH94usJTGNHG45HB50m7SSkL6H1C+9pxBEDE+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.08.24 17:59, Mina Almasry wrote:
> On Wed, Aug 21, 2024 at 8:31 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Currently, running the charge_reserved_hugetlb.sh selftest we can
>> sometimes observe something like:
>>
>>    $ ./charge_reserved_hugetlb.sh -cgroup-v2
>>    ...
>>    write_result is 0
>>    After write:
>>    hugetlb_usage=0
>>    reserved_usage=10485760
>>    killing write_to_hugetlbfs
>>    Received 2.
>>    Deleting the memory
>>    Detach failure: Invalid argument
>>    umount: /mnt/huge: target is busy.
>>
>> Both cases are issues in the test.
>>
>> While the unmount error seems to be racy, it will make the test fail:
>>          $ ./run_vmtests.sh -t hugetlb
>>          ...
>>          # [FAIL]
>>          not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=32
>>
>> The issue is that we are not waiting for the write_to_hugetlbfs process
>> to quit. So it might still have a hugetlbfs file open, about which
>> umount is not happy. Fix that by making "killall" wait for the process
>> to quit.
>>
>> The other error ("Detach failure: Invalid argument") does not seem to
>> result in a test error, but is misleading. Turns out write_to_hugetlbfs.c
>> unconditionally tries to cleanup using shmdt(), even when we only
>> mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
>> SHM case. Fix that as well.
>>
>> With this change it seems to work as expected.
>>
>> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
>> Reported-by: Mario Casquero <mcasquer@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Mina Almasry <almasrymina@google.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Initially I thought it could be nice to split fixes for the 2 issues
> in separate patches in case one of them ends up needing a revert or
> something, but probably not worth a respin. Fixes look good to me.

I was debating with myself as well if it should be separated, but 
decided to go the simple route of a single patch :)

> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks!

-- 
Cheers,

David / dhildenb


