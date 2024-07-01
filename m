Return-Path: <linux-kernel+bounces-236248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E591DF69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967EB1C208A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60B14D6F1;
	Mon,  1 Jul 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pAfHIgjF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46386250
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837313; cv=none; b=oy1ndlS4YnUflJH46rQzv5/OgVe3NXkj7yBkCZpLaWgFHowklRLsN/6Iww0+w1a00IvfATwZi5aa9QugOYe/9xu4bnIuAgNO5XokcmaZCkgh1hkv6sR/HdjaZjgeUhjaiO3W9qXEJ8jNuolfPvcBXCeK7lvWoPWaJFJ7e+J59sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837313; c=relaxed/simple;
	bh=mZeO1f7tTznVKqOD4SvW+UN628jwmIqb6IO7RYHEuNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2ZSP1B6mrmAGKqCIHA5Hhgb3tn72MboaJyu7+1GejW9WcSVqoaycRULFWJFw5fJnnI15h1JrKWZf4YGNLV80k6goForfhqQBz1ms0z00M0xyt+gPTwsFDVnsKWce/32XqK4jDBeTYIyFZR7UvE5z3rww63Ah703DpLxN/P8Nk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pAfHIgjF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso15575815ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719837311; x=1720442111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Srvua/8GiZk2f1lRDes3KQDNlajTOwOOiszOgYhtkE=;
        b=pAfHIgjFp9YUT8lsILQhKGdJNkOLEeH4L8svf4d7mBWVb59VOY3lbu9C/Z1NNsk2us
         jvlz9Goy9AqnLoTwfqdsFBOUpoL48O0ve9S9guulN7+IwahnQLJRRdHbTwAklM5knKmb
         jTRPBEv9DUtSETpgv1AVNa74gsPS2TR0+AGrrCjxn/XBceocNim3OrAIWAedMk6jZSfP
         1sqaDRQYZ2LtmFjo+OE1LZxHtgz/e4kFrNGjZyNGQfwvs08n30ZwUosJfGYD9N6emHmk
         UJkzRuJLYvs1ZFpPQ558CgrO03/VplZ9uVgHRZDMAg59xSH23RYkhcOgvYRoZbQPkbH6
         tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837311; x=1720442111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Srvua/8GiZk2f1lRDes3KQDNlajTOwOOiszOgYhtkE=;
        b=wO/k7SunMqIEttfEjIz/cPLtpqFQLEGzI3gtZlvjTI0/WjgcLGvbxYsdEyPgx+418d
         +EzSGTJF5A9znmOwp3S0tpv+RFk1+50HhqPXROHKQDrqvcRLmf6WeBXHEiNWQZvNtZsi
         P3syeBo4y7hGIpyKtKTvS1jhJK1lnR4nnA5fgJzUSQlbtfS5+tFyvpbxBAMLydP19mDn
         DOwNv0UaTqzl7RGfIOiFgPju+zwAly3bYm+HzkDJCNZC707SrQ6JqTo40kGj0wjVaFwE
         mBro2KxgtVa22trVPc+j+JkGUwiP+osY/9dSPhce089BBBC3gmvxOR6dk0Qwig/+AJhE
         kMog==
X-Forwarded-Encrypted: i=1; AJvYcCWMLnlZY+yW/glTtjS2sdk8Qq248TjGC960crdEdj+C4t3qnW/3svh6Ao+/77RG1V9p2whdl068FxI4ucbJhCftnii/XvncLrHLUfKx
X-Gm-Message-State: AOJu0YyJXBLVIA/AGKmvS2JDOufUSuQA/yY4HGtrAsiA7Px2yID6+tKg
	3r6xcTR/ePJTYGdIwLLhObE1JYw2iNdM/+xBOW+pnZf5KKRamL5BbPxdnYLHmjQ=
X-Google-Smtp-Source: AGHT+IEDTYyht4xal4sRk0Ri79tyKeyIeWLDUvtqY7rzls4XH1cjLoNZcE3nJnryOV0CB94f4AEujg==
X-Received: by 2002:a17:902:cec5:b0:1fa:95d6:1584 with SMTP id d9443c01a7336-1fadbca398dmr31822695ad.37.1719837310840;
        Mon, 01 Jul 2024 05:35:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8cbbsm63560625ad.106.2024.07.01.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:35:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sOGFP-000KA4-33;
	Mon, 01 Jul 2024 22:35:07 +1000
Date: Mon, 1 Jul 2024 22:35:07 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, chandanbabu@kernel.org,
	John Garry <john.g.garry@oracle.com>, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next v6 1/2] xfs: reserve blocks for truncating large
 realtime inode
Message-ID: <ZoKie9aZV0sHIbA8@dread.disaster.area>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
 <20240618142112.1315279-2-yi.zhang@huaweicloud.com>
 <ZoIDVHaS8xjha1mA@dread.disaster.area>
 <b27977d3-3764-886d-7067-483cea203fbe@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27977d3-3764-886d-7067-483cea203fbe@huaweicloud.com>

On Mon, Jul 01, 2024 at 10:26:18AM +0800, Zhang Yi wrote:
> On 2024/7/1 9:16, Dave Chinner wrote:
> > On Tue, Jun 18, 2024 at 10:21:11PM +0800, Zhang Yi wrote:
> >> @@ -917,7 +920,17 @@ xfs_setattr_size(
> >>  			return error;
> >>  	}
> >>  
> >> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> >> +	/*
> >> +	 * For realtime inode with more than one block rtextsize, we need the
> >> +	 * block reservation for bmap btree block allocations/splits that can
> >> +	 * happen since it could split the tail written extent and convert the
> >> +	 * right beyond EOF one to unwritten.
> >> +	 */
> >> +	if (xfs_inode_has_bigrtalloc(ip))
> >> +		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
> > 
> > .... should this be doing this generic check instead:
> > 
> > 	if (xfs_inode_alloc_unitsize(ip) > 1)
> 
>         if (xfs_inode_alloc_unitsize(ip) > i_blocksize(inode)) ?
> 
> > 		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
> > 
> 
> Yeah, it makes sense to me, but Christoph suggested to think about force
> aligned allocations later, so I only dealt with the big RT inode case here.
> I can revise it if John and Christoph don't object.

Sorry, but I don't really care what either John or Christoph say on
this matter: xfs_inode_has_bigrtalloc() is recently introduced
technical debt that should not be propagated further.

xfs_inode_has_bigrtalloc() needs to be replaced completely with
xfs_inode_alloc_unitsize() and any conditional behaviour needed can
be based on the return value from xfs_inode_alloc_unitsize(). That
works for everything that has an allocation block size larger than
one filesystem block, not just one specific RT case.

Don't force John to have fix all these same RT bugs that are being
fixed with xfs_inode_has_bigrtalloc() just because forced alignment
stuff is not yet merged. Don't make John's life harder than it needs
to be to get that stuff merged, and don't waste my time arguing
about it: just fix the problem the right way the first time.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

