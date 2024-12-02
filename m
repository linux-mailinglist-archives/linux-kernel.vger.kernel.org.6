Return-Path: <linux-kernel+bounces-426894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48C9DF9E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156C7162B93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55D1E25E9;
	Mon,  2 Dec 2024 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tzYEs8Yl"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01617C2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113786; cv=none; b=TmSbsCLjcxmVQLjeqUlg5JAQOfeG+xcOmzK7mHtgFbTCSq/gwPfRu9iNIVAk7Uq1MC42BnFetqprYuZdjX2MiimA/Ij9AvaUSszc1l1FooYRIyP5Dmbb8ckS9VdY7CA0c3dYC23mo3FGaqYQ4WvMG84WnEhrnFGAWDrEFw9jlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113786; c=relaxed/simple;
	bh=48TwfSPMPybbln4L4VHaWpUK04g4lWpmL78knpalAlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1qTLXM55Q+8qMDo/B01QpMPZrBhXpbcJS9wPYiI5wfRdthuCJxh0Sfi+2jacpAC3Tdte099CoHFY3BGiRc0kS649EW8f2rgP723Q9Z7VUC72GjbwhSKZFtRQAX0ks+2ASGqQjt4w2MY0Iz9qKBYR9wNb8Ad8QGXNcwc5R2YnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tzYEs8Yl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=kthWi9C2WGLqY2eitOOOeCclXFg+ZXISrj2feTHlTB8=; b=tzYEs8YlrqV5gXEYfTy9lRjUeb
	zBwiZm2SlAobzc9lg58bui++MX/uGeAUu9gPdGJG4zqhkzkHymBu68pnl8JcZ7DVujkZl2nXbY4O5
	bpnqlbxUuOgdTtbfKcr8pMG9NfKR0+CjE0anYZGwknGftUG6kunHvrZ+blqoDt2Zr+ksQID+o1gLZ
	0nJ1h9vxyVpENfA7g5E0+zhb+W+JZqcNniK66Nk0Hw2ozmOz/38O6jHX/WHsM4uc61pD2HR3Sc8+0
	SKbYmI6kZ5Bc6XPSd86mIsJc3Nr8fjveo3s9+bxbmAYsBuhWsrX4Mt3li0mLObZ/GijShETflZIyx
	rJmo9XAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHy46-00000003v4r-0zpc;
	Mon, 02 Dec 2024 04:29:42 +0000
Date: Mon, 2 Dec 2024 04:29:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <20241202042942.GN3387508@ZenIV>
References: <20241004184440.GQ4017910@ZenIV>
 <20241004195132.1393968-1-brahmajit.xyz@gmail.com>
 <20241115050358.GQ3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115050358.GQ3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 15, 2024 at 05:03:58AM +0000, Al Viro wrote:

> > fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
> >   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
> >       |                                                  ^~~~~~
> > 
> > Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> 
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Sorry, hadn't realized it had fallen through the cracks.
> Christian, usually you are handling vfs/vfs.git#vfs.misc; I can put
> it there myself, if you prefer it that way...

OK, in viro/vfs.git#work.misc for now.

