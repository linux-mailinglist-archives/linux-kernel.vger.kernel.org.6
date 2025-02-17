Return-Path: <linux-kernel+bounces-517800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4BA385EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25010174EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C321D5A1;
	Mon, 17 Feb 2025 14:14:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6021D58B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801680; cv=none; b=T4P+gPRfDvPNqCNfVedFR+6xTZnYrYZ+FqRBcrUvNYZH/heF2ex8sd4ImG2wiTj0lhpxOF4RRXo0JgJb1oy56sY7jG+2FYj0CIWjGL3sZbcNDPEyjTV2sIiB9wXODhpI5aXxeS20KFa/MbqXgEiHQuWih3LDHcOLB4cuQcNIovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801680; c=relaxed/simple;
	bh=AmfXjxcH/exvrFWzJbuLflIkWmltAbM7ZvYOz2uUj/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8RM++Vel2AxCHYwCZ+nYxHYr86wl7r62AukF2Pqt3GXkDro7EyV9jvwCPm5NNKqGVg6EK/12gHEFtlM+4eSuGP5Cu62F6ZNXwGeKzgZiewNI4d9lqUypvwmOrJIoLNtpBwkPuLiMKy2pt4Mi1bclmJkqxG94nFsE21O22LZMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C82152B;
	Mon, 17 Feb 2025 06:14:57 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D37D3F6A8;
	Mon, 17 Feb 2025 06:14:37 -0800 (PST)
Date: Mon, 17 Feb 2025 14:14:34 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] firmware: arm_ffa: Framework notification
 support + other updates and fixes
Message-ID: <Z7NESuOgFZBSxgR-@bogus>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
 <20250214113628.djl7uq6kpwut7yax@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214113628.djl7uq6kpwut7yax@vireshk-i7>

On Fri, Feb 14, 2025 at 05:06:28PM +0530, Viresh Kumar wrote:
> On 31-01-25, 11:24, Sudeep Holla wrote:
> > This bundle of changes mainly have FF-A framework notification support
> > along with other minor updates and fixes.
> > 
> > It adds support to allow multiple UUIDs per partition to register
> > individual SRI callback, to handle Rx buffer full framework notification
> > in particular and general framework/interface to extend in the future.
> > 
> > It also adds support for passing UUID in FFA_MSG_SEND2 which improves
> > the multiple UUID/services per partition support in the driver and
> > an helper to check if a partition can receive REQUEST2 messages or not.
> > 
> > It also improves cleaning up the partitions by adding unregistration of
> > the devices as well as handles the presence of host partition in the
> > partition info.
> > 
> > It also contain fixes big-endian support in couple of functions:
> > __ffa_partition_info_regs_get() and __ffa_partition_info_get().
> > Big-endian support is still not complete. Only these changes can be
> > verified at the moment without any additional application or testing
> > support changes.
> > 
> > Regarding the FF-A versions, it upgrades the driver version to v1.2
> > and rejects any higher major version than the driver version as
> > incompatible.
> > 
> > It also fixes the mis-alignment with sync_send_receive{,2} function
> > prototypes.
> > 
> > It replaces UUID buffer to standard UUID format in the ffa_partition_info
> > structure and fixes a typo in some FF-A bus macros.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

-- 
Regards,
Sudeep

