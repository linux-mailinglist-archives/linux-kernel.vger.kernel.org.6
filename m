Return-Path: <linux-kernel+bounces-236274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223591DFD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02801F23451
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4E15A851;
	Mon,  1 Jul 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX1nvOxp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9E15A489;
	Mon,  1 Jul 2024 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838060; cv=none; b=SkDVI5hlYD6NjktDNFNcpOr5kmkr1P4KbDYpIIMrinbr/Q9fpKG4pNj9KgSqOKkFkJL4ErXdVP+sHtzadUSnseQFArxxBi3H785zBzTj2tnCd++4SMl4jVZmg9zpnWWsSt48hqk94sVYadiA+KiiGxju9r5nyFw1k7OjgLnlZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838060; c=relaxed/simple;
	bh=LfYQTMCfmMbGIovdjPNb6rCWeA4AeChPckEiZHS4laY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAtCLoUC+rDcgEezx3qV60tAlvKh9yEnjTGvNqH6+7UouNWlYwk599rIrXl2qczhFafwT1T7H4EjWzPLeVYN1prAJXOb+NznggJCMS1aegbqZDclHGKTxVA7N9afD5O71uIFEUH0AYCGEiwE2YarBdlylNT/NXt4vnWy2ZJkDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX1nvOxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D7C32786;
	Mon,  1 Jul 2024 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719838059;
	bh=LfYQTMCfmMbGIovdjPNb6rCWeA4AeChPckEiZHS4laY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EX1nvOxpwjmROiPDwmMaf2i/4KZEarkTkP2uaL++hxCyQP5dFxCtOUkbBdA5RKehE
	 l/KdTXQF1gVv9Y6StTRp4EZG48AiZUmXEI76/iE5xf/AucSmCD7d9aGevX52EhRVmc
	 q0IneWK85/Qfkr1dV1rZzppu4KnGQNV3iOOZYMFhReKieI/sYJ4KXIYGQtppnja5lE
	 6rGZ3PsCR3ik9+AbnzFWePNcGqMpAR0Y1pZImCl+402Na9zm4kpuxu1uZNTJsfMSga
	 KBr20GXD3lCPp15Y5LeBg2Iiq4L02MOBD6GiGMWeS1ukIt/TB698Ls/uHe73iHkRwd
	 ojdmNskJL74Aw==
Date: Mon, 1 Jul 2024 13:47:34 +0100
From: Will Deacon <will@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Mainline: v6.10-rc6 boot failed across all arm64 devices
Message-ID: <20240701124733.GB2095@willie-the-truck>
References: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Naresh,

This report is quite hard to follow, so just some minor comments which
you can hopefully take on board to improve things in future:

On Mon, Jul 01, 2024 at 05:28:29PM +0530, Naresh Kamboju wrote:
> The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
> qemu-arm64 and no crash log found (earlycon) did not help.
> 
> But the defconfig builds boot PASS.
> 
> The boot problem is with defconfig + Extra Kconfigs and builds links
> provided in the bottom of this email.

If I go to the bottom of the email, I see this:

> Links:
> -----
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrbdtwMqpD9wx7IPRGJ7Dsx3/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrYDposdlRsS4jwF916a0qGE/
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473346/suite/boot/test/gcc-13-lkftconfig-libgpiod/history/
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473903/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/

but these are just random links without any context. The first two appear
to be kernel build artifacts, but I can't tell:

  - Are both "good" or "bad"?
  - What is the difference between them?

If I look at the first of the last two links, click through to the
"qemu-arm64" target and follow the "job_url" link, then I end up at:

  https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2idWuAb51mcz7lO1BAj8Aw0BrNY

which has some empty logs and something from "TuxRun" which says:

  {"error": "File not found"}

It's very hard to know what to do with this :/

Will

