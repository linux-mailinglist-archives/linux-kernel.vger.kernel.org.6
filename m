Return-Path: <linux-kernel+bounces-535942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082CCA47989
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD35118915FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63F227EBF;
	Thu, 27 Feb 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xmztMTrP"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3665270024
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740649894; cv=none; b=MsFvISqoWif/qdL4F77sMWj8EPTVLH+YcRfOak7isfSm5dLZpHUMG/wEmz+2CbyJqy32MsfGdhHNPitbnMJtKEDYsA5ztpEqQ2XXEeyWHjI1kuVbzmPSVG6yKn0DDPzC4cF5HiHOmJb0WoVoHS9u4YZ7Dmy3RI0x34tqa6XAlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740649894; c=relaxed/simple;
	bh=nIdCJYwmuSe5QLt8/tDk5Es1wOqwuMzghxIYXnADvt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBvycB8SHal08MEMUs/UNBY8kOGV/YeCMzdYMMx0rQEUYQOTjKSh+a4NNwEawHVgm6fPHQGEs9ZkzJ77ThstSYtWYnDBwPGFevlns6eK8PqihyA9QxawYHhJnmEEis8a5Xgyk+qAmQvSQWMxVfFbPmF2C2mkzDMkNkbT3czmHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xmztMTrP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3091fecb637so6660211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740649891; x=1741254691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPTKCDlIl7OJpWbanUGrKwVYW5alvhhnOctJNOYGL3I=;
        b=xmztMTrPqstlTj4VF63nNxleMDLZJOzAf9y7fU/C17X826HvKNou+RxWM/Leq/YthS
         pSaobA2iHp8xbzl98vD2kDCK8E+IIcVQdwRtrz7gsBDsUitGcoXeMeQHVkvGQLVA0HrM
         Y42Vcypkowh4isqC1GZNUOzjwnGc1D0ZYljmEPAmSxst8h2+ANrW4WpOyzSQjdJ/SwV8
         g87ZNOlQsAft5ifNp+FYL0AIxE3y0LaCh2Kj2TiWCX7iDYNCJQDAW8Xc4/3uFPiaNO9t
         M3A7CYq78pbgRkdkd5XdHmUcI8u52gYscnhSJ4L9htYCu7s8j+Xt3NzC3jJtZgIYlPto
         46bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740649891; x=1741254691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPTKCDlIl7OJpWbanUGrKwVYW5alvhhnOctJNOYGL3I=;
        b=N9+x7q4DvY/QObH7pPAYZlA4tCv+UDkayM+iHzNJoX1U0Q0NM04JE1ZiC5CHnMH0/E
         mktU9xcFW/wNTCtgjEeqZMTHbWDLcaOluV4b2XF8FoclfdxyxJ3pgx+mVYXKjPivYvoE
         SWJnOrpt+kwIvZn76f6KytV3MJshoSlOlDLByiOE4cR1sIONYJROVOgx+l34luSOXVRC
         cGGt3o8qpjm2gbdFfzUZiZtB+iqJnSI9IbcNwc2z6deizBBDRWTiKYVvSmuNe2IeOCQp
         BBdCWxmyH2qQn++bIQoyV429uLxUKCM2tf/owcWJ2q9NHXXFpmJEXgRTjpwZoJGcidy2
         UlqA==
X-Forwarded-Encrypted: i=1; AJvYcCWKd98Nn/a7ZpT/dDDmbjR3Ek2SQQ90vIFOwxsh73IjbdHIfKmPCnjTtJr1Iz6bfE6NBjdWbvp5MzzRTb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOQaSAjMOSXqZRzaLXZlx9o1fnsiZZwvabJEn19ZaDf4+VgNo
	g7ya00i7NHsvG/9pBkjD0OTYOEYJEFv4jKLPp3JJ0jNyNdkiEV/t95V33wF+YvOoAdqTrnOQMsh
	nSIQyw1UQr+Xxa3iSVrdzxDQ4BIepTFDXyNBf4g==
