Return-Path: <linux-kernel+bounces-180140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545338C6A95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80B01F23616
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7314D156978;
	Wed, 15 May 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xAk2LgJB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6YyWOsQH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XeiTY/KG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="72Qj9JNV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FC13EFE5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790589; cv=none; b=m0YldSdDQoQBd1mTrKUgVf1F7/4g3OgPHnrydaJtRososyxud11WRdrdX/zZpHSTJFWEak5AhhKfb30MfMyzCKivvELww0sSavitBHRg6HsC4/KeRPpiQGdZ3xQlslvDrEdPnD17HciZFBRLtNDqe4vI/UHfw0tf88MfsyvpdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790589; c=relaxed/simple;
	bh=OJxGoKrjfqlK/MUgk1i9U5Q/Yg8IRzNWwgxtSetyJsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7oJk79iKoWEqFS0D44yaMcIdcvbFKerXgZQ1SqEq1DneVpgeDPI/o0VY9RuSKeE2DKShoyyEDNmEHe1wNfEAlWmePJ5iJ8Tx1FnsC/md0jbPYDO2Kbhk/smMoyImynOabjs4xMnrhYyXaS3Prqm6GM7NHO9tpoVFuzHtyN2pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xAk2LgJB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6YyWOsQH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XeiTY/KG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=72Qj9JNV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8A20208E9;
	Wed, 15 May 2024 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715790586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0jxss9V3AeagCi7uN8ZfpOTCNV12gVUbXNo/Msryv4=;
	b=xAk2LgJBh5BjtZhYRDFqUTuLDyYBSnMOkW1TvWgURfTyGY4OOgEq/Jm+d6XRAtZpxISoDy
	CSwdzYqkIp9SfnSFUCDmju+FpTI7eNkdIhp6lyMxZ9X9M/oagAiwmQMSN2UbOinFoFxACA
	qWWxCfgqmH+bbzy4ZJwt8XUynzAx0YQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715790586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0jxss9V3AeagCi7uN8ZfpOTCNV12gVUbXNo/Msryv4=;
	b=6YyWOsQHYDi+S+4JEq8FhnMivO1mvxmmbnMIVZiOsxQ+HeSsr66HdoRIO+ISFIez5YoVDv
	4AGyRkhPDmMThzDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715790585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0jxss9V3AeagCi7uN8ZfpOTCNV12gVUbXNo/Msryv4=;
	b=XeiTY/KGWFOgUCfP3ojvAHwdVRT3DC/Lk2oc57drMmfJunYP0zuSru7s99PfVb/2Fyk657
	Hd1UOgVj3Ohb9HtOSa7WMXeo1B900DHgRJR4iw6usu2uSR04V0VzH+QaX8cQSKkJxpXsnr
	YwWZk7tr5Vnnl2AftxwhgTKTaO+Lcfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715790585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0jxss9V3AeagCi7uN8ZfpOTCNV12gVUbXNo/Msryv4=;
	b=72Qj9JNVYu2+F6gryyPrY+s7k7XppIQXhvJqBzTM3IldZrx+g0jx0g8QScxsHoRMkbudLo
	8EMXd/DGEGWsG9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D13131372E;
	Wed, 15 May 2024 16:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkrlMvniRGYgHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:29:45 +0000
Date: Wed, 15 May 2024 18:29:44 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] WARNING in kernfs_remove_by_name_ns (3)
Message-ID: <20240515162944.GQ4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <00000000000047624505d0453c58@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000047624505d0453c58@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 0.60
X-Spam-Level: 
X-Spamd-Result: default: False [0.60 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=647adc5a101c9bf3];
	BAYES_HAM(-0.90)[85.97%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[93cbdd0ab421adc5275d];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Mon, Nov 08, 2021 at 03:24:26AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce840177930f Merge tag 'defconfig-5.16' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1516eb12b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=647adc5a101c9bf3
> dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernfs: can not remove 'nr_tags', no directory
> WARNING: CPU: 0 PID: 352 at fs/kernfs/dir.c:1535 kernfs_remove_by_name_ns+0x96/0xa0 fs/kernfs/dir.c:1535

#syz set subsystems: kernfs

Remove btrfs from subsystems.  Multiple reports, injected ENOMEM and
sysfs cannot remove the files and warns

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/kernfs/dir.c?id=d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7#n1662

