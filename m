Return-Path: <linux-kernel+bounces-441319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7489ECCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7576516635D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC622ACCA;
	Wed, 11 Dec 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwvLGGxO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BE225A54
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922274; cv=none; b=LzB4RwR5HtPd1+wt8fx/cx6woMSIzRyERLaClO6FnzmgZLI735YI5rSA9JOxDs5DBCnCEQoY98cuND9HHtN6cTTLFqnyHjhghZNvksm8Vo+GvTl7A5u2xvND/BGnwTd+bu8ESjGzLx9gwmjxcXDF7pjuTB29uU2CY07YYhyW+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922274; c=relaxed/simple;
	bh=v0tMV0+yizAI9tyjbNbHiBG+dO9e/FLJC2l8vqabUug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k5M9BqapNiyYGki+1qGTvcGJg9UQ4SdRX6f29pnJVMfMVL22a55rIXfcqBd9PHzuXlLFnyeFqc5Z6XoaoWRFACzH/mB2p5W616PIaSfOggZsYdOLKqI32+1FRgOlyhRmDAfYeSjmCnxNqv6+bijbTLmQPUSB+zVD0wAWtUut/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwvLGGxO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733922272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pP+oty7rblXvodud5kX45/ESThaHOT5Q634wHnRNkmM=;
	b=LwvLGGxOWQddQGaZE7GaJ5Vc95Rgjkb+dNkOO1tjfSv83uvooThWQXOC+u+GqAi9bPTfXW
	clcDOw1vAjrQ3NENv7ktCS7HYiWh3bxifcMQoRYipg2EFQN86RjGU7sUvJZzZ6wxRx2c7S
	35QqacLap5amQKkYyCA08rH0hUnxtlk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-HWpmiAsvNqK1pndatuUGwQ-1; Wed, 11 Dec 2024 08:04:31 -0500
X-MC-Unique: HWpmiAsvNqK1pndatuUGwQ-1
X-Mimecast-MFC-AGG-ID: HWpmiAsvNqK1pndatuUGwQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434fb9646efso26956265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922270; x=1734527070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pP+oty7rblXvodud5kX45/ESThaHOT5Q634wHnRNkmM=;
        b=p7QgDCZuOvyxRFevAZo+9vRmBvQBa6fd8QQvtVTUl9i+vGCdiTfj43CsSkV8dYdIcY
         vzQt2nTNNrsET2bQWwTrc15LKGWm/XRrmcXp3L0mmIYbwidcwsD2Q+OwLy5fDZ+Soj5T
         GeJEYVuVC1RdeEqCMjX5XOOfeNFhSG9riGvAMVZufDWJkmUoI8Q+qTwDQXWJoZy6aby6
         Iv6BUH5ZjJXdpYda01d+I6/vd+3Gw9W8NLWJ2rjDMInPaING+X05Xj69QtCM0S+1L4gM
         Jezh/vAsv+YbcedNymittv3WLLbJOq6yjXEFV0IuYAGf4tjlHrfWjA5n9cX/LAcrh6qP
         M18Q==
X-Gm-Message-State: AOJu0YwXttu/1kifMGsR4QA/RksBrMCjhcpH7kqpHs6LmCxvxccP6z1m
	wszI2mIG8tHhGZAAOqMEb59XVI80DiLqy5LdDft/PH3i1mMRCKRQoCdHMPdo9x18XJNYFRDO1Bu
	w+KOHIxoWVPOrgiQboRKOi2c8yfGRtmptljKgs7v1p3amOlsb6LJ0H5pjDgC/uw==
X-Gm-Gg: ASbGncu2Vw2Wxe6ogSGZNEvlYO4wDkC+TKZjF9LrqhGeTweQJGQdhvBD/QeO2230uGN
	IVnL7DtAi64DhfehbDQTmx2Y1swGCVny8WK+ulwqGIMd/WNimacvaJSPa8oRQPaIt0mpQQM3X35
	TqeGJI1I3zL8m0i+J+QO9Ckf61zARdNh9QyOEFll8FoKcy2Gkao12EgAcB3RrToz5n2oWjEuMeN
	hctb7iGCLdbRThYzyA9xyTZAevv4KFgrIG4CdIMpq3KDhdC04FZcyOy2tajISYY+UrTmagSPvt4
X-Received: by 2002:a5d:64e7:0:b0:386:857:cc54 with SMTP id ffacd0b85a97d-3864ce7fe32mr2252070f8f.9.1733922268311;
        Wed, 11 Dec 2024 05:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMAQepzT22tbw/K+RGChQqrxtSY0EaW0jiP9dtZYMLRVzWLBUSNUYzgiUc0NKi+4KJZtawpA==
X-Received: by 2002:a5d:64e7:0:b0:386:857:cc54 with SMTP id ffacd0b85a97d-3864ce7fe32mr2251957f8f.9.1733922266373;
        Wed, 11 Dec 2024 05:04:26 -0800 (PST)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c2c9dsm1245687f8f.54.2024.12.11.05.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:04:25 -0800 (PST)
Message-ID: <c741e6c0-6a36-4402-b818-ff55399397fc@redhat.com>
Date: Wed, 11 Dec 2024 14:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
From: David Hildenbrand <david@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
References: <20241210102953.218122-1-david@redhat.com>
 <20241210102953.218122-2-david@redhat.com>
 <20241210211613.GC2508492@cmpxchg.org>
 <d6a79fa6-dcc1-4181-9946-940a91c0b1f2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d6a79fa6-dcc1-4181-9946-940a91c0b1f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Having a function guess the caller is a bit of an anti-pattern. The
>> resulting code is hard to follow, and it's very easy to
>> unintentionally burden some cases with unnecessary stuff. It's better
>> to unshare paths until you don't need conditionals like this.
>   > > In addition to the fastpath, I think you're also punishing the
>> move_freepages_block_isolate() case. We *know* we just changed the
>> type of one of the buddy's blocks, and yet you're still checking the
>> the range again to decide whether to split.
> 
> Yes, that's not ideal, and it would be easy to unshare that case (call
> the "split" function instead of a "maybe_split" function).
> 
> I am not 100% sure though, if move_freepages_block_isolate() can always
> decide "I really have a mixture", but that code is simply quite advanced :)

I played with it, and I think we can indeed assume that 
move_freepages_block_isolate() will always have to split.

-- 
Cheers,

David / dhildenb


