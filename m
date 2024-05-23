Return-Path: <linux-kernel+bounces-187307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA78CCFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791661F237EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495C13D899;
	Thu, 23 May 2024 10:06:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFF54FA9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458778; cv=none; b=iBfLz0xBqetBThVfqMnNdJMpm3Samgw9pfSj3ipEPCzDf3PIVb/S1AYkR59CrNXvbb5u6JshVghvFnu9LxrT61iwlYJXp77Q/O8K68alO7ha6r37DozzIP0dhwQsCZuXcQzoAJGarea4sAp2xUCa9Y24x3WqQHYrfueEeJK6aUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458778; c=relaxed/simple;
	bh=01ooiBngkExdL4vCJt12BGebosjA5sPO8bjgk9iOBQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Y9xaRfWI0FAY3emaE84RA6dY9Faq/cYR7Oz+8hhvw7Z25BHy2Sk88wh19LKC/2STA7//OPe8wkyotYKImF11RdWUvPoh/vMjVHTOkoV+mAAOc3Ut2dlYOjPT6R8pL6ukXrg3nsLt5mBOQgm3Z/kM9/fSm1qln17DaRhr7TDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41DDC2F4;
	Thu, 23 May 2024 03:06:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6CD3F766;
	Thu, 23 May 2024 03:06:15 -0700 (PDT)
Date: Thu, 23 May 2024 11:06:12 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ross Burton <ross.burton@arm.com>
Subject: Re: [PATCH] clocksource: sp804: Make user selectable
Message-ID: <Zk8VFNx5v_aIjGtN@bogus>
References: <20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org>

On Wed, May 22, 2024 at 06:44:41PM +0100, Mark Brown wrote:
> The sp804 is currently only user selectable if COMPILE_TEST, this was
> done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> spuriously offered on platforms that won't have the hardware since it's
> generally only seen on Arm based platforms.  This config is overly
> restrictive, while platforms that rely on the SP804 do select it in
> their Kconfig there are others such as the Arm fast models which have a
> SP804 available but currently unused by Linux.  Relax the dependency to
> allow it to be user selectable on arm and arm64 to avoid surprises and
> in case someone comes up with a use for extra timer hardware.
>
> Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
> Reported-by: Ross Burton <ross.burton@arm.com>

Thanks for the quick fix Mark!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

