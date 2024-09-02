Return-Path: <linux-kernel+bounces-310824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10A9681AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E8FB2097D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B6185B68;
	Mon,  2 Sep 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="Getyq49N"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F1185B65
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265564; cv=none; b=Lh7LeedETCkgeyN4cDljRcDOGKngrPruwRLaKPSetHsRdYyv0zMBEGdTfyB/l45qNJvQrkMjf6VMhCdMSYNesO+HhInnrBdcM0NOc8Wx7vqdVlCUeaYHB2ayh8fnHnau6VqkIu8oNGJFNv3jeMB7SxYEx1j2C2dMXuQIBnj8Cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265564; c=relaxed/simple;
	bh=kZVo2xER+nRGPKkvLJQ8OP6DwI+lbFckrLmznME3TpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnr/3dBGqhVwP60pHP6ZkL4Y6+ZNosG2H/EGq5vm0RmOVBzYrttHr0O9NCW6EbcY/krYe7ZcmnYVyQPwdE6y96koaHpa9Izqt0e7pliGllR67TJQYUVSZUJquNx5cPB0v+s/qpYqIU3+p9xPxNdKgLkZSrNd/+FT2ta+Cl/EbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=Getyq49N; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 567E9697D1;
	Mon,  2 Sep 2024 04:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UhT3U5zyLILdoM1tyZBb1t7DNlyeif+DRzYH4+w3qmw=;
	b=Getyq49NqDeqVZkMt1QZ3Cf7CeW/swOruiVOs46r332V1ZklA6kLb0igYL308Q1rFQSox7
	H3K2Ghbq0h7pdLPUV5wnYk/meW7nmTDALMhr62sUm5v344Hc3l4XfUJwYc2C1xcsqjOHuF
	mOnE0o6TAneEwd/9Et0FTLZK3pYvZguSL/J5GJg0Gc4oN6R/yM/8VMC/9Q8jOt3m2y7GVK
	vWj/57/Ces9DGLRnfu0zcvERy6orpt2GiOzOuMj3wqWVN6jvABohHF6Egm3Yjdye5HVg/K
	bSW2vtpfCY35T2hztsmE4ohsfrjUHWRv7XGsvZwPZmwkaAjpNRdhUYg6/fNKow==
Date: Mon, 2 Sep 2024 16:25:52 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] erofs: refactor read_inode calling convention
Message-ID: <7d5r3gf4drcyraiahnuwo6ia5czursu2s6bd4jo4fcizhgwqhk@6qwnh7kn53qz>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
 <20240902080417.427993-3-toolmanp@tlmp.cc>
 <1cbbd501-bd81-4df8-a887-8c07e0469ae1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbbd501-bd81-4df8-a887-8c07e0469ae1@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 02, 2024 at 04:12:31PM GMT, Gao Xiang wrote:
> 
> 
> > +static int erofs_read_inode(struct inode *inode)
> >   {
> >   	struct super_block *sb = inode->i_sb;
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > @@ -20,20 +45,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
> >   	struct erofs_inode_compact *dic;
> >   	struct erofs_inode_extended *die, *copied = NULL;
> >   	union erofs_inode_i_u iu;
> > -	unsigned int ifmt;
> > -	int err;
> > +	struct erofs_buf buf;
> 
> Should be
> 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> 
> Otherwise buf itself will be left uninitialized.
> 

My bad, i forget this when rebasing. will be fixed in next version.

> >   		inode_nohighmem(inode);
> >   		break;
> >   	case S_IFCHR:
> > @@ -269,7 +266,6 @@ static int erofs_fill_inode(struct inode *inode)
> >   #endif
> >   	}
> >   out_unlock:
> 
> I mean since `return err` is the only useful statement for
> label `out_unlock`.
> 
> You could just remove it entirely and replace all
> `goto out_unlock` to `return err`;
> 
> the name `out_unlock` itself is also meaningless due to
> this patch.
> 
> Thanks,
> Gao Xiang
> 
> > -	erofs_put_metabuf(&buf);
> >   	return err;
> >   }
> 
Got it, will be fixed in next version.

Best Regards,
Yiyang Wu

