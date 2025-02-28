Return-Path: <linux-kernel+bounces-537775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B8A4907A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2484F1892DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A891ADC65;
	Fri, 28 Feb 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcAp2R7K"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613D157487
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718046; cv=none; b=G8K10Ww6cfe3S7cnTzs3WO9sYRUoy2PHYcdcifaQNrGF7wnEtp1Jaus9cSZsFXG3/D13Ff2XAya+om+l0hJzMAlZwJ262aKVxHGjKMxA1JzgjkwN3R1pZ4lUqLOhzmXJHB0Q0E0zIzP/ELCo9pP11O5zjW4+qbSu9I2CStHBX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718046; c=relaxed/simple;
	bh=l1HDXAYe/KohXzpwN5NY8azhX/n0DajBZTX9fxylPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtNwPLN+DG8ix70v1DlJMkUdL+QmC3E8G+FBe+PPLRQCE/78UpZq7aA3bdsR0qJIX9IZGZ+MTnnw9HSABS5xMyiXu4wrnuc7Oi8ujXm07mfUhXgAruVbvmvVlNQWngkqkrL8nnqAHUC059VxAbAnqyFA4iQgASM4jY5NSC6+d6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QcAp2R7K; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f44353649aso2790209a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740718044; x=1741322844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUctcDfZmQyRY2JKLTPER14bWPljruecUN0Iw/PMa7Y=;
        b=QcAp2R7K+Ue1CqK6w5qWzZymxTScpm+KG4dT9oD6Z5WCE8vueqnBcls5+2cYfplSSS
         oi4dHypeW1qkibYcD3flp3lREUAXP+A9SMcN3LJMbPSA+AhJX9Z4E+d3SFA5owqy7jj0
         DLLDf4AMhKFSBYXib8oxdWCj015aTfCNYd5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740718044; x=1741322844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUctcDfZmQyRY2JKLTPER14bWPljruecUN0Iw/PMa7Y=;
        b=gJHWfDZwXmzTZG1oVlHT1jo0D1EudT/2ldG88UaosrZrsBh3Yb97RqZxB965o9ZDWZ
         WoHOvRm2t0G5bxmc6LRpdFaKfVEfKRu8AXbEEdAo7CvTwVD+UI1GIpR/IoB7bQ4Sucnh
         WtGq9f+ToJ6EOlPiB02x625IFDvadej50ipgoc5bYwdrW/986lPobLOIGGkG8/75a3Dl
         dGhIJiwqKr3GRfpVnH3OegDgC63w6nqF0CKtGL5CRI6kwhPo5L+nWUdRsALblP73ID7D
         MuAlxXp5ZAx2VfUNI3tpf447J6lenlMtPwXl+GekIIRhNhmoSSHxl4sMVlfxi1pLcl5i
         px5w==
X-Forwarded-Encrypted: i=1; AJvYcCUbY7O6hsR7wjILJsNDyW6FC9ft2bQhMNLq5MkOMAJOX7VM72cuz6gfpcf7oQY8GNdyfzEjJgmHnXJ9hJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LC7hfRIL1InXcVEKEj6mPah4BkDtnNlSYvsDniB2llTm1BVh
	Dtt4uBJmnhh+mhIVG93qzSkTEiPMsClle7Ii7m18N7bKy26/qf8JwYrH1b3FsuxGsNLTLi2G79y
	/5wysjOz4niAynn+sx69FqI1dT7s1XdDit93c7QmRn+WEHJON6A==
X-Gm-Gg: ASbGncu4RgEoWpnjbeV4bFM3F3jk1inHarYzmLlk8a4Qwtn8ZD0Ifeb+6+9buCQsNno
	kN6rN4Ru5/RIT2+DpNh8Z65tnySKzHq+DtvolHPd5/0Z2hcUnzmdE685ZTkZa6I4dzzCBBpsot9
	FkK+9el8U=
X-Google-Smtp-Source: AGHT+IEUloVkp/IH+X5jej0U1S6I2vwbJF4jbAAoN1pV4CnDgAWYJmrTvDEe7XLe9SV3V8xEixdh9phDOBlBpbSKg0U=
X-Received: by 2002:a17:90b:48c2:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-2febab3c710mr3550322a91.14.1740718044199; Thu, 27 Feb 2025
 20:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
 <2025022407-polo-disgrace-9655@gregkh> <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
 <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com>
 <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
 <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
 <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com>
 <CABBYNZKJUnhGXJEsExCdWNaE448QhCeiymLm9yS80k18AeWqoQ@mail.gmail.com> <CADg1FFeyRa8rGkJXb+4Ymeqn+3XLJ3ZEpBnQ_F3WvwrS+u1KfQ@mail.gmail.com>
