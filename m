Return-Path: <linux-kernel+bounces-430613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BA9E338C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F616283D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE6187858;
	Wed,  4 Dec 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NPppGEpK"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A87143888
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733293849; cv=none; b=M5cp3LLQrDwPfZKyRvxnynqn75lnQUDlUDbu94Dr7cyqZS1mn0wB/1NS/6zUvkzQ7M3EfjyzFll5phNpzX97nKdPyzjpxd30Lo6D0funAvpR3CuHn+id4Um3mZUtAObPkpfc4IIx+k1nfmnBmrvwEj2j3Ei0Cnu0cElAja7HMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733293849; c=relaxed/simple;
	bh=u8/FhKS6syL2h6vpp19qkb8ugo62/NjIFJc/lxA1Q2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvQap0FIrWEntkuZJaVusy8WxkNyfjWldPu6PVpCkj/4tgIUMYRlFite6IxqpPSlH5ipoeYCOFSCu7NJqH6kQ1n4KYoIeDo0offx+pu8zvJ7ZMEdEkYPsk0VxSNCTvm9nyacGlas3YXU0H7q38spJUK/m5f0ZtHZr2huhQHFcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NPppGEpK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DEB73F1CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733293843;
	bh=Vu4AWTTF9NWZIyLPtlOp2MAWisE9ji+w1i+PTwK1h7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NPppGEpKp/TpkMNPQRqE0T+VnrpgmQtdx97Cl8TtWhuzJoWYOAPnRcQGImRGZ7mr5
	 dZp67K9Dt3lUpGT75FXO2odokmf6/WGBZs4pvDXqcOjS/6Jr2T1hRPa4X/DRSjFSN7
	 YmqJ3nEwdiuPLBSkd3Ey/tgIcFnMo8C5ITCAuvkgRIxxSyzNJVUHEk26wW2HGE0Tlw
	 QkuGklL6Ql3j3RwvywJtUPTup1E+w4jPK4Z7u/Mzbxd46QllGubX6X7J+vlUqSDoo4
	 RWHe90cGE9Ck/+T47/bd8TkTfDoNskR0Cr1CmIaesqgaS8rQvMaOTqswfT70yJ86pG
	 dW/tdebZeqE0Q==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e27c5949so2766268f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 22:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733293842; x=1733898642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu4AWTTF9NWZIyLPtlOp2MAWisE9ji+w1i+PTwK1h7E=;
        b=gBh0LRhbwE52G4W5aU4qmYA+HdNC8bNtLUi9tepuEr43wzbmftpUfPfRrdNS7+P5kh
         FA+8k6cqGaip+4uViNeO/XNbuoZED89scS/CU5chJASIsWe9f+t6Zm06a5NyQlWAmb9R
         dWcmtHvhME/G8SqQr3p8IS0FS0cIQ8JqIpfxDvavf2Gmh2zfnuX2gOHRcoWlj9rjZ4mu
         LON28ttrTLfjF41sXuLC6xibYsHuxv6CcfikpFwDhuwIKronmKMjRzwFPlg1aFeVqxTo
         yK1B3/dXFL8r6cXjYWRSa2G4g46T/HsB+65CReY5Z7UdrAYZFyoalNn0sV7/ItJw1ZVk
         Kbhw==
X-Forwarded-Encrypted: i=1; AJvYcCVboObf5dsTmyzOPIpMdt22qn0ALYRvUgJzVSnVAzBdcAAzBpt+MQq8tH1zOSA5FtcBg+c6LoK63GEEcwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mk7Pz3uS0hXYV5O/FTip2M9AQsD9ztRw6boNn1UtYx58EAaN
	hh5MDX7qzI1vf1rYF8R+IjV0OTjtbXOt8Fp7MciJZA5W7rdonedfAbFVGDXtcsVCICG6zAkIzGz
	foav0tuYyaGScHdG+GQ82WMp8L806YTaWrvAtyfrwpSuoS22X4hSZtyxGDMUgQNgZuS/Dm3P/D2
	mpHPmlKRpYP5IJWI5uifBcBq9zmEmLBizRTYPmGnt/kaBJHt6n8jA0
X-Gm-Gg: ASbGnct0/YsnOQdDjhWUnuBrtbQ9pdqv+jTPgQQ/hkNlt7Enfa9tDq1SWxsLWtB3LOQ
	zYxbDAfYG7OvsJwGHtK9MTxRW5RLkhX6U
