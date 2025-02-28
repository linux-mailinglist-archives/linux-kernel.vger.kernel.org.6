Return-Path: <linux-kernel+bounces-537577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D237A48DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB76E16E6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE421D555;
	Fri, 28 Feb 2025 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bYjZhUp"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189A17BD6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704948; cv=none; b=ZISjjMgtOW0oHjoty1zw+3y9q+QvVzJuw77fV3K0/8WQ9+5LNUdaV2cfNkA7k1EiiTdQM9CaTQtbydpQdg/GUniF93PTE1sjci7462mGbmkxIJ4CfkMnUeADbWRPjTG4QvhImGqWy+NvZ2n0G0WkD/br9mOZew4VV95BFa+NxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704948; c=relaxed/simple;
	bh=8joGwOlGDtKm/Ou163mKi9Jps79mbX1bhWxA8lqK9As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGZXixYOt8///KiZCagFe+Jv4w48AGDZqaR7kqROnk62WNEkv/IQDxTsEP02eB55h+ufTmhUmCOZJ+/S7W4fhH9DY8BqihcLQp2uEdr//Uxy+FqWo0oPrhLPYELwhw4dGQoI2gHDO6kcMxQBk4q9EGxwbs5yPKaSX/ifEOytocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bYjZhUp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fb7d64908fso14988167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740704946; x=1741309746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7O0pcoKAAbkmC6anJMdQDr5zFGZCy6HhbubzNF3bDI=;
        b=4bYjZhUp9HI3Ch/fCS36z4Z9m6lmG8iLQvcIeFd8MJ+NH7ipFr+SBMZS99/Wv7sDTJ
         gSesXRrkXDsh3V9KDOlQefxQMOlEFYGRWW8YhWJmlBa6Qgc1G3EakKzzFkR1cLKKVh90
         zRX8U4qPhrj6D5WD0sgZ+Hb4b1iPlIubeW52u7M2303pcm/4T8UebiznSyr//9QZUytj
         i0eE1NSxGGT1gIXfDsBY9J1qcRtPOPNboDhe3HpR6ajVMgtzXI7xin6R8OnrrWNwL+dl
         DbqQoMMF1XTlAlplbzF+EI2e6rndsW3Rth9jjevZh2If5tis3EznoaHqU2HY4vZ1lJAf
         2i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740704946; x=1741309746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7O0pcoKAAbkmC6anJMdQDr5zFGZCy6HhbubzNF3bDI=;
        b=YRkzwCt11mvUioT/bE4ISIJfz22MuTyi+HEChaiHnq0oqBQxvNDucefb9xBOpgib95
         xseeIwY+gxnT1IfWKUvobhVT6G75p2UZfHU9Im5IluPtf3DRgCM/pdlazv2SbENQrTxe
         A4GM/NkvCxH8rFbMhEMQDcOovjGBEkhkl1NmpFDvD2Cwt2NKbBEm75yhjij3TPiTuJae
         vJ2CD4kUcKVdQ8KltOlzMkgmdHEFEzy5pNojeEAeec4k4J6ZVj4tt4SuE/81qc5VjWCc
         RWgnf2p0xre20E4PNI3zC/MZeEivg1ZR7bWEDVk8VRLgEjS3oqesTeu3qoXeyOyWZ7UA
         O3SA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVZZBa5oTcFzOKrZidB42FkdBVtUHVChed5orlY/BOdIHQmjILwqqdiB5ODYgOhRX1aGZbE174d31lDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tJkLjD7gNPdikIzyBHe9PuccYZTxhCofwUgNkF6Hk7yrZjHZ
	1DgyqGS0kiuv6kb5TtXtZLQw5OBQrsSsPdNWsXjM1sU9H4XMLQV7T+WNoQH+sfy5Zt2yYyihxaB
	lqD6Y+n6wW3dC4KEU7DUGI6gZNG5Ve6H9WOpRLTwcM3K/qXzRKBTf
X-Gm-Gg: ASbGnctxsl+NcEPLXNIjE3DI1Ogv8zjHc6jU9y3liUMkyKzZywpNOBNY0J2FDXM4TZq
	Bh0Z7EHERuQkieiDGyJKlYms75rfDtz4KQhANVKK2b0CG2e8giJrUZMXbjrjO7V0BL8t4tfIM1W
	F7ElI3A6s=
X-Google-Smtp-Source: AGHT+IE1do07rAVeM26LWM44sDcYkndMMS6PqevsrML44Ig1O2UNIGxaZZ09D+v1YjMHpR+yUbCrMZa0Okg5Z9Qp2hI=
X-Received: by 2002:a05:690c:288b:b0:6fb:968b:d8f5 with SMTP id
 00721157ae682-6fd4a16c59fmr18940297b3.36.1740704945595; Thu, 27 Feb 2025
 17:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227171417.4023415-1-chharry@google.com> <CABBYNZ+QdWQ49ZMxPLj86d=kjr7Sf38LR1PrYrPhU8kZMQuh0A@mail.gmail.com>
