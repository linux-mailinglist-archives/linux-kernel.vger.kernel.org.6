Return-Path: <linux-kernel+bounces-214827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC7908AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572D41F28757
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFF194C67;
	Fri, 14 Jun 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu1lIwmX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313E194132
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718363409; cv=none; b=q0gbWgu8srYbXXbsc2gyyVFdUE4RSF1bg0W9tJWE2nbgf3hKjp6NeKhBmdkqiGTR2x8ZTP8fnW9Fq1ZWspA7TQYzxAi1U443qhUt5jkoogY2edJz4yFJD+5jgBdy69RbUXNt8SS9Kla6DA4rbWHZ6tu89wVwWPh/zX6JbVFwLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718363409; c=relaxed/simple;
	bh=YCsaHm5iZolRWDseHK/GGIMl0Aip3yfcKxyQkkgk+qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzirXVaOw1dur11qTTDYxeELwLuTav79rLNdzFg3X3MIQSg3qM6DptzH+NKITeOgTlhNBV7SuCbPPZry+YYLrCfjQ6xy6yy9R8xLmksBfMpHNQZW7E9LRGU916lFCilwrQkrF2Z5knTp/2Inu1IBsT15E6MG0u3nieot4igiauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vu1lIwmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718363406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lDoP3n5U8svwzcXHuhtzvLXNWKAcZjpKZT5vUmNNoBQ=;
	b=Vu1lIwmXLvSZEW6eDh5td1R/oDX12Wr5Gm3n0sFRfRIsZbhLxKjzlE95Otp0miSg/UNnLm
	1o3r4SGlQV3dHYHDx+lovAHbuAlKwHz2I1DM+0od3iK2mITnmmudAOM8v/vV/6ICxcnM4y
	Hc6TKaScSOrHrDobuN17EoiRr/oul4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-zfN1VdM7MF6DjO_wElkNkg-1; Fri, 14 Jun 2024 07:10:05 -0400
X-MC-Unique: zfN1VdM7MF6DjO_wElkNkg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4213441aa8cso14058915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718363404; x=1718968204;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lDoP3n5U8svwzcXHuhtzvLXNWKAcZjpKZT5vUmNNoBQ=;
        b=r7ZBHPLKE+AxeqL9zJG2Bez/f6lvOOWtXREvHEyeZ7zD3CZJ3eeXGADMjel1uVSxl1
         FJtzR8L4W3etmMUwNfGFe+qAE9xmhzhcsO4Eb09fZeQDvtEeQuGm5vwnFS06SwEQXStA
         c0tU67UqE/ecEIbZ8WuA+wP3+L3GZPTi3ORqF2e1aYf7pr5DOqFSnrWPsUWw56yZ1iCY
         4wej00zS1WKIq0S3tHvMan3F10mhAEz4792fI3qxYEaWcxjzhjEPQG0Va3YFNgtPkrNu
         Bv+19ogh7s2SrBDAeCjwnJE45J4NoNF6gn2vI6j2ClOo1N03ts6MvodZIINoAv8/4qS3
         1B2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTCV1OsuaFkfsr+uQ6ehJ2hfT3SOy9mW67RVRY1ATbJeDrDzJ2bFLgia4L9KB9wVULGLz/6Xm0U+q2JGkbOH6mjXAiVTXNvfbqJzZO
X-Gm-Message-State: AOJu0YxJzKltgnHVXZA0qZkLss/udmM+1+9T5iXQqgvXARvXPBSiwE7k
	qfolswmshKAiigLX5S66f5NNkWHPPOq1Hezs/QO3wBDfrIf/3ZsKmKejwO7JnNdMyXyKpAoAeW0
	N2iN/Zi9ZELP9Ji4HC3soX9aSzk9Qy1SBQqW7KAb53K6lZJ14PGeoBgOrInpcWA==
X-Received: by 2002:a05:600c:4ed2:b0:421:7983:f1c4 with SMTP id 5b1f17b1804b1-42304822952mr20956755e9.6.1718363404197;
        Fri, 14 Jun 2024 04:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWrFvxFWl4j/3eMgj5zcaBKhfMweUrDuGoUebxXF/1MagUcsbMoY36WJ8VKn9mbLbdEUvMA==
