Return-Path: <linux-kernel+bounces-561382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99270A610A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9B53B9438
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A61FDE3D;
	Fri, 14 Mar 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFReOsjM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02A1FCFFC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954255; cv=none; b=tsMpvIK/nbZCFIG7kruoF+7PtaT+1poOQTcZb7FBNjhsXcRJxAHvphO0UvZatWwYcYUAskV8LMprl7qDjFLedwsTFkehtTES3hQIaG/V+c4I4dtMw9PzNsFu7/191TzwumY2rUmwG7q+pz2HFpmSgXQ6Q9P3oxJ7aDuOzlbEeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954255; c=relaxed/simple;
	bh=XbIiHJcoZC9B43KXCo0L2pc6+TBkTn1NwxGG5MpFWXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dORZ07jcQKw4YLRCpMhp/UyY9etGsiYhe4KjVhBL9JgNpKigsBKdwQ0PfgEMRIRNmt+vHN7rHgVKcM1v9HzpImHMpV0bS/QrlZrvNNz6opvXyK4mHimeB3tSAIORUeNvi7/I88hfsdNvAcT+veUoQ1G2YO+lGLPmr0n+/2gjkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFReOsjM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N+W7JLYSi3FHd5wiExWEG1bnYG61jBb9yzI4idWzEYc=;
	b=dFReOsjMg+u2A6l7GBU1B/9dwPWO9g8hSpbWsBokKYdvjHBF0DjrtW69UMo7j0Jo09/LS0
	5AHxTk0/3fVOSm9v3obab5qz1KJDE5xlDtSQYgk5KbuxJBRGS72K4dqWWiXpJBi71gpLSH
	FU9p6/bX/H4vuHchcyXW9qj2AK2n8Z8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-52-k-pROOayxD_TiDb9cvQ-1; Fri, 14 Mar 2025 08:10:51 -0400
X-MC-Unique: 52-k-pROOayxD_TiDb9cvQ-1
X-Mimecast-MFC-AGG-ID: 52-k-pROOayxD_TiDb9cvQ_1741954251
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so15947805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954251; x=1742559051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+W7JLYSi3FHd5wiExWEG1bnYG61jBb9yzI4idWzEYc=;
        b=Tro3698ejwsR5UDRYv5IlD6c6fwq0RB7N4w2yxjofpjlSPkuOxAE6iP/THDidxFgxe
         Gy40PFmhrlmOqJUg6nPfGnkY4M6B2AS8c5bfhYYrqx0fvzDiPtZJanwMBh9+L4Az99qs
         d3YTM7SaFr9OzrNoSzD3ylHSgDcD68PNlBPvDtE+bpOV4eX+Hf4GFxMQuKcLnMYOAXk1
         1TPKS4aGASE7PgkLwELyZeSsEHBuBi6jOgaN21d4p6DyIVoVtsix9mgsOYk/zMkkP5fI
         4Dj2O0/lzRjJCAjyblc/RQn/n8yJcOvfmaV4j7Uq2G4hW6NEEOMH17tuuCnD/RBuiAoq
         L7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVeeqLygcViwof+HshpPYzxs29eX0wpby7v71W2RaLBBD6oLLHijg8q6Z6vS/vSncUV6sWOLqGtlsathfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmVgQSjQbjCywlBTNycBaV3hRZPPaNXfzlERLD4yxprrZXWCS
	1WYU2Etfk8yuJgPDCk2oVcxY3rTAWpttLU567U/DNDvHwajZPkOFq9R5bKPCUA6WSEDGz/Qzndb
	qn5peXN9U1VomITg4P5QBJzXVgASNSCx7+fYoBoYjD9Fsu3OLMoHkhnAyiX12DA==
X-Gm-Gg: ASbGnctLvG/C6VIob6RUq4+hc+GMz8LPZrhR3zN1qnrLlMQqhfPysg7zxnZtrfgXKOg
	5UDxNiuJQNhgBnf0JIJdT5kAdJQODLvvbQNCsPAmCh0JG6opvvTYBkLXdCSv8Mm2owLacnA8puL
	yT3LRiogvoSFkouEdyKuWq2+pzmZgCbtQBXHX6D069MRRxX/F+u0Cp6KvJTu6EEzOdJQgkpySr2
	W3tWwRGA6fibeHbrTXn4hysok5rqf2eEhhT1zooiwGvbXWQ6RZ9x+XOXGTANAr931ILcrITMAcZ
	4Hc1osZp3v7/vXWB2aUlzNpxnWhJUnoLzbYbeHUBHtgLPXw313Kr1M4IT2+yjwLLnDXqsv70geh
	LtKbGQLby8XtOUrNBoa3R9YLj/00EtxN9lOTOOmM+Zs4=
X-Received: by 2002:a05:600c:1908:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-43d1ec80980mr31107545e9.7.1741954250528;
        Fri, 14 Mar 2025 05:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoxby3mE34K41WTlTk/z5r+dIaWHqYottBOdqY1VDqMeig1kOOVvVsfUN57fluTQqQAxwE/g==
X-Received: by 2002:a05:600c:1908:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-43d1ec80980mr31107225e9.7.1741954250152;
        Fri, 14 Mar 2025 05:10:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d? (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de. [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcfbcsm15437505e9.11.2025.03.14.05.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:10:49 -0700 (PDT)
Message-ID: <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Date: Fri, 14 Mar 2025 13:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9FHEdZoYbCMoj64@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.25 09:34, Brendan Jackman wrote:
> On Tue, Mar 11, 2025 at 08:53:02PM +0100, David Hildenbrand wrote:
>>> 2. 9pfs seems to pass the f_type through from the host. So you can't
>>> detect it this way anyway.
>>>
>>> [3. I guess overlayfs & friends would also be an issue here although
>>> that doesn't affect my usecase.]
>>>
>>> Anyway, I think we would have to scrape /proc/mounts to do this :(
>>>
>>
>> The question I am asking myself: is this a 9pfs design bug or is it a 9pfs
>> hypervisor bug. Because we shouldn't try too hard to work around hypervisor
>> bugs.
>>
>> Which 9pfs implementation are you using in the hypervisor?
> 
> I'm using QEMU via virtme-ng. IIUC virtme-ng knows how to use viortfs
> for the rootfs, but for individually-mounted directories with
> --rwdir/--rodir it uses 9pfs unconditionally.

Ah okay, that makes sense.

> 
> Even if it's a bug in QEMU, I think it is worth working around this
> one way or another. QEMU by far the most practical way to run these
> tests, and virtme-ng is probably the most popular/practical way to do
> that.

I'm afraid yes. Although allocating temp files form 9pfs is rather ... 
weird. :) One would assume that /tmp is usually backed by tmpfs. But 
well, a disto can do what it wants.

> I think even if we are confident it's just a bunch of broken
> code that isn't even in Linux, it's pragmatic to spend a certain
> amount of energy on having green tests there.
> 

Yeah, we're trying ...

> (Also, this f_type thing might be totally intentional specified
> filesystem behaviour, I don't know).

I assume it's broken in various ways to mimic that you are a file system 
which you are not.

Your approach is likely the easiest approach to deal with this 9pfs crap.

Can you document in the code+description better what we learned, and why 
we cannot even trust f_type with crappy 9pfs?

---
Cheers,

David / dhildenb


