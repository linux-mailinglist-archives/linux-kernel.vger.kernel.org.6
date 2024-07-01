Return-Path: <linux-kernel+bounces-236161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BF91DE47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF2B287A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154C14388B;
	Mon,  1 Jul 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axQMZMd5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236D2B9C6;
	Mon,  1 Jul 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834258; cv=none; b=SELffUt0IzB434VU8OKLzezYyKkq796z5zWKVaGMTwbAxTIRps8B9jWpNPJp42MiYh1I/EJ5TXhbswMpMe2YHs4I15mkW3WYdS5DpAANCQCGVoXAOamZvmvOrjpSzgUoTsSKfhPuXnPT76Ezsvk9IHjIRjQBfVcdo0VbDdgQipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834258; c=relaxed/simple;
	bh=EFhHZ8krS3YX4Rhnw6tPzG9ivsvic2w0ICte+D7epPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3Ppn5O0RKy4OS6+wu8ESEAi492T3qH3A7+sLHiN3vmYySzvjEtrs4BIF/6KRrySgPwwC8kAB0TO4Sms/ES0CBx0DkhMSHQhiZgxeY64ZRWTr5WuvkiPfyh0w9X8ibjFepV+HFXZpNnsFuLrUgYuV1tSsAMHg0pZsoyy+olTdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axQMZMd5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a70c0349b64so367127566b.1;
        Mon, 01 Jul 2024 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719834255; x=1720439055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9iAbQtFtdSiqgpd9jNTe/QjQNj0w6DRstuBh7C3leo=;
        b=axQMZMd5OCWzLut2fDRNWCCuXKnEy5FT/zP+x4RUqELVeeYlSO1ws3HMCObzX35N0Y
         UfaWToknLrPBO7HBnuC+yL+sYBgVWMfiZHS5U1yp5GxxEbw+L8LvrX33I55xfYaDNTir
         FdTI5CNkbF/HVrlb8VWx4/tcVTGehuhDf6lP/fYvbgIeXAQuM8WQh5rwE2z/JyJDKVuJ
         4qKgmBuCgdybzh8Pxd7fQLhnmUSRHEuPZf5vtEvmodoSlev5AFR66x9UMywqusGh/9Ex
         Rb6rW0oADK0vrjq5VEb17vkY3gGM1+ZNr9kFCDIq7cSl2KwT9U0wUHik8LFs05gUjT39
         +eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834255; x=1720439055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9iAbQtFtdSiqgpd9jNTe/QjQNj0w6DRstuBh7C3leo=;
        b=S/4G5HDqoBurPy+5IlCDdR4YyslSExMn0BVI0/o8YQ9spYGa6N3NHnpxtwU3VN8+N9
         k1YERbweVf0JgPkWOQk6vjoIaqyVNM4H0j7ZYYWo4TXzfDTvSbbjoDDlDGnNFlKxCsb7
         XB10h1gW9LBkues+nE/P+yjvE8zPF+VzfxWVThqQX/tZT9iZ6zo+wApICIttvMLANKx0
         ch+XUXc+ya35FIpc7mXMrrk0wSWRkaVzvDZggp2W000Kkn6lRh6b7hwNbauw/dcL7Ny0
         nxmEtz1O9NiICapykJVBDcZ9CNAVVuScID2LuQLuuXsX8yDsPVmT5OvBwjGh/4h4wPk9
         yTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8H87JMuKZ9LM37IWHSxyNAM41JkSKm/FFVZHVLroz8wT/S2Xmzl17EPtDJsoJrlRWNQsO9aIdb3uVSRMAXuNElDkDnU7EoOGv/eMtapyDZlpo1zUnQc5LAqchZ5/v6lsVC1C+/6xp
X-Gm-Message-State: AOJu0YxndMvBsboNoL8tipkAaeNg8kBH8dUwSjLc2pgrBOev1Dz+6fms
	/aLiGQAbKZri2irDhveXOfIxNfInhJjEJc2hybqvFJmymzVf/gNXnRzTKqOXSQ+IYSEtPQyGP3i
	8v5xZh0GOEzW7fnN2EmSWd8Rs2PvWfG7piw8=
X-Google-Smtp-Source: AGHT+IGP2RE/XOGWNnQ5wOLWhmgKlYA0QFP79Xr7+7awa8VbxGp5MuJB+YxschZcRrEBfy59TFrTmr4UL3Jh49GmJe0=
X-Received: by 2002:a17:906:5643:b0:a72:6849:cb09 with SMTP id
 a640c23a62f3a-a7514495b0dmr369152466b.53.1719834255355; Mon, 01 Jul 2024
 04:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601120640.73556-1-joswang1221@gmail.com> <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
 <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com> <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
 <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com> <CAMtoTm2G-w+yRjechji7scJO-JZo6N==VK6Wun3ATRc7do9rEg@mail.gmail.com>
 <b5deb873-7151-46fa-164e-9e2c6a339636@linux.intel.com> <CAMtoTm1cqeFhko_+D7cZL5vAv7ea+bvF0yGHn0Uy7cwyU=O0zw@mail.gmail.com>
In-Reply-To: <CAMtoTm1cqeFhko_+D7cZL5vAv7ea+bvF0yGHn0Uy7cwyU=O0zw@mail.gmail.com>
From: joswang <joswang1221@gmail.com>
Date: Mon, 1 Jul 2024 19:44:03 +0800
Message-ID: <CAMtoTm2MGnT+_U1JQFmbH7OgcH6s89ZtkNALkO44vSE35yi=qQ@mail.gmail.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathias

Do you have a better idea about this question?

Thanks=EF=BC=8C

Jos Wang

On Wed, Jun 12, 2024 at 10:23=E2=80=AFPM joswang <joswang1221@gmail.com> wr=
ote:
>
> On Tue, Jun 11, 2024 at 11:00=E2=80=AFPM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
> >
> > On 11.6.2024 17.45, joswang wrote:
> > > On Tue, Jun 11, 2024 at 6:01=E2=80=AFPM Mathias Nyman
> > > <mathias.nyman@linux.intel.com> wrote:
> > >>
> > >> On 6.6.2024 17.08, joswang wrote:
> > >>> On Wed, Jun 5, 2024 at 6:31=E2=80=AFPM Mathias Nyman
> > >>> <mathias.nyman@linux.intel.com> wrote:
> > >> ...
> > >>>>
> > >>>> I was thinking of turning XHCI_AVOID_BEI behavior into the new def=
ault, so no
> > >>>> quirk flag would be needed:
> > >>>>
> > >>>> Currently without the quirk flag:
> > >>>>
> > >>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> > >>>>
> > >>>> Currently with XHCI_AVOID_BEI quirk flag:
> > >>>>
> > >>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> > >>>> - Interrupt is additionally triggered every 32 isoc TRB (initially=
).
> > >>>> - if more than 128 events are processed in one interrupt then the
> > >>>>      32 is halved, and we trigger an interrupts every 16th isoc TR=
B, and so
> > >>>>      on, 16 -> 8...
> > >>>>
> > >>>> I would remove the quirk flag, and make all controllers interrupt
> > >>>> behave as if it was set. i.e. interrupt at least every 32 isoc TRB
> > >>>
> > >>> Thank you for your detailed analysis.
> > >>> Excuse me, I have a question, do you mean to set "Currently with
> > >>> XHCI_AVOID_BEI quirk flag" as the default behavior?
> > >>
> > >> Yes, unless it causes some issues or there are strong objections
> > >>
> > >>>>
> > >>>> Is there an actual real world case where interrupting every 32nd I=
SOC TRB is
> > >>>> too often?
> > >>>
> > >>> I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt w=
ill
> > >>> be triggered every 8 TRBs, which makes the interrupts seem to be qu=
ite
> > >>> frequent.
> > >>> Thanks
> > >>> Jos
> > >>>
> > >>
> > >> It should start with interrupting every 32nd isoc TD, not 8th
> > >>
> > >> #define AVOID_BEI_INTERVAL_MAX   32
> > >>
> > >> ir->isoc_bei_interval =3D AVOID_BEI_INTERVAL_MAX;
> > >>
> > >> Thanks
> > >> Mathias
> > >
> > > As you mentioned=EF=BC=8Cif more than 128 events are processed in one
> > > interrupt then the 32 is halved, and we trigger an interrupts every
> > > 16th isoc TRB, and so on, 16 -> 8...
> > > xhci_handle_events()
> > >      ......
> > >      if (event_loop++ > TRBS_PER_SEGMENT / 2) {
> > >           if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> > >                ir->isoc_bei_interval =3D ir->isoc_bei_interval / 2;
> > >      }
> > >      .......
> >
> > Yes, and to me this seems reasonable .
> > If there are over 128 events per interrupt then we should interrupt mor=
e often.
> >
> > Would this work as the default for the Synopsys hosts you are working w=
ith?
> >
> > Thanks
> > Mathias
>
> Without enabling XHCI_AVOID_BEI quirk, that is, triggering an
> interrupt once for every 32TRB:
> For some USB cameras (such as high-resolution cameras, etc.), the data
> volume of one frame is relatively large, and the host controller will
> frequently trigger interrupts during data transmission. For some SOC
> platforms (such as rockchip platforms, which also use Synopsys USB IP)
> with poor performance, it is possible that the CPU cannot respond to
> interrupts in time, resulting in frame loss.
> Therefore, I think that using XHCI_AVOID_BEI quirk by default may
> aggravate the above problem. Please help evaluate, thank you.
>
> Thanks,
> Jos Wang

