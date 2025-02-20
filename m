Return-Path: <linux-kernel+bounces-523768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B0A3DAEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B4B189C77D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7001F7910;
	Thu, 20 Feb 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nrPzNydB"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD811F76C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057010; cv=none; b=og6rXWGS9X29EowJXQl7M77JtY2l6ORylg3Y/BJ3hpmu/j3PXe/xeOw035rY30rjeIpDVBFXQDrsc1SZj65ip7PQF2OTu8RhzpXdB3oF66Zwh14AIsH68njqpnMo+hds3E98dl63BRyeilzsWPobH/SxoZCn+KgD0ra+EbTD4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057010; c=relaxed/simple;
	bh=OoFlg/wkEKxRqwkvakP/8WXxrSjDzVgjFkv67QkB3o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjSP8eQgRbpBq8A2oyNR0sumcy0+fL6a1Jk51ETkgC+/JqcVE78mO4TvBrVuECnTkZP+ELN95sPCTL1Q56VaWX3kjS6/7EvzJKINjdqq65Icq9TooMPkSJqJH6+s5ZgUsaupiS7/rPFbtKmhGwQozpMPgGkJQNhzp30d1ztCDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nrPzNydB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67BCB3F277
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740057001;
	bh=TDkw57RZdAj5KHZ7bxyyZ0R+TDLfczvy1Fi5CTCDaEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=nrPzNydBZgyAxzL0/e/kTK8olPL4D9S+V6/f/0xMZWN1286S0wbFjw5Ina4j0VqpD
	 hvdWuLUpid3K0j99uavJ/s6CpljCZds9mbTHN7Y1ShZXmCaKKW5bpSEOXjpCBjFYoC
	 r96f1yRtxKp7hTi4h20mRBMLpQ2iClhCVrUp8B9wKdPzf7kgYhWjXCyheh5+nQi8h0
	 fU6SFRlCbGWAo2CAPHoReSRpoJorkvxMSskUt4Iv8FxRTPwo6W+NgFSQfWTO51BfQa
	 OSeqqsj3wC+FWUTYHqKY/W7uWNwQIMdefOvBA+sH5jZjgCatqUsCPoVBxe8IDdmM/i
	 Sy5q7eHPb60gQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc46431885so2974206a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056999; x=1740661799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDkw57RZdAj5KHZ7bxyyZ0R+TDLfczvy1Fi5CTCDaEU=;
        b=Pg9TaHpw0uJ8fvodE8Eds0nCsDOclyGBLDDQvbS35boXgTGvmjEO/DwJO+zxeAFs69
         ZXrxQlGBkbmd+unLj40z/HvmJuacTWZLJh6+JRbF3C6zss9q7cyTsT3L/VbUjbQAZU3B
         vUx7LXV0qiJWeOtbLUsHUftUXXqyNCdUXCwvLDxTOveBO/jKoRoDF59l51Aqw28N9R49
         0lMngvFLylSJO67atSrKaj0Bg423IvYdCVmz4S64j//vKuj9yn3QM7R++LTYaigDsPZ1
         WX7DuUQBligjGFShMO/lMzFp6Ui77AOyVEnWmxRX0/GsYRa5MIHnxr9TDNJO4KV9LRrG
         961w==
X-Forwarded-Encrypted: i=1; AJvYcCUu0uBO++0fPiQkFDLQ3zP7ZIjP5LkVmLQjaWlYQSvTSlwUHiBl38APXgWiD+u10dPn8XkChSECydJanvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJhY3Y3tTOR4Q7+koa1NQ+QoDrdQbPdFqJ8Z5OKcxPjkoO6Zz
	EQohTleyzdBUjq7+R23ii2CCV6hJ2zehVYpC/plWinXMCrTgiRZAhra0L+2UuDk+ZureZ3Yg0qg
	X4svcm6s3CgWQ71hQCOfxSYSAeIc63G/b4I1dYsFlAgdf0elhxK1XXRBP2La+xOk8VgYjJLgxR/
	J7Kw==
X-Gm-Gg: ASbGnct91K5dzdehTGNBbJExi3NTI2QEAL8qFZX8NBzyVDg2DLZIEVEoGJeMgm1h/14
	CeK2Je509+Gat0L/FTvxrzWIVfOhf1egy298ORr7eWvy5s/+zLhUG3iS/1EwOIO6WbpYXl7YqTD
	6HClylCY+RLPBzIImbyNCqQYkFQJrjizuMa4AI6SgiwQtWAH79GS0mXJtIlrxemPYsD/EnIhOjH
	rxXA0bxmdSp3zIeYM8ilP78NOsxdZHAkukqcQievNGMe1c0a1b5NCuwQ+hDJUxYpeTzZKV876Sb
	WaT+Rm0=
