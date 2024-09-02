Return-Path: <linux-kernel+bounces-310868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6DF96823A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995661F22CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E60186E27;
	Mon,  2 Sep 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0zv0C7+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435FA186E23
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266563; cv=none; b=pBTZFdxDUf+Y/zsPS/c4r27HgOSBBeMPxft7CxO4xZB/qHtlLByaijnn9WGyqvMOZJA3X8llEFqMrzCBgd6lxM8yTDQSs93ae80Fnv3e+WuOrFeP6bKFW2u8aKebCS9Ask+SosncnCt10MO/Azp93S+MQrxjUdKUnDszPN8RoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266563; c=relaxed/simple;
	bh=2n5m36DkE2LFtmn6Tbu7DZ+nnZR5HWSmXz/m2B0ZT8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es78FeSfHxcwwCEe9TBKs3m5ZsFMI1H9mgcDbmjDQCkXRSySydQDLKsAQ7Mn5tdjohQVpxzW5bjFLqa5jWHJic5wSBsDc3XadO9lYMEwP2l+PhnMjO6X/zsYdroj7nPsqGcEVnxtJjQnoufbEyD60hgje4ewhcyE9nZ1wSCRP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0zv0C7+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374bb1a3addso1340110f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725266560; x=1725871360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKGoMeM/3PgNSP8PxE5G5/agPWjtquoSc/4Ni9Seno0=;
        b=N0zv0C7+1uFordlGeEQIO+ZTkShXVqLFJ3ORjQuUFHzfKvV3lyQXb6arZvqsIH0sLN
         ERXu6plVqRHjuDhbefvNcnJgmIKhBVdm2vnAJqox8d7r/H2fz6ffMOt8mOwKLzkKYbO2
         slOYn6Cj3lgpm/bEUrkdMgfUiZ/d+Jw4V8FlUoPcLuppx2dhhf8Nw3yRcaJNihCDcaWT
         Q2c60jKQFEijhXpwj3hHIr8D2c5CQFYNzDg+62ehahIT0cxs06WLWUfJwAwoJnc5XDRM
         lrbcQiAOqBxXbfZxHm/uDhjNZvLZ7VMe5aZH8UkjTvDc4QUgI4tyeQL81gf3HEUPE6Kb
         LzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266560; x=1725871360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKGoMeM/3PgNSP8PxE5G5/agPWjtquoSc/4Ni9Seno0=;
        b=A8iN1h4fWV7gHQ/ocEmiEpprrMPz9gn3e//ttLVyiLLoHXcgLit2a3+tn6JUam2GaU
         /gxTB8xskVl++UnSFgxm2Cg1gobegkBJ+nAEDYeBLaIonlLGldX+0dnKrRipeRy8U8DK
         xHq2Szl6RdbAPv04PC9B5eRm0oKKEoECLiKZTcI+W99yw5WaWllyiEbpnRwudzK9G+tM
         TdqV99n0F+rQrS+e/tVA/7estxoi1ZXE3Bsb4xWp1cnUHyEeBskLZIr4t/W1cm9xP3YU
         +eLs9CFxW20IvauUVne5SXI1pT9PyaLJGJ4FyOiGUpFaUJC7zksX/5wWUwbOUTUh8S+z
         xshQ==
X-Gm-Message-State: AOJu0Yy43RGuoJQmsLNFHDJJMimUJ+kWqVpRI7yzYOKVFtjPhKjluFBr
	FrgNxijrKE6KVSXq5feZAUJq4lyegAyJRuc4zi7/2Vsi+N3yHcVM8O7QU9JOZXbS8c0gpangY7e
	NqxpbB1nYwm+EduG72Wi7FgyH1Jw=
X-Google-Smtp-Source: AGHT+IEMNLEkMONqWM78QpxpHQNDiMtOsNf38dOjHl4R7Uoj7Gz0QOq4hKkwyA3On0WrxeacGkgvuUKYo2Nt882Vc/E=
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df6e with SMTP id
 ffacd0b85a97d-374c269e094mr4102290f8f.25.1725266559850; Mon, 02 Sep 2024
 01:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtUuYXSq8g2Mphuq@den-build> <87r0a27blv.ffs@tglx>
In-Reply-To: <87r0a27blv.ffs@tglx>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Mon, 2 Sep 2024 16:42:28 +0800
Message-ID: <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Sep 2, 2024 at 3:34=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Richard!
>
> On Mon, Sep 02 2024 at 11:17, Richard Clark wrote:
>
> The subsystem prefix is 'irqdomain' not 'irq'
>
Right, will correct it.
>
> # git log --online $FILE
>
> gives you a decent hint.
>
> > In current implementation, the trigger type in 'flags' when calling req=
uest_irq
> > will override the type value get from the firmware(dt/acpi node) if the=
y are
> > not consistent, and the overrided trigger type value will be retained b=
y irq_data,
> > consequently the type value get from the firmware will not match the re=
tained one
> > next time in case the virq is available.
> >
> > Thus below error message will be observed by the __2nd__ 'insmod' withi=
n the
> > 'insmod - rmmod - insmod' operation sequence for the same device driver=
 kernel
> > module, in which request_irq(..., IRQ_TYPE_LEVEL_HIGH, ...) is used:
> >
> >       irq: type mismatch, failed to map hwirq-182 for interrupt-control=
ler!
>
> How so?
>
> 1) insmod()
>      irq_create_fwspec_mapping(fwspec)
>        irq_domain_translate(fwspec, ... &type); <- Sets type to the FW va=
lue
>
>        virq =3D irq_find_mapping(domain, hwirq);
>        if (virq) {
>          // Path not taken
>        }
>
>        // Map interrupt
>        ...
>
>        irqd_set_trigger_type(..., type);
>
> 2) rmmod()
>      tears down mapping
>
This just tears down the action allocated and installed by
request_irq(...), but does not teardown the irq's node inserted in the
revmap_tree.
>
> 3) insmod()
>
>       Should be exactly the same as #1 because the previous mapping was
>       torn down by rmmod()
>
Not the same exactly, the {irq, irq_data} will still be in the
revmap_tree, so it will enter another path in this case:
        virq =3D irq_find_mapping(domain, hwirq);
        if (virq) {
               // will be in this path for the next 'insmod' since the
{virq, irq_data} not be teardowned by free_irq(...) called by rmmod
       }

>
> Even if the first mapping is not torn down by rmmod(), which is a bug in
> itself, then the type is exactly the same as the firmware describes it, n=
o?
>
> So how exactly does that happen what you describe?
>
The logic is if the trigger type specified by request_irq(...) is not
consistent with the firmware one, the request_irq will override the
FW. We need to keep this logic the same as when we insmod the same
kmod next time -- override the FW's too instead of returning a
mismatch type error.
>
> > The corresponding 'interrupts' property of that device node is:
> >       interrupts =3D <0 150 1>;
> >
> > This commit fixes the above issue by adding a new checker -
> > irqd_trigger_type_was_set:
>
> This commit is equaly redundant as 'This patch'
>
> # git grep 'This patch' Documentation/process/
>
> Also 'new checker' is not really a technical term.
>
Ah, will correct it. Thanks!
>
> Thanks,
>
>         tglx

