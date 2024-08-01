Return-Path: <linux-kernel+bounces-270679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D7944395
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3571C21C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022FA16DC1A;
	Thu,  1 Aug 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTCPHZH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F115749F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492677; cv=none; b=k4sY8ToEjNgyyTBe26dnz+gSm3+PBuYd895JHMURUN2LJhr5sTUhnxHMIfuDCo92GT8Y/75aZZHvl/eQ1+yOeryk2Xni/pe2Ew9hzLwkOCAlEB/ME3kMvS8lEnO0svf/EZv22gxcNN1NpYRIUgQAO2A/OVrTVi68TPcdbKlfU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492677; c=relaxed/simple;
	bh=F7glOAsYhDlHdSJ8EVqbQdYGQGstaUZBiVXnAKmsuNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb8/jRxAxnNXDi7Vh2qZIZznwBjI+0tkCk/lHWnimQnNJLEzaoifiQUn9q6a75eDgBI8lExaF65TJEwSUZarjvEQvj4NFLcj5XELCJu1btYRAw3KSIHHoFWBzQi5nisxjgk24dcP6PCuANH5cFimnYoRfWGWncj6FAkmtl3XROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTCPHZH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8639EC4AF0D;
	Thu,  1 Aug 2024 06:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492676;
	bh=F7glOAsYhDlHdSJ8EVqbQdYGQGstaUZBiVXnAKmsuNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTCPHZH4rICXi7konJET3SbLcbfe+zM9cWf/0mYWAZnp6Oc+wpCCVb8+xBTHIWrw5
	 jTBrEg9BlyM4E6XsyMJ7SaV2OD/B7WUqPJbko03PN6PywaI6zrLSfJyf40zbcca+qX
	 QdudLa1RKt/atOgd2WqR7W75r2MI+nABCn+xXP56R27yo8RX7JPySyy+eKTgjq3BIo
	 EjJaliUHBm/WFmfzbVbeE8qhKSCTLZTBCQ4Gj01OadVBnnqlYtnv0SEHUppaIH9XtG
	 MgfeU+aHVfejs66AQDaGCDj+QQ3aJgJ3cl8ZlDuHyPi5PzJW1P1XRJ6GRWCetxu30V
	 Xy5YYTtFdgJFQ==
Date: Thu, 1 Aug 2024 09:09:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <ZqsmisgECjaCt92Z@kernel.org>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
 <Zqcqky8XdiQy3mO-@kernel.org>
 <20240801000739.lrgmokbbgvikrlkw@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801000739.lrgmokbbgvikrlkw@master>

On Thu, Aug 01, 2024 at 12:07:39AM +0000, Wei Yang wrote:
> On Mon, Jul 29, 2024 at 08:37:23AM +0300, Mike Rapoport wrote:
> >On Mon, Jul 29, 2024 at 01:47:21AM +0000, Wei Yang wrote:
> >> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> >> alloc") introduce the usage of virt_to_phys(), which is not defined in
> >> memblock tests.
> >> 
> >> Define it in mm.h to fix the build error.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> 
> >> ---
> >> v2: move definition to mm.h
> >> ---
> >>  tools/include/linux/mm.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
> >> index cad4f2927983..9db45c5d00fc 100644
> >> --- a/tools/include/linux/mm.h
> >> +++ b/tools/include/linux/mm.h
> >> @@ -20,6 +20,8 @@
> >>  #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
> >>  
> >>  #define phys_to_virt phys_to_virt
> >> +#define virt_to_phys(p) ((unsigned long)p)
> >> +
> >
> >Please don't break #define of phys_to_virt from the static inline
> >implementation.
> >
> 
> I don't touch the definition of phys_to_virt, so you are willing me to adjust
> it?
> 
> The macro here will be expanded to code at preprocessing stage. I don't get
> how static inline would help here. Do I miss something?

static inline allows type checking of the parameters and #define with the
same name as of the static inline allows catching other defines with the
same name.

So it's common practice to use this combination, line phys_to_virt does.
 
> >And please make virt_to_phys a static inline similarly to phys_to_virt.
> >
> >>  static inline void *phys_to_virt(unsigned long address)
> >>  {
> >>  	return __va(address);
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

