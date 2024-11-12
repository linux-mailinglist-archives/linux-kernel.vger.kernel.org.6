Return-Path: <linux-kernel+bounces-405717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D49C562D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B68928D48E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7E226B87;
	Tue, 12 Nov 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YLNM61YC"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6422259F0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408982; cv=none; b=Y3cdtGrULdGYw42t3d4Lj3Qe50yRsuS+wnBLeVAFNPD6Y8xuDOv7FS5QQjyjRFvoTiVC+Iom4Pn/PQ1ayLpBus5kuZLa+SNVz7zoRCmDLOON6TlDpnrvmcj0jhdia0BRSC3nQ7oXHDL/dQKsCGECBzYZB6VqynxQbjlJ1QIeZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408982; c=relaxed/simple;
	bh=DsbYhjU+MGS4KHI8QOgLMW2dvNF6mRm2JPGKykDe36E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNmCycPRDvv0N+D3ubDe7iVCKdNHwuZ4nJQsV3g84Dio8Ri/R9rA6OSHiTY7Uz7Y/0Z4mtlt0GWY5x8kXA03XSMLuQZMTdOlTswEfzV548nyMBbuml2suQY9tJgqvV+05FMTTwThJzOboWiQR4b1G633J+wUJwrWkjY1tDn0h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YLNM61YC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f84907caso6128540e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731408978; x=1732013778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgV5V8DK71Iloe3m6MTNyD9MYw5RZp19v9Zftu6XlE=;
        b=YLNM61YCYYihEcXCiL3uLgALkvezYEJBU1Z73pxn27sctfuNneF6JmVlYW+dpNo6NR
         4jUX139NsP/WTMyVIzPN76VvXjXpVVU9ni9hK71AgA3+eMKxznm5FbP9r1BfDWr+KNb/
         GxKcfJpL+BQFOnu9SbQNm//yhgx6XK1VmSkRE1h5cvZlevdCPm2iV0qyVKW7ZAlFRkWu
         GFW1Ii4/gXOfapgzaB2wmLetU78Ma3xKhIG4PrpvRGuQXCakgMLiaxshuximC2Rs7JOg
         v+o8SpHJ8lhYVYxqt3s+orw5iM4fY+raOWsurpCTfid96tLm9PnN3CZoKLElUK36MN24
         O5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408978; x=1732013778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NgV5V8DK71Iloe3m6MTNyD9MYw5RZp19v9Zftu6XlE=;
        b=c1DKUtcCThrQly00P2rinIqnvUiCL/EcY25s0yGBgV8Z5ClRA2aS6JdajINe7g4u5B
         fUcRnoBF98lZUTRkvIOm0/Gih0jIDcqhU3z6Qwdr3Twij/UJ+XD5rv7CCsRwmmwj1VKe
         n3xi+HsYbx1D39w1KLvspGtcrp8zuqyMObT34TVVEwiQfc9KCIsRenMcYWldUfrITjv0
         K3ZKv9qouLi6Kkcd0l9FFbAn98AvJ0ByaJCgQsCK5ZBnCg4fgQu3TCvG0wIBswr8ikOg
         +vuN+Uww0NwsUiBrMGKmrXtYDxNQsm2DHPKY5PYHrd62TNcM7rJIGEXOcVacdoUC+od9
         TDsA==
X-Gm-Message-State: AOJu0Yz5aQfnRY5S1jDGb0gmn2GUr0tpt/LEf2/MC9+kkWPfKtD5sQtD
	aYjc/RxQhG3yDd9J4BYUJzdEXMCHrJRG/Uu0jEM05hi2ATlSVi0FA+gMXHIHJQA=
X-Google-Smtp-Source: AGHT+IHDuVB0RR2CHU3iExGqoPqQvYTGAGXUjxRqXvwOpJoZhY9n+8utJFsyRy6JbEFFiAtMSAtDIA==
X-Received: by 2002:a05:6512:b94:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-53d862f33cfmr7627369e87.47.1731408978344;
        Tue, 12 Nov 2024 02:56:18 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1e9sm246583415e9.29.2024.11.12.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:56:17 -0800 (PST)
