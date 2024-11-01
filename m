Return-Path: <linux-kernel+bounces-391751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6169B8B46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE12B21C04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5F14E2DA;
	Fri,  1 Nov 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1yPK6wq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB01448C1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443510; cv=none; b=ussEkSFKoE6mNFlHYPiwEAPmIQsYvUoKP1FfAh5cJUDZVZER/wpPEt3YdjdvcnTIoodBb2VYtcYsNkzW7HO60Jb6CnagqggdEBVP8Ayqd/lPLtjFyFFbTRCT45X4ZvzUT/Xg+OH80DbufH0rF7omKaYmgLB4Ijcv87WJjlCFjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443510; c=relaxed/simple;
	bh=f/eFC1evByRoBWC2obnndn3AQo1rcdhC7qzV++yByn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HprKpg+FnjNwPbtw/8wp/jFAgQ9OPqTozRQqUtKWRW3xcAL6SWQ02il42E6Ci7e/MMWn6z0uPvDHXa2yduLTCk62J/Z6ipraSkwBfoc7543swmYbjYqeD7d0j0pukZNMKrQqrCOIzDLvUkLRUQjQYD5i/5eRUMBY2tnwETRjJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1yPK6wq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb518014b9so14060571fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443506; x=1731048306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=buwbwZlERL376t+nXnY+bTwXdGUxF7/rEqEox8uFaIA=;
        b=e1yPK6wqFki4yiZQYp1VwBwjRT0jWau9N3q+oJFrZDfOrhJOrgBlKFTWf4yDznh2YW
         vEx1iruLBFoEV6ysrtX1ZH11qhNcxhPCkNt37UIKmrIvVWN4Dti0wrkzdxM4ivLlkp7v
         VC9ypzdk6Z+mQdThGR5+RxizkSPEaQwxbqGQuDk5soOoX8wyG8CLgWz9NxYsiTeFV0Ia
         MmlHWEL/F3jEgzjohpHgoQXlezf0XN+/JTr5RftioWdm3Rb1e29fsuPi9ytAJ3/f3FoJ
         Vq47SVoXieqipUjk2W7yEGZSR9PvBoF/AVYmgiPgT7CUUx0DBtAfwPFV99l6spfMcaXU
         j4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443506; x=1731048306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buwbwZlERL376t+nXnY+bTwXdGUxF7/rEqEox8uFaIA=;
        b=CTrVig/kH7AshuCaRzTD46C33s4c+PZOS74DIFFQo2V+0UM2RjivJiLKWohcJGLq1D
         kEaxi5ELfyWTCBqHASgjTBEdJ8EjpUitBu9Rd2V8zD2Bi/gc/k4SLkZpVmdtntYRG6m4
         uQ0E+qf4cCcXdpwlv7kHASJwlJ/F0DDNr5x59wCyiGfgheOW+QSKK2H1It5vfFX5vKWb
         M4tSimZXNAG5cFDhjOZMCxh1nz3Sc/htTi1vf8sVD4zdPLp42L2aTZfl5pTC3SpQSZ7i
         lv9N72aZVlUmBj4pTXqg5sLnLFZ5+j5jS9BXtQptyAz6e3wcQBdFsByULu2GFzPAonix
         UbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvEf/3C9Y2me2wlvO2vFUcg0LnoQt8Hs81lac18tfjIbF03kAxwI9ObqBo9j/ZbSYb1nisRpRHV97Z6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpky72BW2eZDD5d88ew/2v8wixhTBW9atHflW3I78r9Nn+MD/X
	MZ8i45+eyU1P6bLPSalE7xqI1kR788CTltQ0Sj+DLlEX4Z4LePt5iWJ045Wv1vmZOQDTSMNoqxq
	RYAblu+cSWhlkb3CdXNyaxaPesgGlA6KSPVU=
