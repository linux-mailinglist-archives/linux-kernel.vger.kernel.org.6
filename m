Return-Path: <linux-kernel+bounces-433592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370D9E5A43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095F428684C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6A21C9F8;
	Thu,  5 Dec 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/USAT8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B921C164
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413975; cv=none; b=pqFnJ2RbuP0jaVmzpba5qU2c3e3ZFuL5DpqpZr1OEKjvuQINf2tCJjEClMX9YGa5L3yP/BjUNFkztk14kuiyDhe/EdfYlGW8yVhxANWU79LFJrrbdNtO1KmfnXMUciuX7kE5sW87yOZ6KDnsBXAVmjlyHs5oxK3uXKA1iMTQp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413975; c=relaxed/simple;
	bh=1AMPvjJGAkhd6iZY1/Ml5FGvqBe+g4POfJzEID7uGFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjrJg1PGx14sOXXNJ4tBumMlfJ+fj3729Ih2UCmnfxoqlasEzoVQXUwLLpuM2Q22c2My7DBMMBAaLeM+KrFyzELNj2V3s7ypAiKGFSJAk54Q0PsBkJzIMuXmlWf7rW0GIYX04T8bq7TGDQe4F/eW6eqZN9ea7BV51ey14UJH1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/USAT8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733413971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s85aLpWly0hO0+a8798HPivHQxmtFwjHj6n2eenApWU=;
	b=G/USAT8o+POp1EbJb8c4y7fPP8DoQbjEqof+bCR97Z7iGlcwXkkE/J8BKgg7SXd26xR1ds
	Eg1r7VEO/Ek8wvsJRFrVJ/Zukc3DwfggRvO2UOxBXwU+HkAFibIvxaOKvGzYCVgAUARG5u
	FUCEGYA3S4i2UUm+zJ59xQ1YoKYICNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1lPpH-dPM1edDzt6WTADuw-1; Thu, 05 Dec 2024 10:52:50 -0500
X-MC-Unique: 1lPpH-dPM1edDzt6WTADuw-1
X-Mimecast-MFC-AGG-ID: 1lPpH-dPM1edDzt6WTADuw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385df115288so536530f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413969; x=1734018769;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s85aLpWly0hO0+a8798HPivHQxmtFwjHj6n2eenApWU=;
        b=hTxT/rMzlD9DPxBsjrDvmVtgX9VKycofJjgsI+Am4Y9GSTAaDV1vEtq9RNd+g5Syr3
         tQa1kEF61gwfkcNkSbDMRvgSP8DVp5SLpqMwinsffxfxk6LNEwZpXLAEQcDOUZXXceZF
         Aw+h87iPo0exLpC2oPidFNReqhMdbqqmrTf2jCdVbfyYeACBFDGCqJiVwOmJXTjV+xXX
         J711DlFdLRId6Ps5AaGm7QsjibA53I0cjJEbGEsz/pxgLO/foR8aqbyS0gKozgrVGwKC
         A41DHksQaRYSeOwM638HTMgVuJqv4VwKPbguOwx/6XXM2ajngZMCNiU28GZ5B34LO8oD
         YaiQ==
X-Gm-Message-State: AOJu0YxIAPYW6eVC8mag+wUjRKUULjqXOrFpNqedEAGCfuapuGUN7irZ
	4YyS58XYwDQob0Rb4dUEEJJnBdcEZa63utE5X6940+ltnoPkLkszSWHl2oF/WHbo+ffeBHCfgG4
	6i529s9vXIMpvjAbILPfmuX2CC6OCFLHGxK9hPTmAcxsAdyEe9RFdaKsIUVGklA==
X-Gm-Gg: ASbGncuzN/3JLGJ3JeqZQOeULPofHj9HzG1xFSOYew4znXRD7hOubr31cGq78TLHP75
	NYlOSpZLzBbGGd898T5GPYSsqPJE3fOeqX2ggFeDTyHK7z8EMhesSlFa2irnO1iIgGswznvjTSP
	OgNvDCNBCZ1y2oNHdxsdZ7Yqln8hcqArHHcSOsRUrzlAvgUMYIGkmej7UfYurLb+ymMN/PB3RNw
	AqTZfH2k1Yh8ulh0SrOCpt5hgtXhpIJPTHFCwbZy+X5Yv7yqRILsEFmcNBJyVnhF5S0D0NFQ8VV
	HBKdj9CcHf5Fn3SWJlZTzLgu/op34l4VAUISgybNwnpEzzJkPGRgIze4FrNoQP2+W86uh8rsv6f
	ayA==
