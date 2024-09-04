Return-Path: <linux-kernel+bounces-314795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9496B8A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287DAB21A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB21CCEE3;
	Wed,  4 Sep 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SO6odcXg"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A284A40
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446057; cv=none; b=ovWGCkK5eqMfRflYnhjW6/uca9Ci3h3yHhj244YMEqEeb5HfFVqgfCQ3cv5gkD0bSHbqX8bBCa00Vla2nyI6xFO/PNyHb9oxwseAkt7EX3T+9QDCm7EdDns7d+AswcwSRKsYWQyswxcI2Dh36HrEQpaIeQwZxTQ8lDmiZMSBOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446057; c=relaxed/simple;
	bh=dLmnx1TF4SiaKL4QOrvyrbwA7Guxd3AQOia6Omz2e0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozdOr9YwX4UAMFa2qOYNBKuMmpj1lOKi9elNb36a7VdXQdnyQepdMzFywUflRrARRC9zpzZOYnrejNTrZuKzkiwuFcU4cpF0sCDQwCvwBPi0/pCLL+SSlW/q+HBDLk74E7m9PTE6F22PkRs/S7HafOwXV1GdHcrUMplPJFl9la8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SO6odcXg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1256718a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725446054; x=1726050854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUsWBUhOnHC+ub+4Jhy0Mx4GpfwgZi2d8Xn0uLNWsSQ=;
        b=SO6odcXgbAlGkA9FbvXHbLetaLzg+lwc36pynDWRV9kZjYCNwUxj0cnM76t+P3bXGu
         0FIDUFreRlbruDoaapBwjTIjQ9kGmeMzxqe5oO2Az0HJ4FdITSmEAiu+bv8LPeQuskem
         rf81PEtI0/p/QVt3zansBK6aiOGPSR47aSedHLhi+J1gDJolSp1DmIs+t2Q3zwvByArn
         AOXU02wsZNv3CZsKZaL0WwLCPK8BCPQjXRjMq9Fbogx7p+kfpHpaEo+WPYYJ7fUHaIT8
         c8GkKZGXM6X4NpT89Sq4pJD0jZB85ZwDE0pvy6OkRkPKM7+przfgRC4LHXZGbFZTmcve
         BAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725446054; x=1726050854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUsWBUhOnHC+ub+4Jhy0Mx4GpfwgZi2d8Xn0uLNWsSQ=;
        b=mleGmxm87XS26FeNiRddY2tGq0iyUOR5HAKt6M8gAT0pjwathIfjip2eFV+n27u3Ox
         LkSjhEe3WlxH+QQmqD9F1+fC2DeVnmdX2jRzwBwaEV54a6tUYpTUaAu1gPilzVU3/rom
         CpBpaEGDSdeBZTCcg9xtp3vfOIeK9+rTT5Ha2p49aTeXeI8hzA6w90D/siI1cWCRTzCH
         espvTMammjnM7cR4UsWuT/xjSkfTaOKWTtw/srEr9/IypIHRW6hnvZ9N4UQu8GKfmpBS
         NA1XVwHXxwNh9n4n5pc3LeOBsn909TfM/7aZImXKoPf8KizPANfRW9hFnH0yZ4wvSKIT
         CGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWtxdTdbF0em7Ccg9U50QbhwTrZXZqloYKPrJw/dZqyRd9nyw9uunZu2BRpQCuyAMurvY9nuM843nuXrio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHp2PUho5D6mj8QiBmz2y08NrRXi+/qHgg8DJJ+IBrlN4LZlXc
	IKhTL6chmfdH8sS+ohRfOGl8/+L3UMaSGQALX5ZsW0wUQD4gvHXkgRpLkbtWAYw=
X-Google-Smtp-Source: AGHT+IGu3TDU8L1KStejfuYJBVuEylGK40m2V5OVnQro6QhzeL116r5dXj/B0Cx8EzLWOpT+s4jv2Q==
X-Received: by 2002:a05:6402:268d:b0:5c2:6a73:d13b with SMTP id 4fb4d7f45d1cf-5c26a73d3c7mr5679631a12.34.1725446053854;
        Wed, 04 Sep 2024 03:34:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c2455908eesm5264270a12.55.2024.09.04.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:34:13 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:34:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v8 31/35] printk: nbcon: Implement emergency
 sections
Message-ID: <Ztg3pFoYERN4GuWf@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-32-john.ogness@linutronix.de>
 <87plpum4jw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plpum4jw.fsf@jogness.linutronix.de>

On Tue 2024-08-27 16:25:31, John Ogness wrote:
> Hi Petr,
> 
> On 2024-08-20, John Ogness <john.ogness@linutronix.de> wrote:
> > +static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
> > +{
> > +	/*
> > +	 * The value of __printk_percpu_data_ready gets set in normal
> > +	 * context and before SMP initialization. As a result it could
> > +	 * never change while inside an nbcon emergency section.
> > +	 */
> > +	if (!printk_percpu_data_ready())
> > +		return &early_nbcon_pcpu_emergency_nesting;
> > +
> > +	/* Open code this_cpu_ptr() without checking migration. */
> > +	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
> > +}
> 
> It was pointed out to me that raw_cpu_ptr() exists exactly for this
> purpose. There is no need to open code it.

Good to know!

> ------------8<--------------
> >From fe50e9646c44360d88749c2c24c109405b27ad9e Mon Sep 17 00:00:00 2001
> From: John Ogness <john.ogness@linutronix.de>
> Date: Tue, 27 Aug 2024 14:06:19 +0000
> Subject: [PATCH] printk: nbcon: Use raw_cpu_ptr() instead of open coding
> 
> There is no need to open code a non-migration-checking
> this_cpu_ptr(). That is exactly what raw_cpu_ptr() is.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I wanted to avoid rebase when it was not really necessary. So, I have
committed the patch into printk/linux.git, branch rework/write_atomic
on top of the existing patches.

Best Regards,
Petr

