Return-Path: <linux-kernel+bounces-371712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9E9A3EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393862820A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897518CBF1;
	Fri, 18 Oct 2024 12:57:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F12F9DF;
	Fri, 18 Oct 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256238; cv=none; b=Si4lZZTmGUxpinX1NxbTdjYHnBrWQH64zKQHE4AHliRRvWCi72UNNXEQUeW5kyHiTcq5fkXeVPtqRTg+L1R0mY0g1OgwVaO6zHXLtwkTn+7DNNe3SPthIHJODrChzbtcoITwycqomX3yGlsuZe/oTu06vhbibNuzPrsz4yQf/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256238; c=relaxed/simple;
	bh=u8YJsDjnXx6waZcqswFEzrNIa9LHOweKyJMecaGgmz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyO/Ngmb4+ioNL/2sfBWp0k05ND7XPV+rRp245nYOTLgKGHmIHavz0+6VvGz4RpxxjNTRBffAI6hwSu+bxt+ex1eAHQbPk6gdvw92VqCYUx7qmygBCzaeAflhQOsBfXH5ev8rm0r06RoujO/S7Hl5dLB67M0oV/xeSu9GuL7/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4A5106F;
	Fri, 18 Oct 2024 05:57:44 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EBC63F7F5;
	Fri, 18 Oct 2024 05:57:12 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:57:09 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <ZxJbJa8Q3V02yf_z@bogus>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
 <20240827182450.3608307-3-florian.fainelli@broadcom.com>
 <20240903154000.GA2080277@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903154000.GA2080277@bogus>

On Tue, Sep 03, 2024 at 04:40:00PM +0100, Sudeep Holla wrote:
> On Tue, Aug 27, 2024 at 11:24:50AM -0700, Florian Fainelli wrote:
> > Some shared memory areas might only support a certain access width,
> > such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> > on ARM64 by making both 8-bit and 64-bit accesses to such memory.
> >
> > Update the shmem layer to support reading from and writing to such
> > shared memory area using the specified I/O width in the Device Tree. The
> > various transport layers making use of the shmem.c code are updated
> > accordingly to pass the I/O accessors that they store.
> >
> 
> This looks good to me now, much simpler. I will push this to -next soon,
> but it won't be for v6.12. I have already sent PR for that. I want this
> to be in -next for longer just to see if anyone has any comments and
> doesn't break any platform(which it shouldn't anyways).
> 
> Just hoping if anyone looks at it and have feedback once it is in -next.
> I will apply formally at v6.12-rc1 and report back if no one complains
> until then.
> 

Hi Florian,

Just thought I will check with you if the content is -next are fine as I now
recall I did the rebase as this patch was original posted before the rework
of transport as modules were merged. Please confirm if you are happy with the
rebase as you see in -next. I also had to rebase it on recent fixes that
Justin added as there were trivial conflicts.

Another thing I wanted to check is if [1] series has any impact on this.
IIUC no, but it would be good to give a go in terms of testing just in case
that as well lands in -next.

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20241010123627.695191-1-jvetter@kalrayinc.com

