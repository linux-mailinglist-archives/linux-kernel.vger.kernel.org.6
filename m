Return-Path: <linux-kernel+bounces-335839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92197EB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806071C215C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33822197A9B;
	Mon, 23 Sep 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0nCn1ttq"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F28002A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093451; cv=none; b=jgyBmVKZVTIuU0bptny3MQnPUVY6Kt470IKHjboYXFuwvR3pCnmZXLgsxup8NxQxtsifa7CJV8sUZ5tm9NMM9DoNETwLwUebNfk6uaOfg1dbc7kr/RGEYEVqbzG+qiz2uUn0kU8SVsaZ28fp79/XvHR4M4N+3vP+tkWgVH2F+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093451; c=relaxed/simple;
	bh=sKw4RpY/kNpY5eSc9/qtLDCJMPcC2OkmwvZa/qK45fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp1xug1In9wGay+MGRygBn8J+wbEI8JJT/3GaLrhijeVUEoyzLMpwFzxGInV/xKge75Xky6eS5M9LKHVmSui4qjS98HnSN4aUSZDixQPErnLJbXcOmAywZ/8fRLwbFBebxvxsAfIHJ1baqQxw/tVg+OUHEJqJ79xHmK4SNMZv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0nCn1ttq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9a23fc16fso479807285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727093447; x=1727698247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRfOQ0tS9cN4A6dE8SfP42PhT4ARLrBFORewUNU1yeg=;
        b=0nCn1ttq0UMHWnngkOZSxQ5rUajEAcpwMGGBZBT3QCvSxDX1/Z8hf1Q7hljhvSSViU
         Hy21LeSVuB41hoxuaCMtAr0tT08FWaa9mPwC7pehm+cdyb9XrO4zSk3l8IIyYmcHknmG
         F/Ne7eGQGWkzftIF1xRz4d3NvBE45LphnoNG5T6wLHYXyEDerI7OvLZaNWDCdn/17Jr6
         qH6PfF3UzoLmMcTXVkbTHD4QWWIArRcG1qf8IB0cO0O3eh/WXAWIIpAQrkEmo8rKXQ2S
         0SSPm45l9vNL59HT45TZmem0mQc1hCNiUABLWFo5UWskf9DTQw3RCPdTE9J2K0ub7UDQ
         +Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093447; x=1727698247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRfOQ0tS9cN4A6dE8SfP42PhT4ARLrBFORewUNU1yeg=;
        b=Ssrc2GG28h+5YjL4OHCDrOg/1dqngCEqFJPzuGD07HkIRt5PrBte6c8xVKZQNcY9oK
         sfG0RW7pwbsmMb7wh+O8SXPeHnadHUafswZawdYfi+RYzw969idws4PRuZSuAQeTQym+
         N6pUnoe5+HAfX51DdNR2+cTV6LOyMUb7XdMSqXngZnl+o3w2+jZmA+QWzPHbXtzvWcd7
         U9p1ZW4Bml6Umcv1cOtsv2QIJPliibSmnfrL7NN67vpNO4Dy8MHkzrSmHaL0bNKrk499
         wh9REnqeBt/MPBeUwjKJxCaceWrxVrG7AqPb/hySMoszJgVAeBk8Sxd1jmh6S21UEeeY
         hPeg==
X-Forwarded-Encrypted: i=1; AJvYcCUCRt2pE6i3z/qR/3RiN91SOVT4OEm9Eg7CllBRPxo8WFkBtohRVrqX0Hkb5JpKsRMvAB5uK1YRI0tgrAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6BK7LopGMVQxvnBwRmOvolZX7JAo6BvzbbyaMvMTM74Qe0l+
	YOB+dezJtkj9qk/1jkhik5fRSq3/kPBtSIlQzRQ/aB5fIoUjybYyn7F9/3gQw5M=
X-Google-Smtp-Source: AGHT+IElg8qVKPTj4Pd2rDhN1S71xp00EUK4UYGmT5pMHGR/us3IeiPIoyDuGeqQZi3Ydh6nJDM7Aw==
X-Received: by 2002:a05:620a:450a:b0:7a6:5a80:7ee7 with SMTP id af79cd13be357-7acb8209cd4mr2158460385a.46.1727093447388;
        Mon, 23 Sep 2024 05:10:47 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08ed0bdsm470264885a.130.2024.09.23.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:10:46 -0700 (PDT)
