Return-Path: <linux-kernel+bounces-204440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD448FEE25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96CE1C25273
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFC19751F;
	Thu,  6 Jun 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEAj96XI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F2196C78
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683581; cv=none; b=aWDOGIxVxE4j39l5oBQZjBoxOicKS1ZhWoEZ/idiiu8HTl9THg6miWdMk0G/umHpZCNZF6NMQ/kX6aKXseWEwxQRhZQJ/Oayu/lCxXMVR9tJcldpAuoFj/HwkFcYBVyeIWReAXx8u25O8ti6Cj8lCqvTVDQF1gjNP8z24IK2Bg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683581; c=relaxed/simple;
	bh=xmEdPDXw1k/BWduDyUVJLV259V5w3Fa90zom/EWQBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxhG44Lc46v+RG+87NwfUM4cki9O6rTITGVXzvLsrqRR0Xb1tWtxwaj4+yUjV9bhX4yKTu1mwSlhmYfDmEzjtxqApzT85edicFfgDl1SYCjJUaBwKD1tnQY+XKYxbbz2O1ZuQUgsfg3HOpylBSapZD1hEU6WCLJfpyOJr4hg2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEAj96XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0939EC2BD10;
	Thu,  6 Jun 2024 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717683581;
	bh=xmEdPDXw1k/BWduDyUVJLV259V5w3Fa90zom/EWQBFk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JEAj96XIpIO8CBmuyI6nhs3Mj9yer+/ii3D4GgzK/9cOYp60HZaQxY3fZkRAXORVv
	 2lfgYC70M+Db7+Ht/VjPrFhuErIvi8H5nR71Df8qsUoL5+JnMzdHW2NZ/gHpO5w1qA
	 HV4O4GnnG0P6toiMR2QXOP2ISFR8VIW1DHYtOG9PIAt6LGmNUyCJJVl1wpIBmg+DbL
	 eNkKk+5hGmT9dQfY4mS7C2MXukA0aAaNrCoNfr3/BMoX9B/0xxUzJGZNn2/dgdbpEQ
	 8jpVdwmjGxN44DkJyZVrRuY0cIkVLMjYM5UYd5BCJjSxUDZjE1tHqTkwxuMgQT9Lyd
	 j0Z4249u5aIpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9512FCE3F34; Thu,  6 Jun 2024 07:19:40 -0700 (PDT)
Date: Thu, 6 Jun 2024 07:19:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
Message-ID: <20c484a5-d797-4782-b5b5-bea5fcae9284@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
 <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
 <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
 <eaa90c1a-ae96-4506-90dd-146ce85d311c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa90c1a-ae96-4506-90dd-146ce85d311c@suse.com>

On Thu, Jun 06, 2024 at 08:13:17AM +0200, Jan Beulich wrote:
> On 05.06.2024 22:48, Paul E. McKenney wrote:
> > On Wed, Jun 05, 2024 at 09:46:37PM +0200, Jan Beulich wrote:
> >> On 05.06.2024 21:07, Paul E. McKenney wrote:
> >>> On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
> >>>> The following kernel warnings are noticed on x86 devices while booting
> >>>> the Linux next-20240603 tag and looks like it is expected to warn users to
> >>>> use NUMA_NO_NODE instead.
> >>>>
> >>>> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> >>>>
> >>>> The following config is enabled
> >>>> CONFIG_NUMA=y
> >>>
> >>> I am seeing this as well.  Is the following commit premature?
> >>>
> >>> e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> >>>
> >>> Maybe old ACPI tables and device trees need to catch up?
> >>>
> >>> Left to myself, I would simply remove the WARN_ON_ONCE() from the above
> >>> commit, but I would guess that there is a better way.
> >>
> >> Well, the warning is issued precisely to make clear that call
> >> sites need to change. A patch to do so for the two instances
> >> on x86 that I'm aware of is already pending maintainer approval.
> > 
> > Could you please point me at that patch so that I can stop repeatedly
> > reproducing those two particular issues?
> 
> https://lore.kernel.org/lkml/abadb736-a239-49e4-ab42-ace7acdd4278@suse.com/

Thank you, Jan!

A quick initial test shows that this clears things up.  I have started
a longer test to check for additional issues.  But in the meantime
for the issues I was already seeing in the initial test:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