In-Reply-To: <CADg1FFeyRa8rGkJXb+4Ymeqn+3XLJ3ZEpBnQ_F3WvwrS+u1KfQ@mail.gmail.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Fri, 28 Feb 2025 12:47:13 +0800
X-Gm-Features: AQ5f1JrdK3rHVPx7Y-bQnOVp_3G3Em7yyRotC8FT3nEVBrT7B8ahOyAWdVGF11Y
Message-ID: <CADwQ6b63Z3HXCx=pXrhTDAXhqPO7-fSvgE7=TiTMTvc4Y+-mNA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-bluetooth@vger.kernel.org, chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Beyond power concerns, another potential issue is USB host controller
scheduling fairness. SCO data is transmitted over isochronous pipes,
and if the alternate setting remains non-zero, the USB host controller
reserves bandwidth even when no audio data is being transmitted. This
could reduce throughput for some USB 1.x/2.0 applications, such as
file transfers from USB mass storage devices, when sharing the bus
with a Bluetooth controller in SCO mode. I don=E2=80=99t have a Chromebook =
to
verify this theory, but I suggest the ChromeOS team measure the
potential impact and follow up if necessary.

On Fri, Feb 28, 2025 at 12:44=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> On Thu, Feb 27, 2025 at 11:59=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Thu, Feb 27, 2025 at 10:37=E2=80=AFAM Hsin-chen Chuang <chharry@goog=
le.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Thu, Feb 27, 2025 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Hsin-chen,
> > > >
> > > > On Wed, Feb 26, 2025 at 9:22=E2=80=AFPM Hsin-chen Chuang <chharry@g=
oogle.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Hsin-chen,
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chhar=
ry@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang =
wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > >
> > > > > > > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@l=
inuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chu=
ang wrote:
> > > > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > > >
> > > > > > > > > > > Automatically configure the altsetting for USER_CHANN=
EL when a SCO is
> > > > > > > > > > > connected. This adds support for the USER_CHANNEL to =
transfer SCO data
> > > > > > > > > > > over USB transport.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs att=
ribute to control USB alt setting")
> > > > > > > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org=
>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Give up tracking the SCO handles. Only configure th=
e altsetting when
> > > > > > > > > > >   SCO connected.
> > > > > > > > > > > - Put the change behind Kconfig/module parameter
> > > > > > > > > > >
> > > > > > > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > > > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++=
++++++++++++++++++
> > > > > > > > > > >  2 files changed, 57 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/blue=
tooth/Kconfig
> > > > > > > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > > > > > > >         Say Y here to enable USB poll_sync for Blueto=
oth USB devices by
> > > > > > > > > > >         default.
> > > > > > > > > > >
> > > > > > > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL=
 when SCO connected"
> > > > > > > > > > > +     depends on BT_HCIBTUSB
> > > > > > > > > > > +     default n
> > > > > >
> > > > > > Maybe we can do just:
> > > > > >
> > > > > >  default y if CHROME_PLATFORMS
> > > > > >
> > > > > > > > > > > +     help
> > > > > > > > > > > +       Say Y here to enable auto set isoc_altsetting=
 for USER_CHANNEL
> > > > > > > > > > > +       when SCO connected
> > > > > > > > > > > +
> > > > > > > > > > > +       This can be overridden by passing btusb.auto_=
set_isoc_alt=3D[y|n]
> > > > > > > > > > > +       on the kernel commandline.
> > > > > > > > > > > +
> > > > > > > > > > >  config BT_HCIBTUSB_BCM
> > > > > > > > > > >       bool "Broadcom protocol support"
> > > > > > > > > > >       depends on BT_HCIBTUSB
> > > > > > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/blue=
tooth/btusb.c
> > > > > > > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > > > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG=
_BT_HCIBTUSB_AUTOSUSPEND);
> > > > > > > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_B=
T_HCIBTUSB_POLL_SYNC);
> > > > > > > > > > >  static bool reset =3D true;
> > > > > > > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT=
);
> > > > > > > > > > >
> > > > > > > > > > >  static struct usb_driver btusb_driver;
> > > > > > > > > > >
> > > > > > > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_=
frags(struct btusb_data *data)
> > > > > > > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static void btusb_sco_connected(struct btusb_data *d=
ata, struct sk_buff *skb)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->dat=
a;
> > > > > > > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > > > > > > +     unsigned int notify_air_mode;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > > > > > > +             return;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HC=
I_EV_SYNC_CONN_COMPLETE)
> > > > > > > > > > > +             return;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) ||=
 ev->status)
