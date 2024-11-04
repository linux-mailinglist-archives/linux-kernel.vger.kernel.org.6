Return-Path: <linux-kernel+bounces-395165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835AB9BB9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A91D283256
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D11C07E2;
	Mon,  4 Nov 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FukKASQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C06208A7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736155; cv=none; b=EEfy+tfyX8RUewWk915d+GTI6AJWcQ+NvSs/7hb20kPHMRNZ8RYqlD6Fsb4tfvZeA6D1tuCL8ihMEq5F0G7v6eE8qn3c7c6mkgCnhgmQHg9GmDqNNQTZBEAHc2SKISqyLw98C0RO21YNCdpZI791fxd3nilqkM+ifFtL4ATsgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736155; c=relaxed/simple;
	bh=tTuYSJUwPYIHQIlVCky/nVA69xBMEEAABvv+/p364UE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RfamQ6EWVujlCpqzWY/n7c9d/JnlA5FZzG4BeiZnQzmHvgph+oWrGcMpnXuZ0otCf1W/le8lYBjafF7IkRWrx8n7RIDsKwQw7mlucEVQ5H65e3rHvOFPX03vIqHbYVtI8SOqbCJkX9Qmk8657PdEIXeUhq6Tve6p0PYsl1P9ehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FukKASQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B6C4CECE;
	Mon,  4 Nov 2024 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730736155;
	bh=tTuYSJUwPYIHQIlVCky/nVA69xBMEEAABvv+/p364UE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FukKASQG0SPePaMCPatYhyW4VmiaI5f20pczvMR50kAFL5gVX2lQeAYVbZ/oWj2Jl
	 LLkx74JIAIYl1dD0gElzlKJI2+cb9SXRio7Jzm4rVwXH3R+QyQejUFDonlLp5NLCV+
	 8A3g+1dzAQ5JVV5DFK6ZnK3qnVHcyjqj8wmmFDK3/xuz1CKpq4gZ6xuunMXrVy3B9L
	 ttEFDM2mzXhYu2pnGo6coIXBPpSqmP32cdneex0MTUfO2qQgm2XU0jzar1j4bQzTNw
	 MxLkwXDAzdDOfeOZwCWVj7URcWenDVicNO+U0iofg7mqXgUJkOW1/AO5Brlb5q2UM6
	 9D3pJiu0qtn7A==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20241101165553.4055617-1-andriy.shevchenko@linux.intel.com>
References: <20241101165553.4055617-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: irq: Set lockdep class for hierarchical
 IRQ domains
Message-Id: <173073615378.64475.15494783436766249752.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 16:02:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 01 Nov 2024 18:55:53 +0200, Andy Shevchenko wrote:
> Lockdep gives a false positive splat as it can't distinguish the lock
> which is taken by different IRQ descriptors from different IRQ chips
> that are organized in a way of a hierarchy:
> 
>    ======================================================
>    WARNING: possible circular locking dependency detected
>    6.12.0-rc5-next-20241101-00148-g9fabf8160b53 #562 Tainted: G        W
>    ------------------------------------------------------
>    modprobe/141 is trying to acquire lock:
>    ffff899446947868 (intel_soc_pmic_bxtwc:502:(&bxtwc_regmap_config)->lock){+.+.}-{4:4}, at: regmap_update_bits_base+0x33/0x90
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: irq: Set lockdep class for hierarchical IRQ domains
      commit: 953e549471cabc9d4980f1da2e9fa79f4c23da06

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


