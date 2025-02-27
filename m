Return-Path: <linux-kernel+bounces-536274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B762A47D83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674C03A2C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27322B581;
	Thu, 27 Feb 2025 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWhr47Bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783822A1EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658953; cv=none; b=ScIDgz7ba8OwzCBVoyjY4X5prW83g7172u2f6FJqwumYyxouUyW2Kw+0+Rr/FQnObGItnpjGRQTyZouJJ/0MuWK2AQvT1C1+1kccwmPtwrcAwSGp6HRAuqUacKVSkL9v/cKu9s7aqQCBpNzMo4FRXdxXZHz3HQCiMuA6Nc9gg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658953; c=relaxed/simple;
	bh=cVpzKkyBYmpvEbCcTYlxi5MAHKPz41ZFptazsq1Sxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC5m5dvTfgBBwjhN8vK08iUQZxdk2f9WOWPVtMivJU7mki1p8I1n71nDbSDnkY+t7VpP3NfTFuelSkmUECEqAp8PPdJ0KIEu5mcUybBZ/ldRAbeTkxnXyQpuQ7yaYFKWAoo4Cg7/xpb64omNs2vkqdrSVD6srS81+VysQheN+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWhr47Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C6C4CEDD;
	Thu, 27 Feb 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658952;
	bh=cVpzKkyBYmpvEbCcTYlxi5MAHKPz41ZFptazsq1Sxxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWhr47BfjZf78WeGkQQnu9+QY3NjJG+wYL/nLq8M8LqcgB6YsZcXILzTof5zoZjgi
	 shTbf5akpCdeChmZqrcrle1Coco9uJTUgfbS6ZILp/8oS+HkxrYg91DHND7qVpQ0Be
	 PnUVU/9+l9Mpw8ySrE5vPZbF17dYubObE4aT5rL3wZxrfF0FsqQpHKscBHwMT1HysQ
	 bAJrypS1gkK0WKiGULgYmzV+lWzsDTayPWLx5L3zbMryXyCmKQJ2yZJA9lW9ztwn2T
	 1BiG7zQVACXYVxqV79ysh5WmGc8A1QiQ5HOQca67bPLni2uKGzAhXAnwDJ3U7xHVQz
	 89USv31LwwcUQ==
Date: Thu, 27 Feb 2025 13:22:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
Message-ID: <Z8BY_AZPQQm0BJTu@gmail.com>
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
 <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
 <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Mon, Dec 16, 2024 at 5:20 PM Matt Fleming <matt@readmodwrite.com> wrote:
> >
> > On Sat, Dec 14, 2024 at 1:17 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Does your config include CONFIG_UBSAN_BOOL=y ?
> >
> > Yes, it does!
> >
> > > There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
> > > (aka -fsanitize=bool), reported in [1] and fixed for gcc-14.2 in [2].
> > >
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736#c42
> > >
> > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=115172
> > >
> > > Otherwise, please attach your .config, and I'll look into this issue.
> >
> > Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot again.
> >
> > Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?
> 
> No, this is a very rare Oops that triggers only with gcc-14.1 version
> and only when both KASAN and UBSAN are enabled. This is actually the
> problem with sanitization of the percpu address when named address
> spaces are enabled (IOW, sanitization of __seg_gs prefixed address).
> UBSAN creates a temporary in memory, but forgets to copy memory tags,
> including named address space qualifier from the original. Later ASAN
> sanitizes this location as a normal variable (due to missing
> qualifier), but actually should be disabled for __seg_gs prefixed
> addresses.
> 
> Your report is only *the second* since sanitizers were re-enabled with
> named address spaces. gcc-14.2 that includes the fix is available
> since August 2024, and since sanitizers are strictly development
> tools, my proposed solution would be to simply upgrade the compiler to
> gcc-14.2 release.

So unless this is difficult to test for, it would be nice to have a 
compiler version cutoff for the feature. Especially if it's been 
reported twice already, chances are that a lot more people have 
experienced it already.

The kernel build should avoid this known oops automatically.

Thanks,

	Ingo

