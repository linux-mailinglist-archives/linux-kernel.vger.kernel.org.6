Return-Path: <linux-kernel+bounces-249982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBE92F28E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25AAB21A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9591A08BB;
	Thu, 11 Jul 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j9/O61zO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7519EED4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740031; cv=none; b=HrpIIJstqRM/DBhkKhyQydliQMlicz1e03TAy5F/yMxRcrKPsPeIyka7NeGuqwZwz+eemRgHcNkJWe01w3P7s8jlSKmUK9RF7BcCwDiQNmUYWutfOX/qv/n/JUrxTIstWpMWlD2KYF95OKGy81xFBdx09wSkW3MRuvAEQTMpe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740031; c=relaxed/simple;
	bh=K53tpMQcO11OpUnCtKhvbGs7M8dMyiMy3vumHdNU3TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHtrejHpWhMZISzSu6HadKLrHN0YhJqMPYzihdukHdyDe6AqOE55PImGOVAt9fS4PqFy1U5CqdQV85GhTAlwgTGC+TT+5ziz8G4/DynPAi6nfvL1xRAUipNo6NGo5T/PgC1DS2FIYbTi2DUvt2XYBeA0FFXLqWyS47EOb0DkxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j9/O61zO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb1c918860so18357985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720740029; x=1721344829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VA2PscEzfSHi8ckmw3aeAx6MJKInRJvQm5FzW1Chuyo=;
        b=j9/O61zO022CxV+zv724PH7cvGuHWI+9S5gY377VO5rppINa83K159wTPQMTc132sq
         NhpdAl5WNVIlYqmCFi/tOLvxGBY0tMp0c5MakTZH00+1igXnDwsU83DjVjWQJHSDTI7A
         mw/UhigOmkjgjijg5c5FrkxEV6EhfxMHUIIAkAJB2wU+o34rzJMNmBhQcicJKA96I55t
         a6AT5vMjPMoypaXpBicqTDUW7faNHbCD0GtpuX4yqCKM2PWjVLb/PlKgFvYUVnOYZrgM
         qpcCO0hhE+Q/Hjjt6jcyW3xF1iY6G1V76PjUYL7wMbW3WuL0ekkGyTem4veHW11ncuWz
         B61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740029; x=1721344829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA2PscEzfSHi8ckmw3aeAx6MJKInRJvQm5FzW1Chuyo=;
        b=fvp8LS/gX42gzMPPaQOtoM/rLcL3sca2RYTXfR23sxof7wpz6y0NSHjKgyt/q9kxkg
         MRYHtG+UvUOKg2gsHTdPgIA57fqR+qHJb0/javEETywsE/C9xEeR07DtjIhtWnQ6eEd7
         YBJjW9NTbUdQPCD13BYTPb7/YdiTWbBrzFRHJeMN9quwGnwV7ZznPiSj3Se67OkAVcXL
         kxur5OUsypITFYuz8dp6L8mRTB1IBpMIAmYPoY3lx+UEv65vLhhKiP1fSIJ2wj+7wmuM
         /1DzpejD1K/7nZyA+5QjPUwh9A2guyAfP6qa4Bijk/TcYd5rAQCbhxNR7pmWfuJpBUvK
         6rOg==
X-Forwarded-Encrypted: i=1; AJvYcCX02pgRDCBKc8WLBTuOJwBrnDm5YevAlgs/hf7ZcdHkaLTxpSLPdGVnm3HMK2Fx70qn09QKJcP9avo6iC0hS/Vr4nB/BHMSZEWZD+ik
X-Gm-Message-State: AOJu0YwiWlU7M2mV1uPbo1H2IVsAth+aISn1RS2PI1RKoKYo82aUrgHQ
	txppaFuqgutaduw797caXbOn/20qieA1627L+BLODoRAZVfKkJ9ehob9uSaO7z8=
