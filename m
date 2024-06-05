Return-Path: <linux-kernel+bounces-201779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA38FC310
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9713B22023
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89003169AE1;
	Wed,  5 Jun 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS3BF3Q9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AB169365;
	Wed,  5 Jun 2024 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565873; cv=none; b=nEBlkC+zAMOCq6nkB3bi3AV+Zr1US7KH4HNGbAc5CExUb9G4NMd0us0BlA/o7RGDrkRyQq0Mg/iiOY2OV+vSDT67+rPwYpurJEJW2IrD8xBHoc5ywMiMMAqD2qe3B5MzwIZR9esaXhnrqqhvJKmwENSzuSmP3ZeIAcgtgE5g7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565873; c=relaxed/simple;
	bh=l852dA5VN+Px8tiG3tto5KW7f7rbKSIorgVQDfsWO5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdfOBdaMG0zSQj/ASm6POjXTZDA+rIn6+eZs+mx58E+eV5/kXFW2kBgD7MP7Mcs5+nBGmMaWA3EP7+FgX6K6XuZp3I4KoIKdVWwrApxan3CfXseZBO4yalMGFTm9rvuBrvJ0v/AUVgLVZZIJRYLX06jl8AkRdpWpMYPSODbtCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS3BF3Q9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso2246553a12.1;
        Tue, 04 Jun 2024 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717565870; x=1718170670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivP6gp59oSgNT/63LBG6JxCWkINInb5yAeO9GehaLuY=;
        b=hS3BF3Q9CkTX5j+lDjgIO8q3YLiiHFaduxFPkOj1jvzoEHaWtMIyJdaFL6JlRgM5Qt
         rdn11QFQpnlwCCnnh0Gu94l1W0Qpxk5MBypefQMqExdG/KcclOrvXRQfJUnI2CCvo+w5
         0pUWDFAvCC18o622PzdGkrm3pMlssXikPaeancFVV7MLDtjKSJK1d+99QhmdFlgzgyPG
         GAh216UjPxS5vnJ3m6V1oRU9+Sm11KQMnTjk24L13hNe3b9cAErNhksqyZCiItR/YIRc
         Q7lQ7DLgv2wWvZpNS1HZxaP2ijaRkI9k6q6OOAOnNLGNAf+au85X8gtCa08o6Ndt/DEC
         hjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717565870; x=1718170670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivP6gp59oSgNT/63LBG6JxCWkINInb5yAeO9GehaLuY=;
        b=wdbhKkupx9ldqM6Po8/VCch+/QEt/jpYkBBlD8EGKOvwpTB74FL0OHW8iZjmAANy6b
         KaNCx+cnjefIUu3iB9OS1TIYvh2aZzNB7g2Xrrpq2lTe/eWcKALux0XYixX+pvHa815Z
         tJ3tv2vHvKKTEPBH+ezACpCZNph+UvSNiahXCsJZosIt2kR+6bnvmWe9ymHlZKytm+8c
         WvRuSHXae588CD1pgV0jQG4uRhsR5Lvpjza8G/3d8PmHGDm3umWnMmFBIrIaWyGDP3Wp
         bDOpj3XmqC00QMfMLClR7hmpasSSFVuOMk8aq3yWbkPR1xGUSReoGGIvFBUnV8QvPxsN
         g9wA==
X-Forwarded-Encrypted: i=1; AJvYcCWZL4N/wE0Kbr+uhvmSR6r/4peJkF5MtQNmpYY5QWyiGsELp8kWkxqXMMB1clTVat8IPdw+j1xCD3c2w6zjWvf6O1uGGEX5yn8GmLavSADVvMrta1wQw84CWjYpgFyu7P/uPbAeFKeo
X-Gm-Message-State: AOJu0YzNSQheGGbsMQfaooHp8pM3G1AkMoG+Sm4QLdgu/ynLjNaEJ8sr
	dyEySQyqF0G492GqJgW69I8wuwtfvq5zK/1QegbIR4a7Ln8RTQeKxyZIjp+jNMJeR4cc5JmKdpF
	XJcba2WjmRM86Ur9DNAGNrxalX4qzvFamgv+YJAfq
X-Google-Smtp-Source: AGHT+IEsxK+r1Wx6TldqiWnh624UIExMEkJxS6bwboqAI5FAekmb5Lcfxp66ZKNXV8f+tAmU49vdz4wFMsw4xgTzGJw=
X-Received: by 2002:a17:907:ca2a:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a699f87f0c8mr73594766b.37.1717565869768; Tue, 04 Jun 2024
 22:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601120640.73556-1-joswang1221@gmail.com> <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
