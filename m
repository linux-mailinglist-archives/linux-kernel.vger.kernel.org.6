Return-Path: <linux-kernel+bounces-407963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A39C7801
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4061F24EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1C13D24D;
	Wed, 13 Nov 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nt0y/ika"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CD84D13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513524; cv=none; b=tIDbkkRhbIeV9ct2PyZL1X7XOflKJY1EsN3ZD8zH2220VyahQjqOTQmdOpiTpl7135Z4OdvS2sYI0dxrm4Suo3WpUkIgNZg5DmMv3XdLzKAWAQVsMGjjdTE538Bb4HF6uBL/NE/07X4Sx5cWFVhvuSn2VSTeeA70SXTX5sqfKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513524; c=relaxed/simple;
	bh=qo/L4Rj/ujZnYsYMQkwYgfGTPkJq75vK+uiSD4BntRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFuaHNI4I5mCZMVsOlv8r3FucB96XZA2C4XIeqKyegK8wqZ3Hu5zRUEDqdXEOsO3Kb+YFW8EfxRfW2JdYisltIzNbU1WsOHYaBXD81j0ceCgZJ3ZoSYNQgWk1PoyOulU1KCI2Zyo5qBkbdV9OtmHpkfh/MJsdmOY8ELozHTuSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nt0y/ika; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso61577845e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731513520; x=1732118320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf5TjSvPe5rCvBCA6D7ZCh0Cbq12/qb9SeeBw1+x2uc=;
        b=Nt0y/ikaNMRzT2A+CknTKE91mhhv6mMRidkgttd3ojnJhhZ1i394qxdYVdUqnKQurZ
         1EK1CLL4DzuUD6Bj+03CTiYutdqzxPDyPhKEYaZn4Q97SfFCVwt02deZK/iZMlIbqcP3
         L3W6OctF1uINm85ZLfR5q2urGMBaDItEubVhUTm5Nf48wmZj+Eu25s1Q+Ndr2CGgSnM6
         F1E9eRyg8u53Pnzz7rkmLx0SdXTWbi8AK2xHHVDluHOmSKC5ASOq8pmIEWJjNkfipl73
         2ndjRDPt0C3QxV/VMZTUIrw+KPVU5R9t5ZhEnZ4lHr0oF533B1firBLkGvOSjfOZznIp
         Kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513520; x=1732118320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf5TjSvPe5rCvBCA6D7ZCh0Cbq12/qb9SeeBw1+x2uc=;
        b=GucpSFZ6xrAyDP3fnEbGe+HgK/8Y1u1hK2isDlaw3R4vUp1NVgh7hE1/tcKU9xoMSV
         kvAx5aWjEztXl7hpCLoNwF3pB0F5JcUvWmT6oj7qEr1HVdnaSKXinBihimPe+qNNrL3G
         puGngAoXbPxrkwR0BzhT0shkinghLJxMVoLQDSY/sVfdvQpedJ7RKgyoKd2i7hoJvNck
         mrRdkd3Qiqa8CXCN6preOs1wjc69N4aZgL6IzriBoVWJpLCTeqKN/yBzx5URyYQFXjfp
         q+7C702ab5Z7ZW2IHCnscbBaX4y5aYizB1H19Q4qEcWynZTa0BtCrpHsTq46dCq8IqDc
         jIEw==
X-Gm-Message-State: AOJu0Yx1Q792kfGVKSHpFFwZ6WVU9a1MRV6xeuHEdWD7ViNt6BsSzUz/
	mpyf+FdKdxrXzM4AsifaZF0FnIzXFZIYwq/5lQXASIX8Q+8G9w294sa37VDxK1c=
X-Google-Smtp-Source: AGHT+IFqfeHUlD7MVcdhG5Bl24qLF19H70J3IuBOaTcomQbeFOlL7Pl7gAfMQiG1drYAzsfulA7Hlg==
X-Received: by 2002:a05:6000:210e:b0:382:424:94fe with SMTP id ffacd0b85a97d-382042495edmr8354938f8f.36.1731513519825;
        Wed, 13 Nov 2024 07:58:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99790csm18883403f8f.46.2024.11.13.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:58:39 -0800 (PST)
