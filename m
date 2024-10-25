Return-Path: <linux-kernel+bounces-380880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F489AF73D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5761F228AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886D13792B;
	Fri, 25 Oct 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/f8ApCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8960B8A;
	Fri, 25 Oct 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822063; cv=none; b=FBQfghPNxgnlngkLoe9HGBX4h2gv8TpniFvEmxJXn5188XpDdmaxZwL6HzvMpva+9t/nHMgfGNd8R9tg64MKFnKSj6GoRMKyPAtUBBbr+UxCoFvJ9JPzEQ4PMPUlLlotu9IS1dGfW3dEpyi3anZ/4ZrJrmsXX1WIlxAaopzba9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822063; c=relaxed/simple;
	bh=KatEv+Przk+OAhtQT+2T4+Qs0MzBzE84EJjVF4TfGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLJfj0V3glXTdpYhAvjYCxeT9r7QM7a9pcgngmxUuVfKZzeOznxJ0+YVf7u4ttf64/jzwrfihlqDvucf/Rgp6ojM1lsS8cnv/GRoWYIQLZ8fxlFboP7uupCbt+tyKM8az50KqsEtRkXKiPLJLjZVm79xQkkv/H/IAl2LUESvBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/f8ApCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5CC4CEC7;
	Fri, 25 Oct 2024 02:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729822063;
	bh=KatEv+Przk+OAhtQT+2T4+Qs0MzBzE84EJjVF4TfGQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/f8ApCL/mW4UhwDatK2nNtSH5UbdrXGDof5IwtjnbSc3D5GYytmFB6FZi5Ycb1t/
	 6rzcP2lcOzk97LA8hO+tSuLE9Z8CqHVURkjsb8mVa8Z2KVI3OV9bkQlH4SpAjIEKue
	 X8XI3UqAjobOPUk/KyOTrXMZk79UY2n2PkzOGG/VcS6M/3lRdNXHsGWRPhlsoFyrdy
	 8kbVB3eWlBOfdqO7z0HX6tyJmNBHbDjNZPGM7bzImAnyoKiE6QjzntKV18GzYT5LLy
	 FD0gekSDEUGiLDeQ5X1UFXLppU5FPwZDHqd1lUxU3aRKKcvwqbHhV4Ir6MvW/LnKXc
	 4QMf3eJNjZazA==
Date: Thu, 24 Oct 2024 19:07:40 -0700
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
Message-ID: <Zxr9bJu_VxzYyhuU@bombadil.infradead.org>
References: <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <ZxqJj9IZ2GF3IStb@bombadil.infradead.org>
 <20241024211728.0e2304fd@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024211728.0e2304fd@rorschach.local.home>

On Thu, Oct 24, 2024 at 09:17:28PM -0400, Steven Rostedt wrote:
> Remember, this is talking about fixes after -rc1 not for things heading
> to the merge window. I find linux-next extremely useful for that work.
> But for fixes, what benefit is it to push to linux-next before sending
> to Linus a fix that adds a missing mutex_unlock() in the error path?

Yeah, sorry I did not get that context, in that case think the value is
more immediate than a round trip through 0-day given linus tree has
more immediacy for testing and value for fixes.

  Luis


