Return-Path: <linux-kernel+bounces-538915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB5A49ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7206F3A6B01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC127293D;
	Fri, 28 Feb 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2SU+yZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B926A0DB;
	Fri, 28 Feb 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760197; cv=none; b=YwHkK0ZMDOy/xcOuwW3NOVo47rQWhBzMzzWi72pXCInWbzLOqaFdhAU72Kk6HopeNIb1T6ZQL9OCggbp4GnEtT8YLKCIu2WX6tm9uebB418xyCI4wQKIhEsS31ExTxT6hgayaJnenqpunh3LXLykqIm0yuE1hyV7q/3efeaK67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760197; c=relaxed/simple;
	bh=86iLB2xYz5M5aFtDFt/iqtdDh9B1p6wZvxkEDZM9VIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMarotpi246Xl9Ms5YlhIQ0T6VyPRy4n7gal54rY9zuxkXhq6sLZ9o4hU+Myd4J1jwtK5opuszFyRhsr+47rSSB6+1uHZgqmRSdnfwWgtpP3aKqJToFB85es3JpUOHiq4ZhExLVEL7sjs09CRvpVYYmlxoIFJDR08Xx05nfNKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2SU+yZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2553FC4CED6;
	Fri, 28 Feb 2025 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760196;
	bh=86iLB2xYz5M5aFtDFt/iqtdDh9B1p6wZvxkEDZM9VIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2SU+yZr8/rvvbKi1AUsxDvM3pUYedNx/QC6lUo/8mp3mmv0SDb3IBi1LWaTG5dsA
	 3VX2U5+RUfCgeqyE3d2NhH7m+35BLVvxM+skw93CdeEbg411GWPueGwEk16Y3lZFY3
	 7l9j3IEjIKcKBwOncZO5VrJQJQ1gL3ZhGtGYBlT4JBlxCUF9zsMJ6wV3W2JP3YBvDl
	 KEfqbFTNNbaD9oQ0phpUPlZObpEcldQkwPyxsoaRXSTHnhYHrJh7yeE0y1dLPXFrHE
	 qdebZF3X6jeAEl8EY0GGm/f1UUfMedYLNQJaz0HJBvXHr0MHULtnIZPiqBdBBhIYkL
	 GA8eYXcNHENNg==
Date: Fri, 28 Feb 2025 17:29:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86/cpu: Add facility to force-enable CPU caps
 and bugs
Message-ID: <Z8HkeZq1-Ij6MUZE@gmail.com>
References: <20241220-force-cpu-bug-v2-0-7dc71bce742a@google.com>
 <CA+i-1C2dB94t7nDEd-41MgLeHMYGN2oQJyQE8qnkcx+xYdHfpA@mail.gmail.com>
 <Z8GK10q_ouii0O5F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8GK10q_ouii0O5F@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Brendan Jackman <jackmanb@google.com> wrote:
> 
> > Hi folks, happy new year. I hope this ping isn't too aggressive given
> > the season - please let me know if it is.
> > 
> > Any new thoughts on this?
> 
> Sorry, this series got lost in the holiday season (apparently you 
> weren't nearly pushy enough to breach the maintainer patch-detection 
> noise/signal level :-), and this functionality is definitely useful and 
> the series looks good to me.
> 
> Integration with clearcpuid= is so much more generic than the original 
> variant and reuses a lot of that logic, so that's a big plus.
> 
> I've applied it to the x86 tree under the tip:x86/cpu branch and if 
> everything goes fine in testing it should hit v6.15 in a couple of 
> weeks.
> 
> One additional thing - which I'd suggest we make a 4th patch, because 
> it affects the existing clearcpuid= behavior - is to extend 
> set/clearcpuid= with a bit more boot time verbosity, right now it 
> taints the kernel:
> 
>                                 /* empty-string, i.e., ""-defined feature flags */
>                                 if (!x86_cap_flags[bit])
>                                         pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
>                                 else
>                                         pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
> 
>                                 if (set)
>                                         setup_force_cpu_cap(bit);
>                                 else
>                                         setup_clear_cpu_cap(bit);
>                                 taint++;
> 
> 
> I'd suggest we do what PeterZ suggested back in December: in addition 
> to the tainting, also emit an informative pr_warn() for every CPU 
> feature bit enabled/disabled over what was present, and maybe make a 
> bit of a distinction between 'feature' and 'bug' feature bits.

Ie. what I mean is that at minimum upgrade the output from pr_info() to 
pr_warn() - but maybe also make it clear in the output that the kernel 
is tainted and things may break as a result of modifying the feature 
bits.

Thanks,

	Ingo

