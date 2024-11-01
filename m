Return-Path: <linux-kernel+bounces-392033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB89B8EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90091C231A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859FC15AAB6;
	Fri,  1 Nov 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYiBj1PW"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF01586F2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456307; cv=none; b=JfnMqhjVfupvw8b3mhgVtSoeeXHWvKuS53QOOZrfx8bYw/DT9ntcynEItKMRQJpQkAXBGwinNrR7HjrffdxaD0snywc0xFzFqp3YY0yv+Cep3A6N/G4qxt2k4wxoV+rlb4J2sHlSUZO8QuY50HDLkR95PyEhX7twTTIUMZy1EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456307; c=relaxed/simple;
	bh=ipFVqEBpiK2Tzcv4RDXc8uhuWXygpW0n551czX3pIZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4vFGUZ/nARo82bP18ubmykVYEEbzVhWrJtEUsCjXpKDRJ0GS3QTxKuxRyMLApRKCCBIc8IDtFJ6nK8f/P9VA4v1hpT/8vL7QDQVOuKXD5OQ9WIspRByIyWoFX/1PsdIbifZdGZkdVfdtxWK4sTYfgyfQrIr1dCGHXB/Pw2pRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYiBj1PW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso16581271fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730456304; x=1731061104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwxM/FjA9AksgVOtf8rzlVE3z9HPcVCwlrxiT5luSQU=;
        b=hYiBj1PWL29b9C0pVsO53GicGJvil8sIMciZHmtuOeRdoc0FFdgSOmM+gYgHs5FJh7
         4ft7z/bH67F/5Sq0ba5LHiN6Mpo9rlNrRJw2nYYG/bzxZeiF6jeZRN4BRyXHlmISKwPv
         R0jPwpd3iW959Ayl4J50inz75+l8FlKy2zcR4A10BurfItMVfCWuWjTrikudgV9icgvR
         VvMrwZWTKjya5QFCbFgCwwBWMfsaBQ4a5r978MiynG1BT0M9VYUzCTpXNDmhcG4i/m0g
         6WoKzpUEmIFYONvkOsXqLq9WHqnbBk/IvrtR1NSflxvHmH9RTc0l9an1m8xOE/3rVZKI
         uP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730456304; x=1731061104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwxM/FjA9AksgVOtf8rzlVE3z9HPcVCwlrxiT5luSQU=;
        b=jNEyqX+/DyXSFL7ePeFWdce17kfXBMwntLqifXLoz56H6vPkNnpK+HXDI64/5ipVhE
         00FqwKNCe3e22Oa8nm8Z+PESE8aP73HSgpi1xSfpDrGkfewdLc/kFC1ge7O/5ePtnXj3
         cEMGTc5TdfbHkotGSffcb9XUPBbr5FwoJxY7e3VEGiBXEfd9/WDcNEc54LEHjTsmXc8Y
         6G9MTHJuBokkR+vY2XOcisseBzVnhSNT9IP4USZOTMZzmQShIv2J5JoaMQGW0e2dPZml
         FtHfKZv3LGzWKUAuDfITsYvaNgsLMHWAzYrYzmo2Yokz08OGd0Zz6B+CdUcR8CG3pe7c
         ++IA==
X-Forwarded-Encrypted: i=1; AJvYcCUwPOxgIWwp/x6tWwxJabvOGn9OaiASqamHitKp4xLLjEMDwPEgC3gRQh8YYOYk7/dNNwLlB8ZXDQ/oBks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV73exFveAGFZFFtZvYhQcCfwVgOIQmUID29XLN5LK5A0Y3ugH
	p9fjG6ZYmbPXUF0pvg7hOmgYOv7CqeUc+ZMcVprIq/sbdNzsDH2jTBdVMne3JftFvaVZctA6D70
	/dkRnvnQ8i+5z8W7g4ieDHa8t47E=
X-Google-Smtp-Source: AGHT+IGktJR4kXiSVcEP5zyV7fVZbNHuALXiNZ/K8o5Zyj0KzJIQB/BDX4XXF+spSRskc7kGZPunVPyRF1WkVpBdtPs=
X-Received: by 2002:a05:651c:994:b0:2fb:5504:794d with SMTP id
 38308e7fff4ca-2fedb7ecb76mr14926851fa.44.1730456303431; Fri, 01 Nov 2024
 03:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031193606.87970-1-advaitdhamorikar@gmail.com>
 <87r07wufs7.ffs@tglx> <CAJ7bepLOJZLwgm6f+RU=-xb0qPim-7VBi+062EJC5yT5_BmmpA@mail.gmail.com>
 <TY3PR01MB120896A09E7CF11D55164527BC2562@TY3PR01MB12089.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB120896A09E7CF11D55164527BC2562@TY3PR01MB12089.jpnprd01.prod.outlook.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Fri, 1 Nov 2024 15:48:11 +0530
