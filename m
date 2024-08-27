Return-Path: <linux-kernel+bounces-303809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9496154F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E762283679
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02221CFEA4;
	Tue, 27 Aug 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MKgM9ZlP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F751BFE02
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779149; cv=none; b=evwAwF5KByM541/zHocS0k3EdasVZynrHN/mKm6tyuebusaK89lxtwm7YK0ZLi6NUwn6VVLsw0eH8wkkiHGYDjjvN6zCfUbApCNQ8qsmxijK2v3rbilveVM4r8EPXSLxbKOlT+qVVwjPtJZ8v7Fn4M4aH1+zXTZjKxuVNCi7TzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779149; c=relaxed/simple;
	bh=NWgFP5KVDbToJhlJviC9mZMGZQZ789dYx8k8Bq8m3h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjl52qrEXxhWyHLVrrQt3u/N71ow2Kn0zwbdR5jlcTNmBBWL0naKNDmI6G10YZR4ZGOrUslY5239hGjgMECbKV8MqEjlub8w8Ap+sAMJeTwJzU+7Xtqj6PpYiyGmPIYZ6vq4zwB3Dtd28XQ3zQ0RV9ZtEbtuBkJ8hF+8MC3I/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MKgM9ZlP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86a0b5513aso487488866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724779145; x=1725383945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F902tn07rWooDCnlmBpJkGqy61VBHRp/GRQFZejgCig=;
        b=MKgM9ZlPKf8blRiw8RjFJNvCdbkXSl+VmkVT43s9vlJxddZjK0JwVoRjPACeIqEdq1
         riGitoB4njEBBztR70lUI291jhcX2FakoQCWsGTcRC90cdR6zMslPJXjkIvjAwxp2BOC
         iOdUld+72J6eG+zY5QsL2Als3cwY4m7Mh9HoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779145; x=1725383945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F902tn07rWooDCnlmBpJkGqy61VBHRp/GRQFZejgCig=;
        b=AzV2IyqHcTck6pk5S4+kBbonSDYVKZ7IUrehhH33hVZqZicGEW7XUJMV/VX+WDkEy0
         TPLU0Tp+y2f/E0q+wcDeTlKJX1n1evUdHe32Ms2A5J3ixdMd4wVQ0pg8kY3KHlavRu1J
         KajmoiM8pDkMIrtyfpPAz0FU6sUmNukvPPDQm1szmtiY1ft+3EzH2JSKd6qiGlwHeWtq
         iZi7OZpItLlhQCyqRjTNZTrOfnPb0D51epzhr+x+mvxa000+s8wC7mRroI3Gd/AV0nHQ
         VrZrL/UbJcC5Etorv8Wh8iXGghBdS49ZqYbEiDgsK5+ufQl7yrVWPPitYCv5PKfVQVZ0
         FbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8YyXKhm10xkwG4trweVk1zjjd6knGYw1r72pumxrzpYmEVTgxtPjKUvgtYimQFvZeEr10ulvV7VeelMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguSm+/Dp2vCVHymR4hLl7QNOJibtGE1tiQCYOf6eR83sRKwez
	8MGUcMOH7RA8w1DAn3Zb+qZ2yeFvfT9oWfvHbO/Ug1TaBI1WIMGq7QewGjsCBjaWjFKiPNYiB9Q
	gsOBRX0zu80z/rchCv3MuPnjlcDPy+aCYZ4hl7A==
X-Google-Smtp-Source: AGHT+IEqknsIJsxEYHKsLfZm+FOibLo5EdYIPqAiirTO3UXOu8KVXZPl3Vn2ytt+tIyU+FoXNjogO8zw4Z20WcNg+sM=
X-Received: by 2002:a17:907:e251:b0:a7a:8378:625c with SMTP id
 a640c23a62f3a-a86a52de6aemr1041755766b.36.1724779144296; Tue, 27 Aug 2024
 10:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYUPR06MB6217549161B67D996EB3DCE3D2942@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To: <TYUPR06MB6217549161B67D996EB3DCE3D2942@TYUPR06MB6217.apcprd06.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 27 Aug 2024 19:18:51 +0200
Message-ID: <CAOf5uw=-giw8DSY3cX_No73THAwbKc+5Pgy8Vap-AeeF5h+VrA@mail.gmail.com>
Subject: Re: [PATCH v8] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K <quic_prashk@quicinc.com>, 
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"opensource.kernel" <opensource.kernel@vivo.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi =E8=83=A1=E8=BF=9E=E5=8B=A4

On Tue, Aug 27, 2024 at 12:19=E2=80=AFPM =E8=83=A1=E8=BF=9E=E5=8B=A4 <hulia=
nqin@vivo.com> wrote:
>
> From: Lianqin Hu <hulianqin@vivo.com>
>
> Considering that in some extreme cases, when the unbind operation
> is being executed, gserial_disconnect has already cleared gser->ioport,
> and gs_read_complete gets called afterwards, which results in accessing
> null pointer, add a null pointer check to prevent this situation.
>

Was better not to get rid of the test case. What config.usb in android does=
 is
trigger a gadget reconfiguration on this property change. It means that I e=
xpect
the android test, try to change gadget and moving from one type to
another in a loop.
Is that correct? If so will be nice that you describe

