Return-Path: <linux-kernel+bounces-520514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C08A3AAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC175171D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C801CDA0B;
	Tue, 18 Feb 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QVHIUM6F"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4B1CAA6C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914200; cv=none; b=oPNwjZnTJjpSoSijCxMsA2jqvDNLLntOH7HfzeydMsikVT150LNBUoh/5gJhcGjGMQDM+hGTNUhX3fCZEQCGOjjgl7qBeBMhfRjUrA07PXtEL8YyqIyTE89B9DdDgxrfTiME0DjNZB+q6q+n9E91MGT+TDbgu/V1skluYVV6V5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914200; c=relaxed/simple;
	bh=zJlUKOAUMzRwSMd0RyUaRL4qi8n/irFI0ZisgXVoNeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzVeslM7JRF5CUP/f1cGQHYfY9UxL0upo8U2Ln1lDJSGd9kfEA/5FmGDu1kKwWEZyuqq82N9uPipCFvThCCVcCrlo08eTBoj3ieZXNC9emPwo/NQan443HZWYBtlFlS8u8X3OAoiF7GYr6ivB7uvPjq22cPz6N4W6LtcY85APuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QVHIUM6F; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f441791e40so8804939a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739914198; x=1740518998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAWzpG6ORdf2NB5VGRikJxcn275RHvR6uS8CPCH19no=;
        b=QVHIUM6F6SfDY/s0h4ftbTNxI/bY3Iy2Su0CTtV9+CjQoPyScTNBXSQPTvbp3QALhK
         FQLRFzr9TnYZ06sNCph+SeRjVfSUlc3Qtw1FPEZ+3iUe8yYz6qG8lv16rdZYhcK8+VRG
         X2ZQW3atxz2Alu2KyPlskIDuN5ljzW79Wruqu+LVwjBijZ9a9vDcfbA005ha7BIgzii2
         wDwK4tNZhxnrl6CVuJn2oUg9RJUVw/3B6W8vxZAiLrjmhgI4ApURt/snUleZtNplTbMs
         irqDY4iKPOxHdQXgUXKe8Hn2RsUZTrRM3zBI2RwruZQs/FQDkpWbmScQpjRP9092wuoC
         xbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914198; x=1740518998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAWzpG6ORdf2NB5VGRikJxcn275RHvR6uS8CPCH19no=;
        b=VySAr64DehxNv9+Gu48EvsB4JP3iaXUo614DHBuo0IShaR6ZUpWOYF6/h8cnCwvzjZ
         z5eAky42/YHHbdSLzn/iGBdpOxv9K2MHpjMyTYRAL16TQYwlHTes66pCo+bhadgHR5jQ
         C1t9N1Z3WJRgwmRFCwuE+4mMwZPb/pudMe8oJ1tpyh4FI5eYP940MaK9BcGKjTqbZQcj
         L9HDjuxeEuoVMpJBwN5epVx2AghJWUxVPsC2zAIfZJhvtLy4//TYCBSJ6Y+X3OEc5Kw8
         baNGmg87mbtqlSUiybVoVUqPQYSlWLLEFGidipaeBZwVxtLmDm/mTxpAKvX14wkYoxdF
         9Adw==
X-Forwarded-Encrypted: i=1; AJvYcCVcmX+u/Or8JW99ZurV1g0YcJyBh5og3iD+sYDg8/L7FI84kd1LQ9tRHsdmHLZeC+PPpZnx1U3QIUdIhsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJxVid2PZS1ai+f8aBx2Hz4nejD7uv80jhSUyUvbi7gwa31cz
	geLnlX1btugUo0n5VqO34cP/KUrsjKaGZjXnELQorOSA1I2tOxR5jRwR8+w8700=
X-Gm-Gg: ASbGnctxCerw5kYr/vLjhj54+n8EhCgtgJJfFFE7UZozUi1ll8mDMt9lo82yEtBPWk5
	5xvO+hdc7sMiThQbEz77aejAKXbzwgmGI/tNagnqA0KsV2uUoEshd3Hl5xadLo5f66fTIen1f49
	UpH28D3h3/Ck6r8VGenjo+W9uiHpYsT80QjW8Aw6jujsxFuTpgoA5VxswWjlumnZHOEl65Sa5cE
	I3PqGMEKC+zvfICGlLX/pWe+0ftG59yiT63gS807n6jP13i8bAtgUkvE0qcOgEsRckrecfjRRso
	EehY+ggZ84JnE7oC+D04mrboNBkh3ifMhoNcGYEVLQHyw1tsliJoNDl63vg65vgeF5w=
