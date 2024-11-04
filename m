Return-Path: <linux-kernel+bounces-395215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB39BBA60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0707B1F2386C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934E1C07E4;
	Mon,  4 Nov 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Lz6GIvOV"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B62BB04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738053; cv=none; b=thA1uEn0nRQipEWCa5d/XpU3miCy9i8C8rvB0RfMsYqY0YsS1bCatLcgqbOn5TYzuJ4E4NhRQspERqXz88V6b5UBTJvB54vVaMHIs0Ykwr3jUStuxBp9HPYaZUvZ1fkzUChrcDsseYKh6TNAzwO89OMiJUZ1T143PhNQdFbrtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738053; c=relaxed/simple;
	bh=2BRjgS0AxpemRKCD7GDKfZ2a8oM9AU0aSXE8m73qv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYJSIDur2GKoiksMhi/z0WizS7vQNEyRNFwl3szB9M7r9HLuVom1cUUDnF7t1xYmr2i6ILXhqZxSEMbKEkKivhlwn3NYwK8F/6xZnsY8NecCNvtFNxefV1pnkvmZpAlyR6OipaaH38anPOMb+qStPbu90qOD86Aih6QLj7EIM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Lz6GIvOV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1507c42faso407398085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730738048; x=1731342848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX1khw0TKho0yFzPsMp3dwNcz3lK+q/XoPKlIPJlqlM=;
        b=Lz6GIvOVeOA9mkqbPASHkrY9Spg7k2as9YNVxAd0U9KIfkYZtYHKGPjnwwmcxwnvFn
         t6w0WNbMMh7m3eEy9t1yGb8S+NPBIsERoQ05K/JpT8eDktAfRtj4gyvlMnyKvQRpKLDR
         S+WaPo6uadLEUZfFhryRpz+rwKQQEBa6Th9itMaTBtU6nljiMRVfxoEeepY8vtaxRxR2
         3bJFJrRcyyEsrwseLJpPNGeXpPlwS39sMd+IZCSvpwPMn23pZJ3JyvINDiuyjRcOcBTP
         bOKKXvR7ignLMe3Vic2h14OmcKwkVcBZp5Bw64S8VUS//lmnc1+TJuTOzB8zLVp0ey87
         E8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730738048; x=1731342848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX1khw0TKho0yFzPsMp3dwNcz3lK+q/XoPKlIPJlqlM=;
        b=LUTfPwKtHbhnC/RKXTNDduJPBBrm0oEUOA2gU0mkCzKo5sy3lDpn+NCe8zYzvETP3M
         75jz2HdqRIpvcA+M7N4dG6z7YWz729Q5qaqt9npo30ctG+bsRKZU9kqCV0bSHtFAu7Di
         mqj7y+SiDSsAMFXWMRcRcbdAPuYodCKq2DoEuq2Wp4wxeYWMjD03hno1e8AHBFUL0Jix
         GtnEKhouH4Ujy6/v4jOSlUO/GEqFbpy+/oBc8wkx81Cdjgg1Bt2Y2qvWBDv9zeky1jq0
         nyu2mvftpN5fKUGO9XItRiNOSNgudw9R6Ou6pgPyc/dY4WUqNAOi1Bw6ta5TpYZDkLbJ
         bSLg==
X-Forwarded-Encrypted: i=1; AJvYcCXyD501ulXAQt4BfuExsonJG9Q8GOn3hmFq1RIAJP4x+Domiox1Nct97DOALvyLHTOKFDt5IZg3lDoM5pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0lBGEhshRy56hFgUA2uWjaB9ApRw/ubB4Pacnkj5H8J1laLx
	qjKPxslBtmMH5dMeiUR0CE6YAOOTCxq5urIBrBB+MH2HawkfnU+LXOYKIf0568Y=
X-Google-Smtp-Source: AGHT+IE5cRit64NOIWXFwfHPa/+8dF20E77ojQpVMudW8g0lIn+CghLrTU4e1Mcq/buC7Bkm41/HIg==
X-Received: by 2002:a05:620a:240a:b0:7b1:45be:2e98 with SMTP id af79cd13be357-7b2f3cfa7c4mr2535810985a.10.1730738048549;
        Mon, 04 Nov 2024 08:34:08 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a8114asm433769085a.106.2024.11.04.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:34:06 -0800 (PST)
Date: Mon, 4 Nov 2024 11:34:02 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
Message-ID: <20241104163402.GA810664@cmpxchg.org>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>

On Mon, Nov 04, 2024 at 01:42:08PM +0100, David Hildenbrand wrote:
> On 02.11.24 11:12, Barry Song wrote:
> > @@ -1599,6 +1599,16 @@ The following nested keys are defined.
> >   	  pglazyfreed (npn)
> >   		Amount of reclaimed lazyfree pages
> >   
> > +	  swpin_zero
> > +		Number of pages moved into memory with zero content, meaning no
> > +		copy exists in the backend swapfile, allowing swap-in to avoid
> > +		I/O read overhead.
> > +
> > +	  swpout_zero
> > +		Number of pages moved out of memory with zero content, meaning no
> > +		copy is needed in the backend swapfile, allowing swap-out to avoid
> > +		I/O write overhead.
> 
> Hm, can make it a bit clearer that this is a pure optimization and refer 
> to the other counters?
> 
> swpin_zero
> 	Portion of "pswpin" pages for which I/O was optimized out
> 	because the page content was detected to be zero during swapout.

AFAICS the zeropages currently don't show up in pswpin/pswpout, so
these are independent counters, not subsets.

I'm leaning towards Barry's side on the fixes tag. When zswap handled
the same-filled pages, we would count them in zswpin/out. From a user
POV, especially one using zswap, the behavior didn't change, but the
counts giving insight into this (potentially significant) VM activity
disappeared. This is arguably a regression.

> swpout_zero
> 	Portion of "pswout" pages for which I/O was optimized out
> 	because the page content was detected to be zero.

Are we sure we want to commit to the "zero" in the name here? Until
very recently, zswap optimized all same-filled pages. It's possible
somebody might want to bring that back down the line.

In reference to the above, I'd actually prefer putting them back into
zswpin/zswpout. Sure, they're not handled by zswap.c proper, but this
is arguably just an implementation detail; from a user POV this is
still just (a form of) compression in lieu of IO to the swap backend.

IMO there is no need for coming up with a separate category. Just add
them to zswpin/zswpout and remove the CONFIG_ZSWAP guards from them?

