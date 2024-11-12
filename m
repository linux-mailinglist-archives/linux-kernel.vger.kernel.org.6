Return-Path: <linux-kernel+bounces-405592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB69C5357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA028826A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E61F26E3;
	Tue, 12 Nov 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsKjAOpw"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1320B20B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407145; cv=none; b=LzlHA61Zy3mtDKNEKtTF/OP9nDqaSc2xMoRmyjDGQncGgQW5q8XMdWMmr6v32NpoZ86SiFCzEybB8ggogO8jjC4+VwA/covFGhYjQDM3Zb4zj8cTuqpB+k3F2d0ke3wCGcDovSSqcno3RW1w09US9cSrd2StJM9yAkU/umPjEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407145; c=relaxed/simple;
	bh=1D1zZKYCSlaEhy1+5tHVx44PwVRCFIMTedpvlyE0kik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9ZuLPJb3LWaDtgRvkgpQGG8Ja/Pv/5lxbfkNT0gL/UvSy8cxw6DUBSBTCxN+voMfbZT7IlTM7ZZ/jf9sFeGFmxCdlANbwP2HMbRwYBTF/AIqm9xrQUmmj3Ci0RyNBeVEpgsDIeRg15zOwTjun/Y9oSf2lAw0vrhC6TaLUYeU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsKjAOpw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3650291f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731407141; x=1732011941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5yHXIwIHCW+JAcYCylm65WJUcWQ5bSuDUNscIOTBvE=;
        b=NsKjAOpwPdPiiYFJnoCR3kUbdhlIsAUz5KJsbdXS4WVj/sKUhvXRMgY8X7UQ+4N6AC
         NMaJ/SkkWeAoOf/OgdrZ5dzTJ4CpjVJf79i1KcoDhlFp+Sxhy5gE31fHIxdGYp2O591Y
         YZHts2iclJF6uU6VCX/q10hKP776dBRbbedFmtuFPdZEjiFp0f8p+dpkeu5463UQtvx0
         nktO8apSndE0TjVTHDd9ERelyqB7UF7oJX2OuA3vk6m70QHexuPWgWc5Rqf+VpjyLJCq
         Lnlkwp3th31IlfaBYKDuRUkt16/QJYyCxRio3+tOq7TSQ2al6PheGIgakumvYJvNkdW/
         ELgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407141; x=1732011941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5yHXIwIHCW+JAcYCylm65WJUcWQ5bSuDUNscIOTBvE=;
        b=I0H2BU9teZw15AR1DGnXgfk/5jrN0uH7FGYY3eXdR4qPSLoeZWsMb5LjzQx+SpfrUD
         f/xi3LZZNJOQJmsdPrJDAOvu3aIATxUrkHeEfxWcSZQpvML66mHoA8cOPSw6/WAsxkEW
         gvakjzUV10ztrEWnlUwPVscSuv1c4n97krZX7Qm95lEhwmYT0pKr6w1aNHvXEkYyu/1G
         oqaOqC2PS5FD5jmPwTfUg6+CGdJqHtEcfkQDWBownbJzKRn/FZ4/nfHbLcifTVpN1EYy
         pmD73nUCEnjjTuZ+mYGnriich4mX5EIC5IoXe7823tQ2MfZPPGnHTr6H1PXPtkvCARin
         7mQw==
X-Gm-Message-State: AOJu0YwtVsg8dfjwmJrBO1kV0/HO7Oqu6imbZhgGxs/fl8F4kAgG1euP
	pB1nN6ldK0/2ddz5vI3naMtzKdbexW7k5AidUVkW3OFStowcAzyWnSr0Cfip6Cw=
X-Google-Smtp-Source: AGHT+IGIYd2CmmVqWiZ5wMCAwv4CjM91gTS2b3teNaxRcn9X2Z86zV570IB+s6/7CCxiw+pEV6x29w==
X-Received: by 2002:a05:6000:184e:b0:381:df72:52cd with SMTP id ffacd0b85a97d-381f1822aadmr14787560f8f.23.1731407141024;
        Tue, 12 Nov 2024 02:25:41 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda03696sm15200653f8f.87.2024.11.12.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:25:40 -0800 (PST)
Date: Tue, 12 Nov 2024 11:25:38 +0100
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
Message-ID: <ZzMtCVlLVLnwghQB@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <28d8dff56bc15b2a41f0d2035701ccb11df22610.1730133890.git.chris@chrisdown.name>
 <Zy4368zf-sJyyzja@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4368zf-sJyyzja@pathway.suse.cz>

