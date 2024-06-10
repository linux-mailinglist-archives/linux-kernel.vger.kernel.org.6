Return-Path: <linux-kernel+bounces-208228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2800F90229F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF91F23826
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583912FB01;
	Mon, 10 Jun 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPP+8ktl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPP+8ktl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4812F399
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025838; cv=none; b=hrTboVGUswQ5uh4ef/hir6Z8eYN4KLHOT/0d9K9KB319xCLhK5iT2wppTMMyesXfbaXZ5Wy+9sHJ4gh24ISw+s6NNMyQfU5YO/FXjYY0Dx1O+tBx6K91z0ELaJYqvGshcidanHq+p40QPgsLnasqRkLw0Dsov0czTo3x384fy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025838; c=relaxed/simple;
	bh=6E117J5q2zQN+cGgmJCbKYOL9GHDd3RjdgUx+nvSanc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRM9nfPcJa12qYFTp7L5ryjWpxwfUMGJn/wgHAwnscFgSjViZ+PinfZM7JSpyIjD+qZHnPGjdBRM7+xuKQV80zR+JtRf3dYRuB8EtdIKebqdyoE5YNdtxxZMoFUjj7KE4PbbipqSKYj08doWKYmMuzecrnoWVBTUP2AYrOVNBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPP+8ktl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPP+8ktl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B394F1F7F3;
	Mon, 10 Jun 2024 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718025834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhwIXuLk75mx3LVCWaJczOVutWJ7oqAn3s5/sjvFOAQ=;
	b=ZPP+8ktlXgU1i1nQ85U7YBTWOxphkzTDHferEufkD5zGTMpLQUoKciODWszBmDdOtfN9ew
	4F/zOSj2bBV92seg1cqgSXgql4QksW6TUtFvYu8q3clCIDvO3P3zjPKg+Avkn/GGm9E9RK
	DftIQM1ebBLpqGMrs8T5ZoXdefMiWa4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZPP+8ktl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718025834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhwIXuLk75mx3LVCWaJczOVutWJ7oqAn3s5/sjvFOAQ=;
	b=ZPP+8ktlXgU1i1nQ85U7YBTWOxphkzTDHferEufkD5zGTMpLQUoKciODWszBmDdOtfN9ew
	4F/zOSj2bBV92seg1cqgSXgql4QksW6TUtFvYu8q3clCIDvO3P3zjPKg+Avkn/GGm9E9RK
	DftIQM1ebBLpqGMrs8T5ZoXdefMiWa4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9401413A51;
	Mon, 10 Jun 2024 13:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id peg5IWr+ZmYbMwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 10 Jun 2024 13:23:54 +0000
Date: Mon, 10 Jun 2024 15:23:49 +0200
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
Message-ID: <Zmb-ZZHbeNNjcs68@tiehlicka>
References: <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
 <20240604003448.GA26609@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604003448.GA26609@system.software.com>
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,intel.com,redhat.com,gmail.com,vger.kernel.org,kvack.org,skhynix.com,linux-foundation.org,tencent.com,techsingularity.net,google.com,kernel.org,linutronix.de,alien8.de,linux.intel.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B394F1F7F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 04-06-24 09:34:48, Byungchul Park wrote:
> On Mon, Jun 03, 2024 at 06:01:05PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> > > Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
> > >  Presumably some xa_value() that means a reader has to go do a
> > > luf_flush() before going any farther.
> > 
> > I can allocate one for that.  We've got something like 1000 currently
> > unused values which can't be mistaken for anything else.
> > 
> > > That would actually have a chance at fixing two issues:  One where a new
> > > page cache insertion is attempted.  The other where someone goes to look
> > > in the page cache and takes some action _because_ it is empty (I think
> > > NFS is doing some of this for file locks).
> > > 
> > > LUF is also pretty fundamentally built on the idea that files can't
> > > change without LUF being aware.  That model seems to work decently for
> > > normal old filesystems on normal old local block devices.  I'm worried
> > > about NFS, and I don't know how seriously folks take FUSE, but it
> > > obviously can't work well for FUSE.
> > 
> > I'm more concerned with:
> > 
> >  - page goes back to buddy
> >  - page is allocated to slab
> 
> At this point, tlb flush needed will be performed in prep_new_page().

But that does mean that an unaware caller would get an additional
overhead of the flushing, right? I think it would be just a matter of
time before somebody can turn that into a side channel attack, not to
mention unexpected latencies introduced.
-- 
Michal Hocko
SUSE Labs