X-Received: by 2002:a05:6a21:6004:b0:1ee:e4f0:62a with SMTP id adf61e73a8af0-1eee4f008a3mr5085211637.20.1740056999406;
        Thu, 20 Feb 2025 05:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvByjuePrsVHk8y766/+TCh6MsNT6Fs9sPnsreg1VEb5YOiXGj9/bDc37i57PPPNYm+t+Nvw==
X-Received: by 2002:a05:6a21:6004:b0:1ee:e4f0:62a with SMTP id adf61e73a8af0-1eee4f008a3mr5085179637.20.1740056999115;
        Thu, 20 Feb 2025 05:09:59 -0800 (PST)
Received: from localhost ([240f:74:7be:1:256c:5029:b967:ebb0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5813a687sm10818259a12.20.2025.02.20.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:09:58 -0800 (PST)
Date: Thu, 20 Feb 2025 22:09:55 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gpio: sim: convert to use dev-sync-probe utilities
Message-ID: <w6qjqr2uccbli4nejka2z7dusjcyrdqklda6au7qqkesubmfgb@hspgx2zmru3p>
References: <20250218160333.605829-1-koichiro.den@canonical.com>
 <20250218160333.605829-3-koichiro.den@canonical.com>
 <CAMRc=Mc5XfcQPsw1K70ogT6Oyxhy=PJ8neHT9xA8wrZmk069eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc5XfcQPsw1K70ogT6Oyxhy=PJ8neHT9xA8wrZmk069eQ@mail.gmail.com>

On Thu, Feb 20, 2025 at 12:08:18PM GMT, Bartosz Golaszewski wrote:
> On Tue, Feb 18, 2025 at 5:04 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > Update gpio-sim to use the new dev-sync-probe helper functions for
> > synchronized platform device creation, reducing code duplication.
> >
> > No functional change.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  drivers/gpio/Kconfig    |  2 +
> >  drivers/gpio/gpio-sim.c | 84 ++++++-----------------------------------
> >  2 files changed, 14 insertions(+), 72 deletions(-)
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 2e4c5f0a94f7..ba06f052b9ea 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -1866,6 +1866,7 @@ endmenu
> >  # This symbol is selected by drivers that need synchronous fake device creation
> >  config DEV_SYNC_PROBE
> >         tristate "Utilities for synchronous fake device creation"
> > +       depends on GPIO_SIM
> 
> No, it does not. Please drop this.

I'll hide the config as you pointed out, and drop this while at it. Thanks.

> 
> >         help
> >           Common helper functions for drivers that need synchronous fake
> >           device creation.
> > @@ -1916,6 +1917,7 @@ config GPIO_SIM
> >         tristate "GPIO Simulator Module"
> >         select IRQ_SIM
> >         select CONFIGFS_FS
> > +       select DEV_SYNC_PROBE
> >         help
> >           This enables the GPIO simulator - a configfs-based GPIO testing
> >           driver.
> > diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> > index a086087ada17..d1cdea450937 100644
> > --- a/drivers/gpio/gpio-sim.c
> > +++ b/drivers/gpio/gpio-sim.c
> > @@ -10,7 +10,6 @@
> >  #include <linux/array_size.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/cleanup.h>
> > -#include <linux/completion.h>
> >  #include <linux/configfs.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > @@ -37,6 +36,8 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/types.h>
> >
> > +#include "dev-sync-probe.h"
> > +
> >  #define GPIO_SIM_NGPIO_MAX     1024
> >  #define GPIO_SIM_PROP_MAX      4 /* Max 3 properties + sentinel. */
> >  #define GPIO_SIM_NUM_ATTRS     3 /* value, pull and sentinel */
> > @@ -541,14 +542,9 @@ static struct platform_driver gpio_sim_driver = {
> >  };
> >
> >  struct gpio_sim_device {
> > +       struct dev_sync_probe_data data;
> 
> Maybe something more indicative of the purpose? probe_data? sync_probe_data?

Hm, right. I'll go with probe_data. Thanks!

> 
> Bart

