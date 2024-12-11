Return-Path: <linux-kernel+bounces-442284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9789EDA35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A09167776
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF020E6F3;
	Wed, 11 Dec 2024 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j/ejm0YH"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47121F4E2C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956416; cv=none; b=cwGpUMS8q5BoSv+vjkLf8cVboeQVuQTZUjHS4g57SrcmOJ5ncCKYrVaMK3JjTQv5MiYLHqyuy8edJ7GnFLtURbPOqUJXVAawRmm9vYyzRYgFlF0j4pZ6L9akng+/PzLOgGKnSvaEnv08b1oRWO/+SV6PGBb/FjBLmdpcJm/NfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956416; c=relaxed/simple;
	bh=VOGzIGGSxqcC7jyFVRhHAo+5MH48iBCMJkB64VO7HdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS56IJill4oVZsrdavx2ZeHPzpdriCZ2bxoT1JWZny0JSYkEG6DPafFmJ03TaDVLwhzVDi3k4gDgnX/te3LFY6qESi0eRzktL8wt5PGCnI6XmE3VgoPFQOtZSABx32+r1u73Uv6DKei2tW9sdKG+9yn4kbesfxpCr/osNMwS0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j/ejm0YH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso1523648a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733956414; x=1734561214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=j/ejm0YH6vC3JTn6aSaULZwKVb89iCsaOgno1knpGPttaxzaexerLkwhwtTgTAYe3i
         6Q2kT/jo7vdHRRcLmk+qxinVMGJWI/wgVjkal81UtOU3esAlKVxiJ12O1QhU1uWvvI8X
         ZSxrcig/cUDx+ROYR1l0ciOET5DvuSjfDeuONsH1i0wqXUmYDuhm/KUq3Uh5iBa/a/rC
         Up0NzYZQezfMvegZ6nMR4LICpIUHTEBLpt6+bS47f98Ush3v5BkEHaPPlZSMSOOExoo5
         8dnh69STWKdciRv4FW8E2707xhq9LVyjTJLasZ7EUpFsj0J6eGhtGRoKO2RIsoebYdg/
         NMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956414; x=1734561214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=OeOUv21KBoZBB2wRj1NYFfltTwLlNE//vBYP8LHRfGiGUyoyY0zoiyaBkV44+qnx0c
         oQyklimu7OfsClRCkpa46376IULyqaXkYk44ktPed3UNzlFI5KZWrmz8tz2kw7Mfuo3G
         xBDE3mocJX1jGrvb9/+OjG3rYt+OMjJnEjIkpuHjzvoTGYgrKONHxmqXiWdDFnRUUgDE
         2uhmf9t4/n0EIOm9GsEv+lvQgCDCfiF8UmP9Ey2i6Xjk3gfQgi0P4ccswXzjAFXiPcC3
         ULrbBWgJKRNZgA2Jzx8EiVXQJxdBovlWZITgwU+K1eUq0G/M1QKzKIEBhGMUV/qgH29d
         zCxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrW9+Md6e80ZQN+lo8ocEmHez5uxvqcc0w1Ko7ZCjgPKY/8K3OpXrOrZvk2g6zqE/VImVrLRbybkMrKMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfeOTsek+nYV1op2BOvzQB2zJwa3Z4Pw/Jnraicd2BfmunFIP
	q1hkdHi2j/VDZW2Gc+tC3VIkYrvcKpWkU/1wt47KkWEOkWnjvQv1Qkvxb7LL+x0=
X-Gm-Gg: ASbGncv6IZ5mGZV0IWoakHuyEtU1+LSo/MZRY+Ryms4k1aow93PYflLbtF2kwd6rZP6
	t9RbPLH8n4ztttXNUZPoVqyhQDUGyWaN85FNRhi3DQ+YyD7V28Lh8PfNWNOkfTV5GDZXg0ugLJl
	ajVG7AVSJUs65YoeNr/OHAc6ETfwMdbF4ERinwz52lE47fYvzLDFd/+CrkM7wiGbrEIyKKWTt/r
	v7Fwq/F/gbqRI49l80KGUx1pb+84N6KJNpKeiDZQL2NaxSn/SlaoXnFSFticQjzKJFMQEIGJBo/
	RiLSqkbz6DxqnHEk2+SBeT8CgXY=
X-Google-Smtp-Source: AGHT+IEVKuZamiHIkIRgt4sKWSN/CxUsh7q1Rtn5YMJ8loDhLinrZmWvhpreTWA49/k9SjEkFUp/vQ==
X-Received: by 2002:a17:90b:358b:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f1392b7518mr2309164a91.19.1733956413993;
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm12072842a91.36.2024.12.11.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLVGr-00000009ZKP-40OP;
	Thu, 12 Dec 2024 09:33:29 +1100
Date: Thu, 12 Dec 2024 09:33:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1oTOUCui9vTgNoM@dread.disaster.area>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211181706.GB6678@frogsfrogsfrogs>

On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > Currently with stat we only show FS_IOC_FSGETXATTR details
> > if the filesystem is XFS. With extsize support also coming
> > to ext4 make sure to show these details when -c "stat" or "statx"
> > is used.
> > 
> > No functional changes for filesystems other than ext4.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  io/stat.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/io/stat.c b/io/stat.c
> > index 326f2822e276..d06c2186cde4 100644
> > --- a/io/stat.c
> > +++ b/io/stat.c
> > @@ -97,14 +97,14 @@ print_file_info(void)
> >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> >  }
> >  
> > -static void
> > -print_xfs_info(int verbose)
> > +static void print_extended_info(int verbose)
> >  {
> > -	struct dioattr	dio;
> > -	struct fsxattr	fsx, fsxa;
> > +	struct dioattr dio;
> > +	struct fsxattr fsx, fsxa;
> > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> >  
> > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> 
> Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> print whatever is returned, no matter what filesystem we think is
> feeding us information?

Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
some time, we should treat it the same way for all filesystems.

> e.g.
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> 				  errno != ENOTTY))
> 			perror("FS_IOC_GETXATTR");

Why do we even need "is_xfs_fd" there? XFS will never give a
EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

