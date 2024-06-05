Return-Path: <linux-kernel+bounces-202443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFF8FCCAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85654B216C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293A1BF91A;
	Wed,  5 Jun 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O3lts7qZ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9311BF90D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588620; cv=none; b=DAaOqCnhzlnLz3Am+STt+f9cx1H57BgRIzd4IFYxqArNxoENXprpl48tJdzxh6++W6/aSmVfCN+st/yEGRBI91C0oQAt/rKcQdvkWrSKjYWdwNIclWur2KjEHY4I36kGiKV/uesBCx+uLkoThqJZWkS1g6SAvvhcK+U09L2WZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588620; c=relaxed/simple;
	bh=UbH1/7grnRdpXvuxHfEUVkrSJnWawHkx/2SBGGKAPgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5RC/RwXNLorwHCY6svOtf5I76s+tT7A0F9dawJhiLetI9YxSeJ9mi+61NRg/Yra4fRD6CTU2LrN8UO59Xcf39pHDVdgtvm3ti/dlgYmRZ9xOkoMdpCnV2hreqEQC5aUGz1m/0cQTxuSHH+UFfbJh4BHW+SUl1SCois+o2SxiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O3lts7qZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79523244ccfso64600585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717588617; x=1718193417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17rQdjGRIN2CSga/YFCaGswU6lwvjB6GqByaiI2V+ko=;
        b=O3lts7qZpx3A1CVGBB5Fx8C3vLToLcJWJxJfxzYvpZO3S8CFQGExq2QEFn01+5qd/w
         l/+j9XlRduaikM/uWlNxR+tdvTZP1ZqLyT/+IWrZiGk1gUXAnP1KWcd0nSpPtxozFhj9
         ruvo9+DC39no/82lSzhiHV4AGGQYWrje4FQHzJyG0Jpoq/BFvD5Rtn6BksZEtGE6yS34
         CLFoELN+uHBkym7mVAnxYjCbfucy4THRwYN7yCoGeY9cvBOJL5jm+tSSkZ85ofDnK1Ep
         yBMh05907+3btuKX60kiTRZfMnzjLleKeJ00LvDI9E5GHrnY3h/Z6VpIIaOhb3rApa+1
         EG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588617; x=1718193417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17rQdjGRIN2CSga/YFCaGswU6lwvjB6GqByaiI2V+ko=;
        b=HYLpxrsHQRsjzwqi3KgTap4+9usynw1MErbJaETcCKDegW22+2U28i4JW6G3f9dHCL
         Sby4V7vMESHoC8Qb8ljyrMaDOWxOvOoQCDp/u8oob9IaswoU/xDtF3XBFoBU9X8KimZ0
         DHmZuFz7aldCqJboKaxTey8fOCkeQcLRVpRvjErKzH/CVDOygq99YKfmZBhHfc8pwJGa
         ISthGK4nf0Dya4AD0wpb7kceUZZdyOJRm2TdelO8j/WoE+f68Q8bU68zChNnqs0OsI/w
         nk4ns5GZbdOF/hOi00DobR3Ez6OPiNsPA3b+lJ76P3pEvPROltueIt3P43JbELye+AOG
         YBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUWhMNTimwNwBwL0dCwEz/p0eL9hHyVZScIYT8ILzCTsVe5Yvrb0i2Y6zHGVRMrJa2/+GfVDBCoOQULTl+u+dJDHjSDVIhNN0bWWnyR
X-Gm-Message-State: AOJu0Yw7wbCxT3TgkdzRT5xe4Nn5DtMI+2Y925i1H9dqEkjZ++MKwwuo
	+8qITv/0yM0DPvh2/IJWhCn0+zHdOjiDuP7CCRCdaQf1a+RodEL2w16dVmgsjxU=
X-Google-Smtp-Source: AGHT+IH87Vgxi0u/6B6nOPz3Js4whNZ+PxPB9EPNZ3t7mrmfAT1RKqbTJL+X2xFL1FK3wwFqMewlsQ==
X-Received: by 2002:a05:620a:1362:b0:790:efef:af55 with SMTP id af79cd13be357-79522fa4bbbmr417688985a.3.1717588617261;
        Wed, 05 Jun 2024 04:56:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7952b8e99d4sm12315185a.72.2024.06.05.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:56:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEpGC-006ZOM-6l;
	Wed, 05 Jun 2024 08:56:56 -0300
Date: Wed, 5 Jun 2024 08:56:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] arm64/io: add constant-argument check
Message-ID: <20240605115656.GC791043@ziepe.ca>
References: <20240604210006.668912-1-arnd@kernel.org>
 <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3>

On Wed, Jun 05, 2024 at 10:15:38AM +0100, Mark Rutland wrote:
> On Tue, Jun 04, 2024 at 10:59:57PM +0200, Arnd Bergmann wrote:
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
> > it is still constant if the compiler decides against inlining it, and
> > mark them as __always_inline to override the logic that sometimes leads
> > to the compiler not producing the simplified output.
> > 
> > Note that either the __always_inline annotation or the check for a
> > constant value are sufficient here, but combining the two looks cleaner
> > as it also avoids the macro. With clang-8 and older, the macro was still
> > needed, but all versions of gcc and clang can reliably perform constant
> > folding here.
> > 
> > Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I have a trivial nit below, but either way this looks good to me, so
> regardless of that:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Still codegens what I expect on clang-17 at least, agree with Mark's
note

Thanks,
Jason

