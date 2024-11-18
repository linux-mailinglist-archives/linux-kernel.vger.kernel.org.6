Return-Path: <linux-kernel+bounces-413157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FD9D144D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5420D1F2207A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B11AE875;
	Mon, 18 Nov 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IhW34m+f"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7201AA1C5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943205; cv=none; b=UHp/M5J6Ghtzo6Z4dAudLCQ+LJXjZiZDxoMRxy2Xi19yPqVF6JYMbjXFmhydSiKw9CtNPaTr7Kc93JKRqJ1fqg7EETDAW55NE/shTVFzlT2iWZ/OHgqawjK0SFtNEle+qxrgEQpATBasqySVP0XI3uMnm3fwW3R+K9g20ZO9vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943205; c=relaxed/simple;
	bh=/8N7G1LGIf2kwW/o/tASz8OeeJYsPdurJirv7h6ggbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPnHFIcg0chbmv+c84BTN8X1m+f+3JvubqoQjJoLt/QSj0fGGwLf9gXvnCBRkNnhpOrl3Bz1SGY3Os3OkSKeEzk7sMWjNY3pA4v0IhF3Oj2HK8BRL1lw31hF3uBngqOaiLfKC/Wz9I+/6dgHuaJSOtcgVPrme1LcJlV/J7YFgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IhW34m+f; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382026ba43eso2699583f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731943201; x=1732548001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bO7a20ZjW6t4mhdM7n1pAeRm1m0R6IPvHl5SqBK9cpM=;
        b=IhW34m+f/mt+ktlLgPDBZbaAOoew/8I6DIVBmlPTPxFO95cYt+SqXb+GUVWRtvwq8Z
         XXFKXT9eaUV9vHgwjZgkR4hOzl6TOUW436YRyiSisAeg6w/hvl561EcgSXxEn69GdXND
         NfWFLoq+jNMFhvoNLBOTAW7v/f/vGrVizsOm6wmGQs78JGZYNPrXLGV1jY6bqxDrp8Lu
         /5vmygjFV811OI79aBZcXek2U6QNUiggbOnEjApaK2ZCCLtvRZ+jW4IFbNb1M/F/lFWS
         0TSjhJed38WuP6ZDQm4dH+PaVrCblbZYtf714tpk2vaURKHDMG1ZeCuFdDtOJRPe1qhC
         HDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943201; x=1732548001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO7a20ZjW6t4mhdM7n1pAeRm1m0R6IPvHl5SqBK9cpM=;
        b=DNtH7+GpQnAFzBBq10L0yTeL8gTOUcJhj3B62ReMW0Hib5M/l+4iTJ3jbmjK6sZFv0
         klx2HZq/5g0UdGrNY4vrSenAObho4LRj7cGCCZqWzaR38nxiqSgwHhjryNWgwBNGH85f
         um5SfXs251T9QWOpkjMco1C7TopGPnRd2YR46FESOt7sZz0pjzCCZimuYFFRxoTpF5KK
         709Pr0Xiv7kQ4NGwnn2cCI71p3ZIlO0hYtB7qp9z6tKuhcPISqp/1Qo34AS+vbO89HYt
         NeblDFlGUC6aabLrbwdp4dMZCJWHC2NVuTct/1x6QXMN5zj7hthBmbpddmjhBS9qKqWf
         fvhA==
X-Gm-Message-State: AOJu0YyvNwkXb99udQiPbUco3LvasG7iVIZrT2LGV3SFO1Sa4O/X79SB
	X6MdYL9SQJ/FEuA05odBnyBnokLOOXv4CM5HosBQkKS946yE/pQs+/kEh4IEh/Q=
X-Google-Smtp-Source: AGHT+IHeOtr1o8whI0XBVWRpAUpDFR2h4NEYvMu7h66Jpqioq14woKarCM8IE+8e4XvE5o1qJg9jpQ==
X-Received: by 2002:a05:6000:1ac5:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-38231a18dcamr7116321f8f.35.1731943201054;
        Mon, 18 Nov 2024 07:20:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824a8109a7sm1617726f8f.104.2024.11.18.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:20:00 -0800 (PST)
Date: Mon, 18 Nov 2024 16:19:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: register_device: was: Re: [PATCH v6 06/11] printk: console:
 Introduce sysfs interface for per-console loglevels
Message-ID: <ZztbHhHc14kqz0Dc@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <ZzTM04qQXOg2RsOa@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTM04qQXOg2RsOa@pathway.suse.cz>

On Wed 2024-11-13 16:59:17, Petr Mladek wrote:
> > A sysfs interface under /sys/class/console/ is created that permits
> > viewing and configuring per-console attributes. This is the main
> > interface with which we expect users to interact with and configure
> > per-console loglevels.
> 
> > diff --git a/kernel/printk/sysfs.c b/kernel/printk/sysfs.c
> > new file mode 100644
> > index 000000000000..e24590074861
> > --- /dev/null
> > +++ b/kernel/printk/sysfs.c
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
> > +		return;
> > +
> > +	if (WARN_ON(con->classdev))
> > +		return;
> > +
> > +	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
> > +	if (!con->classdev)
> > +		return;
> > +
> > +	device_initialize(con->classdev);
> > +	dev_set_name(con->classdev, "%s%d", con->name, con->index);
> > +	dev_set_drvdata(con->classdev, con);
> > +	con->classdev->release = console_classdev_release;
> > +	con->classdev->class = console_class;
> > +	if (device_add(con->classdev))
> > +		put_device(con->classdev);
> 
> Honestly, I am not sure how to review this. I am not familiar with
> these APIs. I have spent few hours trying to investigate various
> drivers but I did not find any similar use case. I tried to look
> for documentation but I did not find any good HOWTO.

BTW: When investigating other users of these APIs, I saw
a use of pm_runtime_no_callbacks() in

static int i2c_register_adapter(struct i2c_adapter *adap)
{
	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
[...]
	device_initialize(&adap->dev);
[...]
	/*
	 * This adapter can be used as a parent immediately after device_add(),
	 * setup runtime-pm (especially ignore-children) before hand.
	 */
	device_enable_async_suspend(&adap->dev);
	pm_runtime_no_callbacks(&adap->dev);

It removed part of the sysfs interface in the power subdirectory.

It might make sense to use this for the console devices as well.
If I get it correctly then the newly added struct device in
struct console can't affect the power management of the underlying
HW device.

Best Regards,
Petr

