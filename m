Return-Path: <linux-kernel+bounces-380446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0B9AEEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E075B215CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0A51FE0FC;
	Thu, 24 Oct 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrXkB456"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406EC1EF958;
	Thu, 24 Oct 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792401; cv=none; b=RfYLy2i05HNSGqNBjjjPK+DTsIFO40hlLaH8f/9gjMA5D4gMx5x98qIlv+mlU9JwVwH9EvVHr0X/0OwpcxLIPNQ9qkQfaxt9jDcw1ISYq7F0n5qKMMovD+Jog7LcRIH1Jg2srVhp5Yg6HW5Bk9FSYSNncZSLmVfu1nH4gFg0DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792401; c=relaxed/simple;
	bh=97XRz7peIuJVQC43k4/ySRQsyp3Yj1gdZ3QpFFd9A1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnbMKrTpOurVX430FvAL/lb1ETD6pmqzJeaVRXkPuMAY5XCU5D3Vq+GIB04gkSfVFyF1u/0HqiT489v9l4e92R6+LAG4ORxnbej5fjGIi3ptNwUU7X8rvtNrSU1p8gNumpsIeui2rYvLG8Jqjzl/0eMzOHj8MxUrLSBcCAPYDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrXkB456; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72AAC4CEE3;
	Thu, 24 Oct 2024 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792400;
	bh=97XRz7peIuJVQC43k4/ySRQsyp3Yj1gdZ3QpFFd9A1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrXkB456NQZ4h8TJqF6MtBj691/WRDz3oXQasTSMa896eo3yzm9xjYg5L9lSyPGqC
	 PTK5WR5TVXdcigZTrfKd73qRxgrhrT7/TISKtc1FfXaCTzkxiMGGFZ56cFzT1y1vDy
	 9OR5OzLzaLRWr+N1xMTqurE5nRMkyXTFXKengvHAfjcsOBNb+DLkobK2Sqtiu9F2zE
	 0R7EjPsLAkJJ7q1W2mRYgq6CMuMzmNxfjU2w0phnASRcJWC0iYw9wcdeAbCQQHjEJH
	 4zJctfOwsoD83uzHPUCnfpov1pdvAS2+X3CCc0KJD/X5MLmfOL+gEASVBxwc1OOTbL
	 6wrkKaC1TtqIQ==
Date: Thu, 24 Oct 2024 10:53:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxqJj9IZ2GF3IStb@bombadil.infradead.org>
References: <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024024928.6fb9d892@rorschach.local.home>

On Thu, Oct 24, 2024 at 02:49:28AM -0400, Steven Rostedt wrote:
> Now I have to ask. What's the benefit of pushing to linux-next over
> waiting for the zero-day bot?

0-day only does build tests by default, there are many places which have
actual run time tests which *run* off of linux-next, those are both bots
and human. Granted you can get your own run time tests out of your own
branches but that's on each developer to set up and a developer's test
exposure of just one branch is small compared to linux-next. For example
I've seen obscure bugs creep up on linux-next for modules which only some
odd arch or setup was able to capture before which no test we had during
development was able to capture. So more exposure to system variability
and test variability.

The other benefit is you get to see *way ahead of time* possible merge
conflicts, and if you can coordinate with the respective maintainers
which your code conflicts with, you can prepare so that this is smooth
sailing upon pull request to Linus.

  Luis

