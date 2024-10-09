Return-Path: <linux-kernel+bounces-356500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74BF9961FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076151F233BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C2184527;
	Wed,  9 Oct 2024 08:11:40 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BD18872F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461499; cv=none; b=bB+i/yVfXWNtEhGheflrWfdfSjQNQ/9Xzq5DKH2p/u4oAd8uwbDboNfTT/QUj+NmKSvmDsrQ2CG8AKs9zVeOOTbpng//c4d1HW2DFl5PHUUJWik80/CyvHlsgfhTuAfl2P1O9rNM2onIx14dcUM28hejqJzkWfgoCLNF9QHhw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461499; c=relaxed/simple;
	bh=wiwkY2xo0Ar7nDNvoBr0VD6znJPf4NhqPdh1THn2SOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siqheGn9G5P/9sP7F2fBUwn602THoM9cWqta/0EzjRLo36CQ5bC6G5luw0nRLsMOcCYnk9wHPs+XSX1/XwT9gH6q1zo4c7tTzJY3EY7lwIBPeN1nN49XPV6n9HvLJn165sM9BkwMT2Cnn47FVBV66MRhlGIItO2Cmq92woEUXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9932aa108cso656558966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461495; x=1729066295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a5+0M9H/wWhUYSVgpJpB37C2tEsqtnox/q8tbp9Cfw=;
        b=NAvCi3gtpc9/57CUikx00ka6sjVMBsKVOJKYI5ckkXSXoBSP8S2VVKWU+vS4XEXjBr
         WrC4WhqKaMm7Y0BPRebWEeUlNmfgkZ1+0CGBOgQl638scnJ+66LyKy1eyS/42PuFeggT
         ZgtY7NZZ7wZVId8EAUiKiE7EEyUZ7xVdVw86NHo6giUwDq/C/nSiQWj8r2uh74IRUIRp
         F3DAff0xQxgLW2fGpfMxl7WyCxZxiFsi/3e5yuKMmgNlAvHbRrXWhuD2K/n4iTqN1rFx
         LxK8ArpX7b0M/ZAAX9VqP4gEG7boIJXZlZnILF8wZP42s/WDkKAjluuXucS8cV7dW++m
         SBSQ==
X-Gm-Message-State: AOJu0YxVSjCGLofTPLaik7V3AHwVScxS/yEucqS0qsn64qeNKO9Uwp3I
	mCpO/AHONRPXkRpKXBIK480puNmpGhkemDmXdWzn8qCdm9xcf1KlH2r59zp95GFJkho21lW0Ji+
	ai9xw71Xpj8zgKQX+3qZzancTJ+I=
X-Google-Smtp-Source: AGHT+IFwsXFgMyUU8Nw/D9AVxlvYKfyWoBO9RJQ4NCOf5KL0d9CktueYOBTHoqv5UT65XUB3njAWH+DuTHsA6gLemJs=
X-Received: by 2002:a17:907:6eaa:b0:a99:7a05:a652 with SMTP id
 a640c23a62f3a-a998d114ec3mr132287266b.13.1728461495156; Wed, 09 Oct 2024
 01:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008201107.38520-1-ak.alexander.kozhinov@gmail.com>
In-Reply-To: <20241008201107.38520-1-ak.alexander.kozhinov@gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 9 Oct 2024 17:11:23 +0900
Message-ID: <CAMZ6Rq+AfFvrRG4muTyK6xrOQ-Wa8n8Ha5XG=yesna+1FGHXzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] can: gs_usb.c: add usb endpoint address detection
 at driver probe step
