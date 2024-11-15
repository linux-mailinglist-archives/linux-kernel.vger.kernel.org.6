Return-Path: <linux-kernel+bounces-410788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2E9CE0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4881F29716
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB21CEAD3;
	Fri, 15 Nov 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EjsExwXp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B31CDA17
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679786; cv=none; b=trYFvPBcq9FLfXMH5Rynpmr1F6vf4bFDj4zWSYjXby4ePU8R7GiGMzZv2lVUn/5s6hc2PCQRI8GsXj4y0RC8CSdqZ+T375VRWmYvD741nLrST9IggfQ8/+apYEeb1A1bgBbzdGjlrxe71kGvmoGHcPyZyqHnc8HXRq02W+WILL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679786; c=relaxed/simple;
	bh=LWw08fzFcNSxm2zBPbFHhn5yk31ly3QOkt6fjopKptY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT5TB9Hb41V9pIFaNi9ysYP5gjCHgsI60jN7xe6wuvw7qrtD9/ipASJgSc3bo7PtNopsS8MdYUL2Sa+GjmFQHJAE1inxJ6pKe6AMgPJ0iQuJjWK9C2JgN47WcQ0eW7ac0QHldexbDzkv2W+GAQ+0GSWWSeEqNovErJYF7S61yNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EjsExwXp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so19812195e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731679782; x=1732284582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6pEYdW+lIlOUfcH8xyjeXOlkv10KgDloXUT7dPuM0c=;
        b=EjsExwXp4Ic5gzsJXg9HMf2h/8I7SS+MRtRer3odaRbEBGjgUJUf8c/22OvaGohO+L
         +5dVrqAvPMqE7xXt4WOJ1Tz3ICIsuOP3vFca36hhnMffu4G5a20XZI0e2ftdusp7LLmQ
         T1vK/C4olRy8a8HQxEXJq/0kgajuMV1tI8HIPilgokp4WN+8sOAWADTiIYBsnrKJZvwX
         fKv14k+0M2Ke0m6hlSC4bm+Qy1yJBI0OVqW8YVHdRxk6sbo8G9aEuElHlymlh0aetK5R
         YI6k0jpV8MwH24P9U4BI+aXmNLBY5LyRnm5ri/KETAOHgyEhi8eKETO3ZE2NeKJUFe77
         EyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679782; x=1732284582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6pEYdW+lIlOUfcH8xyjeXOlkv10KgDloXUT7dPuM0c=;
        b=rIkijPjiDyaRruE7DA/57mlZRitKzOqLfmYzRXJDSH4QQrpOHm1DJi00Gu/XhX0gcE
         QE28oywTWnRo2HPHKS13UuxReS/UYqH2fOBE5iilJ3kY+TTZmq5R6WyGOFmT0SxvdHzX
         U5I9WIlYzEX5SlNqKbRqPE67lDGJ6r5MCovMzEpz19sAGKTEn43i0YihdZmGdPmibHZu
         vrr5bDXwYHeaYZSr/TIpmOqvRLLYDPmhNQYO+Xw9PkIRX+m2jE5OSuWobtvHZN43ybO9
         mCZqvlZmJV/CsBzz3ogL//2a1W/PmEAmHm/dxmiIZMslk7wYT1WiguSzG2gj2J4v9JFM
         E36g==
X-Forwarded-Encrypted: i=1; AJvYcCVwWzB4LYwm+LHwwgCrLUY3kltzpk9zuQf578bPgjcnCMDsYsYTfwVEmQsk4ZZv1x4xoD+uXsxVjJucIeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12DmrE15MCO7r9qj67K4itpW0s5co5lsbTku3DBpE+ZLerB13
	GdjWd0b5W2auBvhGJ7cV8PliiYrKJ9xThPNyaEoDOlWDjspecAZ6YTz6Vah7fzE=
X-Google-Smtp-Source: AGHT+IFt/+UuOw3+/oDsYl3b1j6rPM8c+T3WCDvXRRXusJCCb0QB2RtbEleLA7p/tbhO4mtUQsWh6A==
X-Received: by 2002:a05:600c:a43:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-432df743251mr30393945e9.12.1731679780596;
        Fri, 15 Nov 2024 06:09:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da24498csm59474025e9.1.2024.11.15.06.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:09:40 -0800 (PST)
Date: Fri, 15 Nov 2024 15:09:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <ZzdWITzvFH-ae_jx@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111508-native-subtype-2990@gregkh>

