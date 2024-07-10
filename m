Return-Path: <linux-kernel+bounces-247518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A453792D0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF121C21D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930C19007F;
	Wed, 10 Jul 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eaZJQmoa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2kZ2Klff";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eaZJQmoa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2kZ2Klff"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9E190071
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610826; cv=none; b=D6UUanVgOdH6jKhvC0u6kiLlycy5l8wcwUvfr9WXiXBn2AMkSo9nsWZk2JJdo8YGRCoofx8Avw38K9R/Y17rML/Iv5S4p41GRk8LCrptTjydgv+32M7cty+AeBGD7mAb/YW2AeqM5LHdZz7lHSm8cNteXuKV6zazClGvD9A9orA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610826; c=relaxed/simple;
	bh=ypLblwacHibwpwx4iPwovIcUS0fpg/H4vOw5kCEWnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT44cthw+SRcgbgnNaTMG/zQgbEnuWIdQ2VjJZDjdYvdswj/xST+VuT4Aj9ZTsPJ8RpH2kKXdD81rt9cBVmj9tXknCS3p7QDgBc1qdCfmiMtFa34QXlDMu1Isw2jqc88mAeI5gctwl6hBSNFE4ab04QO5NZAJlJyyGgpUeVBxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eaZJQmoa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2kZ2Klff; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eaZJQmoa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2kZ2Klff; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17CB121BBB;
	Wed, 10 Jul 2024 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720610822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzTKuYC2mO+DNXXK5AjiYtvoeM/CmJF2ahQV7yfc6DI=;
	b=eaZJQmoaUrJQTAFr6gk4yuuCqNUjR5ub9wfBTzFMD82pJMVUBIJdtGTpmWhwZ/LVtnnQ/d
	7n9Mh1aAg9Redwt6J6+HKd6FfvTtHR/J2WAx1wAKyb0uJxJxLpwtqXSG8N1sRb34bCrgWO
	ro0EgDfFr7mDXVnuxrq1qqlZZIgCsCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720610822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzTKuYC2mO+DNXXK5AjiYtvoeM/CmJF2ahQV7yfc6DI=;
	b=2kZ2KlffOaL4OSRustxVhKH/x0BRjy7C3fwGxt4Y0fGXEDSmb0K2MLEW9lSZKVWOUTcXI+
	t4ei5Eq/7Qx36gAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eaZJQmoa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2kZ2Klff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720610822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzTKuYC2mO+DNXXK5AjiYtvoeM/CmJF2ahQV7yfc6DI=;
	b=eaZJQmoaUrJQTAFr6gk4yuuCqNUjR5ub9wfBTzFMD82pJMVUBIJdtGTpmWhwZ/LVtnnQ/d
	7n9Mh1aAg9Redwt6J6+HKd6FfvTtHR/J2WAx1wAKyb0uJxJxLpwtqXSG8N1sRb34bCrgWO
	ro0EgDfFr7mDXVnuxrq1qqlZZIgCsCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720610822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzTKuYC2mO+DNXXK5AjiYtvoeM/CmJF2ahQV7yfc6DI=;
	b=2kZ2KlffOaL4OSRustxVhKH/x0BRjy7C3fwGxt4Y0fGXEDSmb0K2MLEW9lSZKVWOUTcXI+
	t4ei5Eq/7Qx36gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1967137D2;
	Wed, 10 Jul 2024 11:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nM6tHwFwjmaxfgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 11:26:57 +0000
Date: Wed, 10 Jul 2024 13:26:54 +0200
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
Message-ID: <Zo5v_hefrYFImqBC@localhost.localdomain>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
 <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
X-Rspamd-Queue-Id: 17CB121BBB
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jul 10, 2024 at 05:52:43AM +0200, David Hildenbrand wrote:
> I understand that. And it would all be easier+more straight forward if we
> wouldn't have that hugetlb CONT-PTE / CONT-PMD stuff in there that works
> similar, but different to "ordinary" cont-pte for thp.
> 
> I'm sure you stumbled over the set_huge_pte_at() on arm64 for example. If
> we, at one point *don't* use these hugetlb functions right now to modify
> hugetlb entries, we might be in trouble.
> 
> That's why I think we should maybe invest our time and effort in having a
> new pagewalker that will just batch such things naturally, and users that
> can operate on that naturally. For example: a hugetlb cont-pte-mapped folio
> will just naturally be reported as a "fully mapped folio", just like a THP
> would be if mapped in a compatible way.
> 
> Yes, this requires more work, but as raised in some patches here, working on
> individual PTEs/PMDs for hugetlb is problematic.
> 
> You have to batch every operation, to essentially teach ordinary code to do
> what the hugetlb_* special code would have done on cont-pte/cont-pmd things.
> 
> 
> (as a side note, cont-pte/cont-pmd should primarily be a hint from arch code
> on how many entries we can batch, like we do in folio_pte_batch(); point is
> that we want to batch also on architectures where we don't have such bits,
> and prepare for architectures that implement various sizes of batching;
> IMHO, having cont-pte/cont-pmd checks in common code is likely the wrong
> approach. Again, folio_pte_batch() is where we tackled the problem
> differently from the THP perspective)

I must say I did not check folio_pte_batch() and I am totally ignorant
of what/how it does things.
I will have a look.

> I have an idea for a better page table walker API that would try batching
> most entries (under one PTL), and walkers can just register for the types
> they want. Hoping I will find some time to at least scetch the user
> interface soon.
> 
> That doesn't mean that this should block your work, but the
> cont-pte/cont/pmd hugetlb stuff is really nasty to handle here, and I don't
> particularly like where this is going.

Ok, let me take a step back then.
Previous versions of that RFC did not handle cont-{pte-pmd} wide in the
open, so let me go back to the drawing board and come up with something
that does not fiddle with cont- stuff in that way.

I might post here a small diff just to see if we are on the same page.

As usual, thanks a lot for your comments David!


-- 
Oscar Salvador
SUSE Labs

