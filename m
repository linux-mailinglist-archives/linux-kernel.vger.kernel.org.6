Return-Path: <linux-kernel+bounces-336087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A397EEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E971E1C214EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612619E980;
	Mon, 23 Sep 2024 16:13:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695619CC3D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108003; cv=none; b=YUQMKckkY7bVkSZ1QpI2tpdDULQf8mjvWDk1H5VuuCYzB5fe7XiurP3Swik6+QrSjwGDFNJkw6+hP5iz9fHRgvOW5oJtY8lZzh4VUz57NxZqhtufat+RjaIBjHBUWUEtJqwxi2pdjrzUoplvXiEel5huZOpyEE9LKIrAfLrnQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108003; c=relaxed/simple;
	bh=wQ0W5zFheriKR/UA29fmXrqkPTUMq2ZjruDvXpG9u7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KIdEld+ovNgpSt4Y9VLiQc26Z6MSjKLwkYrRDkdJqboQNi0rSYJClqz1flPHjftp8l9qdVU4hZG7icniH+u/sFF5bMjnZm9o93C5/fPs/ovumdL+9x+WdHWbsvApKNscg6coSdmkekinsYWQnII0rsWtwhukEv5k11PDqGV9Mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so52605955ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108001; x=1727712801;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ0W5zFheriKR/UA29fmXrqkPTUMq2ZjruDvXpG9u7o=;
        b=BbCYBGbmX6Tf5WcpHEVkasZjhR6yJ3Yi+gZkek8Mn1TFXzZrab3/36YKwtwdxxcVNx
         sRGHWln+XdBCeJRI3QdIXX04W9NxIdH2id+ZlVn/BbgzKxkv9c7hZySmKBs0nspEI/W3
         Pd9T6CpJ4HSN1jDpPdN4E0/qjl5uYZ9EFoMDmjvpYek1Pkh35yRF3ouBn3F4s9dzCt6R
         1jj62Cj6hEL4T/KabNnRo9aJjmDw4u8uinpzHYpx03iGzP9JZ1SqZ2juNHW7PSe0CeZZ
         wKslE0kckKJym1np9xu9tEg+WiZe2vx3hWicVBpoLrB07TVyQE/2Z3Ky7e7tHwB8rRxY
         r7KQ==
X-Gm-Message-State: AOJu0YxBTekvCeUhymk6EaOEGzezs2HlOgBs+RP/BztRXJNqA2y2j84B
	/lt57YgWhibDePmBknb7ljoGGZ/uLWlRR5UwJ16SGTcdAAs5EIrlBO/DRGV3RMGBkAAj1c32+qt
	uwoSQdxVIe5oSO0GqgeXvA133VUxoAigg3WUk/pnZGTwPoxzREGB4xR8=
X-Google-Smtp-Source: AGHT+IH4m0ACY88Fx2CbK4g6AajnhubPenp/LvmS6OBttXymrKhWUNZtC4cGKykrjRB8dhxKhjnLdaNV88xZAI5kBw9OzkkHPeZK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:3a0:bc89:612 with SMTP id
 e9e14a558f8ab-3a0c8ca172fmr128210855ab.8.1727108000988; Mon, 23 Sep 2024
 09:13:20 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:13:20 -0700
In-Reply-To: <000000000000d8f51a061ba88d22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f193a0.050a0220.3eed3.0011.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
Author: luiz.dentz@gmail.com

Hi Aleksandr,

On Mon, Sep 23, 2024 at 11:52=E2=80=AFAM Aleksandr Nogikh <nogikh@google.co=
m> wrote:
>
> (removed public mailing lists from Cc)
>
> On Mon, Sep 23, 2024 at 5:48=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, Sep 23, 2024 at 11:20=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Aleksandr,
> > >
> > > On Mon, Sep 23, 2024 at 10:37=E2=80=AFAM Aleksandr Nogikh <nogikh@goo=
gle.com> wrote:
> > > >
> > > > On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Hillf,
> > > > >
> > > > > On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sin=
a.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Maybe something like the following would be a better approach=
:
> > > > > > >
> > > > > > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a68=
46e
> > > > > >
> > > > > > If your idea is not bad, boy, feel free to win Tested-by from s=
yzbot with it.
> > > > >
> > > > > Is there a way to quickly check a patch with syzbot?
> > > >
> > > > You can send a `#syz test` command in a reply to syzbot and attach =
the
> > > > patch-to-test to the email message.
> > > >
> > > > See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#=
testing-patches
> > >
> Looks like the whitespaces still got lost while copy-pasting :(
> As an option, you can also just attach the patch as a file.

Yeah, looks like gmail web client screwing things up, anyway lets try
attaching the patch:

#syz test


--=20
Luiz Augusto von Dentz

