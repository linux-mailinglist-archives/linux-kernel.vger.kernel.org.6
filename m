Return-Path: <linux-kernel+bounces-306230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC726963B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DD1F22902
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F381598EC;
	Thu, 29 Aug 2024 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uYhmDQtx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A9145341
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912971; cv=none; b=HB/j8QEnuBItyO27CWzSOTwD9SxKWGlXn48mGWzs6pqXBJmZ0LhamSW1pJ45guMtdPWXG3W7sFMr4PHWcZ/ljmbDQGdHAgc6rZtJT152GKSFrQQfeRsndSljASdj8T3WS1SBdQu7pQo4MOi/4PrSGE5+++HZcUNH/D6ioxOJBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912971; c=relaxed/simple;
	bh=LOWmdAlWScPbeBU/ImaiL422GzBuK7DLt8fMeGU2dzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfifLF1B69fLhPpJd6/v7ElTsf8Lv60d0hPAqkDsoZWKUcHakjaXqvbVWC2mnT7jCDb+XVx00MzfsgYMjfyxAl9w4MyQGQgE72VWnVejfZSOcEHgAdsNA8Alyz3s1oat77KLcAbwwMOzPh1V0pQ2xyQxTrzlTbEc519dxeH0UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uYhmDQtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7D8C4CEC1;
	Thu, 29 Aug 2024 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724912971;
	bh=LOWmdAlWScPbeBU/ImaiL422GzBuK7DLt8fMeGU2dzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYhmDQtx+tRD2yBwxwxRwvpDJY/bgtVoypB/GhYsc/+1l7q6zQkw6Ct5wUtFIMQ0L
	 iuUyZ0qBTKBvZqUOHxUKI0T6uMPHDMoB/7d83li9mJpoHBVTP8Q7W1J69rUTm867KS
	 /O/u6wiDxl0GtUF9nxBOh9mjfB5hGSAOgWijcFoE=
Date: Thu, 29 Aug 2024 08:29:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: WARNING in __kernfs_remove
Message-ID: <2024082917-yield-winnings-31dd@gregkh>
References: <CALAgD-5uYCK+Y5N431CwLXeN0ahJtUde+CovAYexVZyNqDBSqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5uYCK+Y5N431CwLXeN0ahJtUde+CovAYexVZyNqDBSqw@mail.gmail.com>

On Wed, Aug 28, 2024 at 03:03:33PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a logic bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.

A reproducer would be great, otherwise there's not much we can do here,
sorry.

> 
> Bug report:
> 
> team0 (unregistering): Port device team_slave_0 removed
> netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2
> family 0 port 6081 - 0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1090 at fs/kernfs/dir.c:41

So this is a lockdep warning?

Patches to resolve issues like this are greatly apprecaited, "raw"
syzbot reports are not much good given that we are drowning in them.

thanks,

greg k-h

