Return-Path: <linux-kernel+bounces-271359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C3944D31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF07EB25FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16461A01CB;
	Thu,  1 Aug 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXiia8eY"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168D13D2B8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519064; cv=none; b=T1vxmMv8B4h7oHArpUPcXR0ssj0CqanToRWH4TYGk6/mD0Y4/KtDccMVrsVNyd/pqVsfvagPcD7QlvBazlPQQbEAw/uor3bmBXkx3ibvfk7qglHxTR4B00dGqyRLV7/KS1JAvIQEPX/zX7LRQej5WLyWYB/+LqShejVfLuQx/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519064; c=relaxed/simple;
	bh=5JQrkiP0uOjwss1rpQy/l3A+rpzTZUsAeWqATieGYNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp3V+uYlW6ooK37HVqJ1aLeQ3kVaEV6My1hI51OQyORr0+z7+Jb2fpo2SVZTA4rLBwFEgZA3omThy0SAeBxlQgFhlcdttIpWR0lb7IIyJ8v6Hc5thDVUWv/Z+IU1gUYqfWGi11jX+VV6RPLTHaJF2Yk7Op2xjLQaM5eh7tNhuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXiia8eY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so5892576a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722519062; x=1723123862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv4iB82yfscVGFR90a765Fg0rBGgnQwJipeiUQwNkUo=;
        b=QXiia8eYmVTg+p2V2TNj/SBZT5e0ZZJvME9woB0gWOymDK7exk9uJ7BiHoN9dicAFR
         T4FBXKEqwgqucRrmyzzepIC4RHPwXtH3370tKymLrA2u+fWA8icyWZosu0I6CGZZgmxy
         aIxZBrogMBroqYsWeOm+QEorixnqqd7VvMb02zY2cQ0XjhELmNT8xXNSjpWcz6IMfdJF
         iAtoqLdnmueQfLvuIQGN3hHSsmH9CvPJdrkeu18O75yjbfQ3p2it81vbQG+4zMdKBsje
         Mpl1QveXK3hmrLvLlllk5Y1QlAVs8dPetzN+yausBnNPgzt5lIrtr2qd/1YPL7vh9cxM
         DGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519062; x=1723123862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv4iB82yfscVGFR90a765Fg0rBGgnQwJipeiUQwNkUo=;
        b=TMtHE/IP8fvENXmReDzBX6hVe2aMPkp1TarNSpMpgdwCjvZBDNzETHWtKl6rP+joxl
         PPlpc2pZWxHJiT/aLzDyfpTBrUKA3j+WLq6InjHszTJBImXgLT1joR3AQCMo6aIB2J/u
         QGSYHMp49tY+bry8vm5PqtgZhoabWYjtNpwZH5u4ZzqZ9t5oMf1tYMfJFif+NUxWkz4m
         vhnjy04I/wmEkreC2PkPT8ap74hnAMmQqlTtYpvXN4cnY9FmvRoJkE68X4uEcrJ1Xyrm
         DjmtxqSwe27Hq2tYl5bTj1Ba5gFJDp2wZA2M+SJ0N4P1x8pa3JNKGwLlL5DcCH67DENs
         4mMA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdCKSWaJO79A48/qcYepAj+fbzgWzMZnnOWhKAdNNVoMocwjSCa/tBMmyOC8mbkhhxmZ4RJdwRs5rpgCnMpCQeFUHJbv10bDOaUYN
X-Gm-Message-State: AOJu0YwFnaslGIPnpUBSErH6MVFXogipznPkiPC5Xe9DRsEfgwedmBpJ
	gwlryNCcasEI2r8mk8HajiMm3Ode47UB0gsXr/ig78Ig8vObFibm
X-Google-Smtp-Source: AGHT+IElO9v+4Isd9ZaN2clcpXml/1imltaATSqt4uv4tE5W6CFLpI3ysrDPJAq4DaCky1y+YsIR6w==
X-Received: by 2002:a50:ee8d:0:b0:5a1:a447:9f9b with SMTP id 4fb4d7f45d1cf-5b7f54136b9mr201616a12.27.1722519061241;
        Thu, 01 Aug 2024 06:31:01 -0700 (PDT)
Received: from f (cst-prg-90-207.cust.vodafone.cz. [46.135.90.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af959990c9sm8749591a12.47.2024.08.01.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:30:59 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:30:49 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Yin, Fengwei" <fengwei.yin@intel.com>, 
	kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec
 -2.9% regression
Message-ID: <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>

On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
> Yes indeed. fork() can be extremely sensitive to each added instruction.
> 
> I even pointed out to Peter why I didn't add the PageHuge check in there
> originally [1].
> 
> "Well, and I didn't want to have runtime-hugetlb checks in
> PageAnonExclusive code called on certainly-not-hugetlb code paths."
> 
> 
> We now have to do a page_folio(page) and then test for hugetlb.
> 
> 	return folio_test_hugetlb(page_folio(page));
> 
> Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 times, so
> maybe at least part of the overhead is gone.
> 

I'll note page_folio expands to a call to _compound_head.

While _compound_head is declared as an inline, it ends up being big
enough that the compiler decides to emit a real function instead and
real func calls are not particularly cheap.

I had a brief look with a profiler myself and for single-threaded usage
the func is quite high up there, while it manages to get out with the
first branch -- that is to say there is definitely performance lost for
having a func call instead of an inlined branch.

The routine is deinlined because of a call to page_fixed_fake_head,
which itself is annotated with always_inline.

This is of course patchable with minor shoveling.

I did not go for it because stress-ng results were too unstable for me
to confidently state win/loss.

But should you want to whack the regression, this is what I would look
into.

