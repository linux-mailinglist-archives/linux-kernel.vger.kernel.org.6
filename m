Return-Path: <linux-kernel+bounces-536698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC30A48320
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEA3B5F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9926B94B;
	Thu, 27 Feb 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojQBK1wI"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929026B2C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670647; cv=none; b=IFb7eT1U6mw4Xa79hPXnoJJL9bRLetjpsIgYQjB5BeMZsMwSAgmsRD/mtTpCDV5KAMiaf9qY9Dp0ukM/vYT41o4za3SWMGGDmRjJZGK2fxkfxdfsAd1hEBt0NM68GjI6cbpAnHlgdOIE9sdsFBmZm84iZgLivViDHIODKD1e6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670647; c=relaxed/simple;
	bh=u+2QV1zMceSvL1rwFfEaGR9fpcmpAEZP8CsqkauyPHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsaBs1wzxvBNCG0pxu3k4/f8auKxHYprjqeYZEgJyVQM046gZ+HYCCT244paBBTe/tZcUF0e17YeYiD5WcTGQ68WotEi1s7CzfwUYEx3Zi2xPlmSbA/f/cn8rn6476dNM/Nxc4eA0TD9JXNkClDUQirO3mXxlOR584ZzXN814RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojQBK1wI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so921916276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740670644; x=1741275444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKNvlpFVUKxwsWoVw37H9cWMQYyKOQSTR+W3w1pVEHo=;
        b=ojQBK1wIytd2ruk3+pI4YqeqYppxuhaPhBGNWuDJa8zNf87cgKm87vHoVZnEb9LXoW
         5+M9fXOWFPjQLEKL0BkjB04szRecJBFokxyx6nPUhw5xANnSoERqN80CaNhWMI5bwQAl
         zy5DzCk3tZW9ghG/8jQ42k4uNDXZoTT+7y9COSClFtcjg43b++R2dzi9OhNcSrVIbAMe
         w2atd7J9MbyEnuUTgNaSDm0HzLCqJoGS+NYIR4Cz6E3EsDEfFMKVJ2ICONIfzo+DPSm2
         mwp9/BnFLBlkIbrydh4EHU7nE8OOY12dKhhflmwymSp8lrzzAybj2flx9jHo6pSQnprK
         zoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670644; x=1741275444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKNvlpFVUKxwsWoVw37H9cWMQYyKOQSTR+W3w1pVEHo=;
        b=IGHK9mg7BAPgMvEGdFbefjU3LQzxzcAVXifSZRmT7uPOcdF5TnRAHJmotEcwu7dYxX
         twP50GXej/V5hEmqn35zfaqgUEYbGfoisTExtqyHn0LzzM/1GWZSC/T5oRDiuXYkV8hk
         cAYkj/LQZjboUM1LV81e2SSFA4ewqu9MRj9XLVvMZATEywMmd7EaVXvDQrhKznB25AvS
         9cV1Be+d1Qmv240lnCsQytdWH+dsBo+GbwzoVgFw/Bbsl/WjZK70EkZNgdTsYSf3sblo
         aWeMsZtR47v92V+1XzB68caQjnSPq7/zRewjQHBxVbzSH5qIquM0dnFmomhkMboTJhWm
         msWg==
X-Forwarded-Encrypted: i=1; AJvYcCXhENQy9nyYMr21/2d5VqHi3sB0k7IRuS+U8vl3AoPDRuHbyIGITshnSCQaiuCyHYAUfglE6zcflC6Meb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlGUJSqbQH89ylvZCXO0KtepSFBK7Q40EQK2kjha9CGkM6KjV
	LdrlE+kY/572ZlNuD5p9Nkm+x7u9l3r0JSG1HNbimVYniTI1WrHaiiKbAZ3ntSdhLs4UYnNzS21
	6be4QqSTKPRYgVB0MXocOx0NEFz83ExKIAu48
