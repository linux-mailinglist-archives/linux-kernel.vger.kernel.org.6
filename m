Return-Path: <linux-kernel+bounces-408179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F169C7B76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19AD288EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8B2038B8;
	Wed, 13 Nov 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QItJuSDv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C81442F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523529; cv=none; b=dCymdjvTfvCbVF7OIkNgDfPRXVk/KPm2/wFr+/vAMXRohyWTrhc6F14B0tEHj29V99rkouxU+nex2E2xCswdj+sVGDcaab7lUYi1l8zjnBT7vZYHh9Ai6uuQwAoQ7JYn4jW3IUzUXOclBdXFCBt4GeV/xeZvjqkulcJswh8wy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523529; c=relaxed/simple;
	bh=P6jIlY9JlHx4IX6ZeVd9SGpJozjp1PyDpD5Gn4RFB+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfb9ycalhfy456S/kT4sD+5b2FqCDasBzFscpTp6qvxBSy19GlW7yE6CnI6WgliePfYVcXlebfZA31RtwwmYT/XiTfg5pgfjlA0Jwk7tNGrJmVJQoPQF4pF2PGyVX7NdlxJ+HoDny1u5N6B+zBX/abKeyuHN4eOlDGP7XMw7R8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QItJuSDv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731523526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oiRy7tMpXqzMBxF0V5M1vZe3r1wcdUHw4HgsZMbQH2Q=;
	b=QItJuSDvG0vJbFkNM5niv2FCV/MNC1rhDSzdZ6GVtbXk2O9iH8P/oXmVlJhvDIuUSTxhxg
	vH9DditRSuv4O+FFMVIu9WpOX8a5Afl17/tq35pU1pBKbTjSJaC2XNbE0zGwV+8djTcgJy
	dhkcKHQSFCQ3V2eaKcWMFz2++IJvcpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-kS-4122DMn-pweVuj6A8Zg-1; Wed, 13 Nov 2024 13:45:25 -0500
X-MC-Unique: kS-4122DMn-pweVuj6A8Zg-1
X-Mimecast-MFC-AGG-ID: kS-4122DMn-pweVuj6A8Zg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so50140865e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523524; x=1732128324;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oiRy7tMpXqzMBxF0V5M1vZe3r1wcdUHw4HgsZMbQH2Q=;
        b=ol0PRCCbb0jS0OCOcrbGfXebGu15lnj+OciYYVxhPebyNc3HJPBhLSIZEb+NwSNv6r
         osUaC6GqG5ejrzDcHUpQJn/CpQEitDSVN/J+9bKPfpovlp+DEGgI64D55hAQcv0oOzNs
         IwuynB1XyW9gIVBct+gvQWolrY3ugZqLqDdZqOrz6RPb5Lvnii7q5EArWU7IcVzOLv5L
         WbJGc5JXuTaodcbmnLZYkRIZCqyLNDLHKKpu02WvCxfLuRmmvf0g7vkh/qedskW+S4Pj
         sdwqtWksqPT/fuy9SwZd4fXor7iW1h17Nemc8iJYfN54rvjOtdOlLpwR9K12AICb0Lax
         Hqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWVD2+t4kwRgOua6WLM+alv36s+eI8F5/F6eXPDPAmou5FWaXIXeH3g7F6CpuSFuv3iI9ygFSCpC9fWWaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAddP+68QP4SL869lnKFRhLWb2wB3eK1iC5KmgivhntAl2NEe
	q7moxMyMcS7nTd2gddYPI/VH8KxSyhvieSzodpUdtwjAdStzyfgpnSyRSHxi34GE3gv4py9QBRT
	+U2CKMof2eqC88LijRTRwlnZvRVYAnf5mcOC851C4XVdPFZQuwQfp4ES+bpFALw==
X-Received: by 2002:a05:600c:c08:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-432d4aae6b7mr42155425e9.10.1731523523049;
        Wed, 13 Nov 2024 10:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdMZHL+YKk/qd9EVqmBiiyqPXnVJueSChXwtWqIhdBqK0IgMFXLo997Jor7MXgVsm2UQyemg==
X-Received: by 2002:a05:600c:c08:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-432d4aae6b7mr42154585e9.10.1731523521172;
        Wed, 13 Nov 2024 10:45:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2e0esm34971275e9.2.2024.11.13.10.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:45:20 -0800 (PST)
Message-ID: <3ceb9fc6-47cd-4715-ab86-517ed873dc04@redhat.com>
Date: Wed, 13 Nov 2024 19:45:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
To: Peter Xu <peterx@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Nicholas Piggin <npiggin@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>, Huang Ying <ying.huang@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Rik van Riel <riel@surriel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Oscar Salvador <osalvador@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240812181225.1360970-1-peterx@redhat.com>
 <CAG48ez0NNph0Zp2aZ+c1T+U940CvwxcQ+jyEhp3KYZLSWPSrNw@mail.gmail.com>
 <ZzTWQqr-zFQz0HHY@x1n> <07ba2a86-f22b-43aa-a542-f1a182656b63@redhat.com>
 <ZzToT6kkN0kkh-ww@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzToT6kkN0kkh-ww@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.11.24 18:56, Peter Xu wrote:
> On Wed, Nov 13, 2024 at 05:42:15PM +0100, David Hildenbrand wrote:
>> On 13.11.24 17:39, Peter Xu wrote:
>>> On Mon, Nov 11, 2024 at 10:20:59PM +0100, Jann Horn wrote:
>>>> On Mon, Aug 12, 2024 at 8:12 PM Peter Xu <peterx@redhat.com> wrote:
>>>>> Dax supports pud pages for a while, but mprotect on puds was missing since
>>>>> the start.  This series tries to fix that by providing pud handling in
>>>>> mprotect().  The goal is to add more types of pud mappings like hugetlb or
>>>>> pfnmaps.  This series paves way for it by fixing known pud entries.
>>>>
>>>> Do people actually use hardware where they can use PUD THP mappings
>>>> for DAX? I thought that was just some esoteric feature that isn't
>>>> actually usable on almost any system.
>>>> Was I wrong about that?
>>>
>>> I did run it with a qemu emulated nvdimm device.  Though in reality I've no
>>> idea on how many people are using it..
>>
>> I wonder if we still have to support it ... or could disable it+rip it out.
> 
> Note that in my previous email, I also mentioned mremap() for PMD on dax
> too.  If that's a real problem, it won't be fixed even if dropping dax PUD
> support.
>

Very true.


> And we definitely want to understand whether there're still users on pud
> dax to consider dropping anything.. it could still be that both mprotect()
> and mremap() are not yet used in the current use cases.

Right, but at least NVDIMMs are getting less important. Just a thought 
if this is really still worth having.

-- 
Cheers,

David / dhildenb


