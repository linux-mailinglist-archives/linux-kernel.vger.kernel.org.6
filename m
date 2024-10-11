Return-Path: <linux-kernel+bounces-361054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77E99A2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D4F285E81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A133216A3E;
	Fri, 11 Oct 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0NNPEe0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C038216A1E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646771; cv=none; b=uxgZ9UVvdQXTK1y5ukYty1AfeIbazEdrykoDFFg7LZYB8fl0pBc31hCdfpmYIx70pVNAyKJG2rFJ/G/7id62m4INyYevYb5r3LWyJb+E1eZLMAuspOnOzm4WhQMametjmHV4fDS/xhrbvSZ/YI7TipKgqh5g8UlAg4secJSEhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646771; c=relaxed/simple;
	bh=uxWda1jjE01Hiq2/GdvI3YwRYiUh/JwIj8EBT53/D/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7QggoL6rGdDmOqeGxNTh0AHFzMtwJqOk0yO/eFYNULUpiumJyONGQ0mWZP+Arl+I4DburB3GzH0UOCmhI8wt2y4urptCFGQOZ39LusMOT3v+pY4ma5M76ds93a4q6AyPe5jga3h3EYgrqMi3MRC5gOKQKO/FdXbdvHavjrKVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0NNPEe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728646769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YSwa3uEpPswNDcoEbeNVSsH+ZHhyvprVjcqw1gIKnUA=;
	b=I0NNPEe0tAVl2WiqAYi7RdGrQBqEAXAdrIQVsrLM9Ogkabxj1ZSJt558gBGe2uMHVQB9V/
	hDNiBIN+U1BIJQxMZLYD1nSL3LLEYL8BksEWog8P08reMDpaSVvimtdmBzgSR0O/N9LfOp
	oUGLionYLOcUhSuE6bBVV4vZOaXDcDo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Nd53aTHTMaO8hTdzSqA9Bg-1; Fri, 11 Oct 2024 07:39:27 -0400
X-MC-Unique: Nd53aTHTMaO8hTdzSqA9Bg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43057565db5so10850115e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646767; x=1729251567;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSwa3uEpPswNDcoEbeNVSsH+ZHhyvprVjcqw1gIKnUA=;
        b=fJSOKw/WHrzguy+iHCpJ1vNsStkP6NLbzCFQF1cSfMGrMFj6Uj211brqHFPyigD9FC
         EpRr0hig8G9DCAsySAyWCqrpr3W904B+dvREV8B6Hw2BWA2J8qCG8Zh20wdKY9RCXO+m
         FWkPBxH0bJny7BgnwcrBud2AQYNRS1yt6MxwYwG3K6XCzSHXNNZH8HTa8dODTxVO4uyg
         mwfcvEkT54YXDMw0iqb+edrZmqAOMKUzXH2QMVJUU+Zy7Jb5YCF4I3ydqCQSChibVsPo
         0CIE7q3qxCa8WgYin5fKGMg9TtXlVDKae9TWGsJx94n5wOm2PdH8Chf4C3wnfwy/uE/U
         vKiw==
X-Forwarded-Encrypted: i=1; AJvYcCVjMN3Ok+OEYz61zl/WE3nIEql0YMp/zuDvNrg4xqJ+SrjnT77GVQxuuEbNRj69aCikPb6i360yg59Y1+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQMXX0eLEZxcZzlfCSk98MrALy/H3yITQubp9Pcc294Yc5wcS
	Z6psXYy0248ce0eEgQiXMeM9MAhYl8LMAffH1ur+s53KdA6vjf19w7t9EhjhFx0y5j0wKpYEPLa
	Pk8/2hhJ8P3vIXA+hDtLqVVr2ncUd4bosNMETrxMQuPhob1wt1fgKqbgB2OWplRUTkGOGj06G
X-Received: by 2002:a05:600c:b9a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-4311d884328mr20904545e9.3.1728646766775;
        Fri, 11 Oct 2024 04:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXRS8eHd5J8kgixq2jF5sP0vcpuDVeq0dVlxRTUowv7C4+G18bwN/KWrHQGRJVOzJAbCnurA==
X-Received: by 2002:a05:600c:b9a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-4311d884328mr20904325e9.3.1728646766313;
        Fri, 11 Oct 2024 04:39:26 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5181fsm72311515e9.25.2024.10.11.04.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 04:39:25 -0700 (PDT)
Message-ID: <33c40562-fd22-4517-9f56-1039289a55e5@redhat.com>
Date: Fri, 11 Oct 2024 13:39:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mm: don't install PMD mappings when THPs are
 disabled by the hw/process/vma
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, kvm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20241011102445.934409-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241011102445.934409-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2024 12.24, David Hildenbrand wrote:
> During testing, it was found that we can get PMD mappings in processes
> where THP (and more precisely, PMD mappings) are supposed to be disabled.
> While it works as expected for anon+shmem, the pagecache is the problematic
> bit.
> 
> For s390 KVM this currently means that a VM backed by a file located on
> filesystem with large folio support can crash when KVM tries accessing
> the problematic page, because the readahead logic might decide to use
> a PMD-sized THP and faulting it into the page tables will install a
> PMD mapping, something that s390 KVM cannot tolerate.
> 
> This might also be a problem with HW that does not support PMD mappings,
> but I did not try reproducing it.
> 
> Fix it by respecting the ways to disable THPs when deciding whether we
> can install a PMD mapping. khugepaged should already be taking care of
> not collapsing if THPs are effectively disabled for the hw/process/vma.
> 
> An earlier patch was tested by Thomas Huth, this one still needs to
> be retested; sending it out already.

I just finished testing your new version of these patches here, and I can 
confirm that they are fixing the problem that I was facing, so:

Tested-by: Thomas Huth <thuth@redhat.com>

FWIW, the problem can be reproduced by running a KVM guest on a s390x host 
like this:

qemu-system-s390x -accel kvm -nographic -m 4G -d guest_errors \
   -M s390-ccw-virtio,memory-backend=mem-machine_mem \
   -object 
memory-backend-file,size=4294967296,prealloc=true,mem-path=$HOME/myfile,share=true,id=mem-machine_mem

Without the fix, the guest crashes immediatly before being able to execute 
the first instruction. With the fix applied, you can still see the first 
messages of the guest firmware, indicating that the guest started successfully.

Thank you very much for the fix, David!

  Thomas


