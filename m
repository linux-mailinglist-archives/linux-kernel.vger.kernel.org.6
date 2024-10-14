Return-Path: <linux-kernel+bounces-363433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE899C261
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908AB1F21032
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660715624D;
	Mon, 14 Oct 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yW7oWpZA"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF51155A34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892763; cv=none; b=e4N0ah9El5lfOpy40pocOxN4bLNRDcaZp1XQVkvm3aGaWuiq1enG3jfM42fo0FH7WF/PGpZEEjC/YacX0VUrw0paw8CfZYx9UWQjq5NqPE3LoBx9UhqoQBZWOyVEPZJdhXMyP3ZUDcsrk6Wjv8MfQs23Kmc1jjpdMb0+HeQfqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892763; c=relaxed/simple;
	bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhHebfllF2LYg9li9ckGdkJbp1QadUZ63uwTF9/fc27jSz2k8NzPOhTl6WGQfqc7o0OmvjFIcpxt2dNeBvqoAWUa4ZNQjpyBI4rcbeFb09r+Ix3rUeCctw4fQvO8IOnwHSrCM+HHQiMtAD5NmldAAmgZ3Tk2MXrtJ2UnROn83RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yW7oWpZA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f84907caso577016e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728892759; x=1729497559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
        b=yW7oWpZA3BTF2qLluR9yNKl8wmcaBX1Ca0r0VcsJjz8TMfs1Q9ltSdkFdoGa0n0gZg
         9vz175ulwvN72ljFMjlXE8Bda7Aq4wDL9T7c5J6rwm35psM+brYjcdbDnERepfTa76V/
         F8QGNrShmfHd4tak/31zRJl7xsCjwl4y3Zm4TS1tLYK5lyLqTAUNRDf29LzLQ/kP1lJv
         D6n53Zv3bAKKSjwrY7AQoH1R6r7ofISZ17sdk8Gux7jvb+M57yd5zH/SeWjbaierGyFG
         DHSpZWXtskUg2d9ZgVE2Atis6F/5bFru7s31ew8AijdX0+ATXXx2TaYS41AhF39aNNjE
         sWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892759; x=1729497559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
        b=hFWVDfWrYWpePV8T7oB8jPiVvyD5TInKKrSwfjW+oUEuYuo5sSwpKIpJR2BYKtlFpA
         PfiDUo6ZAtsbnfSvLZCuqCmLqC532+Q0HHOwJnZm75xpBJzogjWhnJISkp+r+bcuKD9c
         tl8G5K5HFZZQOS++KP75+xorskOzCrCF1IeqKSfyFdrhmG25cLWWpGskyf4QMS6qAqjP
         6uYcy2qEGakyQGDKcvxKTyijaHG7Ip2ciw9zpLPWCG9jO23lRyDPNsH98lZHI0iTt69f
         P6vhNDXhX5LEGcqv85T9bHsjOSGC6r/gj/CMMcH88rPGmPeBTIVA5hCJszg52pRi6fMH
         6qMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXolyfdvLSJcUN5xPe2mdTBIYj4t7b2xRQl1QtFx4suUZPbwo+OQziTpR0LRHv3bMg+eDOQsp/x/d4qvlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrNqUt1OYDNkyiJrpteNxi3dQp1uu+oo5Llf0ln/bJrhCc6GB
	tpA0A+gU8ZdWUYU1GcB9plN0v1GIcrTyN5XNyOTbFG9Pvkv+sj2riBVv9IjZWyXCTNxaB3QoTVr
	+JCH/nhroPlXgTR0YmQxvTz9zze8rj+ijBNPIKw==
X-Google-Smtp-Source: AGHT+IEpWHvzePip2AbpOZrDDoOTlWCLBCnZZjhQ7Blogjf+ZP6Ifrw41m8GkUv9NHZszflLIk7m6dG7ATFP47hYxNQ=
X-Received: by 2002:a05:6512:3a8d:b0:52e:76d5:9504 with SMTP id
 2adb3069b0e04-539da3be550mr5304615e87.3.1728892759031; Mon, 14 Oct 2024
 00:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014075329.10400-1-pstanner@redhat.com> <20241014075329.10400-5-pstanner@redhat.com>
In-Reply-To: <20241014075329.10400-5-pstanner@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:59:08 +0200
Message-ID: <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keith Busch <kbusch@kernel.org>, Li Zetao <lizetao1@huawei.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:53=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace those functions with calls to pcim_iomap_region().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

This is part of a larger series so I acked it previously but at second
glance it doesn't look like it depends on anything that comes before?
Should it have been sent separately to the GPIO tree? Should I pick it
up independently?

Bart

