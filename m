Return-Path: <linux-kernel+bounces-210349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86F9042AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4340D1C23F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72458ADB;
	Tue, 11 Jun 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v8/frryW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3wgenPCm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uNrI7hne";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uJ/mdJ52"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D802570
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128001; cv=none; b=pwAywzbTvUrNkIQF12/mvm81ZdPAEshXDtbHtN7EluWK+PlMoclWpIbLexbKdUPCITeTIlnjjqH6Psv3WiAKca2dY3NPTYdRDsXA4Cpq+aUZDELfqqLdxV2KK1mnS87KqwhWFttYXJ9/TKjOFwARM+NMJF1afKcxfgIEOqom5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128001; c=relaxed/simple;
	bh=Gc2QJjFKuooJpZezzK9jDQOBXAv/+pvH9DTw7x0qZ1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfMWhrXkcurBSp+x1SR0GTqOQb0skCg91C9FAP34CdBQ9DB7ObEmcOojEQoSr0qvaehUlHs/Fg4g5Qxl0jVQDgV44QEkbPS0DD9QzFbNs9mPbwgTrj8VbEgQYjzUTsVhX0CdMGLCk1VTgYwIdg1cF2ToVQujmg07zJzOyLiE2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v8/frryW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3wgenPCm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uNrI7hne; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uJ/mdJ52; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA9D533934;
	Tue, 11 Jun 2024 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718127997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9F4F7zS6MedU2Ze6EUL2z7546IdwYSF8EB9xyILKMM=;
	b=v8/frryW0j2Kn6F6KTFimIngH2wXDDzZGwj8FkcPDU0dI3xwr8Mo9QedOrDj7KuAY1UvoD
	qBb3I71aBZolB5/4aOKf4vGhbupYP1sFsqSga87fA+ZK78mxiIgfzmmWBRdfTaO90JeDTW
	AYImxaUX9AXcp3NlYFyqfFkzG+xdgqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718127997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9F4F7zS6MedU2Ze6EUL2z7546IdwYSF8EB9xyILKMM=;
	b=3wgenPCm8OHwFH91hFIt/BUOnMqPx5WACck3uffMQXS23PNvu7PCYFn2O5IPtI0JM076hp
	i2uqwGZDwsLV+qBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uNrI7hne;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uJ/mdJ52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718127995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9F4F7zS6MedU2Ze6EUL2z7546IdwYSF8EB9xyILKMM=;
	b=uNrI7hnePKXIr76tjRxuQaCZl4QNVCLnDx5iwwISCNWYNqxn4HhzdLThBn0ZMvlstkDAQm
	j+jLqfnHLL7MuGsQ8ez5CVlyLZRQulMQXqKLuNvUzh6U4pbuUukrSCz4+8CPgKLPq1RLK/
	ropdHR6B59fb8whZihurCjV2OK+1N/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718127995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h9F4F7zS6MedU2Ze6EUL2z7546IdwYSF8EB9xyILKMM=;
	b=uJ/mdJ52jNDHlSLsAoF95gPn/eDsS4NlOLNZozrL9srsQPJEbyQOOx2KDFSoQppGu243iL
	WE2Hajbh5py9ztAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 734E113A55;
	Tue, 11 Jun 2024 17:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6CkWGXuNaGa4CAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 17:46:35 +0000
Date: Tue, 11 Jun 2024 19:46:33 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Message-ID: <ZmiNeTL5cZYmCbNf@localhost.localdomain>
References: <0000000000004f12bb061a9acf07@google.com>
 <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
X-Rspamd-Queue-Id: DA9D533934
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,appspotmail.com:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[569ed13f4054f271087b];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 11, 2024 at 10:30:05AM -0700, Andrew Morton wrote:
> On Tue, 11 Jun 2024 03:34:25 -0700 syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> Thanks.
> 
> > Call Trace:
> >  <TASK>
> >  alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
> >  memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
> >  memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
> >  udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
> >  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
> >  udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> I think we can pretty confidently point at the series "mm/gup:
> Introduce memfd_pin_folios() for pinning memfd folios".  I'll drop the
> v14 series.  

jfyi: I am trying to reproduce this locally.


-- 
Oscar Salvador
SUSE Labs

