Return-Path: <linux-kernel+bounces-434089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553B9E617F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74D7282F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9721CEE97;
	Thu,  5 Dec 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kMVcF/cd"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CD1BC063
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733442535; cv=none; b=Am0Tmr0BXg+YqtctqVLcSr1XlwwG8xzqm0kJDb2baJdxqNpnWU/BZ3gOi1BEKdixjIjiWYJPKzoUos/jmHQtpH35cmHdvXRteeNMB0GApGAZTka0AOIbrcFTWH7VXLDYOUAtLEg4RAGIhUnTXNuLcgipfTxfY4PgwBe40mOqDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733442535; c=relaxed/simple;
	bh=uqz6ivQ/2LyumpX9NNCPcod+YMiz19Q1MG3CTwn+rmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUKoW9jo76yGVICGHag3cvRNS6gLVTgN1XlDwkXc90LzmwmymVou6dgVb6/eUKMm6DB5JQnR/J3rI1CXt41LTx9rkGWKERZ8kIv3aYgf1BVXUIG8Fj6KOez5yn8RAqYStW/IR5GdbzuP2ZBT/j/Aq3yUEZyKL8JEk7el4LIIcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kMVcF/cd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2172086a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733442532; x=1734047332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp6M/ObLqy+1tkOR01UeM6+9P+LWvNmp8Od0Uqs1xZc=;
        b=kMVcF/cd3g11TjsDU79FEsye6DC96x0VcSgcSrP4jRMsEdJtsQO53+5JB9AOcl7ygE
         11k2n5k1nHTlGoBitIZcX9XdF+w/WczoxTU+9JcI5lEgL2K89lbEYh6umwT9AxvET7rU
         oRUaNN5p1tTL1eBumfNPRNc9sVRk0suhF+DG1Z66pXAUPVFu9n+N7KjLwSXvA1jOZKki
         CMuo6RbnR4FOzqk9jfOsM9iGSdDWarP8FBR1MgEyfGPaCncXc7A4hMOc0+K1AnAUAx3P
         RZSoInCWS4J8Zs12Zb5WIl8dqRU5LmB5dlsMCkOsnWbmsiUX/jO4ZZN1NOvW2mfNolAO
         wxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733442532; x=1734047332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp6M/ObLqy+1tkOR01UeM6+9P+LWvNmp8Od0Uqs1xZc=;
        b=XDb55k3o4AmX0wy8rJ+DmFM77PD44fw/IcyMOzU/2ucD/aTeyBQ7kjHC6Q6WATrAGu
         RZfBsvaP3hYMFebzd3JPfI9DYoDtHxy2ENduHUi6swBeYYV7nBuXeN8e7VLzxju0/Syf
         1OBcZPWq350W4BigyHS0oOQe8P/u5jCHdYQZj0UgwemAP4UC+yTocflyK6zMD0NfcbC4
         eJzqSQ3KhHCZf04DNxSOD1iQpXKHW7PYAyt8dSJe7WTyZAERP0LL9OqI/fB2JtP7dsiC
         olj5QsEyMgY3E51SQvIG3BCXdfypUBVuNcjOT0nzQCExeU4Ae4INj1jZOOrNmZiR8OZ2
         QqUg==
X-Forwarded-Encrypted: i=1; AJvYcCU8kOVSTl+ydzlqxE/5RJ7dONRbvbJke+lwpdUAATlVrwqVr+ysf+mAlsxCIH4Xttyaqt9ha/jmSACqmAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkX9Jgg4/oP17JnNvKDzGu/QStieqRsybZ90CbuIGjXqXS5itj
	hA/tdtOc+CyGZ3yuR/bvOpwDfE/ZCiWXV7OCYdfyNHZH04mJJwTyRqnAL0iOqFw=
