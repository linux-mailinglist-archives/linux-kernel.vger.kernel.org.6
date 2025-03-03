Return-Path: <linux-kernel+bounces-544659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95FA4E3B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EA819C2184
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0420898C;
	Tue,  4 Mar 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3E9ZHE9"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C929616C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101649; cv=pass; b=U9i1yxsPAzWivFNQP68NtclW1MdUMA8je5YvuKyT5a30hcRwYP6paUUhLccwb2BeJ2UGJc3w11WsSZeiZ0g06nZIFXHHx1iLxf+etWmQXFxFhuMUtQvyhA7fvNa7qSRxxhwMPeSErx4t47gWLbd5XWdYvu8MsQ2Q0dMA4XQ5GEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101649; c=relaxed/simple;
	bh=JTyTHNloR3xDUjK8RymDbJ0QEbLzHy1TcN78c7jPexM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eifRvuJAvbLp0QUCHDelFaTCCTqdCjwtMHq0scm8+NzZmZTg5UKR3eqkq3pFu4huG4XlJxOaOC9sPYbYKpU5N2i32Q36KzgfKtyebTyXP0vjJLaRtJbJyTYn0pYmlnGi0xxsbtAZ7+M4zCdvBOcyvAZAj/55ZiKavjeKypH8hxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3E9ZHE9; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id CF4C340F1CFA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:20:45 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E3E9ZHE9
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fTv0MsqzFymb
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:18:59 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5822F4272B; Tue,  4 Mar 2025 18:18:57 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3E9ZHE9
X-Envelope-From: <linux-kernel+bounces-541151-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3E9ZHE9
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 65C4A4260A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:27:44 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 072C43063EFF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:27:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557F4170F38
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31D1EFF80;
	Mon,  3 Mar 2025 08:25:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132891EF0B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990340; cv=none; b=tFPjnPd5d3CCTktBa3NFi/0VYENmmF7hBtuzzY/v9CpmrQlH0J5PBuWZ8noCP2a3hk5YvfjceQjxNk/YWj7j9EzIrM0/rLpMeFFTkliUZFaScu/bIm3QSwvjpJfv4LUcn4OPVTIYM1WLHnhkhj3XZSpBxad/vgkF30N5bxhlplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990340; c=relaxed/simple;
	bh=JTyTHNloR3xDUjK8RymDbJ0QEbLzHy1TcN78c7jPexM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwWPUg3e7J0dAvuNOrxlzE5ZDwHV1j0jiEKfq+uw5QDubE5ORiBgctTyeXrZjGmT3bTa7FqIs7Bs93Qnp4BnloPlOQb/wTgVExhq9yuK7KggcgV7aalrcjrn30j0ppOPJzwqqmBkUi2igHlJm3TFo7Kx/GlnDoWTgJ1L7luIOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3E9ZHE9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740990334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xQJa5hq33EwCeIlC6ZAKrgfFf28o5I5tCi+O9hYDtj8=;
	b=E3E9ZHE9kCvnipyvx23aB5gJ7pYxS2lvbTXnwHRvUWumEAvzA8hBdm7HVznxFKIRga6L6w
	1KcrW+5LkJHVE3RKxdw5NabvNzZwJ3l6r1CyGWcSIarejdDxGY0YrSIgTrHv2vnjO5xqgn
	L84OESvimKgoYNHLC6UKZgrbxB9ImB8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-7rn24ahwOIWaFeR4rCDOfA-1; Mon, 03 Mar 2025 03:25:33 -0500
X-MC-Unique: 7rn24ahwOIWaFeR4rCDOfA-1
X-Mimecast-MFC-AGG-ID: 7rn24ahwOIWaFeR4rCDOfA_1740990332
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e003c1easo1843565f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990332; x=1741595132;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQJa5hq33EwCeIlC6ZAKrgfFf28o5I5tCi+O9hYDtj8=;
        b=K6r+0CzOMWZWUczHd324Xe3fxYWrUxQj1Eyfd8bXbfD8LbAjRJ1H5FQKiYEwUOatVw
         SqhH9xvU4J92lC6cqloRjUMuh8D4X9U2MhZ8RvbepzxjXgocWANfI+H4Mxa/TCqriDvz
         s1CVNwF0W3TwKzRjsmvJihXOCXU2DuXnnd/F5eytc03jW8c9XsO8vTdi9FzWSWqBAwja
         /9LVLBc4pHZnYmg3A8jKftMocMyxBmaT+0nofZ/OOY+N2j/+ACZvBCB17puf1zE3vVl/
         UlgAImexwFvBqAtzIUEHyXcqS8cSNijYTmqg/DtzviRsq7x6pDPDMWqslbKmgd9Ifc2m
         Fh4g==
X-Forwarded-Encrypted: i=1; AJvYcCXqT/AONl1opMphiqqMaMqAruOc9CQvldmpUTUKszh/MpR/hKsDkvRRI1YMRjKMs411SieZd/Onoq7vzzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkjd8Q+1wulo/1qT7MN4XlC9RxNlQC+AjhqVwwWALxvSSItYC
	m9KtN2Qb42vDaPP4z8rRDkn62Vj0X6hgO3KtXxyyBScvG+nV7KBzIn2TY4urRhFliP0hpV1FAOl
	/4I1wK0O6IAbqU00EqteBUk6ETYsHwXf9MXXvQIMfWmuRcfTGuCuJzcXHbREJ4Q==
