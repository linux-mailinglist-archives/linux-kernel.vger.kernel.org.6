Return-Path: <linux-kernel+bounces-244029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6250F929E29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372562851CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAB33080;
	Mon,  8 Jul 2024 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWWc+BSU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M0y01MZQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWWc+BSU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M0y01MZQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89A2F2E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426716; cv=none; b=IISXWR5S/04kNyi37+6vdpPn2WtcGY9y3Lxqb+s1mVZiq3AlYl9hcwK0iWTdUTnSIcQUQl8Wp4TlFKOyBMvHVntbGhDxmDwgXwaVKQxH0sGbRdlfbBQuysr/fO/gPczWUrTvjRK+dWpOg8QfKEkqe9qVh6Z0xC+fTQJxmKZYPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426716; c=relaxed/simple;
	bh=IqD55gxmpoZeRJ16jjbR4Rvt6wRVikPNir0sjdkhWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f475s3q5KHwzJI+T1V59eZXLOnWblN+MA0s0E3Z2yQBain5lKw6UW/mjGGtCNgvzrXpv3dYws+qZ35UtqxIIuQ73PUN95Fd4CrWfuwgeo6K7k5RKlAOpSBEe8PP+vB48XD7+L9X0C65QZmPzQw/7/BxZ7DkyKIXMShXzIsxYGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWWc+BSU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M0y01MZQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWWc+BSU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M0y01MZQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7900F1FC04;
	Mon,  8 Jul 2024 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720426713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ihnjih6wKrKAooD4HKYfrrl0oRcgj0cWYHWi7AhdIQ=;
	b=hWWc+BSUSy3QLdZqku9vup8XAhaKyrq0QMyVJ/aXXdJTRNQJVzrbiz900jE2njtDD85W8E
	tXMYC9sFK8F0FNihzcdeu472TVMx0yXqKc9AvPrffhU/U6+Qvp/Gp5iVFK054DybTVxK6G
	BMmyTiZvYZ+/qa7N4XYFL3nM63/1mTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720426713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ihnjih6wKrKAooD4HKYfrrl0oRcgj0cWYHWi7AhdIQ=;
	b=M0y01MZQbMM3pZJwZ6GHdoxAuInPYUXACb13d8Z6m1MZ9PuyKJSrIu6YO/zzVWD4eiic6p
	456Rm67bzI5m+RDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720426713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ihnjih6wKrKAooD4HKYfrrl0oRcgj0cWYHWi7AhdIQ=;
	b=hWWc+BSUSy3QLdZqku9vup8XAhaKyrq0QMyVJ/aXXdJTRNQJVzrbiz900jE2njtDD85W8E
	tXMYC9sFK8F0FNihzcdeu472TVMx0yXqKc9AvPrffhU/U6+Qvp/Gp5iVFK054DybTVxK6G
	BMmyTiZvYZ+/qa7N4XYFL3nM63/1mTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720426713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ihnjih6wKrKAooD4HKYfrrl0oRcgj0cWYHWi7AhdIQ=;
	b=M0y01MZQbMM3pZJwZ6GHdoxAuInPYUXACb13d8Z6m1MZ9PuyKJSrIu6YO/zzVWD4eiic6p
	456Rm67bzI5m+RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59EFA13A7F;
	Mon,  8 Jul 2024 08:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Et83Edigi2aeHgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 08 Jul 2024 08:18:32 +0000
Date: Mon, 8 Jul 2024 10:18:30 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <Zoug1swoTOqNUPJo@localhost.localdomain>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Thu, Jul 04, 2024 at 05:23:30PM +0200, David Hildenbrand wrote:
> My thinking was if "remove hugetlb_entry" cannot wait for "remove
> page_walk", because we found a reasonable way to do it better and convert
> the individual users. Maybe it can't.
> 
> I've not given up hope that we can end up with something better and clearer
> than the current page_walk API :)

Hi David,

I agree that the current page_walk might be a bit convoluted, and that the
indirect functions approach is a bit of a hassle.
Having said that, let me clarify something.

Although this patchset touches the page_walk API wrt. getting rid of
hugetlb special casing all over the place, my goal was not as focused on
the page_walk as it was on the hugetlb code to gain hability to be
interpreted on PUD/PMD level.

One of the things, among other things, that helped in creating this
mess/duplication we have wrt. hugetlb code vs mm core is that hugetlb
__always__ operates on ptes, which means that we cannot rely on the mm
core to do the right thing, and we need a bunch of hugetlb-pte functions
that knows about their thing, so we lean on that.

IMHO, that was a mistake to start with, but I was not around when it was
introduced and maybe there were good reasons to deal with that the way
it is done.
But, the thing is that my ultimate goal, is for hugetlb code to be able
to deal with PUD/PMD (pte and cont-pte is already dealt with) just like
mm core does for THP (PUD is not supported by THP, but you get me), and
that is not that difficult to do, as this patchset tries to prove.

Of course, for hugetlb to gain the hability to operate on PUD/PMD, this
means we need to add a fairly amount of code. e.g: for operating
hugepages on PUD level, code for markers on PUD/PMD level for
uffd/poison stuff (only dealt
on pmd/pte atm AFAIK), swap functions for PUD (is_swap_pud for PUD), etc.
Basically, almost all we did for PMD-* stuff we need it for PUD as well,
and that will be around when THP gains support for PUD if it ever does
(I guess that in a few years if memory capacity keeps increasing).

E.g: pud_to_swp_entry to detect that a swp entry is hwpoison with
     is_hwpoison_entry

Yes, it is a hassle to have more code around, but IMO, this new code
will help us in 1) move away from __always__ operate on ptes 2) ease
integrate hugetlb code into mm core.

I will keep working on this patchset not because of pagewalk savings,
but because I think it will help us in have hugetlb more mm-core ready,
since the current pagewalk has to test that a hugetlb page can be
properly read on PUD/PMD/PTE level no matter what: uffd for hugetlb on PUD/PMD,
hwpoison entries for swp on PUD/PMD, pud invalidating, etc.

If that gets accomplished, I think that a fair amount of code that lives
in hugetlb.c can be deleted/converted as less special casing will be needed.

I might be wrong and maybe I will hit a brick wall, but hopefully not.



-- 
Oscar Salvador
SUSE Labs

