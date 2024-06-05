Return-Path: <linux-kernel+bounces-203196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A438FD7C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34141F25049
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2514A082;
	Wed,  5 Jun 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djRW8dej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998B7462
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620527; cv=none; b=pnK5hxvq0Z9tAP7GkecqY+ODxOvma3tfEnce4UL74PML7t8joEaf/UxSsJzotaWuLseyspnifDI0nO/HyhvD/ofzE6bB5j73VngrCZtscpCl6sKtI4lnPEhYuD8Loj0+qe6fjO96yF8J2769wHxx97OEPK+/0S8NRQQR4M4qnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620527; c=relaxed/simple;
	bh=T5vr5sPvG0JFOXXVreMHeuAt0slBjtXGtC/wJP+h424=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnbpL66JU/TCmUTj90ZPAUMpJMPHCU/D4nMVGVbEox/KA2kWoG1RmPE9hhRD3hIBadlfLiUBAeKWp5SEcJkVHWz3PzL1QLstvoSVhxL4C3gBUZyPcGvDIzKLRz7+nmPOnQIKIxxUZKWebUteO5JJh/i+xTjBuYGydR1c2zMa0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djRW8dej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FCCC2BD11;
	Wed,  5 Jun 2024 20:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717620526;
	bh=T5vr5sPvG0JFOXXVreMHeuAt0slBjtXGtC/wJP+h424=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=djRW8dejK447Uba2SB73pKSW2tX5d1fwBlUICNRuXwHtUGONv/nLgcLoamj1LO53F
	 1oR6q6IjjbXmLgxcxYaRzF5sXVqQnhzL8O17xmL1hkh9vVMt6XI/PJCEfln1H6xWKr
	 GvUmsUPJS5YbaeUi86r5hrSAo57RjJqffa9+dp6kmKEkHHhM6b503YHxmuPFbwJ/U9
	 Ojo3EidLxLlwktsKpYgINSAj/FSrB4uZhq1TE7RtMpMzU4Ktnudm9uWfuU8PDcdMWy
	 qCVIgBdd76wr6Iu7hfhoaPHrU+cZP5meL/Y6ie8/jvSGuF4FRqo8FRo3FGnK19gH9Q
	 L0JEXLbmGQ35Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7138CCE0A72; Wed,  5 Jun 2024 13:48:46 -0700 (PDT)
Date: Wed, 5 Jun 2024 13:48:46 -0700
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
Message-ID: <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
 <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>

On Wed, Jun 05, 2024 at 09:46:37PM +0200, Jan Beulich wrote:
> On 05.06.2024 21:07, Paul E. McKenney wrote:
> > On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
> >> The following kernel warnings are noticed on x86 devices while booting
> >> the Linux next-20240603 tag and looks like it is expected to warn users to
> >> use NUMA_NO_NODE instead.
> >>
> >> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> >>
> >> The following config is enabled
> >> CONFIG_NUMA=y
> > 
> > I am seeing this as well.  Is the following commit premature?
> > 
> > e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> > 
> > Maybe old ACPI tables and device trees need to catch up?
> > 
> > Left to myself, I would simply remove the WARN_ON_ONCE() from the above
> > commit, but I would guess that there is a better way.
> 
> Well, the warning is issued precisely to make clear that call
> sites need to change. A patch to do so for the two instances
> on x86 that I'm aware of is already pending maintainer approval.

Could you please point me at that patch so that I can stop repeatedly
reproducing those two particular issues?

							Thanx, Paul

