Return-Path: <linux-kernel+bounces-170687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4C8BDAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD922886C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A76BB5B;
	Tue,  7 May 2024 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmCncGDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97454BE4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059064; cv=none; b=kU6aOCU3uaFd4QkWsZ/VqUyRqXh6cMKAtC2tGp8x/k3g4Dpj+HR/IfpcmxZHrxmBd4eOhJLCES0kc5hocT94Jb4xjOMOeS758yKN8fQir3Dx9/CJyAhSDIQZpwm1/+Bkbn0QoOMMdCFAKpHxhUjWi6jyTRlFTkPPM20G6fgPJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059064; c=relaxed/simple;
	bh=MVxJV0DmzBRnFYcte+tBATygTJyvAiF8PMo21+ADg0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1Hy/aJS348QOKlLDcEF9+/J4viZSAAHb+rmf0q1qDoWyKGHMX85tcXwmT8Zm8nFCpc1IHOfPJKaO1KQD/TfzfIrc4nnpIbmO+Q3u9aFJyUg9NdNmNcmSOoMIbOcVtsZ6Vy+aHZfW7VGbuwhOT+gqSMR5/FYHtBRBh2s5Yzc71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmCncGDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE31C2BBFC;
	Tue,  7 May 2024 05:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715059063;
	bh=MVxJV0DmzBRnFYcte+tBATygTJyvAiF8PMo21+ADg0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmCncGDSSdcfqIIrRxuvPGq8GBzaMWSoFP1+/GbVdC4S+pb6vOXXwwEYHfnHZY8Cn
	 VTBPcvNG7zAi5DgR4J+25vLRX/APnkwzEXsdfke2GInWIiVzVTsNxBxLQZl0VKUjN3
	 ZfLTGeOcFKc2Jm5+9m5Q0V3a8bYU3Uurv4a1pnsZEUeC/qWLsHCOoZ5trQaEXR8AiF
	 KjmaCqd7fPFkQHg5zRuiYiXSkne0H9al2+0X9KcGY6pu2jRj7yjZEH0D4Tv2m9x2bt
	 QUJttVFp4LpaZ/Ct1npI/v4VKJm6uFhzDVTz0sSjqQElyHYk5v3dSuchc8Q80shHUM
	 GTANWxXuf7vAg==
Date: Mon, 6 May 2024 22:17:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
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
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 1/5] x86/bugs: Only harden syscalls when needed
Message-ID: <20240507051741.4crk2pd2fuh4euyd@treble>
References: <982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org>
 <ZiYbPZ1biNCEndKZ@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiYbPZ1biNCEndKZ@yujie-X299>

On Mon, Apr 22, 2024 at 04:09:33PM +0800, Yujie Liu wrote:
> On Fri, Apr 19, 2024 at 02:09:47PM -0700, Josh Poimboeuf wrote:
> > Syscall hardening (converting the syscall indirect branch to a series of
> > direct branches) has shown some performance regressions:
> >
> > - Red Hat internal testing showed up to 12% slowdowns in database
> >   benchmark testing on Sapphire Rapids when the DB was stressed with 80+
> >   users to cause contention.
> >
> > - The kernel test robot's will-it-scale benchmarks showed significant
> >   regressions on Skylake with IBRS:
> >   https://lkml.kernel.org/lkml/202404191333.178a0eed-yujie.liu@intel.com
> 
> To clarify, we reported a +1.4% improvement (not regression) of
> will-it-scale futex4 benchmark on Skylake. Meanwhile we did observe some
> regressions by running other benchmarks on Ice Lake, such as:
> 
>     stress-ng.null.ops_per_sec -4.0% regression on Intel Xeon Gold 6346 (Ice Lake)
>     unixbench.fsbuffer.throughput -1.4% regression on Intel Xeon Gold 6346 (Ice Lake)

Thanks for clarifying that.  I'm not sure what I was looking at.

I also saw your email where Ice Lake showed a ~10% regression for
1e3ad78334a6.  Unfortunately my patch wouldn't help with that, as it's
designed to help with older systems (e.g., Skylake) and newer (e.g.,
Sapphire Rapids) but not Ice/Cascade Lake.

Whether 1e3ad78334a6 helps or hurts seems very workload-dependent.

It would be especially interesting to see if my patch helps on the newer
systems which have the HW mitigation: Raptor Lake, Meteor Lake, Sapphire
Rapids, Emerald Rapids.

For now, maybe I'll just table this patch until we have more data.

-- 
Josh