X-Received: by 2002:a05:6000:2b0d:b0:385:e9c0:c069 with SMTP id ffacd0b85a97d-385fd433373mr3201327f8f.57.1733293842510;
        Tue, 03 Dec 2024 22:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKkV5ER1fJMeaNPt9eXdid2Bgy53nhFydaMsm5HpgMyJxVgBYK7Sk/f/FxzBOxkqpnahXd9nHs6aTfHvCS8o=
X-Received: by 2002:a05:6000:2b0d:b0:385:e9c0:c069 with SMTP id
 ffacd0b85a97d-385fd433373mr3201311f8f.57.1733293842135; Tue, 03 Dec 2024
 22:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202023041.492547-1-en-wei.wu@canonical.com> <CABBYNZLBGSKp_ew1Zk5YXrpsdue4aHObfavNcQQ8KOCymt7Eww@mail.gmail.com>
In-Reply-To: <CABBYNZLBGSKp_ew1Zk5YXrpsdue4aHObfavNcQQ8KOCymt7Eww@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 4 Dec 2024 14:30:31 +0800
Message-ID: <CAMqyJG0n5evc5-BAyT+R5+Sq15VJoqoEo2uhH6bjAd_Y5egiQQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com, 
	kuan-ying.lee@canonical.com, anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 05:23, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi En-Wei,
