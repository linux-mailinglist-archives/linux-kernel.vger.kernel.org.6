Return-Path: <linux-kernel+bounces-242995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3429929000
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14576B21A4F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73FA95E;
	Sat,  6 Jul 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l3dK/Fth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AF29CA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720231823; cv=none; b=OJJOrQCP6k4dpwh0TC5cLlGQA4k0+kTxm7EuVIGtYhLoCIfeDK2JC7g2LEKU+bdrWgQYfSCXhVTtlxPNgKgW4gOgV/3p2/q5nXFMmsz614q5vDHgaFdfYH9aKHBU9ENFcf47sxxYq135VGv5oHymVu+U6Jocws1PkTBZG467p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720231823; c=relaxed/simple;
	bh=DMLyCMONF54Q+IgQjEZrrmK+niHcMmjAxdxFlL7dVoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q38D8dW9WK+A8Poj7XiuDofUWfyYsWTzrgcFpxIAWbE7BapAoOXqUW52bc3zgGb6Hymfw/oPcW3upeAVeHXrX4FMItYB4R/tLV2XvGi/++fr+iPRjoD1GxCdX2c5LedNrOyxVB+BoMfdaISnOTe7/ImZuJSxMWQjSAs3uIG0Mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=l3dK/Fth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C58C116B1;
	Sat,  6 Jul 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l3dK/Fth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720231820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oP7pKA2w2OGlbpisVwia1gxr0eOIYBDmJqs/kafeUWo=;
	b=l3dK/FthgJajzCC6gJq4H28OLw8PZbc1UMWBmzvQvsOmCT32tpIhCI5BoPnKi+oo4hv1jb
	U7hfynx5Qbq1xSLH7kmLxi6bWF0LgpceksObszwmIS6Cufxt5Oy4xSKWPIV/0mqIefdNOE
	rg4gOrXL5HRMUnBesItnOBHWQ7E7UsE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ce7407b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Jul 2024 02:10:19 +0000 (UTC)
Date: Sat, 6 Jul 2024 04:10:17 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <ZoinidZQY6hU99XT@zx2c4.com>
References: <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com>
 <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com>
 <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
 <ZohB6uPAVX03Sc96@zx2c4.com>
 <CAHk-=wgC5tWThswb1EO5W75wWL-OhB0fqrnF9nR+Fnsgjp-NfA@mail.gmail.com>
 <CAHk-=wjwU6o4QExra5qNzBxtX5NwTfaX8ytZKk8BFtOng6zqSQ@mail.gmail.com>
 <ZoiLzzM94m_sjfVK@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoiLzzM94m_sjfVK@zx2c4.com>

Hi again Linus,

On Sat, Jul 06, 2024 at 02:11:59AM +0200, Jason A. Donenfeld wrote:
> What I have in mind, IOW, isn't fanciness. But alright, let me run with
> where you're urging me and see where that takes things. 
> 
> > Side note: you could just stick the size as a constant in the vdso too.
> 
> Yea, this sounds more like solution (4) from my last email. I'll give
> that a shot and see what it's like nuking the syscall. I'll ping here
> when v21 of the series is ready, and hopefully you like it more.

I'll spend the weekend doing my own code review and fixing things up and
working on commit messages and documentation and all that, but there are
now three simpler commits in here that implement what I have in mind
based on our discussion:

    https://git.zx2c4.com/linux-rng/log/

The selftest code is the largest part of it. There's no more syscall. I
think it should be much more to your liking and seems like an alright
set of compromises. Hopefully that's a bit closer to the mark.

Jason

