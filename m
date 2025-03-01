Return-Path: <linux-kernel+bounces-539787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F7A4A89C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C923BBA5C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 04:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99251B414F;
	Sat,  1 Mar 2025 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH/lMEfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FA16BE3A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740803995; cv=none; b=EXMvukciFjDNQfX7s4lA9ETlFPuVNHIy1EeZMziAsevk8bUlc63ryEcFkk1N6Hvd7inoGL+90bJJfN/ltiAWOVAUpyM+ooc6tQNJQOi2M68cvYUaOkv8J21uvTD1C5X75iTcHIRZwrq4ovS0kvZV9AVZVjx1gMrhaUsPK97rNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740803995; c=relaxed/simple;
	bh=cthizsVH9XEvy/+Wq2qKLDOxSqhYdJN2GBeD/Fh8bYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUc21UsynyduzY/0e8K1k6Clh1cExMV2KSZWEW6R+a7l0bOc4zYrrLfRca3uRuqQaX6EMTwgQESikwIV5L/4mqjBqt95fXuO+I3zmWp0MvxCku0ZWQoEhf8N3rfkg1kXIrF79YvP+yVeCYXzHS71zcOi8WPpsy6OiZXlBK+oBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH/lMEfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921E4C4CEDD;
	Sat,  1 Mar 2025 04:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740803994;
	bh=cthizsVH9XEvy/+Wq2qKLDOxSqhYdJN2GBeD/Fh8bYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YH/lMEfI07cQfym3AM2ngKc0hTnPiHCWT1PztoN9wMV2vf6/IWksUL2whtm4Gt43+
	 KqH+B0aZ8MuLl8zAGM7U0W7Gdjf+dHpBjY+VchUKdr9ErivvplMIgoha2xviuPnHip
	 uoLvDVsh8Abr1UGO3BV26ldjxMdLSWePSWbgvVQNzk2gKef7qFOrnWRlu1gAg3KYLT
	 JIWuuKJqSe3++BZj19RpXtEnvcHNa291mT2dgRWNDLdxAZ9ol3W3r8I7d6+KOEQUhj
	 B2xU5VCTcEkAXQMM84Z9Ualtc6fHXMUnxaDZQU5GW6ozgQtdujmUBotidvAX1jHtem
	 m3Ri0S4uhp5cg==
Date: Sat, 1 Mar 2025 04:39:50 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Keun-O Park <kpark3469@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	Keuno Park <keun-o.park@katim.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than
 linear_region_size
Message-ID: <20250301043948.GA27296@willie-the-truck>
References: <20250224062111.66528-1-kpark3469@gmail.com>
 <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
 <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
 <CA+KhAHYDui3VkebjxZLnN_ijMUzJf2BRMqtPqqos+rCbf8J7Ww@mail.gmail.com>
 <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHyZ5_+ZrcRtdx4X8LA+mzCNcXUZM_3QcEudYGbuGBq0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 28, 2025 at 02:11:41PM +0100, Ard Biesheuvel wrote:
> On Fri, 28 Feb 2025 at 06:55, Keun-O Park <kpark3469@gmail.com> wrote:
> >
> > How about adding a warning message in case of linear region
> > randomization failure?
> > And, there might be two options in my mind by now to consider hotplug memory.
> > Either giving an option for users to override "parange" as kernel
> > param or providing the legacy way((memblock_end_of_DRAM() -
> > memblock_start_of_DRAM()) when CONFIG_MEMORY_HOTPLUG is off.
> > Users believe KASLR will work fine by enabling CONFIG_RANDOMIZE_BASE.
> > In case of linear region randomization failure, I think at least users
> > need to know about this failure.
> > Can you share your thoughts on this please?
> >
> 
> Randomization of the linear map has always been a best effort thing,
> so I don't think this is a big deal.
> 
> I wouldn't object to the new behavior being conditional on
> CONFIG_MEMORY_HOTPLUG, and fallback to the old behavior otherwise. But
> ultimately, it will be up to the maintainers.

Personally, given the confusion that linear map randomization seems to
cause, I'd rather reduce the number of variables on which it depends.

I also wonder whether it's actually useful at all...

Will

