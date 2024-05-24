Return-Path: <linux-kernel+bounces-188176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AEA8CDEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF88286B51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7431FC4;
	Fri, 24 May 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c0PNkwvg"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561936D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716510315; cv=none; b=qz1bW9cHE7BIqjzWM5/GJ/Dw7NZ5u22ybMI9e2mWY6VviVhUf0SZpwnlMRsVdVC01q39X/ZdQZWXpN1nxi7K6ohCFQRC7hUbDoKrLIwG/g/YBdPz3urVLhOKRng8mO7gebahHjQWZsqBSaof7KgtTy/Jbg7Z55SqWKIhYM2021Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716510315; c=relaxed/simple;
	bh=U+XQqQjFGY0Dsnz1iYyMGSwZE5e64uigVIBpySGsOWQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnqZojKZZZADX6Kbc1PcYCw+WPBpIkbysP+7djCaGE1BXQyIPp/TpTmHQIAkYu/YlQ1N/KKk2jkoo5UVkIsjku/x3gFdrv4Hm4yXkvGSad8POjBe5hflTk6vfAYrf0FtJRFk7CxszH46d1XMfLOOUFbJ6YOj++gxK6fZ/mU99jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c0PNkwvg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794aa87af7cso13527385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716510312; x=1717115112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX2oAdiZue5vGuu38VdxDUrJ1eMtA33xvB1yO4Vm7T4=;
        b=c0PNkwvggpIrbWlbj9sRMJfNM2D47FdObwLX/tEWZIK+r57zbLqX2gMgJ579DDq1zm
         Yn2H0M3E4aw0yr4awUDYI02ixHDnQFpaspApbOmpY6C9Y97jN7M3FJkdoszkRku+3+tQ
         PeDFZjcrH5/BJb0/ARPOs5+/jKWMWvExoo0dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716510312; x=1717115112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX2oAdiZue5vGuu38VdxDUrJ1eMtA33xvB1yO4Vm7T4=;
        b=NsfcAIcn1xTQCQ+2iSzSmOeBMTvmGbQie60l+rYAPdTks7YA2Ycyj/XEL6j4lbf6u9
         GI4kz1DvjUxfjtJRqtZrjR98NjCVPLlFGrBOA0XsxU0u5nS/fcG1GnfHFBqcX6xhHkQc
         /68lrv9iJ1myHrPDeD8KLjVi1nDQcyIoDxbdu5l5wsRLpPZMZFRr7X2bZNSbSjCqtrqM
         uJ+62D16n027ncPvysVlNaetjjU3ygPvEgNORbBLk6xzfgtRw0RndYRsAsAduF8poMGs
         nC+V9TC7OozO1+uDOYWbNCixzpIulGHNWVu1LAnGNxLIqgYqlD4quoAADY+vfJqF0vtN
         08oA==
X-Forwarded-Encrypted: i=1; AJvYcCXp55l1AWH/rhkHooE8np6kYqGzXqCfjCo0EAbnF3N/fm8VIQprk+jRHJ05/FBR7/osnCBdMdbMKlM2s5ry+glaVfCKUyvXL0UN2EVo
X-Gm-Message-State: AOJu0Yx41iGJ2YcsBlVrJfBPGUWYRhHWP0IeJIjokb1DK5qSZweXpPkk
	5dCLN0utnBVx5Mjo7GVvrrN2CYxpGEFSx95JzVMQzepQrG1zpvMH9z58/0ckEtiFEfjH0durCo4
	003ftF4mn/8HkWzPz68qZ/ZJsJmWOkKUemVBp
X-Google-Smtp-Source: AGHT+IGFLK1p3SdN9AodStf+OL72IZFLq1VoeAAFc3OOdOka8ZwEhPtfLoJ456ZTTwjV8kUX6SQvIZZmMiHRGzOhlRc=
X-Received: by 2002:a05:620a:2952:b0:792:9a4b:dcd4 with SMTP id
 af79cd13be357-794ab09e87cmr96261885a.45.1716510312469; Thu, 23 May 2024
 17:25:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 May 2024 17:25:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240523162207.1.I2395e66cf70c6e67d774c56943825c289b9c13e4@changeid>
References: <20240523232216.3148367-1-dianders@chromium.org> <20240523162207.1.I2395e66cf70c6e67d774c56943825c289b9c13e4@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Thu, 23 May 2024 17:25:11 -0700
Message-ID: <CAE-0n51nBXsaubmtbUxPBsNDiNuOVa1hB9O0bihm8fpEhEDjRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: port: Don't block system suspend even if
 bytes are left to xmit
To: Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, 
	linux-arm-msm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Guanbing Huang <albanhuang@tencent.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2024-05-23 16:22:12)
> Recently, suspend testing on sc7180-trogdor based devices has started
> to sometimes fail with messages like this:
>
>   port a88000.serial:0.0: PM: calling pm_runtime_force_suspend+0x0/0xf8 @ 28934, parent: a88000.serial:0
>   port a88000.serial:0.0: PM: dpm_run_callback(): pm_runtime_force_suspend+0x0/0xf8 returns -16
>   port a88000.serial:0.0: PM: pm_runtime_force_suspend+0x0/0xf8 returned -16 after 33 usecs
>   port a88000.serial:0.0: PM: failed to suspend: error -16
>
> I could reproduce these problem by logging in via an agetty on the
> debug serial port (which was _not_ used for kernel console) and
> running:
>   cat /var/log/messages
> ...and then (via an SSH session) forcing a few suspend/resume cycles.
>
> Tracing through the code and doing some printf debugging shows that
> the -16 (-EBUSY) comes from the recently added
> serial_port_runtime_suspend().
>
> The idea of the serial_port_runtime_suspend() function is to prevent
> the port from being _runtime_ suspended if it still has bytes left to
> transmit. Having bytes left to transmit isn't a reason to block
> _system_ suspend, though.

Can you elaborate? I paused to think that maybe we would want to make
sure that everything that was transmitted had been transmitted but that
doesn't seem right because it's a problem for higher layers to solve,
e.g. serdev would want to make sure some sleep command sent over the
wire actually got sent.

> The DEFINE_RUNTIME_DEV_PM_OPS() used by the
> serial_port code means that the system suspend function will be
> pm_runtime_force_suspend(). In pm_runtime_force_suspend() we can see
> that before calling the runtime suspend function we'll call
> pm_runtime_disable(). This should be a reliable way to detect that
> we're called from system suspend and that we shouldn't look for
> busyness.
>
> Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still busy")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/serial_port.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> index 91a338d3cb34..b781227cc996 100644
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -64,6 +64,16 @@ static int serial_port_runtime_suspend(struct device *dev)
>         if (port->flags & UPF_DEAD)
>                 return 0;
>
> +       /*
> +        * We only want to check the busyness of the port if PM Runtime is
> +        * enabled. Specifically PM Runtime will be disabled by
> +        * pm_runtime_force_suspend() during system suspend and we don't want
> +        * to block system suspend even if there is data still left to
> +        * transmit. We only want to block regulator PM Runtime transitions.

s/regulator/regular/

Is this a typo? Also, why is "runtime" capitalized?

> +        */
> +       if (!pm_runtime_enabled(dev))
> +               return 0;

