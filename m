Return-Path: <linux-kernel+bounces-535952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495FA479B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1DD7A3072
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D672227E94;
	Thu, 27 Feb 2025 10:03:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6264A1E833A;
	Thu, 27 Feb 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650633; cv=none; b=ikmWABPmDLBAw7f9BXUd/nXGKj9ymixjY1Yhs7KpbVC3LzNFEMpobTbXlekFwfy5Ld9BRT+S5Jig9Vcesftub3+tRNlD4CTr0mcE+2dpGZEi+PWtb8mY/i0Qj91wIuQ+MI4z1rpONTjy+tRry5xLQq0h6S//rx0PQRHgAcHVwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650633; c=relaxed/simple;
	bh=ADEThMSry5ykbyZHq7Sgt5uZWEbC/3nt8AD4Dy+XktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBh2TBB1kkEMNBKZD1dsVCUZKK53Q2AA4wViMtotOA2Y8qyk/8tRzX+hH882vrzN8zB4pX8tWa7juGLBBVI22ELzDRmUgRVJt1a1k/i+YJTxp+Gld8Bms7SVwqv5DUE0DOC0W4dONbO2kBAShJ20yr0UG5dJp45rNRNjo2R0TyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4512BCC;
	Thu, 27 Feb 2025 02:04:07 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5927E3F673;
	Thu, 27 Feb 2025 02:03:49 -0800 (PST)
Date: Thu, 27 Feb 2025 10:03:46 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v6 06/10] perf: arm_pmuv3: Add support for ARM Rainier PMU
Message-ID: <Z8A4gu-TV-XqbdOY@bogus>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
 <20250220180427.3382482-7-vincenzo.frascino@arm.com>
 <Z77tD1VuD_W0CK5B@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z77tD1VuD_W0CK5B@bogus>

On Wed, Feb 26, 2025 at 10:29:35AM +0000, Sudeep Holla wrote:
> On Thu, Feb 20, 2025 at 06:04:24PM +0000, Vincenzo Frascino wrote:
> > Add support for the ARM Rainier CPU core PMU.
> >
>
> I can't take this through Arm SoC unless there is a strong dependency
> and/or urgency. I can take 05/10. The other option is you can take
> 05 and 06/10 via Will's perf changes as usual as I they seem quite
> independent to me.
>
> I can take the rest of the patches through Arm SoC tree for next merge
> window.
>

Sorry, even I manage to reply on v6 instead of v7. Please ignore the
previous email. I will reply on v7 with updated information.

--
Regards,
Sudeep