X-Gm-Gg: ASbGncveziaOIg8pCyNNEyyOkSZ9p8t9c4V22TZWNTG/eVzabwhmRxakvtXETLPht9U
	y0wK9kZc5UGqumJh9jdTNe2KTbTmr58ZjzaP5jA0/BqrwLVnUvVy3oXPsKD0HsBl2WymMoIg1wt
	A03do8pUK5IKN08GtjCrsHP1PBS9FuQnA2Fki/gCJsO5etRNOPjwf/zovasrelpgXdyN7nY6SBs
	mACkBEpt+l4yMhS+0Y59odX5RfkxNT7zphGQja7rpJE8TVdQmTCNb67Nt8ACwo2Oi+CVV/3KL0N
	Q4uNdISPsS8CuVPqRPGG6PKSmrkIeeFlneQCg6AmrgQOLKXPWocqebv1G+1iEnPmOpJLpossfb5
	fq4wkl2D8bRmpGQ+Q0tpjWCC8BLDq/gdI5+a/bJeF8Xo=
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12598019f8f.11.1740990332280;
        Mon, 03 Mar 2025 00:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHXdEcK466k9cymsnu6lkTJiaTmjAeBQ+6arxNNNOBmOvsqU6SoLHa6hs0wN1owqcbaCRBJg==
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12597996f8f.11.1740990331870;
        Mon, 03 Mar 2025 00:25:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm96630265e9.0.2025.03.03.00.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:25:31 -0800 (PST)
Message-ID: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
Date: Mon, 3 Mar 2025 09:25:30 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Jiri Bohac <jbohac@suse.cz>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>,
 Michal Hocko <mhocko@suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fTv0MsqzFymb
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706356.87218@EQSav9jSC9+qHxO+7gVaOQ
X-ITU-MailScanner-SpamCheck: not spam

On 20.02.25 17:48, Jiri Bohac wrote:
> Hi,
> 
> this series implements a way to reserve additional crash kernel
> memory using CMA.
> 
> Link to the v1 discussion:
> https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
> See below for the changes since v1 and how concerns from the
> discussion have been addressed.
> 
> Currently, all the memory for the crash kernel is not usable by
> the 1st (production) kernel. It is also unmapped so that it can't
> be corrupted by the fault that will eventually trigger the crash.
> This makes sense for the memory actually used by the kexec-loaded
> crash kernel image and initrd and the data prepared during the
> load (vmcoreinfo, ...). However, the reserved space needs to be
> much larger than that to provide enough run-time memory for the
> crash kernel and the kdump userspace. Estimating the amount of
> memory to reserve is difficult. Being too careful makes kdump
> likely to end in OOM, being too generous takes even more memory
> from the production system. Also, the reservation only allows
> reserving a single contiguous block (or two with the "low"
> suffix). I've seen systems where this fails because the physical
> memory is fragmented.
> 
> By reserving additional crashkernel memory from CMA, the main
> crashkernel reservation can be just large enough to fit the
> kernel and initrd image, minimizing the memory taken away from
> the production system. Most of the run-time memory for the crash
> kernel will be memory previously available to userspace in the
> production system. As this memory is no longer wasted, the
> reservation can be done with a generous margin, making kdump more
> reliable. Kernel memory that we need to preserve for dumping is
> never allocated from CMA. User data is typically not dumped by
> makedumpfile. When dumping of user data is intended this new CMA
> reservation cannot be used.


Hi,

I'll note that your comment about "user space" is currently the case, 
but will likely not hold in the long run. The assumption you are making 
is that only user-space memory will be allocated from MIGRATE_CMA, which 
is not necessarily the case. Any movable allocation will end up in there.

Besides LRU folios (user space memory and the pagecache), we already 
support migration of some kernel allocations using the non-lru migration 
framework. Such allocations (which use __GFP_MOVABLE, see 
__SetPageMovable()) currently only include
* memory balloon: pages we never want to dump either way
* zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
* z3fold (->zpool): only used by zswap (-> compressed LRU pages)

Just imagine if we support migration of other kernel allocations, such 
as user page tables. The dump would be missing important information.

Once that happens, it will become a lot harder to judge whether CMA can 
be used or not. At least, the kernel could bail out/warn for these 
kernel configs.

> 
> There are five patches in this series:
> 
> The first adds a new ",cma" suffix to the recenly introduced generic
> crashkernel parsing code. parse_crashkernel() takes one more
> argument to store the cma reservation size.
> 
> The second patch implements reserve_crashkernel_cma() which
> performs the reservation. If the requested size is not available
> in a single range, multiple smaller ranges will be reserved.
> 
> The third patch updates Documentation/, explicitly mentioning the
> potential DMA corruption of the CMA-reserved memory.
> 
> The fourth patch adds a short delay before booting the kdump
> kernel, allowing pending DMA transfers to finish.


What does "short" mean? At least in theory, long-term pinning is 
forbidden for MIGRATE_CMA, so we should not have such pages mapped into 
an iommu where DMA can happily keep going on for quite a while.

But that assumes that our old kernel is not buggy, and doesn't end up 
mapping these pages into an IOMMU where DMA will just continue. I recall 
that DRM might currently be a problem, described here [1].

If kdump starts not working as expected in case our old kernel is buggy, 
doesn't that partially destroy the purpose of kdump (-> debug bugs in 
the old kernel)?


[1] https://lore.kernel.org/all/Z6MV_Y9WRdlBYeRs@phenom.ffwll.local/T/#u

-- 
Cheers,

David / dhildenb



