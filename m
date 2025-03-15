Return-Path: <linux-kernel+bounces-562780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B750A632D2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A69A3AFC88
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2B1A5BA8;
	Sat, 15 Mar 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1HpQUZz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068719ABD4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742079619; cv=none; b=LNl+vIYSVvgy7W3RhJu98ilHKZDWuoRpjW+dt0ku5Rm0BO0Otg1Ws0o39xTERfV9RrqMps2YCNANqDObyVAnSxjNlW1N+ce2Vr4iVm/7eA5ZPaVsp+uk8AkGeJMlInnbfKRCTL6PffwK4K+JHt6rtOgUD1rIHaEqcOss1A+4IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742079619; c=relaxed/simple;
	bh=xhRFpzk4rzdLvCilNXA/yVnrnYAhopE2nHKm/Q5UY+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV9mENgC1iRvci0RaadKWqqH7ICdu+28twlnbhLapK1Bbkaztt/CqqGuF8UMlFSyNdXlg0vqIxPyc+WPHcpZDFSjETA/kqw0rgiUxTUKDWeMm95V3ySvon5YMc5di8Xw/+VpjI4pr+ZcR1hkrVSheS4Is1OhPE+OqmzpZY4ojIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1HpQUZz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742079615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xEY/qgIubnuvaxvPQIcCtmjl0Q+JZGksygczEmSgHEg=;
	b=S1HpQUZz4aXU2QIsWVeUsaMxOrOG1WCd3rpYuCWDYwt06vlOChXjzrRKo6wucNaOCG3HA/
	ctJ205nNUI2MysqybvhbOZeUk7e9vI6XAZ7ewDOx4ItqQZzVCqvSY/iIbNmv08e7QHIGoD
	xynnVdjHrTCBgnqU4HLbsvmmB8XJrq8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-1dbZQRnoPUChvkfSVh84cg-1; Sat, 15 Mar 2025 19:00:13 -0400
X-MC-Unique: 1dbZQRnoPUChvkfSVh84cg-1
X-Mimecast-MFC-AGG-ID: 1dbZQRnoPUChvkfSVh84cg_1742079612
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so5187005e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742079612; x=1742684412;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xEY/qgIubnuvaxvPQIcCtmjl0Q+JZGksygczEmSgHEg=;
        b=t341Rm8xweDx/H9FBkIf0Vh9icvo2QNcKBor+xhrnfaCSdGNwfBxU7VFr7CvwCwjwa
         njFSDF15Qaq72BlvQS6M1JI8IrzRsAHeZ7d36FVVmRLg1doDXozeSr4zGwCsnXKOvSPv
         ZwAk3rMFD0C2ajLTy4+EbKk1lB23SmgEjbb2US1Ym9jTccZsADMxnTjzTyv4yahty2KT
         68jwE71PRxoBlvlqUCCu//tbMHm9EGJqR1JPUmIVHSocE1bt5cHnuip0DPBnr+QCAH7H
         qab8gWBDAfXVSF3yAxdjPyOlbR/DwX6LBJuDjy+mGBOEugByEmuo25gmlGM9X30W+JCz
         Tpvg==
X-Forwarded-Encrypted: i=1; AJvYcCUCNk/v/gHIwmf+EYUPhjVF+i81V9SpDVugKo7xgn3QpkuoFrGp4Lz2y034bwXV72pDP7PrjF7RXiXCL1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsDij1ZiK/VmYLMsykuIL/G+1w8SfLwiNAYAhQn0jxHpFUhYa
	/JjyIJjywrlMtQTFnwJi5sYG71xWds5Md6i2oj6uE1yZavaEk6r/lEitpVaSfFrV2+LbRFg5AOB
	+HKz9cQHXQuCeUGq8JlUkmrjqSFPx8vBkTo+7fhswlm/g3uJiyfxXq6SLjEOISEF9nNzY/9cJ