Date: Wed, 13 Nov 2024 16:58:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <ZzTMrFEcYZf58aqj@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:46, Chris Down wrote:
> A sysfs interface under /sys/class/console/ is created that permits
> viewing and configuring per-console attributes. This is the main
> interface with which we expect users to interact with and configure
> per-console loglevels.
> 
> Each console device now has its own directory (for example,
> /sys/class/console/ttyS0/) containing the following attributes:
> 
> - effective_loglevel (ro): The effective loglevel for the console after
>   considering all loglevel authorities (e.g., global loglevel,
>   per-console loglevel).
> - effective_loglevel_source (ro): The source of the effective loglevel
>   (e.g., local, global, ignore_loglevel).
> - enabled (ro): Indicates whether the console is enabled (1) or disabled
>   (0).
> - loglevel (rw): The per-console loglevel. Writing a value between 0
>   (KERN_EMERG) and 8 (KERN_DEBUG + 1) sets the per-console loglevel.
>   Writing -1 disables the per-console loglevel.

The function clamp_loglevel() uses "minimum_console_loglevel"
as the minimal boundary. This variable is initialized to
CONSOLE_LOGLEVEL_MIN which is defined as 1.

And indeed, the value 0 is not accepted:

  # echo 0 >/sys/class/console/ttyS0/loglevel 
  -bash: echo: write error: Numerical result out of range

CONSOLE_LOGLEVEL_MIN has been used since ages. I am not completely
sure about the motivation. I guess that KERN_EMERG messages
should never get disabled.

I would keep "1" as the minimal allowed value and update
the documentation.


> In terms of technical implementation, we embed a device pointer in the
> console struct, and register each console using it so we can expose
> attributes in sysfs. We currently expose the following attributes:
> 
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-console
[...]
> +What:		/sys/class/console/<C>/loglevel
> +Date:		October 2024
> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Read write. The current per-console loglevel, which will take
> +		effect if not overridden by other non-sysfs controls (see
> +		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
> +		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also

The real minimal boundary is 1.

> +		takes the special value "-1" to indicate that no per-console
> +		loglevel is set, and we should defer to the global controls.
> diff --git a/Documentation/admin-guide/per-console-loglevel.rst b/Documentation/admin-guide/per-console-loglevel.rst
> index 1ec7608f94b0..41bf3befb2f3 100644
> --- a/Documentation/admin-guide/per-console-loglevel.rst
> +++ b/Documentation/admin-guide/per-console-loglevel.rst
> @@ -68,3 +68,44 @@ further:
>  The default value for ``kernel.console_loglevel`` comes from
>  ``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
>  ``quiet`` is passed on the kernel command line.
> +
> +Console attributes
> +~~~~~~~~~~~~~~~~~~
> +
> +Registered consoles are exposed at ``/sys/class/console``. For example, if you
> +are using ``ttyS0``, the console backing it can be viewed at
> +``/sys/class/console/ttyS0/``. The following files are available:
> +
> +* ``effective_loglevel`` (r): The effective loglevel after considering all
> +  loglevel authorities. For example, it shows the value of the console-specific
> +  loglevel when a console-specific loglevel is defined, and shows the global
> +  console loglevel value when the console-specific one is not defined.
> +
> +* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
> +  the effective loglevel being set. The following values can be present:
> +
> +    * ``local``: The console-specific loglevel is in effect.
> +
> +    * ``global``: The global loglevel (``kernel.console_loglevel``) is in
> +      effect. Set a console-specific loglevel to override it.
> +
> +    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
> +      command line or at ``/sys/module/printk/parameters/ignore_loglevel``.
> +      Disable it to use level controls.
> +
> +* ``enabled`` (r): Whether the console is enabled.

Please, remove the 'enabled' flag for now. All registered consoles are
enabled. It seems that only some serial consoles temporary disable
consoles during the suspend but the sysfs interface is not accessible
at this time anyway.

It has been discussed recently, see
https://lore.kernel.org/r/ZyoNZfLT6tlVAWjO@pathway.suse.cz

> +* ``loglevel`` (rw): The local, console-specific loglevel for this console.
> +  This will be in effect if no other global control overrides it. Look at
> +  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
> +
> +Deprecated
> +~~~~~~~~~~
> +
> +* ``kernel.printk`` sysctl: this takes four values, setting
> +  ``kernel.console_loglevel``, ``kernel.default_message_loglevel``, the minimum
> +  console loglevel, and a fourth unused value. The interface is generally
> +  considered to quite confusing, doesn't perform checks on the values given,
> +  and is unaware of per-console loglevel semantics.
> +
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -77,6 +77,8 @@ extern bool ignore_per_console_loglevel;
>  
>  extern void console_verbose(void);
>  
> +int clamp_loglevel(int level);
> +

It is declared also in kernel/printk/internal.h. And it seems
that the internal header is enough.

>  /* strlen("ratelimit") + 1 */
>  #define DEVKMSG_STR_MAX_SIZE 10
>  extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -199,6 +199,12 @@ static int __init control_devkmsg(char *str)
>  }
>  __setup("printk.devkmsg=", control_devkmsg);
>  
> +int clamp_loglevel(int level)
> +{
> +	return clamp(level, minimum_console_loglevel,
> +		     CONSOLE_LOGLEVEL_MOTORMOUTH);

Documentation/ABI/testing/sysfs-class-console says:

   "Bounds are 1 (LOGLEVEL_ALERT) to 8 (LOGLEVEL_DEBUG + 1) inclusive."

I do not have strong opinion. But I would follow the documentation
because the limit is well defined there. On the contrary,
CONSOLE_LOGLEVEL_MOTORMOUTH is a randomly chosen value
and we should not leak it to the userspace ;-)

