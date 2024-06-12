Return-Path: <linux-kernel+bounces-211096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0CA904D14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860952827C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F146C16B729;
	Wed, 12 Jun 2024 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/K//iGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8XfKfm/F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/K//iGf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8XfKfm/F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85148376E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178403; cv=none; b=rbGhrd+X/PgeHrzcoDWMNbRs+arUoS0AcGtdDSXF4aoBlr3ND0fywZ3dqiM92SrsH+iVQJ0QgAqR4vP9CQl32703w1zoNOlg9+MygzZ7Hd85CpPRwrwryfAy3wWhJUeetFFU6cDxOZSNgw+COB0NGdTeSQRsP86FQzaO/rJkb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178403; c=relaxed/simple;
	bh=UFpabIf/dN8c1RJLdklHzuovnkTesTVwJ00eTyqxSC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqh99e3wcyszqCMrp7WrIr4JKApyORuZlbhmsnXgrRHdUU8cpoHq7y9+AcJb54CYHp0Cefn4qaipOq1Mw0wME7UnvfCuWMrmmujNMfOMJ0ziLfTV7yios9KfW3TdDc9qvZmg1NWf+Y5eqOZyC/tZwqLA8Lm7noRDZm6SMxVQq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/K//iGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8XfKfm/F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/K//iGf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8XfKfm/F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13EC5BD71;
	Wed, 12 Jun 2024 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718178399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqPYOMSLjoZmKtQ6T4VvDZee4VHduhR9r0QGUNqSm+E=;
	b=Y/K//iGfqnXWWHmkYXFNp74NDi0lFYeGBC5Nqiehur9Q7Y9oelC5piySkkyBWTFdFXXVSy
	1wA70XmZPQkQuyKWUR2wke2nnujZN3eC0YphhREkerX7OSktkLWirg2NpZDFxFHrk3PsPl
	1X8dYTboMPBfP4QtL80YSfeXZAwH3nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718178399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqPYOMSLjoZmKtQ6T4VvDZee4VHduhR9r0QGUNqSm+E=;
	b=8XfKfm/FF2m/OhCu02PM8NgHKE+mQB8z+1g3O41wPPSwnZNsgFEO4uLIXXO3RlaGNe8V0x
	7yuTRFQ+8LMRFGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718178399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqPYOMSLjoZmKtQ6T4VvDZee4VHduhR9r0QGUNqSm+E=;
	b=Y/K//iGfqnXWWHmkYXFNp74NDi0lFYeGBC5Nqiehur9Q7Y9oelC5piySkkyBWTFdFXXVSy
	1wA70XmZPQkQuyKWUR2wke2nnujZN3eC0YphhREkerX7OSktkLWirg2NpZDFxFHrk3PsPl
	1X8dYTboMPBfP4QtL80YSfeXZAwH3nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718178399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqPYOMSLjoZmKtQ6T4VvDZee4VHduhR9r0QGUNqSm+E=;
	b=8XfKfm/FF2m/OhCu02PM8NgHKE+mQB8z+1g3O41wPPSwnZNsgFEO4uLIXXO3RlaGNe8V0x
	7yuTRFQ+8LMRFGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5992B1372E;
	Wed, 12 Jun 2024 07:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d5BAE19SaWYIUAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Jun 2024 07:46:39 +0000
Date: Wed, 12 Jun 2024 09:46:37 +0200
From: Oscar Salvador <osalvador@suse.de>
To: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Message-ID: <ZmlSXfFAw-gWfJIG@localhost.localdomain>
References: <0000000000004f12bb061a9acf07@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004f12bb061a9acf07@google.com>
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[569ed13f4054f271087b];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Tue, Jun 11, 2024 at 03:34:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d35b2284e966 Add linux-next specific files for 20240607
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=161352e2980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
> dashboard link: https://syzkaller.appspot.com/bug?extid=569ed13f4054f271087b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb5e86980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db597e980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e0055a00a2cb/disk-d35b2284.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/192cbb8cf833/vmlinux-d35b2284.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/57804c9c9319/bzImage-d35b2284.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000489: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: probably user-memory-access in range [0x0000000000002448-0x000000000000244f]
> CPU: 1 PID: 5095 Comm: syz-executor603 Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> RIP: 0010:zonelist_zone_idx include/linux/mmzone.h:1613 [inline]
> RIP: 0010:next_zones_zonelist include/linux/mmzone.h:1644 [inline]
> RIP: 0010:first_zones_zonelist include/linux/mmzone.h:1670 [inline]
> RIP: 0010:dequeue_hugetlb_folio_nodemask+0x193/0xe40 mm/hugetlb.c:1362
> Code: 93 7a a0 ff c7 44 24 14 00 00 00 00 83 7c 24 40 00 0f 85 97 0c 00 00 48 83 7c 24 20 00 0f 85 45 09 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 58 09 00 00 44 8b 33 44 89 f7 8b 5c 24
...
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: https://github.com/leberus/linux hugetlb-dequeue-numa


-- 
Oscar Salvador
SUSE Labs

