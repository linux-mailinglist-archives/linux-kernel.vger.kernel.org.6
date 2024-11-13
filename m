Return-Path: <linux-kernel+bounces-408390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2669C7E32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D72844FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F218C012;
	Wed, 13 Nov 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QBjvm2BV"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BD7081D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536640; cv=none; b=nM2L7XrP/n5A5BuKXjOFXft3FeQm7enmPiIQGuXSwFvBWPaaFIKfzYc7Kb6CxYCl70HElECmk2BqYgNgy7NTT5TsEh5w8YCRg5uQOhDoUwiKe/r213mvkNTgmi+q7IxsAESSfWPGXH9O3e/DW/P1HgrwaePZtlJ3tfL6GUT+o4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536640; c=relaxed/simple;
	bh=TgLSM3kw/IESz6YfA/6CcM0kRm8NHR70/vlEMxjDpdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcMpGSZyk64UauDlC3WVqsohIrx5NySceCmVmGSSzC7oQ5au2Eqs5QQjhFGMgGPeTaCsKwJNl3Yakc6OAq5ZasLpx/wGNv8RHBED9IQqJWAk1DKZKRkXOAwSw139NMNaIKdXeLZE4FHsA/ArABfyX2Q5k8ZOfPsiwgeqCR1t23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QBjvm2BV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so5654942a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731536637; x=1732141437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhU1DTFWsUZULhpNS1f0hFA10SN7OegQFOrkLjd72jU=;
        b=QBjvm2BVQ3a+mq5FYbcfSBvesRgnlh5smymbDA4YWvSZXW2869GBssZrpDlEzJFv/Q
         5FY6Ii7+kqEvJp5IMTEOadDoHWwDjmGijvU7XbGmuULfIL1HBY6UrBzEZQlHtspAoVZX
         E8impMf1ikl6/VN4e09SEA91gSn4xG/DMbadkA2zhvz5f7dKzFMNZcWbBJRzO1QmgTwB
         wWAhkF0uWT7IGjWbIMyyQY19WVfH+EgOvE62UjQcOA1d8HxkMU55ladkeHcXqxrGzw2p
         LJ5IhVC8jtWfZHejGuIyuqXtlbg3QaWRJzHZ10QGegwT8ylV+VP8FDSswszIloVmqrMp
         quMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536637; x=1732141437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhU1DTFWsUZULhpNS1f0hFA10SN7OegQFOrkLjd72jU=;
        b=PmcP2sSOFWGPGRmP4lo25MLUwW/7z8iYIA38njkjbJm+ssyRYLkht2fLtRajyUPW5q
         Be+RWGE8nNXfJQqDuF1UjhHINS4QSqzSxp9cRzZnawmekc9wR1f9pOxeYVxOzz2D3Pgk
         CLL6S5B1XzA6rGobiUF+TILaEiB4RZhc5jLmC7N8MuKiYQca3Y/NiZDcSGq+8aGmUuOs
         xRKHKVxvlVc/u5jcWzNBPXPy9/pm+16gOKv1HyC783qp7G2/7z3WRdx5JimBwCydCKep
         gEIuIQvA1Q/xZhS6QR43H1Wkb0GDECXJIBCMmhgS0Jox5EvYXeA6+ugq6dY7Pdadkod5
         ERKw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4ppq2sI10C/L5lNah+rzZANSNNerGgqOgmI1Lclt7jw7Js1wDMh23t/OZk61Tcght/a7W36HuN70qmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8i13ijWiTb+RZ69XD9PNOO6bda9FtQx8oDvyYVdOq5EeemA7Q
	ye2j92hxTKmujIo9zjCFHU1C0lZldnNBmk3AnXlU/6SNm3yws04o7Q02tQ7Krns=
X-Google-Smtp-Source: AGHT+IFp+u01htZ7+R4q0w8zY+0n6pwR7q3KOwbId/6FUz/GheGxoVBPUTfGzcZ0P6rKeXYjD5vOXg==
X-Received: by 2002:a05:6a20:748b:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1dc2292c2a4mr30095003637.11.1731536630122;
        Wed, 13 Nov 2024 14:23:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f7127f3b01sm2017218a12.84.2024.11.13.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 14:23:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tBLm6-00EGof-0x;
	Thu, 14 Nov 2024 09:23:46 +1100
