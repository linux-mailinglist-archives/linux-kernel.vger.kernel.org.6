Return-Path: <linux-kernel+bounces-314048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB996AE23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3ECB21A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F440FC12;
	Wed,  4 Sep 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wSdatNP5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DD29A2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415047; cv=none; b=SzgRhVaoEqmYYvyIGbM7JQqDEFtIt63eijHld+uCRZRwGrGxnnJ/T3NYNv+73quChqQ7AhtFmTSYG3R52oPB572CHokrXnTt2JOKXdQWahhfSCxBNixk3Zv9P7Z3w9Q0hIbZp91QlwC0ontAtXx8pi6yV7TaHgu/1fIvwx3Gffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415047; c=relaxed/simple;
	bh=KrsbuzwRzYAt6vJq9F6VDrlgJqybkvD+/vneeWdcLf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe27h+VzWSEC/LO9qjZi+jPJ8GOhLrOT45/MpQbzP+E0N88Orzg9PMSLwtswvvE1f/g68Z8Aa/xjpxTx4N/2wKHoyXt8jrQIdcA8f+ORX9L50HNJJJo1br4B3HIj2zJitlR1rDLf24S1bKu+V44EmB10oTP+i7q7KaIL2ckAQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wSdatNP5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D3A83F6B5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725415042;
	bh=86SfZLfRe8f8K84AmtfIpgYOcyHznOWRKrIg/kGiMzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wSdatNP5YU83dc4OSAARwDqJOoFsy9HjjANcWu9U2+NVy/3FaTS6Gn83E5rQYD389
	 hbV98wyW8yL0M6Mpzm0V51RIBPE8baqlZsQrUuBXCCj1ligtnJp2QI7ElT0wvqSiBj
	 DBOZRLmM4t+fxffQqvbIH1DIT1eAozlP+acCKEPYwI1y368t43XntstBlSKuu/on7B
	 yreJO24vKmbjdN7sfMd4AZ84NTjs0S2iIE7AUJjzrSfHwKrRPzu5BiKU2S6r5PHMM/
	 7QEMV1FIlRVP4wKS7+gHQbf8bYWWo7HKd4MXucxJ4SQi8wMlWiWA/zsydVpBEQY15N
	 rv8cFuSyqpJlA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c2580e0434so1411890a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725415042; x=1726019842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86SfZLfRe8f8K84AmtfIpgYOcyHznOWRKrIg/kGiMzg=;
        b=RdFsY8mLq5kz2ijGkBhYpMoZXHBNoMS4jDsQ4jr2bBfd1Du00QTS25HlinNOB42ww+
         9r8zhcu/uM/FK1pb41daAdW9CnPkkylZzCnDC6fXuqJUU8A+iK6SPImcQhB41DtzTL9z
         HgEknBSxUC5gDVwXSMUqrhTZAfvPTv3Vb0XKSJEcldWxpBGQ7rj6ujd1hMnDiaiHly7S
         ZNaE6J3s28kvhbQyvn5JDzTlQpsYdAwh02ChcWMthMZd5swF0oGINtHA9AZvXX5N/7Qr
         OKlJTytWNlV6vh78/B4/hRQb7zGOv3VYI+mpQNYt15niJ/77iuURSOxVj7PI8BK04R7u
         8Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCUlgK+bkDZCQCMEUzAIthSqxwFrgvKZmTUtbK0mhZmiPWf3pPj2p5epQajKsVMKYpCvBheUfa04KAAbDZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0WlLJJs1vYk2Au8QyMmSFk1UsNXLhngV+9tjZIVGgrETNhC1
	DxqwK13pccYiVJYhkKglHYOLQL1wlzGNnSNTSoHT/6HzYhFQ0VNFmDC0x48LvB6iQtsreGi4nVB
	kUkEyi4g96Y9zdx1M9YAi1+iKlqWfJUmUQWmUTOih+T/4JhVkC8ctzx4i7Tk70WT6rKhD1hIb+H
	y6S/JBdx/zjmceSPV1zwhzhaRO+g5JchjjIqY9k4nm8dLXQXaZbINq
X-Received: by 2002:a05:6402:254b:b0:5c2:6d3e:d99b with SMTP id 4fb4d7f45d1cf-5c26d3edbe0mr2530714a12.16.1725415041895;
        Tue, 03 Sep 2024 18:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAEHK8NpR3SZTrSJQCZIajOEVMuJzNnwXMh2xQ/7TcBQy/Pca7lrnwoNVuynFnCfC34vYbYyVkSk/Uuv9WUHE=
X-Received: by 2002:a05:6402:254b:b0:5c2:6d3e:d99b with SMTP id
 4fb4d7f45d1cf-5c26d3edbe0mr2530703a12.16.1725415041133; Tue, 03 Sep 2024
 18:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad> <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
 <ZtciXnbQJ88hjfDk@kbusch-mbp>
In-Reply-To: <ZtciXnbQJ88hjfDk@kbusch-mbp>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 4 Sep 2024 09:57:08 +0800
Message-ID: <CAAd53p4cyOvhkorHBkt227_KKcCoKZJ+SM13n_97fmTTq_HLuQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: Keith Busch <kbusch@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, acelan.kao@canonical.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:51=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> > On Tue, Sep 3, 2024 at 12:29=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > > Meteor Lake VMD has a bug that the IRQ raises before the DMA region=
 is
> > > > ready, so the requested IO is considered never completed:
> > > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> > > >
> > > > The is documented as erratum MTL016 [0]. The suggested workaround i=
s to
> > > > "The VMD MSI interrupt-handler should initially perform a dummy reg=
ister
> > > > read to the MSI initiator device prior to any writes to ensure prop=
er
> > > > PCIe ordering." which essentially is adding a delay before the inte=
rrupt
> > > > handling.
> > > >
> > >
> > > Why can't you add a dummy register read instead? Adding a delay for P=
CIe
> > > ordering is not going to work always.
> >
> > This can be done too. But it can take longer than 4us delay, so I'd
> > like to keep it a bit faster here.
>
> An added delay is just a side effect of the read. The read flushes
> pending device-to-host writes, which is most likely what the errata
> really requires. I think Mani is right, you need to pay that register
> read penalty to truly fix this.

OK, will change the quirk to perform dummy register read.

But I am not sure which is the "MSI initiator device", is it VMD
controller or NVMe devices?

Kai-Heng

>
> > > > +     /* Erratum MTL016 */
> > > > +     VMD_FEAT_INTERRUPT_QUIRK        =3D (1 << 6),
> > > >  };
> > > >
> > > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > > >   */
> > > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > > >
> > > > +static bool interrupt_delay;
> > > > +
> > > >  /**
> > > >   * struct vmd_irq - private data to map driver IRQ to the VMD shar=
ed vector
> > > >   * @node:    list item for parent traversal.
> > > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > > >       struct vmd_irq_list     *irq;
> > > >       bool                    enabled;
> > > >       unsigned int            virq;
> > > > +     bool                    delay_irq;
> > >
> > > This is unused. Perhaps you wanted to use this instead of interrupt_d=
elay?
> >
> > This is leftover, will scratch this.
>
> Maybe you should actually use it instead of making a global? The quirk
> says it is device specific, so no need to punish every device if it
> doesn't need it (unlikely as it is to see such a thing).

