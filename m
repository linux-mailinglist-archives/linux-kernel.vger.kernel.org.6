Return-Path: <linux-kernel+bounces-252416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2229312C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883EF283146
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78609188CDB;
	Mon, 15 Jul 2024 11:06:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F3185623
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041581; cv=none; b=qtE8NLROlYD4ciyPlQc3oosjSKNWZTecloeCJGadKm7dofm49/80K4XpdrIQjOmGfb0ZpGIEkvbyBgOy4Wmv/F7xkeZhE2qAnhm1FSAMC9e2gA4OH/6juR8L1ALD15LEk85dbRVKgYu25OaTmy/QN1x/fv7p0+n/JBUooKGbWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041581; c=relaxed/simple;
	bh=lG1YmJpnVpuD05Y9eszU1NLELLc5aK7TkEdatzr5utM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPo+sDAbP7CHI94g4CdO3Usm5zJajyuTdF4NdUkLcI8F/Rq8e+yBp5DZWucVWrs0eNgGnCgx99996aIDPcEY0mDruV5+jwOA5XeBYtuuKaFNK4cBgomp9hiugo0I70LJJro0stE9WRZN+Q46+Ky6sRs3RItE0yvx0ozip1Mlz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F013DA7;
	Mon, 15 Jul 2024 04:06:43 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 040E23F766;
	Mon, 15 Jul 2024 04:06:16 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:06:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ross Burton <ross.burton@arm.com>
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
Message-ID: <ZpUCpn55Fqw_H3ge@J2N7QTR9R3>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
 <2b946a68-dcdd-4a1e-b7c3-416725033c2e@linaro.org>
 <ddfc867d-2431-44d2-9753-b577e8f5ddea@sirena.org.uk>
 <11c5de84-21f0-45de-81e0-dc765a391123@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11c5de84-21f0-45de-81e0-dc765a391123@linaro.org>

On Tue, Jul 09, 2024 at 06:15:40PM +0200, Daniel Lezcano wrote:
> On 08/07/2024 19:44, Mark Brown wrote:
> > On Mon, Jul 08, 2024 at 06:49:38PM +0200, Daniel Lezcano wrote:
> > > On 29/05/2024 21:48, Mark Brown wrote:
> > 
> > > > The sp804 is currently only user selectable if COMPILE_TEST, this was
> > > > done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> > > > COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> > > > spuriously offered on platforms that won't have the hardware since it's
> > > > generally only seen on Arm based platforms.  This config is overly
> > > > restrictive, while platforms that rely on the SP804 do select it in
> > > > their Kconfig there are others such as the Arm fast models which have a
> > > > SP804 available but currently unused by Linux.  Relax the dependency to
> > > > allow it to be user selectable on arm and arm64 to avoid surprises and
> > > > in case someone comes up with a use for extra timer hardware.
> > 
> > > Would it make sense to add the option in the platform so it selects the
> > > timer ?
> > 
> > As the commit log says far as I'm aware all the platforms that rely on
> > the sp804 timer already select it (they wouldn't otherwise be able to
> > work unless COMPILE_TEST was enabled).  The Arm models and possibly
> > other platforms have the sp804 but it will currently be ignored by Linux
> > and the architected timers used instead so it would be wasteful to force
> > it on for them.
> 
> The policy of the Kconfig is we should keep the option silent.

Why?

I can understand hiding an option when it *really* depends on something
that isn't available, but the kernel not having knowledge of a specific
soc/platform isn't the same thing -- it's an entirely synthetic
dependency.

What problem is solved by not allowing the user to select this?

> My suggestion was to provide the option in the platforms Kconfig and
> [un]select the ARM_TIMER_SP804 from there

As above, that means that the kernel needs to have knowledge of the
specific platform, which in general we've been moving *away* form (e.g.
with DT and ACPI tables). For virtial platformas specifically that's a
massive pain because they're *so* configurable -- there's not much the
kernel can rely on being present/absent, and users will want to enable
specific features depending on what they're trying to test, at which
point they'd have to hack Kconfig files...

Mark.

> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 