X-Gm-Gg: ASbGncsx/Wmjl+OlB5wp730q1D+B9I53TzDd7tXpOoP0hS4Nvvm4uxrnBk7FoA2ygho
	kd6CunWB/tSdQ+J6ethrT4R2TruzM4UM4cF1b/PA9QFXsHgCY62BgpTRDkyhMYU2dZ+RYqsE+MP
	1tG0ask6HF6Wl4kHWiHRdFHkXzGcYTUG1wbpO9V7sU4qs6HfsmsBSq7I2QmJJw9o94Zjx71Ac/p
	w97PU6QsTyQ06wWwulxIETbFF4aEPYm+0Dm7eFGvJ6BKQ7rw3kh8hw8+ov3iK9th7Fv7XAKLsNI
	dzYmXbdx21/zbeeUXoc9e34=
X-Google-Smtp-Source: AGHT+IGIGj5SnYCFPesKUm0foOJsHTZQ70hdnjfdPmpvBxSjq6dR3HnM650p3aAphKdS24ug934vVw==
X-Received: by 2002:a17:90b:3f8b:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2ef68e2a9c7mr1831164a91.15.1733442532547;
        Thu, 05 Dec 2024 15:48:52 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b03sm4196890a91.38.2024.12.05.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:48:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tJLaS-000000078y9-1kqe;
	Fri, 06 Dec 2024 10:48:48 +1100
Date: Fri, 6 Dec 2024 10:48:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: alexjlzheng@tencent.com, cem@kernel.org, chandanbabu@kernel.org,
	dchinner@redhat.com, djwong@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [RESEND PATCH v2] xfs: fix the entry condition of exact EOF
 block allocation optimization
Message-ID: <Z1I74KeyZRv2pBBT@dread.disaster.area>
References: <Z09stGvgxKV91XfX@dread.disaster.area>
 <20241205121802.1232223-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205121802.1232223-1-alexjlzheng@tencent.com>

