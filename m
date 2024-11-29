Return-Path: <linux-kernel+bounces-425568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD89DE6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B52AB239B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15AA19D8A0;
	Fri, 29 Nov 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/iwni6d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A719D89B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885150; cv=none; b=PyPNoD13PF7ceyGD0tpJl8a2etOh2aDVQhE9wlv+44bDIbjOFjeH0eIaDxWZfxRTa4Y9UfD9g7Kv6jqafoOwjzsxYOafx54RRkTB3ZD85iMiAVRlk9QOM4redTfdc/bSbW69A5nInxMd6h/uSgRwEAZQpGwBTWidfR8APHbereM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885150; c=relaxed/simple;
	bh=f1LwzimyJxvtlnfLkiNNLS/Jz/XOOBMaAW1tRgiFn5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=artj8Nmh40wnaUieAWGYlbwF1mab4nj8cxCSTmtOptjhTKypmWv6PH8o/qE1v6WthJebOl4NtG9cK1eCkSLflGst9s/xloMDV+isMlFxkeVhpMLBFdvsoD8zIBA6QCQbVtjoUGxfYzgJ0LZxJ/N0CGkzdNgA14sYaH7jHH2Sx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/iwni6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732885148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XcSCrZsrFnqSAWVc0CZcBqWIMg9FraNhIyn4BgkF2PI=;
	b=P/iwni6dbodJpnZ5prcF/8fHKLSu/3fsMYR7FsqCynGO14BNiu0P87wztPmwPhHyosxXoU
	cokSPe1cVJWObcnVLpFZujIgscVlcniFak+fTFtBbU19kFndAi6FNM8pNWd8ltZAHF3xMc
	TtQ0SUOvAqtxtX7GQPhvf1b1ae8N3z0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ju_pwlTDOAyU1BdYhfSolw-1; Fri, 29 Nov 2024 07:59:06 -0500
X-MC-Unique: ju_pwlTDOAyU1BdYhfSolw-1
X-Mimecast-MFC-AGG-ID: ju_pwlTDOAyU1BdYhfSolw
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53de90d54f1so1664577e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885145; x=1733489945;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XcSCrZsrFnqSAWVc0CZcBqWIMg9FraNhIyn4BgkF2PI=;
        b=k5+HrKtSyzWHE8p3U8t0dx/G9uOmRvZKR6okMzIhI3CL0qnPzQZBBmdqB88Mr/EZ4H
         kAydnqXeXVaizVzfp7nzbKUxQ/OysJ6QBt01mb7LXjVa2T5xTsVob0Gi1GwvXYazdl3r
         9ZJJ3m6myWroV5MD7/BDmhvBn6HvRPaFi67ioCAYA16VM9zTKxFGJZLJhujahH9atVWQ
         T/1yPNjcndIoTZDXH0ain+CeUb/6g7HxIQgv6+fuhHQPlDO+WDFSCWmioSLIAFIOh5RY
         /LLQuY+48FqlN9py+8kWckU6Vj5UxuMdE27k2BTa0ChPy4l1381NjMt2cXtEUEEwqMUJ
         BisA==
X-Forwarded-Encrypted: i=1; AJvYcCVrNHo7+lfPT4+XQduRt6M+lq9uuZdJhgutRhmcP8h/2KaA5Ik0PCDawkPqk9oNoxFLQDHQwAdPdRIfrCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBPR3sQ4tdAJqJzDvyFOU9R1GhKrMWM/vCQSyX+XvcrhD/ykF
	K2MtN/OPs0jf+gk3+1lVSGEAkNBAU41F+oVNviVzJyk07lXzqkyVDztQyxOZApY5uvS+YSnRTZK
	/puNTVuphK1ttvl3Xdmxf62X6yv8iPUM07takqOaNZbhtvLx0ULbC4px1AHAoPw==
X-Gm-Gg: ASbGncvuYtNT5/akpLyUT5d32/W6idoaGRiQdgssDZfgT0e6JFsjC/RVFabbK9BREMZ
	6sTDEHKMz/V0czWd2GcxcEcgV3U+CGIbFD6a1l86lvJZgk7Q4cgrr5pe6b8pTDXsxSJ0XwroUel
	KF1+qTnj23fOvCArOv9M3OMxZqljnpssCJJeTpb8ijtGbMyYfs6buZ4RZhqL+OaV9aTR53P2IG2
	344dpJ0OUS/eUtak52laUKmAzH09pa+HnDZrp4HO/r6Qo4rerlwpeKmAoRtPY5A89VfC3WVNoyT
	aUgpRPJYy3SBxT1cqIpHLQ/H9E1OAOh//Jvjsk3iI9NRRRYPJvjcJAt0nEjQNkytVw+iHZblvVD
	t+A==
X-Received: by 2002:a05:6512:2387:b0:53d:ee8d:9e60 with SMTP id 2adb3069b0e04-53df00d10d7mr6656798e87.14.1732885144712;
        Fri, 29 Nov 2024 04:59:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2a+Juq/9rxa2Z+aXTJn/KvbqThG58N7VlCAGh1Jbzk9FIUtrc1RDMd0vxssTYZeIi6kvRmQ==
X-Received: by 2002:a05:6512:2387:b0:53d:ee8d:9e60 with SMTP id 2adb3069b0e04-53df00d10d7mr6656779e87.14.1732885144199;
        Fri, 29 Nov 2024 04:59:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm51985305e9.15.2024.11.29.04.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:59:02 -0800 (PST)
Message-ID: <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
Date: Fri, 29 Nov 2024 13:59:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 13:55, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
>> On 29.11.24 13:26, Peter Zijlstra wrote:
>>> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
>>>
>>>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>>>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>>>
>>>> We could start that work right now by making some user (iouring,
>>>> ring_buffer) set a new page->_type, and checking that in
>>>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>>>> and the mapcount.
>>>>
>>>> Because then, we can just make all the relevant drivers set the type, refuse
>>>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>>>> refuse in vm_normal_page() any pages with this memdesc.
>>>>
>>>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>>>> these things will stop working, I hope that is not a problem.
>>>
>>> Well... perf-tool likes to call write() upon these pages in order to
>>> write out the data from the mmap() into a file.
> 
> I'm confused about what you mean, write() using the fd should work fine, how
> would they interact with the mmap? I mean be making a silly mistake here

write() to file from the mmap()'ed address range to *some* file.

This will GUP the pages you inserted.

GUP does not work on PFNMAP.

-- 
Cheers,

David / dhildenb


