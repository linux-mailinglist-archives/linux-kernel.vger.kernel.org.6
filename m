Return-Path: <linux-kernel+bounces-540931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC51A4B689
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E077A5A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618F1D5143;
	Mon,  3 Mar 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM1zBnwc"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2BAD27;
	Mon,  3 Mar 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972598; cv=none; b=TyWZVnhSbSmrnB3DUwdVVPwOgXQ1dlXEaHI76r/YK4hAh59IT1wUQF4jzZMBdGeBnCcJrUDh2EC8MSWlXY4lgO6L0VDjKKcsAmmfo9T3PnKsRhjNuM4vK+p4mhdjVR9Bby1GalfC9fDfyxa0o1BaNKHztn3PHz17G5G5IsmyUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972598; c=relaxed/simple;
	bh=WtisgUpe8nKNcHbVQ8d3kt1UOEUUroeDbfP37vsyDmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elLNhA4NWbzNQjoEwCnkhw1G4seSbP+YkIEiQtYaqqzQHUbOyDq3kW+fjMf0GwqwTl2kWaWymH/M/eP8NaOXcyeKbYQfdIM2uZMAjcSGQkDq+I7wudCoFVJLH4QayDp/T9D/NgkSx1MF/BShUwnc1KKhqVw5nSVOugjNkmi3e1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM1zBnwc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fc6fe05460so2392157eaf.1;
        Sun, 02 Mar 2025 19:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740972596; x=1741577396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpLoS55VvHYT2ILHdOJH5ho8KuNQfaCMBpbxTBAx2Sk=;
        b=AM1zBnwcNufI9CVu9wCH2mkjCn+nCxCMaWcBc6bjVfk5fn9xdJdU1Ly0I2q7QM3xEN
         F0EtDFLY0E0YK31twsIudwYT6Pcfh21QMO7I1MhxOPDmDwQC+Z3XtzjuLbQaUk2Z1cUG
         E+7S/OInRyahET4Wwwquwza/aSn+bSBYuEI5ZbhEFb9vU9f2bnsisMET44+MfkkKqQye
         5wxN7pXxzw2DTQpTofzuEWQLFLaN/7upnVbGXYkFk+GKXhqWx3plqv3A8fI4I9oR/zSy
         NrllHAfVMFWqsh5wV6LbxhECQlfNIpdGWIbBUnuwLjSxagmxebVT7Fs7IFF4xLAGdO72
         r+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740972596; x=1741577396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpLoS55VvHYT2ILHdOJH5ho8KuNQfaCMBpbxTBAx2Sk=;
        b=c5P624XlYInJRmpvX3jw+xPEeHN7J3cIfUkZhisSJdgrjIANL52QA3L9hAoiIaKd5l
         iC5Tw1b3PHrOiYAB4/CoSW8GPYTJqqRrV99G+leJqVdHYwPwGPzscsZFwtBul3nLadLg
         uHxUlEEZ6n6g8hTilQy4C0e9croREQOSJaR8sswn7/0lCOeGHj71uauBRBs8sz5M6++k
         DQhuwfckBpHexWGJ0hnJzXr9bGXdIFmQoTbiadYrpZZYZvSQFbmAr3rGYgX572ITl6zH
         hHv17fwDFKL61hwXn2nHWtGKJYVX1Y6zEh2R6A7gGEIxgilcddXqM+R09CxGAThctWgZ
         JyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZlKAM3Smf9gFtTpzoOinuQZkko4uYMk5HnJOl1LiY7KQCXQCzpLQ6sdd4GypQgLzODj5oTInC08ND@vger.kernel.org, AJvYcCXCtgNYwTuZiPCS77xJf54Emu/zDFVfDqPgACncImIubn+g7qZZoBfIPh9URMizn6oQpKaL9f6vju4EK8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcoWukv33EhzThq4j2voq4fu7ckE6+loeVgHa9tecvDL6JJ2R
	F5I8/Qlk+WBRZmsIrLpvVDTK0rdXc6nAdzCdlWvD03baEWcUfZ5P17W4Fm7Khax8y/9aeCZM7qe
	Yf0+GvoKkDIlMxm1DejkJyPfftoVQIcTu
X-Gm-Gg: ASbGnctquMDjZSxG0O4/tKvDYDeOTWBvp9bFQK2AvW1Irb6HnGW+QMaXDcB2Toq5EG8
	CM1JRExPO5m5bdlfMG69dxDitZUZPTiXcMq7JUNB14H51Wji5wt3hKm+HvECrdBY+hUefB1y/VW
	RRzbv5yEHCQ1t5GNGX4gwF+k8fuNRl