Date: Tue, 12 Nov 2024 11:56:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Conflict with FORCE_CON: Re: [PATCH v6 04/11] printk: Support
 toggling per-console loglevel via syslog() and cmdline
Message-ID: <ZzM0T5b4uKIN0PM7@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:40, Chris Down wrote:
> A new module parameter (ignore_per_console_loglevel) is added, which can
> be set via the kernel command line or at runtime through
> /sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
> per-console loglevels are ignored, and the global console loglevel
> (console_loglevel) is used for all consoles.
> 
> During sysrq, we temporarily disable per-console loglevels to ensure all
> requisite messages are printed to the console. This is necessary because
> sysrq is often used in dire circumstances where access to
> /sys/class/console may not be trivially possible.

I have just pushed a patchset which removed the console_loglevel
manipulation from sysrq, see
https://lore.kernel.org/r/20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com

As a result, the change in drivers/tty/sysrq.c is not needed anymore.

Note that the other patchset causes some conflict with this patchset.
But they does not seem to be hard to resolved:


1st conflict is in boot_delay_msec(). But the affected logic
has actually been moved to printk_delay(). As a result,
boot_delay_msec() might stay as it is:

static void boot_delay_msec(void)
{
	unsigned long long k;
	unsigned long timeout;

	if (boot_delay == 0 || system_state >= SYSTEM_RUNNING)
		return;

	k = (unsigned long long)loops_per_msec * boot_delay;

	timeout = jiffies + msecs_to_jiffies(boot_delay);
	while (k) {
		k--;
		cpu_relax();
		/*
		 * use (volatile) jiffies to prevent
		 * compiler reduction; loop termination via jiffies
		 * is secondary and may or may not happen.
		 */
		if (time_after(jiffies, timeout))
			break;
		touch_nmi_watchdog();
	}
}


Instead, we should add check of is_printk_force_console() into
printk_delay(). I suggest to do it the following way:

static bool suppress_message_printing_everywhere(int level)
{
	bool suppress_everywhere = true;
	struct console *con;
	int cookie;

	cookie = console_srcu_read_lock();

	for_each_console_srcu(con) {
		if (!suppress_message_printing(level, con)) {
			suppress_everywhere = false;
			break;
		}
	}
	console_srcu_read_unlock(cookie);

	return suppress_everywhere;
}

static inline void printk_delay(int level)
{
	if (!is_printk_force_console() &&
	    suppress_message_printing_everywhere(level))
		return;

	boot_delay_msec();

	if (unlikely(printk_delay_msec)) {
		int m = printk_delay_msec;

		while (m--) {
			mdelay(1);
			touch_nmi_watchdog();
		}
	}
}


2nd conflict is in printk_get_next_message(). I suggest to do
something like:

	force_con = r.info->flags & LOG_FORCE_CON;

	/*
	 * Skip records that are not forced to be printed on consoles and that
	 * has level above the console loglevel. Never suppress when used in
	 * devkmsg_read().
	 */
	if (!force_con && con && suppress_message_printing(r.info->level, con))
		goto out;


Actually, I suggested to pass @con_level instead of @con here.
In which case, we might need something like:

	if (con) {
		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
		con_level = console_srcu_read_loglevel(con);
	} else {
		/* Used only by devkmsg_read(). Show all messages there. */
		is_extended = true;
		con_level = CONSOLE_LOGLEVEL_MOTORMOUTH;
	}
[...]
	force_con = r.info->flags & LOG_FORCE_CON;

	/*
	 * Skip records that are not forced to be printed on consoles and that
	 * has level above the console loglevel.
	 */
	if (!force_con && suppress_message_printing(r.info->level, con_level))
		goto out;



I hope that you find there code snippets useful. I provide them
because I feel a bit guilty that I have already merged the other
patchset... ;-)

Best Regards,
Petr

