Return-Path: <linux-kernel+bounces-220833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68C90E7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60921F22394
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732E86636;
	Wed, 19 Jun 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="bLKbaH/p"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6D80C04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791813; cv=none; b=s/O37CcOLkTjwqwNTV9uR1NpTI5stB+VO7n6Y9mnHRh9/87k0axpUPI8R2tyw5X+ofGULfrBz3bxPjBAMBCCwZtFd9QTWsufFts8kS/Fdea3GuEcTUjHmpD6Z/F2I9xyof/l/8BVRHeswnK95nf/1ERpr7eOt8QD2NAPnov3JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791813; c=relaxed/simple;
	bh=squliK7jr0NC6xXWsIbFQ48EcsRgBrMr7MO6MWuF8wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3x4jeBD9MppGcCmwLQStYBWI2Ba5Rmgi1iqFYN+RZiSwgexNGd3UVGPGk8O7W81JMnHPzP1Jk6JvHL47qK8KvQ1jMbcS2R8JKLLH4yXrltLLGafLuXXxVtYKC0iylkpS1UETbp1Up8dUhDv8vfglof4He4MkfCAgoJCT4oa+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=bLKbaH/p; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1718791810; x=1750327810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SwEPVkX3dmPP3UFXdzAhYNE6buV92cORmitwcIWuV0I=;
  b=bLKbaH/p3qMfjZUq9aD1JImYvRGHpJ1uQcnLIhtJh3JFiWoutiITeBqo
   1TPCvUjz1P4G4M4P/ZHaCuXF5tsOsyOOMnydCFmy6eRuTliET3RXReRts
   v8JirbUCN5ps6hyHu2hN0+Wj+lonaQdYHP9/ATxmvn9Rb7P2QxrUagyaW
   y7lrCN+Uc2Fql0YvVopqbcjvF9conU+cFwxzys9YVF8TBjWQaYy2CHA/y
   3ZB1IRBWZAFD4gv+sidUtGYdDxETIKU4bl13TrOC51ZsNncQy+fonMH0g
   WBEv2RhvVSNJCtt2/v4yttiqDg3BCCxMOnpolK70lEs5LBOo+liAJ5pxx
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:00:00 +0900
X-IronPort-AV: E=Sophos;i="6.08,250,1712588400"; 
   d="scan'208";a="425625442"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 19 Jun 2024 19:00:00 +0900
Date: Wed, 19 Jun 2024 10:00:00 +0000
From: Khasnis Soumya <soumya.khasnis@sony.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, gregkh@linuxfoundation.org
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, soumya.khasnis@sony.com,
	srinavasa.nagaraju@sony.com, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v5] driver core: Add timeout for device shutdown
Message-ID: <20240619100000.GA10362@sony.com>
References: <20240613083226.GA8191@sony.com>
 <2024061326-moonlit-protozoan-61f8@gregkh>
 <ecf55d97-363d-4731-bcfa-81cb4e58f2c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecf55d97-363d-4731-bcfa-81cb4e58f2c7@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 13, 2024 at 01:51:57PM +0200, Daniel Lezcano wrote:
> On 13/06/2024 10:43, Greg KH wrote:
> > On Thu, Jun 13, 2024 at 08:32:26AM +0000, Soumya Khasnis wrote:
> >> The device shutdown callbacks invoked during shutdown/reboot
> >> are prone to errors depending on the device state or mishandling
> >> by one or more driver. In order to prevent a device hang in such
> >> scenarios, we bail out after a timeout while dumping a meaningful
> >> call trace of the shutdown callback to kernel logs, which blocks
> >> the shutdown or reboot process.
> > 
> > Again, this is not a "device shutdown" timeout, it is a "the whole
> > system has not shutdown this fast" timeout.
> > 
> > And in looking at my system, it doesn't shutdown in 10 seconds as it is
> > madly flushing a ton of stuff out to the disks, and they are slow
> > beasts.  So your 10 second default would cause me data loss on my
> > workstation, not good!
> 
> Thanks for pointing this out. It is exactly what I was worried about ...
Thank you for comments Daniel and Greg, let me explain.

Typically reboot/shutdown sequence involves following steps in User land before kernel restart/shutdown sequence is entered.

1.	Terminate all services (except shutdown critical tasks)
2.	Sync File systems
3.	Unmount File systems
4.	Trigger kernel reboot(LINUX_REBOOT_CMD_RESTART/LINUX_REBOOT_CMD_POWER_OFF) system call

A userspace watchdog can be setup for above as exists on Android system.
This needs large timeout value because it involves syncing data to disks.  

Below is the kernel restart sequence after control moves to kernel in step 4).
The issue we intend to address here is that the device driver shutdown callbacks may hang
due to unresponsive device or a broken driver.

|-kernel_restart()
              |- kernel_restart_prepare()
                     |- device_shutdown() // Iterates over the device hierarchy and invokes the shutdown callbacks (class/bus/driver->shutdown)
              |- syscore_shutdown()
              |- machine_restart()

I still believe a 10 sec timeout as default is reasonable for the device_shutdown().
Not all drivers necessarily implement a shutdown callback and the timeout can be configured for large systems as needed.


> 
> [ ... ]
> 
> > Isn't this just a bug in your drivers?  Why not fix them?  Or if you
> > really have to have 10 seconds to shut down, use a watchdog timer that
> > you trigger from userspace and stop petting once you want to shut down.
> > Then, if it expires it will reset the machine, all of your policy
> > decisions would have been done in userspace, no need to get the kernel
> > involved at all.
> 
> +1
> 
> 
> -- 
> <https://urldefense.com/v3/__http://www.linaro.org/__;!!JmoZiZGBv3RvKRSx!_c6dCsrFBbO_ivlpLdqDvkFPd2bIFgHN48Xbjt4dqXVv5_QYeLwNMJOuy_jh5vBfqDUbNuCQ23qnLmHmRRCvtllhT_Uq$ [linaro[.]org]> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <https://urldefense.com/v3/__http://www.facebook.com/pages/Linaro__;!!JmoZiZGBv3RvKRSx!_c6dCsrFBbO_ivlpLdqDvkFPd2bIFgHN48Xbjt4dqXVv5_QYeLwNMJOuy_jh5vBfqDUbNuCQ23qnLmHmRRCvtqiO2qBL$ [facebook[.]com]> Facebook |
> <https://urldefense.com/v3/__http://twitter.com/*!/linaroorg__;Iw!!JmoZiZGBv3RvKRSx!_c6dCsrFBbO_ivlpLdqDvkFPd2bIFgHN48Xbjt4dqXVv5_QYeLwNMJOuy_jh5vBfqDUbNuCQ23qnLmHmRRCvtrJS5bNz$ [twitter[.]com]> Twitter |
> <https://urldefense.com/v3/__http://www.linaro.org/linaro-blog/__;!!JmoZiZGBv3RvKRSx!_c6dCsrFBbO_ivlpLdqDvkFPd2bIFgHN48Xbjt4dqXVv5_QYeLwNMJOuy_jh5vBfqDUbNuCQ23qnLmHmRRCvthplPsVl$ [linaro[.]org]> Blog
> 

