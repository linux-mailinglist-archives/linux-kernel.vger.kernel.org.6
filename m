Return-Path: <linux-kernel+bounces-558360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5830A5E4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF93BB528
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3E25C6E5;
	Wed, 12 Mar 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GOGJO3C2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC625A346
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809126; cv=none; b=W3g4kEwk7bmYeD1PKlkbgbQFsxStzvLpUoVrhGYQGbNH5jk4y4uiKMwgLEVdQRRNgPfWFgMcVCkzDaVNdWov8eGn8A8Mj6K/EkWqoZug+2T4B1HlBj7hUkS7E5ooFyg/bOQG5rLof4qPSpXc1y2QJBUgiryqOwcZVRHzwG5Vdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809126; c=relaxed/simple;
	bh=9nCebzwQcT7vsmLoqvflspQkiwpll02VlnYPMm4lKOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1ZI2Vom6G3IKX8QIpLZ7GWM4vumsQZcoK0Uywc0Splzu3ZBVINU3t1GKaYTgg0iarA/snDJJQrT7Y6ROs/wg29NNsBlIW6lMDvMr5bj2kbCeSVsS3jPHabr7pD/seena9oVan2hiSTSIzKSurUZzZ92YCRKVCaGy6wLc8lnxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GOGJO3C2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso4670075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741809123; x=1742413923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=GOGJO3C2/wlKBsCli3wHpFSOAwpXN67Fhww6AHNXYt6ZpwFMGx0mwROgOHuRh31IsN
         XMYFA56eCx/vM/UTdDzC2NI8M2998h9Uwk3pdfw7BIdhyCXy+qL8JGnSRQFNo4u+89O7
         ACbwFNWCtPHgj/g+5zdJIKSwNc2W0hJYYTMOG9ybHwEwyM5G8RvLELZntsHfU7/dEYL1
         8IantO9rfNEihePEb018gGVDovaRq/eiz6zb8BanToOTCBKOWkh6X/IV3pK8dUAziGqa
         Vy8in57gtB5Q3gDxLDCyihkhXEARr3IHWvdHZyC+QbCi+iYQQ1nDkOWrs0wv23WRgqPC
         aflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809123; x=1742413923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZXks1yCL59Hzx10jJaOlAET0rV27Iyc9SiIzk3nPyM=;
        b=hbXnaLr7Cg+MhKIiOjS80aoe9oY9jhMYU3nATrWmjxpRfC39RSHd+F9P3iBpq8uIho
         vpsxskiJojRxcHe3F7x4t3cXxePg54eVjj/A6EAzR+jikE4yYRG6JQteuO4KMpyc/793
         eszxKFFig3Y6JlszLJMXTE34B7bYUv6p8S/FQc9yBG9NdLf6S4f4VnNVn9ShpNZnA1rx
         6+6reOrv7/OPPDFyuQYLmFp/HgdISJUHkTI88AMLU7jQbYou5KK8Oylqq8xs/2oc1wE7
         fje5ACexabt6tv8/8Knzenc/uJMWoYLtG2met4uY9hBZBHJMXxoi3krK+T4Ez4ZMtjlF
         fhIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXZas1bAxklSRAsMW52bmecS1EDNFJP6MFGLUNFX8iDmpj/aEUZjukG48Qy8/UCmIv7eTrxb4HQkXrrtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEDhgivRUAkQBH1oBgpbxOC+iWNCVsG6fd7/7hdtiZk8CLNQX
	+TcngXhvO7eOWNi2rvibEiClTqOMQBiq61eixkkwkoY6l7dNcysC6K03ZM8chw0=
X-Gm-Gg: ASbGncvitJB4eXwX3V+oDI6CMCess/sN4zXNdq6bskskk3D9bSx1LbE7tVU/LAG3YRI
	GzmVFBI4j+RfcR4z+jK1o+1tGL6GoNEXI0InOMcZ0gDeLZjse+kTSYrccQO9suYJQs9elc949v9
	0tM1ZxDWrYDWUgsAZ6WjsSZRieyHMPfzmG5NyN8VQAFVOkYATFllrtl/grNuKQV/0UEVh0/bKlf
	8uC8ZM0k7zvRBZAfxZbojJqkevnh3K6eu8Iqna2JNKt/rCYQ7xmU64sXRQ+cLy/Hqh7slDMWFcA
	TfjxAV3nxpSunjus9hFvCPyCI2RQckisWknl0IuNuIzIlkshXa0OSZWlfWvfHBKraPFoIRTd8Tq
	jpg49+kD57/32kA8LtMYn
X-Google-Smtp-Source: AGHT+IEE2EJW9ndEG7Y/L7HAyUCKmqOhXbnMCG+N60tA8rq5IwDA5m81XvtvYTp7j4ChVG457AtQ1g==
X-Received: by 2002:a17:903:228e:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22592e2d676mr134144265ad.19.1741809122629;
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm120190275ad.91.2025.03.12.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:52:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tsS7T-0000000CHVL-0aXe;
	Thu, 13 Mar 2025 06:51:59 +1100
Date: Thu, 13 Mar 2025 06:51:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z9Hl39cS-V2r-5mY@dread.disaster.area>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
 <Z84QRx_yEDEDUxr5@dread.disaster.area>
 <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>

On Mon, Mar 10, 2025 at 12:10:44PM +0000, John Garry wrote:
> On 09/03/2025 22:03, Dave Chinner wrote:
> > On Mon, Mar 03, 2025 at 05:11:20PM +0000, John Garry wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> > > index 4b721d935994..e6baa81e20d8 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.h
> > > +++ b/fs/xfs/libxfs/xfs_bmap.h
> > > @@ -87,6 +87,9 @@ struct xfs_bmalloca {
> > >   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
> > >   #define XFS_BMAPI_NORMAP	(1u << 10)
> > > +/* Try to align allocations to the extent size hint */
> > > +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> > 
> > Don't we already do that?
> > 
> > Or is this doing something subtle and non-obvious like overriding
> > stripe width alignment for large atomic writes?
> > 
> 
> stripe alignment only comes into play for eof allocation.
> 
> args->alignment is used in xfs_alloc_compute_aligned() to actually align the
> start bno.
> 
> If I don't have this, then we can get this ping-pong affect when overwriting
> atomically the same region:
> 
> # dd if=/dev/zero of=mnt/file bs=1M count=10 conv=fsync
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0525 sec (1.190 MiB/sec and 19.0425 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0581 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> # /xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" mnt/file
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0524 sec (1.191 MiB/sec and 19.0611 ops/sec)
> # xfs_bmap -vp mnt/file
> mnt/file:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>   0: [0..127]:        20672..20799      0 (20672..20799)     128 000000
>   1: [128..20479]:    320..20671        0 (320..20671)     20352 000000
> 
> We are never getting aligned extents wrt write length, and so have to fall
> back to the SW-based atomic write always. That is not what we want.

Please add a comment to explain this where the XFS_BMAPI_EXTSZALIGN
flag is set, because it's not at all obvious what it is doing or why
it is needed from the name of the variable or the implementation.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

