Return-Path: <linux-kernel+bounces-259879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE342939E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC851F22861
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED214F9F5;
	Tue, 23 Jul 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz1LzXnP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1DA14F9CC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729546; cv=none; b=hUpkOzCNeNqdSnlCJnm+4PkAXCASJbtKrEX3aOfQ6skg8KZ61mqf/1R9MM4qnSboBJ/u6QeBYipVIsdZP1SgNpvuXhiQpupWW2+ZCXJwGP9yeUJl/aaKMiTn2qTh+eI0DakWGPFwgr2TqYFaF3YEnNgCfFoWFGdTAYxy/6RA3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729546; c=relaxed/simple;
	bh=HfrnWpdUe9p1MVAIrotGcdQeysfR4KqJXkT967VBxUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fcU2zNRwv/n7u92b1+qGpk0IijgYIA0I+ol6TMnsTe8BWDyiDXNXN1cmNqXpGJSdjabNuz9GBO2s6d7Srg8J3jvF7JFkgLKL4V7bvVYWCV8+1oFPIoVimp3mxf5RMQcMTedj+hoqOmnCH8sfXuhrDeAFmY9qDMiViQXNCOr5GII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iz1LzXnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nNzGoOBe6BKRYVTtL/SL0qocozNWntgUklzkLKR1K2I=;
	b=iz1LzXnPc9gVb1BcA3w9hL00xGGrJU/KeGjfGLRR/6z0mVE+0pEWE+enpHjDDtkbgpPVpP
	GdgMPTy7aW3BLDdiaXMtgA4I1UUxp1LMNTFOX9gkgp06LYR/DQ6WbI8o4AAY7VkA72asu1
	wXUIhJ7PbX31WuYfOQocxD4tVLsXy+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-B4qFFUPWP82vnxDkqZj0uQ-1; Tue, 23 Jul 2024 06:12:22 -0400
X-MC-Unique: B4qFFUPWP82vnxDkqZj0uQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36832c7023bso3082391f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729541; x=1722334341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNzGoOBe6BKRYVTtL/SL0qocozNWntgUklzkLKR1K2I=;
        b=loYcSukzmnp2K6vx/hPwpZemQmNeDXbMzWuoGpngmbDV6a/XWkk3AFrxUmZAua6gez
         NB/x+a4kpWy+1Uq/G7G947TcPU0s2ZDWyMwwP91WuFZjESIJFhxKsdhN0UfY5suAWQvI
         jl4PR43zT72DBwLMGcT8vWd3ahGZxfDFE8U1RwDYd7OcXGRI+gym9zeWDM5EjYGyixjI
         WflkX17fR7ZZpQXLu5CjVazbp6VSrhFVyq4Hx6A6bm8aXzj+6ajQnjQuy3gAgcBkyciR
         fbwRGK083XbsHonYJ1+jc5b2VagIC8mtLyJALvav4lLrDGTDHJJhHSPJAeDkoYNf5K9y
         XYsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWRmn/NiWuSoiULRBnSLY4Ae0PxBAdrINdAu7niSNbSavfumgcYXWKEjoof9SMeGvmpSDAAHKrPsLmLBx7dDm0EhzV0XqOk87vjvLb
X-Gm-Message-State: AOJu0YxBkjpXkExe+WhxWMvW36ISCWbwdSxUdZxQ/QLkZH2mFmBd4QcT
	dONU3cA2f1nukYPrGVHdJDtKXVIN/h35ohWeesBDTObpBySyb/vjWRaZBapJAX3Jei58/MNdBkE
	PB9FwMtOPk79VmjBM6BrP+fNNVmRXl19WdJDmOmVQXtUfO4frun+YOeTIytBv3w==
X-Received: by 2002:a5d:5388:0:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-369bae34d3amr6069963f8f.22.1721729541354;
        Tue, 23 Jul 2024 03:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLdO5lHEFuHniRuCZ17wU8mF1Sz1U0vQXrtIoJfpzbGO3M/aBwevcBg8n8GIQRxE6RXhc5yQ==
X-Received: by 2002:a5d:5388:0:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-369bae34d3amr6069931f8f.22.1721729540939;
        Tue, 23 Jul 2024 03:12:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:ed00:9dc2:1adb:d133:4434? (p200300cbc72fed009dc21adbd1334434.dip0.t-ipconnect.de. [2003:cb:c72f:ed00:9dc2:1adb:d133:4434])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684773sm11116875f8f.7.2024.07.23.03.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:12:20 -0700 (PDT)
Message-ID: <50a581c9-0e59-4282-859b-922d02b3870e@redhat.com>
Date: Tue, 23 Jul 2024 12:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Peter Xu <peterx@redhat.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
 <Zp53fnlsJGOmWSRQ@x1n>
 <ox3rg6uyazlaeshxeub5hxv4z4bjai222mkitoduktmar5l3pd@qfxv4jdnj5xo>
 <Zp7MaJ0eosfaZP_3@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zp7MaJ0eosfaZP_3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.24 23:17, Peter Xu wrote:
> On Mon, Jul 22, 2024 at 04:22:45PM -0400, Liam R. Howlett wrote:
>> The problem report from [2] and [3] is that we are getting to a call
>> path that includes unmap_single_vma() without the mmap lock.  This patch
>> fails to address that issue, it only takes the caller with the assert
>> out of the call path.
>>
>> Removing the function with the lock check doesn't fix the locking issue.
>> If there is no locking issue here, please state the case in the commit
>> log as you feel it is safe to use a vma pointer without the mmap_lock
>> held.
> 
> Could you please state why there's a locking issue, and why this patch (of
> a x86 PAT specific issue...) would need any documentation on that?
> 
> I thought it was pretty common that file truncation (or anything similar)
> does a file rmap walk over vmas that mapping this file, and vmas need to be
> alive during the rmap walk, no?

Right, I was also assuming that the rmap locking (from where we obtained 
that VMA -- rmap interval tree) makes sure that using the VMA is safe.

-- 
Cheers,

David / dhildenb


