Return-Path: <linux-kernel+bounces-547589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC09A50B59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB053AB7A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E38253B67;
	Wed,  5 Mar 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh1petAY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6025290E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202404; cv=none; b=Dk8dFZFpdANY00awBkZO2Dr+yv4eAGqVuKu3Z534x5jXlWbucZnkQRkg5XvJBf1V3JGpkGzMctNoFUmEo6Bg7Hiy5/JV7D/07mfv6Kl47hZZw5OlgXbL7DH2/4ppswZiN2p8XXKTuw191Epnj7hCYiLc9n201eOiJrbjMHR4Mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202404; c=relaxed/simple;
	bh=nU9/72CxyQkf+ujhOpB1bMoup1Uc71nTSxwFKFqifsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llm2WWSEdKXTkmlUKkwQn9XhKe3c9S/TTxckwWpU3Ha4E/UjB53T5TQg/GHGR9Nv05rFM+1bzLTXTpZG2AVAqupReWqowxuYn8RuyQFDnMHL9Dt94qjwOVXT56uGKfhx25dR9C4YncVyWP8W+b49GXuWYCalIbmEXvnIt7dwiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qh1petAY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741202401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=voWCQu4ewlCORS7CjXYXxbqRYeHnRe4GherS3B2jRsg=;
	b=Qh1petAY6NZY62PCo2lffS3+uAtaYp4qZXnal6NsfzfaMiswgZC7ScSjyEqylOiurd7TVT
	5nfmSMh476uDRwYaxpxuq2eDCepPrwx7fGCPSASxEx9djg9egrLASM205du9l3kbKRRMcc
	Hakfd4dekDcNBt7uj3TPAIkWeqE5YsE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-dA4F5Np7P6Ww7wCS8lEKlA-1; Wed, 05 Mar 2025 14:19:45 -0500
X-MC-Unique: dA4F5Np7P6Ww7wCS8lEKlA-1
X-Mimecast-MFC-AGG-ID: dA4F5Np7P6Ww7wCS8lEKlA_1741202384
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f365274dso663941f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202384; x=1741807184;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=voWCQu4ewlCORS7CjXYXxbqRYeHnRe4GherS3B2jRsg=;
        b=dF227nXfzhRR0gUSkMU8FN5ZWfs2IXNaPaBDtu6Iqm+Nuzw/hN+kShQOJhhuHOe0gF
         YJzwktP37FCXf8RPWHLgT7PpKFdmfplB3H5W0p+ln0Ukh5UPAYhM7Lcp5IV63+QL8ucw
         vO0HOvXhUbWH1NevbkGhS9i1inGc+xDsnvYTgzYgy3TzKeUdXzsFkMDtBRhsKTmcx823
         DLPyTwS+db9s0ccrh/8kMqLUp7JET7EEH4vuex8uIpMxlkwBW4LhD4nr3K/zJOOrZc7d
         8npxkKYh2jnOGtJUEBQjrqU1WWGWn04Bm2B11sQ3S3TF2or2PnY3+dkm14QPFpy5K2O+
         +cbw==
X-Forwarded-Encrypted: i=1; AJvYcCU5M8u4pnqbl5Etk6vsvR6HJQN5z88srmK5mX1U81HNPOKHbFnXBN/+iT8yvg69w9WcHML/CF4mDIFw51A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExfrsc6vZ3UqfYu0zd6/qNIADfPzkx/BrDkeNi/ydgxQ2d+Kx
	7/1IcKk5gNmWvarZvF5YuK4RJMsoDITB7XJGc3S6gILN8tzyBMKUDSWJPA72jKtHvuBv2ZOSNIT
	bfmef+moEF3if1LpXEfeje8nkKDTUV+5McZ9UNx4aU1nkv7LtJTIDCmR5fRDccw==
X-Gm-Gg: ASbGncu2B+2sZe1z18OGhhjscGddCs/1NmXw4i0e9RbeYEuE23iTc0otIusMGCtbkRr
	AJFPMinQQdQ3Au2JOvtrgniNeMVoQM9dOS0TB8yfXY1P3MFk76cSOWAXpaf/qPILvoIT4ZfLGAC
	BfAm1/XWspe5zt/vWpSkl3BNnf0EtXYFg1IGtYusRPljOsROhQkTjeDnPJ+YOq0aZ4RaIx82+p+
	qIOXInVB0y9/RYofprDzALnZtLKLWsfKfQjpfcZYSKjYOsq0pOgRHnv/jtP1mQmFrloZXC0lt36
	JeLjfFn/hw6tWOsVqjsxSa7gK4m0SgjhU7ZEnNlZtPOh
X-Received: by 2002:a5d:59ae:0:b0:38d:d222:ee70 with SMTP id ffacd0b85a97d-3912981f367mr577571f8f.20.1741202384195;
        Wed, 05 Mar 2025 11:19:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA9C2s4vINS63wYRmmLG1uSlH7T47ke5yJ/eUB4ZnfSQF0HRnZ2F/al7ZcYAmHhtdlIsVtjA==
X-Received: by 2002:a5d:59ae:0:b0:38d:d222:ee70 with SMTP id ffacd0b85a97d-3912981f367mr577559f8f.20.1741202383833;
        Wed, 05 Mar 2025 11:19:43 -0800 (PST)
Received: from [192.168.3.141] (p5b0c63d5.dip0.t-ipconnect.de. [91.12.99.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-391241bd151sm2073895f8f.21.2025.03.05.11.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:19:42 -0800 (PST)
Message-ID: <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
Date: Wed, 5 Mar 2025 20:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED
 and MADV_FREE
To: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8ieZVFEa6vAouvu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 19:56, Matthew Wilcox wrote:
> On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
>> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
>> can happen for each vma of the given address ranges.  Because such tlb
>> flushes are for address ranges of same process, doing those in a batch
>> is more efficient while still being safe.  Modify madvise() and
>> process_madvise() entry level code path to do such batched tlb flushes,
>> while the internal unmap logics do only gathering of the tlb entries to
>> flush.
> 
> Do real applications actually do madvise requests that span multiple
> VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> call to mmap [1], so why would it make sense for an application to
> call madvise() across a VMA boundary?

I had the same question. If this happens in an app, I would assume that 
a single MADV_DONTNEED call would usually not span multiples VMAs, and 
if it does, not that many (and that often) that we would really care 
about it.

OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED 
version would make more sense to me. I don't recall if process_madvise() 
allows for that already, and if it does, is this series primarily 
tackling optimizing that?

-- 
Cheers,

David / dhildenb