X-Received: by 2002:a05:6000:18a3:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38605b2abd8mr7797587f8f.53.1733413969094;
        Thu, 05 Dec 2024 07:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHorzB/FvppL9QBcu7Y7JBClFEooNvJGXuPPhBo+bJh7HgTQ5CNm/oY9HqG1zJnWb0lyjvKUQ==
X-Received: by 2002:a05:6000:18a3:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38605b2abd8mr7797565f8f.53.1733413968668;
        Thu, 05 Dec 2024 07:52:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8? (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113458sm28086615e9.27.2024.12.05.07.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 07:52:47 -0800 (PST)
Message-ID: <4f863bcd-7926-4504-8ff0-3b20debaf107@redhat.com>
Date: Thu, 5 Dec 2024 16:52:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-mm mailing list problems
To: Benjamin LaHaise <bcrl@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
References: <20241205085217.2086353-1-david@redhat.com>
 <dc19ac6a-51ae-406a-85e9-c4acf2ecb80a@redhat.com>
 <276e4bda-b1ec-4beb-b9f5-1daa6e39c992@suse.cz>
 <20241205154213.GA5247@kvack.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241205154213.GA5247@kvack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.12.24 16:42, Benjamin LaHaise wrote:
> On Thu, Dec 05, 2024 at 03:43:54PM +0100, Vlastimil Babka wrote:
>> On 12/5/24 13:12, David Hildenbrand wrote:
>>> On 05.12.24 09:52, David Hildenbrand wrote:
>>>> Sending this via the RH SMTP first, because IT doesn't see any obvious
>>>> problems why the mails shouldn't be reaching linux-mm, so let's see if
>>>> the problems are gone now. If this doesn't work, I'll resend them
>>>> using the known-working gmail SMTP. Sorry already for the noise ...
>>>
>>> I talked to RH IT, and it looks like the mails get delivered to
>>> linux-mm@kvack.org just fine, and linux-mm decides to silently drop them.
> 
> Messages were being dumped into a spam folder as the upstream spam
> filtering service used for kvack.org was incorrectly tagging them as spam.
> The folder where these messages were being quarantined in was not the one
> being checked for the last few months due to the spam tagging changing
> back on September 8th.

Ah that explains it,

> 
>>> Does anybody know who maintains linux-mm@kvack.org?
> 
> Use owner-linux-mm@kvack.org, which has been in place since the mailing
> list was first created.  That is the sender of every mailing list message.

Ah!

> 
> Unfortunately, the issue was not flagged to me until today.  The mailing
> list footers that used to let people know about the mailing list contact
> info previously had to be removed due to the implementation of DKIM
> enforcement.  Even sending emails to majordomo@ per the List-Subscribe:
> and List-Unsubscribe: headers would have gotten my attention.

Yeah, I tried hard finding a contact, and apparently ...

> 
>>> I wrote a mail to
>>> mbot@kvack.org, but I am pretty sure that is the wrong address.
> 
> mbot@kvack.org is a spam trap.  Do not send emails there unless you want
> to be marked as a spam sender.

... all I found was a trap :)

(guess I'm now a swam sender ;) )

> 
>> AFAIK it's Benjamin, CC'd
> 
> It should now be fixed as I have tweaked the spam filtering rules. 

Thanks!

> The
> messages misfiled as spam since September 8th have now been delivered.
> I'm shocked that nobody bothered reporting this until now.  

Hm, I sent quite a bunch of patches after September 8th, and I think 
they mostly got delivered. For me, it started ~1 week ago.


> Please do not
> report mailing list issues to the mailing list.  I simply do not have the
> time / energy to scan the thousands of messages that fly by every week.

Now that I know how to contact you, that will obviously be my first choice.

Thanks!

-- 
Cheers,

David / dhildenb


