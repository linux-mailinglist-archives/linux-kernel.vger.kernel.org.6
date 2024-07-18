Return-Path: <linux-kernel+bounces-256810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FA9370B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630261C219AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC124145A0A;
	Thu, 18 Jul 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BUyX0VUH"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798480C07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342121; cv=none; b=qCppa3Ok9Kt2aUfI4wrGRy/bRgJWFTBUTuOB5A521Z+QU1eJMJ2ZzSAERYPiaNPU1ntWzqB2VY4ZSlCMbacBsRdsKCBz3swXNpkMJfIP8w9cwBHhPVSK+58WwI24MqH9MGwT1R8GhPE+xamb7vPPxeGIacqb8gZkRT9tjTPcOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342121; c=relaxed/simple;
	bh=uBrVziKrh9wuW7qZktms0c2SGtYTIAf+915rwmXJe3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyEM+EVZatmM/mG7Jclvw/dPIvZljDTjgeylvofbztFTQr0AgH2SOMJidgrwXmASO6IyTqkPuMfas7HvUIMquUQjgAzh2P9FMIl6a5dvdqSZHiwrkzI4Y6OdNSR9v13xRbxH/2U7i1kYglVjKbS/ibTjzE+N83OLAP2xAi4DucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BUyX0VUH; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-807007b8dd1so52912539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721342119; x=1721946919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHed+P96itcIQNzLtbTOuPRqeg9F31qpRuhm4M1r37w=;
        b=BUyX0VUHv4e3+msQmonB5kA6JgwKFqACMjMRKZrnfcYYmocq9p5wjlYBHkrqFIobgZ
         V6jzJUX3YW3+6EkBcRk+rhzdkpm60cjUrhk8pIuLCza51OxLExoaK7vh32YF8HN5Lo9x
         06/AGuJUGhlGjfPYBAnyUwd6nsOSKt3NpP6gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721342119; x=1721946919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHed+P96itcIQNzLtbTOuPRqeg9F31qpRuhm4M1r37w=;
        b=Np+VFcQUgIniJL1UIa3V6HNCFsdhJVePFAYS9oLVm2Hud84Bqn98Lh6kDhRsfqEcMH
         v88vPkc5ltDbAUWaHHI8jUTIdbS8vsKaqMWe6N4jV/YHbe+1SGuHELIv1tHe/JqmvxaD
         YZtattDwMhaYzKh11+Wvwx1CmeK9WW2ty9whcYWfzcsxu5G9p+tCzJsp+8cMHvm2pRsz
         6cO/nWFn7knJv2PARUEfSO0zZopr5lsfZu1cuuZ0Rya0ZDdXZEQ4ItAEzMwJwvNgXwbH
         /0ZBpW5YW/TH0NBKJqIlwnq12u8kL5mtwqNeadhayLb78jIjpAJooT3p+sJnSB1FmexA
         EaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJc8NtUe56FXB7wcnxb/Nu2Sqayi4WvvAJ+ghxGFXOkZ+cVzptj31TP/c02W/vo6Hvz5BhteG4sj3e4y3BX0snSN8XQns258ooqwAQ
X-Gm-Message-State: AOJu0YzZKLBMCqy+OG7h9zBQmIc8FWz39YbX/U2YVct9K1iYiwqll5ZY
	QgQCZt8sqQCjwyAFqmleepxs7jrA3RBwX2NqE+4clNkpDmDnFox0tSInn992wA==
X-Google-Smtp-Source: AGHT+IE7ztAOpPJbMaHRiLmD4M8ceQs8LFBUXdW3Xk37Ryv3IBx0w2NCY6VQZzcxRrDl/CCuXvvQSw==
X-Received: by 2002:a05:6602:6d86:b0:7ff:cec0:2985 with SMTP id ca18e2360f4ac-81711e17e2bmr905711639f.13.1721342118602;
        Thu, 18 Jul 2024 15:35:18 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-819aba11fd4sm6868639f.4.2024.07.18.15.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:35:18 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:35:17 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco@wolfvision.net,
	benjamin.bara@skidata.com, macpaul.lin@mediatek.com,
	linux.amoon@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v2 1/2] usb: misc: onboard_dev: extend platform data to
 add power on delay field
Message-ID: <ZpmYpQepfSZDaPew@google.com>
References: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1721244223-3194869-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1721244223-3194869-2-git-send-email-radhey.shyam.pandey@amd.com>

On Thu, Jul 18, 2024 at 12:53:42AM +0530, Radhey Shyam Pandey wrote:
> Introduce dedicated field 'power_on_delay_us' in onboard platform data
> and update its delay for USB5744 configuration. Hub itself requires some
> delay after reset to get to state where configuration data is going to
> be accepted. Without delay upcoming support for configuration via SMBUS
> is reporting a failure on the first SMBus write.
> 
> i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed
> 
> Similar delay is likely also required for default configuration but
> because there is enough time (code execution) between reset and usage
> of the hub any issue is not visible but it doesn't mean delay shouldn't
> be reflected.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Suggested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes for v2:
> - New patch
> ---
>  drivers/usb/misc/onboard_usb_dev.c | 1 +
>  drivers/usb/misc/onboard_usb_dev.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> index f2bcc1a8b95f..94d5424841fd 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -98,6 +98,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
>  
>  	fsleep(onboard_dev->pdata->reset_us);
>  	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
> +	fsleep(onboard_dev->pdata->power_on_delay_us);
>  
>  	onboard_dev->is_powered_on = true;
>  
> diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
> index fbba549c0f47..82c76a0b3346 100644
> --- a/drivers/usb/misc/onboard_usb_dev.h
> +++ b/drivers/usb/misc/onboard_usb_dev.h
> @@ -10,6 +10,7 @@
>  
>  struct onboard_dev_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
> +	unsigned long power_on_delay_us; /* power on pulse width in us */

nit: it isn't really a pulse width, just a simple delay.

>  	unsigned int num_supplies;	/* number of supplies */
>  	const char * const supply_names[MAX_SUPPLIES];
>  	bool is_hub;
> @@ -24,6 +25,7 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
>  
>  static const struct onboard_dev_pdata microchip_usb5744_data = {
>  	.reset_us = 0,
> +	.power_on_delay_us = 10000,
>  	.num_supplies = 2,
>  	.supply_names = { "vdd", "vdd2" },
>  	.is_hub = true,
> -- 
> 2.34.1
> 

