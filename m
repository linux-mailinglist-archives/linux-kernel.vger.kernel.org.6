Return-Path: <linux-kernel+bounces-440246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573629EBAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61171668AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29D226886;
	Tue, 10 Dec 2024 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+GO3kgp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BB8633A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861536; cv=none; b=a2HfxjLZx8DIRpY4DDqZV0B7o9XZo4aWCH8MCtZIXLmEmkkYqJmS70hHU3JrSKIznIr8ZnySDMRJzmqQytoNg8x6CkagajNF07cch7+KDjVzZbPRep8OrMEmlzHg02HjYLLVShXhB9j7q5R897CgP1QC/PepBbcGnyU+xkeP/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861536; c=relaxed/simple;
	bh=r8OlRq4jVPjGV1Bfy5PkZxjsVtpN2abZXDmi+WAKlPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkabnD1rsE+EMEdNWxsS5jilEA/yMBbcRjeullMBbazNY48zbkN/ItPfY1j/Ek/tM/GjGRZSAHVw296lx5HgwAIRdNfeMjb3BHkamk8650SqZN8mBpcNRcZAlSKpOAbgfjIZJkRKPMjz+nkJO74urqqFGmp4uJlcHUGwybCbs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+GO3kgp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733861533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=juGHJy98WZH6LpUInCfGRhQO53ofgyYN4j3qIV+zEL4=;
	b=f+GO3kgpXubMaPWfYmOnIoHvHrQHZMXcL99+z7CuF+9dB0NsLsIZgUzY+xYAxKKLWpbPio
	mqYcF9y4E2VUqjIU1CdmHIpAVEN5iC1f98AkUbW5I4dEj39VMGRcp8Kv+n11ZzABQbStUU
	7h3UVJHEY0W6p6+SLtThS0rEsFg20+w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-3s17O_H0NH2mOFq26IgZnQ-1; Tue, 10 Dec 2024 15:12:12 -0500
X-MC-Unique: 3s17O_H0NH2mOFq26IgZnQ-1
X-Mimecast-MFC-AGG-ID: 3s17O_H0NH2mOFq26IgZnQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434c214c05aso46757205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861531; x=1734466331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=juGHJy98WZH6LpUInCfGRhQO53ofgyYN4j3qIV+zEL4=;
        b=ZDh1ligfrMkYQOApFSYJLxpv5KNVeeJgQySw4lyYQyJjnAEQurewVsrx0mlw37vdwZ
         s+vP8+V0gqy0UiANvJUKgcbZ12XtoKRGSd0jmy1L12xjunyih3Zxyb7n0JB4o11PoJJ1
         YLhpybSaj8je2kxpXGyOpXLt9waKmtaFz52/Lh7gzXtNSl/bsD7N2U5ppcPPRv50Fdcg
         HiJJnnNWh9XF4Qjr3BqMqLQdR/+tAMpAtfkLZsYJoSg4rA4KN8XlqUmVZv47SEkGHCD7
         5m5BBXhj+RZeFLN2VTkr0zmAIJoMA8Y+3JyI8HMygQVD5khUsTaQIyDmQcGVge6S8J4B
         i30w==
X-Forwarded-Encrypted: i=1; AJvYcCWrRjXl7+AE3rW4Wpcuy04GHI0d5h+EMANPqm+35iyJHk0usygzmzV2yFswv3CUzKXEVi9nGmDrQf5M7+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwncVQ94Cgi4lC28vkU1mNU+H46UvSuxcS4MzpUK+cYmjx/ocM
	sSA9gqXCVlSjGcwH41/AXw9dGoWqBjG2ipvwxaJnIQ4cSlbAoE/gzeD4lyz+crUZLpfWlsHKe6p
	NOg1PKuINiGoitqBVnPVpLDdtXnJReEuQtoLmm65WbJzJIe04jJeLNQv1DHclLA==
X-Gm-Gg: ASbGncv39wxoq93MF7C4NwWMvd/Tx7jK5Iz53mYKhfmmNvZib0ggLaekCXIBRUPKlQj
	6fpggcVlE8+vGMWJN0y58ARk/LVzgqxzUDgX7q1OkILSOhXx9Iqj6NOwM5sgrD19kFQzODz/S4d
	c5hShn7RQ6T6Lr5ZfO9AFxAuJe9Qq7ZnurctJywBGnjyJy/Aau1bZelFAOKd9+vUCejH2PI7sJy
	owTulTd8EvA0arXGfgXgVtA8EIWgwit+aJrFo+S/s3sIwlgX/hnfDASsuvlIvFcHNnmK+66vn4B
	WPJYx6IJGMY6UIwRpCeU/fFo/aT0fhrLBrlR49c+vKBjhrUs91uCQx+hvLkgC0t3P6YX2sr3QhW
	2OtmW0g==
X-Received: by 2002:a05:600c:5122:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-4361c393889mr1225355e9.8.1733861531088;
        Tue, 10 Dec 2024 12:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBXk0gQ+aT/mZKbFBNcqLPO6kHx7wUGVXlbh1qFlhCc8nVpAeKsJp4y+2W20lwaMMn0P35ig==
X-Received: by 2002:a05:600c:5122:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-4361c393889mr1225195e9.8.1733861530742;
        Tue, 10 Dec 2024 12:12:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434faeda409sm70709485e9.7.2024.12.10.12.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:12:09 -0800 (PST)
Message-ID: <ee92b309-db6d-416c-97ab-25abf8b12957@redhat.com>
Date: Tue, 10 Dec 2024 21:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 6/9] mm/truncate: use folio_split() for truncate
 operation.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
References: <20241205001839.2582020-1-ziy@nvidia.com>
 <20241205001839.2582020-7-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241205001839.2582020-7-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.12.24 01:18, Zi Yan wrote:
> Instead of splitting the large folio uniformly during truncation, use
> buddy allocator like split at the start of truncation range to minimize
> the number of resulting folios.
> 
> For example, to truncate a order-4 folio
> [0, 1, 2, 3, 4, 5, ..., 15]
> between [3, 10] (inclusive), folio_split() splits the folio to
> [0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
> [8..15] is kept with zeros in [8..10].

But isn't that making things worse that they are today? Imagine 
fallocate() on a shmem file where we won't be freeing memory?

-- 
Cheers,

David / dhildenb


