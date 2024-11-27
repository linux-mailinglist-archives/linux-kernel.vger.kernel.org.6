Return-Path: <linux-kernel+bounces-423463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659779DA7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32827281C18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88E1FBEB8;
	Wed, 27 Nov 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Pu0Umx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FF1FA82E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710368; cv=none; b=XbD+CdxT5x3+OMm39jKJt9FsAqf1dQHnN7ak3VGkv7kvyK5C6Z6XcPW3B6/XwEWMVxoIeIfkg7+n1H8iS9HWHiIGNELnGTHXYK5QmmLrP7QUrUBuO/maHy2WgHQztgMLHMCbpy4K+hzy2kgPOwuF2k7/7rXAElUGJZmO2DP9we0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710368; c=relaxed/simple;
	bh=Vulef0y4BjI2kMvl6+Wmc7w+5GHFR+tZnL8++UF5SF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlisNylpj2ndOP9o6jb0Qaqm7zttcqfV8nO3ImCmqPAUIstgw36udvbdlDgZ2T16e77PC2TYbAsworUROgNgevbcEoue+dKm4pXps3jrXf/7jHMDJeInzN6j4YQEfSILPMFn3xaBYgs8ZvC+7Tm+jsO8iwgIOS22Fce4iUgz3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5Pu0Umx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E0C4CECC;
	Wed, 27 Nov 2024 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732710367;
	bh=Vulef0y4BjI2kMvl6+Wmc7w+5GHFR+tZnL8++UF5SF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5Pu0UmxHMp+h+Q93JzDQszXbNYp1eUEuBrW8GBZUzF6IgdjZ7E7lKavCrIWq36Iu
	 9jVzr6akH42GWk+2xpkbeu47mzx5Q3TwAWuNfSnD+UahS8aOxcsihxtlsIZVugEPeY
	 Dc+ek+biZoGq2TkODJQxoU2Lyvwudp7/Gn5G5mWg+IoYJRyyW5kRm8gQcgA4RQ8YHi
	 u3W1/1+vY5/AxBCZ0poy+nEogflXT6pN3pxCxn1Y0s7GQaTYDtiULf7EYPpyG78XaX
	 HQwUA1bDEiGzDjmu6BfYqV88gULbG7QIha8rk7HFW2dcwn8lqJcmvPrMxDGQHy6LeJ
	 vHWmuU7U8/+SQ==
Date: Wed, 27 Nov 2024 12:26:03 +0000
From: Will Deacon <will@kernel.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] Depmod is failing on allmodconfig for arm64 and
 x86_64
Message-ID: <20241127122602.GA2530@willie-the-truck>
References: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 26, 2024 at 06:25:44PM +0500, Muhammad Usama Anjum wrote:
> Hi,
> 
> The depmod is failing on 9f16d5e6f2206 (mainline) arm64 and x86_64 because of:
> ```
> depmod: ERROR: Cycle detected: libphy
> 
> depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
> depmod: ERROR: Cycle detected: ptp
> depmod: ERROR: Cycle detected: stp
> depmod: ERROR: Cycle detected: ipv6
> depmod: ERROR: Cycle detected: bridge
> depmod: ERROR: Found 2 modules in dependency cycles!
> make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> make[1]: *** [/tmp/kci/linux/Makefile:1844: modules_install] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> ```
> 
> This issue wasn't present until c66fbc6c3df9. 

$ git show c66fbc6c3df9
commit c66fbc6c3df9ccefbb896695cfc4db279d517ff1
Merge: f103749785a7 1037d186edfc
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Nov 20 14:56:02 2024 -0800

    Merge tag 'for-linus' of https://github.com/openrisc/linux

    Pull OpenRISC update from Stafford Horne:
     "A single fixup from me: Fix bug with earlycon being broken due to
      removal of early_ioremap"

    * tag 'for-linus' of https://github.com/openrisc/linux:
      openrisc: Implement fixmap to fix earlycon


Are you sure?

Will

