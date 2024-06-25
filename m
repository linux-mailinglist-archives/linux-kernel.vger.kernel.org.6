Return-Path: <linux-kernel+bounces-228668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083F916532
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665FB1C218A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06414A08B;
	Tue, 25 Jun 2024 10:24:12 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC3136E28
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311052; cv=none; b=qWtDTjR7AtHzefQ6IzJ8+F0fJTYkG6VicAoL+jO6QYfrzJGFfIt3Q+9tM9dpJsCRCgWPtH7TX2Vvl5ZS0FYK7emQAjdIynhJMRHix2vacOoU+TKXiGjSVcIcmwfxlnddSqnlMm1Ot4HeVO7NRo8fKLm+3I9pSoSlU6UDCbi6EBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311052; c=relaxed/simple;
	bh=qBcGDPmxvL4M0AMYOH8v/IMULS0eIr7aPitOVtTjk2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NzxedpHzYX5C88R1QyAIIG46twp+BrP9GduN5cysMhNuq9RaRFoQLnDYtaxfj2zGOR3L3MfRjMiavCtd5GVjXsYDgPOCLksLoKi09WkEZZ3TPfQo1sG9KbwLD4DdaQ9BJayfXzKn4RyNkRM4PFGQX2nHdLYlbP89/Dz8yNIJw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso746113339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311050; x=1719915850;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAEZlUMOtUqZuLfCSnjIcvMdPJ2DfhMWjQhOMq+TkCM=;
        b=ob2rcJZz1Q7pZmrygPZEGKZqzsTJcPlWj4T6TtZxO2fuux+r03H98MSI+WgBHYN++y
         ZRz5gqymTEjTtgnBUcDrZh99txap9V/8awZ6tZyygPgoRrBBCfWv2buDeOwKc/+ibPc9
         bFNdBJCimsNnKTjmK3Jq1poHMMFa4Gl04jetAnWF7lj5506K5BWQMBOojF47sKHa7wWa
         jEVb7njsjGOxI9FhkFYlFtx5+zVJEQJXglydZk2hZgJUxL4kCrTG/AF17Seifx+GF9Zf
         qVCSsU7UEgF/mkfAjx0C7irWnU2HxiH4sksxDvOklq1K0JIgU02YLdPjUFFUfoFYtVpF
         Dskw==
X-Gm-Message-State: AOJu0YzQ5BDdLzQDgleqCaYBw25dhW9Ky/bNvxe9ipJsCjj88o54UN8P
	oHA6h0c5R0B2eEa9WugqBgGbfj1xOWySVq08bdejugTcNlqdhfmg7r3cLqRRL6khJOtyuLvwJN4
	UDvidmprVXDI239D40JJNctc48LpQPtmDKBCqOduLMRIZ9n11Dlxs4sg=
X-Google-Smtp-Source: AGHT+IEn+roOPWnk0NHOJkCa+LPLQZIFfB5knVykLBq+/r533uXpftOSiNF0Yu0wiTuhv5OBiuqhmlUncv7I4sfSuql3c74L2Ar2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc4:b0:7eb:80e5:b5ca with SMTP id
 ca18e2360f4ac-7f3a1436ac4mr22016439f.2.1719311050183; Tue, 25 Jun 2024
 03:24:10 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:24:10 -0700
In-Reply-To: <000000000000051b2d06189716c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067a8dc061bb44c10@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] INFO: rcu detected stall in
 schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (=
6)
Author: marcello.bauer@9elements.com

#syz test

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1304,7 +1304,7 @@ static int dummy_urb_enqueue(
=20
        /* kick the scheduler, it'll do the rest */
        if (!hrtimer_active(&dum_hcd->timer))
-               hrtimer_start(&dum_hcd->timer,
ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+               hrtimer_start(&dum_hcd->timer,
ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL_SOFT);
=20
  done:
        spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,7 +1325,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd,
struct urb *urb, int status)
        rc =3D usb_hcd_check_unlink_urb(hcd, urb, status);
        if (!rc && dum_hcd->rh_state !=3D DUMMY_RH_RUNNING &&
                        !list_empty(&dum_hcd->urbp_list))
-               hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
HRTIMER_MODE_REL);
+               hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
HRTIMER_MODE_REL_SOFT);
=20
        spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
        return rc;
