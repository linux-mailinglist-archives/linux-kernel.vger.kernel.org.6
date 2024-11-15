Return-Path: <linux-kernel+bounces-410200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488D9CD630
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADD528303F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C615FD13;
	Fri, 15 Nov 2024 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEnX4c9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165842F37
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644446; cv=none; b=DUeyXMuJngjiCJxPD3JtiXhSIgnYllBPY0S0NEW3Q0WpNGlwPsf2OurXpOrJPgB7jPFd6DMEavEuuGpUnaGrdJC3HMTA0oauT54VPcodklo7uW9uBjWVprL/6PUV1v9s1++pteB0zCRqcMeG1XvnupaBRBvr2GHdPuVpdu0rTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644446; c=relaxed/simple;
	bh=hnQXQlbEP4VmtjecbhfSbvQDUZqiHupONbvOwH6oljk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdAASlWbPqg4McifA+CcrP8aF8/YZWCvP+DhWEzVeF+jtP4otA+gvtouxmekuTGtAsVVJDbAEtnNLM2zEyfYlR6UUyi4UaJfBaXRU5/7SvJ9gc/O2DSmE7Z7sQfJxFL+0Ad+7k6EE/6twsBI+RnSKpArJ7YTJsX0VfrWIq1AyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEnX4c9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C17FC4CECF;
	Fri, 15 Nov 2024 04:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731644445;
	bh=hnQXQlbEP4VmtjecbhfSbvQDUZqiHupONbvOwH6oljk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEnX4c9DWSydg6zjN6Y4qQGno97PZ9w2iHbE1ddpoBmaOraazFKvGOJcK5OyRmXLG
	 ab9d5uXmOhJ0CnWaqdbjx1mi2CNtiva7VPJ5mMb1wNDzaAZyj4DqFuzspx8Y/YTBWe
	 cvzfdj1Y4tBsmtYCW4QhmVeJucEFEHcXwMvKur5U=
Date: Fri, 15 Nov 2024 05:20:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <2024111508-native-subtype-2990@gregkh>
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

On Mon, Oct 28, 2024 at 04:45:46PM +0000, Chris Down wrote:
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
> 
> In terms of technical implementation, we embed a device pointer in the
> console struct, and register each console using it so we can expose
> attributes in sysfs. We currently expose the following attributes:
> 
>     % ls -l /sys/class/console/ttyS0/
>     total 0
>     lrwxrwxrwx 1 root root    0 Oct 23 13:17 subsystem -> ../../../../class/console/
>     -r--r--r-- 1 root root 4096 Oct 23 13:18 effective_loglevel
>     -r--r--r-- 1 root root 4096 Oct 23 13:18 effective_loglevel_source
>     -r--r--r-- 1 root root 4096 Oct 23 13:18 enabled
>     -rw-r--r-- 1 root root 4096 Oct 23 13:18 loglevel
>     -rw-r--r-- 1 root root 4096 Oct 23 13:17 uevent
> 
> The lifecycle of this classdev looks like this on registration:
> 
>     register_console(con)/printk_late_init()
>       console_register_device(con)
>         device_initialize(con->classdev) # refcount++
>         device_add(con->classdev)        # refcount++
> 
> At stable state, the refcount is two.
> 
> Console unregistration looks like this:
> 
>     [con->classdev refcount drops to 0]
>       console_classdev_release(con->classdev)
>         kfree(con->classdev)
> 
>     unregister_console(con)
>       device_unregister(con->classdev)
>         device_del(con->classdev) # refcount--
>           device_remove_class_symlinks()
>             kernfs_remove_by_name_ns()
>               kernfs_drain()
>                 kernfs_drain_open_files() # wait for close()
>         put_device(con->classdev) # refcount--
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/ABI/testing/sysfs-class-console |  47 +++++
>  .../admin-guide/per-console-loglevel.rst      |  41 ++++
>  Documentation/core-api/printk-basics.rst      |  35 ++--
>  Documentation/networking/netconsole.rst       |  13 ++
>  MAINTAINERS                                   |   1 +
>  include/linux/console.h                       |   3 +
>  include/linux/printk.h                        |   2 +
>  kernel/printk/Makefile                        |   2 +-
>  kernel/printk/internal.h                      |   5 +
>  kernel/printk/printk.c                        |  15 ++
>  kernel/printk/sysfs.c                         | 178 ++++++++++++++++++
>  11 files changed, 324 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-console
>  create mode 100644 kernel/printk/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-console b/Documentation/ABI/testing/sysfs-class-console
> new file mode 100644
> index 000000000000..40b90b190af3
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-console
> @@ -0,0 +1,47 @@
> +What:		/sys/class/console/
> +Date:		October 2024