> Added a static spinlock to prevent gser->ioport from becoming
> null after the newly added check.
>
> Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000001a8
> pc : gs_read_complete+0x58/0x240
> lr : usb_gadget_giveback_request+0x40/0x160
> sp : ffffffc00f1539c0
> x29: ffffffc00f1539c0 x28: ffffff8002a30000 x27: 0000000000000000
> x26: ffffff8002a30000 x25: 0000000000000000 x24: ffffff8002a30000
> x23: ffffff8002ff9a70 x22: ffffff898e7a7b00 x21: ffffff803c9af9d8
> x20: ffffff898e7a7b00 x19: 00000000000001a8 x18: ffffffc0099fd098
> x17: 0000000000001000 x16: 0000000080000000 x15: 0000000ac1200000
> x14: 0000000000000003 x13: 000000000000d5e8 x12: 0000000355c314ac
> x11: 0000000000000015 x10: 0000000000000012 x9 : 0000000000000008
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffff887cd12000
> x5 : 0000000000000002 x4 : ffffffc00f9b07f0 x3 : ffffffc00f1538d0
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000001a8
> Call trace:
> gs_read_complete+0x58/0x240
> usb_gadget_giveback_request+0x40/0x160
> dwc3_remove_requests+0x170/0x484
> dwc3_ep0_out_start+0xb0/0x1d4
> __dwc3_gadget_start+0x25c/0x720
> kretprobe_trampoline.cfi_jt+0x0/0x8
> kretprobe_trampoline.cfi_jt+0x0/0x8
> udc_bind_to_driver+0x1d8/0x300
> usb_gadget_probe_driver+0xa8/0x1dc
> gadget_dev_desc_UDC_store+0x13c/0x188
> configfs_write_iter+0x160/0x1f4
> vfs_write+0x2d0/0x40c
> ksys_write+0x7c/0xf0
> __arm64_sys_write+0x20/0x30
> invoke_syscall+0x60/0x150
> el0_svc_common+0x8c/0xf8
> do_el0_svc+0x28/0xa0
> el0_svc+0x24/0x84
> el0t_64_sync_handler+0x88/0xec
> el0t_64_sync+0x1b4/0x1b8
> Code: aa1f03e1 aa1303e0 52800022 2a0103e8 (88e87e62)
> ---[ end trace 938847327a739172 ]---
> Kernel panic - not syncing: Oops: Fatal exception
>
> Fixes: c1dca562be8a ("usb gadget: split out serial core")
> Cc: stable@vger.kernel.org
> Suggested-by: Prashanth K <quic_prashk@quicinc.com>
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v8: Updated patch submission description as suggested in v7 discussion.
> v7: Remove code comments.
> v6: Update the commit text.
> v5: Add the Fixes tag.
> v4: CC stable kernel.
> v3: Add serial_port_lock protection when checking port pointer.
> v2: Optimize code comments.
> v1: Delete log printing.
>
>  drivers/usb/gadget/function/u_serial.c | 31 +++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/=
function/u_serial.c
> index b394105e55d6..66d918523b3e 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -452,20 +452,41 @@ static void gs_rx_push(struct work_struct *work)
>
>  static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -       struct gs_port  *port =3D ep->driver_data;
> +       struct gs_port  *port;
> +       unsigned long  flags;
> +
> +       spin_lock_irqsave(&serial_port_lock, flags);
> +       port =3D ep->driver_data;
> +
> +       if (!port) {
> +               spin_unlock_irqrestore(&serial_port_lock, flags);
> +               return;
> +       }
>
> -       /* Queue all received data until the tty layer is ready for it. *=
/
>         spin_lock(&port->port_lock);
> +       spin_unlock(&serial_port_lock);
> +
> +       /* Queue all received data until the tty layer is ready for it. *=
/
>         list_add_tail(&req->list, &port->read_queue);
>         schedule_delayed_work(&port->push, 0);
> -       spin_unlock(&port->port_lock);
> +       spin_unlock_irqrestore(&port->port_lock, flags);
>  }
>
>  static void gs_write_complete(struct usb_ep *ep, struct usb_request *req=
)
>  {
> -       struct gs_port  *port =3D ep->driver_data;
> +       struct gs_port  *port;
> +       unsigned long  flags;
> +
> +       spin_lock_irqsave(&serial_port_lock, flags);
> +       port =3D ep->driver_data;
> +
> +       if (!port) {
> +               spin_unlock_irqrestore(&serial_port_lock, flags);
> +               return;
> +       }
>
>         spin_lock(&port->port_lock);
> +       spin_unlock(&serial_port_lock);
>         list_add(&req->list, &port->write_pool);
>         port->write_started--;
>
> @@ -486,7 +507,7 @@ static void gs_write_complete(struct usb_ep *ep, stru=
ct usb_request *req)
>                 break;
>         }
>
> -       spin_unlock(&port->port_lock);
> +       spin_unlock_irqrestore(&port->port_lock, flags);
>  }
>
>  static void gs_free_requests(struct usb_ep *ep, struct list_head *head,
> --

I can base my review on what was done before for suspend/resume and
this implementation looks the same.
I don't think that both are optimal but this should avoid race on completio=
n.

Michael

> 2.39.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