Date: Thu, 14 Nov 2024 09:23:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alex Shi <seakeel@gmail.com>, linux-xfs@vger.kernel.org,
	Linux-MM <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: xfs deadlock on mm-unstable kernel?
Message-ID: <ZzUm8jiGmyDVyEwX@dread.disaster.area>
References: <e5814465-b39a-44d8-aa3d-427773c9ae16@gmail.com>
 <Zou8FCgPKqqWXKyS@dread.disaster.area>
 <20241112171428.UqPpObPV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112171428.UqPpObPV@linutronix.de>

On Tue, Nov 12, 2024 at 06:14:28PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-07-08 20:14:44 [+1000], Dave Chinner wrote:
> > On Mon, Jul 08, 2024 at 04:36:08PM +0800, Alex Shi wrote:
> > >   372.297234][ T3001] ============================================
> > > [  372.297530][ T3001] WARNING: possible recursive locking detected
> > > [  372.297827][ T3001] 6.10.0-rc6-00453-g2be3de2b70e6 #64 Not tainted
> > > [  372.298137][ T3001] --------------------------------------------
> > > [  372.298436][ T3001] cc1/3001 is trying to acquire lock:
> > > [  372.298701][ T3001] ffff88802cb910d8 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_reclaim_inode+0x59e/0x710
> > > [  372.299242][ T3001] 
> > > [  372.299242][ T3001] but task is already holding lock:
> > > [  372.299679][ T3001] ffff88800e145e58 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock_data_map_shared+0x4d/0x60
> > > [  372.300258][ T3001] 
> > > [  372.300258][ T3001] other info that might help us debug this:
> > > [  372.300650][ T3001]  Possible unsafe locking scenario:
> > > [  372.300650][ T3001] 
> > > [  372.301031][ T3001]        CPU0
> > > [  372.301231][ T3001]        ----
> > > [  372.301386][ T3001]   lock(&xfs_dir_ilock_class);
> > > [  372.301623][ T3001]   lock(&xfs_dir_ilock_class);
> > > [  372.301860][ T3001] 
> > > [  372.301860][ T3001]  *** DEADLOCK ***
> > > [  372.301860][ T3001] 
> > > [  372.302325][ T3001]  May be due to missing lock nesting notation
> > > [  372.302325][ T3001] 
> > > [  372.302723][ T3001] 3 locks held by cc1/3001:
> > > [  372.302944][ T3001]  #0: ffff88800e146078 (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: walk_component+0x2a5/0x500
> > > [  372.303554][ T3001]  #1: ffff88800e145e58 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock_data_map_shared+0x4d/0x60
> > > [  372.304183][ T3001]  #2: ffff8880040190e0 (&type->s_umount_key#48){++++}-{3:3}, at: super_cache_scan+0x82/0x4e0
> > 
> > False positive. Inodes above allocation must be actively referenced,
> > and inodes accees by xfs_reclaim_inode() must have no references and
> > been evicted and destroyed by the VFS. So there is no way that an
> > unreferenced inode being locked for reclaim in xfs_reclaim_inode()
> > can deadlock against the refrenced inode locked by the inode lookup
> > code.
> > 
> > Unfortunately, we don't have enough lockdep subclasses available to
> > annotate this correctly - we're already using all
> > MAX_LOCKDEP_SUBCLASSES to tell lockdep about all the ways we can
> > nest inode locks. That leaves us no space to add a "reclaim"
> > annotation for locking done from super_cache_scan() paths that would
> > avoid these false positives....
> 
> So the former inode (the one triggering the reclaim) is created and can
> not be the same as the one in reclaim list. Couldn't we assign it a
> different lock-class?

We've done that in the past. The problem with that is we lose lock
ordering verification across reclaim. i.e. inode lock ordering must
be the same both above and below reclaim, and changing the lock
class loses the ability to verify this.

This is important to us as some code (e.g. extent removal) can be
called from both above and below reclaim, and they require the same
transaction and inode lock contexts to be held regardless of where
they are called from...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