X-Google-Smtp-Source: AGHT+IGrP23tPN6MMlCVWhvplz8qjlX5j5RlUeL4tH7d1yWnc1KxgwtfPHwcpLRh8Y9tku8eNio/rakFblLt9pDruHg=
X-Received: by 2002:a2e:be05:0:b0:2fb:70a0:91e7 with SMTP id
 38308e7fff4ca-2fcbdf6ff4fmr114026171fa.10.1730443505989; Thu, 31 Oct 2024
 23:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031193606.87970-1-advaitdhamorikar@gmail.com> <87r07wufs7.ffs@tglx>
In-Reply-To: <87r07wufs7.ffs@tglx>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Fri, 1 Nov 2024 12:14:54 +0530
Message-ID: <CAJ7bepLOJZLwgm6f+RU=-xb0qPim-7VBi+062EJC5yT5_BmmpA@mail.gmail.com>
Subject: Re: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched datatype
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Thomas,

> and read through the matching documentation.
My bad, I will be more imperative next time :)

> In fact there is no problem with the existing code because the hardware
> interrupt number range for this interrupt chip is guaranteed to be
> smaller than UINT_MAX. IOW, a truncation from unsigned long to unsigned
> int (on a 64-bit system) does not matter at all.
I did not know about the interrupt range of the chip, so I
assumed the truncation from 8 bytes to 4 might pose a problem.

>If at all, then the proper change is either
>1) to make the related variables type irq_hw_number_t
This seems like the better option to me. If it is needed,
I will submit a patch v2 after waiting for some more feedback, if there's any.

I have one question, static analyzers report an issue of a bad bit
shift operation
on line 307: tien = ICU_TSSR_TIEN(titsel_n);
#define ICU_TSSR_TIEN(n) (BIT(7) << ((n) * 8))

From what I understand hwirq can possibly have values from 0 to 31
If titsel_n ends up being a large remainder say 5, we can have a bad
bitshift operation
exceeding 64 bits.
My humble apologies if my observations are completely off, I'm a
beginner trying to learn
Linux driver dev by looking at how other drivers work.
If this is an issue what could be a possible method to fix this?
I would be grateful if you or someone could point me to some relevant docs.

Thank you for your time and feedback,

Best regards,
Advait

On Fri, 1 Nov 2024 at 02:54, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Nov 01 2024 at 01:06, Advait Dhamorikar wrote:
> > This patch updates the type of hw_irq to unsigned long to
>
> Please do:
>
> git grep 'This patch' Documentation/process/
>
> and read through the matching documentation.
>
> > match irq_hw_number_t.
> >
> > The variable hw_irq is defined as unsigned int at places,
> > However when it is initialized using irqd_to_hwirq(), it returns
> > an irq_hw_number_t, which inturn is a typedef for unsigned long.
>
> We know that, but what is the problem this patch is actually solving?
>
> >  static void rzv2h_icu_eoi(struct irq_data *d)
> >  {
> >       struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
> > -     unsigned int hw_irq = irqd_to_hwirq(d);
> > +     unsigned long hw_irq = irqd_to_hwirq(d);
> >       unsigned int tintirq_nr;
>
> It moves the type mismatch and potential truncation a few lines further
> down:
>
>         tintirq_nr = hw_irq - ICU_TINT_START;
>
> In fact there is no problem with the existing code because the hardware
> interrupt number range for this interrupt chip is guaranteed to be
> smaller than UINT_MAX. IOW, a truncation from unsigned long to unsigned
> int (on a 64-bit system) does not matter at all.
>
> I'm all for being type safe, but what you are doing is purely cosmetic.
>
> If at all, then the proper change is either
>
>  1) to make the related variables type irq_hw_number_t
>
>     You cannot make assumptions about the type which is behind
>     irq_hw_number_t today. The type can change tomorrow, no?
>
> or
>
>  2) Use a proper type cast which documents that the type conversion
>     including the potential truncation is intentional and correct.
>
>     This should not be an actual type cast, but a helper inline which
>     has the cast and explicitely returns an unsigned int.
>
> I leave it to you to decide which variant is the correct one, but I'm
> happy to answer your questions.
>
> Thanks,
>
>         tglx

