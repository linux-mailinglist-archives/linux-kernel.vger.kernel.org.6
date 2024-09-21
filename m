Return-Path: <linux-kernel+bounces-334796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2697DC44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4679E1F21F06
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81646153800;
	Sat, 21 Sep 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iT/S95/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4DF9DF;
	Sat, 21 Sep 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909311; cv=none; b=B/CchoAdDWu2s5iCaSUVZsHsD5/oxxzgVGB1zwoZGT0oUtQ9tfHJMf8A7tPWWBZY8CKZF373imE6mTu9ZTs463l81/KSGSaVQPuhw6YErsS+AtBPE/ThkqyUxNe0vswtjRBVi9WLF6/GoFSz5ZB2XU6tZBIDwJHZ8WNcs9Ml31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909311; c=relaxed/simple;
	bh=vO+JEDyCHltUmTg3ZcIN9R8Ev/kEgA7VymCPCG8zfws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRE3B4WUAwi0OCbyFLnJGfIG7uh8b3JZK6MARnXsLmIqpvABfX1mNomSGGgouOrSaCQT+mlp9f0mR3Gk7T2sbIH6gko20DlntALPwPmW/XPaJmm8/r/q7kzamQjXJ0TTlDv/GaG31LB91w60a3xbbp/YAHj6jyDBI+gcEsaRsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iT/S95/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE31C4CEC2;
	Sat, 21 Sep 2024 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726909310;
	bh=vO+JEDyCHltUmTg3ZcIN9R8Ev/kEgA7VymCPCG8zfws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT/S95/VYa9INjreD5sDnOvp3wyw5N+rE9f4Q4UP6rmCiKj+0g6b2O3Jj2a/4fow2
	 oZOP2befp97nhlMOsmjsK/QTxCSa1ID1xblVg9lcu3YN9yaNgHDmtscAudJ+hLVXkG
	 9S0APmw7H231y2Tsz+G7RIlVpkhqO0f/POfhb9bc=
Date: Sat, 21 Sep 2024 11:01:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, linux@roeck-us.net, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v4 0/9] misc: Add AMD side band interface(SBI)
 functionality
Message-ID: <2024092116-dental-chamber-e978@gregkh>
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <9b0cc2c4-44d3-3038-54b3-d4793b879820@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0cc2c4-44d3-3038-54b3-d4793b879820@amd.com>

On Fri, Sep 20, 2024 at 12:15:37PM +0530, Gupta, Akshay wrote:
> 
> On 9/12/2024 12:38 PM, Akshay Gupta wrote:
> > AMD's Advanced Platform Management Link (APML) interface provides system
> > management functionality accessed by the baseboard management controller (BMC).
> > sbrmi driver under hwmon subsystem, which is probed as an i2c driver and
> > reports power using APML specified protocol.
> > However, APML interface defines few other protocols to support
> > full system management functionality out-of-band.
> > Out-of-band management is term used for BMC talking to system management unit
> > (IP in the processor). AMD's documentation called this link as side band interface.
> > 
> > This patchset is an attempt to add all APML core functionality in one place
> > and provide hwmon and user space interface
> > 1. [Patch 1] Move the i2c client probe, hwmon sensors and sbrmi core functionality
> >     from drivers/hwmon to drivers/misc/
> > 2. [Patch 2] Convert i2c to regmap which provides multiple benefits
> >     over direct smbus APIs.
> >      a. i2c/i3c support and
> >      b. 1 byte/2 byte RMI register size addressing
> > 3. [Patch 3] Optimize wait condition with regmap API regmap_read_poll_timeout as per
> >     suggestion from Arnd
> > 4. [Patch 4, 5] Register a misc device which provides
> >      a. An ioctl interface through node /dev/sbrmiX
> >      b. Register sets is common across APML protocols. IOCTL is providing
> >         synchronization among protocols as transactions may create
> >         race condition.
> > 5. [Subsequent patches 6, 7 and 8] add support for AMD custom protocols
> >      a. CPUID
> >      b. MCAMSR
> >      c. Register xfer
> > 6. [Patch 9] AMD side band description document
> > 
> > Open-sourced and widely used https://github.com/amd/esmi_oob_library
> > will continue to provide user-space programmable API.
> > 
> > Akshay Gupta (9):
> >    hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
> >    misc: amd-sbi: Use regmap subsystem
> >    misc: amd-sbi: Optimize the wait condition for mailbox command
> >      completion
> >    misc: amd-sbi: Add support for AMD_SBI IOCTL
> >    misc: amd-sbi: Add support for mailbox error codes
> >    misc: amd-sbi: Add support for CPUID protocol
> >    misc: amd-sbi: Add support for MCA register protocol
> >    misc: amd-sbi: Add supoort for register xfer
> >    misc: amd-sbi: Add document for AMD SB IOCTL description
> 
> Hi Greg, Arnd,
> 
> You have previously reviewed v3 of patch set and I have addressed the review
> comments in v4.
> 
> Can you please take review v4 patch set?

Please wait until after the merge window is over (i.e. -rc1 is out) as
we can't do anything until then as you know.  Also remember that most of
us are traveling all of this week (and some of us next week) for
conferences, and will get to the backlog when we return.

To help us out, please go through the lists and review other submissions
for these subsystems so that your changes move to the top of unreviewed
ones.

thanks,

greg k-h

