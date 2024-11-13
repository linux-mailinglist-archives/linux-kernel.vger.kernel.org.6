Return-Path: <linux-kernel+bounces-407964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EA9C7977
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E686AB2D5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A161586CB;
	Wed, 13 Nov 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPYDmsoy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74728156C5F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513561; cv=none; b=Ij6CViIyeu7m3T5H504bvWcp81XesFl9LYidYSGqDsiKXJBUtJl+Y+4VV66eWoBE3MfyP93w33NKHwXg7GezyTUsJchrCTXAI1kpeRk503STahQzJIJIwMzlmznWV+cOz/ePoEXYImCDDU+6kp8dNz2u45HQPO0fNQAgMxJ4c90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513561; c=relaxed/simple;
	bh=AubKqEIlyx+TnbDxU/5gR1LMWuRmYxVvtetJ5krokC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWRIBRmDjE/9RSFjZtoAZ4dUboNMAw1aSduisoZICtxwQign7WGhh/SoDqN5e3UmNUhQ4HH3sZxt/b4vjRYD0dDAYhvSTnolp2WtmBrlk4R/NGGNMnGTVFlxHbyQQLYu+KFmU8RjQRY8ybQu9jwXcE7a7RpIJUdFD3lvg+EJpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPYDmsoy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315abed18aso60682845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731513558; x=1732118358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OP2jHPolkA60IHwRUFOeCcmip167g9Fn3A0uTf1j6qM=;
        b=UPYDmsoyfzGm4azW5zN0fIFqDoTIdShkdVZ0xQWvAtHPQRR2kOq+nCXzdaK7O5ulnu
         EId9vYFJcvVCRwAjFIcaok7Nq3+ip9+VqI9JVgqA7VPv8rR95Hn8tqkUNRQwQezX+nzJ
         f6nD2QMM5HqdZDI2Sb4RVqNvWyv7p4w7Zb+IaEQ3CgxtbqVXG4S3oWQWOlwqUn4oYFOE
         EnvDIt/4JEfwCnBoWu6G9G+wjC2oYxvrp6oPPUry1Lrq/QwdfkLneRyFnQmGkB/JxP46
         f/SUSs15jOon5wCIe9X1kgLj8jIlPNVFaVqqlpoXAeZZBa6acbeJZfZojtX39lU8twVD
         ng9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513558; x=1732118358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP2jHPolkA60IHwRUFOeCcmip167g9Fn3A0uTf1j6qM=;
        b=mnxybFGtnOdn/5cYfCHb3OIW30he3iWtqb4miukBEQdpoa2PthAJgYutFnVo7R6fsS
         DJodsCz5qMyFZlYRvjmC/aIQuvHNYnpA0uXr6ccpdN2+QL2JtbEI/+gF2uiErhD8bXGL
         OjIXColjii2JJV9tZfGjxl9BOrm8HIphj5qYKghaedW8KDeiL+AHwEZ6BiSTnQ4xL8ZV
         S9RMsi3GK+LtZ0CgoDix9D656r/Z1OQw4W38fx2mjtYED24aIsytR/OdJu8ByI4HpxJx
         l+1fk00bSVrGBwqpGn/f4fAImorwqhvmQAv7PvEQRZjaVi4vTeTvu3v3kKnVWsTJqw3W
         BHhQ==
X-Gm-Message-State: AOJu0YwLmXgzIfpO/fgEQtnpvEPkzsuzP5lAEBZenRRV0Ro5Ep/X3VJz
	MTpDS3+L67mR08UILbEu+ujcEQPHoeyWehfHkt7RdDrtHBSMdpDqh1Rpr+afB20=
X-Google-Smtp-Source: AGHT+IFb2OimMqpjE95mm3JqqnEb6gH2Ami4WFE/7CBkEofTXMeScTGZZv2LGnN0d4jZuaTip2quGQ==
X-Received: by 2002:a05:6000:1f87:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-381f186cbc9mr18022959f8f.29.1731513557721;
        Wed, 13 Nov 2024 07:59:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda051c6sm18544656f8f.99.2024.11.13.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:59:17 -0800 (PST)
Date: Wed, 13 Nov 2024 16:59:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: register_device: was: Re: [PATCH v6 06/11] printk: console:
 Introduce sysfs interface for per-console loglevels
Message-ID: <ZzTM04qQXOg2RsOa@pathway.suse.cz>
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

> A sysfs interface under /sys/class/console/ is created that permits
> viewing and configuring per-console attributes. This is the main
> interface with which we expect users to interact with and configure
> per-console loglevels.

> diff --git a/kernel/printk/sysfs.c b/kernel/printk/sysfs.c
> new file mode 100644
> index 000000000000..e24590074861
> --- /dev/null
> +++ b/kernel/printk/sysfs.c
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
> +		return;
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

Honestly, I am not sure how to review this. I am not familiar with
these APIs. I have spent few hours trying to investigate various
drivers but I did not find any similar use case. I tried to look
for documentation but I did not find any good HOWTO.

It seems to work but it is the only thing that I could
say about it ;-)

Just by chance, do you have any pointers into a code or
documentation which could help me to feel more comfortable?

> +}
> +

Best Regards,
Petr

