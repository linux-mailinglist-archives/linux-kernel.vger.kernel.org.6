Return-Path: <linux-kernel+bounces-535962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C671EA479CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C316EB42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770D228CBC;
	Thu, 27 Feb 2025 10:10:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F821B9EE;
	Thu, 27 Feb 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651038; cv=none; b=qizZJOMmwTRQQwBhWu6eU/L+J15cR8nf9GFuBQ3FYI38MZvjCCIn96mQQCQkwSQ+BjotJ6AYLypsaOSS4vjjZUyTy6yxEGK0+GK3UgKiPUuNNShGZLCmcCVwT+qINueu7mQeGvKx6dQDlHFRMNvO5rl0KI0x+HodWrwD6zukV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651038; c=relaxed/simple;
	bh=Y9gKbMls8JcPodgTXFcP0NunrUCm3EdPae1E65HDWVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyfdE52ZCB4Pq8MaTaQUjZPuXVIAs803MhMNtc1/LD8sL0P1eakZUk67c0oiRPR16CslI7C9pgDR415aqTZoPgvs84EaVUxpmDN4cITWKloZEbn35NvQ/RUpnxQt0cJ6EALkZGKqUtpUncYMIhnNLXoFG2nRoc5c2q4zuDKdv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED78E2BCC;
	Thu, 27 Feb 2025 02:10:50 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07D6A3F673;
	Thu, 27 Feb 2025 02:10:32 -0800 (PST)
Date: Thu, 27 Feb 2025 10:10:30 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
Message-ID: <Z8A6FttvudR6rjzk@bogus>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-7-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180349.1413089-7-vincenzo.frascino@arm.com>


On Fri, Feb 21, 2025 at 06:03:45PM +0000, Vincenzo Frascino wrote:
> Add support for the ARM Rainier CPU core PMU.
>

I can't take this through Arm SoC as the DTS and dt-bindings changes
are kept separate from the driver changes in their pull request to Linus.

I need to keep the bindings(05/10) and the DTS(07/10) together to avoid
DTC warnings.

So the 2 options I see are:
Defer this driver change until the bindings last upstream.
OR
Just take the perf driver change without the binding via perf tree

For now, I will take all other patches except this.

--
Regards,
Sudeep

