Return-Path: <linux-kernel+bounces-391143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5A9B8336
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACDD1C21C74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B341CB328;
	Thu, 31 Oct 2024 19:18:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E531C9EC4;
	Thu, 31 Oct 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402328; cv=none; b=oXTHyHWzr1J8HcpBxVqlkjQXAl0dqTJJmTKowmE0iOICZacA1iRhWVQEwIsnGizQqGyqcQMfHZrScgR6rLBOwJDwoBDz7vzAIpu7KhdOqXu+5rMXNWqRuuu4IseaA4yUMFIbHe0j74tR0XLYlVLMLDHJK5CeMbJUAo9s8VWoPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402328; c=relaxed/simple;
	bh=XTKGe29swHHvflyEPO6SdiLlq2rQ+M/mpQQ3gBNlB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5AS9mZODopIoUtPSgIDaK8sHLj72+VKEK5H28qgCpkz8JOd5wRxeZHNjupVp8dexFRSjw6BptBGGI34gTonY0Qcqh2FxDvWGkRn4/jPUF9ZoEMcqWJl9ZZ2TTYd8qNeYPsFsmrjQUVA9jkXuIqKnVkrt7PGya6c5uEZ4vTabiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42555C4CEC3;
	Thu, 31 Oct 2024 19:18:47 +0000 (UTC)
Date: Thu, 31 Oct 2024 15:19:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig
 <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin
 <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241031151943.7be1cf5c@gandalf.local.home>
In-Reply-To: <1cb27980-7679-43c7-92b5-48af6d711a1c@linuxfoundation.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	<792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	<ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<1cb27980-7679-43c7-92b5-48af6d711a1c@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 13:08:12 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > But pushing to linux-next for a day or two, what does that give me?
> >   
> 
> I don't send pull requests without soaking it in next for 2 to 3 days.
> It helps me find problems related to things something breaking on an
> architecture and/or config.
> 
> I find next very helpful in finding merge conflicts and build/test
> breakages.

I have a 13 hour test suite that I run before pushing anything. And since
it's going into the rc release, any merge conflict that happens in next is
likely something that isn't even applicable for Linus's tree. Sure, it will
need to be addressed in the next merge window, but that would have been
found after getting in Linus's tree anyway, because really a fix to Linus's
tree should have no merge conflicts.

-- Steve

