Return-Path: <linux-kernel+bounces-241000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51B927588
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FC21C216FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA11AD9D2;
	Thu,  4 Jul 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcUAK6gr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FD14B078;
	Thu,  4 Jul 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094072; cv=none; b=e1UTfoGKrPBdXTzsrQTCMcw2GKkSFF/wtQHrnSyDBFraD5VjC6bo/7iJZMD9mGWhhqK+lb016lZjUnXMPf3rnboPPdoeFR3O4AjQTeihy9z51FIGWGz9FZEKt50BvhtXJddAMiO29kICRjRCa/KDf4EUadx3w7iTJeDkF08g110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094072; c=relaxed/simple;
	bh=3O8/t+3wfCMKK8plthSo7lGuK9QcXUx2GEAeeJGoSJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXPm/CHbhKf+OxeVryd1ZbtcZCpAVCveuupMOU+YCTRqUmgOnN0JBafMTeg53O1IjMZ82JyPcmxR8F6RnYFR9CUSu3AVdvDBS8QuiRd4t7RAcE3G5vltxyvyF3XA3Xt+KDDQuFAAFOmNIT3BuokcugsA6V/94ijjZslNEJWjjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcUAK6gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AFCC3277B;
	Thu,  4 Jul 2024 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720094072;
	bh=3O8/t+3wfCMKK8plthSo7lGuK9QcXUx2GEAeeJGoSJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcUAK6grU+gPn1yO4WXBy3BAn0achJW+RBqHDUjX6CXucSDot/7oGYRWD5NP1FwL+
	 GAOZRVyyB/F/Zn0SqR7ZALnUW1LV1peeIzuTWASRzTP4eTaPm1ULzcMeTn5r4YOcmT
	 m+aTE85Mf/cTezYEHy5LFW+2IEZHkB2syDtWE19c=
Date: Thu, 4 Jul 2024 13:54:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 6/6] misc: sbrmi: Add support for new revision
Message-ID: <2024070452-bunkbed-example-9dd3@gregkh>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-7-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111624.1583460-7-akshay.gupta@amd.com>

On Thu, Jul 04, 2024 at 11:16:24AM +0000, Akshay Gupta wrote:
> - RMI device supports v21 on Turin, which has increased register set.
>   Hence, requires 2byte for register addressing.
> 
> - Both Genoa and Turin processors are SP5 compatible, often CPUs are
>   interchanged on the base boards with BMC remaining the same.
>   Hence, we need to identify correct regmap configuration. A mechanism
>   was not defined to identify the RMI register address width.
> - The address width can only be determined if the socket is powered ON.
> - This patch also addresses CPUID and MCAMSR register read protocol,
>   the modification is due to the increase in register address size and
>   the modified thread input.
> 

When you have to list all of the different things you did in a single
change, that's a huge hint that it needs to be split up.

Remember, each patch can only do _one_ thing.

Would you want to review something that attempted to do all of this at
once?

thanks,

greg k-h

