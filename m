Return-Path: <linux-kernel+bounces-418169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACD9D5DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2B91F21423
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37161DE3DF;
	Fri, 22 Nov 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COR3Dv2m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8C1DE2B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274508; cv=none; b=cI2ypJjTUPO10vpEplA7dvJfmEjPUgo8wf0lrcrQZywfV4yxhEI0FdIkwSo/4anlRRQaBcIwzafil/AMyEHBdTOuOdHUuaQCytaMppacG9TgPG8Uk/7edJYvXDUPj7lomOODTV5T3PZM8jC0IP34t/Y4OMxxaTBtP2B0FaOPyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274508; c=relaxed/simple;
	bh=4YNPUk6nuTXXTclm9x86XEvqu/FY+NIbURhv96VNXQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRK3/CYeHmtNqvnTe++EGr/pZM+vlS3QrbxqMTmXKzFjf/rJZiufbSQB7ZJbKjYWeNMUCMO/SZ2nbLU5gwBo+6Xb79u9iME+mvhg6yT/Sndc+K8tLHltLnpS/xgxVHGVfvXF/txOS1v/OxLvvAt2+3+MKuvk/phdRfDiOCL1Nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COR3Dv2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732274505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r9Lf9NEh1Wx+KLFWKDJTwrbwUrVCdsepgIGg/rI8pXo=;
	b=COR3Dv2mP1/87JCIRMXEhywx39SkZCKnL094oipCBH8v5jRm6vrjKhm+BHNpIWpgwwMoNA
	Rwm5V6JVHR+N6yAc8MSZbN2VzXpIkE4G3NC2OOfiC+7g3cLh4kW7NMj3uXywJ0WLyPEiLr
	u23pQ+vNHi4NDLr2XYZ7hDwTsCdLXWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-jEVIohXoN6KaFKPSR0RIUg-1; Fri, 22 Nov 2024 06:21:44 -0500
X-MC-Unique: jEVIohXoN6KaFKPSR0RIUg-1
X-Mimecast-MFC-AGG-ID: jEVIohXoN6KaFKPSR0RIUg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso11425205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732274503; x=1732879303;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9Lf9NEh1Wx+KLFWKDJTwrbwUrVCdsepgIGg/rI8pXo=;
        b=KBpFBMrWlEwNoNnGubrmERICv4lblnTB8mLMHjnEw0TaKDeNar0PCI6qMNdQXPLm32
         QLM4P5UVzqasVrgINJoLo6k0Gb1ZNvy24duJ16GoI+xp5P+7d//pPAFWGH6L9wj7NmTL
         bOWHr+Ikj8QBLByNurQjOv5oI7HMNUMGzT12oEdxqXsjcKQABC1FPcp2qLV1XLOFzlhm
         DjBQz1e5BTWGUf5Rpb7l9/TBZ8ifxoqvGiWgU69nSuLMwt4BeYC9lhGHURLwlwxt4SWl
         nNXNKku44Hef74Jb0s0EwlQayMU7cJlfaAqV19uKlBAyZDtg/gvl4PGSzF+CK4aVQnCX
         9w+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJTLu4gxpW2pw1EdJEWk+OqZcrzYGysiNp2WkO5fmn5rZy6JPj5cHQD3xFtyZmGKzqy97dvk8X3t6/czs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vLQGra14t9rgDoX6/LCbWlflDXidPOV0R32cwqbSlXz1NPVF
	C51ncjb7iKy+T8sG8zN5P7NbjLidcHJ1MokolzrcUaOpxTdKLG1wqJorZhfjhfPG/xKzn242y7h
	vEVtu9T1wyf2JjvhCplJj0e/6MhZ5LsYPntyos3AMt2xOXQj6xaZYnwz0YD6A2g==
X-Gm-Gg: ASbGnctV5AToSVAQRzA/FGeyzlLYcUdoIDX7wruE7gqr0mEhvTu+T3AgcyfqnRd1I+a
	wF2hU8bZFkNbfPo6ZPoWG7oG5PhmU0i6QgGcdzDBXFHHDWk2xgYAjl+iZj/rq8ngl6h8P5RSRCn
	7hpqBt+Hl38CTbDe60kC2JjmNSpxQBL0qLTEKNbo0auKvpUoaBHC6NxDfP/F4pph1N1SSCS/+oE
	gZzbR2Tl3Tz2pMyGBreVvkpFu4Lcu3Ah5dtyZpHlpOvQUf28utSXi+4z0oTsy0tbeZc7y0amDi8
	DlEcpOU+VOtWqk3CRW+vIrrTl0TH7gYJmF3E/Mqoubi/Q/g08YZWY5l5YKlMsdIeYdgvZqbGch0
	=
X-Received: by 2002:a05:600c:a296:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-433c5ca2428mr56849365e9.8.1732274503262;
        Fri, 22 Nov 2024 03:21:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2+3otb3BDknrAK8yb894tbDvw/KXdTTwseaY15YXhYSr7ICKAhguNlMjvBKBCnMg3L+0gRQ==
X-Received: by 2002:a05:600c:a296:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-433c5ca2428mr56849055e9.8.1732274502927;
        Fri, 22 Nov 2024 03:21:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad6730sm2173502f8f.9.2024.11.22.03.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:21:42 -0800 (PST)
Message-ID: <a3b70874-a3a0-4e28-9673-3d39ace4d669@redhat.com>
Date: Fri, 22 Nov 2024 12:21:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] seqlock: add raw_seqcount_try_begin
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 andrii@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, willy@infradead.org,
 brauner@kernel.org, oleg@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
 viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241121162826.987947-1-surenb@google.com>
 <46aa36f0-64a6-4aee-8134-0ec93f62e59c@redhat.com>
 <20241122111914.GS24774@noisy.programming.kicks-ass.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241122111914.GS24774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 12:19, Peter Zijlstra wrote:
> On Fri, Nov 22, 2024 at 12:10:29PM +0100, David Hildenbrand wrote:
> 
>> In gup_fast(), we simply do
>>
>> seq = raw_read_seqcount(&current->mm->write_protect_seq);
>> if (seq & 1)
>> 	return 0;
>>
>> Should we be using that there as well?
>>
>> if (!raw_seqcount_try_begin(&current->mm->write_protect_seqs, seq))
>> 	return 0;
> 
> Might as well. A quick grep doesn't find me another instance of this
> pattern, but does find me something 'funny' in net/netfilter/x_tables.c.
> Let's pretend I didn't see that for now ... *sigh*

:)

I'm also not 100% sure about barriers in gup_fast() around the 
raw_seqcount .... and I'm pretending I didn't see any of that as well ...

> 
> Want me to stick a patch like this on, or do you want to do that later,
> when the dust has settled?

Feel free to add a patch to just change that as well, it's an easy change.

For this patch

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


