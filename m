Return-Path: <linux-kernel+bounces-209686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94D903964
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17ED8B20C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82E179957;
	Tue, 11 Jun 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="c1weGvuO"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07238178385
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103406; cv=none; b=AxtkWERpBE3i5MtdFbJdbMcjPYknmBJwvKPU1QUtaTSQ+D3dGNxBnWvslz3aXW3BXcAHQtfDplN5qEE21Wfo9PltbwrEwRcMMF4PlqRGF04mYyI5QZhBhy0MQcRuQUWzW8jEMCAFaKKtlE6tjwWJTQkK5DAM4YdOmPUjvefITqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103406; c=relaxed/simple;
	bh=VS52WzltTszbYB/0AuS6XbIVZSd6jF210Ln2FEwF98Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkxfLThUAGDyeAYLvhj6lC3Gqj8LpLtOFnE7x8VAs1OfpRA4nOKo1uuqd6bkqNkEZ+V1AtJpxmbuTMwbqb2hTwnOYP2edEznn1KcOl6VvnIeUf+09JShEMpVFvrLRnW/sPORSGzZDNrbJf5JroYjcl1CazmM42+A25nRHbDCjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=c1weGvuO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e54287a719so710496a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718103403; x=1718708203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXKCVYj/en67A5jojR7ZOsNjCFi9wMZegvGM7Xga/QY=;
        b=c1weGvuOhkgH6T8P2IUfWxB75718lNZNTsEpzWY3NPoGV2GDM2M79UtUIhuHhFOukY
         cu1JcQ3QW6v46IslS2T96lw9+o5EcCZrBqdl5nyo3Krhc1jZVBF80bSocz+dIu9wNOdr
         IFPDx9s+QwZgJFN12fBqsW+Im9bP86LwndPDgorbRNU4pQkvUILGiqvWsfu5a92HIJcY
         1haQcUC8MIMkt/HDU+eKdawPU/cOb+Tlbm0Ueh2b8j97AX8ixbb9m6PxWSK6hqLsT2zl
         8J/EMdT9XKOgonVEOgiMMKGKybargDKpiAGx/Msyv7SfvsmyGl75po5S4x8SsTCjysch
         ML9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103403; x=1718708203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXKCVYj/en67A5jojR7ZOsNjCFi9wMZegvGM7Xga/QY=;
        b=K+goUdiRg8BurACRy+zBwBeMsGoXyNtRNLL+ese6bbqABPBI545nU5RlrCzDwGS8eM
         8tL4JQlIEDQrxK2WtDH+1C8pMv6PQ4wbv2+0aiHa2W5cfeJOQc473viYxf3dy9uvqXxX
         CRtSyeb04f4uEB3mjWGdNkOVhl6CssoIQdn4nNxcG9wINlhigLYQV4KR6xJg1A98LXEg
         tttmVeoI+REGkkU4XMWMBdRp+KLxcmSHSC1Q4D9pHbLy+qwDnn9cl2VvPBLQ4ZMrAgWO
         317HlESEApAzRlQuE6utiCRRmc9Sut4mxtx94fFkuvvEX5tE3jMDbvPDBlHtbIy9/y2d
         9ExA==
X-Forwarded-Encrypted: i=1; AJvYcCXyvhjeLN+ayCbOr7BpKl+iMGVJVAM5i8AlJ36CXG/ieKJsxPRccSDPFSZrOrMJ+ZFpbGiJXFRq+O3Kq7cO98uTvb5TnKZmDYTNdOkp
X-Gm-Message-State: AOJu0YyPfQmF/49iYoi4Ga84kbGEcDlDbiHdEN0IaYJXT1DI4debUu6b
	BE2/Kt7MNyDEdPc0yzwkj2+TpUHfAe/3sGtWhmEhAof8BlcPkygj7vDithcU/Yg=
X-Google-Smtp-Source: AGHT+IHK8K2V7kQymm38HJCYaowY5rCw46Jeqv5NKPUtVcg9MLXbwyJNHKJq2OnyYuNzXkS/aVN5kQ==
X-Received: by 2002:a05:6a20:4310:b0:1b7:406c:1086 with SMTP id adf61e73a8af0-1b85ac05febmr3167116637.6.1718103403178;
        Tue, 11 Jun 2024 03:56:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042f5584e9sm4812995b3a.12.2024.06.11.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:56:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sGzBA-00C5re-0c;
	Tue, 11 Jun 2024 20:56:40 +1000
Date: Tue, 11 Jun 2024 20:56:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Message-ID: <ZmgtaGglOL33Wkzr@dread.disaster.area>
References: <20240611041540.495840-1-mjguzik@gmail.com>
 <20240611100222.htl43626sklgso5p@quack3>
 <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kge4tzrxi2nxz7zg3j2qxgvnf4fcaywtlckgsc7d52eubvzmj4@zwmwknndha5y>

On Tue, Jun 11, 2024 at 12:23:59PM +0200, Mateusz Guzik wrote:
> On Tue, Jun 11, 2024 at 12:02:22PM +0200, Jan Kara wrote:
> > On Tue 11-06-24 06:15:40, Mateusz Guzik wrote:
> > > new_inode used to have the following:
> > > 	spin_lock(&inode_lock);
> > > 	inodes_stat.nr_inodes++;
> > > 	list_add(&inode->i_list, &inode_in_use);
> > > 	list_add(&inode->i_sb_list, &sb->s_inodes);
> > > 	inode->i_ino = ++last_ino;
> > > 	inode->i_state = 0;
> > > 	spin_unlock(&inode_lock);
> > > 
> > > over time things disappeared, got moved around or got replaced (global
> > > inode lock with a per-inode lock), eventually this got reduced to:
> > > 	spin_lock(&inode->i_lock);
> > > 	inode->i_state = 0;
> > > 	spin_unlock(&inode->i_lock);
> > > 
> > > But the lock acquire here does not synchronize against anyone.
> > > 
> > > Additionally iget5_locked performs i_state = 0 assignment without any
> > > locks to begin with and the two combined look confusing at best.
> > > 
> > > It looks like the current state is a leftover which was not cleaned up.
> > > 
> > > Ideally it would be an invariant that i_state == 0 to begin with, but
> > > achieving that would require dealing with all filesystem alloc handlers
> > > one by one.
> > > 
> > > In the meantime drop the misleading locking and move i_state zeroing to
> > > alloc_inode so that others don't need to deal with it by hand.
> > > 
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > 
> > Good point. But the initialization would seem more natural in
> > inode_init_always(), wouldn't it? And that will also address your "FIXME"
> > comment.
> > 
> 
> My point is that by the time the inode is destroyed some of the fields
> like i_state should be set to a well-known value, this one preferably
> plain 0.
>
> I did not patch inode_init_always because it is exported and xfs uses it
> in 2 spots, only one of which zeroing the thing immediately after.
> Another one is a little more involved, it probably would not be a
> problem as the value is set altered later anyway, but I don't want to
> mess with semantics of the func if it can be easily avoided.

Better to move the zeroing to inode_init_always(), do the basic
save/restore mod to xfs_reinit_inode(), and let us XFS people worry
about whether inode_init_always() is the right thing to be calling
in their code...

All you'd need to do in xfs_reinit_inode() is this

+	unsigned long	state = inode->i_state;

	.....
	error = inode_init_always(mp->m_super, inode);
	.....
+	inode->i_state = state;
	.....

And it should behave as expected.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

