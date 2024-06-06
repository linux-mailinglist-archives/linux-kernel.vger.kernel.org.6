Return-Path: <linux-kernel+bounces-204263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD728FE661
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B951C251A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1319596A;
	Thu,  6 Jun 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd9Znjx+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66313B28A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676504; cv=none; b=bjxYEXZA4nJ/4a0+62qk0PPfsxBHoElT9X6TPQDCZz1tbVGCJ7j37Ub9sBMTKJ/U0/BAVV5f4akO01AJTXjh5CHwgvixW4XZVY0DmPAw7gDEO6k1JDp9CBi/+61AAWJvtNG6D0R2ODPQOPIsPQwWzGAKRQsegmCMCxA1GySdm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676504; c=relaxed/simple;
	bh=qurimzIkT/yPut3biOsKiqGxlHYduWbPU8YbwTgqDHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHpTTUmt04OVC8R2iLLhen4I96RWOPk1Qogz7iE/FBD4cJYcvhd9u1XMaOyeOeinQuxAhDk1AfiCB+En5GMfUZprsuH3Au9xC/2pMgCkD4VhwZHX/mtVX0pJnPMmD4eK3vYeYGyoKNx/fAJfsycQMmQuHY4qeQhQuxcg7hAQ0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd9Znjx+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so14484a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717676501; x=1718281301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBgGTryxhc3C7oVWPcQ7xu87S9ZJmNwoP7ur83yFeJc=;
        b=rd9Znjx+aGNuAMTX+oQsvAaqVjEa7K55ydVl1rufqvH1+emuUXZ1I4phDqXTz36+uG
         9p8OG5N9o1rrgtO3G5VefJ2kymAwbJPMOEgNhZvLo/QcV8z3Jh51tJi+qKDAECKygN6q
         FHgrYn5xxfVYdcUcoq4jFgcHjzomoVqHE1upkNxn6if/KuB1gy5yEMPyf1qksvQzsuwN
         zYmkLSXFEiVX3kL9uywwS/XCNTiGXc4/UYe115GKjJM3f8ut7itiZ+jcg7ySEuHtaVd/
         u2bf2JYY4rK8D1bWaMpZRBsErmDV7y/tx1obHLYrxRKsmH+RqhU/wbBNufESc2816Sek
         ZE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717676501; x=1718281301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBgGTryxhc3C7oVWPcQ7xu87S9ZJmNwoP7ur83yFeJc=;
        b=ZkBcaiR6dnLdm2i5ijhSjRSXHYmwW5+SNoUFhbyt2nDi+OTi5c6AIEbdOqnxw4IWHm
         iUzfB4JJe43wSk2l0cF03Z5mAnRwd2jvc4V96snuY6BrKqA2gQsFxtlDegQrMu7+fXII
         W8dUhcVXbawAgTTpUKPG3Ny65BUwxGyziaXt6zFePxtHA2oQrgQ4QR+BbSyRyy+39T1+
         pu8tKhwoM7Dpq3zwRx5HxbRRCPDZVfYLix1tun8PkZLYAjGJC5nvuLnYibzkawih2QAo
         tdZhKqh2g/aK/XbKeBoRJFc8s8e2fWnyE0IN0ys45/GC3HqAK521xgGf5ai+JXK/tzNy
         6SKg==
X-Forwarded-Encrypted: i=1; AJvYcCVWG1xktInoc9FD9+fYwFvE4w2/vsKXxrlVsPLN9Qy6Xtozg7aIZ7TkFenOsy7JQAdj3wvo/4oTe2nsk0rpSCK1LQd6CXnIgVn6rVNI
X-Gm-Message-State: AOJu0YxxAWrL7dWtjYtF5gLfLE67JQkAwpoOHEv72dJKyTAv0I4v8oOK
	7eAxDZQJhiz83L1zEe3Y66HmeEzpLvQt9QDNt5orqjkO6ZnRc3smOZv7oIGhGW5qS7sLXEDkz8h
	NjpIe10wEO/j0OdsNScBogpW4A5Njjkm0qrTC
X-Google-Smtp-Source: AGHT+IHHA1ypHrQf9AHRBVrEa3tgpGTQIfew32GMMVEDbVj4YWn2Slnrzs9G7rAF/lLvXtqAd6L1rlCoYl+G/Lwf2zg=
X-Received: by 2002:a05:6402:2d7:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57aa680b57bmr209603a12.0.1717676500303; Thu, 06 Jun 2024
 05:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
 <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
 <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com>
 <CABBYNZJK6zyYYmi66prKMdF69HkwfhOvMeB0TnEcGYRLTTr2jw@mail.gmail.com>
 <CANFp7mWWYmm9gPrsDBho3sDGu5q_fQztR+LJJUWQ_Faw0QRXFQ@mail.gmail.com>
 <CABBYNZLtDc2MVh8f=2vLK6czfiz8wN=940exiw+fDv-fkNkqJA@mail.gmail.com> <CANFp7mUFn3U6z1b2+tMPAxHVOHQsazzo8tZZfFBOpCUaNMsP3A@mail.gmail.com>
