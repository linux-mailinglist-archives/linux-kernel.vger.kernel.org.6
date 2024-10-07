Return-Path: <linux-kernel+bounces-353824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CC993338
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370CFB264DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9921DB34A;
	Mon,  7 Oct 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nNpnL+80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B61D1E8A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318531; cv=none; b=h04e6mxp2MzOQtcfzn3rRcU+a9IlOlD6AGGARpobcmLFaeto3AFIujxlIRqDrvhl3GYWki2V0E5dIbyXCRTAXp1gu3HvWvWse91xZHzlJGqP465im2Y6/zqrAtyI8bidiWr3DDTgsrTaw8uKcsIoSlCWRg2uixtEoxUlu2FzR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318531; c=relaxed/simple;
	bh=9FElrkUmQ6NFjY7jBFyppoufzoOhZX4NBa0sJz6abqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbyQpo4r2IuBWhDHPRQBoD5FXcYOvALcN61DzFGeKC61mIM6fTaKFzu6ysd1h7ZHUfLTY2c19Ifsh4r1mPjyILQn5sWKvY8AGSIQupBBWb2MDgQqbqHmmWIGANgDHSJATw19Kt+kMfi4aK2QPID9kcIJdYytyDnfrhPD4zBaKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nNpnL+80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B18C4CEC6;
	Mon,  7 Oct 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nNpnL+80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728318528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ilJfs6VwyezGkqdIQDo26qMLuBPXCOOn0/kg2C0MuA=;
	b=nNpnL+80WI/BOztRB/jqPyXCsNI5orRVV9Wd6MchqCBWOyV4W135834smfjaDQjd1xs1Fp
	c6SY857OpJNBGYJ1EYSWZANS28DzofmGclsTvS1y55cw2AjK6nUC+AQ+gXCphQ0cwWJh5K
	JhRnf7zX697PQOG0hPvpH0vTGESDbOs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 404bc7f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 16:28:48 +0000 (UTC)
Date: Mon, 7 Oct 2024 18:28:46 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
Message-ID: <ZwQMPmfG5zDGz1Wr@zx2c4.com>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
 <Zv7HcuhVH1uM9BNI@zx2c4.com>
 <EF78F2DB-7219-407B-9017-990462128B13@ellerman.id.au>
 <Zv_1tqMf-RIXapBD@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv_1tqMf-RIXapBD@zx2c4.com>

On Fri, Oct 04, 2024 at 04:03:34PM +0200, Jason A. Donenfeld wrote:
> On Fri, Oct 04, 2024 at 08:52:40PM +1000, Michael Ellerman wrote:
> > 
> > 
> > On October 4, 2024 2:33:54 AM GMT+10:00, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > >Hey Christophe, Michael,
> > >
> > >This series actually looks pretty okay to me. I realize ThomasW is
> > >working on more generic cleanups that might obliterate the need for
> > >this, and that may or may not wind up in 6.13. But, I was thinking, this
> > >seems like a good correct thing to do, and to do it now for 6.12, maybe
> > >as a fix through the powerpc tree. Then ThomasW can base his work atop
> > >this, which might wind up including the nice lr optimizations you've
> > >made. And then also if ThomasW's work doesn't land or gets reverted or
> > >whatever, at least we'll have this in tree for 6.12.
> > >
> > >Michael - what do you think of that? Worth taking these two patches into
> > >your fixes?
> > 
> > I agree the series looks good. But they're not fixes by my reading, so I'd be inclined to put them in next for v6.13?
> 
> They're "close enough" to fixes. The get_realdatapage stuff is super
> wonky and weird and it's quite good Christophe has gotten rid of it.
> Returning NULL from the generic accesor function never really sat right
> and looks buggy even if it does work. But more to the point, given the
> other scheduled churn for 6.13, it's going to be a tree-clashing
> nightmare to get this in later. And this Sunday is rc2 only, so why not.

Bumping to top of the box.

Jason

