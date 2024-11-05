Return-Path: <linux-kernel+bounces-396109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853699BC7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F44285A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8BC1A7AE3;
	Tue,  5 Nov 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROVhE0NA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8918C93B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795036; cv=none; b=awfpvq7dUCLpugDGvoJiWmAcjzo8RYJHPPuKU8K7Ks+f/6ZNmID87wteB/e+4DU4h36yJVwyflZjC0MgL7kT8YSxTc6mtzEOJOx+R/aSqDS9UPR/RU48m2bZKtwvwzOK2PUTPg1IIR1y5ew8Ce9eO3iUTjUCkQtJv4M8eHXnULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795036; c=relaxed/simple;
	bh=uuEt8/042L227jK4nh2Huw1k+Sw6eFHXJ5CXZydCoOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WysGQ72fmwQW4XHGOAQQxXNshnYZS1xIRPs+BannEuH4d6o4jDi5z7zosCIrAjQExSVmhaBgxnylYykrJlBs+aUCxz42llp90WESqJYiX+Nbv2nd5pYIjScnfrwK8lvvGWw5ZMbYdVqwm2pvRp3mfy3czHfaWBtmuICEdJjYiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROVhE0NA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730795033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D3W9QAvUAkm8NsIy4KlN33IRVJVPTiio+py5miU0660=;
	b=ROVhE0NAcrGRnkuXfXZIgmVup1Py+7gsC/dIxY/Z/many0A+Xj2I7Due9fwJ3Dc331mUOc
	zCtijwmA4WmElmh3iGqhwRpd4/2VjTHwKYXWhuwYU9YG4ph/WgI8CChB8PQMe5VI+PlwDb
	ELXjkNyFu9pLb6v5DeY/G21gAD/ppyQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-FRCsK14nPQG1Z5SR1EJxhg-1; Tue, 05 Nov 2024 03:23:48 -0500
X-MC-Unique: FRCsK14nPQG1Z5SR1EJxhg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d67f4bf98so2315400f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795027; x=1731399827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3W9QAvUAkm8NsIy4KlN33IRVJVPTiio+py5miU0660=;
        b=QggEkUExUP3VYiN4L3RPK6OdV2rSrLTznL94dNRJlbj8O6k2gG8P65ktvN67LaluqK
         IhXHGMmJ84v5gu9A5AP0OGO/Osv1pujAwe0XndkSexCEdZ5c6DhYRQgz3EPOcZOgrqMi
         8ThnjhJ+5JdahD/29Xe4tBntEthdByautimkylgMZV/bLom1OEMFSVu1BiWyGPW9I2TC
         su3L8xQKx7Yn6RRUpokCztL2LJdX7Z0wu8xfG+qu7RyGPIZ3Md9nDx9ka5rClAdtXQck
         4NdlPlI67hybNTet3GObjfPVpsTlbv2+Mqqe4hCX2lO9v8UeDVtCCo6AJKXQUIhb6YXX
         pxQg==
X-Forwarded-Encrypted: i=1; AJvYcCXFYZRqeGJ/WKuuFP5H4aLwYM+uLQQc7fLT9zgia4CcRN+Hl5M2ywWW/+d0x0aP1MJlw8KO11cSADhmsKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx761Y06kx0jRYnPqelb20w3mYVXU0SlKDH/iMYfeoJukR9oiPH
	uZL5dIe6wEZ0CPwNfMTj5Y7QYbUnE6vlcYIllWQWE5AwZ0HWepGQwfxvQN10/sSeEBxgrFkopZo
	Bd3AnGxSvfH++sZz6dvAgc0ZEwroyUILGWELiGiPCHYUJmYELBrbVY3F49G/PtA==
X-Received: by 2002:a5d:4a43:0:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-380610f2ac9mr22723747f8f.3.1730795027471;
        Tue, 05 Nov 2024 00:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhz3UIoLTr/cr22juXFWLt3vXvnPZom+pIhUJv1eZPMHW55+NBBrRX318pklVDru4zeCHj6A==
X-Received: by 2002:a5d:4a43:0:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-380610f2ac9mr22723719f8f.3.1730795027013;
        Tue, 05 Nov 2024 00:23:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4387sm15372731f8f.42.2024.11.05.00.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 00:23:45 -0800 (PST)
Message-ID: <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
Date: Tue, 5 Nov 2024 09:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
 <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
 <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.24 04:40, Andrew Morton wrote:
> On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>>> As mentioned above, this isn't about fixing a bug; it's simply to ensure
>>> that swap-related metrics don't disappear.
>>
>> Documentation/process/submitting-patches.rst:
>>
>> "A Fixes: tag indicates that the patch fixes an issue in a previous
>> commit. It is used to make it easy to determine where a bug originated,
>> which can help review a bug fix."
>>
>> If there is no BUG, I'm afraid you are abusing that tag.
> 
> I think the abuse is reasonable.  We have no Should-be-included-with:.

A "Belongs-to:" might make sense, for this kind of stuff that is still 
only in an RFC. Or we update the doc to explicitly spell out this 
special case of using "Fixes" to sort out something into the RC.

Because if this would be already in a released kernel, it would get a 
bit trickier: stable rules explicitly spell out "fix a real bug".

> 
> 0ca0c24e3211 is only in 6.12-rcX so this is the time to make
> userspace-visible tweaks, so the 6.12 interfaces are the same as the
> 6.13+ interfaces (which is what I think is happening here?)
 > > And including the Fixes in this patch might be useful to someone who is
> backporting 0ca0c24e3211 into some earlier kernel for their own
> purposes.

Just to be clear: adding new counters would hardly be fixing existing 
tools that perform calculations based on existing counters. So we are 
already changing the "userspace-visible" portion in some way, and I have 
no idea what in vmstat we consider "stable".

But I still don't think it's all that big of a deal except in some 
handcrafted scenarios hardly anybody cares about; the cover letter is 
also pretty clear on that.

So I'll shut up now and let people figure out the naming first, and if a 
new counter is required at all :)

-- 
Cheers,

David / dhildenb


