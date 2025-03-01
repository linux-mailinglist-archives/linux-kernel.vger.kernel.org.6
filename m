Return-Path: <linux-kernel+bounces-539727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D475A4A7D7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6623BC4CA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D915624D;
	Sat,  1 Mar 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLdRVc61"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D222087;
	Sat,  1 Mar 2025 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794725; cv=none; b=JY/1M2CxQNXJEoe1pVZwGCik9Zc+3G1FOdjHavCaNVSlFtyaIVrrOKrhY/JBGKW3xR314T5KgmJKUpQplpWmEGEpMov4vFtg3ySakRUwJXhZps/MaKUuhnuuZOAsncvt3MtrRGroM2eliwYSxWMjIzgfJuW3jZXduXxYl96w2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794725; c=relaxed/simple;
	bh=m+ygO2tcknG8sblxk7ujAKGzVcl1OORFp0lLOwIDTEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbtqW1KXcbsQcHa64DdEMfHmItQ1lVX2j+EqDa0RD5P5FZoKJNxSuZgBbtjxzs+EswlNQF7+ZTY1Xtwa9QQmnCELq1tV484G/Ay5PPU2v9pVwBTQQjuq6IuCWcQtgv5WCo8rVTA5PcQRNxBROVoP/87bCLaicoZeJtlr/Jkn5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLdRVc61; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fe9c1c14baso1645819eaf.0;
        Fri, 28 Feb 2025 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740794722; x=1741399522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl1Ha5BhbfiW1ZQNVbip8NiE2DRjxBPB6ldGIH/dPlw=;
        b=WLdRVc61eXcwmSupW4LF1Ip3sWXTKw9aZq2/JCAbAyCuFEW0xnzWJ9Z4gSQ1thXdpl
         eTl0tDElUDp6UTfN1XcqtgJ8TtgukPgRUqgfHcc22BUzGEgOz3G27eL47ezEnxkS71B+
         dQ8nCuQSndvblfL1WsvccPJNAjAI6RaSTXYY7MhL+2Fe+Za9Wxi7WxxB/Lyn+29GuuQT
         dFNqdBwlX2rAqJjwcqHB5XKAnL0ToEQWJpB/h+NQ2eTDB6NhQYbFGTtAS4YPPqSFg2KQ
         Fcv2ldPw7anP9AnIKZt4V31zVNUhk+gTp9qzlDAyeMd56OeVY4FVwZsLG1riAUuzwQXj
         7Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794722; x=1741399522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl1Ha5BhbfiW1ZQNVbip8NiE2DRjxBPB6ldGIH/dPlw=;
        b=CAqI/eKFVU9U1hCwxpVKwzFjmsZhmvamWPCeBT1m6zwCA/ypEjkrXQ+slorjpUowHa
         JV1XY0NRmW9l2Jx6DEV4tjpEYW6a70cdh+KCrxUNqqbbdJz5R4t4YmqygYfDuOwIE9w9
         rJXQ3jD2BtEKTO7j0+TnMpwdY0yBgAqg3haYnT702WW2qCG0HwPW1goovZmHZkrdUDNw
         xRWYu/G4ao5xXpN2NZTRjVWgO7TVS9r1r3FSGFFBtW9ChCywxvvCpynFWG6jeNBIMJs/
         WHl/geh/UTEho2ZCn+mem3FPlPwnLF/98wINHTwZqrKP6yDeP8fryDfdyYH2CZ+tWfBb
         6B4g==
X-Forwarded-Encrypted: i=1; AJvYcCV8agOcJFBv0lzN/RP4k0MizovIIvW/NI08v79nUl3KR81JPKBTgyPVw4O/hu9spX3TxvYe6OjvzrPFfX8=@vger.kernel.org, AJvYcCVB/7y6LOKKtDjhFazRbebbreaCKmfv9TSTrCta/ZI3sj/nGTqYVkcvwhYd+BQXuXfmr71NCnCXV5fL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzb0Yn78iTYZO3qEnuJ40zIaet1LqzEO2MoXK+GqufeUabsJvh
	4qJiJQSKOUUwaGWD9M1Fx2qAzQIpRNmotKt+oWMwcI5m984s7BXkWiXc09zFR1rE7BdsotjJN8t
	oBC/kLQUvIgnXb48Jav0g+maO0yw=
X-Gm-Gg: ASbGnctanOAF5wsouvjxwwPo/e+A+g1uErhmPkAhzw5kFr7ewSBoABgU4K5pJAj4AVv
	8EB9HMGXWkNWQ02c5GzLpOJ0IozUU2VIDnAyJaz3gjzW4n3zi2yDPUdMJL5AtgzFy0bQEdrCoqv
	HZ3lMD5fECTyEXaN5dNXwYi+UCAmQ=
X-Google-Smtp-Source: AGHT+IHk8X3H0cDV3irm0FqHyRRW4ZKx+25qxp8Mopli3+Kruo9jL2ZKwahev2zYgDK6dRSxyKae1c7Ejks/OLhscy0=
X-Received: by 2002:a05:6820:553:b0:5fc:a89b:a339 with SMTP id
 006d021491bc7-5feb355f64bmr2871950eaf.4.1740794722554; Fri, 28 Feb 2025
 18:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com> <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
