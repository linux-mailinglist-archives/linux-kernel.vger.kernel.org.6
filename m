Return-Path: <linux-kernel+bounces-528161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3183A4145B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B486216F880
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5419E971;
	Mon, 24 Feb 2025 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nhsadb//"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE51624F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740369514; cv=none; b=OEen6QZxPNoo4qAx6Ba1+BCpCcQSXCzMp1xB0qaesOb2oU/JNPoWa5XdrzRF2rX3WNONxPV56vnjyg9EYjL1VPEPZ+O8v8VJtX1yrlJfV8DdFN1P+d3QWsxzea/Sk17CKu8ML89xnZl+8ynpmhzK5O/tO2jE7re0rkgI+vV7OQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740369514; c=relaxed/simple;
	bh=a+P1Zj0lLL6A+pBoAScpGH5C1g17djwq0Cmx68WiJYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcPTDoM7/2vjMoME9UOHQ1F8SNVBB94Q+UIIhdlOMyovpcjqUmoVbrVxDZjrhiHHEO+dZ9m+Olg+gTV8Irkkya8pJcJyzCwj8q2BySVu070v1cPuAZWPFaUrYZmoM5RMkP3T9O/7zyAqEiclWy62MVCVaaa5LXixUgGRngoRgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nhsadb//; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so2951125276.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740369511; x=1740974311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1AplG7ZYoHxUdBRzvhfNBskJoeRk5zUBAlO/W8L/1g=;
        b=Nhsadb//WhxX/8jiaXgB3MKvKPsspVCHbc8MV7+BMz41H+uY05EFyzgVMgyaTfBTkJ
         OJIM3puw7EA77rnVCNXDM9jDyyt2qKnrE5yIhSN9QnnA4KWrSmLUq0Pk4K4JVFFWsefL
         txeqwEfh1a+Bvf9+hcbli5fMzmRfynLZ5VxFau3mx7XieDxf2dyCUUNmQ35AH11fYJDA
         8uyg++r73ujpsRzkv1S/U9y2votNyAkVwGXzqEq4QOVJlqujle64xXvnOgQU5jJvm9fi
         khy90ud77aTDWcGmMLHMi/teuqR+WpAo21C2M95zQslxdqpEHOFI8wBRouJ2eXOx/5oL
         Q6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740369511; x=1740974311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1AplG7ZYoHxUdBRzvhfNBskJoeRk5zUBAlO/W8L/1g=;
        b=BjNleCqjPgvBuUiYaQKCLnXTG1SprywrOcZkYY3N/2xWs122kXnc1nM7vxjS95RDtk
         HIAT7qqQDEDYvsH3yfCp9tC1nJvbpBfh9MBtIxqIjKA04hsEICOE+wxk/wMy7/4cCjsu
         L2stMCOW0lyuxRSM2AVwlyo2Idhtxxm6krRay62fKXyt750/TZ1HC5zeyVeiBGvML43g
         XOunVgv0BsGfNmRCdT9M3HhaVzfS1eGyDLFpeVXy3+ZMV3BzHmkBvS/7Xy6J5DQtQD5W
         RnlAQWc4+KGcWmDx7gaASkv7UFLJ3sSdXZcku6uM5mCLlp0I/KUB+YE6Buap3XSJ7P3D
         mzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoN36ZpONfOYiuaSzmtKH7zDfZ3OmcfvvXS47XJAl/ukl+pKANlkJrCDp4nidy5ynNNsMWbfLcWsAeV6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvKTiYpAEsX4Wo8dAzZnUtrOrXgss5X8dPYhypzhKKfMnDcIQ
	5Q3V7wCjzKR2q4wv2J68ohXr1gHIp3Wa2Ek0/CXBCmPTmFIxKNQ/hyA4THiCLtKjj444mEbfbpD
	xM3l9iRdR1liolHL9tjo8DU5YBQORpjbAX0Cn
X-Gm-Gg: ASbGnctyxLQ0aA8umpsDl8oP1Uilsm2Hkyi9cZdydCsHNA7OCMFkc7G2wRoJOzpN6Gi
	QdQUjo2NS86x8TBczwHzqfPxcD0YvPiyvJyCLmgI1+lGaHfiFgGGMS5VV8Z4Ckc/oF/HNFb/rlx
	bIh/cYcUpV