Message-ID: <CAJ7bep+ras3xdWfH-7YLbVha0QVN-ONmp39Pvf_TpYhh9A=o-g@mail.gmail.com>
Subject: Re: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched datatype
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"anupnewsmail@gmail.com" <anupnewsmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Fabrizio,

> Which static analyzers did you use?
I used the Synopsys blackduck coverity scanner.

> In this case it's not a bad bit shift operation. The code never passes a parameter that makes it exceed the 64 bit boundary.
> There is nothing to fix in this case.
> Remember that analysers are not always right, you still need to read and understand the code.
Yes, I needed clarification because I wasn't so sure what range of
values irqd_to_hwirq() returned to hwirq.

Thanks for your time and the insights,

Kind regards,
Advait

On Fri, 1 Nov 2024 at 15:18, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Hello Advait,
>
> Thanks for your email.
>
> > From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> > Subject: Re: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched datatype
> >
> > Hello Thomas,
> >
> > > and read through the matching documentation.
> > My bad, I will be more imperative next time :)
> >
> > > In fact there is no problem with the existing code because the hardware
> > > interrupt number range for this interrupt chip is guaranteed to be
> > > smaller than UINT_MAX. IOW, a truncation from unsigned long to unsigned
> > > int (on a 64-bit system) does not matter at all.
> > I did not know about the interrupt range of the chip, so I
> > assumed the truncation from 8 bytes to 4 might pose a problem.
> >
> > >If at all, then the proper change is either
> > >1) to make the related variables type irq_hw_number_t
> > This seems like the better option to me. If it is needed,
> > I will submit a patch v2 after waiting for some more feedback, if there's any.
> >
> > I have one question, static analyzers report an issue of a bad bit
> > shift operation
> > on line 307: tien = ICU_TSSR_TIEN(titsel_n);
> > #define ICU_TSSR_TIEN(n) (BIT(7) << ((n) * 8))
>
> Which static analyzers did you use?
>
> >
> > From what I understand hwirq can possibly have values from 0 to 31
> > If titsel_n ends up being a large remainder say 5, we can have a bad
> > bitshift operation
> > exceeding 64 bits.
>
> In this case it's not a bad bit shift operation. The code never passes a parameter that makes it exceed the 64 bit boundary.
>
> There is nothing to fix in this case.
>
> Remember that analysers are not always right, you still need to read and understand the code.
>
> Kind regards,
> Fab
>
> > My humble apologies if my observations are completely off, I'm a
> > beginner trying to learn
> > Linux driver dev by looking at how other drivers work.
> > If this is an issue what could be a possible method to fix this?
> > I would be grateful if you or someone could point me to some relevant docs.
> >
> > Thank you for your time and feedback,
> >
> > Best regards,
> > Advait
> >
> > On Fri, 1 Nov 2024 at 02:54, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Fri, Nov 01 2024 at 01:06, Advait Dhamorikar wrote:
> > > > This patch updates the type of hw_irq to unsigned long to
> > >
> > > Please do:
> > >
> > > git grep 'This patch' Documentation/process/
> > >
> > > and read through the matching documentation.
> > >
> > > > match irq_hw_number_t.
> > > >
> > > > The variable hw_irq is defined as unsigned int at places,
> > > > However when it is initialized using irqd_to_hwirq(), it returns
> > > > an irq_hw_number_t, which inturn is a typedef for unsigned long.
> > >
> > > We know that, but what is the problem this patch is actually solving?
> > >
> > > >  static void rzv2h_icu_eoi(struct irq_data *d)
> > > >  {
> > > >       struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
> > > > -     unsigned int hw_irq = irqd_to_hwirq(d);
> > > > +     unsigned long hw_irq = irqd_to_hwirq(d);
> > > >       unsigned int tintirq_nr;
> > >
> > > It moves the type mismatch and potential truncation a few lines further
> > > down:
> > >
> > >         tintirq_nr = hw_irq - ICU_TINT_START;
> > >
> > > In fact there is no problem with the existing code because the hardware
> > > interrupt number range for this interrupt chip is guaranteed to be
> > > smaller than UINT_MAX. IOW, a truncation from unsigned long to unsigned
> > > int (on a 64-bit system) does not matter at all.
> > >
> > > I'm all for being type safe, but what you are doing is purely cosmetic.
> > >
> > > If at all, then the proper change is either
> > >
> > >  1) to make the related variables type irq_hw_number_t
> > >
> > >     You cannot make assumptions about the type which is behind
> > >     irq_hw_number_t today. The type can change tomorrow, no?
> > >
> > > or
> > >
> > >  2) Use a proper type cast which documents that the type conversion
> > >     including the potential truncation is intentional and correct.
> > >
> > >     This should not be an actual type cast, but a helper inline which
> > >     has the cast and explicitely returns an unsigned int.
> > >
> > > I leave it to you to decide which variant is the correct one, but I'm
> > > happy to answer your questions.
> > >
> > > Thanks,
> > >
> > >         tglx

