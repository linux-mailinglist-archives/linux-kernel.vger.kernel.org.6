Return-Path: <linux-kernel+bounces-201523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386508FBF74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A3BB2121B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80614BFA8;
	Tue,  4 Jun 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KVcMNi/7"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80B14D290
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542036; cv=none; b=Mbl5KmeV4blOX4laJjzcwRz/BatmdsmPz59SV6s6mWf+XtKbai3Iohy5pTKRhz0FpYk0AcxJE0yTXrGepIEXwZlMerYAchvNEez+fa5+5oQ3iBqTeihn40QP1HHb46Qjlzv9Kuhp06thDzpcDgflEqaEfMWbs63nk/M/s6myNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542036; c=relaxed/simple;
	bh=NqZy1jvUQgEP7snWSqJcHkFugUnn0xW0HZuaW2kAbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL340I4Q7YbyII3rdjwwo9gUTFOAq9GRsYEW39Ie85Z06UmKmFpy6iPwbOfuYH7UWMJklYgMT1hDI36pogL4zkGg1rmJcRlDiN8miGa5IyuVOofVI0ES1q4dIxdLciZPrpJod4T9pGsuEveb/Kgd6sRd+1NzbQcv7xGzv91ypLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KVcMNi/7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1e6fcb2f1so3740584a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717542033; x=1718146833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyNw4VRNcfHDMvQsdXF+ZQvFjDdNPI4HLjI8WPyoIyg=;
        b=KVcMNi/7JFtXCgR35uFsWeOcGvFYlyiSh7QU8BxTWejObgHL9ruezh9DsG8GU4g40h
         D6mAQTbqAC8fFPGpXZuSsQd36sq4W84oqEzUmLdKvLS4T2klaSDnmHvwevx+EGTapycD
         LkhiZPuy4xOGa/0TRtCEtMohqJ51dn64Q4fn0DSSVYq9v6c2vup111iRbuzRszIaVzg+
         krAbFzlnfLBiH+EdA1UixY99TeTMBJQH7rbnnTl7Gcbxx9OLCzTEWkiOyd/jao2jS7o+
         KfjmOAUdIMYf6FU7tkG1Dy+1TX8H3n92yOa1Be2f5ttD/VHDQpjzT4S2qnooofS0DbAp
         /lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542033; x=1718146833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNw4VRNcfHDMvQsdXF+ZQvFjDdNPI4HLjI8WPyoIyg=;
        b=lseI93SOhplEdZipQOJVA731UlqstlGiH3O4A6gCoTNCmHp1HFRlLN4xf30DWJK1qN
         O6jaWZMtqYKbGUPFT22pEBnArlMhdB/WwcOm1Xn+g4AynUerri0KdrW8h6g6AMk+0jL3
         86X+qYB13WDmm6LnhLS3Lr0ZXQ5yEWsilO0vt6b5cHqWyg8fzfGqpCn576FTK+uhMt2u
         YLOeAFWvo0tuH5neWzNoObF1gYhKnETlQzxe/z2wdTexHg6UfZLHmJEwPj2TwyQHv1zG
         znFTz/tarWO6nJ4ezPbF12ycmOWCbvHhy2nN8KX00bxNMkUMWbO2ELqVfYT5ePJM0B8Q
         VTbw==
X-Forwarded-Encrypted: i=1; AJvYcCVzfTecVqEIV56ZNh3wsD180zIGHmUUlrCcPGCOY1ZbWArCeKT/yPwbOoNS/GRmX+i6DO4FgGyhz3qosDWzEcrpqwl0fHlbpEsgcWrM
X-Gm-Message-State: AOJu0YzUdDbu+oJkBnkgYhjCC3CyQZJwsN+PxvgopoCW58/0RZmARsIE
	UTMEz6bKC0QRaynZr94Gufm1/WhV8LiiZO70xiaqjgcdPfZUGicOTD0HnZw7ZaM=
X-Google-Smtp-Source: AGHT+IHTfKmeAc2D7p/DFTZnK5Zo0Wq56sQd0cY51pqUlU0i0kwnRgZDU7hjzj/lw/o9qHMJkwJjVw==
X-Received: by 2002:a17:90b:4ad0:b0:2c1:ad46:7133 with SMTP id 98e67ed59e1d1-2c27dafd1d8mr891271a91.8.1717542032399;
        Tue, 04 Jun 2024 16:00:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28066cfe2sm57278a91.14.2024.06.04.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:00:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sEd8m-004X8n-37;
	Wed, 05 Jun 2024 09:00:28 +1000
