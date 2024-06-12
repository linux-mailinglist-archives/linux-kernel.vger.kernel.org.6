Return-Path: <linux-kernel+bounces-210936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB454904AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374821F22106
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F62F50A;
	Wed, 12 Jun 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fX25/7Y5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TQEukDXp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fX25/7Y5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TQEukDXp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F528DD1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169124; cv=none; b=UoQd8yE+2LL9QMS4Qx0FHItw4GUiCmuZL4wfMj2b+iLMjqdAUaTGpYG+ZJvtQf981+zIeFPi9HNMZG6+P+Db+gQsohAHXD1MShEqJEF2aHt+Uz9raktO4Hdcy2/qKTZshDeSkksTe/fwU9bLzJNpSLoslWZdGhsammIE1+h6FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169124; c=relaxed/simple;
	bh=As6APksy1IGxV4JLIT2WN1gTJM2ZYvvx3ja6MzDeckM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN3jH6NaRqeX9mil8nJzMMJvlPGcCxKpFWT+4cM3HnI/nkgdlrzKJX8BHWXLqr/zIJ/+6eSUGpBRDbpK6LBkEZm0kESa9rkr2YbQRpYQKbxQkWebLc52olN6VmUs1T/D/tactp2Tmnn/rlxFh5As3WTYFf8sx8QVPbdclbdDWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fX25/7Y5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TQEukDXp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fX25/7Y5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TQEukDXp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1231A33EC2;
	Wed, 12 Jun 2024 05:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YBn/nAZuJl3pGHfMw3MJArLAqmqGFrn2hyTXR70cM=;
	b=fX25/7Y5DzIfPRxSG5CRhJ4ACd8LIvhUipT+cSstyXQ+yiSfeFf8+WXErYQ1K35LOA8jJ4
	768G5z2kFRGqZa/R6L2CayIfYFjmkrqRY3/z3AnJpqkZH3KF1zqjA9wPslf6PFB4Ww+uDt
	UElrJNaMjPwPFt5MfYpWT7byu3Usw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YBn/nAZuJl3pGHfMw3MJArLAqmqGFrn2hyTXR70cM=;
	b=TQEukDXpbw6EYkkYBQxMR/vDy3gpQQr5imz/npGfEGpWWj4ZtF5o0EXw0TAhGRzd7A6WNT
	CAIzVzWVfLtY3YAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YBn/nAZuJl3pGHfMw3MJArLAqmqGFrn2hyTXR70cM=;
	b=fX25/7Y5DzIfPRxSG5CRhJ4ACd8LIvhUipT+cSstyXQ+yiSfeFf8+WXErYQ1K35LOA8jJ4
	768G5z2kFRGqZa/R6L2CayIfYFjmkrqRY3/z3AnJpqkZH3KF1zqjA9wPslf6PFB4Ww+uDt
	UElrJNaMjPwPFt5MfYpWT7byu3Usw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YBn/nAZuJl3pGHfMw3MJArLAqmqGFrn2hyTXR70cM=;
	b=TQEukDXpbw6EYkkYBQxMR/vDy3gpQQr5imz/npGfEGpWWj4ZtF5o0EXw0TAhGRzd7A6WNT
	CAIzVzWVfLtY3YAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0217137DF;
	Wed, 12 Jun 2024 05:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +EV7JCAuaWY2KAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Jun 2024 05:12:00 +0000
Date: Wed, 12 Jun 2024 07:11:59 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Message-ID: <ZmkuH8R2XJZEvJwh@localhost.localdomain>
References: <0000000000004f12bb061a9acf07@google.com>
 <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
 <ZmiNeTL5cZYmCbNf@localhost.localdomain>
 <ZmiOxhiWU-CE2ilg@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiOxhiWU-CE2ilg@localhost.localdomain>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Tue, Jun 11, 2024 at 07:52:06PM +0200, Oscar Salvador wrote:
> On Tue, Jun 11, 2024 at 07:46:33PM +0200, Oscar Salvador wrote:
> > On Tue, Jun 11, 2024 at 10:30:05AM -0700, Andrew Morton wrote:
> > > On Tue, 11 Jun 2024 03:34:25 -0700 syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > 
> > > Thanks.
> > > 
> > > > Call Trace:
> > > >  <TASK>
> > > >  alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
> > > >  memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
> > > >  memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
> > > >  udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
> > > >  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
> > > >  udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> > > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > I think we can pretty confidently point at the series "mm/gup:
> > > Introduce memfd_pin_folios() for pinning memfd folios".  I'll drop the
> > > v14 series.  
> > 
> > jfyi: I am trying to reproduce this locally.
> 
> Actually, should not memfd_alloc_folio() pass htlb_alloc_mask() instead
> of GFP_USER to alloc_hugetlb_folio_nodemask? Or at least do
> GFP_HIGHUSER.

Ok, I spot the issue.
memfd_alloc_folio() was calling alloc_hugetlb_folio_nodemask with
preferred_nid being NUMA_NO_NODE, but that is bad as
dequeue_hugetlb_folio_nodemask will do:

zonelist = node_zonelist(nid, gfp_mask)

which will try to get node_zonelists from nid, but since nid is -1, heh.

The below patch fixes the issue for me, but I think that the right place
to fix this up would be alloc_hugetlb_folio_nodemask(), so we can place
the numa_node_id() if preferred_nid = NUMA_NO_NODE in there as a safety
net.
This way we catch this before exploding in case the user was not careful
enough.

I will cook up a patch shortly.

Another thing is why memfd_alloc_folio uses GFP_USER instead of
GFP_HIGHUSER, but that maybe because I see that memfd_pin_folios() is
used by some DMA driver which might not have access to HIGH_MEMORY.

diff --git a/mm/memfd.c b/mm/memfd.c
index 8035c6325e3c..2692f0298adc 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -68,12 +68,13 @@ static void memfd_tag_pins(struct xa_state *xas)
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 {
 #ifdef CONFIG_HUGETLB_PAGE
+	int nid = numa_node_id();
 	struct folio *folio;
 	int err;
 
 	if (is_file_hugepages(memfd)) {
 		folio = alloc_hugetlb_folio_nodemask(hstate_file(memfd),
-						     NUMA_NO_NODE,
+						     nid,
 						     NULL,
 						     GFP_USER,
 						     false);

> 
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 

-- 
Oscar Salvador
SUSE Labs