> > > > > > > > > > > +             return;
> > > > > > > > > > > +
> > > > > > > > > > > +     switch (ev->air_mode) {
> > > > > > > > > > > +     case BT_CODEC_CVSD:
> > > > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_S=
CO_CVSD;
> > > > > > > > > > > +             break;
> > > > > > > > > > > +
> > > > > > > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_S=
CO_TRANSP;
> > > > > > > > > > > +             break;
> > > > > > > > > > > +
> > > > > > > > > > > +     default:
> > > > > > > > > > > +             return;
> > > > > > > > > > > +     }
> > > > > > > > > > > +
> > > > > > > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %=
u", ev->air_mode);
> > > > > > > > > > > +     data->sco_num =3D 1;
> > > > > > > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > > > > > > +     schedule_work(&data->work);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static int btusb_recv_event(struct btusb_data *data,=
 struct sk_buff *skb)
> > > > > > > > > > >  {
> > > > > > > > > > >       if (data->intr_interval) {
> > > > > > > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(st=
ruct btusb_data *data, struct sk_buff *skb)
> > > > > > > > > > >               schedule_delayed_work(&data->rx_work, 0=
);
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on=
 SCO connected */
> > > > > > > > > > > +     if (auto_set_isoc_alt &&
> > > > > > > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHAN=
NEL))
> > > > > > > > > > > +             btusb_sco_connected(data, skb);
> > > > > > > > > > > +
> > > > > > > > > > >       return data->recv_event(data->hdev, skb);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosus=
pend, "Enable USB autosuspend by default");
> > > > > > > > > > >  module_param(reset, bool, 0644);
> > > > > > > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on i=
nitialization");
> > > > > > > > > > >
> > > > > > > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_a=
ltsetting for USER_CHANNEL when SCO connected");
> > > > > > > > > >
> > > > > > > > > > This is not the 1990's, why are you adding new module p=
arameters when we
> > > > > > > > > > have so many other more proper ways to do this?  And re=
ally, this would
> > > > > > > > >
> > > > > > > > > Sorry but could you please provide an example to guard a =
feature like this.
> > > > > > > >
> > > > > > > > Depends on what you want to do with this configuration.  Wh=
y is it an
> > > > > > > > option at all?  Why can't it "just work"?  Module parameter=
s are a pain
> > > > > > >
> > > > > > > I would like to hand this question to Luiz. I believe this pa=
tch just
> > > > > > > works because this configuration is defined in the spec.
> > > > > > > I think Luiz's point is to project the potential existing use=
r, but
> > > > > > > there's probably no User channel user sending SCO data with t=
he latest
> > > > > > > btusb driver because:
> > > > > > > a) There's no way to configure alt setting from userspace
> > > > > > > b) Before eafcfcfca97d, SCO data would be rejected since User=
 channel
> > > > > > > shouldn't be able to modify hci_conn_num
> > > > > >
> > > > > > Perhaps you can just use CHROME_PLATFORMS (suggested above) in =
Kconfig
> > > > > > to enable intercepting of the events, etc, so we don't need any
> > > > > > runtime parameters.
> > > > >
> > > > > I'm afraid that this doesn't resolve Greg's comment below because=
 the
> > > > > multiple controllers are still bonded to the same config.
> > > >
> > > > Well that would be enabled for every controller plugged into the sy=
stem.
> > >
> > > To clarify, I'm totally fine with runtime parameters and/or any
> > > Kconfig like CHROME_PLATFORMS, although I'd prefer the current patch
> > > more.
> > >
> > > But I guess Greg's point is that the multiple controllers should be
> > > able to have different configurations at the same time. I'd respect
> > > your decision to accept this patch or another patch with
> > > CHROME_PLATFORMS, but I guess it's better to convince Greg first.
> >
> > Perhaps I got Greg's response wrong, but I think he was suggesting
> > that it should just work without any special configuration, which is
> > what I'm suggesting here, the use of CHROME_PLATFORMS is more of a
> > stopgap until proper test automation is introduced.
> >
> > You can already have different configurations with respect to
> > HCI_CHANNEL_USER since that is done per controller, btw that is used
> > by the likes of btproxy tool for example which is normally used to
> > hook the controller into a VM.
>
> Thanks for the explanation. I'll follow the suggestion in v3.
>
>
> Best Regards,
>
> Hsin-chen

