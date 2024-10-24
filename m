Return-Path: <linux-kernel+bounces-379286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F39ADC86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72141F23890
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40D189B86;
	Thu, 24 Oct 2024 06:49:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B02170822;
	Thu, 24 Oct 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752573; cv=none; b=kdB9YxJiUAeOjIbDJFfqpzx58xqeBrsksFZ9lmSY/sA9RhP1ucpwDr/uqym+RCL/+os8iunRUMZkOEYf6jeYN3AtI3ktcru9G7edy3b6olB14AMOe6SEVXgLMyQ1qCSXqXD5caAGhM6Ke8dhSLxjENWEljr9rLZLxQsteje8SJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752573; c=relaxed/simple;
	bh=uFOT2oByEmNiJBPbqBwZQBzipRPfDyuLhLXDUL9YDVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S22O5oEE7mAwvvSkFQhlzG6SImpEaHknDifySooUZggpqjhpn4dwcY2THmdQen1KnHqHsTJZuqrjdaQB3CbT94ZHjtMoGPD75brPoG35CA3uezfK+7pyGiR8LjcW+ejVSQAIxQF0dz8kM90Jpa/h/SYn0UDHY5RyC6RlpdUulQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE020C4CEC7;
	Thu, 24 Oct 2024 06:49:31 +0000 (UTC)
Date: Thu, 24 Oct 2024 02:49:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Christoph Hellwig <hch@infradead.org>, Kees Cook
 <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024024928.6fb9d892@rorschach.local.home>
In-Reply-To: <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<8734km2lt7.fsf@mail.lhotse>
	<20241024010103.238ef40b@rorschach.local.home>
	<07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 22:16:31 -0700
Guenter Roeck <linux@roeck-us.net> wrote:
> 
> I do get notifications, so it is still running.
> Its configuration is (still) at https://github.com/intel/lkp-tests.git,
> so you can check yourself if your current repositories and branches are
> listed (and send a pull request to update it if needed). I see
> 
> repo/linux/rostedt-kconfig:owner: Steven Rostedt <rostedt@goodmis.org>
> repo/linux/rostedt-ktest:owner: Steven Rostedt <rostedt@goodmis.org>
> repo/linux/rostedt-trace:owner: Steven Rostedt <rostedt@goodmis.org>
> 
> so at least some testing should still happen. I did notice though
> that "notify_build_success_branch:" is only set in one of the files,
> so you might not get notified if a build was successful in the other
> two.
> 

Thanks for the update!

Yeah, I started using topic branches (requested by Linus) and I didn't
update the success notifications. That explains why I don't receive
them anymore.

Now I have to ask. What's the benefit of pushing to linux-next over
waiting for the zero-day bot?

-- Steve


