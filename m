Return-Path: <linux-kernel+bounces-201333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454318FBD1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F72B262AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834F14B095;
	Tue,  4 Jun 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UGIo5DYu"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B202F25
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531975; cv=none; b=Wp6SXnqjg84+PrDOzJH5hpNkr4Lcw7W3lMSFJPnnmBFe75wc/dImBDnLs9S9qRQu1eU+A/Lv4vHTDTYDb7rh5W6NNBoHjA1Ft82dMfhb8/lf5MAQCKD2LB8iBSa3TjOHzr/wVv7DUSHtowx5pET4qO0hjwBFHpVlQqAy/FAViSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531975; c=relaxed/simple;
	bh=6Fi01LgR7TirgKfGfAsXGioZDJ+IMjeyoRzN8ei8nG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRTGDfEaD4aC240zxNTOGG3eNsvLAYDV1Fho/4OjffrF7QCX0+2KSKhHLJDdSUlvEcOC9NDsKufwjCyajM22T7M2Nl8QH5L0ZjYfVSjJ9Ki5CQP6bbwtGmoKiBf19WDUcDpp/tjOzvCjgEQfR/R1+g9S7BUfTC3ium1LKwx9Q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UGIo5DYu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8e7b50e18so877414a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717531972; x=1718136772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPaAJ0jtH4HyBQSxs+rTYBBrfJz43nBGIYL4UfuFVr0=;
        b=UGIo5DYuUw+R4q0cdF1CBc3LF+G1Y0BFu3kc/QYKU4LORzhS9moiTwKciUZ+x1n0+j
         2r1t0tZVXnzk99k0JnAEMnVZ+LGlS75wVqWfUn6O3SC6q04sh9YbEZjukbPu/2HYo8oo
         3AKH/PZowpyxNo5VpvnbQ9Ma83nT5RPpNywGv7vHP0e4ZkSvMq6tE6gY/7XbCxBp2eLE
         miN98vea091dSzAds7xC88oxfhyobHE+RmlOZ6bxX0bYAGY27XyJlW5ihVU5jW6iLYBk
         G9XAIBClCOu5r5jGKIh8drFfeUMPYjmgrPkKrhv9Mbax+dYIPhTtyGigmO8droEGWKZu
         myvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717531972; x=1718136772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPaAJ0jtH4HyBQSxs+rTYBBrfJz43nBGIYL4UfuFVr0=;
        b=QQmXK6oPs+MCbkCDw+JoydrMd3QJRvc/3elb5h8CucHqjCBpcNRYU+SkpGjLlvClLC
         uYPdcWxbzbwjvpOyqmwfts2PHWfpeS737iwer8XscToADRNmoWtwlb9QKqMW1/pWj7lw
         JgeR7/G8BB4+mVJFv6ZjeggSri5kJRaM6eyO8xV6hvwC3jkFmefAtjapF7VW+JuUPUQt
         +EKSUFXi/RdE/4IqTTp5Z7LMRUu2eTseA9fGWgFK/pUd7m5nBKoRUywt/fAkC+WQAjbp
         8zyVzBZzS48MUKOtxBnOliVI9l4J0NU04XjbLpAzqT/VYDhFhTp6CPSPMp7wsql6QUM/
         VwCg==
X-Forwarded-Encrypted: i=1; AJvYcCUGhy7OSXmtYnr3ivOApqLNgRhVaZPLDK2ZUKepubeMJDZPe4MtnnCkqvjyF9g03SF/s0d3YLvGqrRD/u8bcbVg5tr8k4MfAWd3OaDt
X-Gm-Message-State: AOJu0YwpKK23SK+eP6RvHHd/Z9Fuer/aX9paMjPlx+99Jzh9QJuMxyWk
	hsTPihf5YhSQBPq9vmZEYM1pB03ctK9WU4VBKgkrQAQMB9U8Zn/Hfal6Md9CTek=
X-Google-Smtp-Source: AGHT+IFZwZZeQOvP5e77QrYZrErAjCh8kMGCHbtmCyz6Y6ByuoVRY4Tf8uQzpMtkcs3LdVR+s7ty4g==
X-Received: by 2002:a05:6870:1711:b0:24c:4f80:a59b with SMTP id 586e51a60fabf-2512229c384mr611586fac.58.1717531972436;
        Tue, 04 Jun 2024 13:12:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794fd5e68f1sm306946985a.110.2024.06.04.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:12:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEaWZ-003LSw-EE;
	Tue, 04 Jun 2024 17:12:51 -0300
Date: Tue, 4 Jun 2024 17:12:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] arm64/io: add constant-argument check
Message-ID: <20240604201251.GA791043@ziepe.ca>
References: <20240528153717.2439910-1-arnd@kernel.org>
 <20240604155536.GA20674@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604155536.GA20674@willie-the-truck>

On Tue, Jun 04, 2024 at 04:55:37PM +0100, Will Deacon wrote:
> On Tue, May 28, 2024 at 05:37:11PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > In some configurations __const_iowrite32_copy() does not get inlined
> > and gcc runs into the BUILD_BUG():
> > 
> > In file included from <command-line>:
> > In function '__const_memcpy_toio_aligned32',
> >     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
> >     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
> > include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
> >   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
> >   468 |                         prefix ## suffix();                             \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
> >   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> >    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >       |                     ^~~~~~~~~~~~~~~~
> > arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
> >   193 |                 BUILD_BUG();
> >       |                 ^~~~~~~~~
> > 
> > Move the check for constant arguments into the inline function to ensure
> > it is still constant if the compiler decides against inlining it.
> > 
> > Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2:
> >  - fix both 32-bit and 64-bit copies
> >  - remove now-redundant macros
> > ---
> >  arch/arm64/include/asm/io.h | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> I think this is superseded by Mark's diff in reply to v1, right?
> 
> https://lore.kernel.org/r/ZlcODqVXTDh6n0h-@J2N7QTR9R3
>
> If so, Mark, please can you post that as a proper patch so that we can
> get this fixed?

I wouldn't say superseded, but I agree with Mark that we should have
the __always_inline added to the __iowrite64_copy() and
__const_memcpy_toio_aligned64() in addition to the stuff here.

When I originally wrote this I copied the fairly common pattern of
having the builtin_constant_p test inside a macro, but I see now it is
quite common to put that into an inline. Putting it in the inline is
definately much better, so I like Arnd's patch.

Arnd can you just make that addition and repost this?

Thanks,
Jason

