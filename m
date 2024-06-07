Return-Path: <linux-kernel+bounces-205932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68635900250
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C0D289137
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32318FC63;
	Fri,  7 Jun 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lEBO4P1H"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF315DBB5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760280; cv=none; b=gXsf965GXI28ktc++Tl1YDPwBbsGLPt5kQChnCfb2MxNCUkvsPURr7wT3upn4QCf+PCTg4DFF3nPiyj3Nhy0AXZrjsSHUI4/5w9gXs416Au/MqbCl+7vNqreVglgSJ8gLHIIURMsub1X7H5d7VnYqu6t8+3kLsqHux8QbGages0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760280; c=relaxed/simple;
	bh=hXIlhq8MzBSHyQAmYQDOntn3dATf52PDTcEMHQK2e5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL/S7eievXFrc2X0kk5vw39QvYwbiK6mfbWkRsqa+ySwiE8w+E6clQrNFG4vY77HDSncLTRuMi1bgy0qZjoHicodlIylJ2uSpXh2IdcBIiq53TTADmBByOtr2qnbNIzjfcya00SCEAQmC9X7MoH1DpgU6uAhidXFtJvHrIGIH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lEBO4P1H; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1717760278; x=1749296278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U6UEO9PjMs+prpI6CUpXQz8E3lLO24m5cCQljKt9LZg=;
  b=lEBO4P1HJwxNRccqvzoB4lR6N9SfVHwSGRQDDlUUOHKrci3Cc/LYB8lT
   8iDmDojvys3w73pE9wRfnELObVg35VvAYaDlmLwbjJuLmT2Su/0bnAe8y
   w7As2PJPSQxtTpIV+yc/EwVpKrJjoK5H2MKbMrDtIRWXcDhqn0CAoi+uF
   cz7VTrfwguxULWySXVq1z7fmuKnoSW6Wf2JMPJ1Z1awVvPmHI9fk94b0t
   M1XQGiG0X6trYQ0vdsUcAQNRdycz0rSC1CtA/jqXjHKuM/Ulv6NUK3Knr
   d+ANMqkM/BNUkAYJ6rmNzT4uybEkhDiX3F5oyeS53BYvkLthIkUKRH68v
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:37:50 +0900
X-IronPort-AV: E=Sophos;i="6.08,220,1712588400"; 
   d="scan'208";a="396768495"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 07 Jun 2024 20:37:50 +0900
Date: Fri, 7 Jun 2024 11:37:50 +0000
From: Khasnis Soumya <soumya.khasnis@sony.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, soumya.khasnis@sony.com,
	srinavasa.nagaraju@sony.com, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v3] driver core: Add timeout for device shutdown
Message-ID: <20240607113750.GA30558@sony.com>
References: <20240606085003.GA118950@sony.com>
 <97c8ab14-f56f-4a25-b036-51679251adf3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97c8ab14-f56f-4a25-b036-51679251adf3@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jun 06, 2024 at 05:23:19PM +0200, Daniel Lezcano wrote:
> On 06/06/2024 10:50, Soumya Khasnis wrote:
> > The device shutdown callbacks invoked during shutdown/reboot
> > are prone to errors depending on the device state or mishandling
> > by one or more driver. In order to prevent a device hang in such
> > scenarios, we bail out after a timeout while dumping a meaningful
> > call trace of the shutdown callback to kernel logs, which blocks
> > the shutdown or reboot process.
> 
> Is that not somehow already achieved by the watchdog mechanism ?
The hard or software watchdog enabled by config_lockup_detector couldn’t
detect the cases when stalled on IO wait (wait_for_completion/io)

> 
> > Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> > Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> > ---
> > Changes in v3:
> >    -fix review comments
> >    -updated commit message
> > 
> >   drivers/base/Kconfig | 18 ++++++++++++++++++
> >   drivers/base/base.h  |  8 ++++++++
> >   drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 66 insertions(+)
> > 
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 2b8fd6bb7da0..342d3f87a404 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -243,3 +243,21 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
> >   	  work on.
> >   
> >   endmenu
> > +
> > +config DEVICE_SHUTDOWN_TIMEOUT
> > +	bool "device shutdown timeout"
> > +	default y
> > +	help
> > +	   Enable timeout for device shutdown. In case of device shutdown is
> > +	   broken or device is not responding, system shutdown or restart may hang.
> > +	   This timeout handles such situation and triggers emergency_restart or
> > +	   machine_power_off. Also dumps call trace of shutdown process.
> > +
> > +
> > +config DEVICE_SHUTDOWN_TIMEOUT_SEC
> > +	int "device shutdown timeout in seconds"
> > +	range 10 60
> > +	default 10
> 
> How do you know the shutdown time is between this range?
> 
> What about large systems ?
Agree it is difficult to set single timeout for all device.
This range I have based on consumer device where response time cannot be more.
But still as you mentioned we can not make this configuration by default "true/y"
with some fixed range. I will change patch  to set this configuration default to 
"false/n" as before, and will also remove range.

