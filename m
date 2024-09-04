Return-Path: <linux-kernel+bounces-316076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0F96CAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FDE286692
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162F17ADFF;
	Wed,  4 Sep 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPsKM2WV"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C41779A5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492993; cv=none; b=hGEmw1tW3kckjj0jy8yiI0kmcgnCjZ+6mdgt9nBLOAJzULV1Sjnq6z9lZOpENuOb2QFPsRmaitJSBjbaBnpqjCNer1Q+NYbB9IcbSLwr7JggQ4WhGNAw90EGHmFmK7CLcz64/wteTQ61vGvEKNhNajuHGqOE8xZFasjivo+kL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492993; c=relaxed/simple;
	bh=fOa1Q51qe4eSFjqGABixW/4hdYdiQtGL11hyrEMANlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEUfOfkPOyJ6467RbohGw/ICjyW8m0uD8kBPNJKagbtaW2MBACe1LlnPMyHQJRkGBnPrqvE2MqrrPhCVsn0OFFCYwC309fbLz2LY5VWVoRPMrWI7YH5yeHGiCuEMAUbfJWZrR6IVPz5t2J1XapORHNxVr5vCuLcAsRCJqggdEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPsKM2WV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a80eab3945eso29958866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725492990; x=1726097790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fOa1Q51qe4eSFjqGABixW/4hdYdiQtGL11hyrEMANlA=;
        b=MPsKM2WVt2sUBm90hKCTyGq0lMMgYb8rN5ZKj2LPs7Oc7D4KBP8sY8zGdsWA3/Tdl3
         q8o6LJV0k0I11gnyXcAWb4fGrU74CbNvBnqeWHDPwYQ9pWO+u8OmdUZTqPmTdgb3Qaeq
         9PUedgVeRVU+hvEmHVheNXMt4QM4zRng1cL2LzeNGVnffz/wQRWQCyCyJkaPYPROUalG
         wy2pYiXsVc3SFUohOJtM45+O6URRQOauuxtjmdtpRkrBkazKFMmVMTDSCGLkE4mNja9z
         Q/qcjKbOQte4DBaZYaamAUc0U1Qojsos93X6dw0NzJTB6s0Sa33LrtWpv2DGIV4LNGOW
         zfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492990; x=1726097790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOa1Q51qe4eSFjqGABixW/4hdYdiQtGL11hyrEMANlA=;
        b=smQA7pRjY9GejlppJ7SXuY4PMoedmjjhgpk5VPcnTFwLlLCpgv05fOjdILBuCO9rZm
         91biMZKfL/ajm2P4SAi+Mw4Y3904zOvLtEuFxfRYH7OIiAXyutC0JAaN/Rd7jHoA4WKv
         3NqgMrv0+DDpHOd+3LqLlxkRYSgTnvEn0A8kAxAbdufj5UBowWGJV32FotImthUEs1Oj
         S1BO4VVtxnVwwL3ojGQ0AUSSuXZD4KgjgOstLk/1XWjFnBSw0kb0negERsQfsqofp8M6
         zxvyAZ7Ms+t9VN0UIMu9Y5OCYmxHiox924QDLchOSACxtdk8csxfjfnEaAjVgLg8P9yj
         XEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgLGZwB7udhuYKtAqLEHIS1/EKP8WozSrM4Jsw1JBLvZNBZUl5kiPNSczsEk39oeGLri8027yye0xfdaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmVox4G1o61BCTI0F0ZP6lyrdXBH3cYV6gIweBSP9uAvvN+ZZ
	WZqeJFAg7VO54eNwRwxxK30unmg6hUBpNRvrBvBkm/jj8ZxQApFH+8pkX2MgXwDoPvcn84Mnmsq
	Sx+VRdvLAVfVBlNAdeZB23iuB8fK5l6Cd62Cy
X-Google-Smtp-Source: AGHT+IHDuuc1NSBZcv5eJMmcgD4W2enzMP+OEXUp/tHe1vBeLVIoJgIUtpVBiUuFO4YpWpSbAoDry8IrbZw74IYvlGY=
X-Received: by 2002:a17:906:db07:b0:a86:ae95:eba3 with SMTP id
 a640c23a62f3a-a89a3823702mr1493644166b.62.1725492989563; Wed, 04 Sep 2024
 16:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com> <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
In-Reply-To: <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 16:35:52 -0700
Message-ID: <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > On the other hand, if you read the code of zRAM, you will find zRAM has
> > exactly the same mechanism as zeromap but zRAM can even do more
> > by same_pages filled. since zRAM does the job in swapfile layer, there
> > is no this kind of consistency issue like zeromap.
> >
> > So I feel for zRAM case, we don't need zeromap at all as there are duplicated
> > efforts while I really appreciate your job which can benefit all swapfiles.
> > i mean, zRAM has the ability to check "zero"(and also non-zero but same
> > content). after zeromap checks zeromap, zRAM will check again:
> >
>
> Yes, so there is a reason for having the zeromap patches, which I have outlined
> in the coverletter.
>
> https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/
>
> There are usecases where zswap/zram might not be used in production.
> We can reduce I/O and flash wear in those cases by a large amount.
>
> Also running in Meta production, we found that the number of non-zero filled
> complete pages were less than 1%, so essentially its only the zero-filled pages
> that matter.
>
> I believe after zeromap, it might be a good idea to remove the page_same_filled
> check from zram code? Its not really a problem if its kept as well as I dont
> believe any zero-filled pages should reach zram_write_page?

I brought this up before and Sergey pointed out that zram is sometimes
used as a block device without swap, and that use case would benefit
from having this handling in zram. That being said, I have no idea how
many people care about this specific scenario.

