Return-Path: <linux-kernel+bounces-376408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316B9AB0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1211C22876
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533331A262A;
	Tue, 22 Oct 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSTCIWUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED51A0B05;
	Tue, 22 Oct 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607775; cv=none; b=AkiT67SgngNsw9Ve3YYcxL0bTC3OUGZBMYI6Svxuddt/efW4MR3/V7nkykIEPNt8/ErKqq/Ck0319jFukbnFSYVnwyVP+ipbu4RLia/6IdAbrtXfHNytLxNjTm7+zskk8OzuXI+s52/Umwux8BQif5IAeU0lBNDdzBVGx8CvtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607775; c=relaxed/simple;
	bh=B8UyviWl/MeH/k/JBvoEcEii3wRTMUWD62BDU9dTkSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3jSvz4to6Pvj6pP6CstXGuIFLj8czW/W37pEYCpolDNpxxFUKfV3yQ2avMErUwyz+OxSgfXrWU2OqLGlKiQBIdpdl5TRmmMP3vShFgp9b4YLPZm9H9i9wNx7XRFfCWDJP8agDSbQWZwHIP6Ve5tiftUqZ2teIi4HWfhAjpwm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSTCIWUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172E7C4CEC3;
	Tue, 22 Oct 2024 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607775;
	bh=B8UyviWl/MeH/k/JBvoEcEii3wRTMUWD62BDU9dTkSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSTCIWUKrO17mGJlheXA109mkWfuz8LYqxWh5bNNIT3Gd6UloujPUfF9EeK92C6HN
	 auiDrurJ5ArDtD8jeO6uYNotcM7YxNdRCarxumJExFyd5swU/+hWkE/zQr4YZ3R6F9
	 xjjvEID5yf/aC3c2owflJQh0H/XEZc36DWbisbrGgttrVwStH0KzO+uyrYpKje1m2o
	 ms5LKXihEdLh3oY4Vg6r3T3x/kSgzVBJ9dVPP0BQ2CGk5UlKLKsp++H6PpwcfPThor
	 KSesg2QwzOzdxsaU8bPNAFVM7McIJs3/TBY/WBhiwKbmcAakwNuITH3cDCxOx3mvtU
	 Mw14Wp4rraKBw==
Date: Tue, 22 Oct 2024 10:36:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <Zxe4XT59FhkZbgdq@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
 <nycvar.YFH.7.76.2410221357140.20286@cbobk.fhfr.pm>
 <a627c5bd-e219-4d0e-a2d9-8dda44143d8c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a627c5bd-e219-4d0e-a2d9-8dda44143d8c@paulmck-laptop>

On Tue, Oct 22, 2024 at 07:22:12AM -0700, Paul E. McKenney wrote:
>On Tue, Oct 22, 2024 at 02:06:46PM +0200, Jiri Kosina wrote:
>> On Mon, 21 Oct 2024, Paul E. McKenney wrote:
>>
>> > I have to ask...
>> >
>> > Wouldn't more people testing -next result in more pressure to fix
>> > linux-next problems quickly?
>>
>> I believe I brought up pretty much exactly this at this year's maintainer
>> summit.
>>
>> >From the discussion it turned out the many people believe that this
>> investing into this is probably not worth it, as it will require much more
>> continous, never-ending effort (for which there are probably not enough
>> resources) than just dealing with the fallout once during the -rc1+ phase.
>
>Thank you for the response and the information!
>
>But why won't this same issues apply just as forcefully to a new
>linus-next tree?
>
>Full disclosure:  Testing and tracking down bugs in -next can be a bit of
>a hassle, to be sure, but I expect to continue to do so.  For one thing,
>dealing with -next is way easier than testing patches on the various
>mailing lists.

I'm not trying to change the workflow here, I think all this amounts to
is just a quality of life improvement for Linus who could ideally merge
faster if he knows that the pull requests he's looking at will build and
won't brick his laptop.

If we start playing games around "must spend X days in linus-next", then
yes - I agree with you.

-- 
Thanks,
Sasha

