Return-Path: <linux-kernel+bounces-230684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABAA918082
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418751F24F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1E181B91;
	Wed, 26 Jun 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIJIWohu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A5180A6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403501; cv=none; b=fLieSOyYFOLMriDGvlmRbkFWy0qGVfqUcQ0aw4MdoO7Hwelu7Kb6dVTf+xsFQ4vcqr0p80k74fdcuEPVfsbbPQx4Cis9mk29+vER6fT9H3zXHtl5ZptdB6JPhSp5tsg1V2+IMt3kDVwfxAKlzPYPBLhj20kktPJOXLzOZT3O5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403501; c=relaxed/simple;
	bh=2uHDlGI4Mkm4jPb0WidaIGWBR2l/OxTlZaVOBsJiMIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjf9VzRB4ZJVM1T+PN4R1CDvqlD2W1dZD80PdVyaIJkmKWUl7+eXD14lKPc58NpxQyOOi/Q5e/+A+oVGVWeU6ZhheVe3+TOjKEp1PREobI89YcHYBQoj1c3gLNSRUNSCjmpsN0xk6Krk/+V6jX4mZ993RBwhks4PFLclfDz8z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIJIWohu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073CC32786;
	Wed, 26 Jun 2024 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403501;
	bh=2uHDlGI4Mkm4jPb0WidaIGWBR2l/OxTlZaVOBsJiMIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIJIWohuVu9Es+FhJFnQDacFByt/NzWi/EQzCRN1IRgMYcENXVihg30Uw+ytU8c9Q
	 lA3svGvI0JtY7eoSDIgxOth06mBqeOTQikD0z/q8xvIjg2Y00GN40JxjRe94tFSqGQ
	 XL3oI4alBePURw+4ZHGjv5mkc1DtNBF2SHF/Eyv0f87eInKMLRKvbBnEYLIYov01Xn
	 e3OQPTFOPl4eCz+trbfyudzcPBvq0lDPLP1kWr3Pc8kmLZJXklM7uKg9Vhs+s4uqR8
	 OX+ICpRqb8dNC+/2/5GSMKTYCo4K4xx/r5OPvrF8hsG4fFcSdqvIbj6Lt9PDL27oxe
	 2cgE47E6KqNTg==
Date: Wed, 26 Jun 2024 19:50:57 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/lib: copy_page: s/stnp/stp
Message-ID: <ZnwAoWh-_bTxT-rT@xhacker>
References: <20240613001812.2141-1-jszhang@kernel.org>
 <ZnmzUa2D_wWXAlJl@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnmzUa2D_wWXAlJl@arm.com>

On Mon, Jun 24, 2024 at 06:56:33PM +0100, Catalin Marinas wrote:
> On Thu, Jun 13, 2024 at 08:18:12AM +0800, Jisheng Zhang wrote:
> > stnp performs non-temporal store, give a hints to the memory system
> > that caching is not useful for this data. But the scenario where
> > copy_page() used may not have this implication, although I must admit
> > there's such case where stnp helps performance(good). In this good
> > case, we can rely on the HW write streaming mechanism in some
> > implementations such as cortex-a55 to detect the case and take actions.
> > 
> > testing with https://github.com/apinski-cavium/copy_page_benchmark
> > this patch can reduce the time by about 3% on cortex-a55 platforms.
> 
> What about other CPUs? I'm also not convinced by such microbenchmarks.

Per my test on CA53 and CA73, CA73 got similar improvements. As for CA53
there's no difference, maybe due to the follwoing commit in the ATF:

54035fc4672aa ("Disable non-temporal hint on Cortex-A53/57")

> It looks like it always copies to the same page, the stp may even
> benefit from some caching of the data which we wouldn't need in a real
> scenario.

Yep this is also my understanding where's the improvement from. And
I must admit there's case where stnp helps performance. we can rely
on the HW write streaming mechanism to detect and take actions.

However, sometimes, the "cache" behavior can benefit the scenario. Then
in this case, the stnp here would double lose.

what do you think?

> 
> So, I'm not merging this unless it's backed by some solid data across
> several CPU implementations.
> 
> -- 
> Catalin

