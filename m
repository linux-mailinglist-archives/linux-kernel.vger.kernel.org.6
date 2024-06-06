Return-Path: <linux-kernel+bounces-204956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E088FF578
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E36228818A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2A61FDD;
	Thu,  6 Jun 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEPP/M/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0703BBCC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703401; cv=none; b=Hn47y9wPjhuEefbC2hA2n32UUOcf27zdpgdtiQXdjlO7/tiuWTTXUBO2nFp8Du2mAlCCNc3FGRc/3ZCPj76w6vScIUdNPjyOrCmd2IWvNMJ5DxYbRjnWbQJoliELCsUJopsT0B+dmmiXVej71zI7CvTmuRLddSpk/XyLpBuLL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703401; c=relaxed/simple;
	bh=sKOr9mRXx0a4WKiNAnV+HI3LIk3H9FP9Tw9NowZ77cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf6t8MJrLVfHdfRJUnm4HjhhIggZhNCbGQoiiIznGmMBiPZIX95ezF0scmw6/x9N6+8wKAmFNKqNZmPYkTkjr9p9l4ICU+iq9t/ntagePFOpGCoY3VaSFbae1R6C6pajACQxI9FHNCajBoXek8nBs3WCsvAEB50rKQlPOa8Cdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEPP/M/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA801C2BD10;
	Thu,  6 Jun 2024 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703400;
	bh=sKOr9mRXx0a4WKiNAnV+HI3LIk3H9FP9Tw9NowZ77cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEPP/M/wak7joAX9X9Mq0XbdUTtgJEbhY2reGlqG5wnJGohVLLTCvQjzvEePy2JSf
	 jPBYbYQvj+y5iwCA3Wwm01rKtv0+SupwHeFtfkWMY3GFaFzuPn2aHfIslfJ6WhF/RW
	 zQwFhzKpXyEO6bok/JMT4j9VrVAxZtE/H6o54KI6grhmvWwOwVBWYRzZiWMX/HFrvE
	 qBY67sr8B6U+O925KEfopMpFjT6MALM/aJ1OM6fYe5CQ7f4Xs7tJUcMLnDBVBU+2Ol
	 0+CN1XC1WiDb79TzZ8hQVGkDSR1lHQqWvI+lCBtBp7LwMk8PIlblF0fZxcywSAOs26
	 j0Z3YNG9oo+ew==
Date: Thu, 6 Jun 2024 22:48:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
Message-ID: <ZmIScSCwqpS6WBGn@kernel.org>
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
 <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
 <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
 <eaa90c1a-ae96-4506-90dd-146ce85d311c@suse.com>
 <20c484a5-d797-4782-b5b5-bea5fcae9284@paulmck-laptop>
 <b004f0be-1aa5-4f5b-8dd5-a071bcfc5179@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b004f0be-1aa5-4f5b-8dd5-a071bcfc5179@paulmck-laptop>

On Thu, Jun 06, 2024 at 11:04:30AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 07:19:40AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 06, 2024 at 08:13:17AM +0200, Jan Beulich wrote:
> > > On 05.06.2024 22:48, Paul E. McKenney wrote:
> > > > On Wed, Jun 05, 2024 at 09:46:37PM +0200, Jan Beulich wrote:
> > > >> On 05.06.2024 21:07, Paul E. McKenney wrote:
> > > >>> On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
> > > >>>> The following kernel warnings are noticed on x86 devices while booting
> > > >>>> the Linux next-20240603 tag and looks like it is expected to warn users to
> > > >>>> use NUMA_NO_NODE instead.
> > > >>>>
> > > >>>> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> > > >>>>
> > > >>>> The following config is enabled
> > > >>>> CONFIG_NUMA=y
> > > >>>
> > > >>> I am seeing this as well.  Is the following commit premature?
> > > >>>
> > > >>> e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> > > >>>
> > > >>> Maybe old ACPI tables and device trees need to catch up?
> > > >>>
> > > >>> Left to myself, I would simply remove the WARN_ON_ONCE() from the above
> > > >>> commit, but I would guess that there is a better way.
> > > >>
> > > >> Well, the warning is issued precisely to make clear that call
> > > >> sites need to change. A patch to do so for the two instances
> > > >> on x86 that I'm aware of is already pending maintainer approval.
> > > > 
> > > > Could you please point me at that patch so that I can stop repeatedly
> > > > reproducing those two particular issues?
> > > 
> > > https://lore.kernel.org/lkml/abadb736-a239-49e4-ab42-ace7acdd4278@suse.com/
> > 
> > Thank you, Jan!
> > 
> > A quick initial test shows that this clears things up.  I have started
> > a longer test to check for additional issues.  But in the meantime
> > for the issues I was already seeing in the initial test:
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> And the longer test ran without errors as well, so again, thank you!
> 
> Any chance of getting this into -next sooner rather than later?

Should be there tomorrow.
 
> 							Thanx, Paul

-- 
Sincerely yours,
Mike.

