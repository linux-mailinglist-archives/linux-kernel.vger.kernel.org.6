Return-Path: <linux-kernel+bounces-225027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43232912AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7281C216A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E015F3F0;
	Fri, 21 Jun 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BKvIC7q/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D28155740
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985549; cv=none; b=t7+hs5uNsR+i3BH3NWhjmNJkY0uFrPQyN9jpzYLakhduk+rAPoKlUVvRhKvpq7hdY/G2npnnAUQjuMxDkCiBCZepsrrO27dUwTnNM1g+hEjxEIfvOetzsCmbOr8PF4GD15lBb60qb+9CM1b1F5wTatNcLueEfAWjvks88L1RaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985549; c=relaxed/simple;
	bh=JcoGo90O9fpAyKRX8hSh/3ThrAHfXBfltV1hNBro2gE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj7cAPGGuw03arclCTqoEj8jIBrZLan5/bpC9ZqFmx6SffoY0AOR8AWb4aJnsa6pMIWzu3UNee3eiO6tQi5TbZbf9cZWI0IHeo8c1FPHzkHt/bxQR8UvmaODc1Jj7H2SKGZNxFBJDFaBxWr8e9cRrFugUMBiaaMrjvZ4ezwt060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BKvIC7q/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so25033981fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718985546; x=1719590346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCL4k6ytpJwF22chMBB6UsWYBToKnk1GvIqPZ1Dy/eo=;
        b=BKvIC7q/JelEXk9X0vCKkl6dsZOeYnBQYhAkY5VCdrr2/K7ktzghZB4zS/dgFd3vFw
         BrrpEIApEbmbCqU09R3Wrm3G9ho4wHb3GNYr7xJJu0riDdSX2rN0nAGa9iG2seGnvDrS
         DnCc5M2GCiiXvT5hhLYel3eXM/jMBDwRQXEeSThFzFtoVgY1ZWf3MndTGEpxDiA2BAl3
         3BYuN46eZSA1Z4QqAXz1H68a9Bq70BX9v4bl6ztflhjD2TyOx34taKgs/PU16KgD2UcL
         ONEDzr6S1Ml+LmUj/0lLkrRl41oa/o2IkDUA5RpQALHTXf+cYf0b5NzRXkQGx0HFDARi
         kvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985546; x=1719590346;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCL4k6ytpJwF22chMBB6UsWYBToKnk1GvIqPZ1Dy/eo=;
        b=nFYEoJkCqaW/CtPgVIR0pgkZU6yuNfh7h3SpDiDKtDjNsOMb4Wai/IzwpXhRSgBM0t
         qjgSPEg8VMHv0PbG3ahMQTg7ctQAZLHZDsTnANeXWOKr/6Gwp5eiXVFjPSCVF0YZVRym
         IxJKDNsrbyaVKkSCKgx2D1IS+NwJ6DJFWRU02+QZi25ZaV0duFLcTYZeeFUbl/hSczXS
         48rJBkYc5gxDZ0nXwe+X6aFe54UlvC4viOpAHPblvn1g82jil7qQXJlxyKqtyh60++z3
         v9/R9aqyUjg56sn46Z+252FTlYV6/XF3TKzfC3U4sQy3m+BaszTBa6T4Nso0mbNmK+uv
         Z3zg==
X-Forwarded-Encrypted: i=1; AJvYcCWaXnJvPmzfPEpYpq91xTmqi1tXnO0n7u9gzNt3+A2d4BBa5zCQTl001xmEdat71R5tBYPkxFiiyoUb8C/XjWTDEP+lqLG56d1lqCeR
X-Gm-Message-State: AOJu0YzlyEASF/1yx+MJpf+1ctDSe9CRJOHwF2d5T1TiqplaMGn0tqe6
	2yUNJPkieiCbvpR1iU1UJd85OOawT32PbmRipc7BCsfE9HIANeKVQSg9OxZQUUIYCzmMlt7k4bj
	LH3kXBnKRRjk78Q4TVBZp6uq0HsIzGY5y23qlCA==
X-Google-Smtp-Source: AGHT+IGS1dn+UVCepB7paIwbC5MDNTn6+BfUiAHRn/RdMz17uf/2wecgvNmTvB2WV8bld7kf/PLjBLdM/V26JEqv7Wg=
X-Received: by 2002:a2e:90d1:0:b0:2eb:d816:7a67 with SMTP id
 38308e7fff4ca-2ec3ce94159mr55087391fa.16.1718985546082; Fri, 21 Jun 2024
 08:59:06 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Jun 2024 11:59:05 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <87bk3unw33.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612115231.26703-1-brgl@bgdev.pl> <20240612115231.26703-2-brgl@bgdev.pl>
 <87bk3unw33.ffs@tglx>
Date: Fri, 21 Jun 2024 11:59:05 -0400
Message-ID: <CAMRc=MejZYpY=Nb60LJ63d3L9JK8zBj4154mpeLGsk+_=ZLwVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/irq_sim: add a notifier for irqchip events
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 17:40:00 +0200, Thomas Gleixner <tglx@linutronix.de> said:
> On Wed, Jun 12 2024 at 13:52, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Currently users of the interrupt simulator don't have any way of being
>> notified about interrupts from the simulated domain being requested or
>> released. This causes a problem for one of the users - the GPIO
>> simulator - which is unable to lock the pins as interrupts.
>>
>> Add a blocking notifier and provide interfaces to register with it, then
>> use it to notify users of the domain about interrupts being requested
>> and released while also leaving space for future extensions.
>
> Why a notifier?
>
> There is only one usage site per simulator domain. So there is no reason
> to have a notifier with handwaving about future extensions.
>
> The right thing to do is:
>
> typedef void (*irq_sim_cb_t)(irq_hw_number_t hwirq, bool request, void *data)
>
> struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> 					 unsigned int num_irqs,
>                                          irq_sim_cb_t *cb, void *cb_data);
>
> You get the idea, right?
>


If you're opposed to the notifier, can we at least make it somewhat
future-proof and more elegant with the following?

struct irq_sim_ops {
	int (*irq_sim_irq_requested)(irq_hw_number_t hwirq , void *data);
	int (*irq_sim_irq_released)(irq_hw_number_t hwirq, void *data);
};

struct irq_domain *irq_domain_create_sim_ext(struct fwnode_handle *fwnode,
					     unsigned int num_irqs,
					     const struct irq_sim_ops *ops,
					     void *data);

This way we don't have to change the other call-site over at IIO at all nor
will need to change the prototype for irq_domain_create_sim_ext() if another
callback is needed.

Bart

