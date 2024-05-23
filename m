Return-Path: <linux-kernel+bounces-186935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E577F8CCAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C042830BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401513A878;
	Thu, 23 May 2024 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YcGnkarf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8seKvAx3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xo8J9aYV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nN513p3S"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83927EF;
	Thu, 23 May 2024 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433720; cv=none; b=Ahyg6PsdmKOYu9XLL9G68SsgposTnjZ8tLfI6LM46VpPGTvE7nRcK4mmZSsa9MUD6m6RNhZTpfoAK0wnwhOkE77sm2fC5KthMfRC04jcM16+gs3AdVWFSdbGdILD0jRziKxU0iFF8050tc9bkbuDAjeT+qrkgXChj71nCXNDpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433720; c=relaxed/simple;
	bh=395EtBMeKvhaqcyJa2SJSdImD3drPDcuSCs8TeGMsS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWw4OAO+QuT/BXvg6EFQ2B5IuDgk6MDCwhtErIN34KZ03sFO1TFblbr6vbzu5GkctgZygAuxMYSHZC5VImRBjqFxmr0/uoMZzhfpAam9MctXyIu8Cr13dNGESTItSZC5ndXfAugsqvktjsQTYB9v1BTl7r/119fIlq3iOb7o/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YcGnkarf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8seKvAx3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xo8J9aYV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nN513p3S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDE2C1FDCE;
	Thu, 23 May 2024 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716433716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0N0S6r8IeovFdxww9RN8WulP8rYDdid/w2zv2NcHlY=;
	b=YcGnkarfP7rAwvhiOINxsKMbHpbeoO5PLcP2+nhBTfDiy176wv+VbDX11CO6faQrg2kZ6B
	xmEWJFNLm4TqJ8NB5pQi4TQ4HlbCqxki0PZnYqRfn/1PGf2sp5uIgzPHi8DO5YYkntL13s
	/PoGuujuJZycBq23rlOpbta8wOEdouU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716433716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0N0S6r8IeovFdxww9RN8WulP8rYDdid/w2zv2NcHlY=;
	b=8seKvAx34N9zbAbSXvZmX90nlXbI+J0lTECHG1ywHskkNPLTJeU0OCKKXM714nxIgCjOPv
	cAqnqxCS4rF9SjAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xo8J9aYV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nN513p3S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716433715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0N0S6r8IeovFdxww9RN8WulP8rYDdid/w2zv2NcHlY=;
	b=xo8J9aYV2HvLfM1cXOQxHP9mc8VPZLhgd60GR2simJH6IFQTHl2BisCBQ80uUL+up4OfDt
	IKTrH+tCZw22ujA2Fz5M+WpPbZ4dxsWOe2MMd5DqaEBJJMod50MovReFjtWnyfWYgNWUhU
	Kp8Uhrbt/BtvEopATR1oY6dRnd4z+VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716433715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0N0S6r8IeovFdxww9RN8WulP8rYDdid/w2zv2NcHlY=;
	b=nN513p3S5maKAmTkBL5gb+fzrqAqgWdB+u8EK73ofQkChx9IgR8Rg6R7AxhnOx1vhmHiHn
	oIj72gUreXnNf5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 948A813A6B;
	Thu, 23 May 2024 03:08:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4UfITKzTmZrEAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 23 May 2024 03:08:34 +0000
Date: Thu, 23 May 2024 05:08:29 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <Zk6zLRimo6Q6ZrwM@localhost.localdomain>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <Zj51rEwZeSK4Vr1G@x1n>
 <ZkPJCc5N1Eotpa4u@localhost.localdomain>
 <ZkPY4CSnZWZnxjTa@x1n>
 <ZkSMv31Cwx080no7@localhost.localdomain>
 <Zk5noUEYI4lknyJy@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk5noUEYI4lknyJy@x1n>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,kernel.org,alien8.de,csgroup.eu,linux.intel.com,redhat.com,zytor.com,gmx.de,hansenpartnership.com,nvidia.com,huawei.com,infradead.org,ellerman.id.au,linux.dev,linux.ibm.com,gmail.com,linutronix.de,vger.kernel.org,kvack.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLeqp5gkuwhygrjzi4zhnnr4iu)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EDE2C1FDCE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Wed, May 22, 2024 at 05:46:09PM -0400, Peter Xu wrote:
> > Now, ProcessB still has the page mapped, so upon re-accessing it,
> > it will trigger a new MCE event. memory-failure code will see that this
> 
> The question is why accessing that hwpoison entry from ProcB triggers an
> MCE.  Logically that's a swap entry and it should generate a page fault
> rather than MCE.  Then in the pgfault hanlder we don't need that encoded
> pfn as we have vmf->address.

It would be a swap entry if we reach try_to_umap_one() without trouble.
Then we have the code that converts it:

 ...
 if (PageHWPoison(p))
         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
	 set_{huge_}pte_at
 ...

But maybe we could only do that for ProcA, while ProcB failed to do that,
which means that for ProcA that is a hwpoisoned-swap-entry, but ProcB still
has this page mapped as usual, so if ProcB re-access it, that will not
trigger a fault (because the page is still mapped in its pagetables).


-- 
Oscar Salvador
SUSE Labs

