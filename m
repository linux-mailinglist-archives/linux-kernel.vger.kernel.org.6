Return-Path: <linux-kernel+bounces-401962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE69C21A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87371C24E19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64359126C0A;
	Fri,  8 Nov 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VNN1jFMW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1851BD9DB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082235; cv=none; b=FuLfLBXu4abN8Ry+20Ey5x2QopQLs0VqDmc6ODcuu261g67OLAkNFmbNpFpYXvlHw12pd9X57XeiiWODmPz0/huqiQ6JdhSotlJ4jxelfocRwQZUsTkrPSAHsiRWM7gC0x/6CFXq8IuQG51rLD8hAq8fGLma6z0f6TixQhSaWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082235; c=relaxed/simple;
	bh=s/mOP/C2KNG5BtW1X2SsKwVcK6L4lSvbRgGZZRY6BMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0QJGDICUGIvZMGLvk5aqfIvbM4tz9ykY7FbMW0M/VSVfjGubOqCsCWWiAcUFAZrw+/Fo0ICQDPkAW18+US4VCuhXWvhCuMBGBb9NgGYjxuQOlGEiovfrEe60KiQDyisPYapOZAa8HP5cwrAT8gsNgu6LoYhZUIaG5pGruA6gOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VNN1jFMW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53c779ef19cso2904398e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731082231; x=1731687031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCWzb7eQLuXKNbRlcgpsybY014eEWcCeqgn2VOc8GkI=;
        b=VNN1jFMWpuP/HMA3f896i/50L6JP/WKlKg+YXtAOzaZaPcjc/rD5wFu/ExNFmuRDhy
         LmnBn4rHiWeGLPqlIPOA0UesDxHQkC9eHpyR6GNw1fAYt24ugyHY8RqYBPHwA9sx+2xf
         JwTbzEbWT3AidM0ajVwJPzN6BccF1obStN8sU4Q4tXI86q9RmwHozrHdx09996EvVuGX
         h6K3gUGw5sqXIyPmZk/cq1FK5FvLVdR5eq/bHnPh4+cvRVMHK7uJwEX32Ro+chuMkZGu
         ATJmF0oKbud7xyz2hR2DbEz4Vy2XKjAfxsFQte+Kmu739q37hIYUne/yMKtGs4+nft8u
         aleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731082231; x=1731687031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCWzb7eQLuXKNbRlcgpsybY014eEWcCeqgn2VOc8GkI=;
        b=B4SQTio3NDiRBDGIUKysZRet4jUitt/NlMVMIsiajN+YgClqzPf49YpyOcJ2dueHG7
         bNZR27elqKmn1Iq14KKHLY6LlQlm1Pqq2xyiBno0Ca/1mSYiIaR0whvBHCJ9wAqK6rvj
         8NmUmzVupAj/0r8lYerpfZ8JtKh6tJWjTvFd0ke7LE4qmvzqZARMrMc9UiZ6Q53kMlNg
         ORnGCPCncGvS8xuNlFuuIh7bURheuv3UQ+xECK7WyJW40+QoMTCi3P+J3z9TqQJ2Osj6
         OSufhCVPTAIYLINOQsDxevUmT2soxJbWfzB/0gUHRzoQ5eoYxRIakh7JhW+jvXZ7RuTl
         Rm8g==
X-Gm-Message-State: AOJu0YxIhvJSDxc4PI0RgzrZHcLdxgI/xZuJcsViQ6RifORPFIi2Tw0B
	7xEFjwmixiViymENpHmtCSur5mnCSE/7Ktj0jeRaxIpNYcvoSQPTRDqVnQqDlVA=
X-Google-Smtp-Source: AGHT+IFHwxIr984rFcLVhtJGfOuaNClRJdx+9ocDIXxKif8BTGk1F/c1djJzp9X5lV8Chzw+GS5qYg==
X-Received: by 2002:a05:651c:544:b0:2fb:6027:7c0a with SMTP id 38308e7fff4ca-2ff201e734amr16859701fa.8.1731082230672;
        Fri, 08 Nov 2024 08:10:30 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5ed9eesm3666689a12.48.2024.11.08.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:10:30 -0800 (PST)
Date: Fri, 8 Nov 2024 17:10:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 03/11] printk: console: Implement core per-console
 loglevel infrastructure
Message-ID: <Zy4368zf-sJyyzja@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <28d8dff56bc15b2a41f0d2035701ccb11df22610.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d8dff56bc15b2a41f0d2035701ccb11df22610.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:37, Chris Down wrote:
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the order
> of tens of milliseconds to get the UART to successfully write a message.
> While this might be fine for a single, one-off message, this can cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
> 
> This means that while you might want to send at least INFO level
> messages to (for example) netconsole, which is relatively fast, you may
> only want to send at least WARN level messages to the serial console.
> Such an implementation would permit debugging using the serial console
> in cases that netconsole doesn't receive messages during particularly
> bad system issues, while still keeping the noise low enough to avoid
> inducing latency in userspace applications. To mitigate this, add such
> an interface, extending the existing console loglevel controls to allow
> each console to have its own loglevel.
> 
> One can't just disable the serial console, because one may actually need
> it in situations where the machine is in a bad enough state that nothing
> is received on netconsole. One also can't just bump the loglevel at
> runtime after the issue, because usually the machine is already so
> wedged by this point that it isn't responsive to such requests.