X-Google-Smtp-Source: AGHT+IGMccNKbD9au2BtL102u3ca0gUzV2qBIOAScTtsCAuBgIpj89ZO3K1bkY/Ia6cIHMHgdbR8XQ==
X-Received: by 2002:a17:903:2cf:b0:1fb:8a0e:771b with SMTP id d9443c01a7336-1fbefef53fbmr16050475ad.29.1720740028903;
        Thu, 11 Jul 2024 16:20:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a24eeesm55883665ad.65.2024.07.11.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:20:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sS35O-00CYz8-0R;
	Fri, 12 Jul 2024 09:20:26 +1000
Date: Fri, 12 Jul 2024 09:20:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <ZpBouoiUpMgZtqMk@dread.disaster.area>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711025958.GJ612460@frogsfrogsfrogs>

On Wed, Jul 10, 2024 at 07:59:58PM -0700, Darrick J. Wong wrote:
> On Fri, Jul 05, 2024 at 04:24:44PM +0000, John Garry wrote:
> > +/* Validate the forcealign inode flag */
> > +xfs_failaddr_t
> > +xfs_inode_validate_forcealign(
> > +	struct xfs_mount	*mp,
> > +	uint32_t		extsize,
> > +	uint32_t		cowextsize,
> > +	uint16_t		mode,
> > +	uint16_t		flags,
> > +	uint64_t		flags2)
> > +{
> > +	bool			rt =  flags & XFS_DIFLAG_REALTIME;
> > +
> > +	/* superblock rocompat feature flag */
> > +	if (!xfs_has_forcealign(mp))
> > +		return __this_address;
> > +
> > +	/* Only regular files and directories */
> > +	if (!S_ISDIR(mode) && !S_ISREG(mode))
> > +		return __this_address;
> > +
> > +	/* We require EXTSIZE or EXTSZINHERIT */
> > +	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
> > +		return __this_address;
> > +
> > +	/* We require a non-zero extsize */
> > +	if (!extsize)
> > +		return __this_address;
> > +
> > +	/* Reflink'ed disallowed */
> > +	if (flags2 & XFS_DIFLAG2_REFLINK)
> > +		return __this_address;
> 
> Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
> superblock verifier or xfs_fs_fill_super fail the mount so that old
> kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
> support for forcealign'd cow and starts writing out files with both
> iflags set?

I don't think we should error out the mount because reflink and
forcealign are enabled - that's going to be the common configuration
for every user of forcealign, right? I also don't think we should
throw a corruption error if both flags are set, either.

We're making an initial *implementation choice* not to implement the
two features on the same inode at the same time. We are not making a
an on-disk format design decision that says "these two on-disk flags
are incompatible".

IOWs, if both are set on a current kernel, it's not corruption but a
more recent kernel that supports both flags has modified this inode.
Put simply, we have detected a ro-compat situation for this specific
inode.

Looking at it as a ro-compat situation rather then corruption,
what I would suggest we do is this:

1. Warn at mount that reflink+force align inodes will be treated
as ro-compat inodes. i.e. read-only.

2. prevent forcealign from being set if the shared extent flag is
set on the inode.

3. prevent shared extents from being created if the force align flag
is set (i.e. ->remap_file_range() and anything else that relies on
shared extents will fail on forcealign inodes).

4. if we read an inode with both set, we emit a warning and force
the inode to be read only so we don't screw up the force alignment
of the file (i.e. that inode operates in ro-compat mode.)

#1 is the mount time warning of potential ro-compat behaviour.

#2 and #3 prevent both from getting set on existing kernels.

#4 is the ro-compat behaviour that would occur from taking a
filesystem that ran on a newer kernel that supports force-align+COW.
This avoids corruption shutdowns and modifications that would screw
up the alignment of the shared and COW'd extents.

> That said, if the bs>ps patchset lands, then I think forcealign cow is
> a simple matter of setting the min folio order to the forcealign size
> and making sure that we always write out entire folios if any of the
> blocks cached by the folio is shared.  Direct writes to forcealigned
> shared files probably has to be aligned to the forcealign size or fall
> back to buffered writes for cow.

Right, I think all the pieces we will need are slowly falling into
place in the near future, so it doesn't seem right to me to actually
prevent filesystems with reflink and force-align both enabled right
now and then end up with a weird filesystem config needed to use
forcealign just for a couple of kernel releases...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

