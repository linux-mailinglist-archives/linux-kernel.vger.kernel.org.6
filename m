Return-Path: <linux-kernel+bounces-257229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964D937716
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAA01F2256C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83A84E14;
	Fri, 19 Jul 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGM8Q98R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798067E1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388097; cv=none; b=axMDfeymPxbur8Cyty2NRrwAauspf/aNgdHJ0F1nRrXNdfzdIFBqOKFQBGkfsFdHK4rOKaLzTx1UMRvTEdm2KUhsckrOdrMBHHUOox9jaGWGPUrufV4hXMYiQ5EGkk7JD+bYWMDnStbjjtaEtI27mww8r4q/gA16kX5GiSJQvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388097; c=relaxed/simple;
	bh=PMEVbFOQNq18WIKjBtadWpvBzSWq8XES47zfS0YR5pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1YGcM7heIxpy45HtVdoomPxqyx0a8HKFkfS8anwMLxOhlQjzhW4ozagIfsHM9f0C9Bu7VdlS+Fa36cbdz9LQHn3Tzn1EEXeLw6Cvo/LQUuU81vVKgnd3QsKq76pdSHjKXQD15UWdSZUa3l7it3uyWeTHduz+xEVZGwbmaUqJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGM8Q98R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721388094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5V3WgPDgstctXzSrpFv5YBGi1RZvncZTjdlZUKmQ8KI=;
	b=cGM8Q98RbUkcBdj8Ld98OaWphRqQgvhFBsdQHA1byBl8bxAbwsQC+ulzhGus4R937PyH61
	Fhn3K0zCU95tndpxjN4d81l1q4okvuSkIB0+iLL75lYCkoMUaI//SJv9sld+bj5gzk4WOW
	dPnS6ra1bdPbp5G/FnYMLUNNcNQGRnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-96dzzsF1Mfy2A5ympZ-9bg-1; Fri, 19 Jul 2024 07:21:33 -0400
X-MC-Unique: 96dzzsF1Mfy2A5ympZ-9bg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso11122125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721388091; x=1721992891;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V3WgPDgstctXzSrpFv5YBGi1RZvncZTjdlZUKmQ8KI=;
        b=kBXDxfhWn0AzxVP3NbjmJaVjl8VrY1AdnvfFE9sNQC7c4lF047H+32O07K838enNZy
         FKJ7kKzm72I99YhWWrtWSZnTK5H7bh45eeoCWAPSVkN9Yk4RJ44rJ/yO+/I3V1NtYELQ
         Fjh6xH6/+WB2B5KmcI6YfqgxzIQ5Q+1w2bVsNhYNc7yJ2DoXdbt+OII/joxLNc4RgtNu
         VX+S/m0XiMsqn2snOzbdQQGl5Px1LXjT+m6jRv0CcaFrip3cUvlhlqLcYjdSNIesdWgL
         50TgFfM7F0nmyLdvOYQ3EaP1BgKepHr+seR4Dt+2Jnx4SXf0UM4KnD/0j8oj0GmPQKqw
         jKkA==
X-Forwarded-Encrypted: i=1; AJvYcCU3PCdywKwE3dTydcd1m6NzO3N+JZLanxBOkce0MYzfB/EYvMel6Wfg+OYDIgzNFR/pYRY92UYmVAXI6L36tZ87Yyw/T6Qe2/Px16eF
X-Gm-Message-State: AOJu0YxEC2BfPLLd1bWp1k61sh2b4eMebXVHAds9n/M9ErAxl5rneqAj
	T+JzC6C2lPsEXGumOq3qry7FwLgc2G/4ecmTzgv+zdzfqm6S7KjCV83usGU5SMZkzJ1WeAq3isl
	HX32GrUzueBdDfiFxHNFKNCI/LCh1Gg5z0UgpchEK2Fr1MwCIRDjGybgu5MFojA==
X-Received: by 2002:a05:600c:5801:b0:426:59ec:179d with SMTP id 5b1f17b1804b1-427c2d00125mr52806175e9.38.1721388091709;
        Fri, 19 Jul 2024 04:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7K3GZ0ZdmvjpfxRPvu+KPNlluSUxqvnIjoh7gFeLISbeNwmx+0WFpZMBU3/iF3REKnJhJ2Q==
X-Received: by 2002:a05:600c:5801:b0:426:59ec:179d with SMTP id 5b1f17b1804b1-427c2d00125mr52806035e9.38.1721388091318;
        Fri, 19 Jul 2024 04:21:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1000:c4af:a24f:b8ba:8bbc? (p200300cbc7051000c4afa24fb8ba8bbc.dip0.t-ipconnect.de. [2003:cb:c705:1000:c4af:a24f:b8ba:8bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b8ccsm49388855e9.2.2024.07.19.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 04:21:30 -0700 (PDT)
Message-ID: <9e26dd3a-f983-4d54-b162-52a9938d0dcd@redhat.com>
Date: Fri, 19 Jul 2024 13:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <000000000000341f5f061d8d6bcb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <000000000000341f5f061d8d6bcb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.07.24 00:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11321495980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e054e980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000
> 

The reproducer involves udmabuf. I suspect it has to do with it.

But I'm curius, does the reproducer not trigger before 4d145e3f830b on 
mainliny?

Viveks changes are not upstream yet, but I can only speculate that we 
have some issue similar to the one we had with hugetlb: udmabuf doing 
things with memfd/shmem pages that it shouldn't do, because it doesn't 
"own" these pages.

"udmabuf: Use vmf_insert_pfn and VM_PFNMAP for handling mmap" might help.

-- 
Cheers,

David / dhildenb


