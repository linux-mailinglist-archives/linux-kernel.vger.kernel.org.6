Return-Path: <linux-kernel+bounces-442121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D682B9ED83A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BF4188621D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D11DC9AB;
	Wed, 11 Dec 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZmv8dAT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CE259498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951627; cv=none; b=eFbRuttno+ZEZkZQK6No+QXU/HENzWedp2fomBMMVwbB1tdna2JDs+T/RnTSKkFedRbz6i5nbXkyJ++fQtGycf+qgB/UOBeVzqHuVBgbZU14+G7IXFlHO/xUE/dFyWyK/iw74RQdNoQUMJOQwMl+h+1bbWuDC0KZVHqXsoZwX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951627; c=relaxed/simple;
	bh=R0JdPraaSL7KlAmHlhieAz1Gj/RXBEtylhQ3Qyfszvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnt7ovlPZeYk2F9Lp0tWV25zr16qCCfzn8c0lEysWJjD3AYS8qwMkMuDtMt3lrMcKintLr6UQ/9qXHefkEzYLKlYBfzcMyc5GsF1hqmx5Q8Zc6DO7RzSl2P8vKFD0BmttnrhYYm9d3m/WAJB4luXLZ/T1owFZjF4RvzV9NlsA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZmv8dAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9537CC4CED2;
	Wed, 11 Dec 2024 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733951626;
	bh=R0JdPraaSL7KlAmHlhieAz1Gj/RXBEtylhQ3Qyfszvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZmv8dATqzl2y1i9+qOHbjA2gO20/eNHNBT+FQlRaDQc82/XxxX9IYUj4iBqRSrIu
	 Q60ZkL8izx06QFtKRZmFtksf0BUBS/taFKGQA2eKK5zrem7ol8Ds8kANme8qFrIyxX
	 KBsJ2OXJ7eCU+LAYy93Hft6SvUEwzWeI88Ao4nL0LhQ7BDEf4yAiP7zrcxlNAUavIN
	 lgs1+G7aWRwO4LpwyVOGfmgIYBNCmyP9FB+3+l2Gr/u1RmyU/ebvfLQQM8SKhtfvMT
	 hbd82wkgXkHZat3JLBBazHAmt/T7fkah9tJAc1s27bdya8tcIz6DNav77pCFmTfpx7
	 DCVe6DVgGe39Q==
Date: Wed, 11 Dec 2024 21:13:44 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"hanqi@vivo.com" <hanqi@vivo.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Unicode conversion issue
Message-ID: <Z1oAiAAKzAmV5M2h@google.com>
References: <Z1mzu4Eg6CPURra3@google.com>
 <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com>
 <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>

On 12/11, Linus Torvalds wrote:
> On Wed, 11 Dec 2024 at 11:58, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The problem is that all the filesystems basically do some variation of
> >
> >         if (IS_CASEFOLDED(dir) ..) {
> >
> >                 len = utf8_casefold(sb->s_encoding, orig_name,
> >                         new_name, MAXLEN);
> >
> > and then they use that "new_name" for both hashing and for comparisons.
> 
> Oh, actually, f2fs does pass in the original name to
> generic_ci_match(), so I think this is solvable.
> 
> The solution involves just telling f2fs to ignore the hash if it has
> seen odd characters.

But, the hash is not just used when matching the dentry, but gives a block
location withiin multi-level hash tables for faster lookup as well. If the
filename length is also changed by the unicode patch, utf8_strncasecmp_folded()
will also give an error?

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
> 
> So then all you actually need is that utf8_oddname() that recognizes
> those ignored code-points.
> 
> So I take it all back: option (1) actually doesn't look that bad, and
> would make reverting commit 5c26d2f1d3f5 ("unicode: Don't special case
> ignorable code points") unnecessary.
> 
>                 Linus

