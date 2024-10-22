Return-Path: <linux-kernel+bounces-375959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665929A9DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D5F283EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13056191F65;
	Tue, 22 Oct 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AR2vwOoV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4uhoV0eW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AR2vwOoV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4uhoV0eW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511313A87E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587746; cv=none; b=X1qMrSwoFr6/T5zmaMLWP4i7/GuYSkF1eJ26taxBQmmpJEAI9E3XzzADed/Wcai8rR/VHMmSFgL0woUREEttUfifZ0b/Is0TBWiDrfDpX2g3EesCkGPrKuSqWqW9btQFzq0H048kcvrJlQyLmJnt6vIgKV/NUHvoKhVL1mrGixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587746; c=relaxed/simple;
	bh=hemfWZ0/5Lavp/NbEbcD6PJFzXhvn4kRS5kDGyp379E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMZ53RKyhbpih+yxJzFPWFd0SDUXQXgCO2ugsu36cNnCK/mc7BRVYPl37dmEc7LcJwQLQAMG2gD2pYOYtnljVikJ04JxDISx5FnrbJgato/YjcuFQdnZqiSy0Lyuc+HSLY4BYvREao8teWDVZpeaBGFxAi5Yk18AejGcjsjVYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AR2vwOoV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4uhoV0eW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AR2vwOoV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4uhoV0eW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6D1021EA9;
	Tue, 22 Oct 2024 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729587742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15bNPfrZW1x1Sm/gwxvv4cpA/BRcDjhyJ0pFjAnb5u8=;
	b=AR2vwOoVygG1qN4w3QSnj412plCw3aYWCYMy6pz7+ZGcxUUMkXW3VS2BH3pfY9t0ah7xot
	lpsyuMz/cirhN+YO7jrxXI2U6aBtHEbdZTi5ODkcyS5pGvjhuHRv6kWnFdnuIF/4sTOS8o
	66AZjzzvjq0wHeNqWH4Ndhlbgj1Fn5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729587742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15bNPfrZW1x1Sm/gwxvv4cpA/BRcDjhyJ0pFjAnb5u8=;
	b=4uhoV0eWo2OKSPENQcr8sjnHE9HGRPDOTD2QN7A90rDWeCdGzZZkNiKl9GmvNB+PHr2v9z
	3FFZzuNAy7LaTXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729587742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15bNPfrZW1x1Sm/gwxvv4cpA/BRcDjhyJ0pFjAnb5u8=;
	b=AR2vwOoVygG1qN4w3QSnj412plCw3aYWCYMy6pz7+ZGcxUUMkXW3VS2BH3pfY9t0ah7xot
	lpsyuMz/cirhN+YO7jrxXI2U6aBtHEbdZTi5ODkcyS5pGvjhuHRv6kWnFdnuIF/4sTOS8o
	66AZjzzvjq0wHeNqWH4Ndhlbgj1Fn5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729587742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15bNPfrZW1x1Sm/gwxvv4cpA/BRcDjhyJ0pFjAnb5u8=;
	b=4uhoV0eWo2OKSPENQcr8sjnHE9HGRPDOTD2QN7A90rDWeCdGzZZkNiKl9GmvNB+PHr2v9z
	3FFZzuNAy7LaTXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BE6C13AC9;
	Tue, 22 Oct 2024 09:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AgKJh5qF2d4BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Oct 2024 09:02:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B298A086F; Tue, 22 Oct 2024 11:02:22 +0200 (CEST)
Date: Tue, 22 Oct 2024 11:02:22 +0200
From: Jan Kara <jack@suse.cz>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: jan Kara <jack@suse.com>,
	syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [udf?] general protection fault in udf_read_folio
Message-ID: <20241022090222.tndd3zqlgtohjnce@quack3>
References: <6716ebf5.050a0220.10f4f4.00db.GAE@google.com>
 <2ae7d2b0-0053-4cff-9352-d180c243ded4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae7d2b0-0053-4cff-9352-d180c243ded4@gmail.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[ddf8715339c89280b6fc];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-10-24 02:19:19, Gianfranco Trad wrote:
> On 22/10/24 02:04, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> > 
> > Reported-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
> > Tested-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
> > 
> > Tested on:
> > 
> > commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12684640580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Note: no patches were applied.
> > Note: testing is done by a robot and is best-effort only.
> 
> Hi Jan,
> 
> syzbot reported a null-ptr-deref in udf_read_folio a month ago [1].
> 
> This bug was marked as still open on syzbot, so I retested the reproducer
> (no patch applied) to check if the bug was still valid upstream, seems not
> (as reported up).
> Wondering if syzbot will now try to find another reproducer, since after
> this check the reproducer was crossed away on the syzbot web UI, or if the
> bug can be considered closed.
> I hope this might help.

I believe syzbot tries to bisect back to the fix and reports it. Then
either you can ack it (which closes the bug) or the bug will auto-close
after some time if there's no reproducer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

