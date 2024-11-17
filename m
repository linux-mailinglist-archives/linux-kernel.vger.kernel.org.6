Return-Path: <linux-kernel+bounces-411979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636C9D01F7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD841F22C94
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 03:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AE11712;
	Sun, 17 Nov 2024 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9nxrFbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E028EB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731814904; cv=none; b=fs9EdafM6/7+OYZvSi6ex85mTWJEP0Y0cUd52UPrjn9uTj47rMREMPYg3KdhG1Lx02MnmOeDvMhP6Bnz+44E7OnxOjFfx797Cyh8dRcmjswTctzRnWW5yHUlXfRcJ143KIDZaAcbphFJXYS+QriK8i7mp2Xd+bulHRMbwtMaLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731814904; c=relaxed/simple;
	bh=Fh4kPox9UjV5xE/GDrhwl3lS8k1Xznr8ojhJreMCXs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOm78g6n9AdPOt/o31SaEXQq2iyWu92fqHATddL5JfaVEUrxCxdmznR6GOg2lls4AvnWyU2GrsCpuEBL6RLMQpETbDuOD81Hxqg77X6MWHdhtYLrymFuC7xOcqeyg3PQK4I7HA0B0VOmAvfHaZ6YqVYt5yok3gYQ5imCjGSFiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9nxrFbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E51EC4CECD;
	Sun, 17 Nov 2024 03:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731814903;
	bh=Fh4kPox9UjV5xE/GDrhwl3lS8k1Xznr8ojhJreMCXs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9nxrFbZDDA1mqBle1uo+iuC+uUJ3rupF2ESk8qYrAaWUDOKqXgzqi6MAcAljwnKA
	 Ip2OWpla1MXOYTKQGNl5YHL8zTyQrU5QX8CcNcgyhbwMmmWP9pQgIpPojpqhq+mFZn
	 tnZclO4KIdGQNlklmyvgUXN7umTT4fHWyJniyR+byfwyZtc3oDAQhoMBdsJDbXN4qE
	 FHaPz/qDxtT/cRL0VO/ssLMMhujVLD0/jk/URedwUuKbcYJWU3fpxQpmaFvsOdYRIX
	 bZAYneVbfqCqbZkcQv35VyYP8UkT/FyKFoZLdjgDQIcPoO5/sMrdzbQO8+4WtHizPJ
	 Y0vW7usnOpjJA==
Date: Sat, 16 Nov 2024 22:41:42 -0500
From: Sasha Levin <sashal@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.13
Message-ID: <Zzll9v3dR8UxwvQ8@sashalap>
References: <03ec75a9-aade-4457-ac21-5649116afa98@suse.cz>
 <Zzi7BxJASrR_wbAQ@sashalap>
 <Zzi7zR0maqdCC3ME@sashalap>
 <52be272d-009b-477b-9929-564f75208168@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <52be272d-009b-477b-9929-564f75208168@suse.cz>

On Sat, Nov 16, 2024 at 09:43:07PM +0100, Vlastimil Babka wrote:
>On 11/16/24 16:35, Sasha Levin wrote:
>> [ Obviously I fat-fingered it and didn't add Christian or Al ]
>
>I have found the problem and looks like I managed to force push an older
>broken version of a branch, possibly due to switching between two computers.
>Serves me well for amending in some last minute R-b tags. Doing git diff
>@{u} to check for unexpected suprirses before pushing the result didn't help
>this time, either I forgot or was blind.
>
>I have deleted the slab-for-6.13 signed tag and pushed the fixed branch only
>to -next. Thanks a lot Sasha for catching this early and please drop the
>merge from the for-linus tree.

I've dropped the merge and tests are passing now, thanks!

-- 
Thanks,
Sasha

