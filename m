Return-Path: <linux-kernel+bounces-205114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8958FF79A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E7B1C24308
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3082E13C67B;
	Thu,  6 Jun 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/gzv8oP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FD624
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712338; cv=none; b=HTZEF5M9sjrmiYKaZZztAcdonawkyd20LLN6SUWWbruTnNzzwLRf+OFEaC59rXtSSViZ02ol5NYwdKu7o4yiqok5kr5jzdGj32OnSOgp7JyXppqm1I6Pg8jW8eFIGw2gMwpLqv+drk1WfIukZIVEfM8ZzvriLA8E15zU2ZnVw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712338; c=relaxed/simple;
	bh=JCXmklu+aztEXOYGwB+38pWL/rIG+7//05x4dLVsHS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5MBZC28qJUnN8vBNM+1uE0QajcPihrvDDlLIbUqrbAgwh6sA7RNqFdPKaALMqp4qC45xD884D9L9PWUWM4cqHOTWe786qTYbfAKnAYaXrDPtQNLTJolILghpKY7c1XUVy+EVBSoLabC1cGgDOeJ1mvtjEElSJBlKx85uHkHVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/gzv8oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5506C2BD10;
	Thu,  6 Jun 2024 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717712338;
	bh=JCXmklu+aztEXOYGwB+38pWL/rIG+7//05x4dLVsHS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/gzv8oPRXJsgmsdI6uzHt9sLfLBmmW7Y/ZNdzDD5jsvk6zt30rL3W66YZ1IDMV81
	 xamCcpKotx9QLcleIs7cd++au1PPk5ifXuYSWfPhhLopG9ibmwvxkX/1v25Ub6+wMb
	 8YSxB0q5NcpYlQjOcFk+H2CV33GbX5YJMnDniJta+imAAxFUi/2p53hrUn8DFhtIcy
	 wb9xCPLAtZBTXCzIof1UU5evwepOEPUDca2bc3i7vOSfYjfBDy23v3XT9/dkKSQRj6
	 3/eFPvG+xmdOHQuAkiKS3nkyXQZL573pFU7fOieb5Lbu5XG5tg9mLm7hB8ikT05ok2
	 LzCXh7tk4f0bQ==
Date: Thu, 6 Jun 2024 15:18:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool query: section start/end symbols?
Message-ID: <20240606221856.g3iboxfkkgzp6sd3@treble>
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <20240606194525.cdnnidxurejsjtx4@treble>
 <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>

On Thu, Jun 06, 2024 at 02:10:30PM -0700, Linus Torvalds wrote:
> So what I'm interested in would be to simplify things, and get rid of
> the "key" entirely, because with a good symbol for the start and end
> of the array of users (for _each_ pseudo-constant symbol), it all
> makes the code a lot more straightforward.
> 
> In particular, it would make the architecture side much more
> straightforward, because instead of traversing some "array of keys and
> types" and pick up the ones that match, it would just traverse an
> array that is already pre-matched, because each key goes into its own
> section.
> 
> So I want to *simplify* the code, not make it the horrendous
> complicated mess that is static calls. No "build up that list of
> sites" at run-time.
> 
> Now, I actually suspect that doing this thing would then allow *other*
> cases - like possibly static calls - to simplify their code too. I
> think the static calls could easily use this to simplify the code.
> 
> So I would throw your question back at you and say "No! I'm asking for
> this support because it would allow me to *not* do even a simplified
> version of the horrible things that static calls do".

The "key" idea was probably misguided.  I didn't mean to suggest to make
it all complex like static branches/calls, I was just hoping there's a
simple way to implement "static consts" without needing objtool.

Aside from the idea of avoiding "magic", another small downside of using
objtool is that isn't currently supported on most arches.  That said, it
should be easy enough to make it arch-independent by default for simple
features like this, it just needs a little refactoring.

I still get the feeling there's a way to keep static consts simple
without objtool, but I'm too knee-deep in another problem at the moment
to be able to back that feeling up with much technical merit.

So while I'm not yet necessarily conceding that objtool is really needed
here, I could work up a quick objtool patch.  It would just be x86-only,
is that ok for the time being?

-- 
Josh