On Thu, Dec 05, 2024 at 08:18:02PM +0800, Jinliang Zheng wrote:
> On Wed, 4 Dec 2024 07:40:20 +1100, Dave Chinner wrote:
> > On Sat, Nov 31, 2024 at 07:11:32PM +0800, Jinliang Zheng wrote:
> > > When we call create(), lseek() and write() sequentially, offset != 0
> > > cannot be used as a judgment condition for whether the file already
> > > has extents.
> > > 
> > > Furthermore, when xfs_bmap_adjacent() has not given a better blkno,
> > > it is not necessary to use exact EOF block allocation.
> > > 
> > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > ---
> > > Changelog:
> > > - V2: Fix the entry condition
> > > - V1: https://lore.kernel.org/linux-xfs/ZyFJm7xg7Msd6eVr@dread.disaster.area/T/#t
> > > ---
> > >  fs/xfs/libxfs/xfs_bmap.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 36dd08d13293..c1e5372b6b2e 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -3531,12 +3531,14 @@ xfs_bmap_btalloc_at_eof(
> > >  	int			error;
> > >  
> > >  	/*
> > > -	 * If there are already extents in the file, try an exact EOF block
> > > -	 * allocation to extend the file as a contiguous extent. If that fails,
> > > -	 * or it's the first allocation in a file, just try for a stripe aligned
> > > -	 * allocation.
> > > +	 * If there are already extents in the file, and xfs_bmap_adjacent() has
> > > +	 * given a better blkno, try an exact EOF block allocation to extend the
> > > +	 * file as a contiguous extent. If that fails, or it's the first
> > > +	 * allocation in a file, just try for a stripe aligned allocation.
> > >  	 */
> > > -	if (ap->offset) {
> > > +	if (ap->prev.br_startoff != NULLFILEOFF &&
> > > +	     !isnullstartblock(ap->prev.br_startblock) &&
> > > +	     xfs_bmap_adjacent_valid(ap, ap->blkno, ap->prev.br_startblock)) {
> > 
> > There's no need for calling xfs_bmap_adjacent_valid() here -
> > we know that ap->blkno is valid because the
> > bounds checking has already been done by xfs_bmap_adjacent().
> 
> I'm sorry that I didn't express it clearly, what I meant here is: if we want
> to extend the file as a contiguous extent, then ap->blkno must be a better
> choice given by xfs_bmap_adjacent() than other default values.

Yes, but xfs_bmap_adjacent_valid() does not tell us that.

> /*
>  * If allocating at eof, and there's a previous real block,
>  * try to use its last block as our starting point.
>  */
> if (ap->eof && ap->prev.br_startoff != NULLFILEOFF &&
>     !isnullstartblock(ap->prev.br_startblock) &&
>     xfs_bmap_adjacent_valid(ap,
> 		ap->prev.br_startblock + ap->prev.br_blockcount,
> 		ap->prev.br_startblock)) {
> 	ap->blkno = ap->prev.br_startblock + ap->prev.br_blockcount; <--- better A

For people reading along: This sets the allocation target to the
end of the previous physical extent.

> 	/*
> 	 * Adjust for the gap between prevp and us.
> 	 */
> 	adjust = ap->offset -
> 		(ap->prev.br_startoff + ap->prev.br_blockcount);
> 	if (adjust && xfs_bmap_adjacent_valid(ap, ap->blkno + adjust,
> 			ap->prev.br_startblock))
> 		ap->blkno += adjust;                                 <--- better B

And this adjusts for the file offset of the new EOF allocation
being a distance beyond the previous extent. i.e.

file offset:	0	EOF	    ap->offset
layout:		+--prev--+-----hole-----+--new EOF allocation--+

After allocation:
file offset:	0	oEOF	      offset		      EOF
layout:		+--prev--+-----hole-----+--new EOF allocation--+
physical:	+--used--+-----free-----+-------used-----------+

And now when the write to fill the file offset hole (e.g. because of
racing concurrent extending AIO+DIO writes being issued out of
order), we end up with this non-EOF NEAR allocation being set up
over the hole in the file:

file offset:	0      ap->offset      			      EOF
layout:		+--prev--+-----hole-----+--------next----------+
                       ap->blkno

And the NEAR allocation will find the exact free space we left to
fill that hole, resulting in a file that looks like this:

file offset:	0					      EOF
layout:		+----------------------------------------------+
physical:	+----------------------------------------------+

i.e. a single contiguous extent.

> 	return true;

And it's important to note that xfs_bmap_adjacent returns true if
it selects a new target for exact allocation.

> }
> 
> Only when we reach 'better A' or 'better B' of xfs_bmap_adjacent() above, it
> is worth trying to use xfs_alloc_vextent_EXACT_bno(). Otherwise, NEAR is
> more suitable than EXACT.

Well, yes, that is exactly what the code was -trying- to do.
It was using ap->offset as a proxy for "there is a previous extent"
rather than an explicit check for "do we need exact allocation"

As you've rightly pointed out - this code is not correct in all
situations, nor optimal for all situations.

What I've been trying to point out to you is that your solution is
not optimal, either. 

> Therefore, we need xfs_bmap_adjacent() to determine whether xfs_bmap_adjacent()
> has indeed modified ap->blkno.

It already does, but we ignore it. If we want use exact allocation
only when we are doing EOF allocation:

Perhaps:

-	xfs_bmap_adjacent(ap);
+	if (!xfs_bmap_adjacent(ap))
+		ap->eof = false;

And then in xfs_bmap_btalloc_at_eof() all we need is

-	if (ap->offset) {
+	if (ap->eof) {

i.e. we only do exact allocation at EOF when xfs_bmap_adjacent has
set a target we want exact allocation for.

(note: don't confuse ap->eof and ap->aeof)

> > Actually, for another patch, the bounds checking in
> > xfs_bmap_adjacent_valid() is incorrect. What happens if the last AG
> > is a runt? i.e. it open codes xfs_verify_fsbno() and gets it wrong.
> 
> For general scenarios, I agree.

This *is* a general scenario. Every single extending allocation goes
through this path.

> But here, the parameters x and y of xfs_bmap_adjacent_valid() are both derived
> from ap->prev. Is it possible that it exceeds mp->m_sb.sb_agcount or
> mp->m_sb.sb_agblocks?

I think you missed the significance of the gap (file offset)
adjustment.

Write a couple of TB beyond EOF and see what happens. Then allocate
a file in the last AG that is a runt, and try to write a distance
beyond EOF that will land the target blkno between the size of
the runt AG and mp->m_sb.sb_agcount....

Hint: runt AG length < AGBNO(ap->blkno) < mp->m_sb.sb_agcount.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

