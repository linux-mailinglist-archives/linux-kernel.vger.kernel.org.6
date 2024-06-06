Return-Path: <linux-kernel+bounces-203917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C688FE1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E54B21C99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBF13F459;
	Thu,  6 Jun 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Z8hd+uOZ"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE813C674
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664310; cv=none; b=DkNafW/KqR7Ef5fqYWRB8iK+9IZyQPdMkKVu5KFX3E3N+Fiuci21lVjzMBYp3NTwt8e/9YVsliHWX7US8fQecOSsSGIEeVFqR8e8sHn9y1epyHuYxwFpfrwoC84I9ae7O7yT9YPIYmoCgXcx6L1R2cavL40aGB+oGAjy+Uo34nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664310; c=relaxed/simple;
	bh=eOFXaEud5GYAPjxJmRNmgm08j2Nx2v0h+8hTKBzMh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obQMssaeijo2GkPsALkShSfRicm4BVqGSfmOu9sxnzX8qYRiIgEUIU+ENUxPF5+anFj+OskR+PezGjscmijvX0iqhomN0vwM1YXGYkdTIKDYcbE4wnGkFjbL8KpyYkMSIqa8H5hqIMqgX/tW7Ra/YQmNAc4xWh3vrEYHgS0alUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Z8hd+uOZ; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1717664308; x=1749200308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ni9uQ13h09lqU+RZIfOfm3dcCubUKEXNFbzKL+EbuK4=;
  b=Z8hd+uOZ9azjJWxicd/hdMNf8jgbV0O2kcQEk6Rh6ElomXN2ENA2zGYm
   Up1aduApDmOMaNLtdSMhkQ0aRyyqszEBpPMpneG3kbVHpCpXpTn8CCYxR
   Sq+5VsjSp+QQlxmthfAHkCD/Gn6eVMSUtc7wPmVDFeG1hnUjZx/8RUSbI
   3RE2DrQZuliqPUqyjDNDfsCQEDWL57Yx0seLyQDliIWEKKPPDLVC5b8gH
   FImgOKvEFIZLjwhMAnwxMwFgwpePx/79l8f+j84SasWB2RfC7lzyfN2X4
   k+daHtVKFwGFZZPMpw0+WxYey/XnW8tP4TdJR9lWoH18VprVyNDGhOa0T
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 17:48:18 +0900
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="420659674"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Jun 2024 17:48:18 +0900
Date: Thu, 6 Jun 2024 08:48:17 +0000
From: Khasnis Soumya <soumya.khasnis@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, soumya.khasnis@sony.com,
	srinavasa.nagaraju@sony.com, Madhusudan.Bobbili@sony.com,
	shingo.takeuchi@sony.com, keita.aihara@sony.com,
	masaya.takahashi@sony.com
Subject: Re: [PATCH v2] reboot: Add timeout for device shutdown
Message-ID: <20240606084817.GA118817@sony.com>
References: <20240529110049.GA73111@sony.com>
 <2024052927-traffic-lazy-e3ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024052927-traffic-lazy-e3ad@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, May 29, 2024 at 02:51:48PM +0200, Greg KH wrote:
> On Wed, May 29, 2024 at 11:00:49AM +0000, Soumya Khasnis wrote:
> > The device shutdown callbacks invoked during shutdown/reboot
> > are prone to errors depending on the device state or mishandling
> > by one or more driver.
> 
> Why not fix those drivers?  A release callback should not stall, and if
> it does, that's a bug that should be fixed there.
Yes, the drivers must be fixed. But currently there is no good mechanism
which detects such stalls and there by resulting in a system hang. This
serves as a fail-safe mechanism to prevent such stalls at reboot/shutdown.

> 
> Or use a watchdog and just reboot if that triggers at shutdown time.
The hard or software watchdog enabled by config_lockup_detector couldn’t
detect the cases when stalled on IO wait (wait_for_completion/io)

> 
> > In order to prevent a device hang in such
> > scenarios, we bail out after a timeout while dumping a meaningful
> > call trace of the shutdown callback which blocks the shutdown or
> > reboot process.
> 
> Dump it where?
Dump to kernel log and there by the console. Will update the commit message

