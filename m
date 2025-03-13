Return-Path: <linux-kernel+bounces-560467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC3A604B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA0E169892
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871E1F872D;
	Thu, 13 Mar 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMEAmqCp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C21F5821
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906147; cv=none; b=PG/iJPWSyj4HIoo9hLfK6wjki6DdFkB9N4wJA0mB46Fi22pCPGfNbaY4qCJMecVnqUPL+eLhzElV4FohbokU10DzVmO1lrH6y6jNvx8MntySCVDcOB6CG+HqG1IhGEvTKK02wIBj2/uFY0urDgOHRDR1EKkQGuruoj3sFTWPbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906147; c=relaxed/simple;
	bh=g1HwSUSKFCcVkzS0STeSerOR+B8LjSd8qQZWOXVNJvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF2hhIbmMQ+dr6CcRWTTgMjIuaneJ46Zhy8Xy70XAgSg4KhFlX3K9jhQ3vA2ZeAvOpb3Bh7LLhAC64ZEGe0MOD+ZxLaUHEiM9jpQWnaKzrudIngALWIIZnfRhxhgpR7fiUt4CxdCv8dUVuoLCp7LrpF0JTKg2IvGMVKnb4UtsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMEAmqCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741906144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fNx6s3/J07DS7ObLj5D43SvIYaGPnmaHjq5aLXmff2A=;
	b=eMEAmqCpoLRTf+mnZ/5v/MQz2Xah8yc0BJGV3pB8+gGtqF0EvqUH5YdrlOAU3m3GlXsFUp
	Z2iJgmWsJtXmXKorhjeiijNdmiAPzWy3u94GW45Fz/D4hR4kQ0MYZfZzCRPxSy9E8UZIT1
	gocZcYwSCbrkmmYHJXQzqBIvuVcnod0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-qOY-sbHeOLORlpeWmxhvcA-1; Thu, 13 Mar 2025 18:49:03 -0400
X-MC-Unique: qOY-sbHeOLORlpeWmxhvcA-1
X-Mimecast-MFC-AGG-ID: qOY-sbHeOLORlpeWmxhvcA_1741906142
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so10834165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741906142; x=1742510942;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fNx6s3/J07DS7ObLj5D43SvIYaGPnmaHjq5aLXmff2A=;
        b=DUhmP/vpAS7tULsXgeIJRZVmY49GVi4OomyRp4IHtN/8OmpgM5HDPNiX+spQCZg1MG
         cb8C4AzPqg+xjcK+SvGEoYdGXPj9onezhGzbV5km+UNTMUoMOCT+b4TOSJQWjHF5WRDJ
         4pMoGcfv/lAktBmy3AuxT5pQS4LZ4La9aG/pbTFt2/94BrKwn/O1bY0xGmaBNpuga3fr
         ECfh4t42eQx6t5D9hV+q4a4nvgqH4x4/8tK6a8cc0UyVxxjnYT/zCi22l3GA+Zxc2efJ
         VWeHfztrPK6TlTGAFgqpKWxQ4lCvUTM4ttn8Pz1hy/db83/UsTKLQtJ83Nu3dL8TpCsT
         2CFw==
X-Forwarded-Encrypted: i=1; AJvYcCUCW/TOcIeaQkRbhDJ65jmP8Kpp2DGIyOzqdyQFKxCj+bOLl+hPSyW5T1OZR6AesQqNVnYNlxDo1ZSGEfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbN7hU2/Rpbv6dunvwlZWmhzA7XRB5RJU8RAFD3tM9f7CK2O/P
	4SBV9DAOan/YnqeYLl9MDK7fpsvWLMqJN8UQ17/0/whukGMeyv0h+uX+8q4caqxc8rEs4BUNVuR
	rcBMXQfas+37M8ZKx18nDqfxLPrayXBRMf7XvUAm0QI0uYuMuYuch3inivbcZnGdTimU+Znaw
X-Gm-Gg: ASbGncvR59Ks/zVKsNlBq0aS94p1nYSEvMaMHOWoyL4QNoFd948CnmvyojjyF3lMFRV
	WorfJZgQvFtdozpfywz9Aqrr9V1EgxqqX0HmG2GsGoxu+5h+1mGlVu/qr2swO1S6/51QdeL28aq
	minTAep+C+hQvglFngW8UFqdf3MgtXgB7GSeedVfompKvMlM9+rDqlXQ9BRU3rVRtae40582FPz
	9tzoSA9bSTJVd3vMKm2wtZBR65Wd5T3RsVf/osX6P1QJlOaQTsP4Z5ZH26vChAtVbvCx2DnAjyO
	kVVVUGrdf6v/uP6bzxgN3NGzCkZX83zPg55KOnC2HiSzwHcX4iMQfIXZw5Cj9Fca+KXDp2GwX/c
	5M490r82HQl26SLlCQHJj3YTXEJwBrwM7Q3iOutYP
X-Received: by 2002:a05:600c:354d:b0:43c:f470:75df with SMTP id 5b1f17b1804b1-43d1ec62221mr4569535e9.3.1741906142099;
        Thu, 13 Mar 2025 15:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUwMZox+xV+pcOJHlgdYjfbekjvUxim3egvkV3xAysHIT4juylMW5S4p8Urr9Tnmdha0VrwA==
X-Received: by 2002:a05:600c:354d:b0:43c:f470:75df with SMTP id 5b1f17b1804b1-43d1ec62221mr4569365e9.3.1741906141729;
        Thu, 13 Mar 2025 15:49:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:3600:463c:fbbe:a2df:efd? (p200300cbc7423600463cfbbea2df0efd.dip0.t-ipconnect.de. [2003:cb:c742:3600:463c:fbbe:a2df:efd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b0cc7sm34766725e9.3.2025.03.13.15.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 15:49:01 -0700 (PDT)
Message-ID: <cd013218-7735-4bc1-b6b6-80d1129e2b76@redhat.com>
Date: Thu, 13 Mar 2025 23:49:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 jaewon31.kim@gmail.com, spssyr@gmail.com
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <Z8tVrOezU2q_0ded@casper.infradead.org> <Z9GmYe-bdOZ8LQV5@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9GmYe-bdOZ8LQV5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.25 16:21, Christoph Hellwig wrote:
> On Fri, Mar 07, 2025 at 08:23:08PM +0000, Matthew Wilcox wrote:
>> Howver, the problem is real.
> 
> What is the problem?

I think the problem is the CMA allocation failure, not the latency.

"if a large amount of direct IO is requested constantly, this can make 
pages in CMA pageblocks pinned and unable to migrate outside of the 
pageblock"

We'd need a more reliable way to make CMA allocation -> page migration 
make progress. For example, after we isolated the pageblocks and 
migration starts doing its thing, we could disallow any further GUP 
pins. (e.g., make GUP spin or wait for migration to end)

We could detect in GUP code that a folio is soon expected to be migrated 
by checking the pageblock (isolated) and/or whether the folio is locked.

-- 
Cheers,

David / dhildenb


