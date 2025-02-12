Return-Path: <linux-kernel+bounces-511950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB8A331F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6254188AEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46162036EC;
	Wed, 12 Feb 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mSYW8ecC"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633972036E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397909; cv=none; b=KJHLiTZNeJJuQNdNYoqnDp0SNCOBB6LdRpj+4rzsdxKxF3XbxPA4sfIRRIcE01NP2hXoeEWKBMaRwPZqvhMr+vQBTBJK0kA4ovXzYUl5iIy6m3bIf6XuRuEoOCBLYA5NPZtA1gzPZL07jF/W7NcK4NXUqorU8d90Kau94rWCD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397909; c=relaxed/simple;
	bh=zGVpl8n55w3rZkyXu3E9I/tHyowOiknjat3168lD8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9dnjVZwGy+7OHFLhCtFVROd6X5IFoYlTgjpLxr30iPePBNNLqJ24/vl1o0WS1gNTFMXTPUZqnLnZOB+QjXQ5lpZbKaBan9p0dCwIYEFSr6H9UY+ub7UoDX64sNsqBIZwysFoWo9aIa8GGRVHVe97VKJbSfWA8s4Xb6Y7NJEiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mSYW8ecC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f44e7eae4so2575525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739397906; x=1740002706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XCi8o5nbhzJMV9v1B7KNxIu4y6qFg4L3G4NF5nqO6E=;
        b=mSYW8ecC3HLKOVDCFgiK7PEDWMVS5vpIKJSHy79qI0dU+au7xw1Dl3XbgIzDdiGR+c
         q3xY0c8b/SXV+OYKkXCV5cO8Ciw+VykTwKarCxU0FtNa6H7ALBWqMPo9FSIwsySX+QID
         ciFzevk3DCAbgZENM5HEtZgWB1CNgZQwrqrGuxOOFfXIfmD5DSSiiWjxU56AHBvqBkyM
         m9NWQlDhXyRT4UnyMT7waSCntLl5MuGvCjZNJIr3j1LcblRAmC8Z0o1gWWjf3VFG0wHH
         raotsshRG1aid1wOuW2nbYZaBZjXt+m3eYQDTPT186FlqXLZ1aJU00FxCosiYwGXCESc
         0aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739397906; x=1740002706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XCi8o5nbhzJMV9v1B7KNxIu4y6qFg4L3G4NF5nqO6E=;
        b=PaqsDeF+EVMfpWmTnL//crK3VJJ8RQ/qi6Zfi7MyKlwZBbu+49fsfosUimWTyU3xKN
         zmLNRFFvQ9Qf5HYpnHlvUII431DV4YcdHxWkb+LtHEFw5eP576C7v5+WfmafFVf5riWy
         pe4FVidj+5wG9UOu1EX2Q0OJ+vx/n4lGCjPeKLG2XhqNqIu3TxojAf1JhICD7LnUJzoH
         WOxJKIGUlRCCaz+J4OMmkqVUrmCGA5SihWyV5pYNAvaGquzRb56LlIirdodD9Y+vpwpn
         PQU/IHzkAbaFiLCydhWVQh/55JiuBCb5NqU4wP4eD+6iaJihiIscCsd5ajYJ+MDACa0C
         +CmA==
X-Forwarded-Encrypted: i=1; AJvYcCUSy1W2o1pACaTWdyQ8WB6ay5DPBxJAqBygrTp/Lz6PSXQiodmy6sAX9AQ0ku13OUPiC3AHUBtkcu1JE4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdmt6otV6v4yyjb+4hnU0gIdItRgiQIiSoTqOtXFcoDPP+g4bA
	t+gg3z3/wTn+HIKSP/FerNUNEsxhLvhCcft1XmUu82yyEmEbfZFZZ0iZu9ORADE=
X-Gm-Gg: ASbGncv7NyKNZMvF2GCJKpBynZKNH9ewSsoRgx+71jp2+2kqqBdVV1DcoHY611+qgvN
	lFx1cPtY+yhxcAphlOw8HKmpoNR1D6RrCS1+cU0MzRsvqsG4YwxeTtY7eElxW/+o9WHulr7yhrD
	UDDGwCO8d8y04jIp5ROE3oATzNQMs3AteG2DDpdYpXSECX4wDSWhz9QONdJO7BufBFxDycDFz55
	UsnaRMu90RcR/YkQc4kfe+STwO+6m7bLMYAQwmZ+5dNwEDUBIPFxlxQQbCbUAMA/S6OM/Tv5Bne
	G3Dp/0B0G/JujmFVCQ8OQUi1uC+d5QtfmExQEa88FeHmb/0B5I7AVcd2XPEdHCDhNs4=
X-Google-Smtp-Source: AGHT+IFrP5VrQystnNJ+ooLZEJ/4rrx66H7ZKv4mf+V/qEJbSpjK/r7Ct1fjNvyVBor+q4OHEqB9zQ==
X-Received: by 2002:a05:6a00:348c:b0:728:9d19:d2ea with SMTP id d2e1a72fcca58-7322c39d1c2mr8112737b3a.13.1739397906573;
        Wed, 12 Feb 2025 14:05:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73077975f05sm8292722b3a.14.2025.02.12.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:05:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiKqt-00000000SO1-2Qic;
	Thu, 13 Feb 2025 09:05:03 +1100
Date: Thu, 13 Feb 2025 09:05:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v4] fuse: add new function to invalidate cache for all
 inodes