In-Reply-To: <CANFp7mUFn3U6z1b2+tMPAxHVOHQsazzo8tZZfFBOpCUaNMsP3A@mail.gmail.com>
From: Archie Pusaka <apusaka@google.com>
Date: Thu, 6 Jun 2024 20:21:27 +0800
Message-ID: <CAJQfnxFE-4ue7WRTF75jRJ30TTUB0h7zzL2RsjYK23UEOd3n-A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Sorry for bringing back an old topic, but can we still ask your
opinion on this proposal once again?

Thank you,
Archie


On Thu, 2 May 2024 at 00:57, Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Wed, May 1, 2024 at 9:52=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Wed, May 1, 2024 at 12:34=E2=80=AFPM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > On Tue, Apr 30, 2024 at 9:46=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Abhishek,
> > > >
> > > > On Fri, Apr 26, 2024 at 1:04=E2=80=AFPM Abhishek Pandit-Subedi
> > > > <abhishekpandit@chromium.org> wrote:
> > > > >
> > > > > On Fri, Apr 26, 2024 at 2:08=E2=80=AFAM 'Archie Pusaka' via Chrom=
eOS Bluetooth
> > > > > Upstreaming <chromeos-bluetooth-upstreaming@chromium.org> wrote:
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Archie,
> > > > > > >
> > > > > > > On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusak=
a@google.com> wrote:
> > > > > > > >
> > > > > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > > > > >
> > > > > > > > Sometimes we want the controller to not wake the host up, e=
.g. to
> > > > > > > > save the battery. Add some debugfs knobs to force the wake =
by BT
> > > > > > > > behavior.
> > > > > > > >
> > > > > > > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > > > > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.=
com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> > > > > > > >  1 file changed, 19 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/=
btusb.c
> > > > > > > > index 8bede0a335668..846b15fc3c04c 100644
> > > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > > @@ -873,6 +873,9 @@ struct btusb_data {
> > > > > > > >         unsigned cmd_timeout_cnt;
> > > > > > > >
> > > > > > > >         struct qca_dump_info qca_dump;
> > > > > > > > +
> > > > > > > > +       bool force_enable_remote_wake;
> > > > > > > > +       bool force_disable_remote_wake;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static void btusb_reset(struct hci_dev *hdev)
> > > > > > > > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_in=
terface *intf,
> > > > > > > >
> > > > > > > >         debugfs_create_file("force_poll_sync", 0644, hdev->=
debugfs, data,
> > > > > > > >                             &force_poll_sync_fops);
> > > > > > > > +       debugfs_create_bool("force_enable_remote_wake", 064=
4, hdev->debugfs,
> > > > > > > > +                           &data->force_enable_remote_wake=
);
> > > > > > > > +       debugfs_create_bool("force_disable_remote_wake", 06=
44, hdev->debugfs,
> > > > > > > > +                           &data->force_disable_remote_wak=
e);
> > > > > > > >
> > > > > > > >         return 0;
> > > > > > > >
> > > > > > > > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_=
interface *intf, pm_message_t message)
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       if (!PMSG_IS_AUTO(message)) {
> > > > > > > > +               if (data->force_enable_remote_wake) {
> > > > > > > > +                       data->udev->do_remote_wakeup =3D 1;
> > > > > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPE=
ND, &data->flags))
> > > > > > > > +                               data->udev->reset_resume =
=3D 0;
> > > > > > > > +               } else if (data->force_disable_remote_wake)=
 {
> > > > > > > > +                       data->udev->do_remote_wakeup =3D 0;
> > > > > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPE=
ND, &data->flags))
> > > > > > > > +                               data->udev->reset_resume =
=3D 1;
> > > > > > > > +               }
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.44.0.769.g3c40516874-goog
> > > > > > >
> > > > > > > There is a D-Bus interface available to overwrite the wakeup =
setting:
> > > > > > >
> > > > > > > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Devi=
ce.rst#boolean-wakeallowed-readwrite
> > > > > > >
> > > > > > > Or do you want a master switch for it? On the other hand aren=
't we
> > > > > > > getting into the rfkill area if you really want to switch off=
 radio
