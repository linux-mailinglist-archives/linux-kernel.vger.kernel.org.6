Return-Path: <linux-kernel+bounces-336034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC897EE53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1B01C218FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED11197A8A;
	Mon, 23 Sep 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smh6gEFO"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD61E52C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105900; cv=none; b=Ozg7jHqdIjQ8iFyR0aJCUwjItzrWOYmtzX0FzYmYvqB9a1Jvg/96nbuh6iOc36e1kMIpNEhGyml8RNC4Knzfzeq1JTZ4cYuCrfMX5SU377r+teJQsxRBmK2vWdQeYtHTIXZozYX8FX43yb7kj8hde4GwofPp6Z5ANEXGxRkKdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105900; c=relaxed/simple;
	bh=VSO7uT2xkknVJM18+AB8me0n8jkiADuAZGka1TMUYUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwEfhlBtxSKSOjUmGtOaSKMrWVAjfRlN+E0/W/ZdtXdXsbKLAO9EwsAnZqG/2+nrt4ZsWkiOrq75ikXh/O989ygnT1V14Q1VGbnh5fjuCmUnesIwPZyRaJjE1ssJYTy5J4ykuXQwy60vcEJzOQT6E/LlBzYqPQjdLjJAOrE49pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smh6gEFO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7178df70f28so3445832b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727105897; x=1727710697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNWzqv0LAr+fZdDTxHUMZYVREs5mmsO0H8D59f7sYWo=;
        b=smh6gEFOtM1NN68d4dcC/ik3/u0uJ2GCOAEt4IoQAdPL8sXDUMgek4kaL0U+M/8lrj
         yZS+sIDiRgp0v1PP0rt8ov5A8buescyEDy8wjQuGsvJWtB0oVRdK+QA8m7IH5Bjevhgq
         61v8jHSwE8v8oVc3XjTeuRqkqr2TzcZ0oqSA1wSP1Id4AZhuLV8dwcklqODSwpZcfNbp
         5qFOMjZIm1LOFXE65s+V9+kZZB4oX/efJarVDGJMsSO6uJNYhM2idizNDwli8yVer40r
         3DiyWE7DZIHFlOqQT0t7KwhksKYkhoMjx4oG+lMDjZfNMj7cM4M+cwRIxQbO18eKFRd8
         5HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105897; x=1727710697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNWzqv0LAr+fZdDTxHUMZYVREs5mmsO0H8D59f7sYWo=;
        b=Q0sY/DMl3UNNXpNKcB5+mU0MWAquh56tAZg/guqyyo1JX2M80kweFhbya5ibBZMCeo
         Y7jt0QIU6+g8UvHP6+cgPIgDNrdrmEGioAVfwxKXk7ODnvU6UE0pivVZhPwUB0A2IUOu
         2gb8+843Qni2b84vueHG9+lpyYDtYyDziJMTE2WPv6xCYXClbmtcVv2ldkRp8Ul1Y5rS
         CA16lDuRU7mDI43ffWL3B4Nd5IpPkt3ROmVA++nYvyE9ifudimCO2z1W+O/d8iXYjmWi
         xH8wem2kV7ez9zhJ/BmwimuTOBwYHASF84SDt9OJZ9V8dma7qFfBJ3X/38+Gnka0M/l2
         6QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWfobzhC/14l7JyE5qrOKot3F3dJphNXuF3g/szimQV13hkuqN6NqizfoQydFPxFkZAVbn3hfH0lKaIX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9gmSSHDPeMewmprkiw692jBuCZBVzI1VDxWBLNycLCNoBbAl
	gB48WiPa7glsCJm0jY0Skg/u5jOjQo3L8TqKOet7g3DVe/BTH9muZ8dm8QLRk1NyBbrFhiPNK6M
	/vzUQK4hMo56FxdvrFmoAHz/GvGKOd/lkNg9d
X-Google-Smtp-Source: AGHT+IHb0BavWVYG7v04YHJffKMfU7HscEjRUekuoT8uTPQ23YGmVCA6QDcIxU2xREn0sHZXAP50DGIUQSnj5uEeV+o=
X-Received: by 2002:a05:6a00:a1b:b0:714:2620:d235 with SMTP id
 d2e1a72fcca58-7199c976712mr18027119b3a.16.1727105897072; Mon, 23 Sep 2024
 08:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
 <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com> <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
In-Reply-To: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Sep 2024 17:38:03 +0200
Message-ID: <CANp29Y7TBdGuThfBX1=K7jNj6_+0XqL0A3_=sF1xMMpMWNfoYg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Sep 23, 2024 at 5:20=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Aleksandr,
>
> On Mon, Sep 23, 2024 at 10:37=E2=80=AFAM Aleksandr Nogikh <nogikh@google.=
com> wrote:
> >
> > On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hillf,
> > >
> > > On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.co=
m> wrote:
> > > >
> > > > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
> > > > >
> > > > > Maybe something like the following would be a better approach:
> > > > >
> > > > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> > > >
> > > > If your idea is not bad, boy, feel free to win Tested-by from syzbo=
t with it.
> > >
> > > Is there a way to quickly check a patch with syzbot?
> >
> > You can send a `#syz test` command in a reply to syzbot and attach the
> > patch-to-test to the email message.
> >
> > See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#test=
ing-patches
>
> Thanks, lets see if this works:
>
> #syz test
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6976db02c06..b2f8f9c5b610 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev
> *hdev, struct sk_buff *skb)
>
>         hci_dev_lock(hdev);
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> +       if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
> +               mgmt_device_connected(hdev, conn, NULL, 0);
>         hci_dev_unlock(hdev);
>

^^ Patch parsing will fail here because it expects to see the git diff
output as is -- i.e. if some line only consisted of a single
whitespace (=3D it was an empty line and it did not change), it must
remain so. Sometimes these whitespaces get lost during copy-pasting
and it confuses syzbot.

>         if (conn) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 1c82dcdf6e8f..b87c0f1dab9e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3706,7 +3706,7 @@ static void hci_remote_features_evt(struct
> hci_dev *hdev, void *data,
>                 goto unlock;
>         }
>
> -       if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flag=
s)) {
> +       if (!ev->status) {
>                 struct hci_cp_remote_name_req cp;
>                 memset(&cp, 0, sizeof(cp));
>                 bacpy(&cp.bdaddr, &conn->dst);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9988ba382b68..6544c1ed7143 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn
> *conn, struct l2cap_cmd_hdr *cmd,
>  static int l2cap_connect_req(struct l2cap_conn *conn,
>                              struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *=
data)
>  {
> -       struct hci_dev *hdev =3D conn->hcon->hdev;
> -       struct hci_conn *hcon =3D conn->hcon;
> -
>         if (cmd_len < sizeof(struct l2cap_conn_req))
>                 return -EPROTO;
>
> -       hci_dev_lock(hdev);
> -       if (hci_dev_test_flag(hdev, HCI_MGMT))
> -               mgmt_device_connected(hdev, hcon, NULL, 0);
> -       hci_dev_unlock(hdev);
> -
>         l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
>         return 0;
>  }

--=20
Aleksandr

