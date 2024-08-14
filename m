Return-Path: <linux-kernel+bounces-286847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD0952000
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600C3B2CD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4E1B9B5C;
	Wed, 14 Aug 2024 16:19:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BEC1B8E8B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652342; cv=none; b=Zz6rv87HMnuIJcUv7qIN+TkO920600PFdFYMlosJVHNReWqhATxjv7MmBZWg8U4S1doCf+L2NoTHbbuOeQ83rWfmE7NRG+sMwgY8lLkK0+j5zhkzkEUGimqrsCEX7c5OEy57WL2+XvGNUZZGVfoGMMFYglqAly8mmSGV61B8u/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652342; c=relaxed/simple;
	bh=gQl4CJBjFRKm9G1zC4K8nJuQznRLI2vG3Uy+zPIUtnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTWElktdJW/B3gZXbHvUUaZOLl12RuUme2hZvhrHKMFo8yFobrRwcAKXys6inbuvMgKHhD5GjGvnF2K3fUqTtDNrY7QHK39lIwnv32Vid2a0HfDg5RSTKGiVw+nZdSQyqnwmnYtmYMPsoDPtquq5fYla51En8iUh2bE9b6suFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4F4C4AF0D;
	Wed, 14 Aug 2024 16:18:58 +0000 (UTC)
Date: Wed, 14 Aug 2024 17:18:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Shaoqin Huang <shahuang@redhat.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix KASAN random tag seed initialization
Message-ID: <ZrzY8Kk-1PwZlezI@arm.com>
References: <20240814091005.969756-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814091005.969756-1-samuel.holland@sifive.com>

On Wed, Aug 14, 2024 at 02:09:53AM -0700, Samuel Holland wrote:
> Currently, kasan_init_sw_tags() is called before setup_per_cpu_areas(),
> so per_cpu(prng_state, cpu) accesses the same address regardless of the
> value of "cpu", and the same seed value gets copied to the percpu area
> for every CPU. Fix this by moving the call to smp_prepare_boot_cpu(),
> which is the first architecture hook after setup_per_cpu_areas().

Even with the fix, given the lower resolution of get_cycles(), there's a
good chance that we still have the same seed on all CPUs. If we want
separate seeds, a better bet would be to initialise each CPU separately
via the secondary_start_kernel() path. I'll let the KASAN people comment
on whether that's important.

-- 
Catalin

