Return-Path: <linux-kernel+bounces-186954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EB8CCB20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F79D282C95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522613AA36;
	Thu, 23 May 2024 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zy5OOiqJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775E433A2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434764; cv=none; b=lx92e+3EHxM3cPlFKQXEmRZpc7hj1nv4C4QdC6rmn+X64ku+kPtUUn9h8OqnzV2FiCyCsubrCyz60fPqy0XsjIqrTNb4wyELcQCLshpdMgi+laKnqzhUjd9j392eEedimkFnr/Don4x8nXBhg492J6Zrm02T2H+2/Ck26ar8MOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434764; c=relaxed/simple;
	bh=hABJsT1nXzr5X12Hz8pG3D/OhOr+sbdjTAVWyrBEMfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDOVBm1GMy9lbnyGG25jxKOYjejKJsTTEFfbY1Ki71RPRVtX0NEpW8a6fTY7IYDIlZBgMp1OQa2fYMmrS0ga88WIaMtOHKtu4tvXeNaW5P74s9DrbdEAyHbNg3+PkcwgKcm39J2x+sY7LExU7Y479tZ5cUwslMowmn+jDZUgGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zy5OOiqJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so11263800a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716434760; x=1717039560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L83mJbR99gBM1CeHmsVOzW0zWZuU7yPCDc2y9S6/CFE=;
        b=Zy5OOiqJzAc6NGOJExIKMKKhTUNEC7ZdWEwkbbnykycTteS4LGQztfWr9T84BkCUWR
         WxZ7pz/T4B2LZI4drkClY50IJohlJ1tF+bmbMBtdFQxPzC6a7ZrneucNrC/O+5luwZeu
         ko1zvkypaYD0DJTdZMBCvcqjyQGR1W3MGy9gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716434760; x=1717039560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L83mJbR99gBM1CeHmsVOzW0zWZuU7yPCDc2y9S6/CFE=;
        b=FAllfM9lMW+9I2OewjI3BuSkmxLLLc5B2FRVK8ZT7cllED60CtTpfL95HDGx9fZXHg
         O+bAzc6HhUn+irLKzQ52MlFCEqfeEMurXhOf+1D8ofhVhVj1ez6jpnNNaDkyxuWHfAnN
         EHjSrvOmOUk70viGdbtg0NsDxL5L5TwYp8+LgKkoVsGf6tFI71zJL2iZNWfZ6FKmiTcK
         nk0pW+R8Y1ZoSKyz+27eZkVFpi7rzJnSo95uFcEOHvIcC3vSmwbm5ttlmbiA4THA8Hum
         6MnHL1nocHWF/qp+OaGgC5+H7zg5+KKvBz6/Z707Ld0ggDzHrArd0LfSz0dF7WcBsbRz
         JdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcloNSMVXmrLRfkbW9rAqZejsWqxfJNM0Bw3zqp2gIdmVdrBk/fZjlv9VW7FcCI+Kz75zQMQzjJwL1W6jhGTGHPsK4WSDhEpHOL5P7
X-Gm-Message-State: AOJu0Ywtft9wSc/XsruAw1Bud/vH3RDMF7H9Pwz4BCNuy21AcioJH6Gw
	S3oKG56H/Znbvw8ruVjPZ/j2PqVELwe/cErzZOwS5ksj5czKJMm701NKo9gtlOWaJWC29r/xP1o
	=
X-Google-Smtp-Source: AGHT+IEf3CL6J0Wod8V2F9osKlT1KHRSbf301T/YY4TJcTgpMe3ZaU5VeQZHw96f+tR5BdhkLPvl8A==
X-Received: by 2002:a50:ab0d:0:b0:572:664c:83f2 with SMTP id 4fb4d7f45d1cf-57832bee6c5mr3218389a12.27.1716434760205;
        Wed, 22 May 2024 20:26:00 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733beb89e7sm19736176a12.21.2024.05.22.20.25.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 20:25:59 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so949875566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:25:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzWq2HqVSlsdMQVYo0jwmv1BXoio8a+XrR1ayy3cS9LLOzmydeCxJol/dOcuK8zO7CKd8zM+AjVGEFJeVbpqWkv/d5ypQEOPyOfAS9
X-Received: by 2002:a17:906:e217:b0:a62:44e1:3fe8 with SMTP id
 a640c23a62f3a-a6244e1415amr21855966b.12.1716434759016; Wed, 22 May 2024
 20:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522111139.2612601-1-yinghsu@chromium.org> <CABBYNZKwKLDFtuOLzxdTJj7wxfAJyS4PL_ZWf2h3+ALwC82hsw@mail.gmail.com>
