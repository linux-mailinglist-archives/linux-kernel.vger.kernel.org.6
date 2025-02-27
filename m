Return-Path: <linux-kernel+bounces-536966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A653A4866D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B81883FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8F1DDC29;
	Thu, 27 Feb 2025 17:19:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDD1D6DA8;
	Thu, 27 Feb 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676758; cv=none; b=ismCJkVtu4JlOe3HmHR3Cew/wnpjQUaJqQFHWB6PzA3gih0E0uZvdnSBgAzSNb6hLgvvRdPWyHvEMvMsxAeMZSVQ9RkPmufAUoJ0ZhTfHdDrEvYKl5F5qy/tEwBfwuVr0KDdxtZ2QmwIVssEegxB/dq6HSRr/7eyx3QneuhY9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676758; c=relaxed/simple;
	bh=GhKNCjpu8J5JxBDRjMz4sB0ZqqBj/+kIMtcCv7oYomU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d51BCJ9YnuHthcpywGdcP6oTlsO9drn/XJcGCSfdCQV/4yTh7hB6KRz/OKq99OQS7Vei/RUqeskSUV2v45MhsOfrQkJhFaRTvTYl3YYxSIXfnVbWN29slx9+uf3c93L7+Svb2zMHNY6zwWVDTm058nJ8nO5JTw8h69fiekSQ8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821711477;
	Thu, 27 Feb 2025 09:19:31 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889613F5A1;
	Thu, 27 Feb 2025 09:19:13 -0800 (PST)
Date: Thu, 27 Feb 2025 17:19:10 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <Z8Cejs-jkYwHr_90@bogus>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-7-vincenzo.frascino@arm.com>
 <Z8A6FttvudR6rjzk@bogus>
 <20250227171456.GA25617@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227171456.GA25617@willie-the-truck>

On Thu, Feb 27, 2025 at 05:14:57PM +0000, Will Deacon wrote:
> On Thu, Feb 27, 2025 at 10:10:30AM +0000, Sudeep Holla wrote:
> > 
> > On Fri, Feb 21, 2025 at 06:03:45PM +0000, Vincenzo Frascino wrote:
> > > Add support for the ARM Rainier CPU core PMU.
> > >
> > 
> > I can't take this through Arm SoC as the DTS and dt-bindings changes
> > are kept separate from the driver changes in their pull request to Linus.
> > 
> > I need to keep the bindings(05/10) and the DTS(07/10) together to avoid
> > DTC warnings.
> > 
> > So the 2 options I see are:
> > Defer this driver change until the bindings last upstream.
> > OR
> > Just take the perf driver change without the binding via perf tree
> > 
> > For now, I will take all other patches except this.
> 
> Works for me. I'll pick up the driver patch.
> 

Thanks Will.

-- 
Regards,
Sudeep

