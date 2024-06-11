Return-Path: <linux-kernel+bounces-210359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710A9042CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FB31C2471C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76495915A;
	Tue, 11 Jun 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PmzZEcgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6YIYDN9U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="THwRdiYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OUu6IJyD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566253E15
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128333; cv=none; b=V3p/OzhDhtQtZAvzJnyvxgeQ000jnV5x2y+xtWZOG2stn4/Wz9Xc7vMluwt94sJJXjZKlPvWeYO1ixSIagLKd8nSjce+m5Bu0D4C6gDGIyzkn2OSdtnMeU3vx5+AEU3pZjPGyEHvHDaBmHK8BSSSKhHKs+y8eRYY5Hvb+/NCkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128333; c=relaxed/simple;
	bh=gLIl+N3EbDmCDUs54fUZNe0BBk/6vvbMQujh7ry3Nw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1/vs/OHYOcvXEf+3zqt/bbRWLTrvmZxGKqwDX5wXUPhaUgOm+WDIy08QyKgCFnaDFypeWB9aJc9EzajzmH9/uVxr1csX6ewaBi4ES2E3KoNNZgIHi7A8JXRPK9wGAlhAR3hv6u2R7ZTfis8TLvv85OPztYK0lbcROiaJDwIbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PmzZEcgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6YIYDN9U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=THwRdiYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OUu6IJyD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7400C3393D;
	Tue, 11 Jun 2024 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718128329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcY9+66PbaVZcQn/3AmGdGmKSjGYDmXRUDA786GKSJA=;
	b=PmzZEcgPXSCu9EiLqUdMROSwdSQrprLqpE5w3EwjVyE/oQVTU+VT0VGyf1faTIZh5aQo/4
	fTCPcKJ+whtKSuzgiqY+FuQgUiL6MXvMVuXuQB2F05TEx0uLohMM6tp6qkqHYB9nD3Uiv2
	JAD/iXtuaUuwetlSPZouGCPcJl9WtF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718128329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcY9+66PbaVZcQn/3AmGdGmKSjGYDmXRUDA786GKSJA=;
	b=6YIYDN9U6sj2xYIj2zkEv65eskA2NpgIqqkAuT+8OMXnD1tkiRFzMopSZTO6KkmXwyv2Ty
	XJeNiEJhTqVtDQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718128328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcY9+66PbaVZcQn/3AmGdGmKSjGYDmXRUDA786GKSJA=;
	b=THwRdiYpiuZzHRI8TN9ZSMeHmE/jY0eyX4ukuCK5Ju20hWl9hW3ErTBeIjImqG7MjnMaFk
	bjODjn2ucCzL7yZjYOlrjFTc8ik3/f0TtKZ4WDFkBtNwfTXbJ9YqBb1hURD2MotIq5nKU0
	CMIw9WyjTJODaAgWZicyvU7WzxZsw6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718128328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcY9+66PbaVZcQn/3AmGdGmKSjGYDmXRUDA786GKSJA=;
	b=OUu6IJyDb5SwnvhEYtSKAAZTwjyu6JxmkVbJ951IhvN3c9KLYhRrVf0/Mn7vJlKNYNOr1n
	kNGab4/icNZeK1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEE613A55;
	Tue, 11 Jun 2024 17:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mACMO8eOaGY3CgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 17:52:07 +0000
Date: Tue, 11 Jun 2024 19:52:06 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Message-ID: <ZmiOxhiWU-CE2ilg@localhost.localdomain>
References: <0000000000004f12bb061a9acf07@google.com>
 <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
 <ZmiNeTL5cZYmCbNf@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiNeTL5cZYmCbNf@localhost.localdomain>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[569ed13f4054f271087b];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Tue, Jun 11, 2024 at 07:46:33PM +0200, Oscar Salvador wrote:
> On Tue, Jun 11, 2024 at 10:30:05AM -0700, Andrew Morton wrote:
> > On Tue, 11 Jun 2024 03:34:25 -0700 syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > 
> > Thanks.
> > 
> > > Call Trace:
> > >  <TASK>
> > >  alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
> > >  memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
> > >  memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
> > >  udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
> > >  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
> > >  udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > I think we can pretty confidently point at the series "mm/gup:
> > Introduce memfd_pin_folios() for pinning memfd folios".  I'll drop the
> > v14 series.  
> 
> jfyi: I am trying to reproduce this locally.

Actually, should not memfd_alloc_folio() pass htlb_alloc_mask() instead
of GFP_USER to alloc_hugetlb_folio_nodemask? Or at least do
GFP_HIGHUSER.


-- 
Oscar Salvador
SUSE Labs

