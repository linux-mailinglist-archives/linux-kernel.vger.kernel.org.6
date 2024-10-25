Return-Path: <linux-kernel+bounces-381298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4C9AFD54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C391F23D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF51D31A9;
	Fri, 25 Oct 2024 08:57:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246D1C878E;
	Fri, 25 Oct 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846652; cv=none; b=YRpuWUhKaSp2jDtQVrgRVBPGjGUWfiP9+657SDGWyNjIdoDZdLLM4fvADBqNd2yUUFLZP/UXD6WdZ1t1D2mrNKGjBDWIzG2lM4wqmhcGTIug9P99ruD/ZOw3/T/gH+q5j1pUagxIkd5BrAuNwPbHXjvX/GrLuEgnwwFHHuQhjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846652; c=relaxed/simple;
	bh=BKU9eGjiGpcEW9DhjB7Jaj0ZFVcpGNTSeTnuNH8OLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgy4c5NValaXOgva+yuFxNx2sxtmst9H0aPnqniT7jB5b8WWm7PMyTuDAuH1/hhGJjGLcgx12nNncP1+k8zaUiN1WjXOyC3lgqK/quY4Fte5HTzr63grOihhLVK4kbvCEC/H4+Uw0pk4t81BYu1nPH+lEyMggRAubfU5YeX6Mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93963339;
	Fri, 25 Oct 2024 01:57:59 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9815C3F528;
	Fri, 25 Oct 2024 01:57:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:57:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	Florian Fainelli <f.fainelli@gmail.com>, kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <ZxtddQoBAjYN4hHa@bogus>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
 <20240827182450.3608307-3-florian.fainelli@broadcom.com>
 <20240903154000.GA2080277@bogus>
 <ZxJbJa8Q3V02yf_z@bogus>
 <Zxop6E83YId0et5o@bogus>
 <04050b73-eb16-440f-acd7-986b1f39a6c9@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04050b73-eb16-440f-acd7-986b1f39a6c9@broadcom.com>

On Thu, Oct 24, 2024 at 09:45:25AM -0700, Florian Fainelli wrote:
> On 10/24/24 04:05, Sudeep Holla wrote:
> > Gentle ping! Not sure if my earlier email got into spam or didn't land
> > in lore/ML. Just thought of checking again.
>
> You did not land in spam, just being quite busy.
>

Ah good, at times our email server acts up, so there is always some
doubt about it 😄.

> >
> > On Fri, Oct 18, 2024 at 01:57:09PM +0100, Sudeep Holla wrote:
> > > On Tue, Sep 03, 2024 at 04:40:00PM +0100, Sudeep Holla wrote:
> > > > On Tue, Aug 27, 2024 at 11:24:50AM -0700, Florian Fainelli wrote:
> > > > > Some shared memory areas might only support a certain access width,
> > > > > such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> > > > > on ARM64 by making both 8-bit and 64-bit accesses to such memory.
> > > > >
> > > > > Update the shmem layer to support reading from and writing to such
> > > > > shared memory area using the specified I/O width in the Device Tree. The
> > > > > various transport layers making use of the shmem.c code are updated
> > > > > accordingly to pass the I/O accessors that they store.
> > > > >
> > > >
> > > > This looks good to me now, much simpler. I will push this to -next soon,
> > > > but it won't be for v6.12. I have already sent PR for that. I want this
> > > > to be in -next for longer just to see if anyone has any comments and
> > > > doesn't break any platform(which it shouldn't anyways).
> > > >
> > > > Just hoping if anyone looks at it and have feedback once it is in -next.
> > > > I will apply formally at v6.12-rc1 and report back if no one complains
> > > > until then.
> > > >
> > >
> > > Hi Florian,
> > >
> > > Just thought I will check with you if the content is -next are fine as I now
> > > recall I did the rebase as this patch was original posted before the rework
> > > of transport as modules were merged. Please confirm if you are happy with the
> > > rebase as you see in -next. I also had to rebase it on recent fixes that
> > > Justin added as there were trivial conflicts.
> > >
> > > Another thing I wanted to check is if [1] series has any impact on this.
> > > IIUC no, but it would be good to give a go in terms of testing just in case
> > > that as well lands in -next.
>
> linux-next as of today (2024-10-24) still works good on the affected
> platform, thanks for asking!

Thanks, though note that I am not sure if the series [1] I mentioned in queued
yet or not.

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20241010123627.695191-1-jvetter@kalrayinc.com