Message-ID: <Z60bD3C_p_PHao0n@dread.disaster.area>
References: <20250211092604.15160-1-luis@igalia.com>
 <Z6u5dumvZHf_BDHM@dread.disaster.area>
 <875xlf4cvb.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xlf4cvb.fsf@igalia.com>

On Wed, Feb 12, 2025 at 11:32:40AM +0000, Luis Henriques wrote:
> On Wed, Feb 12 2025, Dave Chinner wrote:
> 
> > [ FWIW: if the commit message directly references someone else's
> > related (and somewhat relevant) work, please directly CC those
> > people on the patch(set). I only noticed this by chance, not because
> > I read every FUSE related patch that goes by me. ]
> 
> Point taken -- I should have included you on CC since the initial RFC.
> 
> > On Tue, Feb 11, 2025 at 09:26:04AM +0000, Luis Henriques wrote:
> >> Currently userspace is able to notify the kernel to invalidate the cache
> >> for an inode.  This means that, if all the inodes in a filesystem need to
> >> be invalidated, then userspace needs to iterate through all of them and do
> >> this kernel notification separately.
> >> 
> >> This patch adds a new option that allows userspace to invalidate all the
> >> inodes with a single notification operation.  In addition to invalidate
> >> all the inodes, it also shrinks the sb dcache.
> >
> > That, IMO, seems like a bit naive - we generally don't allow user
> > controlled denial of service vectors to be added to the kernel. i.e.
> > this is the equivalent of allowing FUSE fs specific 'echo 1 >
> > /proc/sys/vm/drop_caches' via some fuse specific UAPI. We only allow
> > root access to /proc/sys/vm/drop_caches because it can otherwise be
> > easily abused to cause system wide performance issues.
> >
> > It also strikes me as a somewhat dangerous precendent - invalidating
> > random VFS caches through user APIs hidden deep in random fs
> > implementations makes for poor visibility and difficult maintenance
> > of VFS level functionality...
> 
> Hmm... OK, I understand the concern and your comment makes perfect sense.
> But would it be acceptable to move this API upper in the stack and make it
> visible at the VFS layer?  Something similar to the 'drop_caches' but with
> a superblock granularity.  I haven't spent any time thinking how could
> that be done, but it wouldn't be "hidden deep" anymore.

I'm yet to see any justification for why 'user driven entire
filesystem cache invalidation' is needed. Get agreement on whether
the functionality should exist first, then worry about how to
implement it.

> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >> * Changes since v3
> >> - Added comments to clarify semantic changes in fuse_reverse_inval_inode()
> >>   when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
> >> - Added comments to inodes iteration loop to clarify __iget/iput usage
> >>   (suggested by Joanne)
> >> - Dropped get_fuse_mount() call -- fuse_mount can be obtained from
> >>   fuse_ilookup() directly (suggested by Joanne)
> >> 
> >> (Also dropped the RFC from the subject.)
> >> 
> >> * Changes since v2
> >> - Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
> >> - Also updated patch description as per checkpatch.pl suggestion.
> >> 
> >> * Changes since v1
> >> As suggested by Bernd, this patch v2 simply adds an helper function that
> >> will make it easier to replace most of it's code by a call to function
> >> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
> >> 
> >> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
> >
> > That doesn't make the functionality any more palatable.
> >
> > Those iterators are the first step in removing the VFS inode list
> > and only maintaining it in filesystems that actually need this
> > functionality. We want this list to go away because maintaining it
> > is a general VFS cache scalability limitation.
> >
> > i.e. if a filesystem has internal functionality that requires
> > iterating all instantiated inodes, the filesystem itself should
> > maintain that list in the most efficient manner for the filesystem's
> > iteration requirements not rely on the VFS to maintain this
> > information for it.
> 
> Right, and in my use-case that's exactly what is currently being done: the
> FUSE API to invalidate individual inodes is being used.
>
> This new
> functionality just tries to make life easier to userspace when *all* the
> inodes need to be invalidated. (For reference, the use-case is CVMFS, a
> read-only FS, where new generations of a filesystem snapshot may become
> available at some point and the previous one needs to be wiped from the
> cache.)

But you can't actually "wipe" referenced inodes from cache. That is a
use case for revoke(), not inode cache invalidation.

> > I'm left to ponder why the invalidation isn't simply:
> >
> > 	/* Remove all possible active references to cached inodes */
> > 	shrink_dcache_sb();
> >
> > 	/* Remove all unreferenced inodes from cache */
> > 	invalidate_inodes();
> >
> > Which will result in far more of the inode cache for the filesystem
> > being invalidated than the above code....
> 
> To be honest, my initial attempt to implement this feature actually used
> invalidate_inodes().  For some reason that I don't remember anymore why I
> decided to implement the iterator myself.  I'll go look at that code again
> and run some tests on this (much!) simplified version of the invalidation
> function your suggesting.

The above code, while simpler, still doesn't resolve the problem of
invalidation of inodes that have active references (e.g. open files
on them). They can't be "invalidated" in this way - they can't be
removed from cache until all active references go away.

i.e. any operation that is based on the assumption that we can
remove all references to inodes and dentries by walking across them
and dropping cache references to them is fundamentally flawed. To do
this reliably, all active references have to be hunted down and
released before the inodes can be removed from VFS visibility. i.e.
the mythical revoke() operation would need to be implemented for
this to work...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

