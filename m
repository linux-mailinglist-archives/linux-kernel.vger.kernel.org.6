Return-Path: <linux-kernel+bounces-442118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56A9ED830
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F1028280E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39620A5F9;
	Wed, 11 Dec 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p6RTCzVY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+xvp7i//";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p6RTCzVY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+xvp7i//"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6E259498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951465; cv=none; b=M55iLCGgdViW4u3fK2Ynxu/SQLREl3RXlzfjeEPgitIAo6NDFtvqowUQBbAxFiP919YALFO4ClQTMZ8s2DpISpTmIXgW0k3a9FAOEhYpZMAWo1kmHPHAYi4F+kTtzRaxWFIhSjCZKjLs+8ygJVxjgJxhkz8Nr7DA/X3jLM57Gqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951465; c=relaxed/simple;
	bh=BgjMbZbo/5z0V0YZVybqfpE/sNqbBrB1aQRNEiQI7Ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFuD0D3KH56WmiFZBcOgO4jYgK7JCMJcH4MPdLjIwZ96ZvdjUHp23yMhRWJr3nETUZqfvNcd3F7mUxSdA/Rmqt9mfY0wiCFOxfz+ikTaXVHiUGTm4iNEjDTJVwsvNRZPHTi19ugzETCLhkC5TAmkLiW+UMGRUem/yozBGn/ENEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p6RTCzVY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+xvp7i//; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p6RTCzVY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+xvp7i//; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AB721F38D;
	Wed, 11 Dec 2024 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733951460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61jVCsRPkpxL71FtxdVZinhE6grCdcoA/ro1tDNzlOI=;
	b=p6RTCzVYR6/heVFlxh5RT3tQQiBLlEoFgt2C0wBbegH+wrWdmamED94DYB9adicFwycd5D
	Y0q1mOKOsOCmnAc+yI5ZOfUpnzRUH1dG1iUyMjwDKoCWsSBJb8ktO9zFFpIRP+OVq2H4ok
	VO685HeVFU0x95FTFusvPUxMFX5Mw1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733951460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61jVCsRPkpxL71FtxdVZinhE6grCdcoA/ro1tDNzlOI=;
	b=+xvp7i//LCd7aTqKOi59lKK7swNAftuk7nDc2t+RKzLHxlA66aPRDviDU7n2ncJLBVQWtA
	4crTg92T39Kft5CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733951460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61jVCsRPkpxL71FtxdVZinhE6grCdcoA/ro1tDNzlOI=;
	b=p6RTCzVYR6/heVFlxh5RT3tQQiBLlEoFgt2C0wBbegH+wrWdmamED94DYB9adicFwycd5D
	Y0q1mOKOsOCmnAc+yI5ZOfUpnzRUH1dG1iUyMjwDKoCWsSBJb8ktO9zFFpIRP+OVq2H4ok
	VO685HeVFU0x95FTFusvPUxMFX5Mw1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733951460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61jVCsRPkpxL71FtxdVZinhE6grCdcoA/ro1tDNzlOI=;
	b=+xvp7i//LCd7aTqKOi59lKK7swNAftuk7nDc2t+RKzLHxlA66aPRDviDU7n2ncJLBVQWtA
	4crTg92T39Kft5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0757513927;
	Wed, 11 Dec 2024 21:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m4IkNuP/WWf3KAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 11 Dec 2024 21:10:59 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  "hanqi@vivo.com" <hanqi@vivo.com>,
  "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Unicode conversion issue
In-Reply-To: <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 11 Dec 2024 12:18:25 -0800")
Organization: SUSE
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
	<Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be>
	<CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
	<CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
Date: Wed, 11 Dec 2024 16:10:58 -0500
Message-ID: <875xnqudr1.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 11 Dec 2024 at 11:58, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The problem is that all the filesystems basically do some variation of
>>
>>         if (IS_CASEFOLDED(dir) ..) {
>>
>>                 len = utf8_casefold(sb->s_encoding, orig_name,
>>                         new_name, MAXLEN);
>>
>> and then they use that "new_name" for both hashing and for comparisons.
>
> Oh, actually, f2fs does pass in the original name to
> generic_ci_match(), so I think this is solvable.
>
> The solution involves just telling f2fs to ignore the hash if it has
> seen odd characters.
>
> So I think f2fs could actually do something like this:
>
>   --- a/fs/f2fs/dir.c
>   +++ b/fs/f2fs/dir.c
>   @@ -67,6 +67,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
>                         /* fall back to treating name as opaque byte sequence */
>                         return 0;
>                 }
>   +             fname->ignore_hash = utf8_oddname(fname->usr_fname);
>                 fname->cf_name.name = buf;
>                 fname->cf_name.len = len;
>         }
>   @@ -231,7 +232,7 @@ struct f2fs_dir_entry
> *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
>                         continue;
>                 }
>
>   -             if (de->hash_code == fname->hash) {
>   +             if (fname->ignore_hash || de->hash_code == fname->hash) {
>                         res = f2fs_match_name(d->inode, fname,
>                                               d->filename[bit_pos],
>                                               le16_to_cpu(de->name_len));

This solves it for directories with inlined dirents
(FI_INLINE_DENTRY). but for large directories, we use fname->hash to
find the right block to start the search.  So, we'd need to walk through
the entire case-insensitive directory.  In ext4, the issue only exists
on large directories, because we don't care about the hash on small
directories.


>   --- a/fs/f2fs/f2fs.h
>   +++ b/fs/f2fs/f2fs.h
>   @@ -521,6 +521,7 @@ struct f2fs_filename {
>
>         /* The dirhash of this filename */
>         f2fs_hash_t hash;
>   +     bool ignore_hash;
>
>    #ifdef CONFIG_FS_ENCRYPTION
>         /*
>
> where that "utf8_oddname()" is the one that goes "this filename
> contains unhashable characters".
>
> I didn't look very closely at what ext4 does, but it seems to already
> have a pattern for "don't even look at the hash because it's not
> reliable", so I think ext4 can do something similar.

> So then all you actually need is that utf8_oddname() that recognizes
> those ignored code-points.
>
> So I take it all back: option (1) actually doesn't look that bad, and
> would make reverting commit 5c26d2f1d3f5 ("unicode: Don't special case
> ignorable code points") unnecessary.

I think we really need to revert it. The simplest way to implement
utf8_oddname is having the full database with the Ignorable code points
available. We can then add a flag in the same data structure indicating
this is an Ignorable codepoint that should be dismissed by the
utf8_strncasecmp when doing the casefold, while still using the full
string for the hash.

-- 
Gabriel Krisman Bertazi

