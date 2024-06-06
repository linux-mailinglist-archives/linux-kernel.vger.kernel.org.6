Return-Path: <linux-kernel+bounces-204852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F48FF43B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319BC1C240D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F319923F;
	Thu,  6 Jun 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMgh7WM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28C1974E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697072; cv=none; b=GsIts5h1mFM9uCP73JGxbOPGbEf5SHAj3zH4FVxvW2RzVQjlzGzXuS+V5/gR3R9jaqpvUBGiBq66SRvRrxs7af0A+ZnpYC7CjkruOJb2zU3RcsiVnEVpkhEX4W+G095jdgOeq5yvYzR1yxjc1dV31smhRgFzPrBkgpIToKiHKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697072; c=relaxed/simple;
	bh=HDd6OHePqDYE5PcHNs5uUuesJqWx2FNGOr7Pj6VmAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlHEtXlcfr2AOZyQrWOq+Hj1AmG4t8HhNZczcc70tsQVD/rS7qtyz4aoz5TycLRamsux/+h+CtXRXA2NYKBo+LgfAIz5/5EQqTe1Ucm/hvvYxFbTTUCq7VC+/Iv5chiFeQIewsPCBKXoxmwwTiFdiZAkSiAXS74RqK6UbLqdSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMgh7WM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7BC2BD10;
	Thu,  6 Jun 2024 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717697070;
	bh=HDd6OHePqDYE5PcHNs5uUuesJqWx2FNGOr7Pj6VmAxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nMgh7WM6GglV9bL4DSuANqJtT5P1tgI/lh3sVNg8ChLTC9tWCtZOVIkC83rdW+VFA
	 qnEXnpx4+iLIs8tUdtXxkjEzWLpd2zLJbCbIXIat6yT9AnJZ7Yt2PEYXJL5N7w9Ryo
	 M0EQhmRG2UYMCoFwdrYvt75GDP7LLq+JztY40t6yfMfmw0O6ff4vUgSvHjeFU+nFyt
	 NXFz9UTXMSTzE7bXDEZwtx3QVux5z8yFl2n3h2i+0udiijoF54u4+VpHJpdY6YZCcT
	 jNIEa47Mq/Bf64Zlm+ReFfcBXakWf1POVBcxgWxXEC6KmZsGbxls0kCvwPpQwiVgga
	 OCW9VXD48/EcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6F83DCE3F34; Thu,  6 Jun 2024 11:04:30 -0700 (PDT)
Date: Thu, 6 Jun 2024 11:04:30 -0700
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
Message-ID: <b004f0be-1aa5-4f5b-8dd5-a071bcfc5179@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
 <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
 <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
 <eaa90c1a-ae96-4506-90dd-146ce85d311c@suse.com>
 <20c484a5-d797-4782-b5b5-bea5fcae9284@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c484a5-d797-4782-b5b5-bea5fcae9284@paulmck-laptop>

On Thu, Jun 06, 2024 at 07:19:40AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 08:13:17AM +0200, Jan Beulich wrote:
> > On 05.06.2024 22:48, Paul E. McKenney wrote:
> > > On Wed, Jun 05, 2024 at 09:46:37PM +0200, Jan Beulich wrote:
> > >> On 05.06.2024 21:07, Paul E. McKenney wrote:
> > >>> On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
> > >>>> The following kernel warnings are noticed on x86 devices while booting
> > >>>> the Linux next-20240603 tag and looks like it is expected to warn users to
> > >>>> use NUMA_NO_NODE instead.
> > >>>>
> > >>>> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> > >>>>
> > >>>> The following config is enabled
> > >>>> CONFIG_NUMA=y
> > >>>
> > >>> I am seeing this as well.  Is the following commit premature?
> > >>>
> > >>> e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> > >>>
> > >>> Maybe old ACPI tables and device trees need to catch up?
> > >>>
> > >>> Left to myself, I would simply remove the WARN_ON_ONCE() from the above
> > >>> commit, but I would guess that there is a better way.
> > >>
> > >> Well, the warning is issued precisely to make clear that call
> > >> sites need to change. A patch to do so for the two instances
> > >> on x86 that I'm aware of is already pending maintainer approval.
> > > 
> > > Could you please point me at that patch so that I can stop repeatedly
> > > reproducing those two particular issues?
> > 
> > https://lore.kernel.org/lkml/abadb736-a239-49e4-ab42-ace7acdd4278@suse.com/
> 
> Thank you, Jan!
> 
> A quick initial test shows that this clears things up.  I have started
> a longer test to check for additional issues.  But in the meantime
> for the issues I was already seeing in the initial test:
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

And the longer test ran without errors as well, so again, thank you!

Any chance of getting this into -next sooner rather than later?

							Thanx, Paul