The motivation is described nicely.

> The sysfs and kernel command line interfaces to set the per-console
> loglevel will be added later. For now, simply add the necessary internal
> infrastructure to be used by later patches.

It would be nice to describe the basic logic in the commit message.
And also the handling when the global console_loglevel is modified
via sysrq. Something like:

<proposal>
This commit adds the internal infrastructure to support per-console
log levels, which will be configurable through sysfs and the kernel
command line in future commits.

The global `console_loglevel` is preserved and used as the default log
level for all consoles. Each console can override this global level
with its own specific log level stored in `struct console`. To
override the global level, the per-console log level must be greater
than 0; otherwise, the default value of -1 ensures the global level
is used.

The existing `ignore_loglevel` command line parameter will override
both the global and per-console log levels.
</proposal>

> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -101,11 +102,25 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
>  static void sysrq_handle_loglevel(u8 key)
>  {
>  	u8 loglevel = key - '0';
> +	int cookie;
> +	int warned = 0;
> +	struct console *con;
>  
>  	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>  	pr_info("Loglevel set to %u\n", loglevel);
>  	console_loglevel = loglevel;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		if (!warned && per_console_loglevel_is_set(con)) {
> +			warned = 1;
> +			pr_warn("Overriding per-console loglevel from sysrq\n");
> +		}
> +		WRITE_ONCE(con->level, -1);
> +	}
> +	console_srcu_read_unlock(cookie);
>  }
> +

I would prefer to move this into a separate patch. It is similar to
the syslog interface which is handled separately as well.

I would keep this patch only for the basic logic.