Date: Mon, 23 Sep 2024 08:10:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	chrisl@kernel.org, david@redhat.com, hughd@google.com,
	kaleshsingh@google.com, linux-kernel@vger.kernel.org,
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com,
	ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
	ying.huang@intel.com, hch@infradead.org,
	Hailong Liu <hailong.liu@oppo.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Message-ID: <20240923121041.GB437832@cmpxchg.org>
References: <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
 <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
 <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
 <CAGsJ_4wd=6kuwg7v=_ARb+Ay15M8SU776Vjb4rmtiVp8vQg-qA@mail.gmail.com>
 <2c418b81-8f67-4a45-b4d2-d158fa4f05d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c418b81-8f67-4a45-b4d2-d158fa4f05d9@gmail.com>

On Mon, Sep 23, 2024 at 11:22:30AM +0100, Usama Arif wrote:
> On 23/09/2024 00:57, Barry Song wrote:
> > On Thu, Sep 5, 2024 at 7:36 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>>> On the other hand, if you read the code of zRAM, you will find zRAM has
> >>>> exactly the same mechanism as zeromap but zRAM can even do more
> >>>> by same_pages filled. since zRAM does the job in swapfile layer, there
> >>>> is no this kind of consistency issue like zeromap.
> >>>>
> >>>> So I feel for zRAM case, we don't need zeromap at all as there are duplicated
> >>>> efforts while I really appreciate your job which can benefit all swapfiles.
> >>>> i mean, zRAM has the ability to check "zero"(and also non-zero but same
> >>>> content). after zeromap checks zeromap, zRAM will check again:
> >>>>
> >>>
> >>> Yes, so there is a reason for having the zeromap patches, which I have outlined
> >>> in the coverletter.
> >>>
> >>> https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/
> >>>
> >>> There are usecases where zswap/zram might not be used in production.
> >>> We can reduce I/O and flash wear in those cases by a large amount.
> >>>
> >>> Also running in Meta production, we found that the number of non-zero filled
> >>> complete pages were less than 1%, so essentially its only the zero-filled pages
> >>> that matter.
> >>>
> >>> I believe after zeromap, it might be a good idea to remove the page_same_filled
> >>> check from zram code? Its not really a problem if its kept as well as I dont
> >>> believe any zero-filled pages should reach zram_write_page?
> >>
> >> I brought this up before and Sergey pointed out that zram is sometimes
> >> used as a block device without swap, and that use case would benefit
> >> from having this handling in zram. That being said, I have no idea how
> >> many people care about this specific scenario.
> > 
> > Hi Usama/Yosry,
> > 
> > We successfully gathered page_same_filled data for zram on Android.
> > Interestingly,
> > our findings differ from yours on zswap.
> > 
> > Hailong discovered that around 85-86% of the page_same_filled data
> > consists of zeros,
> > while about 15% are non-zero. We suspect that on Android or similar
> > systems, some
> > graphics or media data might be duplicated at times, such as a red
> > block displayed
> > on the screen.
> > 
> > Does this suggest that page_same_filled could still provide some
> > benefits in zram
> > cases?
> 
> Hi Barry,
> 
> Thanks for the data, its very interesting to know this from mobile side.
> Eventhough its not 99% that I observed, I do feel 85% is still quite high.

Would it be possible to benchmark Android with zram only optimizing
zero pages?

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c3d245617083..f6ded491fd00 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -211,6 +211,9 @@ static bool page_same_filled(void *ptr, unsigned long *element)
 	page = (unsigned long *)ptr;
 	val = page[0];
 
+	if (val)
+		return false;
+
 	if (val != page[last_pos])
 		return false;
 
My take is that, if this is worth optimizing for, then it's probably
worth optimizing for in the generic swap layer too. It makes sense to
maintain feature parity if we one day want Android to work with zswap.

> The 2 main reasons for the patcheset to store zero pages to be
> swapped out in a bitmap were for applications that use swap but
> not zswap/zram (reducing I/O and flash wear), and simplifying zswap
> code. It also meant fewer zswap_entry structs in memory which would
> offset the memory usage by bitmap.
> 
> Yosry mentioned that Sergey pointed out that zram is sometimes
> used as a block device without swap, and that use case would benefit
> from having this handling in zram. Will that case also not go through
> swap_writepage and therefore be takencare of by swap_info_struct->zeromap?

No, it won't.

However, the write bios sent from swap have REQ_SWAP set. Zram could
make its same-filled optimization conditional on that flag if it wants
to maintain it for the raw block device use case.

