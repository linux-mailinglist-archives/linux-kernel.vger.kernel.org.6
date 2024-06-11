Return-Path: <linux-kernel+bounces-209811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F3903B34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CCB2824E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1FC176237;
	Tue, 11 Jun 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X3IdD+L9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ctr3kmAL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2314F9E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106917; cv=none; b=DoUmxufFMFcs31Q6u7dydPPyBs0RkUBzp0WEpcMYxfsM24sb7TAXwoqoGCDYCbMe5aneTPMIB+lIoGN6aYNFknJLLe8+Mk7F/unSuu99mRQa0lmfCpzpf68KvaNK4m6zyHHDX1HvIe0Z2DEH2mRmExvpk5FCI9/Filv3xJY1t0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106917; c=relaxed/simple;
	bh=/+JrJoekAVsPdbGaxdVip5r4w6VlQHb8XeTF4tqiCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R426/zAgn8TfRxNV8fdyZvgDOqLjIquoNNCVnSbAwiOo7Qlezg9tL3LDSRyWBEYEu15W2ZShgxfx6pyNbDBU+KAGT6PpoEiU4X23JZA4giZJNml0v95M7cM8tyfL2k58IptW3DD/t06Dw8DF/fAby/FewHfRTwDhDOqhTsJRIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X3IdD+L9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ctr3kmAL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCCBE3373A;
	Tue, 11 Jun 2024 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718106914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8itFnZLoGjChMJJ6y4EBv6LeuFDHeLJfvExupX7tDis=;
	b=X3IdD+L9Upk/xRzoYtKahqgAfQqEo37+NQCvJxidht45A0mGOCVOEjN1jx3Y3hyHdRG5CY
	n2oaYxRubnGNP5vou2a5PB1tEA6h5X2IMjwoB6kfRI5ivAVAo7hkpokBqcyi8BKRAMuexv
	lXFNATndfe2vPQepM1oc3k4D0CkPhoQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ctr3kmAL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718106913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8itFnZLoGjChMJJ6y4EBv6LeuFDHeLJfvExupX7tDis=;
	b=Ctr3kmALNlU8j4/GHYTNIxsZa+1UHOr8WaPkI1vRV2bGtqnr2jcbk1LBfObKNqKj3WUUwe
	rN2yL+OG5ah1cj4a7FbhNgvxCB14Kx6QUz/0z++1d/w8JI5TgYEIMSRVQsNGV04orpNiJb
	AQWL22jlwXIO4rqGmcyx9OSvlQajfWs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17A213A55;
	Tue, 11 Jun 2024 11:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDgcMyE7aGY9IQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 11 Jun 2024 11:55:13 +0000
Date: Tue, 11 Jun 2024 13:55:05 +0200
From: Michal Hocko <mhocko@suse.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <Zmg7GXK1SGFJNdge@tiehlicka>
References: <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
 <20240604003448.GA26609@system.software.com>
 <Zmb-ZZHbeNNjcs68@tiehlicka>
 <20240611005523.GA4384@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611005523.GA4384@system.software.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,intel.com,redhat.com,gmail.com,vger.kernel.org,kvack.org,skhynix.com,linux-foundation.org,tencent.com,techsingularity.net,google.com,kernel.org,linutronix.de,alien8.de,linux.intel.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DCCBE3373A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 11-06-24 09:55:23, Byungchul Park wrote:
> On Mon, Jun 10, 2024 at 03:23:49PM +0200, Michal Hocko wrote:
> > On Tue 04-06-24 09:34:48, Byungchul Park wrote:
> > > On Mon, Jun 03, 2024 at 06:01:05PM +0100, Matthew Wilcox wrote:
> > > > On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> > > > > Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
> > > > >  Presumably some xa_value() that means a reader has to go do a
> > > > > luf_flush() before going any farther.
> > > > 
> > > > I can allocate one for that.  We've got something like 1000 currently
> > > > unused values which can't be mistaken for anything else.
> > > > 
> > > > > That would actually have a chance at fixing two issues:  One where a new
> > > > > page cache insertion is attempted.  The other where someone goes to look
> > > > > in the page cache and takes some action _because_ it is empty (I think
> > > > > NFS is doing some of this for file locks).
> > > > > 
> > > > > LUF is also pretty fundamentally built on the idea that files can't
> > > > > change without LUF being aware.  That model seems to work decently for
> > > > > normal old filesystems on normal old local block devices.  I'm worried
> > > > > about NFS, and I don't know how seriously folks take FUSE, but it
> > > > > obviously can't work well for FUSE.
> > > > 
> > > > I'm more concerned with:
> > > > 
> > > >  - page goes back to buddy
> > > >  - page is allocated to slab
> > > 
> > > At this point, tlb flush needed will be performed in prep_new_page().
> > 
> > But that does mean that an unaware caller would get an additional
> > overhead of the flushing, right? I think it would be just a matter of
> 
> pcp for locality is already a better source of side channel attack.  FYI,
> tlb flush gets barely performed only if pending tlb flush exists.

Right but rare and hard to predict latencies are much worse than
consistent once. 

> > time before somebody can turn that into a side channel attack, not to
> > mention unexpected latencies introduced.
> 
> Nope.  The pending tlb flush performed in prep_new_page() is the one
> that would've done already with the vanilla kernel.  It's not additional
> tlb flushes but it's subset of all the skipped ones.

But those skipped once could have happened in a completely different
context (e.g. a different process or even a diffrent security domain),
right?

> It's worth noting all the existing mm reclaim mechaisms have already
> introduced worse unexpected latencies.

Right, but a reclaim, especially direct reclaim, are expected to be
slow. It is much different to see spike latencies on system with a lot
of memory.
-- 
Michal Hocko
SUSE Labs