> +}
> +
>  char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
>  #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
>  int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
> @@ -3894,6 +3900,8 @@ static int try_enable_preferred_console(struct console *newcon,
>  			// TODO: Will be configurable in a later patch
>  			newcon->level = -1;
>  
> +			newcon->classdev = NULL;
> +

The console can be enabled also by try_enable_default_console().
We need to initialize newcon->classdev there as well.

The same is true for newcon->level. I have missed this when
reviewing the 3rd patch.

>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> --- /dev/null
> +++ b/kernel/printk/sysfs.c
> +void console_register_device(struct console *con)
> +{
> +	/*
> +	 * We might be called from register_console() before the class is
> +	 * registered. If that happens, we'll take care of it in
> +	 * printk_late_init.
> +	 */
> +	if (IS_ERR_OR_NULL(console_class))
> +		return;

This check is not enough to avoid race with printk_late_init():

CPU0					CPU1

register_console()			printk_late_init()
  [...]					[...]
  console_register_device()		console_register_device()
    if (IS_ERR_OR_NULL(console_class))    if (IS_ERR_OR_NULL(console_class))

BANG: Both CPUs see "console == NULL" and both CPUs try to
      register the device.

I suggest to avoid this race by taking console_list_lock() in
printk_late_init(), see below.

> +
> +	if (WARN_ON(con->classdev))
> +		return;
> +
> +	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
> +	if (!con->classdev)
> +		return;
> +
> +	device_initialize(con->classdev);
> +	dev_set_name(con->classdev, "%s%d", con->name, con->index);
> +	dev_set_drvdata(con->classdev, con);
> +	con->classdev->release = console_classdev_release;
> +	con->classdev->class = console_class;
> +	if (device_add(con->classdev))
> +		put_device(con->classdev);
> +}
> +
> +void console_setup_class(void)
> +{
> +	struct console *con;
> +	int cookie;
> +
> +	/*
> +	 * printk exists for the lifetime of the kernel, it cannot be unloaded,
> +	 * so we should never end up back in here.
> +	 */
> +	if (WARN_ON(console_class))
> +		return;
> +
> +	console_class = class_create("console");
> +	if (!IS_ERR(console_class))
> +		console_class->dev_groups = console_sysfs_groups;
> +
> +	cookie = console_srcu_read_lock();

We should take console_list_lock() here to avoid races with
register_console() and unregister_console(). Otherwise.
console_register_device(con) might be called twice.

> +	for_each_console_srcu(con)
> +		console_register_device(con);
> +	console_srcu_read_unlock(cookie);
> +}
> +#else /* CONFIG_PRINTK */
> +void console_register_device(struct console *new)
> +{
> +}
> +void console_setup_class(void)
> +{
> +}
> +#endif

Best Regards,
Petr

