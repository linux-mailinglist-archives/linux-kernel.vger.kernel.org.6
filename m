Return-Path: <linux-kernel+bounces-380816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B99AF684
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633E21C212E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065C43AA1;
	Fri, 25 Oct 2024 01:11:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854312B64;
	Fri, 25 Oct 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818714; cv=none; b=kua0Yap8Ft3ShRnueyuFFqcQmmk1De88+oPhd7YJ4UObxg9ZjPU1fpG6NqEXH1bsIGqFgE+sxtBoeBV3rYxv0F3bOiKMElbdY8xTYNOqMr2kH3NrW8YDpzjdtlMq2ZcHiE7q5rbHFXYXJ+o6g2mr/5TQxyYsPxCthmsFBNz8QZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818714; c=relaxed/simple;
	bh=PdaiVY4mXaaatJcybm9KDwSVafXLmEfyqovSHj3l2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbpBJMT9/G837K/Lb59yCZOR9j8TWEdY6GX/mznRtLx69XxnjNEs8knGNRcUh8EnvQuPtcq2WWB0mLdgga2dEkNemtevVc8ujqBUUdeGtvnRP+iLDwN9lT5isXXI3i4tjkv6gtf5tQYllf+qkWBss50fCFKTLVpJaNVxvwl910E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D501C4CEC7;
	Fri, 25 Oct 2024 01:11:52 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:11:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Christoph Hellwig <hch@infradead.org>, Kees Cook
 <kees@kernel.org>, Sasha Levin <sashal@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024211149.4f0b6138@rorschach.local.home>
In-Reply-To: <82eecf18-0a71-4c16-8511-bc52fb61f421@roeck-us.net>
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
	<20241024024928.6fb9d892@rorschach.local.home>
	<82eecf18-0a71-4c16-8511-bc52fb61f421@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 07:39:00 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > 
> > Now I have to ask. What's the benefit of pushing to linux-next over
> > waiting for the zero-day bot?
> >   
> 
> I push my changes into the same branches that are checked by 0-day
> and pulled into linux-next. linux-next shows interference with other
> branches. Once in a while I do get a notification telling me that
> one or more of the patches interfere with other patches, so I know that
> something happened, and I can prepare for that for the next commit window.

Remember, this is about pushing to linux-next before sending fixes
after -rc1. Not for things that are going to land in the next merge
window. My fixes seldom ever interfere with others work as it's usually
much more focused on code that is already in Linus's tree. Like adding
a missing mutex_unlock() from an error path. How is it helpful to push
something like that to linux-next?

> 
> Testing-wise, I do run build and boot tests on linux-next (the same tests
> as those running on release candidates), so I do know what is wrong there
> and (which did happen a couple of times) if a patch in one of my trees
> is responsible.
> 
> Yes, that means that in many cases I do know ahead of time which problems
> are going to pop up in the mainline kernel. But I don't have the time
> tracking those down when seen in linux-next - there are just too many
> and, as already mentioned, that would be a full-time job on its own.
> Also, it happens a lot that they have been reported but the report was
> ignored or missed. On top of that I found that _if_ I am reporting them,
> the receiving side is at least sometimes either not responsive to almost
> abusive, so for the most part I gave up on it (and frankly I found that
> people tend to be _much_ more responsive if one Linus Torvalds is listed
> in Cc:).
> 
> Note that I do collect known fixes in my 'fixes' and 'testing' branches,
> primarily to have something clean available to keep testing. Linus even
> pulled my fixes branch once directly because the responsible maintainers
> didn't send pull requests to him for weeks.

Or are you saying that it's helpful to "fix" linux-next before fixing
Linus's tree? That way others will have the fixes too?

-- Steve