>
> On Sun, Dec 1, 2024 at 9:30=E2=80=AFPM En-Wei Wu <en-wei.wu@canonical.com=
> wrote:
> >
> > The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash du=
mp
> > collection through devcoredump. During this process, the crash dump dat=
a
> > is queued to a dump queue as skb for further processing.
> >
> > A NULL pointer dereference occurs in skb_dequeue() when processing the
> > dump queue due to improper return value handling:
> >
> > [ 93.672166] Bluetooth: hci0: ACL memdump size(589824)
> >
> > [ 93.672475] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> > [ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
> > [ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80
> >
> > The issue stems from handle_dump_pkt_qca() returning the wrong value on
> > success. It currently returns the value from hci_devcd_init() (0 on
> > success), but callers expect > 0 to indicate successful dump handling.
> > This causes hci_recv_frame() to free the skb while it's still queued fo=
r
> > dump processing, leading to the NULL pointer dereference when
> > hci_devcd_rx() tries to dequeue it.
> >
> > Fix this by:
> >
> > 1. Extracting dump packet detection into new is_dump_pkt_qca() function
> > 2. Making handle_dump_pkt_qca() return 0 on success and negative errno
> >    on failure, consistent with other kernel interfaces
> >
> > This prevents premature skb freeing by ensuring proper handling of
> > dump packets.
> >
> > Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support=
")
> > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> > ---
> > changes in v2:
> > - Fix typo in the title
> > - Re-flow a line in the commit message to fit 72 characters
> > - Add a blank line before btusb_recv_acl_qca()
> >
> > drivers/bluetooth/btusb.c | 76 ++++++++++++++++++++++++---------------
> >  1 file changed, 48 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 279fe6c115fa..741be218610e 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *=
hdev)
> >                 bt_dev_err(hdev, "%s: triggle crash failed (%d)", __fun=
c__, err);
> >  }
> >
> > -/*
> > - * =3D=3D0: not a dump pkt.
> > - * < 0: fails to handle a dump pkt
> > - * > 0: otherwise.
> > - */
> > +/* Return: 0 on success, negative errno on failure. */
> >  static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *s=
kb)
> >  {
> > -       int ret =3D 1;
> > +       int ret =3D 0;
> >         u8 pkt_type;
> >         u8 *sk_ptr;
> >         unsigned int sk_len;
> >         u16 seqno;
> >         u32 dump_size;
> >
> > -       struct hci_event_hdr *event_hdr;
> > -       struct hci_acl_hdr *acl_hdr;
> >         struct qca_dump_hdr *dump_hdr;
> >         struct btusb_data *btdata =3D hci_get_drvdata(hdev);
> >         struct usb_device *udev =3D btdata->udev;
> > @@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *=
hdev, struct sk_buff *skb)
> >         sk_len =3D skb->len;
> >
> >         if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> > -               acl_hdr =3D hci_acl_hdr(skb);
> > -               if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_H=
ANDLE)
> > -                       return 0;
> >                 sk_ptr +=3D HCI_ACL_HDR_SIZE;
> >                 sk_len -=3D HCI_ACL_HDR_SIZE;
>
> I know this is in the original code, but this is totally unsafe, we
> can't go accessing the skb->data pointer without validating it has
> this size, not to mention it is a little odd, to say the least, to
> encode a dump event into a an ACL data packet, but then again it was
> in the original code so I assume the firmware really does weird things
> like this.
>
> Anyway if we know for sure this is a dump packet it shall be possible
> to use the likes of skb_pull_data and stop doing unsafe access like
> this.
>
> > -               event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> > -       } else {
> > -               event_hdr =3D hci_event_hdr(skb);
> >         }
> >
> > -       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> > -               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE))=
)
> > -               return 0;
> > -
> >         sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> >         sk_len -=3D HCI_EVENT_HDR_SIZE;
>
> Ditto, just use skb_pull_data.
>
> >         dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> > -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> > -               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> > -           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> > -               return 0;
> > -
> > -       /*it is dump pkt now*/
> >         seqno =3D le16_to_cpu(dump_hdr->seqno);
> >         if (seqno =3D=3D 0) {
> >                 set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> > @@ -3052,17 +3030,59 @@ static int handle_dump_pkt_qca(struct hci_dev *=
hdev, struct sk_buff *skb)
> >         return ret;
> >  }
> >
> > +/* Return: true if packet is a dump packet, false otherwise. */
> > +static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> > +       u8 pkt_type;
> > +       u8 *sk_ptr;
> > +       unsigned int sk_len;
> > +
> > +       struct hci_event_hdr *event_hdr;
> > +       struct hci_acl_hdr *acl_hdr;
> > +       struct qca_dump_hdr *dump_hdr;
> > +
> > +       pkt_type =3D hci_skb_pkt_type(skb);
> > +       sk_ptr =3D skb->data;
> > +       sk_len =3D skb->len;
> > +
> > +       if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> > +               acl_hdr =3D hci_acl_hdr(skb);
> > +               if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_H=
ANDLE)
> > +                       return false;
> > +               sk_ptr +=3D HCI_ACL_HDR_SIZE;
> > +               sk_len -=3D HCI_ACL_HDR_SIZE;
> > +               event_hdr =3D (struct hci_event_hdr *)sk_ptr;
>
> At this point we can actually use skb_pull_data as well since I don't
> think the stack is supposed to process data packets with
> QCA_MEMDUMP_ACL_HANDLE as handle.
>
> > +       } else {
> > +               event_hdr =3D hci_event_hdr(skb);
> > +       }
> > +
> > +       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> > +               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE))=
)
> > +               return false;
> > +
> > +       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> > +       sk_len -=3D HCI_EVENT_HDR_SIZE;
>
> Unsafe access, sk_len might loop around as well.
>
> > +       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> > +       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> > +               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> > +           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> > +               return false;
> > +
> > +       return true;
>
> This should probably be places in a qca specific portion, also this is
> not very efficient, so I wonder if we should have some means for
> driver to register handles for its vendor events like this, so driver
> don't have to go pick the packet appart to detect that it is not
> really meant for the Bluetooth stack to process.
>
Agree, I think maybe we can go over that in the future.

> > +}
> > +
> >  static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *sk=
b)
> >  {
> > -       if (handle_dump_pkt_qca(hdev, skb))
> > -               return 0;
> > +       if (is_dump_pkt_qca(hdev, skb))
> > +               return handle_dump_pkt_qca(hdev, skb);
>
> This should be something like btqca_recv_acl, etc.
>
For the new helper is_dump_pkt_qca(), I think it's suitable to be
moved into a vendor specific file (btqca.c) like you said.

But I'm wondering if we should do the same thing to
btusb_recv_acl_qca()/btusb_recv_event_qca(), because they are meant to
be only used in the btusb.c.

> >         return hci_recv_frame(hdev, skb);
> >  }
> >
> >  static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *sk=
b)
> >  {
> > -       if (handle_dump_pkt_qca(hdev, skb))
> > -               return 0;
> > +       if (is_dump_pkt_qca(hdev, skb))
> > +               return handle_dump_pkt_qca(hdev, skb);
>
> Ditto, also since there is a clear difference between event vs ACL
> packet I don't think it should be calling the same helper function to
> detect if it is a dump packet or not.
>
> >         return hci_recv_frame(hdev, skb);
> >  }
> >
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz
Best regards,
En-Wei.

