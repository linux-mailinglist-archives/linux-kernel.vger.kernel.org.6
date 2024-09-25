Return-Path: <linux-kernel+bounces-338000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28B98521D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D152854C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB51514EE;
	Wed, 25 Sep 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="y2ONp+8Z"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32A14E2C2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239401; cv=none; b=n93louZId3LojNOxG4J7bbQHaa8893iaCFBt5FrG2wMPSGPFj2zEdr9EaW0s7eZmlJE01WJY1DrHWL/6ta+dpV7fHUz9t9n3kQ7qbMQJQbK5W5GNlzw4TSVo1zRxVOakMbcnk2BznQwRsu+izL2GRVy0J+7L6r93bbqYPwwgWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239401; c=relaxed/simple;
	bh=qP0kef26kQPsF+VA/SMAjgnOAlbYGhUGrzVnLP/9vuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEYH0S5xl4+pxc/yjlaOShVxKiSITaZkzfqcdBOLFt4oZyC04rI2Wu0Df1aaAvSSbLHBup5Ae0D3nmFlk2Qjf1MSKMV4jBFzKygSKOnWzIH0+ZnQNhG+HpTLV0AdTqRE7RQBkgJjzIOov6N/tVDC/zJif0htcB2No2VT1V730EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=y2ONp+8Z; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7179069d029so4559337b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727239399; x=1727844199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ctMQwyxvYW5cU0FTjFHtu9oqwY7oBq1xwTy/5WDdZY=;
        b=y2ONp+8ZaKTFdpCCfyhDY5/lynU6TjpC7znosQffexzpFt8oB5+Xj3u6YOpWHezifn
         MDthu91OG8IfO1wivN5WVuMOgrBTCQxziCwkjpgpSKZPnCRZZOjuToRrtW8yBAc/8SJQ
         PleJeYa9SGyXmGzgS8WOZf8n5YJz3C7ZMkJVpTHUtJszTv5aZKskXQ2U2r3VNGA7VPYb
         qaydvqb7rUsxVZjaq4SSRGCeVDOtaQy9nize+hPGy8xncgbCMRdmNX6t6KNhpTH8jmGn
         xKNY61k8P1RdnmAaOeODHqWmQ+l8jMSuZkBlXVHRMGFWENEnmMX5llFMzI/0YzqJUcPR
         MZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727239399; x=1727844199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ctMQwyxvYW5cU0FTjFHtu9oqwY7oBq1xwTy/5WDdZY=;
        b=iLunlimcVs+0xgCcyMNtI7SwJ9jE/f2lYC7T8d39uls57KH2OPWIcFdcOBBhVk3Kxd
         WUPrdDQh31MK6rwypPzY1WWEpbDwkh383wXHggYfH7qPRC4+T3oEUzWUmqhWcwZgQjCR
         Jlbtdvn+WDWQmLuzd8CxcHejyU9pkjdS3kJZJPvr2NWe/SSzhMe3zSHAWHXGP+TADr0w
         R3f/4bQ2MlwTpeCvljtFdi+bihvso3kVvXN2MHjlcOzo/91+oGPJiSC90xi6bhE8K3le
         i/r7LG5TOnCgqGP7hlwzdtHeXeuy1opGyK7rwgwnJdK0Wg3HSvpB/s/OBAIJkTXxaRvW
         Zeyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6qwqOOma8tCDuD1D3+HvoNG1i8m+dFZ7/s9i8Yy7suleMCJcEP9a1CG7sklIv5tF5FpJiJA56PPA6ANM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxNOHNOYTrXGfc/fS8ul2CsCxbHDGnZ0CZWbePWSHCZNykJvB
	DYQyYj+tQe3JgVR+rzzIs86BGfs4iADuy4PF27WeeBZ3A2ZwIpvoUf4tAqLKb7U=
X-Google-Smtp-Source: AGHT+IG1A2fxT0leRXWaPVBB9fYSXncgAvqsoTY/xO32m/SZoyOWVXDvdfT9Fkdxv8hNtpzXIk1EaQ==
X-Received: by 2002:a05:6a00:1412:b0:719:8667:a5d4 with SMTP id d2e1a72fcca58-71b0aab43f7mr2125401b3a.9.1727239398658;
        Tue, 24 Sep 2024 21:43:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc85b1c6sm1931348b3a.89.2024.09.24.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 21:43:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stJrv-009ijb-07;
	Wed, 25 Sep 2024 14:43:15 +1000
Date: Wed, 25 Sep 2024 14:43:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvOU4+3IIn48g43v@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
 <ZvIzNlIPX4Dt8t6L@dread.disaster.area>
 <dia6l34faugmuwmgpyvpeeppqjwmv2qhhvu57nrerc34qknwlo@ltwkoy7pstrm>
 <ZvNgmoKgWF0TBXP8@dread.disaster.area>
 <v5lvhjauvcx27fcsyhyugzexdk7sik7an2soyxtx5dxj3oxjqa@gbvyu2kc7vpy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5lvhjauvcx27fcsyhyugzexdk7sik7an2soyxtx5dxj3oxjqa@gbvyu2kc7vpy>

On Tue, Sep 24, 2024 at 10:13:01PM -0400, Kent Overstreet wrote:
> On Wed, Sep 25, 2024 at 11:00:10AM GMT, Dave Chinner wrote:
> > > Eh? Of course it'd have to be coherent, but just checking if an inode is
> > > present in the VFS cache is what, 1-2 cache misses? Depending on hash
> > > table fill factor...
> > 
> > Sure, when there is no contention and you have CPU to spare. But the
> > moment the lookup hits contention problems (i.e. we are exceeding
> > the cache lookup scalability capability), we are straight back to
> > running a VFS cache speed instead of uncached speed.
> 
> The cache lookups are just reads; they don't introduce scalability
> issues, unless they're contending with other cores writing to those
> cachelines - checking if an item is present in a hash table is trivial
> to do locklessly.

Which was not something the VFS inode cache did until a couple of
months ago. Just because something is possible/easy today, it
doesn't mean it was possible or viable 15-20 years ago.

> But pulling an inode into and then evicting it from the inode cache
> entails a lot more work - just initializing a struct inode is
> nontrivial, and then there's the (multiple) shared data structures you
> have to manipulate.

Yes, but to avoid this we'd need to come up with a mechanism that is
generally safe for most filesystems, not just bcachefs.

I mean, if you can come up with a stat() mechanism that is safe
enough for us read straight out the XFS buffer cache for inode cache
misses, then we'll switch over to using it ASAP.

That's your challenge - if you want bcachefs to be able to do this,
then you have to make sure the infrastructure required works for
other filesystems just as safely, too.

> And incidentally this sort of "we have a cache on top of the btree, but
> sometimes we have to do direct access" is already something that comes
> up a lot in bcachefs, primarily for the alloc btree. _Tons_ of fun, but
> doesn't actually come up here for us since we don't use the vfs inode
> cache as a writeback cache.

And there-in lies the problem for the general case. Most filesystems
do use writeback caching of inode metadata via the VFS inode state,
XFS included, and that's where all the dragons are hiding.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

