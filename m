Return-Path: <linux-kernel+bounces-391529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E79B8848
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E89A1C21D77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974F55896;
	Fri,  1 Nov 2024 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+dPbgJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1A5336D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424056; cv=none; b=O/pME4AMkajlOQOwlD4zBn2ivCnSorI9IUqnFFc3qqHZTiHD/7BjS6ZIXXCaa0O0dUUFB+10D9cb4jRbcz1B+1oYSBP9eu+HvK+IORmHz96oewRH+GDnBDsarNaFVJdlsfZMpHsnKF/lsj7y0xOsIfRehxtEtf+wWg1nZRqmXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424056; c=relaxed/simple;
	bh=3TKrIwHvdKGPRJkt7emDt76d5OXbJBAYsnCytQ7cHuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUqb5YA3qqcKal1NdLqc67OdOfJaUYnEfF95dAb3HDNCSxCpCUWfEtYUcs8Ey1lTWthM/ymzmsjowJ0LEKuIVBbDMxwDlWvenmNkOeA2vvM2lo8HvzZU6hv3R1yuRpxO/1RVoc5kp66OQViABqLP+6pSRyECXpEyAeAZDTZDxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+dPbgJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA731C4CEC3;
	Fri,  1 Nov 2024 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424056;
	bh=3TKrIwHvdKGPRJkt7emDt76d5OXbJBAYsnCytQ7cHuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+dPbgJQ514JduGfxUI0Ij7ca14m/Z9BgygdjgqoeTvL8s9M78PoCGn+NQJAyGv7T
	 ILzXbFEOJ5V1dfDNi0/pQ9cuFYjGmtdU6OUHvCWThIn3SLZ/Mqf6KlZoiLHnIFM4xD
	 72Gppqv2kkNd9lW5SJHTZyL/nd32I7ld0+CdQPn4=
Date: Fri, 1 Nov 2024 02:20:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] sysfs: constify struct bin_attribute (Part 1)
Message-ID: <2024110100-thieving-numerate-e268@gregkh>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>

On Thu, Oct 31, 2024 at 02:43:49AM +0000, Thomas Weiﬂschuh wrote:
> struct bin_attribute contains a bunch of pointer members, which when
> overwritten by accident or malice can lead to system instability and
> security problems.
> Moving the definitions of struct bin_attribute to read-only memory
> makes these modifications impossible.
> The same change has been performed for many other structures in the
> past. (struct class, struct ctl_table...)
> 
> For the structure definitions throughout the core to be moved to
> read-only memory the following steps are necessary.
> 
> 1) Change all callbacks invoked from the sysfs core to only pass const
>    pointers
> 2) Adapt the sysfs core to only work in terms of const pointers
> 3) Adapt the sysfs core APIs to allow const pointers
> 4) Change all structure definitions through the core to const
> 
> This series provides the foundation for step 1) above.
> It converts some callbacks in a single step to const and provides a
> foundation for those callbacks where a single step is not possible.
> 
> This series is marked as RFC and only sent to the sysfs maintainers to
> get some feedback on the general aproach.
> The same techniques employed by this series can later be reused for the
> same change for 'struct attribute'.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

At a quick glance, this is great!  I'll review it "better" next week
when my travel calms down, so if you want to resend this as a non-rfc
patch, and it looks sane, I'll be glad to queue it up.

thanks!

greg k-h

