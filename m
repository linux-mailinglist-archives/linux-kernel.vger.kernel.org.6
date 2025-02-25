Return-Path: <linux-kernel+bounces-530521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C6A434C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DCB189CFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D62566EC;
	Tue, 25 Feb 2025 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Snu2iggb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9962561D5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462103; cv=none; b=YnKgR8XhA1OwSUtl1zoN/v5gORaxHpT/6gdd0FNNps+rQuhe40LRsBB/tJP5RwJ/emTDLfQSbnt7eeyDxhwNhauk9QmP7tsJWywypnR3s2b80ekLiH9BJjcW+t1U0bCwzgHh1Yo+2A9nxwE6+C91vh0Z6AMMzsg6F6b1gSlEWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462103; c=relaxed/simple;
	bh=jIa7vOt0JPi1BL4+QmSvZ79tEBZoZ5xFaKD6PkU9iiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmIAZPty4j4P1r/TDoWJ2SojrtiwcmmC/Pnzfk90GlOO3BwQeNbR5Py8xTysNnM2M45vx3Y6EBXewE2QFIr2wHis/x9wyKzVBKVtF9wutaXui63AbjHPYmgZm96As4sJFLMuGlnlxTIc8VGc6DbS8eFRGZecZiMVPbuJJRPnnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Snu2iggb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2210d92292eso3726105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740462101; x=1741066901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVmlQ0qkrXqqHoBYxNGr5cUY6QJ6t0qt8m6e6uhD0sY=;
        b=Snu2iggbySVGXvzS0sENdhtUwIHhqzqc7zaYe5I07vwzGp7+voQ1D3ubCMKqSjlS7Z
         OFcP7p/3XBJm+cduAlp5grFAB1LeEIMOV12E/GlUpC3meQp1vMg/iDA1N5R+64/wOES2
         LWXy7u3aO6Ka49wowjCSHgUNl/pHPWC4vaaqpKY6uCJ1kY2l9d4XN1NFQFHlNtmut6yK
         OCzs2caVReAWGY4R4ex8a7qWOetpuqonMX3qXqaiCSLOII+Xry7M64ResMmjvV4rMobW
         DImKQz6csbtJRlR3G8i8v89JVgPFqy1LQVhpBK2L0hqn5QhwynHCBUs+/eo4U6uu4aEm
         tTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740462101; x=1741066901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVmlQ0qkrXqqHoBYxNGr5cUY6QJ6t0qt8m6e6uhD0sY=;
        b=SMlvDcMvPN/gmXMxfTAUcAF/zXRX5VqLpn6ZBPa4KWy3JkcATz6jQ6cdKNy62++m4x
         A7V7x5b3YAo5EFWpggS25xff03BIDNlc0suVQb7layBDAeEb1rBrx48G+Q3CwasFUyUB
         EUFiVbh0u3dOHj8NZ72ai1FlYgz92otO288uMW2XMeTY5xipA3YIv6mbuqC6bz8Lv5l5
         mGa4t2VEDcHq8H5HoZB1KF52d0txHTX0Ma6e+0e8fhRJE4LYn1hacxiTYzetEdr+R1Ij
         oKfK4VYHpknRX/U7uCC6U0by/uKDtho04GLOFXYepWl0/eNfeDSGFv8InZrJc79/zohI
         LKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF7VsEWgV/SPT8bke6XRK9NoHZIHVnS4v9WVtQsy72nPySUKhaWAC+dZUPVq02x3Id92l5o71p1l4w6So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoHNBDlHLQ0WP+7YnPzMqxIkeJfDqzi3ui0HcQ0ZC7S8E9taH
	DPa1ZuU86L8DkDazSIChyq0U8Bp10be1no0WWmmjtnfKNz9YlK+MdVrh7E96a2c=
