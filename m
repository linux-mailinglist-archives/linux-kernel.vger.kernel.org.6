Return-Path: <linux-kernel+bounces-229213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FF916CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213471F29972
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E753716F8E7;
	Tue, 25 Jun 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgK7hvg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B41CABB;
	Tue, 25 Jun 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329003; cv=none; b=pNXgfQNSHDPr0aB+FKUDMUvITkVukY/g69SNPc15Da15pNw+vIxodXf3sp6bUXIjJgu+HwSJnVsYeYow+Gq1xKHMPSESYV+/5qofgH4DohQetl7aRzJTGV9X0L1LO7eRtaKk8uhIG4godOy9rll5YuDYS35Lfm2xEYySN/yYNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329003; c=relaxed/simple;
	bh=FiQ21QoQy0JLE0Wlrm7V0SyFrEIXyUyNZHRIlRzYU9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZzjUthVIR3MsFt4FJVKzcX9piAzK1fLVh5Bo3vLe2vNA8+YvYNOdbfQpRw1Bvd4lgS32MMqDj9+k/Z2qgzIEcevM2mYOkDUHrDo7xvmc7hISim0LVD0cQzP//Qoog8Ldh3BmolxDZbASqXGsMCYeQVYhtcObC/cnAuOZquYlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qgK7hvg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1159AC32781;
	Tue, 25 Jun 2024 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719329002;
	bh=FiQ21QoQy0JLE0Wlrm7V0SyFrEIXyUyNZHRIlRzYU9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgK7hvg4qzs5fRCAwgMEaxdPAU5HU9QU9y7n1ChN0o94m0OhreWjVBuagQI46KCIE
	 5TkqY2kicJfHCungDh2K7qdKfSvHUD4WyZZjkEsVr4hEI6OGiaBfg0sgRGXde2UpR1
	 iah9JTKi7ZbBDDENlh0me5PN7PbC9a/7AUb6Ru8M=
Date: Tue, 25 Jun 2024 17:23:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teddy Engel <engel.teddy@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, devel@driverdev.osuosl.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Fix conflicting types error with
 net_device.
Message-ID: <2024062553-postbox-gangly-e155@gregkh>
References: <20240625151918.10839-1-engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625151918.10839-1-engel.teddy@gmail.com>

On Tue, Jun 25, 2024 at 04:19:18PM +0100, Teddy Engel wrote:
> Add a pre-declaration of struct net_device so the compiler is able to
> use rtl_pci.h / rtl_cam.h.
> 
> Fix for commit: 7dff0b27d9c842f88149bf611cbc0b59be1dcd3c:
> [34/59] staging: rtl89192e: Remove unnecessary pre-declaration of struct
> net_device.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406250858.L8rJMHQm-lkp@intel.com/
> ---
> v2: Add commit id that's being fixed.

You do that with a "Fixes:" tag, not the paragraph you wrote above :)

The documentation should explain how to do it, right?

thanks,

greg k-h