To: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maximilian Schneider <max@schneidersoft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Wed. 9 Oct. 2024 at 05:09, Alexander Kozhinov
<ak.alexander.kozhinov@gmail.com> wrote:
> There is an approach made to implement gs_usb firmware/driver based on
> Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
> EP addresses, if they have different last 4 bytes in absence of other
> endpoints.
>
> For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
> EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
> overwrite EP-OUT to 0x01. More information can be found in the
> discussion with Zephyr RTOS USB stack maintainer here:
>
> https://github.com/zephyrproject-rtos/zephyr/issues/67812
>
> There are already two different gs_usb FW driver implementations based
> on Zephyr RTOS:
>
> 1. https://github.com/CANnectivity/cannectivity
>    (by: https://github.com/henrikbrixandersen)
> 2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAl=
exander:zephyr:gs_usb
>    (by: https://github.com/KozhinovAlexander)
>
> At the moment both Zephyr RTOS implementations use dummy USB endpoint,
> to overcome described USB stack behavior from Zephyr itself. Since
> Zephyr RTOS is intended to be used on microcontrollers with very
> constrained amount of resources (ROM, RAM) and additional endpoint
> requires memory, it is more convenient to update the gs_usb driver in
> the Linux kernel.
>
> To fix this problem, update the gs_usb driver from using hard coded
> endpoint numbers to evaluate the endpoint descriptors and use the
> endpoints provided there.

Thanks for this v3, the code looks good but your patch series has several i=
ssue:

  - you did not put in CC the most relevant mailing list:
    linux-can@vger.kernel.org (you only added the generic
    linux-kernel@vger.kernel.org address)

  - you sent a single message with five patches. Each patch should be
    sent in a different message (but in the same thread).
    git send-email, if used correctly, should manage this for you.

  - when you address comments, you should directly add those to the
    initial patch. The idea is that you should split your work in
    different logical changes. Here, there is only one logical change:
    replace hardcoded endpoint by automatic detection and so, there
    should be only one patch.

  - Instead, you should add a quick changelog at the end of the
    patch. Typically, add a "---" (the cutter) after your
    Signed-off-by tag and put the changelog after this
    cutter. Everything after the cutter will be discarded when the
    maintainers pick-up your patch.

For extra details, refer to this guide:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html


> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Maximilian Schneider <max@schneidersoft.net>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index bc86e9b329fd..f3eb447267f9 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -43,9 +43,6 @@
>  #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
>  #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
>
> -#define GS_USB_ENDPOINT_IN 1
> -#define GS_USB_ENDPOINT_OUT 2
> -
>  /* Timestamp 32 bit timer runs at 1 MHz (1 =C2=B5s tick). Worker account=
s
>   * for timer overflow (will be after ~71 minutes)
>   */
> @@ -336,6 +333,9 @@ struct gs_usb {
>
>         unsigned int hf_size_rx;
>         u8 active_channels;
> +
> +       u8 ep_in;
> +       u8 ep_out;
>  };
>
>  /* 'allocate' a tx context.
> @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>
>  resubmit_urb:
>         usb_fill_bulk_urb(urb, parent->udev,
> -                         usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_I=
N),
> +                         usb_rcvbulkpipe(parent->udev, parent->ep_in),
>                           hf, dev->parent->hf_size_rx,
>                           gs_usb_receive_bulk_callback, parent);
>
> @@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>         }
>
>         usb_fill_bulk_urb(urb, dev->udev,
> -                         usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT)=
,
> +                         usb_sndbulkpipe(dev->udev, dev->parent->ep_out)=
,
>                           hf, dev->hf_size_tx,
>                           gs_usb_xmit_callback, txc);
>
> @@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
>                         usb_fill_bulk_urb(urb,
>                                           dev->udev,
>                                           usb_rcvbulkpipe(dev->udev,
> -                                                         GS_USB_ENDPOINT=
_IN),
> +                                                         dev->parent->ep=
_in),
>                                           buf,
>                                           dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
> @@ -1421,6 +1421,18 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         struct gs_device_config dconf;
>         unsigned int icount, i;
>         int rc;
> +       struct usb_host_interface *host_iface;
> +       struct usb_endpoint_descriptor *ep_in, *ep_out;
> +
> +       host_iface =3D intf->cur_altsetting;
> +
> +       /* Find common bulk endpoints reverse */
> +       rc =3D usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_=
out, NULL,
> +                                                                        =
               NULL);
> +       if (rc) {
> +               dev_err(&intf->dev, "Required endpoints not found\n");
> +               return rc;
> +       }
>
>         /* send host config */
>         rc =3D usb_control_msg_send(udev, 0,
> @@ -1466,6 +1478,10 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         usb_set_intfdata(intf, parent);
>         parent->udev =3D udev;
>
> +       /* store the detected endpoints */
> +       parent->ep_in =3D ep_in->bEndpointAddress;
> +       parent->ep_out =3D ep_out->bEndpointAddress;
> +
>         for (i =3D 0; i < icount; i++) {
>                 unsigned int hf_size_rx =3D 0;
>
> --
> 2.43.0
>
>
> From d0b4d3b1f5fd1b4c33bc5d8f83ed49d04a2286c4 Mon Sep 17 00:00:00 2001
> From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> Date: Tue, 8 Oct 2024 21:25:51 +0200
> Subject: [PATCH v3 2/5] can: gs_usb.c: store pipe instead of endpoint add=
ress
>
> This change implements nitpick: instead of storing the ep_in and ep_out i=
n your priv, you can
> instead directly store the result of usb_rcvbulkpipe(parent->udev,
> parent->ep_in) and usb_sndbulkpipe(dev->udev, dev->parent->ep_out).
>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index f3eb447267f9..e6511af5f692 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -334,8 +334,8 @@ struct gs_usb {
>         unsigned int hf_size_rx;
>         u8 active_channels;
>
> -       u8 ep_in;
> -       u8 ep_out;
> +       unsigned int pipe_in;
> +       unsigned int pipe_out;
>  };
>
>  /* 'allocate' a tx context.
> @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>
>  resubmit_urb:
>         usb_fill_bulk_urb(urb, parent->udev,
> -                         usb_rcvbulkpipe(parent->udev, parent->ep_in),
> +                         parent->pipe_in,
>                           hf, dev->parent->hf_size_rx,
>                           gs_usb_receive_bulk_callback, parent);
>
> @@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>         }
>
>         usb_fill_bulk_urb(urb, dev->udev,
> -                         usb_sndbulkpipe(dev->udev, dev->parent->ep_out)=
,
> +                         dev->parent->pipe_out,
>                           hf, dev->hf_size_tx,
>                           gs_usb_xmit_callback, txc);
>
> @@ -925,8 +925,7 @@ static int gs_can_open(struct net_device *netdev)
>                         /* fill, anchor, and submit rx urb */
>                         usb_fill_bulk_urb(urb,
>                                           dev->udev,
> -                                         usb_rcvbulkpipe(dev->udev,
> -                                                         dev->parent->ep=
_in),
> +                                         dev->parent->pipe_in,
>                                           buf,
>                                           dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
> @@ -1479,8 +1478,8 @@ static int gs_usb_probe(struct usb_interface *intf,
>         parent->udev =3D udev;
>
>         /* store the detected endpoints */
> -       parent->ep_in =3D ep_in->bEndpointAddress;
> -       parent->ep_out =3D ep_out->bEndpointAddress;
> +       parent->pipe_in =3D usb_rcvbulkpipe(parent->udev, ep_in->bEndpoin=
tAddress);
> +       parent->pipe_out =3D usb_sndbulkpipe(parent->udev, ep_out->bEndpo=
intAddress);
>
>         for (i =3D 0; i < icount; i++) {
>                 unsigned int hf_size_rx =3D 0;
> --
> 2.43.0
>
>
> From 6515df86641c6eda6dc3e3c4a8f1fc8625835f89 Mon Sep 17 00:00:00 2001
> From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> Date: Tue, 8 Oct 2024 21:37:13 +0200
> Subject: [PATCH v3 3/5] can: gs_usb.c: use reverse xmas tree declaration
>
> This change implements request: Move this declaration up (c.f. the Revers=
e christmas tree declarations).
>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index e6511af5f692..a88448dbc6af 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1412,6 +1412,8 @@ static int gs_usb_probe(struct usb_interface *intf,
>                         const struct usb_device_id *id)
>  {
>         struct usb_device *udev =3D interface_to_usbdev(intf);
> +       struct usb_endpoint_descriptor *ep_in, *ep_out;
> +       struct usb_host_interface *host_iface;
>         struct gs_host_frame *hf;
>         struct gs_usb *parent;
>         struct gs_host_config hconf =3D {
> @@ -1420,8 +1422,6 @@ static int gs_usb_probe(struct usb_interface *intf,
>         struct gs_device_config dconf;
>         unsigned int icount, i;
>         int rc;
> -       struct usb_host_interface *host_iface;
> -       struct usb_endpoint_descriptor *ep_in, *ep_out;
>
>         host_iface =3D intf->cur_altsetting;
>
> --
> 2.43.0
>
>
> From cddd8290dd877eddcac31366ae69188b79fc35e8 Mon Sep 17 00:00:00 2001
> From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> Date: Tue, 8 Oct 2024 21:40:59 +0200
> Subject: [PATCH v3 4/5] can: gs_usb.c: use rforward usb endpoints search
>
> This change implements request: Any specific reason for doing this in rev=
erse? The previous
> GS_USB_ENDPOINT_IN and GS_USB_ENDPOINT_OUT macros were respectively 1
> and 2, so at the beginning. And in such a case, the normal search
> would find those quicker.
>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index a88448dbc6af..24f715f9c436 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1426,8 +1426,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>         host_iface =3D intf->cur_altsetting;
>
>         /* Find common bulk endpoints reverse */
> -       rc =3D usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_=
out, NULL,
> -                                                                        =
               NULL);
> +       rc =3D usb_find_common_endpoints(host_iface, &ep_in, &ep_out, NUL=
L, NULL);
>         if (rc) {
>                 dev_err(&intf->dev, "Required endpoints not found\n");
>                 return rc;
> --
> 2.43.0
>
>
> From b65448554e172c8b419605411248d83846764a1d Mon Sep 17 00:00:00 2001
> From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> Date: Tue, 8 Oct 2024 21:43:10 +0200
> Subject: [PATCH v3 5/5] can: gs_usb.c: skip new variable declaration
>
> This change implements nipick: no need to declare a new variable for host=
_iface which is used
> only once.
>
> Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 24f715f9c436..d93410682d4b 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1413,7 +1413,6 @@ static int gs_usb_probe(struct usb_interface *intf,
>  {
>         struct usb_device *udev =3D interface_to_usbdev(intf);
>         struct usb_endpoint_descriptor *ep_in, *ep_out;
> -       struct usb_host_interface *host_iface;
>         struct gs_host_frame *hf;
>         struct gs_usb *parent;
>         struct gs_host_config hconf =3D {
> @@ -1423,10 +1422,9 @@ static int gs_usb_probe(struct usb_interface *intf=
,
>         unsigned int icount, i;
>         int rc;
>
> -       host_iface =3D intf->cur_altsetting;
> -
>         /* Find common bulk endpoints reverse */
> -       rc =3D usb_find_common_endpoints(host_iface, &ep_in, &ep_out, NUL=
L, NULL);
> +       rc =3D usb_find_common_endpoints(intf->cur_altsetting,
> +                                                                       &=
ep_in, &ep_out, NULL, NULL);
>         if (rc) {
>                 dev_err(&intf->dev, "Required endpoints not found\n");
>                 return rc;
> --
> 2.43.0
>