X-Gm-Gg: ASbGncv6sv5bOp14QxOUZiIx2NZhQipPxmqczdzs6WVyaac2uLDF20FDtkKXzVTliab
	7GkSZc1mGedFvaoMR+UmUF4Ey1je69wymiK2G9ml0s/pcVZS3Xbf+d0qJ4zUKGE84EPQnshAnhv
	QHSuvgQjI=
X-Google-Smtp-Source: AGHT+IFaoqTgEdm5NgNzFc0dXgFUoGusSTRC/LY0JaiWipBUJbbrfSACHKTw3kUxWRYTx7CH4Kpwv54vAb4UMk+Oe6U=
X-Received: by 2002:a05:6902:27ca:b0:e60:89bc:6e11 with SMTP id
 3f1490d57ef6-e6089bc6ea1mr5247276276.42.1740670643443; Thu, 27 Feb 2025
 07:37:23 -0800 (PST)
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
 <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com> <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
In-Reply-To: <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 27 Feb 2025 23:36:46 +0800
X-Gm-Features: AQ5f1Jr3ZghbFTCeSwTBoRc0I_Bxb-ncIBaS6rj3ktcNyBpZRXvFynHYgHtNwQI
Message-ID: <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Feb 27, 2025 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Wed, Feb 26, 2025 at 9:22=E2=80=AFPM Hsin-chen Chuang <chharry@google.=
com> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry@goo=
gle.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wr=
ote:
> > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > >
> > > > > > > > Automatically configure the altsetting for USER_CHANNEL whe=
n a SCO is
> > > > > > > > connected. This adds support for the USER_CHANNEL to transf=
er SCO data
> > > > > > > > over USB transport.
> > > > > > > >
> > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute=
 to control USB alt setting")
> > > > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Give up tracking the SCO handles. Only configure the alts=
etting when
> > > > > > > >   SCO connected.
> > > > > > > > - Put the change behind Kconfig/module parameter
> > > > > > > >
> > > > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++=
++++++++++++
> > > > > > > >  2 files changed, 57 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/=
Kconfig
> > > > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > > > >         Say Y here to enable USB poll_sync for Bluetooth US=
B devices by
> > > > > > > >         default.
> > > > > > > >
> > > > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL when =
SCO connected"
> > > > > > > > +     depends on BT_HCIBTUSB
> > > > > > > > +     default n
> > >
> > > Maybe we can do just:
> > >
> > >  default y if CHROME_PLATFORMS
> > >
> > > > > > > > +     help
> > > > > > > > +       Say Y here to enable auto set isoc_altsetting for U=
SER_CHANNEL
> > > > > > > > +       when SCO connected
> > > > > > > > +
> > > > > > > > +       This can be overridden by passing btusb.auto_set_is=
oc_alt=3D[y|n]
> > > > > > > > +       on the kernel commandline.
> > > > > > > > +
> > > > > > > >  config BT_HCIBTUSB_BCM
> > > > > > > >       bool "Broadcom protocol support"
> > > > > > > >       depends on BT_HCIBTUSB
> > > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/=
btusb.c
> > > > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HC=
IBTUSB_AUTOSUSPEND);
> > > > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIB=
TUSB_POLL_SYNC);
> > > > > > > >  static bool reset =3D true;
> > > > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > > > > >
> > > > > > > >  static struct usb_driver btusb_driver;
> > > > > > > >
> > > > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(=
struct btusb_data *data)
> > > > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void btusb_sco_connected(struct btusb_data *data, s=
truct sk_buff *skb)
> > > > > > > > +{
> > > > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > > > +     unsigned int notify_air_mode;
> > > > > > > > +
> > > > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_S=
YNC_CONN_COMPLETE)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->s=
tatus)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     switch (ev->air_mode) {
> > > > > > > > +     case BT_CODEC_CVSD:
> > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVS=
D;
> > > > > > > > +             break;
> > > > > > > > +
> > > > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRA=
NSP;
> > > > > > > > +             break;
> > > > > > > > +
> > > > > > > > +     default:
> > > > > > > > +             return;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev=
->air_mode);
> > > > > > > > +     data->sco_num =3D 1;
> > > > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > > > +     schedule_work(&data->work);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int btusb_recv_event(struct btusb_data *data, struc=
t sk_buff *skb)
> > > > > > > >  {
> > > > > > > >       if (data->intr_interval) {
> > > > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct b=
tusb_data *data, struct sk_buff *skb)
> > > > > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO c=
onnected */
> > > > > > > > +     if (auto_set_isoc_alt &&
> > > > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > > > > > +             btusb_sco_connected(data, skb);
> > > > > > > > +
> > > > > > > >       return data->recv_event(data->hdev, skb);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, =
"Enable USB autosuspend by default");
> > > > > > > >  module_param(reset, bool, 0644);
> > > > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initial=
ization");
> > > > > > > >
> > > > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsett=
ing for USER_CHANNEL when SCO connected");
> > > > > > >
> > > > > > > This is not the 1990's, why are you adding new module paramet=
ers when we
> > > > > > > have so many other more proper ways to do this?  And really, =
this would
> > > > > >
> > > > > > Sorry but could you please provide an example to guard a featur=
e like this.
> > > > >
> > > > > Depends on what you want to do with this configuration.  Why is i=
t an
> > > > > option at all?  Why can't it "just work"?  Module parameters are =
a pain
> > > >
> > > > I would like to hand this question to Luiz. I believe this patch ju=
st
> > > > works because this configuration is defined in the spec.
> > > > I think Luiz's point is to project the potential existing user, but
> > > > there's probably no User channel user sending SCO data with the lat=
est
> > > > btusb driver because:
> > > > a) There's no way to configure alt setting from userspace
> > > > b) Before eafcfcfca97d, SCO data would be rejected since User chann=
el
> > > > shouldn't be able to modify hci_conn_num
> > >
> > > Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kconfi=
g
> > > to enable intercepting of the events, etc, so we don't need any
> > > runtime parameters.
> >
> > I'm afraid that this doesn't resolve Greg's comment below because the
> > multiple controllers are still bonded to the same config.
>
> Well that would be enabled for every controller plugged into the system.