Date: Wed, 5 Jun 2024 09:00:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com
Subject: Re: [PATCH] xfs: Fix file creation failure
Message-ID: <Zl+cjKxrncOKbas7@dread.disaster.area>
References: <20240604071121.3981686-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604071121.3981686-1-wozizhi@huawei.com>

On Tue, Jun 04, 2024 at 03:11:21PM +0800, Zizhi Wo wrote:
> We have an xfs image that contains only 2 AGs, the first AG is full and
> the second AG is empty, then a concurrent file creation and little writing
> could unexpectedly return -ENOSPC error since there is a race window that
> the allocator could get the wrong agf->agf_longest.
> 
> Write file process steps:
> 1) Find the entry that best meets the conditions, then calculate the start
> address and length of the remaining part of the entry after allocation.
> 2) Delete this entry. Because the second AG is empty, the btree in its agf
> has only one record, and agf->agf_longest will be set to 0 after deletion.
> 3) Insert the remaining unused parts of this entry based on the
> calculations in 1), and update the agf->agf_longest.
> 
> Create file process steps:
> 1) Check whether there are free inodes in the inode chunk.
> 2) If there is no free inode, check whether there has space for creating
> inode chunks, perform the no-lock judgment first.
> 3) If the judgment succeeds, the judgment is performed again with agf lock
> held. Otherwire, an error is returned directly.
> 
> If the write process is in step 2) but not go to 3) yet, the create file
> process goes to 2) at this time, it will be mistaken for no space,
> resulting in the file system still has space but the file creation fails.
> 
> 	Direct write				Create file
> xfs_file_write_iter
>  ...
>  xfs_direct_write_iomap_begin
>   xfs_iomap_write_direct
>    ...
>    xfs_alloc_ag_vextent_near
>     xfs_alloc_cur_finish
>      xfs_alloc_fixup_trees
>       xfs_btree_delete
>        xfs_btree_delrec
> 	xfs_allocbt_update_lastrec
> 	// longest = 0 because numrec == 0.
> 	 agf->agf_longest = len = 0
> 					   xfs_create
> 					    ...
> 					     xfs_dialloc
> 					      ...
> 					      xfs_alloc_fix_freelist
> 					       xfs_alloc_space_available
> 					-> as longest=0, it will return
> 					false, no space for inode alloc.

Ok, so this is a another attempt to address the problem Ye Bin
attempted to fix here:

https://lore.kernel.org/linux-xfs/20240419061848.1032366-1-yebin10@huawei.com/

> Fix this issue by adding the bc_free_longest field to the xfs_btree_cur_t
> structure to store the potential longest count that will be updated. The
> assignment is done in xfs_alloc_fixup_trees() and xfs_free_ag_extent().

I outlined how this should be fixed in the above thread:

https://lore.kernel.org/linux-xfs/ZiWgRGWVG4aK1165@dread.disaster.area/

This is what I said:

| What we actually want is for pag->pagf_longest not to change
| transiently to zero in xfs_alloc_fixup_trees(). If the delrec that
| zeroes the pagf_longest field is going to follow it up with an
| insrec that will set it back to a valid value, we really should not
| be doing the zeroing in the first place.
| 
| Further, the only btree that tracks the right edge of the btree is
| the by-count allocbt. This isn't "generic" functionality, even
| though it is implemented through the generic btree code. If we lift
| ->update_lastrec from the generic code and do it directly in
| xfs_alloc.c whenever we are finished with a by-count tree update
| and the cursor points to a record in the right-most leaf of the
| tree, then we run the lastrec update directly at that point. 
| By decoupling the lastrec updates from the individual record
| manipulations, we can make the transients disappear completely.

I'm not sure if this patch is an attempt to implement this - there
is no reference in the commit description to this previous attempt
to fix the issue, nor is the any discussion of why this particular
solution was chosen.

In future, when you are trying to fix an issue that has previously
been discussed/presented on the list, please reference it and
provide a link to the previous discussions in the changelog for the
new version of the patchset fixing the issue.

