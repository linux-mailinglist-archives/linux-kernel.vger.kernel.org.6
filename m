Return-Path: <linux-kernel+bounces-557520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB75A5DA52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93EE171918
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D123C8B3;
	Wed, 12 Mar 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1O5eBbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69221D59F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774742; cv=none; b=cvbJ2RydEF/zcUJYkqEzLqaHWvBedmRTp4wUxhrCsA+yjWxnd1L/EKAIhg5sX8JaXnZDpvFg+VNfUlhUQ+Z9J5ab+HQFPVNTq9Y4fM4MMD943U5RlP5B5txQ5T5EYwbhGniZaDjxr0BDbgWA6COtSxdaIohaJsoG4Lwy6xZdM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774742; c=relaxed/simple;
	bh=I/meoAPstTkIHKdRwloxNDfcOzIK+pFIloRdc4WO7sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp8zlgOeJphReBWnLucTJhDS+JMyPlcs2V4+PQ0MbZ6oPVF8BcLFGYR9TfTMC4YB/EwwPHGr4nfl0uxGzxPPsDqcKvJ36+4Q/AjoBY/eCRyi8VStDiqNBl5XLGJ/tYDELEF1X7iSWeShPNMBPEC3w+lWVNitEmqS2jlzn+DeQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1O5eBbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44C2C4CEE3;
	Wed, 12 Mar 2025 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741774742;
	bh=I/meoAPstTkIHKdRwloxNDfcOzIK+pFIloRdc4WO7sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1O5eBbcrMtnFWQ7cjgryCAyW8hMY5UavUZGc4yAeo7z5LhT9EasqsXq2/BYCf863
	 cTc6Pjdam3lAWwIgpkaN06nKlBPV5FOeyFLJCNTBpOpHNBviFJ1/tuA+gEx+AvkEg3
	 LeCeimEkr8ejJQ4QBrofmhuqkULYtkE6TDF9BZgE=
Date: Wed, 12 Mar 2025 11:18:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, derek.kiernan@amd.com, dragan.cvetic@amd.com,
	arnd@arndb.de, praveen.jain@amd.com, harpreet.anand@amd.com,
	nikhil.agarwal@amd.com, srivatsa@csail.mit.edu, code@tyhicks.com,
	ptsm@linux.microsoft.com
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Message-ID: <2025031256-accurate-tactics-1ff7@gregkh>
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095421.1839220-1-nipun.gupta@amd.com>

On Wed, Mar 12, 2025 at 03:24:20PM +0530, Nipun Gupta wrote:
> Silex MultiPK device provides a char device interface to interact
> with Silex device for offloading asymmetric crypto operations.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Silex MultiPK device is a PKI offload device, which has multiple PK engines to
> perform asymmetric crypto operations like ECDSA, RSA, Point Multiplication etc.
> 
> Following provides the brief overview of the device interface with the software:
> 
>  +------------------+
>  |    Software      |
>  +------------------+
>      |          |
>      |          v
>      |     +-----------------------------------------------------------+
>      |     |                     RAM                                   |
>      |     |  +----------------------------+   +---------------------+ |
>      |     |  |           RQ pages         |   |       CQ pages      | |
>      |     |  | +------------------------+ |   | +-----------------+ | |
>      |     |  | |   START (cmd)          | |   | | req_id | status | | |
>      |     |  | |   TFRI (addr, sz)---+  | |   | | req_id | status | | |
>      |     |  | | +-TFRO (addr, sz)   |  | |   | | ...             | | |
>      |     |  | | | NTFY (req_id)     |  | |   | +-----------------+ | |
>      |     |  | +-|-------------------|--+ |   |                     | |
>      |     |  |   |                   v    |   +---------------------+ |
>      |     |  |   |         +-----------+  |                           |
>      |     |  |   |         | input     |  |                           |
>      |     |  |   |         | data      |  |                           |
>      |     |  |   v         +-----------+  |                           |
>      |     |  |  +----------------+        |                           |
>      |     |  |  |  output data   |        |                           |
>      |     |  |  +----------------+        |                           |
>      |     |  +----------------------------+                           |
>      |     |                                                           |
>      |     +-----------------------------------------------------------+
>      |
>      |
>  +---|----------------------------------------------------+
>  |   v                Silex MultiPK device                |
>  |  +-------------------+     +------------------------+  |
>  |  | New request FIFO  | --> |       PK engines       |  |
>  |  +-------------------+     +------------------------+  |
>  +--------------------------------------------------------+
> 
> To perform a crypto operation, the software writes a sequence of descriptors,
> into the RQ memory. This includes input data and designated location for the
> output data. After preparing the request, request offset (from the RQ memory
> region) is written into the NEW_REQUEST register. Request is then stored in a
> common hardware FIFO shared among all RQs. When a PK engine becomes available,
> device pops the request from the FIFO and fetches the descriptors. It DMAs the
> input data from RQ memory and executes the necessary computations. After
> computation is complete, the device writes output data back to RAM via DMA.
> Device then writes a new entry in CQ ring buffer in RAM, indicating completion
> of the request. Device also generates an interrupt for notifying completion to
> the software.
> 
> As Crypto AF_ALG does not support offloading asymmetric operations from 
> user-space (which was attempted to be added earlier in Linux at:
> https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/),
> RQ memory is provided to the user-space via mmap, so that application can
> directly write to the descriptors.
> 
> P.S. Most of the above text is also added as part of silex driver file.

