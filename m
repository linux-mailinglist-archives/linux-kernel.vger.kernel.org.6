Return-Path: <linux-kernel+bounces-572847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3204A6CF53
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4927A59A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5E747F;
	Sun, 23 Mar 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTtRkK1N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B01372
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734154; cv=none; b=QSg7K763udqNybfJRNAhT3X3ZTaj2yoZAui3E7H0Qt7ljOgesYZ2KD7dEbiiNEVQxfEqFM5dxWd4bgV/ejFejlpHTDlAOeeKO4GuMvfYoncaxMZglsqmYXta425/+UuA0mXsoD2AJlcrcDA63gBC/oB2h63mabKaDTUFETMBMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734154; c=relaxed/simple;
	bh=VeyGLHXlepUyQYe0gSbT0JZc6N+SnjunAuHKqqyp0fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJymf+D+CCbxtcC1nS+KDIT0JMSXQfeK5FfuAKIu8ub3K5hMRrmSCwwxFdzcBfJsY/5FQw+wHEE/M72NZ5SNRLENkZQTxKHs06lQbJ5dSjUmsgYbtq4Toav+ufxDheNgd77yYlwhtkwLKcvSs37o0Dl+Gt9kRFCt00WGqM3hTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTtRkK1N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742734151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+KfZtvGFEBhVSDBviisjwkVa4EcwJVJTGPuAJwAkSlM=;
	b=iTtRkK1NoGe4/wYHO9jO+MZ6TyhU0QtojRxQKF5dIRTFjEyGJGxNKrC3H0gKF82N1TiTux
	voYMkZMq8VNJetGdcvQj4Kse6RQFIAiXDeJhgtaoI7uUoQe0N9XkUKI0PxJA4cw54PFjaB
	FMaGjf6niprkMwt9koORJYXGMIn8j2g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-WK3GNAXbOj6YBuhzzaRRLQ-1; Sun, 23 Mar 2025 08:49:09 -0400
X-MC-Unique: WK3GNAXbOj6YBuhzzaRRLQ-1
X-Mimecast-MFC-AGG-ID: WK3GNAXbOj6YBuhzzaRRLQ_1742734149
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8fb5a7183so68905026d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742734149; x=1743338949;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KfZtvGFEBhVSDBviisjwkVa4EcwJVJTGPuAJwAkSlM=;
        b=IHzGyO6v953uo2I4HuRZMjZPNubbwbjU+fPSQIAtsBZ0+dPVbPSIkMPcl3mEGpq2Wa
         AmoAUuoUSyFfWPqmxZZEpolHGXW4RdXLL9lNm6Jsg2Se2lEppi9vFQeji27HOsksAEA3
         83JVh3BPD9AluqsbWWQIyEsHps7njjh531u3FHONY5jx6YGOB81gLL3AfGlEg/MGEC8N
         wiqLc9z0pjZfG58q4dTbHTq8Yi24pQ8tU8fywdcM6yhD6GdYEyX0SQFEd4Z5DTiHirhO
         K9vL9FO3Xa3zLq8mvLSc8pkk0rjLf4IlJins01GwVL1xIqKaa43Fr1nktZ30pNM694S8
         iyBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXn3sESgew8W4NXb0Z/pAOFDrP2ynt26F+olvcbTk6g01I5LTsJHaslmIVeK82snXLTsG6E3QD49kLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqaRfbZxUsl7nXcQ9hyo3a9AO+AT9gms9ZBtEhyWMvU4qXzH6
	+eL8xEPHQerKTfkl4BP7SQmVWe3sWwk0wBeem8i0+1BZYzf1cnF/xcTEZ9K+QU3UiW2PRevvIzS
	MdDOvBCDQANYev43eNwyLXSfrTbGH2s1l+bK2ogv02ZqZ6YCwUsGoPNLWNM5TPA==
X-Gm-Gg: ASbGncvWEn1U7D244pa+wT6y10whejhKcpGlGYz2JaaJL3cJpO8hgOf9h7j0cJsSZ/s
	6N+k+WvgYVP9bjmmhAPp3fNH/2GDGWp6Be2pu0dVUVpquaQynewijfC4I5+6Khp/bsPFQzLIso0
	ZJ9NJRkKMlj5erwtCiYfXcCi2lUWQ0tY9z7P0ZaBGVyCqW7nM4hbDIWsuwZdpoy7SkbWMQxs66I
	DwSXeYf2vZqfSzV/G66mlbUskbl27u41+PaJPbiWznkZv6vJYR1RPXCYlGQFBpAPOvgwTkDEVCC
	SS897SVB14jN
X-Received: by 2002:a05:6214:e8f:b0:6e8:fde9:5d07 with SMTP id 6a1803df08f44-6eb3f2e64damr142190786d6.26.1742734149166;
        Sun, 23 Mar 2025 05:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh2AcKiivrYbdeuvt608beQgMG/MFLv9xmyrX0d4FyrJg7aRayVv5rJNsWQgW66isOCYLYjw==
X-Received: by 2002:a05:6214:e8f:b0:6e8:fde9:5d07 with SMTP id 6a1803df08f44-6eb3f2e64damr142190506d6.26.1742734148800;
        Sun, 23 Mar 2025 05:49:08 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc568csm31413556d6.92.2025.03.23.05.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 05:49:08 -0700 (PDT)
Message-ID: <335b3432-af06-420f-b575-7a1d92148f6b@redhat.com>
Date: Sun, 23 Mar 2025 13:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
 <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
 <2bdf7ac4-b359-420f-94fe-466ae98c4a49@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2bdf7ac4-b359-420f-94fe-466ae98c4a49@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> c)  In -next, there is now be the option to use folio lock +
>> folio_maybe_mapped_shared() == false. But it doesn't tell you into how many
>> VMAs a large folio is mapped into.
>>
>> In the following case:
>>
>> [       folio     ]
>> [ VMA#1 ] [ VMA#2 ]
>>
>> c) would not tell you if you are fine modifying the folio when moving VMA#2.
> 
> Right, I feel like prior checks made should assert this is not the case,
> however?  But mapcount check should be a last ditch assurance?

Something nice might be hiding in c) that might be able to handle a 
single folio being covered by multiple vmas.

I was thinking about the following:

[       folio0     ]
[       VMA#0      ]

Then we do a partial (old-school) mremap()

[ folio0 ]               [ folio0 ]
[ VMA#1  ]               [ VMA#2  ]

To then extend VMA#1 and fault in pages

[ folio0 ][ folio1 ]         [ folio0 ]
[      VMA#1       ]         [ VMA#2  ]

If that is possible (did not try!, maybe something prevents us from 
extending VMA#1) mremap(MREMAP_RELOCATE_ANON) of VMA#1  / VMA#2 cannot work.

We'd have to detect that scenario (partial mremap). You might be doing 
that with the anon-vma magic, something different might be: Assume we 
flag large folios if they were partially mremapped in any process.

Then (with folio lock only)

1) folio_maybe_mapped_shared() == false: mapped into single process
2) folio_maybe_partially_mremaped() == false: not scattered in virtual
    address space

It would be sufficient to check if the folio fully falls into the 
memap() range to decide if we can adjust the folio index etc.

We *might* be able to use that in the COW-reuse path for large folios to 
perform a folio_move_anon_rmap(), which we currently only perform for 
small folios / PMD-mapped folios (single mapping). Not sure yet if 
actually multiple VMAs are involved.



Just throwing it out there ...
> 
> (actually at least one of the 'prior checks' for large folios are added in a
> later commit but still :P)


Yeah, I'm looking at the bigger picture; small folios are easy :P


-- 
Cheers,

David / dhildenb