In-Reply-To: <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
From: joswang <joswang1221@gmail.com>
Date: Wed, 5 Jun 2024 13:37:39 +0800
Message-ID: <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:21=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 1.6.2024 15.06, joswang wrote:
> > From: joswang <joswang@lenovo.com>
> >
> > For Synopsys DWC31 2.00a and earlier versions, every isochronous
> > interval the BEI(Block Event Interrupt) flag is set for all except
> > the last Isoch TRB in a URB, host controller consumes the event
> > TRBs in the event ring, once the event ring is full, it will not
> > generate an interrupt and will stop all data transmission and command
> > execution.
> >
> > To avoid the problem of event ring full, the XHCI-AVOID-BEI quirk is
> > introduced. Currently, the XHCI-AVOID-BEI quirk has been applied to all
> > Intel xHCI controllers, see commit '227a4fd801c8 ("USB: xhci: apply
> > XHCI-AVOID-BEI quirk to all Intel xHCI controllers")'.
> >
> > For Linux system, each event ring consists of one or more event ring
> > segments and each segment is 4 KB that contains 256 TRBs. It seems that
> > the TRBs on the event ring are sufficient and the event ring will not b=
e
> > full. In real application, if it does happen, event ring is full, host
> > controller no interrupt causes the driver to timeout.
> >
> > However, applying XHCI-AVOID-BEI quirk will also bring power consumptio=
n
> > issues. We can consider the application scenarios of the product to dec=
ide
> > whether to enable it. Therefore, we add the enable XHCI-AVOID-BEI quirk
> > through dts configuration to make it more flexible.
>
> Took a look at XHCI_AVOID_BEI quirk and it seems that it evolved from
> solving a hardware issue into a interrupt trigger optimization.
Thanks for reviewing the code.
Yes, you optimized the interrupt triggering frequency.
>
> How about making current XHCI_AVOID_BEI the default behavior, i.e. force
> an interrupt every 32nd isoc trb, and reduce it in case event ring
> has more than half a segments of events per interrupt.
Yes=EF=BC=8Cenabling XHCI_AVOID_BEI quirk is to solve the problem of event =
ring fullness
>
> The actual XHCI_AVOID_BEI quirk would only be used for hardware that that
> can't handle BEI flag properly
>
> something like:
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 266fcbc4bb93..dd161ebf15a3 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3991,16 +3991,17 @@ static int xhci_get_isoc_frame_id(struct xhci_hcd=
 *xhci,
>   static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, in=
t i,
>                                   struct xhci_interrupter *ir)
>   {
> -       if (xhci->hci_version < 0x100)
> +       if (xhci->hci_version < 0x100 || xhci->quirks & XHCI_AVOID_BEI)
>                  return false;
> +
>          /* always generate an event interrupt for the last TD */
>          if (i =3D=3D num_tds - 1)
>                  return false;
>          /*
> -        * If AVOID_BEI is set the host handles full event rings poorly,
> -        * generate an event at least every 8th TD to clear the event rin=
g
> +        * host handles full event rings poorly, force an interrupt at le=
ast
> +        * every 32 isoc TRB to clear the event ring.
>           */
> -       if (i && ir->isoc_bei_interval && xhci->quirks & XHCI_AVOID_BEI)
> +       if (i && ir->isoc_bei_interval)
>
For Synopsys DWC31 2.00a IP and earlier versions, the corresponding
driver is in drivers/usb/dwc3/core.c.
If XHCI_AVOID_BEI quirk is not enabled, in other words, an interrupt
is triggered every 32nd isoc trb, then
the event ring may be full. After the event ring is full, the
controller cannot trigger an interrupt, causing the driver
to timeout.
My initial solution:
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index a171b27a7845..1e33e58c7281 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)

 int dwc3_host_init(struct dwc3 *dwc)
 {
-       struct property_entry   props[5];
+       struct property_entry   props[6];
        struct platform_device  *xhci;
        int                     ret, irq;
        int                     prop_idx =3D 0;
@@ -180,6 +180,9 @@ int dwc3_host_init(struct dwc3 *dwc)
        if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
                props[prop_idx++] =3D
PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");

+       if (DWC3_VER_IS_WITHIN(DWC31, ANY, 200A))
+               props[prop_idx++] =3D PROPERTY_ENTRY_BOOL("quirk-avoid-bei"=
);
+
        if (prop_idx) {
                ret =3D device_create_managed_software_node(&xhci->dev,
props, NULL);
                if (ret) {
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..e1071827d4b3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev,
struct device *sysdev, const s
                if (device_property_read_bool(tmpdev, "quirk-broken-port-pe=
d"))
                        xhci->quirks |=3D XHCI_BROKEN_PORT_PED;

+               if (device_property_read_bool(tmpdev, "quirk-avoid-bei"))
+                       xhci->quirks |=3D XHCI_AVOID_BEI;
+
                if (device_property_read_bool(tmpdev,
"xhci-sg-trb-cache-size-quirk"))
                        xhci->quirks |=3D XHCI_SG_TRB_CACHE_SIZE_QUIRK;

I consider that enabling XHCI_AVOID_BEI quirk will increase the number
of isoc transmission
interrupts, and some specific applications of products may not have
full event rings.
For Synopsys DWC31 2.00a IP and earlier versions, XHCI_AVOID_BEI quirk
is forced to be enabled,
which is not the best solution. Therefore, the second solution is
generated, which is to remove the
modification of drivers/usb/dwc3/host.c file, only keep
drivers/usb/host/xhci-plat.c, enable XHCI_AVOID_BEI
quirk by adding dts configuration. Let users decide whether to enable
XHCI_AVOID_BEI quirk based on
the specific application of the product.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..e1071827d4b3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev,
struct device *sysdev, const s
                if (device_property_read_bool(tmpdev, "quirk-broken-port-pe=
d"))
                        xhci->quirks |=3D XHCI_BROKEN_PORT_PED;

+               if (device_property_read_bool(tmpdev, "quirk-avoid-bei"))
+                       xhci->quirks |=3D XHCI_AVOID_BEI;
+
                if (device_property_read_bool(tmpdev,
"xhci-sg-trb-cache-size-quirk"))
                        xhci->quirks |=3D XHCI_SG_TRB_CACHE_SIZE_QUIRK;
Please help evaluate, thank you.
>
> Thanks
> Mathias
>

