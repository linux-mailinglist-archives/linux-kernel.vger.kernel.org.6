Return-Path: <linux-kernel+bounces-172696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E100A8BF58E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4261C2305F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA03179AF;
	Wed,  8 May 2024 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiWRAWhY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046617597
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145596; cv=none; b=KbfekmQ5NrOEV+fctjtlIIPBDsKaqfTmfONq4zOlUnHQBcRBQc5M17zZTqCdGVfLaDcVeeyS1yfrYK6Zj/tlIv0xymdWcrNxqUNddtO0AvS2+l4v+V8a4fHYLVyzNd8JvWqPwc63wKjwyAgGaM3ECNdhwyNT+RiOaGLGawAaCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145596; c=relaxed/simple;
	bh=uTA5DvevSWIwMkF+/JsuZ+DF8dql4scWS+lC4mf41Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrcN51damYUDxOU2rQV19/OBFHniPHhmSFYYpdklrGHSE7i2LWLrIxB/2JMzaJHPvX3qQE5DQvbYvz7/vNiSFn+fb/MRixS0ykPZvXMae6FWrfy81jJMMIyA7mpvOTl1KQehrDT+/LvR1uO7nXd8RrDk7Qe+SOtnz4cUJCMAU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiWRAWhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBB1C4AF18;
	Wed,  8 May 2024 05:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715145596;
	bh=uTA5DvevSWIwMkF+/JsuZ+DF8dql4scWS+lC4mf41Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiWRAWhY5I47cemKIyLaIawi4aNds6sw8ApKknON0Nb+qKW100VXDnvXNcRL6mu6A
	 b78nRpVJPxrJDj5WZdfgkooyZBjWlY3YJR0g19DXDk9bwf64FkQ/8axd/JG6b106yt
	 2YoeFCpN0sUmJ5ilve+aPgwbo14ujNZX8j4pbolnUmmRjXRbH8gVswD44wwHjZabmF
	 EpVUkmtri0S8Qh1FKqekI1sDMEjWHqodCu9eArHEXQ8FaA+cmcx4J4It9LOfPfLDjT
	 nHERt7jpId8BNMMxJyqw2yd0GHL6FSKt8/wSQVIjSggNfB+jVXFQYp0yIDk2SfrX5C
	 8OTit/JzmRL7A==
Date: Tue, 7 May 2024 22:19:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240508051953.oz3q3hdvifo6lb7o@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <ab3e92eb-d35e-4f5a-8e99-10b3ccb7c2cf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab3e92eb-d35e-4f5a-8e99-10b3ccb7c2cf@linux.intel.com>

On Tue, May 07, 2024 at 07:58:07AM -0700, Daniel Sneddon wrote:
> On 5/6/24 22:30, Josh Poimboeuf wrote:
> > In cloud environments it can be useful to *only* enable the vmexit
> > mitigation and leave syscalls vulnerable.  Add that as an option.
> > 
> > This is similar to the old spectre_bhi=auto option which was removed
> > with the following commit:
> > 
> >   36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")
> > 
> > with the main difference being that this has a more descriptive name and
> > is disabled by default.
> > 
> > Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> 
> Does the KConfig option need to be updated to support this as well?

In general we don't provide a config option for every possible
mitigation cmdline option.  If someone requests it we could add it
later.

> Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>

Thanks!

-- 
Josh

