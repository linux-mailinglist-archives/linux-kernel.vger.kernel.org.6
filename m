Return-Path: <linux-kernel+bounces-536350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D20A47E76
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3C188BCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195822CBF9;
	Thu, 27 Feb 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJIDkf8H"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF841DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661466; cv=none; b=aLGT8mgnVqjUx9DZzgTENJ3WMKNokv7cpY9bXDki1LSfLY+lw7htuVfrsFSdu796PP+kWel7M6rjLV84twdyiKcwt3DnMF7paP7K1Umgn9PKckElPsJNRV7DS1BWaCAS2+W/rhU1L5OLeU1cdLcZKJxpOKPmacn0bx7pnuWi80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661466; c=relaxed/simple;
	bh=9kiQuA2m35ZE51KLo3D1I8ky3OfsGFbf1SjCVbpu2ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPm1b//Dx9dm2bFon2gjE3tbFeBZRauO1dEcsZrCcx626Xxj0RiynQgV56YdhZiFmwP7gbDyRQH/+3PwireSja/yb/ncL1c94Fr9PP6xsyTMiLecZIEXIr2Nz8jGKD6D8yShM1M1/RnEGjE9VIHq58ZCuMq4404q4uhBezCtWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OJIDkf8H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349dc31bcso14334005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740661464; x=1741266264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY3lPWTmNqZZsigW6fCcCa9W0h1dzQbk+JMMnksNz2M=;
        b=OJIDkf8HJwwlxc0hYo+oc3pO1XAvU9f7Iq3oP8ubj6Uv4LBziDafPXYaogOtvVhHQV
         cw1+tShZllK/cRvddPoXawOABvhX3Vp3vVcCZbQxvEUDn27jlpYMvw6R+9Cz5GxheuzR
         Q0jxfWgeW0G9dMGQtbJOrMZVryxXOCjfR/2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661464; x=1741266264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY3lPWTmNqZZsigW6fCcCa9W0h1dzQbk+JMMnksNz2M=;
        b=uwyTuz767cIowpz0nzn5vE7uV13WFIbXPETRicR4ch1AB3L8cWA27u373w0pXmGxL1
         09bxOBiWe58gpC5U7AvSNLrimTsZNmsdYFaotgHzrsI9EU0kJnhgJfk8iNNjSzkxg8nO
         TCDA1ADE0K1lIIylS7TLwwqm9ZOqgjqAlpnguxYOyA+PGdq/4W9TFiCUH5ZrQ9LFK4fg
         J6o1Puzb/CUy4CU/bp9Q25wODbjSGUgI9+rE+56zYUMm00pVBW8kp6uhc7JiP/Z4rFnw
         bcUn5/FlJT7d1qlkP0Aidz6uwn0WxLhmst8j9KjbdwZM0JzRtczAIQaAnxvW/hWpDwlj
         n0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO7WX/QH4Lgcgy/PbJd3RhvG81zTySAEqvIIRsSEZiUPnk8gSJHEuIG58LBwXy2oQpX4RugEHsUXX3kUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpV9a1Z3aThzlwGxvy3jeToQHklEXmBq7TdAbsnYBkZpoYhCwS
	k9vTq+4qqYIbwGQ/npfwNogCswvVosDhditnEf98GBaJYBxRHu+8m35tUJN8e3ZPkfFjW4a+hmg
	=
X-Gm-Gg: ASbGncvMNie5k2mNceHSjruTIJaeDKk/zrqRjcr0NkIZTEEnJT/6QTvn+3yxIACba1L
	fXMh2dfxFUh635MCKmAL/Ag8/9rFXQPl8G+4cL1L6p6gtuw0pNzF7ScPJTqvC/rVkPUxW3qXVig
	OiPSJXRykjNrzzV5C9X+KX6C0QdWq25OkUJHAXDMnIvteFeq8U9/x4xks5AG96bzp7Umlu3Dlbh
	y+MyTYfjqksdpIKzZRQuo9m8uWxOzGHxa2/xIuqOt7K0RuhwxWNMOEjfnh/snVYTFGoFsTCq9Iz
	fmOcU7zxPZgU30TXUdfuUVX7+062wA==
X-Google-Smtp-Source: AGHT+IFNvd0ElV4B1D48R80ma4vVr+h2GufsMAxOmLWTJtIzhmY2T9t1CiXv7N665sHiIvewZmOTJw==
X-Received: by 2002:a05:6a20:7286:b0:1ee:afa2:4e86 with SMTP id adf61e73a8af0-1eef5559342mr49520291637.28.1740661463832;
        Thu, 27 Feb 2025 05:04:23 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm1520971b3a.50.2025.02.27.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:04:23 -0800 (PST)
Date: Thu, 27 Feb 2025 22:04:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <mwpl64zfj4zlv5bwysfzryjpnh6lg5tridhya3t7ly2ax2vt7x@jhmdmh7gwrmn>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
 <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
 <20250227120532.OsZr4v2A@linutronix.de>
 <irpjhnu7utkhf4dds5ghklsbdug6nf32ulsp52ibvym6t3wqfg@pqu7w6uvgbvw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <irpjhnu7utkhf4dds5ghklsbdug6nf32ulsp52ibvym6t3wqfg@pqu7w6uvgbvw>

On (25/02/27 21:42), Sergey Senozhatsky wrote:
> > ach. Got it. What about
> > 
> > | static void zram_slot_lock_init(struct zram *zram, u32 index)
> > | {
> > | 	static struct lock_class_key __key;
> > | 
> > | 	lockdep_init_map(slot_dep_map(zram, index),
> > | 			 "zram->table[index].lock",
> > | 			 &__key, 0);
> > | }
> > 
> > So every lock coming from zram belongs to the same class. Otherwise each
> > lock coming from zram_slot_lock_init() would belong to a different class
> > and for lockdep it would look like they are different locks. But they
> > are used always in the same way.
> 
> I see.  I thought that they key was "shared" between zram meta table
> entries because the key is per-zram device, which sort of made sense
> (we can have different zram devices in a system - one swap, a bunch
> mounted with various file-systems on them).

So the lock class is registered dynamically for each zram device

zram_add()
	lockdep_register_key(&zram->lock_class);

and then we use that zram->lock_class to init zram->table entries.

We unregister the lock_class during each zram device destruction

zram_remove()
	lockdep_unregister_key(&zram->lock_class);

Does this still put zram->table entries into different lock classes?

