Return-Path: <linux-kernel+bounces-548520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A83A5460A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D3C3ACC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41652080F1;
	Thu,  6 Mar 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="utGPIsfH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bSiUM66c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="utGPIsfH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bSiUM66c"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF4146580
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252540; cv=none; b=BKu6Hgv/utPdjS8aatv+PZti0UnRK/qM+BFnOkpdkrBGJgjLTEA4NmFZ9YvF8p9VvmOXIK6eVh+mGrAE0ixitZDXFA+NGrSw7CVvXUv07TQ7oMNA6O7SctHG53p71o7XWq/NcKfXM8xSmfIVyw/oCA6b74HQymYh1BTsrJRNag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252540; c=relaxed/simple;
	bh=b5NFFgzhjvo3t8ojywPf7/M5/G+jm4uPKOgFjCMtu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8rLXT6kwoqrPM8HoI05Wzm4fVtLHBFEn9yvFMgb2psMEWth3ETPbIk0d4og7Bt9y14KPeEfQVOme7rMBWwqg3tyusyI3lEws0fM5kO3MOrVdbKRiUsbFvmMUIvkxBNpHu4Qu4VJMlIWtbcA7iq2GHUQwJ4WcXugtmCciMd+GnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=utGPIsfH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bSiUM66c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=utGPIsfH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bSiUM66c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB28B211BA;
	Thu,  6 Mar 2025 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741252536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BArABqxQWjf53Ufa+sY0G4LVWnCgkOwNaWpIsfl+qiU=;
	b=utGPIsfH8r+y/3qe/JjVe4c2zPQoEQ0mg69wcA6yWmaAhZ6AVdJ/t/DlRq2j+sbqLGIygU
	LSdjAeQzqID1E9HMvjWsEHUjHp6mg4n0UWlIU6V/I+TVcqMVqI67UjE6nGakXkNQNINZsI
	CFWjTfLhL0Klyf6vhrwq0WzuV9ttizw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741252536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BArABqxQWjf53Ufa+sY0G4LVWnCgkOwNaWpIsfl+qiU=;
	b=bSiUM66chjQG/c55yjwRC4UQJyHu7bqTfnCORRyF1oUOuM74I2pSTOOvFDVBsULZ60hkJt
	OJX+QM8LZp/LvXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741252536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BArABqxQWjf53Ufa+sY0G4LVWnCgkOwNaWpIsfl+qiU=;
	b=utGPIsfH8r+y/3qe/JjVe4c2zPQoEQ0mg69wcA6yWmaAhZ6AVdJ/t/DlRq2j+sbqLGIygU
	LSdjAeQzqID1E9HMvjWsEHUjHp6mg4n0UWlIU6V/I+TVcqMVqI67UjE6nGakXkNQNINZsI
	CFWjTfLhL0Klyf6vhrwq0WzuV9ttizw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741252536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BArABqxQWjf53Ufa+sY0G4LVWnCgkOwNaWpIsfl+qiU=;
	b=bSiUM66chjQG/c55yjwRC4UQJyHu7bqTfnCORRyF1oUOuM74I2pSTOOvFDVBsULZ60hkJt
	OJX+QM8LZp/LvXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48C4E13A61;
	Thu,  6 Mar 2025 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Na0ID7hnyWcmEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 06 Mar 2025 09:15:36 +0000
Date: Thu, 6 Mar 2025 10:15:34 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: update nr_huge_pages and
 surplus_huge_pages together
Message-ID: <Z8lntpQLn9RQMq0G@localhost.localdomain>
References: <20250305035409.2391344-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305035409.2391344-1-liushixin2@huawei.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 11:54:09AM +0800, Liu Shixin wrote:
> In alloc_surplus_hugetlb_folio(), we increase nr_huge_pages and
> surplus_huge_pages separately. In the middle window, if we set
> nr_hugepages to smaller and satisfy count < persistent_huge_pages(h),
> the surplus_huge_pages will be increased by adjust_pool_surplus().
> 
> After adding delay in the middle window, we can reproduce the problem
> easily by following step:
> 
>  1. echo 3 > /proc/sys/vm/nr_overcommit_hugepages
>  2. mmap two hugepages. When nr_huge_pages=2 and surplus_huge_pages=1,
>     goto step 3.
>  3. echo 0 > /proc/sys/vm/nr_huge_pages
> 
> Finally, nr_huge_pages is less than surplus_huge_pages.
> 
> To fix the problem, call only_alloc_fresh_hugetlb_folio() instead and
> move down __prep_account_new_huge_page() into the hugetlb_lock.
> 
> Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