X-Gm-Gg: ASbGncvCTnohD+q0OPYbLgQ8Z8781X0ggJHuW4IkULPO/GjvT8YnNGKak9KIjTcOLzZ
	kyghbjU1U4dcBDxT8HUvWj4oR/OLlzEhOy7gau8Ldg+YEeX/QNSKoU4Xd/yTY5dEurnEaHUb1Rn
	Q6eoLcXfofOqie+sWi5HOcpG5ZuTQcY6pQ594VK6B2HobYXkeB+LfbnLI+dGCZYasshsRUueuYx
	08Z6lPF1dDF/y2zboVxiVdz60xnW+Zsy5CCAUsYuEoa6tRxSV/2lWpK556GBAFjNhwBqyKWXhUU
	2ZJA27CXKvnLBdFqNpoKXO4x22dJhpzqObCVq8hqOB9+i6Nl/CUy3GvbH6pDn89Oli4O8gpWsLm
	5wA==
X-Google-Smtp-Source: AGHT+IEKpdHIUEz0cuxzsZpkp0hPqtKV1YUBxtQNV1M0k+7kG6G7UFu3mdg+tbrtRaGfQ7Nl8rnbjw==
X-Received: by 2002:a05:6a21:7781:b0:1f0:e7e2:b295 with SMTP id adf61e73a8af0-1f0e7e2b2c4mr8881586637.5.1740462100963;
        Mon, 24 Feb 2025 21:41:40 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f6bbesm601367b3a.39.2025.02.24.21.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:41:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmnhJ-00000005eRs-2VUP;
	Tue, 25 Feb 2025 16:41:37 +1100
Date: Tue, 25 Feb 2025 16:41:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <Z71YEf5zO-AjXZwo@dread.disaster.area>
References: <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
 <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali>
 <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
 <CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxyEy2F+J38NXwrAXurFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxyEy2F+J38NXwrAXurFQ@mail.gmail.com>

On Fri, Feb 21, 2025 at 06:11:43PM +0100, Amir Goldstein wrote:
> On Fri, Feb 21, 2025 at 5:34 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > I think a few people were talking past each other, because there are two
> > fileds in struct fileattr --- flags, and fsx_xflags.  The flags field
> > is what was originally used by FS_IOC_EXT2_[GS]ETFLAGS, which later
> > started getting used by many other file systems, starting with
> > resierfs and btrfs, and so it became FS_IOC_[GS]ETFLAGS.  The bits in
> > that flags word were both the ioctl ABI and the on-disk encoding, and
> > because we were now allowing multiple file systems to allocate bits,
> > and we needed to avoid stepping on each other (for example since btrfs
> > started using FS_NOCOW_FL, that bit position wouldn't be used by ext4,
> > at least not for a publically exported flag).
> >
> > So we started running out of space in the FS_FLAG_*_FL namespace, and
> > that's why we created FS_IOC_[GS]ETXATTR and the struct fsxattr.  The
> > FS_XFLAG_*_FL space has plenty of space; there are 14 unassigned bit
> > positions, by my count.
> >
> > As far as the arguments about "proper interface design", as far as
> > Linux is concerned, backwards compatibility trumps "we should have
> > done if it differently".  The one and only guarantee that we have that
> > FS_IOC_GETXATTR followed by FS_IOC_SETXATTR will work.  Nothing else.
> >
> > The use case of "what if a backup program wants to backup the flags
> > and restore on a different file system" is one that hasn't been
> > considered, and I don't think any backup programs do it today.  For
> > that matter, some of the flags, such as the NODUMP flag, are designed
> > to be instructions to a dump/restore system, and not really one that
> > *should* be backed up.  Again, the only semantic that was guaranteed
> > is GETXATTR or GETXATTR followed by SETXATTR.
> >
> 
> Thanks for chiming in, Ted!
> Notes from the original author of FS_IOC_EXT2_[GS]ETFLAGS
> are valuable.

..... except when they are completely wrong. FS_IOC_[GS]ETXATTR was
promoted from XFs to the VFS to enable ext4 to use the existing
project ID and quota infrastructure (e.g. for testing with fstests).

> 
> > We can define some new interface for return what xflags are supported
> > by a particular file system.  This could either be the long-debated,
> > but never implemented statfsx() system call.  Or it could be extending
> > what gets returned by FS_IOC_GETXATTR by using one of the fs_pad
> > fields in struct fsxattr.  This is arguably the simplest way of
> > dealing with the problem.
> >
> 
> That is also what I think.
> fsx_xflags_mask semantics for GET are pretty clear
> and follows the established pattern of  stx_attributes_mask
> Even if it is not mandatory for userspace, it can be useful.

