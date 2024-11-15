Return-Path: <linux-kernel+bounces-410215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF619CD65B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4F4B23713
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57389158DB2;
	Fri, 15 Nov 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P5QzXDSF"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546364D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647042; cv=none; b=YacZHCL71U9+AWf8aoxSax5Poa8f6Kv7uoGAQX5icbze9bG+OL0QQNIo814z73jAP0Qn9/Je88xpKKjN3Xhpnv+tSgbOJN61ATvvo3tT9xDfwaV/eLBt++wtpHWpIGblgFxwPvoUD46/xqYIsS04u0wXWHnsTO3mHJTDLABacfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647042; c=relaxed/simple;
	bh=+zkEFCX+zIlBB60GBuopzPZPOVnEg7Z6jjFXwW5uB4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE/qpxiu09at5xJ1mE0uMw0c+vca+xBhtSUHhNz4JoeTtot/41c0jw7fWZXaI2+ieGYPTEWfixdqqf3FQawo98j5EyjZXeICJq2Y/NfLEE1T8jAsPARfe3kPHNwMvrf+5yTPQQXmk1M14T8h5qXFoGPH2k+27c4+Ec43ByorYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P5QzXDSF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=vhNjU7bG7G8RiChf3xBxTvnXfsh3FvudQARf5DW0egU=; b=P5QzXDSFcmC18KW94EfcxFdKxc
	oOj4Q861pZO2VVbrqFJ5JEcZiF2s+VpBupdZnuvbGPbH0qxw/N06G36P1iZAz4kqwN9W3TvBx8cEb
	kHMKsJR587wuhKIx/UB9rVZNbOb6sg0yOnRXI6uyVhXjuqX43enqwfT5pFLkx4Ky4WW+EfKLo7DBc
	IGcJLYO16LQ3TJfq4iYcqglF8JeG6EJCSFKjZIpP9CksykxTR2tHZSPCxNxIs3cqHnZ0oZUeTQBDK
	okyzYqUxscoLdeH6VwWXrtvuR1cHp2qK2YuDOyr/t9uMCaf5DPoVt+dqgeiTe21iMrtcaH69VAH3p
	DxObgsJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBoUw-0000000FCa7-0XXE;
	Fri, 15 Nov 2024 05:03:58 +0000
Date: Fri, 15 Nov 2024 05:03:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <20241115050358.GQ3387508@ZenIV>
References: <20241004184440.GQ4017910@ZenIV>
 <20241004195132.1393968-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004195132.1393968-1-brahmajit.xyz@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 01:21:32AM +0530, Brahmajit Das wrote:
> qnx6_checkroot() had been using weirdly spelled initializer - it needed
> to initialize 3-element arrays of char and it used NUL-padded
> 3-character string literals (i.e. 4-element initializers, with
> completely pointless zeroes at the end).
> 
> That had been spotted by gcc-15[*]; prior to that gcc quietly dropped
> the 4th element of initializers.
> 
> However, none of that had been needed in the first place - all this
> array is used for is checking that the first directory entry in root
> directory is "." and the second - "..".  The check had been expressed as
> a loop, using that match_root[] array.  Since there is no chance that we
> ever want to extend that list of entries, the entire thing is much too
> fancy for its own good; what we need is just a couple of explicit
> memcmp() and that's it.
> 
> [*]: fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
> fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                         ^~~~~~~
> fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                                  ^~~~~~
> 
> Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

Sorry, hadn't realized it had fallen through the cracks.
Christian, usually you are handling vfs/vfs.git#vfs.misc; I can put
it there myself, if you prefer it that way...