X-Google-Smtp-Source: AGHT+IEYgGovWbNBz5I7Q6NnrFCor20ZSkULZEF0q+jKb3DiruilW0eh3BWAG/rPfq3NMRO854lBki3HhIfSIBSXFHE=
X-Received: by 2002:a05:6808:1590:b0:3f3:ff05:6d17 with SMTP id
 5614622812f47-3f5585004a5mr7823518b6e.5.1740972595914; Sun, 02 Mar 2025
 19:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
 <20250228161824.3164826-1-mathias.nyman@linux.intel.com> <CAHN5xi0mf8G4ODMQ9jDXAM4CRXtafZeMh_2KF7efbiFJahO4bw@mail.gmail.com>
In-Reply-To: <CAHN5xi0mf8G4ODMQ9jDXAM4CRXtafZeMh_2KF7efbiFJahO4bw@mail.gmail.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Mon, 3 Mar 2025 11:29:49 +0800
X-Gm-Features: AQ5f1Jq1ZN-223eChXIw2tYABHxIWApQ9yctPB1j-GtoOZwfiN4U-IozyV-UZuc
Message-ID: <CAHN5xi0ZCRu-3MyY36MpUDpJOtjTBc2QUY-s+rtLdBUrrHGOaw@mail.gmail.com>
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc enpoints
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: michal.pecio@gmail.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Kuangyi Chiang <ki.chiang65@gmail.com> =E6=96=BC 2025=E5=B9=B43=E6=9C=881=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> Thanks for the patch.
>
> Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2025=E5=B9=B43=E6=
=9C=881=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:17=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > Unplugging a USB3.0 webcam from Etron hosts while streaming results
> > in errors like this:
> >
> > [ 2.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not=
 part of current TD ep_index 18 comp_code 13
> > [ 2.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf86=
30 trb-start 000000002fdf8640 trb-end 000000002fdf8650
> > [ 2.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not=
 part of current TD ep_index 18 comp_code 13
> > [ 2.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf86=
60 trb-start 000000002fdf8670 trb-end 000000002fdf8670
> >
> > Etron xHC generates two transfer events for the TRB if an error is
> > detected while processing the last TRB of an isoc TD.
> >
> > The first event can be any sort of error (like USB Transaction or
> > Babble Detected, etc), and the final event is Success.
> >
> > The xHCI driver will handle the TD after the first event and remove it
> > from its internal list, and then print an "Transfer event TRB DMA ptr
> > not part of current TD" error message after the final event.
> >
> > Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
> > transaction error mid TD.") is designed to address isoc transaction
> > errors, but unfortunately it doesn't account for this scenario.
> >
> > This issue is similar to the XHCI_SPURIOUS_SUCCESS case where a success
> > event follows a 'short transfer' event, but the TD the event points to
> > is already given back.
> >
> > Expand the spurious success 'short transfer' event handling to cover
> > the spurious success after error on Etron hosts.
> >
> > Kuangyi Chiang reported this issue and submitted a different solution
> > based on using error_mid_td. This commit message is mostly taken
> > from that patch.
> >
> > Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> > Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > ---
> >  drivers/usb/host/xhci-ring.c | 36 +++++++++++++++++++++++++-----------
> >  drivers/usb/host/xhci.h      |  2 +-
> >  2 files changed, 26 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.=
c
> > index 965bffce301e..3d3e6cd69019 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct x=
hci_hcd *xhci, struct xhci_virt_
> >         return 0;
> >  }
> >
> > +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
> > +                                          struct xhci_ring *ring)
> > +{
> > +       switch (ring->old_trb_comp_code) {
> > +       case COMP_SHORT_PACKET:
> > +               return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
> > +       case COMP_USB_TRANSACTION_ERROR:
> > +       case COMP_BABBLE_DETECTED_ERROR:
> > +       case COMP_ISOCH_BUFFER_OVERRUN:
> > +               return xhci->quirks & XHCI_ETRON_HOST &&
> > +                       ring->type =3D=3D TYPE_ISOC;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  /*
> >   * If this function returns an error condition, it means it got a Tran=
sfer
> >   * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
> > @@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
> >         case COMP_SUCCESS:
> >                 if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) !=
=3D 0) {
> >                         trb_comp_code =3D COMP_SHORT_PACKET;
> > -                       xhci_dbg(xhci, "Successful completion on short =
TX for slot %u ep %u with last td short %d\n",
> > -                                slot_id, ep_index, ep_ring->last_td_wa=
s_short);
> > +                       xhci_dbg(xhci, "Successful completion on short =
TX for slot %u ep %u with last td comp code %d\n",
> > +                                slot_id, ep_index, ep_ring->old_trb_co=
mp_code);
> >                 }
> >                 break;
> >         case COMP_SHORT_PACKET:
> > @@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
> >                  */
> >                 if (trb_comp_code !=3D COMP_STOPPED &&
> >                     trb_comp_code !=3D COMP_STOPPED_LENGTH_INVALID &&
> > -                   !ep_ring->last_td_was_short) {
> > +                   !xhci_spurious_success_tx_event(xhci, ep_ring)) {
> >                         xhci_warn(xhci, "Event TRB for slot %u ep %u wi=
th no TDs queued\n",
> >                                   slot_id, ep_index);
> >                 }
> > @@ -2890,11 +2906,12 @@ static int handle_tx_event(struct xhci_hcd *xhc=
i,
> >
> >                         /*
> >                          * Some hosts give a spurious success event aft=
er a short
> > -                        * transfer. Ignore it.
> > +                        * transfer or error on last TRB. Ignore it.
> >                          */
> > -                       if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
> > -                           ep_ring->last_td_was_short) {
> > -                               ep_ring->last_td_was_short =3D false;
> > +                       if (xhci_spurious_success_tx_event(xhci, ep_rin=
g)) {
> > +                               xhci_dbg(xhci, "Spurious event dma %pad=
, comp_code %u after %u\n",
> > +                                        &ep_trb_dma, trb_comp_code, ep=
_ring->old_trb_comp_code);
> > +                               ep_ring->old_trb_comp_code =3D trb_comp=
_code;
> >                                 return 0;
> >                         }
> >
> > @@ -2922,10 +2939,7 @@ static int handle_tx_event(struct xhci_hcd *xhci=
,
> >          */
> >         } while (ep->skip);
> >
> > -       if (trb_comp_code =3D=3D COMP_SHORT_PACKET)
> > -               ep_ring->last_td_was_short =3D true;
> > -       else
> > -               ep_ring->last_td_was_short =3D false;
> > +       ep_ring->old_trb_comp_code =3D trb_comp_code;
> >
> >         ep_trb =3D &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*e=
p_trb)];
> >         trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *)=
 ep_trb, ep_trb_dma);
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 8c164340a2c3..c75c2c12ce53 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1371,7 +1371,7 @@ struct xhci_ring {
> >         unsigned int            num_trbs_free; /* used only by xhci DbC=
 */
> >         unsigned int            bounce_buf_len;
> >         enum xhci_ring_type     type;
> > -       bool                    last_td_was_short;
> > +       u32                     last_td_comp_code;
>
> Should be changed to old_trb_comp_code.
>
> >         struct radix_tree_root  *trb_address_map;
> >  };
> >
> > --
> > 2.43.0
> >
>
> I'll test this later.

It works. See the below dynamic debug messages:

[ 1138.281772] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 13
[ 1138.281777] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba600, comp_code 13 after 13
[ 1138.282013] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 13
[ 1138.282019] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba630, comp_code 13 after 13
[ 1138.282271] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 13
[ 1138.282277] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba660, comp_code 13 after 13
[ 1138.282420] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 13
[ 1138.282425] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba680, comp_code 13 after 13
[ 1138.282653] xhci_hcd 0000:04:00.0: Transfer error for slot 1 ep 18
on endpoint
[ 1138.282659] xhci_hcd 0000:04:00.0: Error mid isoc TD, wait for
final completion event
[ 1138.282779] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 4
[ 1138.282785] xhci_hcd 0000:04:00.0: Transfer error for slot 1 ep 18
on endpoint
[ 1138.282911] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 4
[ 1138.282916] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba6c0, comp_code 13 after 4
[ 1138.282920] xhci_hcd 0000:04:00.0: Transfer error for slot 1 ep 18
on endpoint
[ 1138.282923] xhci_hcd 0000:04:00.0: Error mid isoc TD, wait for
final completion event
[ 1138.283039] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 4
[ 1138.283045] xhci_hcd 0000:04:00.0: Transfer error for slot 1 ep 18
on endpoint
[ 1138.283163] xhci_hcd 0000:04:00.0: Successful completion on short
TX for slot 1 ep 18 with last td comp code 4
[ 1138.283167] xhci_hcd 0000:04:00.0: Spurious event dma
0x000000010b5ba6f0, comp_code 13 after 4

>
> Thanks,
> Kuangyi Chiang

Thanks,
Kuangyi Chiang

