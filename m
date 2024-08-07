Return-Path: <linux-kernel+bounces-278568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D794B1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3A8283C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4F149C6C;
	Wed,  7 Aug 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0TFKINsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6F145333
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065425; cv=none; b=ZFqx7LRZY2I3lJ6gAQxMOz8DTqdqLx/T4lqwLh8yM2bwEytKyKf2ONUHGZZjFVOX7dP71AmcYMXsEUXfSPFtqehcwveDpsZfb4tdWKA20NSFVzuvW7gbVLs9KrB2XTulPKMLvA5WDnsveRof17V6agfRrj1mQW8jOv1+ZUX0X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065425; c=relaxed/simple;
	bh=+gUpbSegd1rP99qLghMnsgBErS9zrHF45NWkbO3C0pc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BvkyPddqCLri2UXleL64qDJqijDfYceVw5QAmE7Kt7Zfm6B1y3Okde3+ahDgFpQ2sB0w5r2OvmTMcuaxQAeV18xh00jMfUXCvDqWhcm0Y6J0wCTiLqs6Wt9k5/W5Hm3tTfL7Iomjawn4eDdAs9SH81SSWI5S6WFeNjVfaUqerSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0TFKINsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CC7C32781;
	Wed,  7 Aug 2024 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723065425;
	bh=+gUpbSegd1rP99qLghMnsgBErS9zrHF45NWkbO3C0pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0TFKINspgpAlLabxd/er+hxRd2vgR0Zs5pOwaZjJoMxyXSkODwI2oFe2cXYsgU71q
	 Run8TO4CZCIZS1bbMHvyICsWBdEqyNihC5Nqewyg+REZ3YSGiX6Jk1u9Z9eJt6Ocsv
	 Ud42JWI0sqQqmHgCa6cvnF/vmd5PDgkW2tmTDDQA=
Date: Wed, 7 Aug 2024 14:17:03 -0700
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
Message-Id: <20240807141703.d641001ee14177ccf80a31d8@linux-foundation.org>
In-Reply-To: <20240807194812.819412-1-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 15:48:04 -0400 Peter Xu <peterx@redhat.com> wrote:

> 
> Dax supports pud pages for a while, but mprotect on puds was missing since
> the start.  This series tries to fix that by providing pud handling in
> mprotect().  The goal is to add more types of pud mappings like hugetlb or
> pfnmaps.  This series paves way for it by fixing known pud entries.
> 
> Considering nobody reported this until when I looked at those other types
> of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
> and this may not need to be backported.  I would guess whoever cares about
> mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
> new kernels would be fine, but I'm open to suggestions.

Yes, I'm not sure this is a "fix" at all.  We're implementing something
which previously wasn't there.  Perhaps the entire series should be
called "mm: implement mprotect() for DAX PUDs"?