>  static const struct sysrq_key_op sysrq_loglevel_op = {
>  	.handler	= sysrq_handle_loglevel,
>  	.help_msg	= "loglevel(0-9)",
> diff --git a/include/linux/console.h b/include/linux/console.h
> index eba367bf605d..3ff22bfeef2a 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -349,6 +350,7 @@ struct console {
>  	unsigned long		dropped;
>  	void			*data;
>  	struct hlist_node	node;
> +	int			level;
>  
>  	/* nbcon console specific members */
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index eca9bb2ee637..5fbd6b7f1ab4 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -303,6 +304,10 @@ static inline void nbcon_device_release(struct console *con)
>  static inline void nbcon_atomic_flush_unsafe(void)
>  {
>  }
> +static inline bool per_console_loglevel_is_set(const struct console *con)

There are similar functions in the printk API, for example,
is_printk_legacy_deferred(). It would be nice to use a similar
naming scheme. I would call it, something like:

	has_per_console_loglevel(con)

> +{
> +	return false;
> +}
>  
>  #endif
>  
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1287,9 +1287,62 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(ignore_loglevel,
>  		 "ignore loglevel setting (prints all kernel messages to the console)");
>  
> -static bool suppress_message_printing(int level)
> +bool per_console_loglevel_is_set(const struct console *con)
>  {
> -	return (level >= console_loglevel && !ignore_loglevel);
> +	return con && (READ_ONCE(con->level) > 0);

We should document why READ_ONCE() is used.

Also it would be great to allow checking of locking dependencies to
make sure that the struct console could not disappear. Similiar
to console_srcu_read_flags(con).

In the followup patches, the funtion is mostly used
the console_srcu_read_lock(). The exception seems to be the sysfs
interface, e.g. effective_loglevel_source_show().

Hmm, we need to distinguish these two callers either by serapate API
or a parameter.

Both is a bit ugly, so I would prefer to reduce the number of these
ugly APIs by passing @con_loglevel instead of @con.

Anyway, we should create something similar to console_srcu_read_flags().


/**
 * console_srcu_read_loglevel - Locklessly read the console specific loglevel
 *				of a possibly registered console
 * @con:	struct console pointer of console to read flags from
 *
 * Locklessly reading @con->loglevel provides a consistent read value because
 * there is at most one CPU modifying @con->loglevel and that CPU is using only
 * read-modify-write operations to do so.
 *
 * Requires console_srcu_read_lock to be held, which implies that @con might
 * be a registered console. The purpose of holding console_srcu_read_lock is
 * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
 * and that no exit/cleanup routines will run if the console is currently
 * undergoing unregistration.
 *
 * If the caller is holding the console_list_lock or it is _certain_ that
 * @con is not and will not become registered, the caller may read
 * @con->loglevel directly instead.
 *
 * Context: Any context.
 * Return: The current value of the @con->level field.
 */
static inline int console_srcu_read_loglevel(const struct console *con)
{
	WARN_ON_ONCE(!console_srcu_read_lock_is_held());

	/* The READ_ONCE() matches the WRITE_ONCE() when @flags are modified. */
	return data_race(READ_ONCE(con->level));
}

Then I would suggest to pass @con_loglevel directly in most the other
API. For example, this function would be:

bool is_valid_per_console_loglevel(int con_level)
{
	return (con_level > 0);
}

> +}
> +
> +/*
> + * Hierarchy of loglevel authority:
> + *
> + * 1. con->level. The locally set, console-specific loglevel. Optional, only
> + *    valid if >0.
> + * 2. console_loglevel. The default global console loglevel, always present.

I would remove these comments. It is obvious from the code.

> + */
> +enum loglevel_source
> +console_effective_loglevel_source(const struct console *con)
> +{
> +	if (WARN_ON_ONCE(!con))
> +		return LLS_GLOBAL;
> +
> +	if (ignore_loglevel)
> +		return LLS_IGNORE_LOGLEVEL;
> +
> +	if (per_console_loglevel_is_set(con))
> +		return LLS_LOCAL;
> +
> +	return LLS_GLOBAL;
> +}

The @con parameter is nice. But it makes it hard to add lockdep
checks. So, I suggest to pass the console specific loglevel
as the parameter, like:

enum loglevel_source
console_effective_loglevel_source(int con_level)
{
	if (ignore_loglevel)
		return LLS_IGNORE_LOGLEVEL;

	if (is_valid_per_console_loglevel(con_level))
		return LLS_LOCAL;

	return LLS_GLOBAL;
}

IMHO, it is not that bad after all.


> +int console_effective_loglevel(const struct console *con)
> +{
> +	enum loglevel_source source;
> +	int level;
> +
> +	source = console_effective_loglevel_source(con);
> +
> +	switch (source) {
> +	case LLS_IGNORE_LOGLEVEL:
> +		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
> +		break;
> +	case LLS_LOCAL:
> +		level = READ_ONCE(con->level);
> +		break;
> +	case LLS_GLOBAL:
> +		level = console_loglevel;
> +		break;
> +	default:
> +		pr_warn("Unhandled console loglevel source: %d", source);
> +		level = console_loglevel;
> +		break;
> +	}
> +
> +	return level;
> +}

and similar here:

int console_effective_loglevel(int con_level)
{
	enum loglevel_source source;
	int level;

	source = console_effective_loglevel_source(con_level);

	switch (source) {
	case LLS_IGNORE_LOGLEVEL:
		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
		break;
	case LLS_LOCAL:
		level = con_level;
		break;
	case LLS_GLOBAL:
		level = console_level;
		break;
	default:
		pr_warn("Unhandled console loglevel source: %d", source);
		level = console_level;
		break;
	}

	return level;
}


> +
> +static bool suppress_message_printing(int level, struct console *con)
> +{
> +	return level >= console_effective_loglevel(con);
>  }

and here:

static bool suppress_message_printing(int level, int con_level)
{
	return level >= console_effective_loglevel(con_level);
}

>  
>  #ifdef CONFIG_BOOT_PRINTK_DELAY
> @@ -2122,7 +2175,21 @@ int printk_delay_msec __read_mostly;
>  
>  static inline void printk_delay(int level)
>  {
> -	if (suppress_message_printing(level))
> +	bool will_emit = false;
> +	int cookie;
> +	struct console *con;
> +
> +	cookie = console_srcu_read_lock();
> +
> +	for_each_console_srcu(con) {
> +		if (!suppress_message_printing(level, con)) {

This is called under srcu read lock so that we could use the srcu_read
API here:

	for_each_console_srcu(con) {
		int con_level = console_srcu_read_loglevel(con);

		if (!suppress_message_printing(level, con_level)) {
		...

> +			will_emit = true;
> +			break;
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);
> +
> +	if (!will_emit)
>  		return;
>  
>  	boot_delay_msec();
> @@ -2975,7 +3042,7 @@ bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
>  	pmsg->dropped = r.info->seq - seq;
>  
>  	/* Never suppress when used in devkmsg_read() */
> -	if (con && suppress_message_printing(r.info->level))
> +	if (con && suppress_message_printing(r.info->level, con))

We could read the con_level at the beginning of the funcion. We
already read there the CON_EXTENDED attribute:

	int con_level:

	if (con) {
		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
		con_level = console_srcu_read_loglevel(con);
	} else {
		/* Used only by devkmsg_read(). */
		is_extended = true;
		con_level = LOGLEVEL_DEFAULT;
	}

Note that I have used LOGLEVEL_DEFAULT instead of the hardcoded -1.
IMHO, it is better to use a NAME and LOGLEVEL_DEFAULT is defined as -1
and the name more or less fits here.

and then do:

	if (con && suppress_message_printing(r.info->level, con_level))



>  		goto out;
>  
>  	if (is_extended) {
> @@ -3789,6 +3856,9 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (newcon->index < 0)
>  				newcon->index = c->index;
>  
> +			// TODO: Will be configurable in a later patch

I would remove the comment. It is enough to mention this in the commit message.

> +			newcon->level = -1;

			newcon->level = LOGLEVEL_DEFAULT;

> +
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  


Best Regards,
Petr

PS: I am sorry for suggesting so many changes. I think that you did it as
    we agreed in the discussion about v5.

    v5 was discussed a long time ago and I have learned some new
    tricks with lockdep when working on the printk kthreads.

