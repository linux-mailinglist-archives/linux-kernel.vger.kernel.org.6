Return-Path: <linux-kernel+bounces-365573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB099E485
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46491C23D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E81E5725;
	Tue, 15 Oct 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSYRKC/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AC4683;
	Tue, 15 Oct 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989475; cv=none; b=RMpR1ZYRklZFv/A28a7UhsxADW5kH6BPJFwUA3pZ5SzN1xUL0eDkPNq0hq2ppY59bVnyIXAfZ2rijLbR2VvhSU3RD3EyP/FY0N0iHDTwXGY9EGUZYtkPBsHkt5lDVCof2dBmFousCFrACiKnnNiMuc4+Oi9IFuF2wPbq8XZ2ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989475; c=relaxed/simple;
	bh=yhtwM+ih4E6+2BNcAKYUr+xWjXfcylje/HzRXgzQnnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFNeRQ5XKSuQiZkLSei5q2GTVvMHuJRg5aVM2earWaGv9UAuuItL63gUl2cyh+qqlEFuMOO8gZ3pOyldYcq8uSf4+K4xGaQe+kKv0BVeZqcBsp3/pAWivJ4c962H+x3FP8zODvW8kQRDWqqsNV6CWtH6y0uHzaDTtLuTneCe+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSYRKC/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F86C4CEC6;
	Tue, 15 Oct 2024 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728989475;
	bh=yhtwM+ih4E6+2BNcAKYUr+xWjXfcylje/HzRXgzQnnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSYRKC/7uzB1PQ/QRQTg+P7JmGZ/JhLOQQbXUwwYpm6LsAhRy5HB7tggyHb5zthKE
	 ShraFLkrk4eGlgAav4WAdLs9z2ihBKZqS7KXQ852RmxbJFJtnyL8jkOMVEAnkDvIjS
	 TgeSGoZlaBNeVBloHesRozLcQMgkURgOO5/LTEFU=
Date: Tue, 15 Oct 2024 12:51:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] rpmb: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <2024101529-shakiness-cognition-dab2@gregkh>
References: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
 <CAHUa44GU=SR9MgBaXJi1yEbvg5Bb73FV4n8erGhN4s_qioKNCw@mail.gmail.com>
 <1c421f69-7bad-4251-94dd-2ebde618be3c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c421f69-7bad-4251-94dd-2ebde618be3c@wanadoo.fr>

On Mon, Oct 14, 2024 at 06:53:56PM +0200, Christophe JAILLET wrote:
> Le 14/10/2024 à 12:38, Jens Wiklander a écrit :
> > On Wed, Oct 9, 2024 at 10:53 PM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > 
> > > ida_alloc() and ida_free() should be preferred to the deprecated
> > > ida_simple_get() and ida_simple_remove().
> > > 
> > > This is less verbose.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > The ida_simple_get()/ida_simple_remove() API was close to be removed (see
> > > [1]). A usage has been re-introduced with this new driver :(
> > > 
> > > [1]: https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@wanadoo.fr/
> > 
> > I'm picking up this for v6.13. I guess your patch set now depends on
> > this patch. I can ack the patch instead and let you include it in your
> > patch set if it's more convenient. Please let me know what you prefer
> > to avoid potential conflicts.
> 
> Greg has already picked both patches in char-misc-testing. [1], [2].
> 
> Let it flow from his trees.
> 
> I'll wait the next cycle to resend my serie [3] or char-misc could take it
> as well. Both solution are fine with me.
> 
> 
> Greg, if you prefer the later, I can resend the serie if more convenient to
> you.
> 
> CJ
> 
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=dfc881abca4247dcf453ce206f05fe09b51be158
> 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=3b0889f95789aa90b0f1a6921d5d6b151f2e53ae
> 
> [3]: https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@wanadoo.fr/

If this is the last users that got taken away in my tree, I'll be glad
to take the removal series as well, so please send it on!

thanks,

greg k-h