> Reported by: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  fs/xfs/libxfs/xfs_alloc.c       | 14 ++++++++++++++
>  fs/xfs/libxfs/xfs_alloc_btree.c |  9 ++++++++-
>  fs/xfs/libxfs/xfs_btree.h       |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 6c55a6e88eba..86ba873d57a8 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -577,6 +577,13 @@ xfs_alloc_fixup_trees(
>  		nfbno2 = rbno + rlen;
>  		nflen2 = (fbno + flen) - nfbno2;
>  	}
> +
> +	/*
> +	 * Record the potential maximum free length in advance.
> +	 */
> +	if (nfbno1 != NULLAGBLOCK || nfbno2 != NULLAGBLOCK)
> +		cnt_cur->bc_ag.bc_free_longest = XFS_EXTLEN_MAX(nflen1, nflen2);
> +

Why do we store the length of a random extent being freed here?
nflen1/2 almost always have nothing to do with the longest free
space extent in the tree, they are just the new free space extents
we are insering into a random location in the free space tree.

>  	/*
>  	 * Delete the entry from the by-size btree.
>  	 */
> @@ -2044,6 +2051,13 @@ xfs_free_ag_extent(
>  	 * Now allocate and initialize a cursor for the by-size tree.
>  	 */
>  	cnt_cur = xfs_cntbt_init_cursor(mp, tp, agbp, pag);
> +	/*
> +	 * Record the potential maximum free length in advance.
> +	 */
> +	if (haveleft)
> +		cnt_cur->bc_ag.bc_free_longest = ltlen;
> +	if (haveright)
> +		cnt_cur->bc_ag.bc_free_longest = gtlen;

That doesn't look correct. At this point in the code, ltlen/gtlen
are the sizes of the physically adjacent freespace extents that we
are going to merge the newly freed extent with. i.e. the new
freespace extent is going to have one of 4 possible values:

	no merge: len
	left merge: ltlen + len
	right merge: gtlen + len
	both merge: ltlen + gtlen + len

So regardless of anything else, this code isn't setting the longest
freespace extent in teh AGF to the lenght of the longest freespace
extent in the filesystem.

Which leads me to ask: how did you test this code? This bug should
have been triggering verifier, repair and scrub failures quite
quickly with fstests....

>  	/*
>  	 * Have both left and right contiguous neighbors.
>  	 * Merge all three into a single free block.
> diff --git a/fs/xfs/libxfs/xfs_alloc_btree.c b/fs/xfs/libxfs/xfs_alloc_btree.c
> index 6ef5ddd89600..8e7d1e0f1a63 100644
> --- a/fs/xfs/libxfs/xfs_alloc_btree.c
> +++ b/fs/xfs/libxfs/xfs_alloc_btree.c
> @@ -161,7 +161,14 @@ xfs_allocbt_update_lastrec(
>  			rrp = XFS_ALLOC_REC_ADDR(cur->bc_mp, block, numrecs);
>  			len = rrp->ar_blockcount;
>  		} else {
> -			len = 0;
> +			/*
> +			 * Update in advance to prevent file creation failure
> +			 * for concurrent processes even though there is no
> +			 * numrec currently.
> +			 * And there's no need to worry as the value that no
> +			 * less than bc_free_longest will be inserted later.
> +			 */
> +			len = cpu_to_be32(cur->bc_ag.bc_free_longest);
>  		}

So this is in the LASTREC_DELREC case when the last record is
removed from the btree. This is what causes the transient state
as we do this when deleting a record to trim it and then re-insert
the remainder back into the by-count btree.

Writing some random transient value into the AGF *and journalling
it* means we creating a transient on-disk format structure
corruption and potentially writing it to persistent storage (i.e.
the journal). The structure is, at least, not consistent in memory
because the free space tree is empty at this point in time, whilst
the agf->longest field says it has a free space available. This
could trip verifiers, be flagged as corruption by xfs_scrub/repair,
etc.

Now, this *might be safe* because we *may* clean it up later in the
transaction, but if this really is the last extent being removed
from the btree and a cursor has previously been used to do other
insert and free operations that set this field, then we trip over
this stale inforamtion and write a corrupt structure to disk. That's
not good.

As I said above, this "last record tracking" needs to be ripped out
of the generic btree code because only the by-count btree uses it.
Then it can be updated at the end of the by-count btree update
process in the allocation code (i.e. after all record manipulations
are done in the transaction) and that avoids this transient caused
by updating the last record on every btree record update that is
done.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

