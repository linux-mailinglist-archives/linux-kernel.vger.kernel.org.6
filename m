Return-Path: <linux-kernel+bounces-175612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84348C2298
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D116B22A74
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160C16D4E5;
	Fri, 10 May 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAhuMrqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27375168AF4;
	Fri, 10 May 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338539; cv=none; b=IPduIAFRpJLngrPDfbbclm2WgmXD0oLrsLrUbO5VL1MaqbPbbav+xy+XVQ1DiXInVvK18qSGY1L+K7X9sw4jYXrQ1s6lR1U52hoJwgtriLygoHz2L0GWU1+p9NH4FXEdu6UOoYPKD7y0EcrqUfpddhrYs+tanK6hyg4szp+DhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338539; c=relaxed/simple;
	bh=3RLAuGF0/SkubgGqr81HXENZp8CeEDdU7Is1crZ3K9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEYURWeGJ/q41JwWF69GncWy9YqroUh2C5JX7n6LXCMhFNtVnuy3lRlGf6Er30AJrEaAGXeydd34z+NvG4MkoujJjqIJCz02WQS9kcz4gPsed6x0Y3fdM7ti2qyZ7km2sAqUTYgLKblZN1R7es0eeHOFmyyA46IvYjmcpJLuzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAhuMrqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F142DC2BD11;
	Fri, 10 May 2024 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715338538;
	bh=3RLAuGF0/SkubgGqr81HXENZp8CeEDdU7Is1crZ3K9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAhuMrqNrc8yn5jVWXFn7GPRrBN8y7V/vwv8h2mY/wXj3euox2C4isv05myPDDV5q
	 og6nQb+CIEuHNLZLFoOgncqL6lIaUSLtTevSdZ7+KO8wvZ2wdD7IN8NUOA7KtaBwLS
	 8+DDn5ftDCGo4fdlbW6fUVVzV52a7V9c5MUrFX7I=
Date: Fri, 10 May 2024 11:55:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Huth <thuth@redhat.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 5/6] tty: hvc-iucv: Make use of iucv_alloc_device()
Message-ID: <2024051023-tapeless-hardener-593d@gregkh>
References: <20240506194454.1160315-1-hca@linux.ibm.com>
 <20240506194454.1160315-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506194454.1160315-6-hca@linux.ibm.com>

On Mon, May 06, 2024 at 09:44:53PM +0200, Heiko Carstens wrote:
> Make use of iucv_alloc_device() to get rid of quite some code.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/tty/hvc/hvc_iucv.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

