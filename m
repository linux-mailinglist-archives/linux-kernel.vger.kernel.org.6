Return-Path: <linux-kernel+bounces-412286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C49D0712
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E944B21B43
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A11DE2AD;
	Sun, 17 Nov 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wBF5LxbE"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468101DD880
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731886923; cv=none; b=gWqOQc0L07dpIZJcZuOGS0IVS5dteQQ6b7CWRzphRn/uDd9BrTm6p+w4shqGt8jMI3DMfjlHdC1aHWSrL15RGVdvEssbeKUbhOgIL0Ip0L0zO9l0FfTyB0Tt9HM6b7QKSQPoJcrZgU10KYo0waoLN41nBj3dFHJgZo756sJiedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731886923; c=relaxed/simple;
	bh=qxTOujbTL10cxGD+QdGTBhyG9RaWSm17XBudCi8uBi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzLWdiAKVnVNK5dMLy2z/XXkKc+wLY5ynTqPvx92h1Fg1yJuJcc/gU3d36/wxi7UWx88yMR3CpTrl+BobHvAhqYN8Xg5LElwI41xGjklnIEjOUFRrI+ZTqJp9MoX+ikj5aosVcX1YOk1VKeLMTmGwM7V2uAPtWCUuVUirqXet8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wBF5LxbE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so840555b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731886921; x=1732491721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUTPquA8eQo3SmUaOr4zN6yMlKLusBV0j+4/2JWItaw=;
        b=wBF5LxbEq1PaT3a7msB8CtZvB9UfUUMd6RvXeTP+U2KGj0YeSxvwT8yY0G8WczWIkn
         15J4k9uJ6Dpd6AZfbNOUaRSD3HuYa30JFrAGQSAzQGF7yDEQ972Fyu+HYAti8nnqais9
         1/gT7f2hWhtHVW4KRmBJFdYRx5grtC4yQYlhzEL9PQYuqs37O5iApXLGrWYxvJ6G3gNM
         wN195gi6v/bU6+pRQSs5pNlM+jTCCuahDA3AIfjFOj2YZ1n3sjsUbQd9Nl08Bmz/W8OE
         SMo4zHpIlfR43nZBWpCPaVjPWOvrj4OkjaBCQFn5tcJzdr1ZlX4yV+ICw3LXWBlBLzJH
         XorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731886921; x=1732491721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUTPquA8eQo3SmUaOr4zN6yMlKLusBV0j+4/2JWItaw=;
        b=R1OnuaP8W2AeAeiqwUg8XLPHUw65NW0kSZhWArKoLfuHtLsg2EM58Ab00agcw2ccFq
         L8IcXgZjfi3kRLDnWthninU0SQCc1t9l4dpvwWqYx+r/6lSpY+7DnlYHsRmYY3cVX27X
         A1Nz5eTQ9PoLp6ys4QLMUVlpb6CtuCdcRh8nzEPDPv/0sGfWY+uPFlKmHQsFa/O45bZV
         Sa7bSQM0bSUmqo6acRqSCWYkgqKhvgXRAqnXvKQmFV6M0eCj2xwv1b6BQq1HrypJCM3E
         6l4ffiobBr+ztsXuXbmJukTGDsVg22m//FqMNUd/RLsmK1zOgS2ZeOBicv87gDI8gJvC
         TCMg==
X-Forwarded-Encrypted: i=1; AJvYcCUytlp/NpsazDorRGRvQgeAKPEpI/igmTUXx/a++mtDc9wJG7o3qp6eTTTOePgATGZpVSoKQQUqpevD3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9sAroxjrdZ3wXHbbZiX+OdrxMVbW4GsGU3KlnQ/bAfVGMTETQ
	wBVw+3+2lRTtGxkdibxRlY22LGrgdAiVizlymp1VpULvbDjMop0rRIbAu5kwf9avhtZdaGUInlB
	b
X-Google-Smtp-Source: AGHT+IGiAd1rAkdTifocy8exaCIjQV+CPbeJh6699Tv0xtsUdygH+X0bJrVxisJuCl+ycdb/1IDZPw==
X-Received: by 2002:a05:6a00:a0c:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-72476cad10fmr13213225b3a.17.1731886921599;
        Sun, 17 Nov 2024 15:42:01 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eef26sm4858255b3a.33.2024.11.17.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 15:42:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1tCo8F-00G4fV-1g;
	Mon, 18 Nov 2024 09:52:39 +1100
Date: Mon, 18 Nov 2024 09:52:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when
 calling vfs_getattr
Message-ID: <ZzpztwFlxgz8q6BZ@dread.disaster.area>
References: <20241117163719.39750-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117163719.39750-1-aha310510@gmail.com>

On Mon, Nov 18, 2024 at 01:37:19AM +0900, Jeongjun Park wrote:
> Many filesystems lock inodes before calling vfs_getattr, so there is no
> data-race for inodes. However, some functions in fs/stat.c that call
> vfs_getattr do not lock inodes, so the data-race occurs.
> 
> Therefore, we need to apply a patch to remove the long-standing data-race
> for inodes in some functions that do not lock inodes.

The lock does nothing useful here. The moment the lock is dropped,
the information in the stat buffer is out of date (i.e. stale) and
callers need to treat it as such. i.e. stat data is a point in time
snapshot of inode state and nothing more.

Holding the inode lock over the getattr call does not change this -
the information returned by getattr is not guaranteed to be up to
date by the time the caller reads it.

i.e. If a caller needs stat information to be serialised against
other operations on the inode, then it needs to hold the inode lock
itself....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