> 
> 
> > 
> > Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> > Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> > ---
> >  drivers/base/Kconfig | 15 +++++++++++++++
> >  kernel/reboot.c      | 46 +++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 2b8fd6bb7da0..d06e379b6281 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -243,3 +243,18 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
> >  	  work on.
> >  
> >  endmenu
> > +
> > +config DEVICE_SHUTDOWN_TIMEOUT
> > +	bool "device shutdown timeout"
> > +	default n
> 
> That is the default, so no need for this.
Was mindful of the “slow” devices in the system with long IO wait times.
Will have to consider increasing DEVICE_SHUTDOWN_TIMEOUT_SEC and make this
a default y

> 
> 
> > +	help
> > +	   Enable timeout for device shutdown. Helps in case device shutdown
> > +	   is hung during shoutdonw and reboot.
> > +
> > +
> > +config DEVICE_SHUTDOWN_TIMEOUT_SEC
> > +	int "device shutdown timeout in seconds"
> > +	default 5
> > +	depends on DEVICE_SHUTDOWN_TIMEOUT
> > +	help
> > +	  sets time for device shutdown timeout in seconds
> 
> You need much more help text for all of these.
Will update the commit with more help text

> 
> And why are these in the drivers/base/Kconfig file?  It has nothing to
> do with "devices", or the driver core, it's all core kernel reboot
> logic.
This is handling only device shutdown, not complete reboot part,
so we want to keep it here.

> 
> 
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 22c16e2564cc..8460bd24563b 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/syscore_ops.h>
> >  #include <linux/uaccess.h>
> > -
> > +#include <linux/sched/debug.h>
> 
> Why remove the blank line?
Will fix it.

> 
> >  /*
> >   * this indicates whether you can reboot with ctrl-alt-del: the default is yes
> >   */
> > @@ -48,6 +48,14 @@ int reboot_cpu;
> >  enum reboot_type reboot_type = BOOT_ACPI;
> >  int reboot_force;
> >  
> > +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> > +struct device_shutdown_timeout {
> > +	struct timer_list timer;
> > +	struct task_struct *task;
> > +} devs_shutdown;
> > +#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
> > +#endif
> 
> #ifdefs should not be in .c files, please put this in a .h file where it
> belongs.  Same for the other #ifdefs.
Will fix it

> 
> 
> 
> > +
> >  struct sys_off_handler {
> >  	struct notifier_block nb;
> >  	int (*sys_off_cb)(struct sys_off_data *data);
> > @@ -88,12 +96,46 @@ void emergency_restart(void)
> >  }
> >  EXPORT_SYMBOL_GPL(emergency_restart);
> >  
> > +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> > +static void device_shutdown_timeout_handler(struct timer_list *t)
> > +{
> > +	pr_emerg("**** device shutdown timeout ****\n");
> 
> What does this have to do with "devices"?  This is a whole-system issue,
> or really a "broken driver" issue.
Shutdown/reboot procedure involves quite a few routines. We are specifically
dealing with a broken driver or device malfunction.

> 
> > +	show_stack(devs_shutdown.task, NULL, KERN_EMERG);
> 
> How do you know this is the 'device shutdown' stack?  What is a "device
> shutdown"?
The timeout handler is invoked in the context of reboot/shutdown process.
We are interested in the device shutdown callback which was stuck and
preventing the reboot/shutdown. By device shutdown, we refer to device
class/bus/driver shutdown calls.

> 
> > +	if (system_state == SYSTEM_RESTART)
> > +		emergency_restart();
> > +	else
> > +		machine_power_off();
> > +}
> > +
> > +static void device_shutdown_timer_set(void)
> > +{
> > +	devs_shutdown.task = current;
> 
> It's just the normal shutdown stack/process, why call it a device?
We are specifically dealing with a broken driver or device malfunction,
So to indicate same, we want to name it as device_shutdown stack.

> 
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
> >  void kernel_restart_prepare(char *cmd)
> >  {
> >  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> >  	system_state = SYSTEM_RESTART;
> >  	usermodehelper_disable();
> > +	device_shutdown_timer_set();
> >  	device_shutdown();
> > +	device_shutdown_timer_clr();
> 
> Why isn't all of this done in device_shutdown() if you think it is a
> device issue?  Why put it in reboot.c?
Will consider moving to device_shutdown()..

> 
> thanks,
> 
> greg k-h

Thanks and Regards,
Soumya.

