Return-Path: <linux-kernel+bounces-212859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ACF90674A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F981C22902
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383F13D60A;
	Thu, 13 Jun 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPlKHcWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DC13C9A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268232; cv=none; b=De2US8y1bL8OAphdTUuf09IeNWy6GUWKxgSeRXFS1TGDxQFao9LhRkGwSqkRbUdI4nR/EvWaBheCsHhLNW/Q0ynZla7MI4Ny5jVjCMg25z9ASuV92Z4pplf7aNM2yMJ6dIaujJ2M0yGOKWoM5x/RPPAjz2ta5xfkJyUzKwoPaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268232; c=relaxed/simple;
	bh=GBZvswistiYsqyTrPy0tffyCyfbkXMicfKdzPDneFsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFjP7vBdnOIBiDjmn/fcjyAqpEqpWUr4+4MX+lhFDwPnHIIbnNeX+voX4IP0qjMIMVYhWnJ1b3GnL8aKURX0a0EqjAJTDkNLn7vDnouRjSDBjNIsZpGKDxbpgdDvrnmeB8aduJKRM8XpH8ggXeSRTGw09oqVrepP/k2n6siCvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPlKHcWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECE5C2BBFC;
	Thu, 13 Jun 2024 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718268231;
	bh=GBZvswistiYsqyTrPy0tffyCyfbkXMicfKdzPDneFsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPlKHcWbt1Gj9IAF0FzZvd2B0/bNy583tqnLY8aTR7YKMoW8ldPrsHwSs40HRcdqU
	 M0SuNB3nyvC9F2295xB2yo+nr0ZcVjZM697m2E4xtqWZV1TWMtOrqV+iX7j578sV/f
	 Y3DURxqYBkoX6dUEmqXDCOxCfuXbAXmWPt0ncPos=
Date: Thu, 13 Jun 2024 10:43:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v5] driver core: Add timeout for device shutdown
Message-ID: <2024061326-moonlit-protozoan-61f8@gregkh>
References: <20240613083226.GA8191@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613083226.GA8191@sony.com>

On Thu, Jun 13, 2024 at 08:32:26AM +0000, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver. In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback to kernel logs, which blocks
> the shutdown or reboot process.

Again, this is not a "device shutdown" timeout, it is a "the whole
system has not shutdown this fast" timeout.

And in looking at my system, it doesn't shutdown in 10 seconds as it is
madly flushing a ton of stuff out to the disks, and they are slow
beasts.  So your 10 second default would cause me data loss on my
workstation, not good!

> Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> ---
> Changes v3:
>   - fix review comments
>  1. added help text  
>  2. set configuration by default "y"
>  3. added range for timeout value(DEVICE_SHUTDOWN_TIMEOUT_SEC)
>  4. moved #define's to base.h file
>  5. moved timeout functionality to device_shutdown() driver/base/core.c from reboot.c
>   - updated commit message 
>  1. added information of where call trace is logged.
>  2. changed patch subject from "reboot:" to "driver core:"
> 
> Changes v4:
>  1. set configuration by default "n"
>  2. removed range for timeout value(DEVICE_SHUTDOWN_TIMEOUT_SEC)
> 
> Changes v5:
>  1. removed "default n" for configuration.
> 
>  drivers/base/Kconfig | 16 ++++++++++++++++
>  drivers/base/base.h  |  8 ++++++++
>  drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..5493d419bdd0 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -243,3 +243,19 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
>  	  work on.
>  
>  endmenu
> +
> +config DEVICE_SHUTDOWN_TIMEOUT
> +	bool "device shutdown timeout"
> +	help
> +	   Enable timeout for device shutdown. In case of device shutdown is
> +	   broken or device is not responding, system shutdown or restart may hang.
> +	   This timeout handles such situation and triggers emergency_restart or
> +	   machine_power_off. Also dumps call trace of shutdown process.

Again, this is not true, this does not take into account that many
systems take a while to flush stuff out.  And that's ok!  They are busy
working, are not stalled, are not broken, and all is good.

And this doesn't have to do with devices.  Oh, I see you moved this to
the driver core now, it wasn't there before.  But why?

Isn't this just a bug in your drivers?  Why not fix them?  Or if you
really have to have 10 seconds to shut down, use a watchdog timer that
you trigger from userspace and stop petting once you want to shut down.
Then, if it expires it will reset the machine, all of your policy
decisions would have been done in userspace, no need to get the kernel
involved at all.

> +
> +
> +config DEVICE_SHUTDOWN_TIMEOUT_SEC
> +	int "device shutdown timeout in seconds"
> +	default 10
> +	depends on DEVICE_SHUTDOWN_TIMEOUT
> +	help
> +	  sets time for device shutdown timeout in seconds
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0738ccad08b2..97eea57a8868 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -243,3 +243,11 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
>  
>  void software_node_notify(struct device *dev);
>  void software_node_notify_remove(struct device *dev);
> +
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +struct device_shutdown_timeout {
> +	struct timer_list timer;
> +	struct task_struct *task;
> +};
> +#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
> +#endif
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b93f3c5716ae..dab455054a80 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -35,6 +35,12 @@
>  #include "base.h"
>  #include "physical_location.h"
>  #include "power/power.h"
> +#include <linux/sched/debug.h>
> +#include <linux/reboot.h>

Does that really look like the correct place for these lines?


> +
> +#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
> +struct device_shutdown_timeout devs_shutdown;
> +#endif

No #ifdef in .c files if at all possible please.

thanks,

greg k-h