On Fri 2024-11-08 17:10:31, Petr Mladek wrote:
> On Mon 2024-10-28 16:45:37, Chris Down wrote:
> It would be nice to describe the basic logic in the commit message.
> And also the handling when the global console_loglevel is modified
> via sysrq. Something like:
> 
> <proposal>
> This commit adds the internal infrastructure to support per-console
> log levels, which will be configurable through sysfs and the kernel
> command line in future commits.
> 
> The global `console_loglevel` is preserved and used as the default log
> level for all consoles. Each console can override this global level
> with its own specific log level stored in `struct console`. To
> override the global level, the per-console log level must be greater
> than 0; otherwise, the default value of -1 ensures the global level
> is used.
> 
> The existing `ignore_loglevel` command line parameter will override
> both the global and per-console log levels.
> </proposal>
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1287,9 +1287,62 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
> > +enum loglevel_source
> > +console_effective_loglevel_source(const struct console *con)
> > +{
> > +	if (WARN_ON_ONCE(!con))
> > +		return LLS_GLOBAL;
> > +
> > +	if (ignore_loglevel)
> > +		return LLS_IGNORE_LOGLEVEL;
> > +
> > +	if (per_console_loglevel_is_set(con))
> > +		return LLS_LOCAL;
> > +
> > +	return LLS_GLOBAL;
> > +}
> 
> The @con parameter is nice. But it makes it hard to add lockdep
> checks. So, I suggest to pass the console specific loglevel
> as the parameter, like:
> 
> enum loglevel_source
> console_effective_loglevel_source(int con_level)
> {
> 	if (ignore_loglevel)
> 		return LLS_IGNORE_LOGLEVEL;
> 
> 	if (is_valid_per_console_loglevel(con_level))
> 		return LLS_LOCAL;
> 
> 	return LLS_GLOBAL;
> }
> 
> int console_effective_loglevel(int con_level)
> {
> 	enum loglevel_source source;
> 	int level;
> 
> 	source = console_effective_loglevel_source(con_level);
> 
> 	switch (source) {
> 	case LLS_IGNORE_LOGLEVEL:
> 		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
> 		break;
> 	case LLS_LOCAL:
> 		level = con_level;
> 		break;
> 	case LLS_GLOBAL:
> 		level = console_level;
> 		break;
> 	default:
> 		pr_warn("Unhandled console loglevel source: %d", source);
> 		level = console_level;
> 		break;
> 	}
> 
> 	return level;
> }
> 
> static bool suppress_message_printing(int level, int con_level)
> {
> 	return level >= console_effective_loglevel(con_level);
> }
> 
> >  
> >  #ifdef CONFIG_BOOT_PRINTK_DELAY
> > @@ -2975,7 +3042,7 @@ bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
> >  	pmsg->dropped = r.info->seq - seq;
> >  
> >  	/* Never suppress when used in devkmsg_read() */
> > -	if (con && suppress_message_printing(r.info->level))
> > +	if (con && suppress_message_printing(r.info->level, con))
> 
> We could read the con_level at the beginning of the funcion. We
> already read there the CON_EXTENDED attribute:
> 
> 	int con_level:
> 
> 	if (con) {
> 		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> 		con_level = console_srcu_read_loglevel(con);
> 	} else {
> 		/* Used only by devkmsg_read(). */
> 		is_extended = true;
> 		con_level = LOGLEVEL_DEFAULT;

Or we could do:

	} else {
		/* Used only by devkmsg_read(). Show all messages there. */
		is_extended = true;
		con_level = CONSOLE_LOGLEVEL_MOTORMOUTH;

The LOGLEVE_DEFAULT would cause using the global loglevel.
But we want to force showing the message.


> 	}
> 
> Note that I have used LOGLEVEL_DEFAULT instead of the hardcoded -1.
> IMHO, it is better to use a NAME and LOGLEVEL_DEFAULT is defined as -1
> and the name more or less fits here.
> 
> and then do:
> 
> 	if (con && suppress_message_printing(r.info->level, con_level))

and then we do not need to check the @con here.

This idea came when I was looking at resolving conflicts against the patchset
which removed the hack in sysrq code, see
https://lore.kernel.org/r/20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com

Best Regards,
Petr

