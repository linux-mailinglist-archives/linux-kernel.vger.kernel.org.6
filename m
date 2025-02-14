Return-Path: <linux-kernel+bounces-514564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A49A35894
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499A5188ECB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E83221DA4;
	Fri, 14 Feb 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbhEhqDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C0221550;
	Fri, 14 Feb 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520784; cv=none; b=qw47UhzpdHjnWXIY26kGa29kl544YjOVIuqCSOd7im0N9LfNzdxzS5DwmXOgFiOumb5ol4DI4mVKkA+UGrgx/DolHoIHvRv/fEa8mMVUNJ92Rrb3CYvkozO38tFTvZ5K7uGBMmSuh1QPVv3Da489Ojv6HmW7lU5Uph1bebmrGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520784; c=relaxed/simple;
	bh=Ja8vLEEdp2iURJ4Q1c/Tui7Jki+HDJyr8wVl3EMQiII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUA1h/ARsngUIQDFPwb4lbd91oJK9+SE3VpBz6pvx47HO64uihTb+3seafMITwC2NOAE3xTgA+UO4m3jHTvn0m8NSBFCDGfI2CKm4+p6LQifFJpbO0zLoaPPHYYSf2t1uFG37fUT9dhmeK4vbSPxvEL3zKuovpFoYpkY6/4Nn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbhEhqDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B698C4CED1;
	Fri, 14 Feb 2025 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520784;
	bh=Ja8vLEEdp2iURJ4Q1c/Tui7Jki+HDJyr8wVl3EMQiII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbhEhqDYJmwhyU/9lkdItHHzpBhtgcENB5PpXiR5cWIeGnjdaLCKtfziXDuKR7Kqa
	 yc1pSq9d8Lyy3nrf8CBmTTTHLI7ldhwZ3RTjco9iCeQthXAVclAHogT7TXyGp69yCQ
	 HI2x4XHcKuzAt418PltMChS16Qu0NnZ2asG8vYwxY5SEsqEk0sN45ggWONGrWenKE8
	 1xm46qZJtfLuoJ2drrPDbxrv1yRnRzpPp6t+/5CSsNQEVg7/lEIWNxsU9h488ywcBr
	 rEB+Ety64oxCxi2JBDLTTt4I/xlbLgdFLOY9vu8kJX4XRbz0L7usQrAYlrts/GC9pp
	 lwXTlOEnQKvZQ==
Date: Fri, 14 Feb 2025 09:13:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 4/8] perf: arm_pmuv3: Add support for ARM Rainier PMU
Message-ID: <20250214-vivacious-savvy-bee-fcdbd9@krzk-bin>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
 <20250213180309.485528-5-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213180309.485528-5-vincenzo.frascino@arm.com>

On Thu, Feb 13, 2025 at 06:03:05PM +0000, Vincenzo Frascino wrote:
> Add support for the ARM Rainier CPU core PMU.
> 
> Note: Coherently, add dt bindings for the same PMU.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 1 +

Bindings are separate patches.

Please run scripts/checkpatch.pl and fix reported warnings. After that,
run also 'scripts/checkpatch.pl --strict' and (probably) fix more
warnings. Some warnings can be ignored, especially from --strict run,
but the code here looks like it needs a fix. Feel free to get in touch
if the warning is not clear.

Best regards,
Krzysztof