To clarify, I'm totally fine with runtime parameters and/or any
Kconfig like CHROME_PLATFORMS, although I'd prefer the current patch
more.

But I guess Greg's point is that the multiple controllers should be
able to have different configurations at the same time. I'd respect
your decision to accept this patch or another patch with
CHROME_PLATFORMS, but I guess it's better to convince Greg first.

>
> > Also I would hesitate to put this Chrome devices specific because
> > project Floss shall be able to run on a general Linux environment.
>
> It can be enabled for Linux in general, it just not enabled by default
> which can be changed later if someone decides to use Floss outside of
> Chrome OS, that said I very much doubt Google would be supporting
> anything other then Chrome based platforms or Floss don't depend on
> Android vendor HCI commands? At least the Android documentation seems

Floss doesn't depend on Android extensions - Our hardwares doesn't
support that either :p

> to suggest a bunch of vendor commands are required:
>
> https://source.android.com/docs/core/connect/bluetooth/hci_requirements
>
> > If you have a strong opinion to guard this behind a flag, perhaps we
> > could try other options suggested by Greg (configfs or maybe back to
> > sysfs).
>
> I think those would be more complicated then handling this via
> Kconfig, besides I think this works best since there is no new API
> introduced, just a new Kconfig option which can be enabled in any
> platform/distro.
>
> > >
> > > > > to configure, we have loads of other ways to do this now (configf=
s,
> > > > > debugfs for debugging stuff, sysfs for device-specific things, et=
c.)
> > > > >
> > > > > > > not work at all for multiple controllers in teh same system, =
right?
> > > > > >
> > > > > > Do you mean we can't have separate parameters for different
> > > > > > controllers? Yes that's true, but why would a user want the dif=
ferent
> > > > > > behavior on the same machine?
> > > > >
> > > > > Why would you prevent them from allowing this to happen for a
> > > > > device-specific option?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > --
> > > > Best Regards,
> > > > Hsin-chen
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > Best Regards,
> >
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz


Best Regards,

Hsin-chen

