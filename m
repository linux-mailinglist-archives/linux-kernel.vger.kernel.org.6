Return-Path: <linux-kernel+bounces-388862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B19B6555
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C0B1C2313E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E91EF0B4;
	Wed, 30 Oct 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+3hvxcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2964315F;
	Wed, 30 Oct 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297445; cv=none; b=sGr/0hXPuKyB7qWiw3kiSvHWlCx1zD3rBmlZ4/JdvGMpMvZ6PmJXo9vSwIw9Vwd2Lnz/CjOQ08/eRmfwBt8S9F069PvBrh2vjnh0js4oNdyKcDkosUHTfwyFSqfWWfh3Gh7RorW6qmIUC/pJVmGc9WK6GCiIu8g2rbIDbAGAHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297445; c=relaxed/simple;
	bh=OJhQ9gBlsQ73BpdP0EXsX44L4OeKUEsuBQrGpOiGKxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGmFrhFn76DGuxSwlwUPDf0vKuXtCEz0aXn18jpdVpxgV1xpPo09YGTX3cF0Fcnd1GOWrnm3nXC04oAXVPgKuOYEb6ninjtgpNkotL/xmRLhh3Qq0uYG4b4ubbGCaHK7Z2OGd3FtpoTKK6GQf+/wuuCisA2fnBFU8F3kT44Yf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+3hvxcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37306C4CECE;
	Wed, 30 Oct 2024 14:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730297445;
	bh=OJhQ9gBlsQ73BpdP0EXsX44L4OeKUEsuBQrGpOiGKxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+3hvxcqcNThCHt5tCg/M05dkdlUOFtW8dSTvSZGVUOYz0eEVWIELd0IjwU7VPPxH
	 Q4hG4qQXd86lkFKi9+uvgn5fUM8dPLElzxumpeSHp9tWy1IGirjATOqh3KTK0jflzl
	 cwLoOKTCsYk/IVfF8THgxEZ80zVWBpu/cmg78xf3EpNyYI2mDVe2kJ9R34FZEx2CqN
	 QS8t6qi/NK2lVTqvuquK0wr4GBLmuUx1PxpofXBoV9TsyPM7qXX1FmTtnhTSekRPLu
	 4uTjIpVsEeS1dzkOZBb+2YqpWBydqZGzUzNcbGjU9mCPi3d/9lCS+3TINB32qmqv1p
	 boxyPsLc2ARZw==
Date: Wed, 30 Oct 2024 10:10:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZyI-Y00J3DBUkon3@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
 <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>
 <ZyDHZHjxwmK1Ow9e@sashalap>
 <292de8f0-49e7-49c8-a327-b279924a5794@leemhuis.info>
 <ZyD6QioGPyJUXI5r@sashalap>
 <58c58550-532a-4cfa-947d-ed56c6c5ba4e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58c58550-532a-4cfa-947d-ed56c6c5ba4e@leemhuis.info>

On Wed, Oct 30, 2024 at 07:46:40AM +0100, Thorsten Leemhuis wrote:
>On 29.10.24 16:07, Sasha Levin wrote:
>> On Tue, Oct 29, 2024 at 01:46:23PM +0100, Thorsten Leemhuis wrote:
>>> Hmmm. After all those mails in this thread improving (and maybe even
>>> separating & somewhat automating[1]) pending-fixes to me still sounds
>>> like time better spend, as then more things could tested before they
>>> even read a PR; but yes, I understand, the timing/order of merges can
>>> mess things up, so testing on PR time has benefits, too.
>> Automating how? Having it be generated more often?
>
>Have the list of -fixes trees which a "no rebases" policy somewhere and
>a script that regularly merges them into a tree. But as indicated, it's
>not that easy in practice and can't be fully automated, as there will be
>merge conflicts occasionally. But Linus wants to see them, so they will
>happen at pull requests time, too -- doing it constantly has the benefit
>that you can notice and resolve them ahead of time.
>
>How much work this is: no idea, maybe Stephen could help answering that
>from experiences for pending-fixes. But I expect conflicts should not
>happen as often as they do when it comes to merging -for-next branches.
>
>But that obviously only helps outside of merge windows.

Do you want to give it ago?

I've pushed something to
https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git/log/?h=auto-pending-fixes
, and scripted a bit around it to try and keep it updated.

We can try a model where it tries to avoid rebases as much as it can,
and if it needs to rebase it will tag the old HEAD before re-creating
the branch?

-- 
Thanks,
Sasha

