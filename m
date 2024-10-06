Return-Path: <linux-kernel+bounces-352185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFB991B6E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9480E2832BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C4165F18;
	Sat,  5 Oct 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IBDTV5eJ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F1F61C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728171667; cv=none; b=lkwwy9DPULjHoCVXyaUxTNllRozmDxWlI9ZGu8YH5EUVOChUJ+rxkaNAX8A5H6SNB6ERgVjssz5gxCXexvnRDb2y4tIWzEfR09SBiPMBuzGNkKv3UczPiNUaFw5hRINGcLOqOSKg3oW/vgwaLVQx0LdqJI949WcSMzfGbBcsI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728171667; c=relaxed/simple;
	bh=HRFm4/t2t9NRoBAlYcqFtrp/N0q2veNV8kygHa6Kfro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkTM+ryVZ0Te9u366ukA3qU6WKRl+AoqrKqDKto59W/QMowfW7KP201UgKf/mC47V6rQTUwVwEyaYYv2He3wcuDTtKGHcIgw0elEH09IoT82XDsApR/EBWZZO3z2n/toSIWpjUaeqRMCB6XZmGGHdfELm9lDpQMvPt8sDwFPDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IBDTV5eJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 19:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728171663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N94jXO8rXgw/sYZ7EbL/8D5WR9t7A3fqzLTeq3yNnDY=;
	b=IBDTV5eJfSgYxkLZAkwuZbh9fg6OzYQ0A3NV3bSva58ItNuu82TqgC3Nj2WSu5cNYdoDqF
	FQ8S52wfBumnVVVHqBw36dk77TDAuTa7X9K3OS6Bi1aWBXy1Wwyz0pllYZdZsDkHke+qZF
	M0mOKxLhjnEaEPnVi1v6gwdL7JHIct4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 04:15:25PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 15:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > The vast majority of those fixes are all ~2 weeks old.
> 
> With the patches not appearing on the list, that seems entirely irrelevant.
> 
> Apparently they are 2 weeks on IN YOUR TREE.
> 
> And absolutely nowhere else.

If what you want is patches appearing on the list, I'm not unwilling to
make that change.

I take issue, and indeed even dig my heels in, when the only people
asking for that are _only_ yelling about that and aren't involved
otherwise.

But you will find that if you talk to me as one human being to another,
where we can share and listen to each other's concerns, I'm more than
happy to be reasonable.

But I'm not going to just toe the line when it's just yelling.

Seriously.

Because the last time you flipped out over a pull request, I spent the
rest of the cycle telling people "x y and z are fixed, but you'll have
to build my tree instead of running a released kernel". And that gets
tiresome; some of the bugs were significant - and no issues to date have
been found in the stuff you kicked back, which tells me my process is
just fine.

So let _that_ sink in. In order to support my userbase, as well as
iterate to find the _next_ set of bugs, I have to be able to ship
bugfixes in a timely manner, and if that's going to keep being an issue
perhaps I should be having those conversations with distro kernel
maintainers now, instead of later.

> > Let that sink in.
> 
> Seriously.
> 
> You completely dodged my actual argument, except for pointing at how
> we didn't have process two decades ago.
> 
> If you can't actually even face this, what's the point any more?

Face _what_ exactly? Because at this point, I can't even tell what it is
you want, what you're reacting to keeps shifting.

