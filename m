Return-Path: <linux-kernel+bounces-246966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E839C92C96D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7582C28344D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B739FCF;
	Wed, 10 Jul 2024 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYQ6OFaG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1B1799B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583573; cv=none; b=KHLSRRDxWc5YoMaH35ABLECsVWpM35dMo91KOGUpYlmGr7KOokFnK84gPwsQuZKJyIgW1nDsMODI2aJIa/ukiMq9NsBs4A65dfYk7wcxb4ji/HOML25I2iu6c4pwpNFBKDIcFEfQoFGPUsROhBO9NhQZbdh0t+G8EBkTlq3/S+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583573; c=relaxed/simple;
	bh=sYyTLW2B8fZZKrR2tHmqnqiqiLu6J2I0mZzzGSldCHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvVlDlXh+cmqIDPv49ivowITizwgtkq0SGH1DO0sOSAmxoNLF7lSamvDTvaNaXOm9fPzBgr3mnekCSefw4byKe2a75ybkp5LvvDkznTdRPDrFVyOyaxFRxvlNr52ljliboowWp4igjToi47DhZ5+Hb2tN4O5TV/ub8UyJLz8rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYQ6OFaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/2WRjnk8r9q2UOyOTngjbjGNJsMgVn92/1xNwrFbWAI=;
	b=PYQ6OFaG53/uGZ67SIlpwBhN0WgeubUldOmbTMEbfwFaejxa1S9CBvyWhAUcAPEkTneIaK
	W8ph5qqkO7Cra5DxorB6/rS5fPnKQx7UiptGkP800ZUoa/rAi+AaqxbsAeaoWT0dPPOAkA
	Vtivmv/PYshFS7+ak2i5FTEfA2sIcAs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-W4DRyFYfO-G0I8TbyzIOYQ-1; Tue, 09 Jul 2024 23:52:46 -0400
X-MC-Unique: W4DRyFYfO-G0I8TbyzIOYQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af5f8def2so4372237b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583566; x=1721188366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2WRjnk8r9q2UOyOTngjbjGNJsMgVn92/1xNwrFbWAI=;
        b=KfjV9wBxUVJ2DqbFjyDK0hfcbbyPpuoV/37mIvSrdMVny1zSMW2IOh8Peyr3ObCNzl
         EoLm+qa1Dzbzn+NcSNZ2q8eXykwjOVT41e+chPJula8Ep+Wm81LMz1kzgwU2vckBMmwv
         zXDHj8tXG7GwBK+ImqysSHZmHWmuW52BpCQaAK/k6IAabKPmZe2ClTmc8LQ6DT2Vc/F0
         kgfvNcNA/1Mumr8+E/JihWP4fpMJhOllx5hIWkfWZ4mHjgf/1Lrml7EAMUqIf7h6iZwm
         NQn8/3BVRpOrnvodgaCP7iWZ5hKle1GrAWne7pamF4S0TOaVES0ZT7ucs2nieXIBaKtU
         VRNg==
X-Forwarded-Encrypted: i=1; AJvYcCXBodW7GwDheXEgZUTAV1gM5/wkA3M15PfvMYt1qHAGniFsnaQxRFeArcJAHU3yhkccABoM1SBMRZP1dtVEuEhicvNQ2hj//QiwnEAZ
X-Gm-Message-State: AOJu0Yz+Sei4vO+wO/sXKv9zmE8ZDjaBUcEMaJXTJK2cYJFn1h1L5i9w
	UA6X531cZn10lm1mASuDlFLkv9bOYkBcWji24gELptsbZ8wCpPdghtcUA3f1laEtVyuZn4ECZoL
	hosEL3w3kcUPpxXTMFw6WM20mwWSblzSztQuNZqgIVicDehz+RV0x3/qxZr2U0A==
X-Received: by 2002:a05:6a20:3c91:b0:1c0:f3e5:bda4 with SMTP id adf61e73a8af0-1c297d2384amr5254307637.0.1720583565744;
        Tue, 09 Jul 2024 20:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr1lxw2WapwDLATRyUEHjO0p/oGlycJSSwOxxQ8m96L48fZfje8RdV4SRAVQNkdgXKvu4rlg==
X-Received: by 2002:a05:6a20:3c91:b0:1c0:f3e5:bda4 with SMTP id adf61e73a8af0-1c297d2384amr5254289637.0.1720583565282;
        Tue, 09 Jul 2024 20:52:45 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a961f50sm10898810a91.21.2024.07.09.20.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:52:44 -0700 (PDT)