> 
> > +	depends on DEVICE_SHUTDOWN_TIMEOUT
> > +	help
> > +	  sets time for device shutdown timeout in seconds
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 0738ccad08b2..97eea57a8868 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -243,3 +243,11 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
> >   
> >   void software_node_notify(struct device *dev);
> >   void software_node_notify_remove(struct device *dev);
> > +
> > +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> > +struct device_shutdown_timeout {
> > +	struct timer_list timer;
> > +	struct task_struct *task;
> > +};
> > +#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
> > +#endif
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index b93f3c5716ae..dab455054a80 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -35,6 +35,12 @@
> >   #include "base.h"
> >   #include "physical_location.h"
> >   #include "power/power.h"
> > +#include <linux/sched/debug.h>
> > +#include <linux/reboot.h>
> > +
> > +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> > +struct device_shutdown_timeout devs_shutdown;
> > +#endif
> >   
> >   /* Device links support. */
> >   static LIST_HEAD(deferred_sync);
> > @@ -4799,6 +4805,38 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
> >   }
> >   EXPORT_SYMBOL_GPL(device_change_owner);
> >   
> > +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> > +static void device_shutdown_timeout_handler(struct timer_list *t)
> > +{
> > +	pr_emerg("**** device shutdown timeout ****\n");
> > +	show_stack(devs_shutdown.task, NULL, KERN_EMERG);
> > +	if (system_state == SYSTEM_RESTART)
> > +		emergency_restart();
> > +	else
> > +		machine_power_off();
> > +}
> 
> So if one device is misbehaving, all the others shutdown callbacks are 
> skipped with emergency halt/reboot ? That is prone to break the system, no?
Skipping other callback may not cause system break, but emergency shutdown or
reboot is better then leave system in hung state. That is the main functionality
of this patch.
> 
> > +static void device_shutdown_timer_set(void)
> > +{
> > +	devs_shutdown.task = current;
> > +	timer_setup(&devs_shutdown.timer, device_shutdown_timeout_handler, 0);
> > +	devs_shutdown.timer.expires = jiffies + SHUTDOWN_TIMEOUT * HZ;
> > +	add_timer(&devs_shutdown.timer);
> > +}
> > +
> > +static void device_shutdown_timer_clr(void)
> > +{
> > +	del_timer(&devs_shutdown.timer);
> > +}
> > +#else
> > +static inline void device_shutdown_timer_set(void)
> > +{
> > +}
> > +static inline void device_shutdown_timer_clr(void)
> > +{
> > +}
> > +#endif
> > +
> >   /**
> >    * device_shutdown - call ->shutdown() on each device to shutdown.
> >    */
> > @@ -4810,6 +4848,7 @@ void device_shutdown(void)
> >   	device_block_probing();
> >   
> >   	cpufreq_suspend();
> > +	device_shutdown_timer_set();
> >   
> >   	spin_lock(&devices_kset->list_lock);
> >   	/*
> > @@ -4869,6 +4908,7 @@ void device_shutdown(void)
> >   		spin_lock(&devices_kset->list_lock);
> >   	}
> >   	spin_unlock(&devices_kset->list_lock);
> > +	device_shutdown_timer_clr();
> >   }
> >   
> >   /*
> 
> -- 
> <https://urldefense.com/v3/__http://www.linaro.org/__;!!JmoZiZGBv3RvKRSx!6XWB4gl8L3rRMPtMmiqJdKcGhAMKhZ9UVvLyqOiGr3vHiQzlgwInwY3OVNNzXZsLONbeCLZZ-CY-APJdHGYO7DpNrCqk$ [linaro[.]org]> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <https://urldefense.com/v3/__http://www.facebook.com/pages/Linaro__;!!JmoZiZGBv3RvKRSx!6XWB4gl8L3rRMPtMmiqJdKcGhAMKhZ9UVvLyqOiGr3vHiQzlgwInwY3OVNNzXZsLONbeCLZZ-CY-APJdHGYO7AtMvPiK$ [facebook[.]com]> Facebook |
> <https://urldefense.com/v3/__http://twitter.com/*!/linaroorg__;Iw!!JmoZiZGBv3RvKRSx!6XWB4gl8L3rRMPtMmiqJdKcGhAMKhZ9UVvLyqOiGr3vHiQzlgwInwY3OVNNzXZsLONbeCLZZ-CY-APJdHGYO7Imo3W2M$ [twitter[.]com]> Twitter |
> <https://urldefense.com/v3/__http://www.linaro.org/linaro-blog/__;!!JmoZiZGBv3RvKRSx!6XWB4gl8L3rRMPtMmiqJdKcGhAMKhZ9UVvLyqOiGr3vHiQzlgwInwY3OVNNzXZsLONbeCLZZ-CY-APJdHGYO7DxWnKe3$ [linaro[.]org]> Blog
> 