X-Gm-Gg: ASbGncsTq7iBV1DwOB0/LGph+EQ5XwEwiDDNeKEpX4A8zhv2pZ0YWNUu/9IJ1tES9Y9
	anbldvzinoTA8AO98jU3hVWHSNWRGpmrlZyXliApnGad0oHEPj8uCkleQyWE1MHNMUhtIbektDs
	5gU/Hdhx+kxPSVl+KGnjDEDS44dpFEjCShZ3SpQ5g=
X-Google-Smtp-Source: AGHT+IHV94SNADU7TM0uXP0JNqa+v7Y/6UlvILj/sEpRtNH+X9zo9+97/YsgMeUyVxKY1oza4xTRi3YQuEbXYQdK8Hg=
X-Received: by 2002:a2e:8748:0:b0:308:ec9d:d9c3 with SMTP id
 38308e7fff4ca-30a80c69428mr59844531fa.26.1740649890993; Thu, 27 Feb 2025
 01:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224143134.3024598-1-koichiro.den@canonical.com> <20250224143134.3024598-2-koichiro.den@canonical.com>
In-Reply-To: <20250224143134.3024598-2-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Feb 2025 10:51:20 +0100
X-Gm-Features: AQ5f1Jr-SH-EZfbLqCfhrIpSm7vW10gLX-r5qO1PN-AmJ0AgvQUuhvPoXa45nGc
Message-ID: <CAMRc=MegKxwX-RjQQcWMGe_JQyRCv82WRRbD0naYkeXshTGXGQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] gpio: aggregator: protect driver attr handlers
 against module unload
To: Koichiro Den <koichiro.den@canonical.com>, geert+renesas@glider.be
Cc: linux-gpio@vger.kernel.org, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> Both new_device_store and delete_device_store touch module global
> resources (e.g. gpio_aggregator_lock). To prevent race conditions with
> module unload, a reference needs to be held.
>
> Add try_module_get() in these handlers.
>
> For new_device_store, this eliminates what appears to be the most dangero=
us
> scenario: if an id is allocated from gpio_aggregator_idr but
> platform_device_register has not yet been called or completed, a concurre=
nt
> module unload could fail to unregister/delete the device, leaving behind =
a
> dangling platform device/GPIO forwarder. This can result in various issue=
s.
> The following simple reproducer demonstrates these problems:
>
>   #!/bin/bash
>   while :; do
>     # note: whether 'gpiochip0 0' exists or not does not matter.
>     echo 'gpiochip0 0' > /sys/bus/platform/drivers/gpio-aggregator/new_de=
vice
>   done &
>   while :; do
>     modprobe gpio-aggregator
>     modprobe -r gpio-aggregator
>   done &
>   wait
>
>   Starting with the following warning, several kinds of warnings will app=
ear
>   and the system may become unstable:
>
>   ------------[ cut here ]------------
>   list_del corruption, ffff888103e2e980->next is LIST_POISON1 (dead000000=
000100)
>   WARNING: CPU: 1 PID: 1327 at lib/list_debug.c:56 __list_del_entry_valid=
_or_report+0xa3/0x120
>   [...]
>   RIP: 0010:__list_del_entry_valid_or_report+0xa3/0x120
>   [...]
>   Call Trace:
>    <TASK>
>    ? __list_del_entry_valid_or_report+0xa3/0x120
>    ? __warn.cold+0x93/0xf2
>    ? __list_del_entry_valid_or_report+0xa3/0x120
>    ? report_bug+0xe6/0x170
>    ? __irq_work_queue_local+0x39/0xe0
>    ? handle_bug+0x58/0x90
>    ? exc_invalid_op+0x13/0x60
>    ? asm_exc_invalid_op+0x16/0x20
>    ? __list_del_entry_valid_or_report+0xa3/0x120
>    gpiod_remove_lookup_table+0x22/0x60
>    new_device_store+0x315/0x350 [gpio_aggregator]
>    kernfs_fop_write_iter+0x137/0x1f0
>    vfs_write+0x262/0x430
>    ksys_write+0x60/0xd0
>    do_syscall_64+0x6c/0x180
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    [...]
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>
> Fixes: 828546e24280 ("gpio: Add GPIO Aggregator")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Geert, does this look good to you? I'd like to send this fix upstream
first and backport it to stable.

Bartosz

