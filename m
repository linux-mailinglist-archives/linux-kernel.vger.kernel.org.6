Return-Path: <linux-kernel+bounces-275043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C81947FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72BA28556C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065715C15C;
	Mon,  5 Aug 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNdj7pQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9215C15A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877678; cv=none; b=HLTPelC9tUGeFTyJdYuW6R/0wdzW8DS6wG6cQut3JeICeyJqiM/1FFyHqqwC0KA29qipaW2bJInF0/ipzOXyxb2+xmVhYHsDjvZQSO6lUeqReakYA9U/vuQHNhm6Xr47tXkVc+Ps8ZzLFm+4YfnnWt+62VB9SwRrxWu5XKAC2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877678; c=relaxed/simple;
	bh=8oDLsrYMWaJslusr/zMMcppEbGxigROfZnvgJbcs1kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXXk4awA51B2I9HYDndEPIFY6Q2vM4yznTIR/ZUcRNA+D0pnOuJiI5PAocoeFh3U+53HoNg4zKik+CHTAui1XjS4e6ICu+aEnkJ0vi7ZrpoVCZyrU4ws1tbIFrh9H8H99Q3bnpGb7y9Rxof0WBE8MiGGB0LftDYp+aCwTHc/dgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNdj7pQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C020C4AF0C;
	Mon,  5 Aug 2024 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722877677;
	bh=8oDLsrYMWaJslusr/zMMcppEbGxigROfZnvgJbcs1kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNdj7pQZ2QpTGcBfZko56BcFj9SNEjepo2DM89QXZZPk8LeY+e3Lu6chB4DgunfJs
	 LfdIJCtGaExWxr4SyQga+c5JqikMuVVVU5+Ig3e7WMN6WuAOxXdEKMQnAoxtpMV0NS
	 lIL3wuCiLzjbJQz0EVdr/YlJPdfxmyRdgr/Ofg7883YYqAbgaGCCYNjvBvWcOYm/Fq
	 +/9J4R695vVsaa7923qaSKdfiqvdYd4iHTRNO4/rNMa4rNpWRWs9QFkLwcqxGd0o1Q
	 X4dy7c/oPVmBJoO+KOjufTnnjQsQr++PBjikSlJcj4jvuKLcwlZYwasTyXi1jqk0eC
	 R+3h4XlUh7kXQ==
Date: Mon, 5 Aug 2024 20:05:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <ZrEGb6JlKoA93Ebu@kernel.org>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
 <ZrCjYqdmNfn3di-o@kernel.org>
 <20240805153720.myjqd6ur65x5ucsu@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805153720.myjqd6ur65x5ucsu@master>

On Mon, Aug 05, 2024 at 03:37:20PM +0000, Wei Yang wrote:
> On Mon, Aug 05, 2024 at 01:03:14PM +0300, Mike Rapoport wrote:
> >On Fri, Aug 02, 2024 at 01:09:19AM +0000, Wei Yang wrote:
> >> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> >> alloc") introduce the usage of virt_to_phys(), which is not defined in
> >> memblock tests.
> >> 
> >> Define it in mm.h to fix the build error.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> 
> >> ---
> >> v3: use static inline as phys_to_virt
> >> v2: move definition to mm.h
> >> ---
> >>  tools/include/linux/mm.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
> >> index cad4f2927983..c9e915914add 100644
> >> --- a/tools/include/linux/mm.h
> >> +++ b/tools/include/linux/mm.h
> >> @@ -25,6 +25,12 @@ static inline void *phys_to_virt(unsigned long address)
> >>  	return __va(address);
> >>  }
> >>  
> >> +#define virt_to_phys virt_to_phys
> >> +static inline phys_addr_t virt_to_phys(volatile void *address)
> >
> >Why volatilte?
> >
> 
> There are two definitions of virt_to_phys:
> 
>   include/asm-generic/io.h
>   arch/x86/include/asm/io.h
> 
> both has volatile.
> 
> I just copy from it. But I don't 100% understand it.

Let's keep it inline with the kernel definitions
 
> >> +{
> >> +	return (unsigned long)address;
> >
> >This should be phys_addr_t, look at its definition in tools/include/linux/types.h
> >
> 
> You are right. Will fix it.
> 
> >> +}
> >> +
> >>  void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
> >>  
> >>  static inline void totalram_pages_inc(void)
> >> -- 
> >> 2.34.1
> >> 
> >
> >-- 
> >Sincerely yours,
> >Mike.
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