You keep saying "it can be useful" without actually giving an
example of when it will be a significant improvement. Then you
demand proof that it isn't useful to userspace to justify a NACK.
That's not the way development works - you want the functionality,
you have to prove to that it is a significant improvement, not
demand that people prove that it isn't.

As it is, a lot of the "masks won't work" reasoning is in the
response I jsut wrote to Ted's email.  There appears to be a
significant lack of knowledge of the scope of the GET/SETXATTR
interfaces and how we've been using them for the past 20+ years
amongst the people arguing they should be fundamentally changed
right now.

> I asked Dave if he objects to fsx_xflags_mask and got silence,
> so IMO, if Pali wants to implement fsx_xflags_mask for the API
> I see no reason to resist it.

You didn't get silence - I only work 3 days a week and I'm
explicitly not responding to upstream devel list email outside of
work hours. So it may take several days before I find time to
respond to any given discussion thread.

As I've told you many, many times before, Amir: slow down and have
patience. There is no rush, nor is there a need to force the
discussion to a rapid conclusion.


> > I suppose the field could double as the bitmask field when
> > FS_IOC_SETXATTR is called, but that just seems to be an overly complex
> > set of semantics.  If someone really wants to do that, I wouldn't
> > really complain, but then what we would actually call the field
> > "flags_supported_on_get_bitmask_on_set" would seem a bit wordy.  :-)
> 
> If we follow the old rule of SET after GET should always work
> then fsx_xflags_mask will always be a superset of fsx_xflags,

Doesn't work for xfsdump/restore use case.

Firstly, there's no space in the dump media format for extended
xflags (i.e. requires new code and backwards incompatible media dump
formats to be created).

Secondly, if the destination kernel and/or filesystem does not
support the flags mask or features defined in the flags mask, what
do we do then?  The policy decision made a couple of decades ago was
that it is better for the kernel to ignore file attrs it doesn't
understand on restore and let the restore continue than it is to
abort the restore....

Better to restore what we support than not be able to restore
anything, yes?

> so I think it would be sane to return -EINVAL in the case
> of (fsx_xflags_mask && fsx_xflags & ~fsx_xflags_mask),
> which is anyway the correct behavior for filesystems when the
> user is trying to set flags that the filesystem does not support.
> 
> As far as I could see, all in-tree filesystems behave this way
> when the user is trying to set unsupported flags either via
> FS_IOC_SETFLAGS or via FS_IOC_SETXATTR
> except xfs, which ignores unsupported fsx_xflags from
> FS_IOC_SETXATTR.
> 
> Changing the behavior of xfs to return -EINVAL for unsupported
> fsx_xflags if fsx_xflags_mask is non zero is NOT going to break UAPI,

Except that it's completely undesireable behaviour for the existing
dump/restore usage of this interface.

If we just add the windows attributes to the fsx_flags field as
I have suggested, then xfsdump/xfs_restore would natively supports
backing up and restoring windows attributes on XFS files the moment
that the kernel XFS code supports windows attributes. 

It will not require any dump/restore code or dump media format
changes, and with the existing SET policy if the destination kernel
and/or filesystem doesn't support those attributes then they will be
silently dropped on restore...

Seriously, I said no because I undestand how these interfaces have
been used for the past 20 years. If you want to change the
fundamental behavioural characteristics of the API, then you have to
make sure that it works with the way xfsdump/restore use the API
across the dump media format. i.e. the consumer of the GET
information can be a SET operation on a different kernel and
filesystem.

I've already said no to a new syscall because it's just a set
of feature bits that can be added to FS_XFLAGS. And the added
advantage of that is that any backup program that already supports
backing up the fsxattr information will also support it without API
or dump media format changes. i.e. we get widespread support for the
windows attributes pretty much for free.

Yet here we are, with people instead wanting to construct complex
new APIs which will require entirely new infrastructure across the
board to support.

Your call - windows attribute support via a small amount of work for
an existing API addition, or a huge amount of work across the entire
filesystem ecosystem for a whole new API. The end functionality will
be identical, but one path is a whole lot less work for everyone
than the other....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