> > > > > > > activity while suspended? That seems like a better idea then =
just
> > > > > > > disable remote wakeup.
> > > > >
> > > > > This DBUS api is different from the quirk this is introducing.
> > > > >
> > > > > The `Wake Allowed` field in D-bus controls whether we add the add=
ress
> > > > > to the Classic Event Filter (HIDP) or LE Filter Accept List (HOGP=
) but
> > > > > not whether we allow wake at the transport level (which is why
> > > > > hdev->wakeup exists).
> > > > >
> > > > > This change specifically addresses a quirk with Realtek chipsets:
> > > > > RTL8822/RTL8852 will do "global shutdown" and power off Bluetooth=
 if
> > > > > USB Remote Wake bit is not set. The USB remote_wake bit is normal=
ly
> > > > > set by the USB stack based on whether device_may_wakeup(udev) =3D=
=3D true.
> > > > > This means that RTL88x2 will lose power around suspend/resume if =
there
> > > > > are no wake capable devices connected.
> > > > >
> > > > > ChromeOS decided to use idle power and resume-time to determine
> > > > > whether to allow remote wake or not for these chipsets and we wan=
t to
> > > > > move this control to userspace so that we don't have to hold CHRO=
MIUM
> > > > > patches in the kernel applying this policy (we want udev rules
> > > > > instead). RTL8852 gets force enabled remote wake because the
> > > > > RESET_RESUME behavior of this chip would otherwise increase our r=
esume
> > > > > time >1s which breaks one of our platform requirements.
> > > > >
> > > > > The end-goal of these changes:
> > > > > * We detect RTL8822 or RTL8852 with udev and apply the right poli=
cy.
> > > > > * RTL8822 gets force_disable_remote_wake (idle power consumption =
too
> > > > > high otherwise)
> > > > > * RTL8852 gets force_enable_remote_wake (resume time too long oth=
erwise)
> > > >
> > > > Got it, but the suggestion was to instead of using
> > > > force_enable_remote_wake, which is sort of non-standard, why don't
> > > > Chrome OS simply use rkill interface to tell the driver to shutdown=
?
> > > > On resume then you can just unblock via rfkill that should have the
> > > > same result as using force_enable_remote_wake, well except if there=
 is
> > > > a bug in the driver that is not handling rfkill as a 'global
> > > > shutdown', but then you need to fix the driver not introduce yet
> > > > another debugfs entry to bypass it.
> > >
> > > Did you mean `force_disable_remote_wake`? rfkill will work for that
> > > around system suspend. We preferred not to do it because we don't use
> > > userspace suspend signals with Bluez today (preferring the kernel
> > > suspend notifier).
> >
> > Yeah, that said rfkill has nothing to do with suspend afaik, it is
> > more for achieving flight mode and as far I know it is a kernel
> > interface.
> >
> > > `force_enable_remote_wake` still needs debugfs as rfkill can't force
> > > an interface to stay awake as far as I know.
> >
> > You mixing up, Im not saying to use rfkill to enable/disable wake
> > support, the remains the same, what changes is that if you want to
> > overwrite that it just use rfkill to block the traffic while suspended
> > that way wake being enable or not doesn't matter since the controller
> > radio shall be off if it is blocked.
>
> Ah, the problem with resume time is not how long it takes for the
> Bluetooth link to come up. The problem is that it takes >1s for all
> the driver resume callbacks to run after a wake IRQ occurs and blocks
> user space from running at all.
>
> The root cause seems to be that reset-resume (which correctly gets set
> for Realtek) will block USB port resume and, since the resume path
> seems to be synchronous, it blocks other drivers from resuming too.
>
> >
> > >
> > > >
> > > > > Hope this provides enough context for why this change is necessar=
y.
> > > > >
> > > > > >
> > > > > > Yes, the initial idea was a master switch.
> > > > > > Thanks for your suggestions.
> > > > > > Let me discuss it with Abhishek.
> > > > > > >
> > > > > > > --
> > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > > Thanks,
> > > > > > Archie
> > > > > >
> > > > > > --
> > > > > > You received this message because you are subscribed to the Goo=
gle Groups "ChromeOS Bluetooth Upstreaming" group.
> > > > > > To unsubscribe from this group and stop receiving emails from i=
t, send an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org=
.
> > > > > > To post to this group, send email to chromeos-bluetooth-upstrea=
ming@chromium.org.
> > > > > > To view this discussion on the web visit https://groups.google.=
com/a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/CAJQfnxHUW%2BMdJU=
p9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ%40mail.gmail.com.
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz

