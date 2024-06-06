Return-Path: <linux-kernel+bounces-204418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0D8FE8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8838B22887
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B9198A2D;
	Thu,  6 Jun 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnsarQq7"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391F198843;
	Thu,  6 Jun 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682933; cv=none; b=rQ9oTOhtDGfo+jodId+JVgsANrRG3pHP70YyyeEV99ID21lYW2/HdWxZY9wzLOutoXEBBa+N7C3t+fHcf5tXl784xomIyYukNWC6mjVkNKbZ0UbtO8eiwVfCmzeP5uXkGpGgk1k2Xra6UJEkM6u/v1fGocIVlv22ka389F9qUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682933; c=relaxed/simple;
	bh=5570pni5u/OsmVvE2bbZGDOscnxd+csoaeg3E6KA4E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3JDo5Zle/n+VGyutHRDcyaWtHaXfPEN22rlvCmt/ZucZIKTjlO9rVn8BSMreS7dscxPt98cpsNFUX5GwiJ/LF6Oj4qUqOi4xVcK5vrRwv/ufP0Cskna8RzMSH1SxGLlqkE1wS13YPNwCBqA9uBCMgRVBgQLQWL4pkFRhy+sasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnsarQq7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso1337119a12.2;
        Thu, 06 Jun 2024 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717682930; x=1718287730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56jslGkcqaDDz5f5lgw8cNTEnSj8hE5KAPITcGyURME=;
        b=KnsarQq77qXRGOvTRwPmtQtes1k40bK6dedWotz2BD1x67VJD6Lybn9cH/WuguhxVo
         SHYTwY4sVuR8r6ZdwboBk38sN5Cjd9WUPrBa6ZUXQ3SOG3G1dyXnvhbByMDMXNL8Uw0o
         X5NoFiYzgivS0DDl0k42eB5mxeU4KJh9yoSxNgJESQF8rbiQOMUhqLse1+dFnYng06h/
         Oa/lL3zP9hj68W0HKgAVk3CIGDg2BOy5llviOodHcOgw/Adbx7VHI0GG/hkZ/5gXW31h
         O3BW800ugnuK1tM8ix3ZgoroPclgwn5TlGm+dmTb4iWFv8UZdgih2pvNozbokAB6PvR2
         Rqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682930; x=1718287730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56jslGkcqaDDz5f5lgw8cNTEnSj8hE5KAPITcGyURME=;
        b=qG2QE4C4B5raKhW+eUllXC/eatC5twTDRGAoACY9iOah2kDH24M0gSZII8tYRjPWNC
         TxgCOvvPmlWNJqaAarCVXqmSIS4j6hCpby1eK4zJnXOkTELG1ieImRwCWsOgAYb4rQzR
         U6QqxdJuGhSB2ZulhqmI9+aJETXp8cgq6kCfWuQWrefS5fz4XNtweOKJ9b5aXnNzLZik
         hm9CVoQDqHo07NeOLmS04QaFXzPkDi/oAMLBvQ0MMZ+Xbklk3xvYbprs06mUQcPWu+24
         DCSSlN9sYoadAX7TSJjFE3/nJ4F8BVOw13w+5G9IemoiGoiPRNi6/FCP938A1WeEIRR8
         spnA==
X-Forwarded-Encrypted: i=1; AJvYcCVWo8wxtr+mWt9seV3Z/ho9etWBNjdRtJpbSnmM4LN4L4WxWPv1XF981vd+VNefxUS+fcSJEWI0PZdlx75hiK+td/Tv9ZVOOAsZ2g8F5qbwhpal7pZ/irCXMFzNqqtEA5TrRKuPlWaD
X-Gm-Message-State: AOJu0YwgzzpKEdRI54mVZ14KlBpGOrWceGJrvZh+SjK10q/rPHgbXM8G
	BRJ58fxh9xqR+deB8qIykoVvd4idQ+72LxMvw4s5vYvUEizkRHYttnzP6Iad3reR3EP/0iuSSB/
	35A+6EbcamSAqap5e4GkJC5hOWkrjreR4FVniuw==
X-Google-Smtp-Source: AGHT+IGNgP275nJ1n7QDGSOgkXnN1O9yDv7X+LSaIUCrMBN8J1USKIroo1VN5pmtPSsloEeJ3Dk18fwF2KiBhXu+PjU=
X-Received: by 2002:a17:906:8302:b0:a66:7b79:3572 with SMTP id
 a640c23a62f3a-a699f362134mr353556966b.15.1717682929728; Thu, 06 Jun 2024
 07:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601120640.73556-1-joswang1221@gmail.com> <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com> <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com>
In-Reply-To: <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com>
From: joswang <joswang1221@gmail.com>
Date: Thu, 6 Jun 2024 22:08:38 +0800
Message-ID: <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:31=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 5.6.2024 8.37, joswang wrote:
> > On Mon, Jun 3, 2024 at 8:21=E2=80=AFPM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 1.6.2024 15.06, joswang wrote:
> >>> From: joswang <joswang@lenovo.com>
> >>>
> >>> For Synopsys DWC31 2.00a and earlier versions, every isochronous
> >>> interval the BEI(Block Event Interrupt) flag is set for all except
> >>> the last Isoch TRB in a URB, host controller consumes the event
> >>> TRBs in the event ring, once the event ring is full, it will not
> >>> generate an interrupt and will stop all data transmission and command
> >>> execution.
> >>>
> >>> To avoid the problem of event ring full, the XHCI-AVOID-BEI quirk is
> >>> introduced. Currently, the XHCI-AVOID-BEI quirk has been applied to a=
ll
> >>> Intel xHCI controllers, see commit '227a4fd801c8 ("USB: xhci: apply
> >>> XHCI-AVOID-BEI quirk to all Intel xHCI controllers")'.
> >>>
> >>> For Linux system, each event ring consists of one or more event ring
> >>> segments and each segment is 4 KB that contains 256 TRBs. It seems th=
at
> >>> the TRBs on the event ring are sufficient and the event ring will not=
 be
> >>> full. In real application, if it does happen, event ring is full, hos=
t
> >>> controller no interrupt causes the driver to timeout.
> >>>
> >>> However, applying XHCI-AVOID-BEI quirk will also bring power consumpt=
ion
> >>> issues. We can consider the application scenarios of the product to d=
ecide
> >>> whether to enable it. Therefore, we add the enable XHCI-AVOID-BEI qui=
rk
> >>> through dts configuration to make it more flexible.
> >>
> >> Took a look at XHCI_AVOID_BEI quirk and it seems that it evolved from
> >> solving a hardware issue into a interrupt trigger optimization.
> > Thanks for reviewing the code.
> > Yes, you optimized the interrupt triggering frequency.
> >>
> >> How about making current XHCI_AVOID_BEI the default behavior, i.e. for=
ce
> >> an interrupt every 32nd isoc trb, and reduce it in case event ring
> >> has more than half a segments of events per interrupt.
> > Yes=EF=BC=8Cenabling XHCI_AVOID_BEI quirk is to solve the problem of ev=
ent ring fullness
> >>
> >> The actual XHCI_AVOID_BEI quirk would only be used for hardware that t=
hat
> >> can't handle BEI flag properly
> >>
> >> something like:
> >>
> >> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring=
.c
> >> index 266fcbc4bb93..dd161ebf15a3 100644
> >> --- a/drivers/usb/host/xhci-ring.c
> >> +++ b/drivers/usb/host/xhci-ring.c
> >> @@ -3991,16 +3991,17 @@ static int xhci_get_isoc_frame_id(struct xhci_=
hcd *xhci,
> >>    static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds=
, int i,
> >>                                    struct xhci_interrupter *ir)
> >>    {
> >> -       if (xhci->hci_version < 0x100)
> >> +       if (xhci->hci_version < 0x100 || xhci->quirks & XHCI_AVOID_BEI=
)
> >>                   return false;
> >> +
> >>           /* always generate an event interrupt for the last TD */
> >>           if (i =3D=3D num_tds - 1)
> >>                   return false;
> >>           /*
> >> -        * If AVOID_BEI is set the host handles full event rings poorl=
y,
> >> -        * generate an event at least every 8th TD to clear the event =
ring
> >> +        * host handles full event rings poorly, force an interrupt at=
 least
> >> +        * every 32 isoc TRB to clear the event ring.
> >>            */
> >> -       if (i && ir->isoc_bei_interval && xhci->quirks & XHCI_AVOID_BE=
I)
> >> +       if (i && ir->isoc_bei_interval)
> >>
> > For Synopsys DWC31 2.00a IP and earlier versions, the corresponding
> > driver is in drivers/usb/dwc3/core.c.
> > If XHCI_AVOID_BEI quirk is not enabled, in other words, an interrupt
> > is triggered every 32nd isoc trb, then
> > the event ring may be full. After the event ring is full, the
> > controller cannot trigger an interrupt, causing the driver
> > to timeout.
>
> I was thinking of turning XHCI_AVOID_BEI behavior into the new default, s=
o no
> quirk flag would be needed:
>
> Currently without the quirk flag:
>
> - ISOC TRBs trigger interrupt if TRB is the last in the TD
>
> Currently with XHCI_AVOID_BEI quirk flag:
>
> - ISOC TRBs trigger interrupt if TRB is the last in the TD
> - Interrupt is additionally triggered every 32 isoc TRB (initially).
> - if more than 128 events are processed in one interrupt then the
>    32 is halved, and we trigger an interrupts every 16th isoc TRB, and so
>    on, 16 -> 8...
>
> I would remove the quirk flag, and make all controllers interrupt
> behave as if it was set. i.e. interrupt at least every 32 isoc TRB

Thank you for your detailed analysis.
Excuse me, I have a question, do you mean to set "Currently with
XHCI_AVOID_BEI quirk flag" as the default behavior?
>
> > My initial solution:
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > index a171b27a7845..1e33e58c7281 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
> >
> >   int dwc3_host_init(struct dwc3 *dwc)
> >   {
> > -       struct property_entry   props[5];
> > +       struct property_entry   props[6];
> >          struct platform_device  *xhci;
> >          int                     ret, irq;
> >          int                     prop_idx =3D 0;
> > @@ -180,6 +180,9 @@ int dwc3_host_init(struct dwc3 *dwc)
> >          if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
> >                  props[prop_idx++] =3D
> > PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
> >
> > +       if (DWC3_VER_IS_WITHIN(DWC31, ANY, 200A))
> > +               props[prop_idx++] =3D PROPERTY_ENTRY_BOOL("quirk-avoid-=
bei");
> > +
> >          if (prop_idx) {
> >                  ret =3D device_create_managed_software_node(&xhci->dev=
,
> > props, NULL);
> >                  if (ret) {
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.=
c
> > index 3d071b875308..e1071827d4b3 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev,
> > struct device *sysdev, const s
> >                  if (device_property_read_bool(tmpdev, "quirk-broken-po=
rt-ped"))
> >                          xhci->quirks |=3D XHCI_BROKEN_PORT_PED;
> >
> > +               if (device_property_read_bool(tmpdev, "quirk-avoid-bei"=
))
> > +                       xhci->quirks |=3D XHCI_AVOID_BEI;
> > +
> >                  if (device_property_read_bool(tmpdev,
> > "xhci-sg-trb-cache-size-quirk"))
> >                          xhci->quirks |=3D XHCI_SG_TRB_CACHE_SIZE_QUIRK=
;
> >
> > I consider that enabling XHCI_AVOID_BEI quirk will increase the number
> > of isoc transmission
> > interrupts, and some specific applications of products may not have
> > full event rings.
> > For Synopsys DWC31 2.00a IP and earlier versions, XHCI_AVOID_BEI quirk
> > is forced to be enabled,
> > which is not the best solution. Therefore, the second solution is
> > generated, which is to remove the
> > modification of drivers/usb/dwc3/host.c file, only keep
> > drivers/usb/host/xhci-plat.c, enable XHCI_AVOID_BEI
> > quirk by adding dts configuration. Let users decide whether to enable
> > XHCI_AVOID_BEI quirk based on
> > the specific application of the product.
>
> Is there an actual real world case where interrupting every 32nd ISOC TRB=
 is
> too often?

I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt will
be triggered every 8 TRBs, which makes the interrupts seem to be quite
frequent.
Thanks
Jos

>
> UVC driver for example has defined UVC_MAX_PACKETS 32, meaning a common i=
soc
> usb camera has max 32 TRBs per TD, and naturally interrupt at least every=
 32
> isoc TRB
>
> To me the problem seems to be the other way around, we see cases like thi=
s where
> we are not interrupting often enough, and event ring fills up.
>
> Thanks
> Mathias
>

