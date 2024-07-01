Return-Path: <linux-kernel+bounces-236260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A791DF99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956EEB23421
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551115921D;
	Mon,  1 Jul 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOrGFwGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7450158DDD;
	Mon,  1 Jul 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837715; cv=none; b=I15rFh+wR10o/I/DB6su0DPCTPsP/epAreJKq+Hj2NVR4X1jYDOFhbDaNXSExXzB/8BufVZcWnHTTZui93RJSV8w1NqDe0KHHQLuaq4nVhw4mdNvuDJyCgjdlpju6T5uQVpBto6fthBkovAdt+U/KyHlDaTNFPNovFTrnF55xVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837715; c=relaxed/simple;
	bh=ihcaF3I5EST7/gh26RJbcWXrvF2VUf3XZhHK396ADEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Uhs2xzBMI397LtT600R/fVYOwjma/nNrFBUpBxaQqOY7KXP6tU8l5LGMCBLq/Zyk8aSbjTLdYiUfCAs/YjWRHDO5iPNM50SPvgjwL5/l9jpTTf1oFhvwGnfrojFuAA2h8yIhd520Aj9wzXor4aGhTf5XNW4g6iLhlscvcg5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOrGFwGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB6C116B1;
	Mon,  1 Jul 2024 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837715;
	bh=ihcaF3I5EST7/gh26RJbcWXrvF2VUf3XZhHK396ADEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOrGFwGGKN5lI/CJUfdrHs/8GxLfqXIKjyaI9b1Hd1PWF6oNMCa9sg/PEoF0+L547
	 djeXuDFAvRf01uwC4eXKoueFCp4+GHY//51rEsCpY1YSSPvIyep6ByNVH7s0a+Nzx6
	 ITyRLFEMGh+4rkSQh0o0V7KDaflJroM081iuWe83EH3gy5u05LBpKkEKolaFkuuaMu
	 0NMWR+RwmYCIs1ubSRDuwdrwRBhXDP+MfStM9oGjB87efyEPlWSdD6mBPKnmtrdqpi
	 WQkPebsQ9TVZdnHLbTrXa0EhP+O/eQ6xTjnbKuX+Zc19lqU+mR481VPfJWR5hlcV4x
	 GHkzRz4hzZxBg==
Date: Mon, 1 Jul 2024 13:41:49 +0100
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Mainline: v6.10-rc6 boot failed across all arm64 devices
Message-ID: <20240701124149.GA2095@willie-the-truck>
References: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
 <145b39a0-da05-4c60-a019-c1a6211e6c77@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145b39a0-da05-4c60-a019-c1a6211e6c77@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 01, 2024 at 01:12:07PM +0100, Mark Brown wrote:
> On Mon, Jul 01, 2024 at 05:28:29PM +0530, Naresh Kamboju wrote:
> > The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
> > qemu-arm64 and no crash log found (earlycon) did not help.
> > 
> > But the defconfig builds boot PASS.
> > 
> > The boot problem is with defconfig + Extra Kconfigs and builds links
> > provided in the bottom of this email.
> > 
> > The boot test history shows that,
> >   GOOD: v6.10-rc5
> >   BAD:  v6.10-rc6
> 
> Other CI systems aren't showing this.  I'm guessing you've updated the
> toolchain versions you're using and are running into:
> 
>    https://sourceware.org/bugzilla/show_bug.cgi?id=31924#c9
> 
> and will see this with other kernels.  It's probably worth testing
> toolchains before deploying them...

Aha, that would explain why I'm failing to reproduce this with clang or
my old version of GCC. I only see the problem with the binary provided
by the CI.

Will