X-Gm-Gg: ASbGncvon0Qsf3r/HLIKiWRW8hbV+fbtxLH7YsJBQuq/Y2fLQJ3vNFzXbtz62vj8Y/p
	mMA69jDjLaipKlpdqceMOxqIWk+Z90vB6Gf8eCphXN/fBpeXOCJ9PTMC9EWVCD9J/XD5xT+sJq1
	GpxXwela4X2NMaRqIHMZF1iXDwpYCe0fEkyz9s4ft7v03KAl0MebUsuDyg1OXKS2nhjd/LUl95z
	Kd4/9yJUnVnlpEdamW7ui1+bpT+GkC/SxWpuw4wpGws0rbaYloZROOG44HhAZVnH+bfFIARVtn5
	Tfb6056MOnRqeGbybbRcNGwOTx3nKirnJUBoFjd9GgMrtHkftQ7X6h3tRiGZ7ZN7S7nOYJGm2td
	hVUw6yE0fhB9aq3Q3igDfekwQc8zKXCYBvIa9fkeLWp0=
X-Received: by 2002:a05:600c:470e:b0:43c:ee62:33f5 with SMTP id 5b1f17b1804b1-43d1eccf8c6mr75685265e9.27.1742079612055;
        Sat, 15 Mar 2025 16:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEreElSctv6SPEP2MEyJ/xqWLJMSiduPZhNsHlrl2TaHlt7HW8aHG5+4LO9QNQdz+JntA2e3g==
X-Received: by 2002:a05:600c:470e:b0:43c:ee62:33f5 with SMTP id 5b1f17b1804b1-43d1eccf8c6mr75685125e9.27.1742079611635;
        Sat, 15 Mar 2025 16:00:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm10072152f8f.85.2025.03.15.16.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 16:00:10 -0700 (PDT)
Message-ID: <e8996592-f7ba-4926-8556-1fe7534038dc@redhat.com>
Date: Sun, 16 Mar 2025 00:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
To: John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig
 <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 jaewon31.kim@gmail.com, spssyr@gmail.com, Zi Yan <ziy@nvidia.com>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <Z8tVrOezU2q_0ded@casper.infradead.org> <Z9GmYe-bdOZ8LQV5@infradead.org>
 <cd013218-7735-4bc1-b6b6-80d1129e2b76@redhat.com>
 <c45e1bf8-f91b-4383-8c1a-7e11be02743b@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c45e1bf8-f91b-4383-8c1a-7e11be02743b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.03.25 02:04, John Hubbard wrote:
> On 3/13/25 3:49 PM, David Hildenbrand wrote:
>> On 12.03.25 16:21, Christoph Hellwig wrote:
>>> On Fri, Mar 07, 2025 at 08:23:08PM +0000, Matthew Wilcox wrote:
>>>> Howver, the problem is real.
>>>
>>> What is the problem?
>>
>> I think the problem is the CMA allocation failure, not the latency.
>>
>> "if a large amount of direct IO is requested constantly, this can make
>> pages in CMA pageblocks pinned and unable to migrate outside of the
>> pageblock"
>>
>> We'd need a more reliable way to make CMA allocation -> page migration
>> make progress. For example, after we isolated the pageblocks and
>> migration starts doing its thing, we could disallow any further GUP
>> pins. (e.g., make GUP spin or wait for migration to end)
>>
>> We could detect in GUP code that a folio is soon expected to be migrated
>> by checking the pageblock (isolated) and/or whether the folio is locked.
>>
> 
> Jason Gunthorpe and Matthew both had some ideas about how to fix this [1],
> which were very close (maybe the same) to what you're saying here: sleep
> and spin in an killable loop.
> 
> It turns out to be a little difficult to do this--I had trouble making
> the folio's "has waiters" bit work for this, for example. And then...squirrel!
> 
> However, I still believe, so far, this is the right approach. I'm just not
> sure which thing to wait on, exactly.

Zi Yan has a series to convert the "isolate" state of pageblocks to a 
separate pageblock bit; it could be considered a lock-bit. Currently, 
it's essentially the migratetype being MIGRATE_ISOLATE.

As soon as a pageblock is isolated, one must be prepared for contained 
pages/folios to get migrated. The folio lock will only be grabbed once 
actually trying to migrate a folio IIRC, so it might not be the best 
choice: especially considering allocations that span many pageblocks.

So maybe one would need a "has waiters" bit per pageblock, so relevant 
users (e.g., GUP) could wait on the isolate bit getting cleared.

-- 
Cheers,

David / dhildenb


