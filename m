Return-Path: <linux-kernel+bounces-382641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F189B1162
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A16D2841F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913E217F4B;
	Fri, 25 Oct 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGq6rLh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098720A5D0;
	Fri, 25 Oct 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890285; cv=none; b=p1SSeEENH2DcvVPSFCJZHBWHFbxKhxunT4Po3nHPxTeBMAgO/F/vHC4Z+pVtwJYNgodEyzS6FSEpBG9zE6+uFCCvguoVKGMe+/2Vt71rnErUv7ZkXOBHxIdGXiXHrW5pz0dt5VgFCizAi7AnaXp/JyTOMTd2VRngFMmA+Q2tDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890285; c=relaxed/simple;
	bh=h1nbi8xFS97hYlc76bkVxX0W0/ZMwND6/0MQlPmGwo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e9/6C9sisJJc7+cK7bf1lZS0A9ANH9OysN8Nc9gTKzqi3FnrzyoNEelVZ46lvh4teqGPZsuhQdVd3wLbOkEjNBwASODtL1kRwX7kwuxC8M9/gkM+TYMIYWINZ59pbW5tE75M9lPf2vwiRWkxcS0pXxRxv6pUz2Jcb4sHCouyglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGq6rLh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A6BC4CEC3;
	Fri, 25 Oct 2024 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890283;
	bh=h1nbi8xFS97hYlc76bkVxX0W0/ZMwND6/0MQlPmGwo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rGq6rLh6MMApIpsb2quu+XNg22XrEOgrXH1tq0Ssmp3tjy+HxdLB7G/q1cVi2qHCV
	 QhPkath5Yxo+rIciNePqVYZuvmppjm1OnyLfLWWwyFAyVza5lkVO3dNG8RX5iJjufd
	 OY33AIQn9rSJlBT/aHkm41KnYr0d7VUf12f3cxodwsZtE0YR2fuNpBu35PuXBRe40O
	 kabupjEJ/dpMXVhJIxVUInnnwWGB/aE0VTLHANKHxAvpbnX857N2lSv2LRckeNfEA4
	 dxoPwvEncyMEMjDlfL9R3Jz0VkoEoYQwkh25cjMfWAZgbrdyUmU6kRY+Iyhg3OYNgF
	 Z4rqq/pb7QCsg==
Date: Fri, 25 Oct 2024 23:04:41 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Christoph Hellwig <hch@infradead.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Guenter Roeck <linux@roeck-us.net>, Michael Ellerman <mpe@ellerman.id.au>, 
    Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
    torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
In-Reply-To: <20241024054909.49ae9faa@rorschach.local.home>
Message-ID: <nycvar.YFH.7.76.2410252303270.20286@cbobk.fhfr.pm>
References: <ZxiN3aINYI4u8pRx@infradead.org> <20241023042004.405056f5@rorschach.local.home> <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com> <20241023051914.7f8cf758@rorschach.local.home> <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home> <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net> <20241024024928.6fb9d892@rorschach.local.home> <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com> <20241024052139.2cf7397f@rorschach.local.home>
 <ZxoSZQSw0z6AdgaU@infradead.org> <20241024054909.49ae9faa@rorschach.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, Steven Rostedt wrote:

> So basically, all I need to do to satisfy your request is to add fixes
> branch that I push to that is pushed after it passes my tests (and not
> the urgent branch that is still being tested and may have bugs) and
> then have that be added to linux-next?

That is one option.

Alternatively do what I have been doing since ever: I have a couple of 
'for-N+1/topic' branches, and then I have one 'for-N/fixes' branch. All of 
them get automerged into 'for-next' branch which Stephen is pulling. Works 
like a charm.

-- 
Jiri Kosina
SUSE Labs