In-Reply-To: <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Sat, 1 Mar 2025 10:05:11 +0800
X-Gm-Features: AQ5f1Jp-KQGCCnxHpXg1OX-unCd8Je_ZMxb-54_GY7vHnGJ3yj1fOBZU29MLcNo
Message-ID: <CAHN5xi0mf8G4ODMQ9jDXAM4CRXtafZeMh_2KF7efbiFJahO4bw@mail.gmail.com>
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc enpoints
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: michal.pecio@gmail.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patch.

Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B43=E6=
=9C=881=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:17=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Unplugging a USB3.0 webcam from Etron hosts while streaming results
> in errors like this:
>
> [ 2.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not p=
art of current TD ep_index 18 comp_code 13
> [ 2.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630=
 trb-start 000000002fdf8640 trb-end 000000002fdf8650
> [ 2.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not p=
art of current TD ep_index 18 comp_code 13
> [ 2.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660=
 trb-start 000000002fdf8670 trb-end 000000002fdf8670
>
> Etron xHC generates two transfer events for the TRB if an error is
> detected while processing the last TRB of an isoc TD.
>
> The first event can be any sort of error (like USB Transaction or
> Babble Detected, etc), and the final event is Success.
>
> The xHCI driver will handle the TD after the first event and remove it
> from its internal list, and then print an "Transfer event TRB DMA ptr
> not part of current TD" error message after the final event.
>
> Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> transaction error mid TD.") is designed to address isoc transaction
> errors, but unfortunately it doesn't account for this scenario.
>
> This issue is similar to the XHCI_SPURIOUS_SUCCESS case where a success
> event follows a 'short transfer' event, but the TD the event points to
> is already given back.
>
> Expand the spurious success 'short transfer' event handling to cover
> the spurious success after error on Etron hosts.
>
> Kuangyi Chiang reported this issue and submitted a different solution
> based on using error_mid_td. This commit message is mostly taken
> from that patch.
>
> Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci-ring.c | 36 +++++++++++++++++++++++++-----------
>  drivers/usb/host/xhci.h      |  2 +-
>  2 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 965bffce301e..3d3e6cd69019 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct xhc=
i_hcd *xhci, struct xhci_virt_
>         return 0;
>  }
>
> +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
> +                                          struct xhci_ring *ring)
> +{
> +       switch (ring->old_trb_comp_code) {
> +       case COMP_SHORT_PACKET:
> +               return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
> +       case COMP_USB_TRANSACTION_ERROR:
> +       case COMP_BABBLE_DETECTED_ERROR:
> +       case COMP_ISOCH_BUFFER_OVERRUN:
> +               return xhci->quirks & XHCI_ETRON_HOST &&
> +                       ring->type =3D=3D TYPE_ISOC;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /*
>   * If this function returns an error condition, it means it got a Transf=
er
>   * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
> @@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>         case COMP_SUCCESS:
>                 if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) !=3D =
0) {
>                         trb_comp_code =3D COMP_SHORT_PACKET;
> -                       xhci_dbg(xhci, "Successful completion on short TX=
 for slot %u ep %u with last td short %d\n",
> -                                slot_id, ep_index, ep_ring->last_td_was_=
short);
> +                       xhci_dbg(xhci, "Successful completion on short TX=
 for slot %u ep %u with last td comp code %d\n",
> +                                slot_id, ep_index, ep_ring->old_trb_comp=
_code);
>                 }
>                 break;
>         case COMP_SHORT_PACKET:
> @@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>                  */
>                 if (trb_comp_code !=3D COMP_STOPPED &&
>                     trb_comp_code !=3D COMP_STOPPED_LENGTH_INVALID &&
> -                   !ep_ring->last_td_was_short) {
> +                   !xhci_spurious_success_tx_event(xhci, ep_ring)) {
>                         xhci_warn(xhci, "Event TRB for slot %u ep %u with=
 no TDs queued\n",
>                                   slot_id, ep_index);
>                 }
> @@ -2890,11 +2906,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>
>                         /*
>                          * Some hosts give a spurious success event after=
 a short
> -                        * transfer. Ignore it.
> +                        * transfer or error on last TRB. Ignore it.
>                          */
> -                       if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
> -                           ep_ring->last_td_was_short) {
> -                               ep_ring->last_td_was_short =3D false;
> +                       if (xhci_spurious_success_tx_event(xhci, ep_ring)=
) {
> +                               xhci_dbg(xhci, "Spurious event dma %pad, =
comp_code %u after %u\n",
> +                                        &ep_trb_dma, trb_comp_code, ep_r=
ing->old_trb_comp_code);
> +                               ep_ring->old_trb_comp_code =3D trb_comp_c=
ode;
>                                 return 0;
>                         }
>
> @@ -2922,10 +2939,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>          */
>         } while (ep->skip);
>
> -       if (trb_comp_code =3D=3D COMP_SHORT_PACKET)
> -               ep_ring->last_td_was_short =3D true;
> -       else
> -               ep_ring->last_td_was_short =3D false;
> +       ep_ring->old_trb_comp_code =3D trb_comp_code;
>
>         ep_trb =3D &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_=
trb)];
>         trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) e=
p_trb, ep_trb_dma);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 8c164340a2c3..c75c2c12ce53 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1371,7 +1371,7 @@ struct xhci_ring {
>         unsigned int            num_trbs_free; /* used only by xhci DbC *=
/
>         unsigned int            bounce_buf_len;
>         enum xhci_ring_type     type;
> -       bool                    last_td_was_short;
> +       u32                     last_td_comp_code;

Should be changed to old_trb_comp_code.

>         struct radix_tree_root  *trb_address_map;
>  };
>
> --
> 2.43.0
>

I'll test this later.

Thanks,
Kuangyi Chiang

