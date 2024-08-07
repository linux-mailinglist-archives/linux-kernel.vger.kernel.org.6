Return-Path: <linux-kernel+bounces-278597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75694B251
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C3D1C21086
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A781509A5;
	Wed,  7 Aug 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="w2C9n7PF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0614D29C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067096; cv=none; b=TM6KU9kMdtEq8KNyWgxGyEyjmVJeJimFIZLozTRqIeqUD67ahFYzxEK7aljczB9JeaHwuQARDH2CMDF8tVDKdk2gyUpay1OoqzaP0Chl9fVh2jg3G9txNe7J9ZaOTuj/L0fzfdUPiyHMgcdP7uoZdmahjc1XPVmDPOU21Hc0Kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067096; c=relaxed/simple;
	bh=u8+YU0xnkjcGaJ9w379iyelLFwGeDj94LfvVMrPVPEI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sRjaZMCsV2CaB7exCU1OlxaxR74pMEsV9N5+PoIx+rpmX9KpUiliIwIemB+Yw5PscSoRUWuRA9bhFCAzcSFkNWPygHgA8AtKcRA8/b1S047i0CpTAZy0kaaQ5V4P+h1NrR59kbDjZf9klAsgRkb/zU+Da4Ncjha0m04MFoOZWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=w2C9n7PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB202C32781;
	Wed,  7 Aug 2024 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723067095;
	bh=u8+YU0xnkjcGaJ9w379iyelLFwGeDj94LfvVMrPVPEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w2C9n7PFnx7zK5Xq2bWhli0FVCL5JC9CGBTq2MWwSTo6BFM0CDjmA0W9MgltygYd0
	 LMrw1YKcpgcWt8gpkPSMHLJKR1IoXZrrDja1AC0aCiN7cRCujdhx+PV/lKiOpnhH0w
	 ipjBpJJyvcuuo/mIhBYTSVOgGLL6+ElAGnRWHqLo=
Date: Wed, 7 Aug 2024 14:44:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Oscar
 Salvador <osalvador@suse.de>, Dan Williams <dan.j.williams@intel.com>,
 James Houghton <jthoughton@google.com>, Matthew Wilcox
 <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, Rik van Riel
 <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, x86@kernel.org, Ingo
 Molnar <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David
 Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Dave Hansen
 <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Message-Id: <20240807144454.15a9668c23d05141ae777696@linux-foundation.org>
In-Reply-To: <ZrPoUgISLqlF-iEQ@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
	<20240807141703.d641001ee14177ccf80a31d8@linux-foundation.org>
	<ZrPoUgISLqlF-iEQ@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 17:34:10 -0400 Peter Xu <peterx@redhat.com> wrote:

> The problem is mprotect() will skip the dax 1G PUD while it shouldn't;
> meanwhile it'll dump some bad PUD in dmesg.  Both of them look like (corner
> case) bugs to me.. where:
> 
>   - skipping the 1G pud means mprotect() will succeed even if the pud won't
>     be updated with the correct permission specified. Logically that can
>     cause e.g. in mprotect(RO) then write the page can cause data corrupt,
>     as the pud page will still be writable.
> 
>   - the bad pud will generate a pr_err() into dmesg, with no limit so far I
>     can see.  So I think it means an userspace can DoS the kernel log if it
>     wants.. simply by creating the PUD and keep mprotect-ing it
> 

I edited this important info into the [0/n] text, thanks.

So current kernels can be made to spew into the kernel logs?  That's
considered serious.  Can unprivileged userspace code do this?


