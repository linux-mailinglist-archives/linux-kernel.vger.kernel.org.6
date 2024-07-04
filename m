Return-Path: <linux-kernel+bounces-240857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839279273BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E03E2887D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564A1A0730;
	Thu,  4 Jul 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zJ+Cdhei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kDOkNGzd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zJ+Cdhei";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kDOkNGzd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81691AB8E6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088018; cv=none; b=Xfr8UoXyjc0r7iozXDuAotLa9FsCMKNrnvVeYaE8z5v/CuzvN4DZ65BsWYwXexvBGcU2CN0ahOmIFwQi+RQ1xVXmFRaRVUd0s/Ym/2qOEVbT1CphiVKf7XVRgxe0kzmt7XuHtLi49L4YZucezBBNLAxyvfzyJkW+9t27B7iFhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088018; c=relaxed/simple;
	bh=avLgwA2xTEOAI1jfe+7fyJvre7FCTfN/1UtL6TmZgBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuPpi/wieFEA20qB6dhqcLcwF+fNzbyO2FS7yXKMCOmGkgsU7/eXCkbaz5MGw/Nf2NhamRjO9zMSy7ozh5vLbhVcKmXOw/iPLlyDHuP89K3hkzW1TNUY0Td2BKAf8yYPXqV1zZ9nOgt7rPgSbKERL4gCX2wNY6/JzKZNIX57JBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zJ+Cdhei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kDOkNGzd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zJ+Cdhei; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kDOkNGzd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B608F1F7B7;
	Thu,  4 Jul 2024 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720088014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhmwWK7X7UiaDm0j4qTVzfPR09c1UYF2XLSHXWFWMZE=;
	b=zJ+Cdheiybyd4svV3GuS3Px9B0wLc2RNzP3uLUGsSjI6U4qEuNq6AmQOHufuRof9Mlwcze
	x9stD/26YHeQkFvE7p8aotsEeykqElVxt9NGballb3H0mVXlJd0xeIrhJg40Vc9H5EFHkk
	5L25rN2y/rrrYiGm/1xLMpcE+yjFQno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720088014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhmwWK7X7UiaDm0j4qTVzfPR09c1UYF2XLSHXWFWMZE=;
	b=kDOkNGzdhG2lnJ6+bdDFPaC1yetA4zrn2y+kTWbx38UinBuGGTJbaRW9qJr8GPO+c03++L
	T/x5SYqTy62hOxBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zJ+Cdhei;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kDOkNGzd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720088014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhmwWK7X7UiaDm0j4qTVzfPR09c1UYF2XLSHXWFWMZE=;
	b=zJ+Cdheiybyd4svV3GuS3Px9B0wLc2RNzP3uLUGsSjI6U4qEuNq6AmQOHufuRof9Mlwcze
	x9stD/26YHeQkFvE7p8aotsEeykqElVxt9NGballb3H0mVXlJd0xeIrhJg40Vc9H5EFHkk
	5L25rN2y/rrrYiGm/1xLMpcE+yjFQno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720088014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhmwWK7X7UiaDm0j4qTVzfPR09c1UYF2XLSHXWFWMZE=;
	b=kDOkNGzdhG2lnJ6+bdDFPaC1yetA4zrn2y+kTWbx38UinBuGGTJbaRW9qJr8GPO+c03++L
	T/x5SYqTy62hOxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A08A21369F;
	Thu,  4 Jul 2024 10:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TcRSIc11hmasYwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 10:13:33 +0000
Date: Thu, 4 Jul 2024 12:13:23 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <ZoZ1w2yDzY_K9Mk0@localhost.localdomain>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
X-Rspamd-Queue-Id: B608F1F7B7
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jul 04, 2024 at 06:30:47AM +0200, Oscar Salvador wrote:
> Hi all,
> 
> During Peter's talk at the LSFMM, it was agreed that one of the things
> that need to be done in order to further integrate hugetlb into mm core,
> is to unify generic and hugetlb pagewalkers.
> I started with this one, which is unifying hugetlb into generic
> pagewalk, instead of having its hugetlb_entry entries.
> Which means that pmd_entry/pte_entry(for cont-pte) entries will also deal with
> hugetlb vmas as well, and so will new pud_entry entries since hugetlb can be
> pud mapped (devm pages as well but we seem not to care about those with
> the exception of hmm code).
> 
> The outcome is this RFC.

Just dropping the git tree, in case someone finds it more suitable:

https://github.com/leberus/linux/ hugetlb-unification-pagewalk 


-- 
Oscar Salvador
SUSE Labs