X-Google-Smtp-Source: AGHT+IHdbqHbnnEP8SW5wFYcgsYUpUI3b2XqJWLkKNLqB0HEB9ms4FqEIUDtueyHP44WVLGjs042I2bzXZnm3yPDn/I=
X-Received: by 2002:a05:6902:1585:b0:e5e:85:a9f0 with SMTP id
 3f1490d57ef6-e5e245b9c3bmr9669267276.6.1740369510927; Sun, 23 Feb 2025
 19:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224022447.1141413-1-chharry@google.com> <CABBYNZJUd1wU0wyPugz4E_WNQsg9qTJmWdu4k2GvvvgVFG8GPQ@mail.gmail.com>
 <CADg1FFfMRwrGjWkhqbiZsfwV5p3axz0bqvPu-vNSSFJyObaN5w@mail.gmail.com> <CABBYNZLFY0AcXJjaz5HQbB0SYu+N7JX_HKpLRfofDy_5ACD+2A@mail.gmail.com>
In-Reply-To: <CABBYNZLFY0AcXJjaz5HQbB0SYu+N7JX_HKpLRfofDy_5ACD+2A@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 24 Feb 2025 11:58:04 +0800
X-Gm-Features: AWEUYZnm2pJCrx_qpLCx4HAbpEF49h1TzDf9VWnIjLxBypGI0kJhfJAwXT0kaeg
Message-ID: <CADg1FFdAgBuddxOE+a=WdqoeO7WxsgZHy7NmXcH71yBF-b+h7g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Feb 24, 2025 at 11:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Sun, Feb 23, 2025 at 10:21=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > Hi Luiz,
> >
> > On Mon, Feb 24, 2025 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Sun, Feb 23, 2025 at 9:26=E2=80=AFPM Hsin-chen Chuang <chharry@goo=
gle.com> wrote:
> > > >
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Automatically configure the altsetting for USER_CHANNEL when a SCO =
is
> > > > connected or disconnected. This adds support for the USER_CHANNEL t=
o
> > > > transfer SCO data over USB transport.
> > >
> > > I guess the tracking of handles is about handling disconnections,
> > > right? I wonder if we can get away without doing that, I didn't inten=
d
> > > to add a whole bunch of changes in order to switch to the right mode,
> > > I get that you may want to disable the isochronous endpoint in case
> > > there is no connection, but I guess that only matters if we are
> > > talking about power but the impact is probably small so I don't think
> > > it is worth it. There is an alternative to match the SCO/eSCO handle
> > > via mask, like we do with ISO handles, that is probably a lot cheaper
> > > than attempting to add a whole list for tracking handles, but it has
> > > the downside that it is vendor/model specific.
> >
> > Yes, that's for handling disconnection. What do you think if we keep
> > only one handle in the driver data? That is, assume there's at most
> > one SCO connection. Then we don't need a list but just a u16.
>
> Hmm, if you can guarantee that it only support at most 1 SCO
> connection that is fine, that said the user channel can be
> opened/closed in between so we would have to monitor things like reset
> as well, so I think we actually need to depend on the Kconfig/module
> parameter to ensure that only user mode will be used so it is safe to
> track the handle, that said I think you will need to intercept things
> like reset anyway since it does affect any handles the driver would
> have stored so you probably need to change the alt setting in case an
> SCO connection was established.

Thanks for the explanation and I understood your concern. Indeed
tracking handles would require way too much effort to ensure it's
correct. I will follow your first approach to keep it simple for now.