On Fri 2024-11-15 05:20:42, Greg Kroah-Hartman wrote:
> On Mon, Oct 28, 2024 at 04:45:46PM +0000, Chris Down wrote:
> > A sysfs interface under /sys/class/console/ is created that permits
> > viewing and configuring per-console attributes. This is the main
> > interface with which we expect users to interact with and configure
> > per-console loglevels.
> > 
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-console
> > @@ -0,0 +1,47 @@
> > +What:		/sys/class/console/<C>/loglevel
> > +Date:		October 2024
> > +Contact:	Chris Down <chris@chrisdown.name>
> > +Description:	Read write. The current per-console loglevel, which will take
> > +		effect if not overridden by other non-sysfs controls (see
> > +		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
> > +		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
> > +		takes the special value "-1" to indicate that no per-console
> > +		loglevel is set, and we should defer to the global controls.
> 
> -1 is odd, why?  That's going to confuse everyone :(

IMHO, it is better than (0) because people might think that "0"
disables all messages or allows just "LOGLEVEL_EMERG".

On the other hand, (-1) is being used for default, undefined, or
unknown values in various situations. For example, see

     git grep "define.*(-1[^0-9]" include/linux/

> > --- /dev/null
> > +++ b/kernel/printk/sysfs.c
> > +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	struct console *con = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));
> 
> While I admire the use of READ_ONCE() properly, it really doesn't matter
> for sysfs as it could change right afterwards and no one cares.  So no
> need for that here, right?

READ_ONCE() prevents compiler optimizations. It makes sure that
the value will be read using a single read operation. It might
be outdated but it will be consistent. I believe that READ_ONCE()
should stay.


> > +}
> > +
> > +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> > +			      const char *buf, size_t size)
> > +{
> > +	struct console *con = dev_get_drvdata(dev);
> > +	ssize_t ret;
> > +	int level;
> > +
> > +	ret = kstrtoint(buf, 10, &level);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (level == -1)
> > +		goto out;
> 
> As I said above, -1 is an odd thing here, why use it?
> 
> > +
> > +	if (clamp_loglevel(level) != level)
> > +		return -ERANGE;
> > +
> > +out:
> > +	WRITE_ONCE(con->level, level);
> 
> Same here, does this matter?

Same here. I believe that WRITE_ONCE() should stay to guarantee an atomic write.

> > +	return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(loglevel);
> > +
> > +static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	struct console *con = dev_get_drvdata(dev);
> > +	int cookie;
> > +	bool enabled;
> > +
> > +	cookie = console_srcu_read_lock();
> > +	enabled = console_srcu_read_flags(con) & CON_ENABLED;
> > +	console_srcu_read_unlock(cookie);
> 
> As the values can change right after reading, do you really need to
> worry about any read locks here?

It is true that the related struct console could not disappear
when this sysfs interface exists. Also it is true that
the read_lock does not prevent any race here.

A plain read is OK.

That said, I suggest to remove this sysfs interface anyway because
the CON_ENABLED flag semantic is bogus. See
https://lore.kernel.org/r/ZzTMrFEcYZf58aqj@pathway.suse.cz and
https://lore.kernel.org/r/ZyoNZfLT6tlVAWjO@pathway.suse.cz


> > +	return sysfs_emit(buf, "%d\n", enabled);
> > +}
> > +
> > +static DEVICE_ATTR_RO(enabled);
> > +
> > +static struct attribute *console_sysfs_attrs[] = {
> > +	&dev_attr_loglevel.attr,
> > +	&dev_attr_effective_loglevel_source.attr,
> > +	&dev_attr_effective_loglevel.attr,
> > +	&dev_attr_enabled.attr,
> > +	NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(console_sysfs);
> > +
> > +static void console_classdev_release(struct device *dev)
> > +{
> > +	kfree(dev);
> > +}
> > +
> > +void console_register_device(struct console *con)
> > +{
> > +	/*
> > +	 * We might be called from register_console() before the class is
> > +	 * registered. If that happens, we'll take care of it in
> > +	 * printk_late_init.
> > +	 */
> > +	if (IS_ERR_OR_NULL(console_class))
> 
> When you change this to be a constant above, this isn't going to be
> needed.
> 
> > +		return;
> > +
> > +	if (WARN_ON(con->classdev))
> > +		return;
> 
> How can this ever happen?
> 
> > +
> > +	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
> > +	if (!con->classdev)
> > +		return;
>
> No error value returned?

Good question.

IMHO, a missing sysfs interface should not be a fatal error
because it might prevent debugging bugs in the sysfs/kobject APIs.
I mean that an error here should not block register_console().

But it is true that we should not ignore this quietly.
We should print an error message at least.

Another question is why is the struct device allocated dynamically?

I guess that it is a memory optimization because struct console
is static. I am not sure if it is worth it. We could always make
it dynamic when people complain.

Best Regards,
Petr

