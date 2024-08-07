Return-Path: <linux-kernel+bounces-277108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E2D949CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627012851F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DADC137E;
	Wed,  7 Aug 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CnTs5MQZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302CE8472
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989343; cv=none; b=cyWVYr5emnoX3H5VveZbW4N7y+pwnMvXVy0BA0ug8IdXbQfcAG2GFZUFE5PNW/jHjdXQv6t/A8edn4h5dVJtgYQsnlor8s3fFTL6BI6+QJzVU4UOTfq7+7AlmCxXvIpmuXRkIWrBFebYJj/9jxl3r0U+ef8dngmvHKqTLuUuBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989343; c=relaxed/simple;
	bh=hT0MeX3lN/+luMv7GRNg6x2rm+Yc+T8HNtTHn+bEfyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCa15CP/NNU61cKE1q0+O9GoiJuiwm8aaXKDVBITI07m+nx3yNoj5Meyoo835z/aCyyH9SKY0nSByoUeTdAw4iz9GsRzJyoazdmnkPRaAogq9ffopCO0Qz5i/Hj1dW0Na8E5VHtB57tgr7hw4MsfjPKt+GIHPBkTL7wzNmW8hyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CnTs5MQZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2b921c48so980248b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722989341; x=1723594141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1whsT5ZzX2NUYGE1kmzQNMAQqUazQflf6zBIIjfKBE=;
        b=CnTs5MQZ1fX9+cnh+rHK9jeB7sG4EwL69djebXabX/4WofeQtsFOQrdzXmsd9E8uX2
         CtrlbDgT777HnyOQbsSqMNMVyU8kFKSpsuAC77pCBqnJQbMXmMTBUViLvXgo/WeUZnHK
         Hsg1t0HmslbBhKAb99HIuPd67kci9ah7XJMkc5stuQShSh+HHqQmTSIUxyZ/LiHKOYSO
         lqe0FDtntLG5n+7Mkl5eSs2swyTJrJIUrJ0gPLc0N1RJlGWeFlD7XCpThF1tZeKMwlRI
         a4jYyj+9J5RylDizv2sLd4oskNSfsVOFCrkSFWns5x3tVtNhHRKmf3M97CKRs7CIQLxx
         mWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722989341; x=1723594141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1whsT5ZzX2NUYGE1kmzQNMAQqUazQflf6zBIIjfKBE=;
        b=kDDz0LbdWdzC+ozt0BfLlC54iNgyyAp4f5JG95o/2hEKQCNjC3Z7krAcUnMErDFTii
         HlxD6yyaCn7XdJxrlWacojxufRHcAJDrly1l1zRZxSz6Ooh+14kpF3cQSfHVFiCUkgn2
         o9eCn/NBWDp47PoxblbtVfGiZ8FZ5sLwA+aULoP52WxXTHp5IvsqVI+3nE8f4aSou8Hg
         s5cmPfSGnMgfXomntZz7Ohr1dg1QMJ/9vnPa49kAsQk6gspqzzFhhcWMk6DhpYRzgDWn
         Od9K6v+Gi476zF2RHFRRnRtWU0ciUPgN+U1MPPzt7R74eUPBAt482vlcVkG/VzW/jZdH
         LyTg==
X-Forwarded-Encrypted: i=1; AJvYcCX7fBSaeeK59s0olUJmClYfVgEOZWQSbYzm1SBhLNNKdIUroMehyRVY4KX0rKz73N7U/r0nyKZi75Es2ACpnub06uDrXUe/I7MzGp6m
X-Gm-Message-State: AOJu0Yzm7kRDsk8Y0bMl4PrbwAXT5xXc7DXw2mQlgIIhaBTWL1hlBWdP
	t7pNhDSYKSXGevUZ6YY1Gx+1PqWcKh62tiKZr5TF5Z1SKTBPYLkdx3FC1QMXXNI=
X-Google-Smtp-Source: AGHT+IFw9vAclRmiZ92meoU01juLqJ0kfWZ8aeYdA0Fzv0l3GA6LwezqSDasXR1t6OKTGWBH1aY4EA==
X-Received: by 2002:a05:6a21:2717:b0:1c6:9fe9:c425 with SMTP id adf61e73a8af0-1c69fe9c522mr12396601637.45.1722989341469;
        Tue, 06 Aug 2024 17:09:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7653b4d99sm6279697a12.84.2024.08.06.17.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:09:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbUEc-007wKo-2q;
	Wed, 07 Aug 2024 10:08:58 +1000
Date: Wed, 7 Aug 2024 10:08:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 11/14] xfs: Only free full extents for forcealign
Message-ID: <ZrK7GrDSebnXXzF6@dread.disaster.area>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-12-john.g.garry@oracle.com>
 <20240806192738.GN623936@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806192738.GN623936@frogsfrogsfrogs>

On Tue, Aug 06, 2024 at 12:27:38PM -0700, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:54PM +0000, John Garry wrote:
> > Like we already do for rtvol, only free full extents for forcealign in
> > xfs_free_file_space().
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/xfs_bmap_util.c |  7 ++-----
> >  fs/xfs/xfs_inode.c     | 14 ++++++++++++++
> >  fs/xfs/xfs_inode.h     |  2 ++
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index 60389ac8bd45..46eebecd7bba 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -854,11 +854,8 @@ xfs_free_file_space(
> >  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
> >  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
> >  
> > -	/* We can only free complete realtime extents. */
> > -	if (xfs_inode_has_bigrtalloc(ip)) {
> > -		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
> > -		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
> > -	}
> > +	/* Free only complete extents. */
> > +	xfs_roundin_to_alloc_fsbsize(ip, &startoffset_fsb, &endoffset_fsb);
> 
> ...and then this becomes:
> 
> 	/* We can only free complete allocation units. */
> 	startoffset_fsb = xfs_inode_roundup_alloc_unit(ip, startoffset_fsb);
> 	endoffset_fsb = xfs_inode_rounddown_alloc_unit(ip, endoffset_fsb);

I much prefer this (roundup/rounddown) to the "in/out" API.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