>
> Btw, if we really want to be safe here we should probably think about
> ways to test loading the btusb on bluez CI and adding testing to it,
> that said that would require emulation to USB vid/pid and possibly the
> vendor commands necessary in order to set up the controller.
>
> > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > >
> > > >  drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++---=
----
> > > >  1 file changed, 186 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index de3fa725d210..dfb0918dfe98 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -854,6 +854,11 @@ struct qca_dump_info {
> > > >  #define BTUSB_ALT6_CONTINUOUS_TX       16
> > > >  #define BTUSB_HW_SSR_ACTIVE    17
> > > >
> > > > +struct sco_handle_list {
> > > > +       struct list_head list;
> > > > +       u16 handle;
> > > > +};
> > > > +
> > > >  struct btusb_data {
> > > >         struct hci_dev       *hdev;
> > > >         struct usb_device    *udev;
> > > > @@ -920,6 +925,9 @@ struct btusb_data {
> > > >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > > >
> > > >         struct qca_dump_info qca_dump;
> > > > +
> > > > +       /* Records the exsiting SCO handles for HCI_USER_CHANNEL */
> > > > +       struct list_head sco_handle_list;
> > > >  };
> > > >
> > > >  static void btusb_reset(struct hci_dev *hdev)
> > > > @@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct =
btusb_data *data)
> > > >         spin_unlock_irqrestore(&data->rxlock, flags);
> > > >  }
> > > >
> > > > +static void btusb_sco_handle_list_clear(struct list_head *list)
> > > > +{
> > > > +       struct sco_handle_list *entry, *n;
> > > > +
> > > > +       list_for_each_entry_safe(entry, n, list, list) {
> > > > +               list_del(&entry->list);
> > > > +               kfree(entry);
> > > > +       }
> > > > +}
> > > > +
> > > > +static struct sco_handle_list *btusb_sco_handle_list_find(
> > > > +       struct list_head *list,
> > > > +       u16 handle)
> > > > +{
> > > > +       struct sco_handle_list *entry;
> > > > +
> > > > +       list_for_each_entry(entry, list, list)
> > > > +               if (entry->handle =3D=3D handle)
> > > > +                       return entry;
> > > > +
> > > > +       return NULL;
> > > > +}
> > > > +
> > > > +static int btusb_sco_handle_list_add(struct list_head *list, u16 h=
andle)
> > > > +{
> > > > +       struct sco_handle_list *entry;
> > > > +
> > > > +       if (btusb_sco_handle_list_find(list, handle))
> > > > +               return -EEXIST;
> > > > +
> > > > +       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > > > +       if (!entry)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       entry->handle =3D handle;
> > > > +       list_add(&entry->list, list);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int btusb_sco_handle_list_del(struct list_head *list, u16 h=
andle)
> > > > +{
> > > > +       struct sco_handle_list *entry;
> > > > +
> > > > +       entry =3D btusb_sco_handle_list_find(list, handle);
> > > > +       if (!entry)
> > > > +               return -ENOENT;
> > > > +
> > > > +       list_del(&entry->list);
> > > > +       kfree(entry);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void btusb_sco_conn_change(struct btusb_data *data, struct =
sk_buff *skb)
> > > > +{
> > > > +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > +       struct hci_dev *hdev =3D data->hdev;
> > > > +
> > > > +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < =
sizeof(*hdr))
> > > > +               return;
> > > > +
> > > > +       switch (hdr->evt) {
> > > > +       case HCI_EV_DISCONN_COMPLETE: {
> > > > +               struct hci_ev_disconn_complete *ev =3D
> > > > +                       (void *) skb->data + sizeof(*hdr);
> > > > +               u16 handle;
> > > > +
> > > > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev-=
>status)
> > > > +                       return;
> > > > +
> > > > +               handle =3D __le16_to_cpu(ev->handle);
> > > > +               if (btusb_sco_handle_list_del(&data->sco_handle_lis=
t,
> > > > +                                             handle) < 0)
> > > > +                       return;
> > > > +
> > > > +               bt_dev_info(hdev, "disabling SCO");
> > > > +               data->sco_num--;
> > > > +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> > > > +               schedule_work(&data->work);
> > > > +
> > > > +               break;
> > > > +       }
> > > > +       case HCI_EV_SYNC_CONN_COMPLETE: {
> > > > +               struct hci_ev_sync_conn_complete *ev =3D
> > > > +                       (void *) skb->data + sizeof(*hdr);
> > > > +               unsigned int notify_air_mode;
> > > > +               u16 handle;
> > > > +
> > > > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev-=
>status)
> > > > +                       return;
> > > > +
> > > > +               switch (ev->air_mode) {
> > > > +               case BT_CODEC_CVSD:
> > > > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_C=
VSD;
> > > > +                       break;
> > > > +
> > > > +               case BT_CODEC_TRANSPARENT:
> > > > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_T=
RANSP;
> > > > +                       break;
> > > > +
> > > > +               default:
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               handle =3D __le16_to_cpu(ev->handle);
> > > > +               if (btusb_sco_handle_list_add(&data->sco_handle_lis=
t,
> > > > +                                             handle) < 0) {
> > > > +                       bt_dev_err(hdev, "failed to add the new SCO=
 handle");
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               bt_dev_info(hdev, "enabling SCO with air mode %u",
> > > > +                           ev->air_mode);
> > > > +               data->sco_num++;
> > > > +               data->air_mode =3D notify_air_mode;
> > > > +               schedule_work(&data->work);
> > > > +
> > > > +               break;
> > > > +       }
> > > > +       default:
> > > > +               break;
> > > > +       }
> > > > +}
> > > > +
> > > >  static int btusb_recv_event(struct btusb_data *data, struct sk_buf=
f *skb)
> > > >  {
> > > >         if (data->intr_interval) {
> > > > @@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_dat=
a *data, struct sk_buff *skb)
> > > >                 schedule_delayed_work(&data->rx_work, 0);
> > > >         }
> > > >
> > > > +       /* Configure altsetting for HCI_USER_CHANNEL on SCO dis/con=
nected */
> > > > +       if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > +               btusb_sco_conn_change(data, skb);
> > >
> > > I'd recommend adding a check for Kconfig/module parameter in the if
> > > statement so btusb_sco_conn_change only runs on distros with it
> > > enabled so we don't risk something not working as expected just
> > > because someone decided to open the user channel.
> >
> > Sure will add it in the next patch.
> >
> > >
> > > >         return data->recv_event(data->hdev, skb);
> > > >  }
> > > >
> > > > @@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_=
data *data)
> > > >         usb_kill_anchored_urbs(&data->ctrl_anchor);
> > > >  }
> > > >
> > > > -static int btusb_close(struct hci_dev *hdev)
> > > > -{
> > > > -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > > -       int err;
> > > > -
> > > > -       BT_DBG("%s", hdev->name);
> > > > -
> > > > -       cancel_delayed_work(&data->rx_work);
> > > > -       cancel_work_sync(&data->work);
> > > > -       cancel_work_sync(&data->waker);
> > > > -
> > > > -       skb_queue_purge(&data->acl_q);
> > > > -
> > > > -       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > > > -       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > > > -       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > > > -       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > > > -
> > > > -       btusb_stop_traffic(data);
> > > > -       btusb_free_frags(data);
> > > > -
> > > > -       err =3D usb_autopm_get_interface(data->intf);
> > > > -       if (err < 0)
> > > > -               goto failed;
> > > > -
> > > > -       data->intf->needs_remote_wakeup =3D 0;
> > > > -
> > > > -       /* Enable remote wake up for auto-suspend */
> > > > -       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > > > -               data->intf->needs_remote_wakeup =3D 1;
> > > > -
> > > > -       usb_autopm_put_interface(data->intf);
> > > > -
> > > > -failed:
> > > > -       usb_scuttle_anchored_urbs(&data->deferred);
> > > > -       return 0;
> > > > -}
> > > > -
> > > >  static int btusb_flush(struct hci_dev *hdev)
> > > >  {
> > > >         struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > > @@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *w=
ork)
> > > >         }
> > > >  }
> > > >
> > > > +static int btusb_close(struct hci_dev *hdev)
> > > > +{
> > > > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > > +       int err;
> > > > +
> > > > +       BT_DBG("%s", hdev->name);
> > > > +
> > > > +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > > > +               btusb_sco_handle_list_clear(&data->sco_handle_list)=
;
> > > > +               data->sco_num =3D 0;
> > > > +               if (data->isoc_altsetting !=3D 0)
> > > > +                       btusb_switch_alt_setting(hdev, 0);
> > > > +       }
> > > > +
> > > > +       cancel_delayed_work(&data->rx_work);
> > > > +       cancel_work_sync(&data->work);
> > > > +       cancel_work_sync(&data->waker);
> > > > +
> > > > +       skb_queue_purge(&data->acl_q);
> > > > +
> > > > +       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > > > +       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > > > +       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > > > +       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > > > +
> > > > +       btusb_stop_traffic(data);
> > > > +       btusb_free_frags(data);
> > > > +
> > > > +       err =3D usb_autopm_get_interface(data->intf);
> > > > +       if (err < 0)
> > > > +               goto failed;
> > > > +
> > > > +       data->intf->needs_remote_wakeup =3D 0;
> > > > +
> > > > +       /* Enable remote wake up for auto-suspend */
> > > > +       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > > > +               data->intf->needs_remote_wakeup =3D 1;
> > > > +
> > > > +       usb_autopm_put_interface(data->intf);
> > > > +
> > > > +failed:
> > > > +       usb_scuttle_anchored_urbs(&data->deferred);
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void btusb_waker(struct work_struct *work)
> > > >  {
> > > >         struct btusb_data *data =3D container_of(work, struct btusb=
_data, waker);
> > > > @@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *=
intf,
> > > >         data->udev =3D interface_to_usbdev(intf);
> > > >         data->intf =3D intf;
> > > >
> > > > +       INIT_LIST_HEAD(&data->sco_handle_list);
> > > > +
> > > >         INIT_WORK(&data->work, btusb_work);
> > > >         INIT_WORK(&data->waker, btusb_waker);
> > > >         INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> > > > @@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_inter=
face *intf)
> > > >         hdev =3D data->hdev;
> > > >         usb_set_intfdata(data->intf, NULL);
> > > >
> > > > +       btusb_sco_handle_list_clear(&data->sco_handle_list);
> > > > +
> > > >         if (data->isoc) {
> > > >                 device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > > >                 usb_set_intfdata(data->isoc, NULL);
> > > > --
> > > > 2.48.1.601.g30ceb7b040-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz

--
Best Regards,
Hsin-chen