In-Reply-To: <CABBYNZ+QdWQ49ZMxPLj86d=kjr7Sf38LR1PrYrPhU8kZMQuh0A@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 28 Feb 2025 09:08:29 +0800
X-Gm-Features: AQ5f1JqF-8o4G0RZxdRRArwn7xPaMsiW2qBDGccNZn9lTrdQL5jZD7L3Flx9z8M
Message-ID: <CADg1FFcK1e_y6mroLuh2kkWA32BU3esbtT9vLbntviDUtkoLJw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	pmenzel@molgen.mpg.de, chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Fri, Feb 28, 2025 at 5:40=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Thu, Feb 27, 2025 at 12:14=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Automatically configure the altsetting for HCI_USER_CHANNEL when a SCO
> > is connected.
> >
> > The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
> > data through USB Bluetooth chips, which is mainly used for bidirectiona=
l
> > audio transfer (voice call). This was not capable because:
> >
> > - Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
> >   alternate setting should be set based on the air mode in order to
> >   transfer SCO data, but
> > - The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
> >   Controller Interface to the user space, which is something above the
> >   USB layer. The user space is not able to configure the USB alt while
> >   keeping the channel open.
> >
> > This patch intercepts the HCI_EV_SYNC_CONN_COMPLETE packets in btusb,
> > extracts the air mode, and configures the alt setting in btusb.
> >
> > This patch is tested on ChromeOS devices. The USB Bluetooth models
> > (CVSD, TRANS alt3 and alt6) could work without a customized kernel.
> >
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Remove module parameter
> > - Set Kconfig to default y if CHROME_PLATFORMS
> >
> > Changes in v2:
> > - Give up tracking the SCO handles. Only configure the altsetting when
> >   SCO connected.
> > - Put the change behind Kconfig/module parameter
> >
> >  drivers/bluetooth/Kconfig | 11 ++++++++++
> >  drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 4ab32abf0f48..cdf7a5caa5c8 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> >           Say Y here to enable USB poll_sync for Bluetooth USB devices =
by
> >           default.
> >
> > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > +       bool "Auto set isoc_altsetting for HCI_USER_CHANNEL when SCO co=
nnected"
> > +       depends on BT_HCIBTUSB
> > +       default y if CHROME_PLATFORMS
> > +       help
> > +         Say Y here to enable auto set isoc_altsetting for HCI_USER_CH=
ANNEL
> > +         when SCO connected
> > +
> > +         When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE =
packets
> > +         and configures isoc_altsetting automatically for HCI_USER_CHA=
NNEL.
> > +
> >  config BT_HCIBTUSB_BCM
> >         bool "Broadcom protocol support"
> >         depends on BT_HCIBTUSB
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index de3fa725d210..2642d2ca885f 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -34,6 +34,8 @@ static bool force_scofix;
> >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOS=
USPEND);
> >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SY=
NC);
> >  static bool reset =3D true;
> > +static bool auto_set_isoc_alt =3D
> > +       IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> >
> >  static struct usb_driver btusb_driver;
> >
> > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct btusb=
_data *data)
> >         spin_unlock_irqrestore(&data->rxlock, flags);
> >  }
> >
> > +static void btusb_sco_connected(struct btusb_data *data, struct sk_buf=
f *skb)
> > +{
> > +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> > +       struct hci_ev_sync_conn_complete *ev =3D
> > +               (void *) skb->data + sizeof(*hdr);
> > +       struct hci_dev *hdev =3D data->hdev;
> > +       unsigned int notify_air_mode;
> > +
> > +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > +               return;
> > +
> > +       if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN_C=
OMPLETE)
> > +               return;
> > +
> > +       if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> > +               return;
> > +
> > +       switch (ev->air_mode) {
> > +       case BT_CODEC_CVSD:
> > +               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > +               break;
> > +
> > +       case BT_CODEC_TRANSPARENT:
> > +               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> > +               break;
> > +
> > +       default:
> > +               return;
> > +       }
> > +
> > +       bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode=
);
> > +       data->sco_num =3D 1;
> > +       data->air_mode =3D notify_air_mode;
> > +       schedule_work(&data->work);
> > +}
> > +
> >  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *s=
kb)
> >  {
> >         if (data->intr_interval) {
> > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_data *d=
ata, struct sk_buff *skb)
> >                 schedule_delayed_work(&data->rx_work, 0);
> >         }
> >
> > +       /* Configure altsetting for HCI_USER_CHANNEL on SCO connected *=
/
> > +       if (auto_set_isoc_alt &&
> > +           hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > +               btusb_sco_connected(data, skb);
> > +
> >         return data->recv_event(data->hdev, skb);
> >  }
> >
> > --
> > 2.48.1.658.g4767266eb4-goog
>
> This has been merged, I did some minor rewording here and there but
> the logic remains the same, now we can problem revert b16b327edb4d
> ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")?
>
> --
> Luiz Augusto von Dentz

Yes, sure. We could revert b16b327edb4d now.


Best Regards,

Hsin-chen