@@ -1995,7 +1995,7 @@ static enum hrtimer_restart dummy_timer(struct
hrtimer *t)
                dum_hcd->udev =3D NULL;
        } else if (dum_hcd->rh_state =3D=3D DUMMY_RH_RUNNING) {
                /* want a 1 msec delay here */
-               hrtimer_start(&dum_hcd->timer,
ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+               hrtimer_start(&dum_hcd->timer,
ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL_SOFT);
        }
=20
        spin_unlock_irqrestore(&dum->lock, flags);
@@ -2389,7 +2389,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
                dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
                set_link_state(dum_hcd);
                if (!list_empty(&dum_hcd->urbp_list))
-                       hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
HRTIMER_MODE_REL);
+                       hrtimer_start(&dum_hcd->timer, ns_to_ktime(0),
HRTIMER_MODE_REL_SOFT);
                hcd->state =3D HC_STATE_RUNNING;
        }
        spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2467,7 +2467,7 @@ static DEVICE_ATTR_RO(urbs);
=20
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-       hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
HRTIMER_MODE_REL);
+       hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
HRTIMER_MODE_REL_SOFT);
        dum_hcd->timer.function =3D dummy_timer;
        dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
        dum_hcd->stream_en_ep =3D 0;
@@ -2497,7 +2497,7 @@ static int dummy_start(struct usb_hcd *hcd)
                return dummy_start_ss(dum_hcd);
=20
        spin_lock_init(&dum_hcd->dum->lock);
-       hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
HRTIMER_MODE_REL);
+       hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC,
HRTIMER_MODE_REL_SOFT);
        dum_hcd->timer.function =3D dummy_timer;
        dum_hcd->rh_state =3D DUMMY_RH_RUNNING;

On Thu, 2024-05-16 at 15:01 -0700, syzbot wrote:
> syzbot has bisected this issue to:
>=20
> commit a7f3813e589fd8e2834720829a47b5eb914a9afe
> Author: Marcello Sylvester Bauer <sylv@sylv.io>
> Date:=C2=A0=C2=A0 Thu Apr 11 14:51:28 2024 +0000
>=20
> =C2=A0=C2=A0=C2=A0 usb: gadget: dummy_hcd: Switch to hrtimer transfer sch=
eduler
>=20
> bisection log:=C2=A0
> https://syzkaller.appspot.com/x/bisect.txt?x=3D119318d0980000
> start commit:=C2=A0=C2=A0 75fa778d74b7 Add linux-next specific files for
> 20240510
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
> final oops:=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/report.txt?x=3D139318d0980000
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D159318d0980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3Dccdd3ebd6715749a
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212c61
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D16dcd598980000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D151d9c78980000
>=20
> Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
> Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> transfer scheduler")
>=20
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection

--=20
=20
=20

 =20

    Marcello Sylvester Bauer
   =20

    Senior Linux Solutions Architect
   =20

 =20

 =20


 =20

 =20

   =20

     =20
        9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
       =20
   =20

   =20

     =20
       =20
          Email:=C2=A0
          marcello.bauer@9elements.com
         =20

       =20
     =20
     =20

       =20
          Phone:=C2=A0
       =20
       =20
         =20
            +49 234 68 94 188
         =20
       =20
     =20

     =20

       =20
          Mobile:=C2=A0
       =20
       =20
         =20
            +49 172 2847618
         =20
       =20
     =20

   =20

 =20






 =20

    Sitz der Gesellschaft: Bochum
 =20

 =20

    Handelsregister: Amtsgericht Bochum, HRB 17519
 =20

 =20

    Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar
 =20

 =20

   =20

    Datenschutzhinweise nach Art. 13 DSGVO
 =20


=20