It's no longer October 2024 :(


> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Interface for viewing and setting per-console attributes, like
> +		the per-console loglevel. For a high-level document describing
> +		the motivations for this interface and related non-sysfs
> +		controls, see
> +		Documentation/admin-guide/per-console-loglevel.rst.
> +
> +What:		/sys/class/console/<C>/effective_loglevel
> +Date:		October 2024
> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Read only. The currently effective loglevel for this console.
> +		All messages emitted with a loglevel below the effective value
> +		will be emitted to the console.
> +
> +What:		/sys/class/console/<C>/effective_loglevel_source
> +Date:		October 2024
> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Read only. The currently effective loglevel source for this
> +		console -- for example, whether it was set globally, or whether
> +		it was set locally for this console.
> +
> +		Possible values are:
> +			=============== ============================================
> +			local           The loglevel comes from the per-console
> +			                loglevel.
> +			global          The loglevel comes from the global loglevel.
> +			ignore_loglevel Both the per-console loglevel and global
> +			                loglevels are ignored as ignore_loglevel is
> +			                present on the kernel command line.
> +			=============== ============================================
> +
> +What:		/sys/class/console/<C>/enabled
> +Date:		October 2024
> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Read only. "1" if the console is enabled, "0" otherwise.
> +
> +What:		/sys/class/console/<C>/loglevel
> +Date:		October 2024
> +Contact:	Chris Down <chris@chrisdown.name>
> +Description:	Read write. The current per-console loglevel, which will take
> +		effect if not overridden by other non-sysfs controls (see
> +		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
> +		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
> +		takes the special value "-1" to indicate that no per-console
> +		loglevel is set, and we should defer to the global controls.

-1 is odd, why?  That's going to confuse everyone :(


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
> +
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
> +Chris Down <chris@chrisdown.name>, 13-October-2024
> diff --git a/Documentation/core-api/printk-basics.rst b/Documentation/core-api/printk-basics.rst
> index 2dde24ca7d9f..bfad359505bb 100644
> --- a/Documentation/core-api/printk-basics.rst
> +++ b/Documentation/core-api/printk-basics.rst
> @@ -54,32 +54,33 @@ string, the log level is not a separate argument). The available log levels are:
>  
>  The log level specifies the importance of a message. The kernel decides whether
>  to show the message immediately (printing it to the current console) depending
> -on its log level and the current *console_loglevel* (a kernel variable). If the
> -message priority is higher (lower log level value) than the *console_loglevel*
> -the message will be printed to the console.
> +on its log level and the current global *console_loglevel* or local per-console
> +loglevel (kernel variables). If the message priority is higher (lower log level
> +value) than the effective loglevel the message will be printed to the console.
>  
>  If the log level is omitted, the message is printed with ``KERN_DEFAULT``
>  level.
>  
> -You can check the current *console_loglevel* with::
> +You can check the current console's loglevel -- for example if you want to
> +check the loglevel for serial consoles:
>  
> -  $ cat /proc/sys/kernel/printk
> -  4        4        1        7
> +  $ cat /sys/class/console/ttyS0/effective_loglevel
> +  6
> +  $ cat /sys/class/console/ttyS0/effective_loglevel_source
> +  local
>  
> -The result shows the *current*, *default*, *minimum* and *boot-time-default* log
> -levels.
> +To change the default loglevel for all consoles, simply write the desired level
> +to ``/proc/sys/kernel/console_loglevel``. For example::
>  
> -To change the current console_loglevel simply write the desired level to
> -``/proc/sys/kernel/printk``. For example, to print all messages to the console::
> +  # echo 5 > /proc/sys/kernel/console_loglevel
>  
> -  # echo 8 > /proc/sys/kernel/printk
> +This sets the console_loglevel to print KERN_WARNING (4) or more severe
> +messages to console. Consoles with a per-console loglevel set will ignore it
> +unless ``ignore_per_console_loglevel`` is set on the kernel command line or at
> +``/sys/module/printk/parameters/ignore_per_console_loglevel``.
>  
> -Another way, using ``dmesg``::
> -
> -  # dmesg -n 5
> -
> -sets the console_loglevel to print KERN_WARNING (4) or more severe messages to
> -console. See ``dmesg(1)`` for more information.
> +For more information on per-console loglevels, see
> +Documentation/admin-guide/per-console-loglevel.rst.
>  
>  As an alternative to printk() you can use the ``pr_*()`` aliases for
>  logging. This family of macros embed the log level in the macro names. For
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index d55c2a22ec7a..34419e6fe106 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -72,6 +72,19 @@ Built-in netconsole starts immediately after the TCP stack is
>  initialized and attempts to bring up the supplied dev at the supplied
>  address.
>  
> +You can also set a loglevel at runtime::
> +
> +  $ ls -l /sys/class/console/netcon0/
> +  total 0
> +  lrwxrwxrwx 1 root root    0 May 18 13:28 subsystem -> ../../../../class/console/
> +  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel
> +  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel_source
> +  -r--r--r-- 1 root root 4096 May 18 13:28 enabled
> +  -rw-r--r-- 1 root root 4096 May 18 13:28 loglevel
> +  -rw-r--r-- 1 root root 4096 May 18 13:28 uevent
> +
> +See Documentation/admin-guide/per-console-loglevel.rst for more information.
> +
>  The remote host has several options to receive the kernel messages,
>  for example:
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea134675669e..003f999e531b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18449,6 +18449,7 @@ R:	John Ogness <john.ogness@linutronix.de>
>  R:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
> +F:	Documentation/ABI/testing/sysfs-class-console
>  F:	Documentation/admin-guide/per-console-loglevel.rst
>  F:	Documentation/core-api/printk-basics.rst
>  F:	include/linux/printk.h
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 3ff22bfeef2a..332eef0f95f7 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -16,6 +16,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/bits.h>
> +#include <linux/device.h>
>  #include <linux/irq_work.h>
>  #include <linux/rculist.h>
>  #include <linux/rcuwait.h>
> @@ -322,6 +323,7 @@ struct nbcon_write_context {
>   * @data:		Driver private data
>   * @node:		hlist node for the console list
>   * @level:		Console-specific loglevel
> + * @classdev:		Console class device for /sys/class/console
>   *
>   * @nbcon_state:	State for nbcon consoles
>   * @nbcon_seq:		Sequence number of the next record for nbcon to print
> @@ -351,6 +353,7 @@ struct console {
>  	void			*data;
>  	struct hlist_node	node;
>  	int			level;
> +	struct device		*classdev;
>  
>  	/* nbcon console specific members */
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 0053533dcfec..b7e8411e033d 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -77,6 +77,8 @@ extern bool ignore_per_console_loglevel;
>  
>  extern void console_verbose(void);
>  
> +int clamp_loglevel(int level);
> +
>  /* strlen("ratelimit") + 1 */
>  #define DEVKMSG_STR_MAX_SIZE 10
>  extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
> diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> index 39a2b61c7232..3c0b6e2a8083 100644
> --- a/kernel/printk/Makefile
> +++ b/kernel/printk/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y	= printk.o
> +obj-y	= printk.o sysfs.o

Don't build this in if you don't have to, see below for how to fix that
up (put the #ifdef in the .h file, not the c file...)

>  obj-$(CONFIG_PRINTK)	+= printk_safe.o nbcon.o
>  obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
>  obj-$(CONFIG_PRINTK_INDEX)	+= index.o
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 9303839d0551..ac607d6907a0 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -21,6 +21,11 @@ enum loglevel_source {
>  	LLS_IGNORE_LOGLEVEL,
>  };
>  
> +void console_register_device(struct console *new);
> +void console_setup_class(void);
> +
> +int clamp_loglevel(int level);

Here, put the #ifdef for the non-printk option.

> +
>  enum loglevel_source
>  console_effective_loglevel_source(const struct console *con);
>  int console_effective_loglevel(const struct console *con);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 055619c5c7e8..bc456f7624d4 100644
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

Why are you explicitly setting this to NULL here?

> +
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> @@ -4170,6 +4178,7 @@ void register_console(struct console *newcon)
>  	if (use_device_lock)
>  		newcon->device_unlock(newcon, flags);
>  
> +	console_register_device(newcon);
>  	console_sysfs_notify();
>  
>  	/*
> @@ -4264,6 +4273,9 @@ static int unregister_console_locked(struct console *console)
>  	if (console->flags & CON_NBCON)
>  		nbcon_free(console);
>  
> +	if (console->classdev)
> +		device_unregister(console->classdev);

How could this be NULL?

> +
>  	console_sysfs_notify();
>  
>  	if (console->exit)
> @@ -4428,6 +4440,9 @@ static int __init printk_late_init(void)
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
>  	printk_sysctl_init();
> +
> +	console_setup_class();
> +
>  	return 0;
>  }
>  late_initcall(printk_late_init);
> diff --git a/kernel/printk/sysfs.c b/kernel/printk/sysfs.c
> new file mode 100644
> index 000000000000..e24590074861
> --- /dev/null
> +++ b/kernel/printk/sysfs.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/console.h>
> +#include <linux/device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +#ifdef CONFIG_PRINTK

Don't put #ifdef in a .c file, put it in the .h file like we normally do
please.

> +static struct class *console_class;

I swept the kernel tree a while ago trying to move all users of dynamic
classes to be constant, but didn't catch them all.  So we shouldn't add
new ones.

This one should be a const structure that you register with a call to
class_register() instead of dynamically creating it.  As a random
example of how to do this, see commit 9565794b1b01 ("staging: fieldbus:
make controller_class constant").

> +static const char *
> +console_effective_loglevel_source_str(const struct console *con)
> +{
> +	enum loglevel_source source;
> +	const char *str;
> +
> +	source = console_effective_loglevel_source(con);
> +
> +	switch (source) {
> +	case LLS_IGNORE_LOGLEVEL:
> +		str = "ignore_loglevel";
> +		break;
> +	case LLS_LOCAL:
> +		str = "local";
> +		break;
> +	case LLS_GLOBAL:
> +		str = "global";
> +		break;
> +	default:
> +		pr_warn("Unhandled console loglevel source: %d", source);

Why send this to the console if something went wrong with the loglevel
of the console?  :)

> +		str = "unknown";

That should be all that is needed, as this is about to be sent to
userspace.

> +		break;
> +	}
> +
> +	return str;
> +}
> +
> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));

While I admire the use of READ_ONCE() properly, it really doesn't matter
for sysfs as it could change right afterwards and no one cares.  So no
need for that here, right?


> +}
> +
> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +	ssize_t ret;
> +	int level;
> +
> +	ret = kstrtoint(buf, 10, &level);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (level == -1)
> +		goto out;

As I said above, -1 is an odd thing here, why use it?

> +
> +	if (clamp_loglevel(level) != level)
> +		return -ERANGE;
> +
> +out:
> +	WRITE_ONCE(con->level, level);

Same here, does this matter?

> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(loglevel);
> +
> +static ssize_t effective_loglevel_source_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  console_effective_loglevel_source_str(con));
> +}
> +
> +static DEVICE_ATTR_RO(effective_loglevel_source);
> +
> +static ssize_t effective_loglevel_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", console_effective_loglevel(con));
> +}
> +
> +static DEVICE_ATTR_RO(effective_loglevel);
> +
> +static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct console *con = dev_get_drvdata(dev);
> +	int cookie;
> +	bool enabled;
> +
> +	cookie = console_srcu_read_lock();
> +	enabled = console_srcu_read_flags(con) & CON_ENABLED;
> +	console_srcu_read_unlock(cookie);

As the values can change right after reading, do you really need to
worry about any read locks here?

> +	return sysfs_emit(buf, "%d\n", enabled);
> +}
> +
> +static DEVICE_ATTR_RO(enabled);
> +
> +static struct attribute *console_sysfs_attrs[] = {
> +	&dev_attr_loglevel.attr,
> +	&dev_attr_effective_loglevel_source.attr,
> +	&dev_attr_effective_loglevel.attr,
> +	&dev_attr_enabled.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(console_sysfs);
> +
> +static void console_classdev_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +void console_register_device(struct console *con)
> +{
> +	/*
> +	 * We might be called from register_console() before the class is
> +	 * registered. If that happens, we'll take care of it in
> +	 * printk_late_init.
> +	 */
> +	if (IS_ERR_OR_NULL(console_class))

When you change this to be a constant above, this isn't going to be
needed.

> +		return;
> +
> +	if (WARN_ON(con->classdev))
> +		return;

How can this ever happen?

> +
> +	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
> +	if (!con->classdev)
> +		return;

No error value returned?

thanks,

greg k-h

