Return-Path: <linux-kernel+bounces-565432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EFA667FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2081896866
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ED819F47E;
	Tue, 18 Mar 2025 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nH4o9QiC"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD64A07;
	Tue, 18 Mar 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270612; cv=none; b=p9KFnksW0XsRQa4+nnDIEkSWKngReGtMY34km+Eqh9nldclPfSE+Pk9Vclvg3H7YPeeYrOYOH+4FUpPD1LXTrt0MrAwAlUz3IdwJr1gNh3VrpFDzmhCpxW0zqD4nKQgwLNAd9OCT/xLdiyckx6HPIqoDZR6SEoOtihSmP/5NTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270612; c=relaxed/simple;
	bh=qflsd2BMv2LEQs6Ph9RzFEh1T2NPrSlI3W4drLtf0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfMtuj4D/pgFmrSSJ57kC05/8JMlfgq11c8V+ihnRdBzRPCO18ohOuiuQwhjE6nZZBn0hDouOPpAxyDpNKWw7dDWPVtM5fxBNrUARh3rSE5SsPmDIBb9iChjl/txSHO/GHmGGyA0EKb5NiRZJYXWfGbFAD0eNinIFpM56Ih05xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nH4o9QiC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qflsd2BMv2LEQs6Ph9RzFEh1T2NPrSlI3W4drLtf0rw=; b=nH4o9QiC92nS2qEgGcPiQeEaed
	zVCLj9cxtivit1O1YBUk0aZv2f6ICKuNsDN8BKRnALIK/ZckARTZ0H7NpaKuszh2hfRx2yo02f24G
	TnBSs5ZMdSkjuYw9cLgV89llccPjJf8FK5nvvvlFYvX9nJ2GBFdjwWXi3VnPv5ZmnPzvS9TT8VnrO
	XXE2xJRD5vKMtwNL8Kvtv9twaOtqJ+IqQ1bsuFuiNx4+yv3qiIPKssPZ+uIpyuKXHJJZzHAXspDXp
	M0CoPIfvldUKYUM4X8U8wUSuEdeFuicxjUDdZtX0tEOb3zxboT+jp2FlzBO0p02bsVWincS+AEflL
	M5Dy2/jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tuOAl-0000000EeV7-2cQd;
	Tue, 18 Mar 2025 04:03:23 +0000
Date: Tue, 18 Mar 2025 04:03:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] fat: Refactor fat_tolower with branchless implementation
Message-ID: <20250318040323.GW2023217@ZenIV>
References: <20250318034309.920866-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318034309.920866-1-richard120310@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 18, 2025 at 11:43:09AM +0800, I Hsin Cheng wrote:
> Elimate the need of if-else branch within fat_tolower, replace it with a
> branchless bitwise operation. This can reduce the number of branch ~130
> regarding to the test script[1].

... and for values outside of 32..126 it would give wrong results.

