Return-Path: <linux-kernel+bounces-179764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066B8C64FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4ABB23A11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8145E093;
	Wed, 15 May 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZngf6Bt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF541F60A;
	Wed, 15 May 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769143; cv=none; b=mbixqtt916gX7ZtHod4IJ+yyPR5l2DQCiU/+fMvMF0B6Tu6GUN7GqYz5HuGDyfKH83oZ1Qe5WTk72bbfSEf2iZnqy5EgDyj5Zce0Ekd8vzbI5CL0Nz0wxFtDNhH0ap66xvundxw5ag+eqz7uqFoQe5bmeAWT6/iXj+l87CcK1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769143; c=relaxed/simple;
	bh=CvksV8oPyRrAbbl3lnhzPKbTj7UWISTUgDHLj2QHslY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s80GZkzN0AEuj5C70Lc4a2bniUF9dPFjJW2aNxR9uxKmzU8FUXPdbKQxtd/oHLb3RnAmJ1+zmRvQ7L/Ayh4gB/DwTIBBYysvVcx/32Pr9xvKyciX+rD5ZkD5LynLFTqTkwip6nHCE1NnxuSOqaOqSrke/SESgN2mgtOVsOEkDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZngf6Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB446C116B1;
	Wed, 15 May 2024 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715769142;
	bh=CvksV8oPyRrAbbl3lnhzPKbTj7UWISTUgDHLj2QHslY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZngf6BtwfOVumLRNhzj4zDdf6JP7oaToc1ml66LC7M+EqXdFbFLRwI0JDfCf44YH
	 rS42jxzI9mAQy0V1Yq++D/kW6pN5iAQCQACoj3kNqssLQPRZ5EqbUVCW9Vz/Cxet1p
	 5BavErDbxMyeeTzQBirGPAzigEOVj3YrEseKAbr6+efZXXTJw+Z98/n8UEUc1xWT7Y
	 4a9tPFOSjfZpQyVk8wFy8Ou575nBCw1IZ6I9jIXotCWyYTWDRssqbFU3t0ybDIfLlF
	 THIPxjUiKNTzcYQpM6R90RBO35KDAAyajTfU51c06yMOCDNaxIE5mMNHc7gZGQd5nv
	 N4uWVSk3yVInw==
Date: Wed, 15 May 2024 11:32:17 +0100
From: Lee Jones <lee@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Chatradhi, Naveen Krishna" <naveenkrishna.chatradhi@amd.com>,
	Naveen Krishna Chatradhi <nchatrad@amd.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Akshay Gupta <Akshay.Gupta@amd.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] sbrmi: Add support for APML protocols
Message-ID: <20240515103217.GA6035@google.com>
References: <20240502220554.2768611-1-nchatrad@amd.com>
 <20240502220554.2768611-2-nchatrad@amd.com>
 <dd4ef0b6-8272-40b6-9a50-edbeec14d5e4@roeck-us.net>
 <8cf0d519-ae6c-4ed0-899e-899f67479052@amd.com>
 <488e8eed-e0f0-4055-b43c-5422b6302632@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <488e8eed-e0f0-4055-b43c-5422b6302632@roeck-us.net>

On Tue, 14 May 2024, Guenter Roeck wrote:

> On 5/14/24 12:15, Chatradhi, Naveen Krishna wrote:
> > + @Misc and @MFD maintainers in CC
> > 
> > Hi
> > 
> > On 5/3/2024 3:56 AM, Guenter Roeck wrote:
> > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > 
> > > 
> > > On 5/2/24 15:05, Naveen Krishna Chatradhi wrote:
> > > > From: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> > > > 
> > > > The present sbrmi module only support reporting power. However, AMD data
> > > > center processors support various system management functionality
> > > > Out-of-band over Advanced Platform Management Link APML.
> > > > 
> > > > Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
> > > > interface for the user space to invoke the following protocols.
> > > >    - Mailbox read/write (already defined in sbrmi_mailbox_xfer())
> > > >    - CPUID read
> > > >    - MCAMSR read
> > > > 
> > > 
> > > This is not hardware monitoring functionality and would have to reside
> > > elsewhere, outside the hwmon subsystem.
> > 
> > I thought as much, please provide your opinion on the following approach.
> > 
> > Background: Present sbrmi under hwmon subsystem is probed as an i2c driver and reports power.
> > 
> > However, APML interface defines few other protocols to support OOB system management functionality.
> > 
> > As adding the core functionality of the APML interface in drivers/hwmon/sbrmi is not the correct approach.
> > 
> > We would like do the following
> > 
> > 1. Move the i2c client probe, misc device registration and rmi_mailbox_xfer() function to a drivers/misc.
> > 
> > 2. Add an MFD device with a cell, which probes the hwmon/sbrmi and continues to report power using the symbols exported by the misc/sbrmi.
> > 
> 
> afaik mfd API function must not be used outside drivers/mfd. The mfd maintainer
> is (or at least used to be) pretty strict on that. The core code of a
> multi-function device might better be implemented in drivers/mfd, with
> drivers in drivers/misc (for the misc device) and drivers/hwmon/ (for
> hwmon functionality). The misc and hwmon drivers could then communicate
> with the core using regmap.

Yes, please only use the MFD API from drivers/mfd.

There are 'offenders' that slipped by me, but in general if you need to
create an MFD then it should be located in the MFD subsystem.

> drivers/mailbox/ supports mailbox style communication. I don't know if that
> would apply to the mailbox functionality implemented here.

-- 
Lee Jones [李琼斯]

