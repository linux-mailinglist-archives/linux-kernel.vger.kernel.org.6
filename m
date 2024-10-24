Return-Path: <linux-kernel+bounces-379762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077639AE365
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C269B2270D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A91CB9FE;
	Thu, 24 Oct 2024 11:05:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474E1CACD4;
	Thu, 24 Oct 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767919; cv=none; b=L7/bo7WKP6UYyfg+BjNs7BcJS/40+QIMEGIJ6chbB8jE5KpL2N6yyimKDLU1jK1rYEL6+UIXaNldjR7EGTwzsK2WG2Db3Fd/gXMjPHvf/oBJ1d1ZkHCqmkDPu9b1jkUy1EIJNjj7efq7TH+o3sLswRwfL6kKT7Gv97dX0erUFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767919; c=relaxed/simple;
	bh=ndF0yvLkGaKCCsjJkb+2MY9tsRsjVzNseff8Rwun9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDRA4e5j80q/n3gJChQoaorjqPAiXt/EMGMg4+JLCqL+EFF66FPf+ghnNAhTmX5KKNRNKYjLiPCTnv2ZYm3OMuza+9WHXa73nNeZxiEU4114Qk/cWlny2/nopr1ynVgbCu2orZ1hWqQbI2Bz+utSrd0Qb8iNzRcpkB9zjs1Hv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C46339;
	Thu, 24 Oct 2024 04:05:46 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 912863F71E;
	Thu, 24 Oct 2024 04:05:14 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:05:12 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <Zxop6E83YId0et5o@bogus>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
 <20240827182450.3608307-3-florian.fainelli@broadcom.com>
 <20240903154000.GA2080277@bogus>
 <ZxJbJa8Q3V02yf_z@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJbJa8Q3V02yf_z@bogus>

Gentle ping! Not sure if my earlier email got into spam or didn't land
in lore/ML. Just thought of checking again.

On Fri, Oct 18, 2024 at 01:57:09PM +0100, Sudeep Holla wrote:
> On Tue, Sep 03, 2024 at 04:40:00PM +0100, Sudeep Holla wrote:
> > On Tue, Aug 27, 2024 at 11:24:50AM -0700, Florian Fainelli wrote:
> > > Some shared memory areas might only support a certain access width,
> > > such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> > > on ARM64 by making both 8-bit and 64-bit accesses to such memory.
> > >
> > > Update the shmem layer to support reading from and writing to such
> > > shared memory area using the specified I/O width in the Device Tree. The
> > > various transport layers making use of the shmem.c code are updated
> > > accordingly to pass the I/O accessors that they store.
> > >
> > 
> > This looks good to me now, much simpler. I will push this to -next soon,
> > but it won't be for v6.12. I have already sent PR for that. I want this
> > to be in -next for longer just to see if anyone has any comments and
> > doesn't break any platform(which it shouldn't anyways).
> > 
> > Just hoping if anyone looks at it and have feedback once it is in -next.
> > I will apply formally at v6.12-rc1 and report back if no one complains
> > until then.
> > 
> 
> Hi Florian,
> 
> Just thought I will check with you if the content is -next are fine as I now
> recall I did the rebase as this patch was original posted before the rework
> of transport as modules were merged. Please confirm if you are happy with the
> rebase as you see in -next. I also had to rebase it on recent fixes that
> Justin added as there were trivial conflicts.
> 
> Another thing I wanted to check is if [1] series has any impact on this.
> IIUC no, but it would be good to give a go in terms of testing just in case
> that as well lands in -next.
> 
> --
> Regards,
> Sudeep
> 
> [1] https://lore.kernel.org/all/20241010123627.695191-1-jvetter@kalrayinc.com

-- 
Regards,
Sudeep