Message-ID: <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
Date: Wed, 10 Jul 2024 05:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
To: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com> <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zoug1swoTOqNUPJo@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 10:18, Oscar Salvador wrote:
> On Thu, Jul 04, 2024 at 05:23:30PM +0200, David Hildenbrand wrote:
>> My thinking was if "remove hugetlb_entry" cannot wait for "remove
>> page_walk", because we found a reasonable way to do it better and convert
>> the individual users. Maybe it can't.
>>
>> I've not given up hope that we can end up with something better and clearer
>> than the current page_walk API :)
> 
> Hi David,
> 

Hi!

> I agree that the current page_walk might be a bit convoluted, and that the
> indirect functions approach is a bit of a hassle.
> Having said that, let me clarify something.
> 
> Although this patchset touches the page_walk API wrt. getting rid of
> hugetlb special casing all over the place, my goal was not as focused on
> the page_walk as it was on the hugetlb code to gain hability to be
> interpreted on PUD/PMD level.

I understand that. And it would all be easier+more straight forward if 
we wouldn't have that hugetlb CONT-PTE / CONT-PMD stuff in there that 
works similar, but different to "ordinary" cont-pte for thp.

I'm sure you stumbled over the set_huge_pte_at() on arm64 for example. 
If we, at one point *don't* use these hugetlb functions right now to 
modify hugetlb entries, we might be in trouble.

That's why I think we should maybe invest our time and effort in having 
a new pagewalker that will just batch such things naturally, and users 
that can operate on that naturally. For example: a hugetlb 
cont-pte-mapped folio will just naturally be reported as a "fully mapped 
folio", just like a THP would be if mapped in a compatible way.

Yes, this requires more work, but as raised in some patches here, 
working on individual PTEs/PMDs for hugetlb is problematic.

You have to batch every operation, to essentially teach ordinary code to 
do what the hugetlb_* special code would have done on cont-pte/cont-pmd 
things.


(as a side note, cont-pte/cont-pmd should primarily be a hint from arch 
code on how many entries we can batch, like we do in folio_pte_batch(); 
point is that we want to batch also on architectures where we don't have 
such bits, and prepare for architectures that implement various sizes of 
batching; IMHO, having cont-pte/cont-pmd checks in common code is likely 
the wrong approach. Again, folio_pte_batch() is where we tackled the 
problem differently from the THP perspective)

> 
> One of the things, among other things, that helped in creating this
> mess/duplication we have wrt. hugetlb code vs mm core is that hugetlb
> __always__ operates on ptes, which means that we cannot rely on the mm
> core to do the right thing, and we need a bunch of hugetlb-pte functions
> that knows about their thing, so we lean on that.
> 
> IMHO, that was a mistake to start with, but I was not around when it was
> introduced and maybe there were good reasons to deal with that the way
> it is done.
> But, the thing is that my ultimate goal, is for hugetlb code to be able
> to deal with PUD/PMD (pte and cont-pte is already dealt with) just like
> mm core does for THP (PUD is not supported by THP, but you get me), and
> that is not that difficult to do, as this patchset tries to prove.
> 
> Of course, for hugetlb to gain the hability to operate on PUD/PMD, this
> means we need to add a fairly amount of code. e.g: for operating
> hugepages on PUD level, code for markers on PUD/PMD level for
> uffd/poison stuff (only dealt
> on pmd/pte atm AFAIK), swap functions for PUD (is_swap_pud for PUD), etc.
> Basically, almost all we did for PMD-* stuff we need it for PUD as well,
> and that will be around when THP gains support for PUD if it ever does
> (I guess that in a few years if memory capacity keeps increasing).
> 
> E.g: pud_to_swp_entry to detect that a swp entry is hwpoison with
>       is_hwpoison_entry
> 
> Yes, it is a hassle to have more code around, but IMO, this new code
> will help us in 1) move away from __always__ operate on ptes 2) ease
> integrate hugetlb code into mm core.
> 
> I will keep working on this patchset not because of pagewalk savings,
> but because I think it will help us in have hugetlb more mm-core ready,
> since the current pagewalk has to test that a hugetlb page can be
> properly read on PUD/PMD/PTE level no matter what: uffd for hugetlb on PUD/PMD,
> hwpoison entries for swp on PUD/PMD, pud invalidating, etc.
> 
> If that gets accomplished, I think that a fair amount of code that lives
> in hugetlb.c can be deleted/converted as less special casing will be needed.
> 
> I might be wrong and maybe I will hit a brick wall, but hopefully not.

I have an idea for a better page table walker API that would try 
batching most entries (under one PTL), and walkers can just register for 
the types they want. Hoping I will find some time to at least scetch the 
user interface soon.

That doesn't mean that this should block your work, but the 
cont-pte/cont/pmd hugetlb stuff is really nasty to handle here, and I 
don't particularly like where this is going.

-- 
Cheers,

David / dhildenb