X-Google-Smtp-Source: AGHT+IFsDxlRvdIHUMdfATA7aggYZogjQzj0emcIGs5vaQZXVtkP6MaG2piZDQjD376zdlUwOm4ZWA==
X-Received: by 2002:a17:90b:2d8d:b0:2ee:f076:20fb with SMTP id 98e67ed59e1d1-2fc40f22db2mr27056073a91.17.1739914198573;
        Tue, 18 Feb 2025 13:29:58 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ab127esm10352120a91.1.2025.02.18.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:29:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkVAA-00000002yDu-2Zih;
	Wed, 19 Feb 2025 08:29:54 +1100
Date: Wed, 19 Feb 2025 08:29:54 +1100
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valentin Volkl <valentin.volkl@cern.ch>,
	Laura Promberger <laura.promberger@cern.ch>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
Message-ID: <Z7T70iOiyAKIu9W3@dread.disaster.area>
References: <20250217133228.24405-1-luis@igalia.com>
 <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area>
 <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com>
 <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
 <87frkb8o94.fsf@igalia.com>
 <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>

On Tue, Feb 18, 2025 at 03:26:24PM +0100, Miklos Szeredi wrote:
> On Tue, 18 Feb 2025 at 12:51, Luis Henriques <luis@igalia.com> wrote:
> >
> > On Tue, Feb 18 2025, Miklos Szeredi wrote:
> >
> > > On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:
> > >
> > >> The problem I'm trying to solve is that, if a filesystem wants to ask the
> > >> kernel to get rid of all inodes, it has to request the kernel to forget
> > >> each one, individually.  The specific filesystem I'm looking at is CVMFS,
> > >> which is a read-only filesystem that needs to be able to update the full
> > >> set of filesystem objects when a new generation snapshot becomes
> > >> available.
> > >
> > > Yeah, we talked about this use case.  As I remember there was a
> > > proposal to set an epoch, marking all objects for "revalidate needed",
> > > which I think is a better solution to the CVMFS problem, than just
> > > getting rid of unused objects.
> >
> > OK, so I think I'm missing some context here.  And, obviously, I also miss
> > some more knowledge on the filesystem itself.  But, if I understand it
> > correctly, the concept of 'inode' in CVMFS is very loose: when a new
> > snapshot generation is available (you mentioned 'epoch', which is, I
> > guess, the same thing) the inodes are all renewed -- the inode numbers
> > aren't kept between generations/epochs.
> >
> > Do you have any links for such discussions, or any details on how this
> > proposal is being implemented?  This would probably be done mostly in
> > user-space I guess, but it would still need a way to get rid of the unused
> > inodes from old snapshots, right?  (inodes from old snapshots still in use
> > would obvious be kept aroud).
> 
> I don't have links.  Adding Valentin Volkl and Laura Promberger to the
> Cc list, maybe they can help with clarification.
> 
> As far as I understand it would work by incrementing fc->epoch on
> FUSE_INVALIDATE_ALL. When an object is looked up/created the current
> epoch is copied to e.g. dentry->d_time.  fuse_dentry_revalidate() then
> compares d_time with fc->epoch and forces an invalidate on mismatch.

That was what I was going to suggest before I got this far in the
thread. i.e. the fs itself keeps a current snapshot ID, and it keeps
track of what snapshot ID each inode was instantiated for. On access
to the inode it checks the IDs and if they don't match, the inode
needs revalidation and then the fs can take appropriate action.

This also takes care of the active inode reference problem that
invalidation has, in that it can revoke access to inodes that are
not longer valid as soon as they are accessed by userspace.

It is also entirely internal to the filesystem (as I suggested such
functionality should be earlier in the thread) and does not require
walking the VFS to find all cached inodes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

