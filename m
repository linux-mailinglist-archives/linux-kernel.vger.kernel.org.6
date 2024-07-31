Return-Path: <linux-kernel+bounces-269784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C449436D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D941F27577
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7324AEDA;
	Wed, 31 Jul 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmNw9rXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D14084E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456196; cv=none; b=I91HBySVD39diGI9LNaEHLOfhxfB1EpoCFRhVN4uhAmRwnz7bTD8oTe0Rn7ZMy+NcZnLiaS36f/MUhsaapsaXtmC28qy5fpNX40nObublR0Pj8IR4UzAj1VXXI9zIslHIJzHddT1PRgfSja21FpRvoZa3+tS2P1M1B+O4BWD0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456196; c=relaxed/simple;
	bh=XmMVpdtq1CvBFB7F50MXSgiYhS1qClRnuBs0Pb8wTqg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XMBpLHz3cS63dF0gtSyvCkx54RZaa+RQm0fHLE4lOE1mNcrBWxG4q30vJRCWzg3f9r/YC3+CobVewgwAHtpvk+NOKEeYArhmltX/ryysWMG9U8Lj8v63qoJLWdzVHT5ztYZcyGRv9z47dOjC9y+3ER23SpqMTjg6lGlS/tU4ReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmNw9rXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8CC116B1;
	Wed, 31 Jul 2024 20:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722456196;
	bh=XmMVpdtq1CvBFB7F50MXSgiYhS1qClRnuBs0Pb8wTqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmNw9rXg6115TDx2JZwy10APnP9bhuuiZcVP+/0Gbi9TVzUsqK6hjytv5tYZLdprG
	 WFxNDEfKz6+7E20zW+IF6s9wfOsIgNp11RUPxuenETsHvxdT7UybvcucOXnotvMs9r
	 0NgemfkUMb/OY6rUsMF01SQeNQC+h/Zbeo5g0Cm4=
Date: Wed, 31 Jul 2024 13:03:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@redhat.com>, Donet Tom <donettom@linux.ibm.com>, Matthew Wilcox
 <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
 <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-Id: <20240731130315.7f1f22d006fb19686104ee54@linux-foundation.org>
In-Reply-To: <ZqpUJnhi5l38ijwj@localhost.localdomain>
References: <20240729091018.2152-1-osalvador@suse.de>
	<20240729091018.2152-7-osalvador@suse.de>
	<8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
	<ZqpTaKHdrYt61HYy@localhost.localdomain>
	<ZqpUJnhi5l38ijwj@localhost.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 17:11:34 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> > git grep hugetlb_get_unmapped_area
> 
> Heh, of course I saw what is wrong after pressing intro.
> Ok, with the entire series applied you should not see this problem as
> hugetlb_get_unmapped_area gets totally wiped out, but checking out only
> this commit indeed throws an error.
> 
> I will see how I can reshufle this.

I dropped the v2 series, so reshuffle away.