All of that should be in the changelog text, don't put it down here
where it will never be seen again.

> +static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{

Where is the Documentation/ABI/ entries for your new sysfs files?

> +	int v, hwv, cnt, maxtotalreqs, rqmaxpending, mults;
> +	struct multipk_dev *mpkdev = dev_get_drvdata(dev);
> +
> +	v = (int)sx_rdreg(mpkdev->regs, REG_SEMVER);
> +	hwv = (int)sx_rdreg(mpkdev->regs, REG_HW_VERSION);
> +	cnt = (int)sx_rdreg(mpkdev->regs, REQ_CFG_REQ_QUEUES_CNT);
> +	maxtotalreqs = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_PENDING_REQ);
> +	rqmaxpending = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_REQ_QUEUE_ENTRIES);
> +	mults = (int)sx_rdreg(mpkdev->regs, REQ_CFG_PK_INST);
> +
> +	return sprintf(buf,
> +		"Hardware interface version: %d.%d.%d\n"
> +		"Hardware implementation version: %d.%d.%d\n"
> +		"Count request queues: %d\n"
> +		"Total max pending requests: %d\n"
> +		"Max pending requests per request queue: %d\n"
> +		"Pkcores 64 multipliers: %d\n"
> +		"Pkcores 256 multipliers: %d\n",
> +		MPK_SEMVER_MAJOR(v), MPK_SEMVER_MINOR(v), MPK_SEMVER_PATCH(v),
> +		MPK_HWVER_MAJOR(hwv), MPK_HWVER_MINOR(hwv), MPK_HWVER_SVN(hwv),
> +		cnt, maxtotalreqs, rqmaxpending,
> +		mults >> 16, mults & 0xFFFF);

No!

sysfs is "one value per file", which this is not at all.

Also, did you run checkpatch.pl?  It should have told you that you
should not be calling sprintf() here either.

> +static int __init multipk_init(void)
> +{
> +	dev_t devt;
> +	int ret;
> +
> +	multipk_class = class_create("multipk");

Why do you need a whole new class?  Why not just use a misc device?

> +	if (IS_ERR(multipk_class)) {
> +		ret = PTR_ERR(multipk_class);
> +		pr_err("can't register class\n");
> +		goto err;
> +	}
> +	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");

Again, why not a dynamic misc device per device in the system?

No need to make this harder than it is.

But again, this really should use the in-kernel apis we already have for
this type of hardware, don't make a custom user/kernel api at all.
That's not going to scale or be easy to maintain for any amount of time.

thanks,

greg k-h

