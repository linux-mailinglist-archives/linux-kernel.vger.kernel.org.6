Return-Path: <linux-kernel+bounces-353870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872829933E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D9285DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117C1DBB1D;
	Mon,  7 Oct 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxidwWF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FD1DC051
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319796; cv=none; b=BC/qMypmLF5HYwCP776XTMZROAV0k5SeWX8Tc9mEwQgWpPsoOqrxUH8fc2vhzXPXUH66j0lAF7F9Dqqs6SmzEMdeETWob68xI5UwBFnrTnIu5ZPf5/q5oGShqdUlDJf2phfUmbrUrQ5sxgSw7sZpRZP/tOerm9V9EcLRmo63vXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319796; c=relaxed/simple;
	bh=QSEWGceGF+zqW4Mxm7quS90OIzr3oPTDd3vjuevYd9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEmSgY7QNxX+IP/5smb8O91rrj61yYr6SXmDQ4A61F6R335HtJRlhJDvSJSQkfBZ8EMqHrRFsUMgWAyPsojkuIc5vJvE8X9boLnHKkfB+91LZIT9HO/wIUkj9hB6DxOBoViHfKDC3jFFHXQu/fGSldI3LQjsKzCYkshk2rlo2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxidwWF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BB0C4CEC6;
	Mon,  7 Oct 2024 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319795;
	bh=QSEWGceGF+zqW4Mxm7quS90OIzr3oPTDd3vjuevYd9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxidwWF5tOsu57/gIOobA09HS9QboVYxvrlD7pq23ZIbz7SUm4c3GAlgi/yljMb8O
	 HzJf37CDNJZIUKSBVuN0fc4Y+TyClDXdb1baExy4dU9lrMSV8sZ+09s7SB80MFKS6J
	 woWjs9wBvCB9aHDQ16wtZpSYc+KqvlzXkwEBJxbqWQCVJSnUrZwHp0IiT5lfCyLwcT
	 iekqIhB+8BAvz5tyU/qfsq4df43HoMVo2EWJ2gSRiu6D2KfXqu1GXFNqCJ1fmn2LC4
	 zdrGv3fG0K6jK3Rfa59/Gp1eBTew0bnsIzmW40L3GadWjrQAsk2IIC5G7MVahPHvON
	 OekUjVUbduvgQ==
Date: Mon, 7 Oct 2024 16:49:53 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, xiuhong.wang@unisoc.com
Subject: Re: [PATCH] f2fs-toos: use getpagesize() to get default blocksize in
 Android
Message-ID: <ZwQRMe9a6oXKLCq5@google.com>
References: <1726283507-16611-1-git-send-email-zhiguo.niu@unisoc.com>
 <CAHJ8P3+=Ft_LOWHXPDdXQnQA=BsGhDLF0KYWWD6T3KHB-TEgWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3+=Ft_LOWHXPDdXQnQA=BsGhDLF0KYWWD6T3KHB-TEgWg@mail.gmail.com>

On 09/19, Zhiguo Niu wrote:
> Hi all,
> please ignore this patch,  we can resove this by "-b" parameter .
> thanks!

Ok, thanks.

> Zhiguo Niu <zhiguo.niu@unisoc.com> 于2024年9月14日周六 11:12写道：
> >
> > When 16K page/block size is enabled in Android platform,
> > a error maybe detected in mount process in kernel if "-b"
> > parameters is not specified in mkfs.f2fs.
> > Just as the following check:
> > if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS)
> >
> > So use getpagesize() to get correct default blocksize.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> > ---
> >  lib/libf2fs.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> > index ecd22d4..98ee0ae 100644
> > --- a/lib/libf2fs.c
> > +++ b/lib/libf2fs.c
> > @@ -685,8 +685,17 @@ void f2fs_init_configuration(void)
> >
> >         memset(&c, 0, sizeof(struct f2fs_configuration));
> >         c.ndevs = 1;
> > +#ifdef WITH_ANDROID
> > +       c.blksize = getpagesize();
> > +       c.blksize_bits = log_base_2(c.blksize);
> > +       if ((1 << c.blksize_bits) != c.blksize) {
> > +               c.blksize = 1 << DEFAULT_BLKSIZE_BITS;
> > +               c.blksize_bits = DEFAULT_BLKSIZE_BITS;
> > +       }
> > +#else
> >         c.blksize = 1 << DEFAULT_BLKSIZE_BITS;
> >         c.blksize_bits = DEFAULT_BLKSIZE_BITS;
> > +#endif
> >         c.sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
> >         c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
> >         c.wanted_total_sectors = -1;
> > --
> > 1.9.1
> >