In-Reply-To: <CABBYNZKwKLDFtuOLzxdTJj7wxfAJyS4PL_ZWf2h3+ALwC82hsw@mail.gmail.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Thu, 23 May 2024 11:25:20 +0800
X-Gmail-Original-Message-ID: <CAAa9mD2KCABHppF+7g8B75eJmPesUJWuFZm+XQedzN+BT+U81Q@mail.gmail.com>
Message-ID: <CAAa9mD2KCABHppF+7g8B75eJmPesUJWuFZm+XQedzN+BT+U81Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: vendor specific ISO data packet identification
 by handle
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paul and Luiz, thanks for the suggestions.
I would like to use different names for hci_pkt_type and pkt_type for
clear layering. Will post another revision later today.


On Wed, May 22, 2024 at 10:11=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Wed, May 22, 2024 at 7:11=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> > track CIS/BIS connections. User-space applications have to identify
> > ISO data by maintaining connection information and look up the mapping
> > for each ACL data packet received. Besides, btsnoop log catpured in
> > kernel would couldn't tell ISO data from ACL data in this case.
> >
> > By differentiating ISO data from ACL data earlier in btusb, we can
> > eliminate unnecessary lookups and improve btsnoop log clarity.
> > This patch enables vendor-specific differentiation between ISO and
> > ACL data packets.
> >
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > Tested LE unicast recording on a ChromeOS device with Intel AX211
> >
> >  drivers/bluetooth/btusb.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 79aefdb3324d..543961b6c671 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -889,6 +889,8 @@ struct btusb_data {
> >         int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
> >         int (*recv_bulk)(struct btusb_data *data, void *buffer, int cou=
nt);
> >
> > +       int (*is_iso_data_pkt)(struct sk_buff *skb);
>
> I'd had this sort of callback in hdev itself so the stack can consult
> the driver about packet types at any stage, see bellow.
>
> > +
> >         int (*setup_on_usb)(struct hci_dev *hdev);
> >
> >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > @@ -1229,6 +1231,8 @@ static int btusb_recv_bulk(struct btusb_data *dat=
a, void *buffer, int count)
> >
> >                 if (!hci_skb_expect(skb)) {
> >                         /* Complete frame */
> > +                       if (data->is_iso_data_pkt && data->is_iso_data_=
pkt(skb))
> > +                               hci_skb_pkt_type(skb) =3D HCI_ISODATA_P=
KT;
>
> Id keep a single point in the stack doing the reclassification of the
> packets, which should probably be in hci_recv_frame, Id suggesting
> doing something like:
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b3ee9ff17624..505ef0b58f8c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2941,6 +2941,14 @@ int hci_reset_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_reset_dev);
>
> +static u8 hci_pkt_type(struct hic_dev *dev, struct sk_buff *skb)
> +{
> +       if (hdev->pkt_type)
> +               return hdev->pkt_type(dev, skb);
> +
> +       return hci_skb_pkt_type(skb);
> +}
> +
>  /* Receive frame from HCI drivers */
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> @@ -2950,6 +2958,10 @@ int hci_recv_frame(struct hci_dev *hdev, struct
> sk_buff *skb)
>                 return -ENXIO;
>         }
>
> +       /* Check if the driver agree with packet type classification */
> +       if (hci_skb_pkt_type(skb) !=3D hci_pkt_type(skb))
> +               hci_skb_pkt_type(skb) =3D hci_pkt_type(skb);
> +
>         switch (hci_skb_pkt_type(skb)) {
>         case HCI_EVENT_PKT:
>                 break;
>
>
> >                         btusb_recv_acl(data, skb);
> >                         skb =3D NULL;
> >                 }
> > @@ -2539,6 +2543,13 @@ static int btusb_recv_bulk_intel(struct btusb_da=
ta *data, void *buffer,
> >         return btusb_recv_bulk(data, buffer, count);
> >  }
> >
> > +static int btusb_is_iso_data_pkt_intel(struct sk_buff *skb)
> > +{
> > +       __u16 handle =3D (__le16_to_cpu(hci_acl_hdr(skb)->handle) & 0xf=
ff);
> > +
> > +       return (handle >=3D 0x900);
> > +}
> > +
> >  static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff=
 *skb)
> >  {
> >         struct urb *urb;
> > @@ -4361,6 +4372,9 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 /* Override the rx handlers */
> >                 data->recv_event =3D btintel_recv_event;
> >                 data->recv_bulk =3D btusb_recv_bulk_intel;
> > +
> > +               /* Override for ISO data packet*/
> > +               data->is_iso_data_pkt =3D btusb_is_iso_data_pkt_intel;
> >         } else if (id->driver_info & BTUSB_REALTEK) {
> >                 /* Allocate extra space for Realtek device */
> >                 priv_size +=3D sizeof(struct btrealtek_data);
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
>
>
> --
> Luiz Augusto von Dentz