X-Received: by 2002:a05:600c:4ed2:b0:421:7983:f1c4 with SMTP id 5b1f17b1804b1-42304822952mr20956485e9.6.1718363403720;
        Fri, 14 Jun 2024 04:10:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9193sm94316495e9.21.2024.06.14.04.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 04:10:03 -0700 (PDT)
Message-ID: <c50287f2-1c83-438b-ba4a-c08ef91b5ba9@redhat.com>
Date: Fri, 14 Jun 2024 13:10:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in
 __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 ying.huang@intel.com, yuzhao@google.com
References: <20240613000721.23093-1-21cnbao@gmail.com>
 <20240613000721.23093-4-21cnbao@gmail.com>
 <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
 <b0b4a134-1d40-4eef-94f3-5c4593b55e78@redhat.com>
 <CAGsJ_4zDoevXiNOTbSefU4WfoPEpbkhArc1niTBFRPsMHu5j8w@mail.gmail.com>
 <cac7d354-bcf3-4d7f-866a-9665568a50a0@redhat.com>
 <CAGsJ_4xfPPz8oOe79nPxues0PkEem8O2Q+0zo6pU8uDGO1kMkg@mail.gmail.com>
 <e151cfd9-c0a5-4536-a490-77dc47aa3ed6@redhat.com>
 <CAGsJ_4wss6++EP8hSyuc3sPqtLgqqjs7DOUfQ5aCK36Bn+VbBg@mail.gmail.com>
 <CAGsJ_4yiVs48XKTMkijS95MwXfxcRkRv0j0rj7cFjKCi2AcYZg@mail.gmail.com>
 <aa2d9d4f-8f06-4388-afe3-ed4b626d41e2@redhat.com>
 <CAGsJ_4wJjp5kTRt=MAQ7umS-uSw9uyUthj1z5urmo5t084aUwQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wJjp5kTRt=MAQ7umS-uSw9uyUthj1z5urmo5t084aUwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I don't think that is required? We are only working with anon folios. Or
>> were you able to trigger this? (which would be weird)
> 
> I didn't trigger this. but I am not sure if kfifo is always anon based on
> the code context.
> 
> for page,  it is 100% anon(otherwise "goto out"), but I am not quite
> sure about kpage
> by the code context.
> 
> static int try_to_merge_one_page(struct vm_area_struct *vma,
>                                   struct page *page, struct page *kpage)
> {
>          pte_t orig_pte = __pte(0);
>          int err = -EFAULT;
> 
>          if (page == kpage)                      /* ksm page forked */
>                  return 0;
> 
>          if (!PageAnon(page))
>                  goto out;
>          ....
> }
> 
> Then I saw this
> 
> static int replace_page(struct vm_area_struct *vma, struct page *page,
>                          struct page *kpage, pte_t orig_pte)
> {
>          ...
>          VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
>          VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage),
>                          kfolio);
> }
> 
> If kfolio is always anon, we should have used
> VM_BUG_ON_FOLIO(PageAnonExclusive(kpage), folio)
> just like
> VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
> without "folio_test_anon(kfolio)".
> 
> So I lost my way.

try_to_merge_one_page() is either called with a KSM page (anon) from 
try_to_merge_with_ksm_page() or with the shared zeropage (!anon and must 
never become anon) from cmp_and_merge_page().

So in replace_page(), we either have an ksm/anon page or the shared 
zeropage.

We never updated the documentation of replace_page() to spell out that 
"kpage" can also be the shared zeropage.

Note how replace_page() calls folio_add_anon_rmap_pte() not for the 
shared zeropage.

If we would have to craft a new anon page things would be going terribly 
wrong.

So not, this (!anon -> anon) must not happen and if it were to happen, 
it would be a real bug and your check in  folio_add_anon_rmap_pte() 
would catch it.

-- 
Cheers,

David / dhildenb


