Return-Path: <linux-kernel+bounces-267881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE29418DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3D71C22C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1EA1A619B;
	Tue, 30 Jul 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3u52ZS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CA1A6160
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356775; cv=none; b=jUPd8rOX/KmtQcSQIjI0eY+XXU/T+BndahiTgSyXsNNrLXRgf1WY6bzl3rGjbS1/HqRr7ZakwWSKU5C+EH5IztT3X4oTczdG67JA1KaMgpNgBcPex+ftwx1yr5Iq9GmtoZlBRG/ySiJYfAkzeJ2SwMosfOQdtxYVIN8rte34+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356775; c=relaxed/simple;
	bh=dVkDjxt+MI5jEKXFqONpZnrpH8uhWQCwH8FHk5L7onM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHT0nobC/xXB4HjSx+8aBP9OvA3cstU+FNgQj4v29CsBMff3k148f0+lFdV2X02bn0yKXmInWuNd00JzQr3RWHffuaLM5dgIBUlX5ak1XELOgUTOPM+vm6PZgHqVNr20f9+AuHe5Q/pJXwjc3SoP0bi44zVivzIZACWcoZQd/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3u52ZS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A35C4AF0E;
	Tue, 30 Jul 2024 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356774;
	bh=dVkDjxt+MI5jEKXFqONpZnrpH8uhWQCwH8FHk5L7onM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3u52ZS9c4CL0IWkn7vhhTuSz7XyDFgkSuKPlGIFPE/gD6RSQZnWXREhxRVv/QOCj
	 MNlYP2p1ZGfULYyLtAfd0m4VxV1WDZaOKkCBt8iwz5a9v5LS/PaIjHpdR5SVncjObM
	 zfHw6cQVdGEYbNNsYlIGgNQOc2oe/oPSzJjTy04ullD/sfr/6Sa315KoJlKVJRdwB2
	 s1Vu+IMdkN363Kw01f25oTbf/SPDmbQMCJbQYfS6xhm5PQA6Acp66FMx1DMCoAKnbq
	 GXRnb1Q9SN0/hfUT18wuTGJZn274tUSDtH/xQ5WzdKGU1pzC+hFiDZbrFvju67B7Yg
	 OrW0hM1+CFCCg==
Date: Tue, 30 Jul 2024 16:26:12 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
Message-ID: <ZqkUJAMJzW_4ANhY@google.com>
References: <20240726012204.1306174-1-chao@kernel.org>
 <ZqfCwDcg7nvJPenf@google.com>
 <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>

On 07/30, Chao Yu wrote:
> On 2024/7/30 0:26, Jaegeuk Kim wrote:
> > On 07/26, Chao Yu wrote:
> > > We should always truncate pagecache while truncating on-disk data.
> > > 
> > > Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v2:
> > > - fix to use cow_inode instead of inode
> > >   fs/f2fs/file.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 6c62f76474d1..54886ddcb8ab 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> > >   		F2FS_I(fi->cow_inode)->atomic_inode = inode;
> > >   	} else {
> > >   		/* Reuse the already created COW inode */
> > > +		truncate_setsize(fi->cow_inode, 0);
> > 
> > What if the below truncation failed?
> 
> What about just dropping page cache and do not set isize to 0?

Can we also check if there's any dirty page before truncating it?

> 
> Thanks,
> 
> > 
> > >   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > >   		if (ret) {
> > >   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > -- 
> > > 2.40.1

