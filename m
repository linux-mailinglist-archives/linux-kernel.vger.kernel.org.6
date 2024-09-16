Return-Path: <linux-kernel+bounces-330266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C93979BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8391F236FA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4813A260;
	Mon, 16 Sep 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uacM8CBQ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0A49637
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470219; cv=none; b=nkRWXp67IOekK5SxpFOw56rwKzdnFX/+ILvm5oD9eP4yr2hTS22bOPDq1cj2fqp9DJy2nHA18eN1kphFPJXSXebITsW+vTMRTYfSgxi01QQwhMeacZ3lSHx6almSpOtitxoFO2cfE0JoQIY8d8fDohFyxV54i/bkwUNeYncbr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470219; c=relaxed/simple;
	bh=p0HRwb7dckvpqsAEI1/7frDLgt0lW6OPyF4zHs0P8lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkSVmYFB3YouBxwN/V2lf0D+v1QnABgIelVI1kSexNkWrxpcoWeTROgQSAUdGLbKvvDyIlUXSsVyzMelfI5+VEN6qVFakNEB8vXI5F5Q31V6ftrT8E7Yj6Go3ptPhE5j+WbCJ/OoyMAf4WQUI428XTzuVUC+TrdglG3j77lSzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uacM8CBQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so2706205a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726470218; x=1727075018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZLEn0Q9zViAeMpnzS+Dnq04taHJPJso6pfVCKuErcs=;
        b=uacM8CBQ2YTGMGXW9M1xXKYXDgwn8/OSFC33WCT3b6kiTcMp5H75DQFyTKUs5LVS6s
         56PPDBTfDxUwfXayNVVF93060ZWqV8Vzi+tomk1ZuAM4A33XwpXXBxbAkr1XaH+HdC1r
         +Z2Tvg1ZEregiWNZWUC4ZVrmfEjnIF5veYQFFP9UDXVvRNiJIuliVWN9RBlvqQpPJv7U
         t+MrxHLqhekD/DChZoSVH6gXtC+ekq8NTzQuYNJwtFRJk3XuodZs0gL5p9+Ph6PMWmtk
         FtHKkRgSXY4do+QrsunPd+Mv96KPaDyokG5CS5vygbIymSn5Duag07JNrJkVKV5vdfzx
         DvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726470218; x=1727075018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZLEn0Q9zViAeMpnzS+Dnq04taHJPJso6pfVCKuErcs=;
        b=HGaY1Iu88b27fHa65bfbkpuDcaVFzOzgzDLwYOJ2D+ig+580xlCN1UF6dseA6F8f1E
         KnMHe+I30ge0EqSRMDxZBpcsI6ovZ7STY5mX31F+pwa1Xc5feWM4tvrQcn12sDC95BJ9
         U3oDFmYMYDiBzxlypXkzZn/l0DeLiGZ/VdvMswGCWoKO/htI1eW8JVujo7fxErCKCDKC
         mXsShDPwpx3EmGBftg7WjvjOU8dg4c2qcZ16s9u6bqsMzFwHEXMckQdNlnl54QotnjKz
         ybV6jfSnccBxKAhW79vcRHnlgMZlnbh1Cx6IcYLEUbYUiNe70PeuoEfGpP3iROczypul
         v8zw==
X-Forwarded-Encrypted: i=1; AJvYcCVIvLyFRJgMtWwfeo1znX/NbMyFbDHouust5c5eMoc307DZry8dxq7+rPLCYffJZ1Pn/ycz8rvMKUTfHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYBkAAHPb9dwekGw1n88tHvFRo8WtAwZyOmOORlClPblekVb2
	NdC4nKFB5bb1dgM0RjTNwu1dgedDgmiS78KyuoH247H7h2TSUXoEXBCkozL1qPA=
X-Google-Smtp-Source: AGHT+IGq42CTY7GghG9ZTc+fqKHl5k23VXJfZNsjb0N1GaK6i7O2LyGs84PhBoOXpuTO1FVLs75q9Q==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr16283390a91.24.1726470217587;
        Mon, 16 Sep 2024 00:03:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c7b4sm6581412a91.17.2024.09.16.00.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:03:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sq5lm-005pLT-1M;
	Mon, 16 Sep 2024 17:03:34 +1000
Date: Mon, 16 Sep 2024 17:03:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZufYRolfyUqEOS1c@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
 <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734m7henr.fsf@gmail.com>

On Tue, Sep 10, 2024 at 06:03:12PM +0530, Ritesh Harjani wrote:
> >> Is it something to just prevent users from destroying their own data
> >> by not allowing a rw mount from an older kernel where users could do
> >> unaligned writes to files marked for atomic writes?
> >> Or is there any other reasoning to prevent XFS filesystem from becoming
> >> inconsistent if an older kernel does a rw mount here.
> >
> > The older kernel does not know what the unknown inode flag means
> > (i.e. atomic writes) and so, by definition, we cannot allow it to
> > modify metadata or file data because it may not modify it in the
> > correct way for that flag being set on the inode.
> >
> > Kernels that don't understand feature flags need to treat the
> > filesystem as read-only, no matter how trivial the feature addition
> > might seem.
> >
> 
> 1. Will it require a fresh formatting of filesystem with mkfs.xfs for
> enabling atomic writes (/forcealign) on XFS?

Initially, yes.

>   a. Is that because reflink is not support with atomic writes
>   (/forcealign) today?

It's much more complex than that.

e.g. How does force-align and COW interact, especially w.r.t.
sub-alloc unit overwrites, cowextsz based preallocation and
unwritten extents in the COW fork?

> As I understand for setting forcealign attr on any inode it checks for
> whether xfs_has_forcealign(mp). That means forcealign can _only_ be
> enabled during mkfs time and it also needs reflink to be disabled with
> -m reflink=0. Right?

forcealign doesn't need to be completely turned off when reflink is
enabled and/or vice versa. Both can co-exist in the filesytsem at
the same time, but the current implementation does not allow
forcealign and reflink to be used on the same inode at the same
time.

It was decided that the best way to handle the lack of reflink
support initially was to make the two feature bits incompatible at
mount time. Hence we currently have to make a non-reflink filesystem
to test forcealign based functionality.

However, doing it this way means that when we fix the implementation
to support reflink and forcealign together, we just remove the mount
time check and all existing reflink filesystems can be immediately
upgraded to support forcealign.

OTOH, we can't do this with atomic writes. Atomic writes require
some mkfs help because they require explicit physical alignment of
the filesystem to the underlying storage. Hence we'll eventually end
up with atomic writes needing to be enabled at mkfs time, but force
align will be an upgradeable feature flag.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

