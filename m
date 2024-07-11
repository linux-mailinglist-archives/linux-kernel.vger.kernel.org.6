Return-Path: <linux-kernel+bounces-248575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1F892DF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB001C21F99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C855C5F3;
	Thu, 11 Jul 2024 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BRayn4zu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NnZYUzAL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BRayn4zu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NnZYUzAL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F05477A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673299; cv=none; b=Y/Vg//Kxl90wxQPsfLbllmjo0KMsR6kkfqOoltGnmxCLLP8vaVbHcPULtRD5E1JSpL8MSuIaDd4nu3GFYgzNT3XByropgHbS7SW+Jn5U+YWPG9dGd4g3WoEgLv/uU3FgZV+XEBo5sxJYgp3PsXHxTzyo2yh+sslezebg6x/2els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673299; c=relaxed/simple;
	bh=EC4xO0dF5octm5kAqsmlyr3bscbTK3fCdwZacnJbiVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlH2cIg/l/gFHbRkcIvtlN9tmRzMFh2JgDnfmdV5IwVBj5o60Ir2gqnhAdQ+zn/cWQlhMjMj2O59MUqkS2WrTd7lf2MTgaecSSWhZxxsXubTpOmgkqmDWeSNmwVbc3bLMvLpTgqTNbtplSXTkxmwYfv4uXsqrI5fzDgzgtFoLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BRayn4zu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NnZYUzAL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BRayn4zu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NnZYUzAL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A17C121991;
	Thu, 11 Jul 2024 04:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720673295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtB+qwSkgCiMXy5rm2CLlB2vE/GD+brI0Y88TU3Jjy8=;
	b=BRayn4zutZuEMV5pssSc2lmbq5COjD7G8C1DNFDOm0pP78HcNjgA2TD3M85JFvr2WBi7Gc
	v4tJI2dYPasSGg65avPziWYCZHZTAodLeS5lthsOYZRHGwGAONNL1Yj2p1fG4sYnlNkRt1
	czb/voyRLxfCOua/G/M56nt/h9tauAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720673295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtB+qwSkgCiMXy5rm2CLlB2vE/GD+brI0Y88TU3Jjy8=;
	b=NnZYUzALS+Q1URIrJhQ9FIE6zXoesaCKdZkz0jJMKPtyenVGTcwJpbISAoqgHEO+fMq8pb
	RmE7/CaRgceh9uDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BRayn4zu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NnZYUzAL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720673295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtB+qwSkgCiMXy5rm2CLlB2vE/GD+brI0Y88TU3Jjy8=;
	b=BRayn4zutZuEMV5pssSc2lmbq5COjD7G8C1DNFDOm0pP78HcNjgA2TD3M85JFvr2WBi7Gc
	v4tJI2dYPasSGg65avPziWYCZHZTAodLeS5lthsOYZRHGwGAONNL1Yj2p1fG4sYnlNkRt1
	czb/voyRLxfCOua/G/M56nt/h9tauAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720673295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtB+qwSkgCiMXy5rm2CLlB2vE/GD+brI0Y88TU3Jjy8=;
	b=NnZYUzALS+Q1URIrJhQ9FIE6zXoesaCKdZkz0jJMKPtyenVGTcwJpbISAoqgHEO+fMq8pb
	RmE7/CaRgceh9uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538A7136D6;
	Thu, 11 Jul 2024 04:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +TyWDg5kj2Y7GAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 11 Jul 2024 04:48:14 +0000
Date: Thu, 11 Jul 2024 06:48:12 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <Zo9kDNFljpVzl69Z@localhost.localdomain>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
 <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
 <Zo5v_hefrYFImqBC@localhost.localdomain>
 <0f01c613-9e4f-47b6-af2b-09aa90437d90@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f01c613-9e4f-47b6-af2b-09aa90437d90@redhat.com>
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A17C121991
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Thu, Jul 11, 2024 at 02:15:38AM +0200, David Hildenbrand wrote:
> > > (as a side note, cont-pte/cont-pmd should primarily be a hint from arch code
> > > on how many entries we can batch, like we do in folio_pte_batch(); point is
> > > that we want to batch also on architectures where we don't have such bits,
> > > and prepare for architectures that implement various sizes of batching;
> > > IMHO, having cont-pte/cont-pmd checks in common code is likely the wrong
> > > approach. Again, folio_pte_batch() is where we tackled the problem
> > > differently from the THP perspective)
> > 
> > I must say I did not check folio_pte_batch() and I am totally ignorant
> > of what/how it does things.
> > I will have a look.
> > 
> > > I have an idea for a better page table walker API that would try batching
> > > most entries (under one PTL), and walkers can just register for the types
> > > they want. Hoping I will find some time to at least scetch the user
> > > interface soon.
> > > 
> > > That doesn't mean that this should block your work, but the
> > > cont-pte/cont/pmd hugetlb stuff is really nasty to handle here, and I don't
> > > particularly like where this is going.
> > 
> > Ok, let me take a step back then.
> > Previous versions of that RFC did not handle cont-{pte-pmd} wide in the
> > open, so let me go back to the drawing board and come up with something
> > that does not fiddle with cont- stuff in that way.
> > 
> > I might post here a small diff just to see if we are on the same page.
> > 
> > As usual, thanks a lot for your comments David!
> 
> Feel free to reach out to discuss ways forward. I think we should
> 
> (a) move to the automatic cont-pte setting as done for THPs via
>     set_ptes().
> (b) Batching PTE updates at all relevant places, so we get no change in
>     behavior: cont-pte bit will remain set.
> (c) Likely remove the use of cont-pte bits in hugetlb code for anything
>     that is not a present folio (i.e., where automatic cont-pte bit
>     setting would never set it). Migration entries might require
>     thought (we can easily batch to achieve the same thing, but the
>     behavior of hugetlb likely differs to the generic way of handling
>     migration entries on multiple ptes: reference the folio vs.
>     the respective subpages of the folio).

Uhm, I see, but I am bit confused.
Although related, this seems orthogonal to this series and more like for
a next-thing to do, right?

It is true that this series tries to handle cont-{pmd,pte} in the
pagewalk api for hugetlb vmas, but in order to raise less eye brows I
can come up with a way not to do that for now, so we do not fiddle with
cont-stuff in this series.


Or am I misunderstanding you?


-- 
Oscar Salvador
SUSE Labs

