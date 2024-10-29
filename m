Return-Path: <linux-kernel+bounces-387422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C89B5105
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DB1F22D91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F911DD520;
	Tue, 29 Oct 2024 17:33:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4201D2796
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223181; cv=none; b=Hhat0XT4BQrZepZjBGfpaQskS3MF2lUq0wncKE3Qi8vpw+xQBc98XQbjQNKV7CZMFm7VJOatbp48qteH2haFA4Pdqb/Y1JP5ICaXrro/wX9MUytV6vYrPTwQYmE4pjwBReLNEelmk4ajhcjVPUuJuMeUz/QM9zOPwLd3GXHMru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223181; c=relaxed/simple;
	bh=nX2ag5qQfWWNNJQYEWWV/Qn4e5DEGzEtuUzcDUm/J/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l73LRWpmKRj5up6AkrLDskNiEkCSYCVRNnqDpn4cuhFI+rM4QhBpcwuWZFkpWShcfFniLszPR3fCn2T2nxdE0oo0wcbG3SGg+0xf4koZ3gMO1YQuIf5N8ibTH+xqVI4cZbpqFHhuxl4pUJ9EkKX7/ysGBH/ZLTPcTNHCvOzEdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76539C4CECD;
	Tue, 29 Oct 2024 17:32:58 +0000 (UTC)
Date: Tue, 29 Oct 2024 17:32:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <ZyEcSCuxYGylmDCa@arm.com>
References: <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
 <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
 <ZyEL0s_qiyAYURR2@arm.com>
 <a050599e-6d43-4759-b08c-d37c0d28ce0e@lucifer.local>
 <ZyEVHy-767RfFwh_@arm.com>
 <2759d754-9bd7-4bc0-a4a3-42f733fb2596@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2759d754-9bd7-4bc0-a4a3-42f733fb2596@lucifer.local>

On Tue, Oct 29, 2024 at 05:28:49PM +0000, Lorenzo Stoakes wrote:
> On Tue, Oct 29, 2024 at 05:02:23PM +0000, Catalin Marinas wrote:
> > That's what I meant (untested, on top of -next as it has a MAP_HUGETLB
> > check in there). I don't think it's much worse than your proposal,
> > assuming that it works:
> 
> Right sorry misread. Yeah this is better, let me do a quick -v4 then!

Thanks!

> Cheers, sorry pretty tired at this stage, was looking at this all last
> night...

No worries. The way we handle MTE is pretty convoluted. Happy to
simplify it if we find a better way.

-- 
Catalin

