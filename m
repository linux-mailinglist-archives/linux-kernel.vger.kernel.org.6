Return-Path: <linux-kernel+bounces-538117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B13A494BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C7317106D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43524C67B;
	Fri, 28 Feb 2025 09:21:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66EF1C2324
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734494; cv=none; b=tRqnQReLd5xkGe7sA6CFulCMqR/9SblPQ+jMH4HdEplvzwZM5/1smG4k7FISv9fM3pREDjW5FztxQfrJGRAGSTalBI3ISXgkpaeFPQaJdUvpa+ZNVdyPpjiJIyaE4s9hpQm5Ie0DUVTlpRyPxKcveq6jMs5krS1fFv53q+g4PYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734494; c=relaxed/simple;
	bh=CltBDih/UFpGka+hBw0AlgOQ7YqRsfv+JeLCRzAMn34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot4sYqcPrmnCQ+yed+IO75SqpYA1He/1lxLxkPB2qszt5feqqJKg7FPKG6kREzJmjTwUlXIOt/2KCVgyFG37CvGWkSQYcF6GlQNcCIf0DwdhMtd8VKChYX0nzDz9lyKoEJndEUpIHyFnt/6UxKfAmVIXryUDkb2STqYZnrG4FBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA201515;
	Fri, 28 Feb 2025 01:21:40 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6FD3F673;
	Fri, 28 Feb 2025 01:21:23 -0800 (PST)
Date: Fri, 28 Feb 2025 09:21:20 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
Message-ID: <Z8GAEDVIUiooPjf_@bogus>
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
 <Z4osWNCUfufciZNG@bogus>
 <20250228082745.rc2u5jiqnq7h737l@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228082745.rc2u5jiqnq7h737l@vireshk-i7>

On Fri, Feb 28, 2025 at 01:57:45PM +0530, Viresh Kumar wrote:
> On 17-01-25, 10:09, Sudeep Holla wrote:
> > On Fri, Jan 17, 2025 at 03:35:52PM +0530, Viresh Kumar wrote:
> > > Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
> > > lead to following warning:
> > > 
> > > WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124
> > >
> > 
> > Looks good, will add to my queue after next -rc1.
> 
> Ping.
> 

Sorry I forgot to respond. I kept this out for now as we need to resolve
the DT bindings.

If you think it can be used/needed irrespective of how we resolve that
issue ? If so, I can queue this.

-- 
Regards,
Sudeep

