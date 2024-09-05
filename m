Return-Path: <linux-kernel+bounces-317903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF496E546
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903401F2791F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154F1AF4ED;
	Thu,  5 Sep 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AM/3Te74"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F921A724A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572851; cv=none; b=liZBk2dZMyGJlkNCsxJ5NBReIf3W1nlg1FVVNIHPLtonVDwqQL03MGax/pjAxhj48L1o8/O3a+rLG8ufzVGg5VxO928+l3OnP/Ez25Fa+i0Cq7AEGpMyT8g6dcF6a/izDR+5QEqfk/yjUNB12h8XWuYityspXOteGgLUXkUJ264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572851; c=relaxed/simple;
	bh=i0UOLszZ08xbkKnNss4rxGidGxMtshSELEYiMtpJsAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m10axYCS+jrS2PRcN4XtuDmuOaMhua0l7Y88m/O7N5NKqZdbcMqT31G1JHMPLXkoeyAJVRlBrpTFm5J8fB/kF5PfeFqqg4XoRLR6zqUajShoSxVLPuXzS/Se0HnXa+QjXxxvLu8dzMNIxCQ8z50v0VTwNOGbAraJk8kXEhOldFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AM/3Te74; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20536dcc6e9so9792095ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725572849; x=1726177649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hB1tfzvGqDohT1t5kqG0/BoXV4hNHXK08f2dliq9E5c=;
        b=AM/3Te74MfuKJtGMpXeBv585oyw355qnw1uuAo+L2GK6X+Ed5uO1Fcl3cwGC0rwmGa
         9IYl3D8QJJr1hsWO3WvGks3a/TnGnH5u4hfqHuH25wG6M7DEYXFr6Zj4Ztf/gSLPVKFy
         abfL4qLMQHWk1AlU/BLFRpu17n1dIppwHyesa//myALWY51V7kLiqpFDL02c5nvTewy9
         cdsNbllhlepOTHn1Xenp6QUGuvUY9WKsVtZ8QbFIR4QHFzGeYRYdZ8EjzfEsMX5FzdVJ
         TqOXXERoEF4Ta34OPs/Ha9x0xo6q7AtajV5jEt68rSs6E8qlKufHz5X4feRfxUzhLNx/
         VFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725572849; x=1726177649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB1tfzvGqDohT1t5kqG0/BoXV4hNHXK08f2dliq9E5c=;
        b=dFEkaApOuu1ALLwYbTSDJPShf1R8xMcQnO9exhJamMA+KCSdJOQQ9RhyDHdC0GozPm
         j4vSTKHrwAqvpyGQpu79kL3nzauynaTpyjpW4Yo5kChxUDn7PLLGvVCJI0La4Vdv7phF
         pWHgka230cKwnBx/hYfuI2ncv5CLhv4LDzmHOSyOy0VbqKL7TKzSjFyu6jrtP96rBopN
         QIRhV+XYrozhmZRs1JpJ52Cy9pvLuhSWT46In6J5MsIDIhfJt0sOteT72545892A0icF
         V+t3GllpJT0uMorXoObclxVorlE2jnXk08rSjrNFYKpYjovG6BvSGz6W7a0Pnl5hIwkO
         ZVew==
X-Forwarded-Encrypted: i=1; AJvYcCUE0op/ifbTqXQ6YhFU2K7enx+i80tLw3TjicWCSkG7Dyl3KDI/o/YAKDNUwNIs+smVJ43ABfA90dztcRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVBtaKVfPk6J5KPrsaBUo3w4J/FflgTvVTHdW7walPoJMF9eL
	Z/JLTgQkpU4OPkfHRLqnikN/28nhzxRqTDGnTpXIjgSIMZ3NS5irezj6XrckpZM=
X-Google-Smtp-Source: AGHT+IHW1qkkMGd7aAakdsHaXQLUN2sqd1dppj81Yx0AkFn4FNYXzftRyCfRbZSCa5Eh4tky41vb6w==
X-Received: by 2002:a17:902:c40e:b0:202:4640:cc68 with SMTP id d9443c01a7336-2050c48fb65mr250217535ad.59.1725572848921;
        Thu, 05 Sep 2024 14:47:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea94b99sm32720895ad.279.2024.09.05.14.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:47:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1smKK2-001Ja3-2r;
	Fri, 06 Sep 2024 07:47:22 +1000
Date: Fri, 6 Sep 2024 07:47:22 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <Ztom6uI0L4uEmDjT@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>

On Thu, Sep 05, 2024 at 11:15:41AM +0100, John Garry wrote:
> > >     - Does the unmapping of extents also only happens in extsize
> > >     chunks (with forcealign)?
> > 
> > Yes, via use of xfs_inode_alloc_unitsize() in the high level code
> > aligning the fsbno ranges to be unmapped.
> > 
> > Remember, force align requires both logical file offset and
> > physical block number to be correctly aligned, so unmap alignment
> > has to be set up correctly at file offset level before we even know
> > what extents underly the file range we need to unmap....
> > 
> > >       If the start or end of the extent which needs unmapping is
> > >       unaligned then we convert that extent to unwritten and skip,
> > >       is it? (__xfs_bunmapi())
> > 
> > The high level code should be aligning the start and end of the
> > file range to be removed via xfs_inode_alloc_unitsize().
> 
> Is that the case for something like truncate? There we just say what is the
> end block which we want to truncate to in
> xfs_itruncate_extents_flags(new_size)  ->
> xfs_bunmapi_range(XFS_B_TO_FSB(new_size)), and that may not be alloc unit
> aligned.

Ah, I thought we had that alignment in xfs_itruncate_extents_flags()
already, but if we don't then that's a bug that needs to be fixed.

We change the space reservation in xfs-setattr_size() for this case
(patch 9) but then don't do any alignment there - it relies on
xfs_itruncate_extents_flags() to do the right thing w.r.t. extent
removal alignment w.r.t. the new EOF.

i.e. The xfs_setattr_size() code takes care of EOF block zeroing and
page cache removal so the user doesn't see old data beyond EOF,
whilst xfs_itruncate_extents_flags() is supposed to take care of the
extent removal and the details of that operation (e.g. alignment).

Patch 10 also modifies xfs_can_free_eofblocks() to take alignment
into account for the post-eof block removal, but doesn't change
xfs_free_eofblocks() at all. i.e  it also relies on
xfs_itruncate_extents_flags() to do the right thing for force
aligned inodes.

In this case, we are removing post-eof speculative preallocation
that that has been allocated by delalloc conversion during
writeback.  These post-eof extents will already be unwritten extents
because delalloc conversion uses unwritten extents to avoid
stale data exposure if we crash between allocation and the data
being written to the extents. Hence there should be no extents to
convert to unwritten in the majority of cases here.

The only case where we might get written extents beyond EOF is if
the file has been truncated down, but in that case we don't really
care because truncate should have already taken care of post-eof
extent alignment for us. xfs_can_free_eofblocks() will see this
extent alignment and so we'll skip xfs_free_eofblocks() in this case
altogether....

Hence xfs_free_eofblocks() should never need to convert a partial
unaligned extent range to unwritten when force-align is enabled
because the post-eof extents should already be unwritten. We also
want to leave the inode in the most optimal state for future
extension, which means we want the post-eof extent to be correctly
aligned.

Hence there are multiple reasons that xfs_itruncate_extents_flags()
should be aligning the post-EOF block it is starting the unmapping
at for force aligned allocation contexts. And in doing so, we remove
the weird corner case where we can have an unaligned extent state
boundary at EOF for atomic writes....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

