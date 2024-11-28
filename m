Return-Path: <linux-kernel+bounces-424940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D842A9DBB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AC1608FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4B1BE87C;
	Thu, 28 Nov 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEB611r5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED48317993;
	Thu, 28 Nov 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812707; cv=none; b=oaK3TvJHoYdzEH2fDn8hdyiZFky5VrzeuKN5UKrFvKhJvBmDZLXyV/01jpWw4JQau40e3eZyL0cRDfab/YoH+cCxDMI7BQDlcXJH5IyHnIIo5CdpPyNEbqmmyzahjzw7O3qepWT3n6tzxS/Ziyv7alHLcE3vN/ZhwspSv3BfZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812707; c=relaxed/simple;
	bh=8FFXDfq4MyFfoAJt1YfCbBO3TnpDRK9YvJEgv6vwrUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMrVT7To75xBSv8ZBNh/m4sFwj0irr/24xtHfXfAgZKdNOBIdWyoF77XIRGPfYKi8pjhdXH61Yrk19ezk3ndQWD5FpIzu20wFvcF8fJ1Iw7e/uhZjZjA4EqcPUeSk9F+9C6yT+BN5IZsjO7Y1XKB8pp8Q1zbHY3ejkCLnxDScBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEB611r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E999C4CECE;
	Thu, 28 Nov 2024 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732812706;
	bh=8FFXDfq4MyFfoAJt1YfCbBO3TnpDRK9YvJEgv6vwrUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEB611r529uETQDgpNuokpGiBJdaZ4/oGAfUzJ/XYFpfThLEkXUQkeUeUABOS1/Lr
	 g7fEyaRlsddlgk3MUq7lYagdXV8sTQY8t+kfnwecGHkn6ybIDpWHDiqOWQkZm1FYe2
	 HG1mACpV2seJJ8MLjoEqQBrcgU9DUp898DaOFOUw=
Date: Thu, 28 Nov 2024 17:51:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-53054: cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
Message-ID: <2024112826-pond-battered-c61b@gregkh>
References: <gl75dywfjz5qrxsc6k47445n5a3abwyeq4gssntt4ftl7ev5jj@zz2jshiohpsr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gl75dywfjz5qrxsc6k47445n5a3abwyeq4gssntt4ftl7ev5jj@zz2jshiohpsr>

On Wed, Nov 27, 2024 at 06:37:57PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Sun, Sep 16, 2001 at 10:00:00PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This issue can be reproduced by the following pressuse test:
> > 1. A large number of cpuset cgroups are deleted.
> > 2. Set cpu on and off repeatly.
> > 3. Set watchdog_thresh repeatly.
> 
> The lockup is triggered in this very specific stress testing scenario.
> CPU offlining (write holding of cpu_hotplug_lock) is necessary to cause
> _this_ lockup. Both 2 and 3 are privileged operations (in a tight loop
> to hit the window).
> 
> I don't think this qualifies as vulnerability.

Thanks for the review, now revoked!

greg k-h

