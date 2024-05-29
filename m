Return-Path: <linux-kernel+bounces-194112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58248D36C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992041F28F03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611B79FD;
	Wed, 29 May 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04w5Mozj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DB6FC6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987104; cv=none; b=RBEZVtzdeV9RE6Y5AEmIhrMg1c1aO1yvDkNJeNe1tlgcXV8X14AlRDIIV36ZGUeR70sUKNjYfj8158KYTLllQS/G3OzZya6iJE5V7FvxfZaDudzoi4rZ3ZfPCxtrO0aPmd0RW8Uu1YNPM1R1JSeEzqetc7h9PjeD/iFIt6rg43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987104; c=relaxed/simple;
	bh=4J+bOv1QJigSGcEp8oiwju1wbh6UwxCDdBQO59w4Lm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiuWz2SqrMb9qHcsbQoyrQJgWfkz9KZQoqCdnimQ5CYqBepP8AOSTxIowEaH9OZz+d0ASGm5q6H/OQ+AIFWFLvTV79xJdUS7jGxYcsR1rCZ2o7JwL+AS+VsckXDlU8t8EjZBddu3R9couDuBUGGQdn+TCU0Tmsn1vBlTUyXddis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04w5Mozj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA23DC32789;
	Wed, 29 May 2024 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716987104;
	bh=4J+bOv1QJigSGcEp8oiwju1wbh6UwxCDdBQO59w4Lm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=04w5MozjHmoKfUA17BqfgRejyf6ticGZ40+/Joq3jpa61lLUi2tlE+466VMs07p8+
	 Lx3RWUxSMp4iFp+DfYaRoO6W0coHIki5AB0oUOjDu6mh5uXsVhWdiH7M75VirjX3c+
	 iAy49xSlheuioM8zObC+U2CprAOANrncgNAnBRTU=
Date: Wed, 29 May 2024 14:51:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v2] reboot: Add timeout for device shutdown
Message-ID: <2024052927-traffic-lazy-e3ad@gregkh>
References: <20240529110049.GA73111@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529110049.GA73111@sony.com>

On Wed, May 29, 2024 at 11:00:49AM +0000, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver.

Why not fix those drivers?  A release callback should not stall, and if
it does, that's a bug that should be fixed there.

Or use a watchdog and just reboot if that triggers at shutdown time.

> In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback which blocks the shutdown or
> reboot process.

Dump it where?


> 
> Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> ---
>  drivers/base/Kconfig | 15 +++++++++++++++
>  kernel/reboot.c      | 46 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..d06e379b6281 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -243,3 +243,18 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
>  	  work on.
>  
>  endmenu
> +
> +config DEVICE_SHUTDOWN_TIMEOUT
> +	bool "device shutdown timeout"
> +	default n

That is the default, so no need for this.


> +	help
> +	   Enable timeout for device shutdown. Helps in case device shutdown
> +	   is hung during shoutdonw and reboot.
> +
> +
> +config DEVICE_SHUTDOWN_TIMEOUT_SEC
> +	int "device shutdown timeout in seconds"
> +	default 5
> +	depends on DEVICE_SHUTDOWN_TIMEOUT
> +	help
> +	  sets time for device shutdown timeout in seconds

You need much more help text for all of these.

And why are these in the drivers/base/Kconfig file?  It has nothing to
do with "devices", or the driver core, it's all core kernel reboot
logic.


> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 22c16e2564cc..8460bd24563b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -18,7 +18,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/uaccess.h>
> -
> +#include <linux/sched/debug.h>

Why remove the blank line?

>  /*
>   * this indicates whether you can reboot with ctrl-alt-del: the default is yes
>   */
> @@ -48,6 +48,14 @@ int reboot_cpu;
>  enum reboot_type reboot_type = BOOT_ACPI;
>  int reboot_force;
>  
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +struct device_shutdown_timeout {
> +	struct timer_list timer;
> +	struct task_struct *task;
> +} devs_shutdown;
> +#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
> +#endif

#ifdefs should not be in .c files, please put this in a .h file where it
belongs.  Same for the other #ifdefs.



> +
>  struct sys_off_handler {
>  	struct notifier_block nb;
>  	int (*sys_off_cb)(struct sys_off_data *data);
> @@ -88,12 +96,46 @@ void emergency_restart(void)
>  }
>  EXPORT_SYMBOL_GPL(emergency_restart);
>  
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +static void device_shutdown_timeout_handler(struct timer_list *t)
> +{
> +	pr_emerg("**** device shutdown timeout ****\n");

What does this have to do with "devices"?  This is a whole-system issue,
or really a "broken driver" issue.

> +	show_stack(devs_shutdown.task, NULL, KERN_EMERG);

How do you know this is the 'device shutdown' stack?  What is a "device
shutdown"?

> +	if (system_state == SYSTEM_RESTART)
> +		emergency_restart();
> +	else
> +		machine_power_off();
> +}
> +
> +static void device_shutdown_timer_set(void)
> +{
> +	devs_shutdown.task = current;

It's just the normal shutdown stack/process, why call it a device?

> +	timer_setup(&devs_shutdown.timer, device_shutdown_timeout_handler, 0);
> +	devs_shutdown.timer.expires = jiffies + SHUTDOWN_TIMEOUT * HZ;
> +	add_timer(&devs_shutdown.timer);
> +}
> +
> +static void device_shutdown_timer_clr(void)
> +{
> +	del_timer(&devs_shutdown.timer);
> +}
> +#else
> +static inline void device_shutdown_timer_set(void)
> +{
> +}
> +static inline void device_shutdown_timer_clr(void)
> +{
> +}
> +#endif
> +
>  void kernel_restart_prepare(char *cmd)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>  	system_state = SYSTEM_RESTART;
>  	usermodehelper_disable();
> +	device_shutdown_timer_set();
>  	device_shutdown();
> +	device_shutdown_timer_clr();

Why isn't all of this done in device_shutdown() if you think it is a
device issue?  Why put it in reboot.c?

thanks,

greg k-h

