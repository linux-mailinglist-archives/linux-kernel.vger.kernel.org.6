Return-Path: <linux-kernel+bounces-389270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B99B6ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D549A2813B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613FE217468;
	Wed, 30 Oct 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl+hqb0w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82EA1E9064;
	Wed, 30 Oct 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308541; cv=none; b=G7xo9G58L3ar/D6rELnkjwCphxVj75a5W3sG/4CillgoCt69IgGZLK+IyVTz595vG+umktbh140uB592agFrv4DtGgNr+VWYkSYfyg5CHN4TlS7IU6xgcSH0DbQ4TSPf0/wqAj9/L+3dCblycrhy6Wsoq1R5dSOLGM8xo5DNlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308541; c=relaxed/simple;
	bh=EUedKMVFw2ww45cgy4fnjJQneRbzjMldoBuRMuIfEdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD/j88PBx5/tAosZp5Cy/6MONz/ddIfccOD0sGPkmI9uA+IXGEpGYuylQihOF14Fyto40DFDKHoXVoRyg7tl+43GVBUZZrOhvUc9NJDcs6aDk6YM6TA9NlT19pbt/3UANbsJsi4d+klm3dhCYMXU3zO/rO/JcvR5hNZMTFe9wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl+hqb0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D1DC4CECE;
	Wed, 30 Oct 2024 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730308541;
	bh=EUedKMVFw2ww45cgy4fnjJQneRbzjMldoBuRMuIfEdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl+hqb0wDSMyfdOIdjYWPoAsMARzUO26xp4ze/w11RmVTN0RYBnYvntXj9Tbk34Vu
	 uuiChFcnM+KjEbq2JeprUZfMQZzNBx4DBIKRWWSDeX17hx71a1LavBpPgycQYrrxga
	 1dGPD60vSoAAP5GSH8gq6c0rGzd6cVQBEBHNMkZyL5JJbJ5PyGps7qQz9cKnCjQLBL
	 XTBvLPhb4A/yX2B0zjgRXTFGhaSwz0Fp4twS+JgSaokisCHnkxMpyGKyLxPn6ZpTJ7
	 utLzAFimyiNRFfPuGc+xvB3KSTTR2eThWSFRfDh1Bat4DtfNfh+om255TxoJuuvl8P
	 o+P5d2+r2nsFw==
Date: Wed, 30 Oct 2024 13:15:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZyJpu5QdGho6cOUs@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
 <c936a7f6-e532-4f6a-b55a-bbf0fe6c6f32@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c936a7f6-e532-4f6a-b55a-bbf0fe6c6f32@paulmck-laptop>

On Wed, Oct 30, 2024 at 10:08:57AM -0700, Paul E. McKenney wrote:
>On Mon, Oct 28, 2024 at 06:46:19PM -0400, Sasha Levin wrote:
>> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>> > On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>> > > For example, for a given PR, the bot can report:
>> > >
>> > > - Were the patches CCed to a mailing list?
>> > > - A histogram of how long the patches were in next (to show bake times)
>> > > - Are any patches associated with test failures? (0day and many other
>> > > CIs are already running tests against -next; parse those reports)
>> > >
>> > > We could have a real pre-submit checker! :)
>> >
>> > That would be very useful.  Items 1 and 2 should be trivial, 3 would
>> > require a bit of work but would still be very useful.
>>
>> If you've been following so far, there is a bot that is capable of doing
>> most of the above
>> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).
>
>Nice!!!
>
>What does this make of these commits of mine?
>
>744e87210b1ae rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
>cbe644aa6fe17 rcu: Stop stall warning from dumping stacks if grace period ends
>26ff1fb02991e rcu: Delete unused rcu_gp_might_be_stalled() function

Days in linux-next:
----------------------------------------
  1 |
  2 |
  3 |
  4 |
  5 |
  6 | +++ (3)

-- 
Thanks,
Sasha

