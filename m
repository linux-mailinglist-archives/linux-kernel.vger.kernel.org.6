Return-Path: <linux-kernel+bounces-320627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E8970CF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A8FB215B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344851ACE00;
	Mon,  9 Sep 2024 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aIfRcZo4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25A9461
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725859525; cv=none; b=fm2OC8z1siVJ5Rsl05zIsMyu+oyHcwZkGSDMkBKEWh5j3HH+3+E5bnk1UojUT6LaNIGK2ARr9/R7CkaafZ5lTARduxBWwdNhpLfeQtFyrHRmNrHijfiSoL9P9o9tKtdCZKzsSuNgjFRAcbTAQ0kUvLhhtNilEid0m5m5AUfh+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725859525; c=relaxed/simple;
	bh=lt+OdRciJs/mbejZWkEBMLSMKdCLgvDG/+2V0adw8WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jlbm2HzM2pFqj6s2mv3U/gCYSJqxbLUViUpaz6b6DWTJzdCGESTnolGwU7WnuZzXVJQdIUgzlrPXaa9WrVBDsmuB0+jIl6g6+5JIzU4l4vgojfeoWwdzLngIndG2EsrJOnRPu1vVevVfJLOaXjfVbE/Jm/ho2UjRjCzgtm+vRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aIfRcZo4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 90F623F62B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725859520;
	bh=IAvfaTdfZpA+q/X0iFHezyi7oVQNx0sFqSrEiTlhudg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aIfRcZo4uXKz3De7hIEyT2ir098alN+S002BrdZ3kcyUJwCiU9hVLJBIHLrHys/tt
	 DqJZ9NsXE2Hzn73doWso6AMpE/bdYPx4/BCGUR3B0Sfv/uWwoOtQB0trRI9LuIkyI/
	 EQ/eNBYOMxWefqP92qgBqL3+ZEIqgtDFH+0Ho2GjRZ9AeFW/mq/1wP8avAzOrfMoFI
	 zLPRGCVUCEs08cGgMKMYOqqhjPERBOMQSgiO7erq/bMCw2oFRZUnvOqt4eMyIgnveY
	 tnjmgvfZsVAlbv9P3aNCJ+N8bNtCV1A8EcOMAW8pp+joi11VRRMnjve8m4mlv04RG7
	 G9F0S3aj4lnnA==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b69e65e8so2309842f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 22:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725859519; x=1726464319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAvfaTdfZpA+q/X0iFHezyi7oVQNx0sFqSrEiTlhudg=;
        b=SoH5cpyhBXneW7+nH1pIxGtAtUW3MFbVXijx3Lyalth/FYiSv5UAWTIBYTWhandbJl
         M3Ce0H6KMBtO6fSpdLXoHbgUKgA6acW9ocNA/XxJIOsHDH4SHdJe8Lw1PBmRiq2nKXA5
         f8ebed9U6zu6PpDXhhVIcQgAxxdWrZkZDm6/cASlCv1n4MU5+8cBAnHJFQ0Zx2wL0HSe
         1fx1WhRuxJbuem1+FJKP8NcWUE42dg39D1MYVoj27prVBdZnz/Efl09u5gM1nYSH5haz
         hT7XJWlfgEYrXN9vQ+LiLd8tXb/sTHyAD5PYssuNPuvhj7QGD1zVp1DEF+RmcmsNuiJg
         7mBA==
X-Forwarded-Encrypted: i=1; AJvYcCVJR+DdMogeEKabdTDoH+YH77NchtYATV0Vbzq0z2piJ6QjdP2xzSmYwf/Ece5cZzvoC2iiOMOKajpLbfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm43gULh+5yIdRl57353sgLYHI5dARRsCKWNKRpdoozvWuZVb1
	oaGW3V5ZTtqX0lg3qnwg07NqEd9AaFaSXikT5uXC5LyIAoCtezl269NwaxgIsE5EAkDLtZm5x3c
	URkBFER0oNF98+/bsdcjzWb4HFuoStRzmJj/iYoBuFfccIWGFoOaHXNraFav2ZsBHzTyS/H7B+l
	dch31+STQIZ3rK7FcxKMmRwfOa5nQtukB3+C2BEOBjU9eALbLMgpv9
X-Received: by 2002:a5d:6184:0:b0:374:b6f2:5f30 with SMTP id ffacd0b85a97d-3788960cf44mr7308360f8f.27.1725859519022;
        Sun, 08 Sep 2024 22:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIPPCybN2BiTI2xpSNXMCruJnTb4YO1MBV8kg20InRqKER78xtzV66i461GGVGHG/iBXDgZu9RDbVImAg8yOE=
X-Received: by 2002:a5d:6184:0:b0:374:b6f2:5f30 with SMTP id
 ffacd0b85a97d-3788960cf44mr7308345f8f.27.1725859518349; Sun, 08 Sep 2024
 22:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906083539.154019-1-en-wei.wu@canonical.com> <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
In-Reply-To: <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Mon, 9 Sep 2024 13:25:07 +0800
Message-ID: <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com, 
	kai.heng.feng@canonical.com, me@lagy.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

Thank you for the quick response.

On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 06.09.2024 10:35, En-Wei Wu wrote:
> > The commit 621735f59064 ("r8169: fix rare issue with broken rx after
> > link-down on RTL8125") set a reset work for RTL8125 in
> > r8169_phylink_handler() to avoid the MAC from locking up, this
> > makes the connection broken after unplugging then re-plugging the
> > Ethernet cable.
> >
> > This is because the commit mistakenly put the reset work in the
> > link-down path rather than the link-up path (The commit message says
> > it should be put in the link-up path).
> >
> That's not what the commit message is saying. It says vendor driver
> r8125 does it in the link-up path.
> I moved it intentionally to the link-down path, because traffic may
> be flowing already after link-up.
>
> > Moving the reset work from the link-down path to the link-up path fixes
> > the issue. Also, remove the unnecessary enum member.
> >
> The user who reported the issue at that time confirmed that the original
> change fixed the issue for him.
> Can you explain, from the NICs perspective, what exactly the difference
> is when doing the reset after link-up?
> Including an explanation how the original change suppresses the link-up
> interrupt. And why that's not the case when doing the reset after link-up=
.

The host-plug test under original change does have the link-up
interrupt and r8169_phylink_handler() called. There is not much clue
why calling reset in link-down path doesn't work but in link-up does.

After several new tests, I found that with the original change, the
link won't break if I unplug and then plug the cable within about 3
seconds. On the other hand, the connections always break if I re-plug
the cable after a few seconds.

With this new patch (reset in link-up path), both of the tests work
without any error.

>
> I simply want to be convinced enough that your change doesn't break
> behavior for other users.
>
> > Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-d=
own on RTL8125")
> > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 3507c2e28110..632e661fc74b 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
> >  enum rtl_flag {
> >       RTL_FLAG_TASK_ENABLED =3D 0,
> >       RTL_FLAG_TASK_RESET_PENDING,
> > -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> >       RTL_FLAG_TASK_TX_TIMEOUT,
> >       RTL_FLAG_MAX
> >  };
> > @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
> >  reset:
> >               rtl_reset_work(tp);
> >               netif_wake_queue(tp->dev);
> > -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, =
tp->wk.flags)) {
> > -             rtl_reset_work(tp);
> >       }
> >  out_unlock:
> >       rtnl_unlock();
> > @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_de=
vice *ndev)
> >       if (netif_carrier_ok(ndev)) {
> >               rtl_link_chg_patch(tp);
> >               pm_request_resume(d);
> > -             netif_wake_queue(tp->dev);
> > -     } else {
> > +
> >               /* In few cases rx is broken after link-down otherwise */
> >               if (rtl_is_8125(tp))
> > -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEU=
E_WAKE);
> > +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING=
);
> > +             else
> > +                     netif_wake_queue(tp->dev);
>
> This call to netif_wake_queue() isn't needed any longer, it was introduce=
d with
> the original change only.
>
> > +     } else {
> >               pm_runtime_idle(d);
> >       }
> >
>

CC. Martin Kj=C3=A6r J=C3=B8rgensen  <me@lagy.org>, could you kindly test i=
f
this new patch works on your environment? Thanks!

En-Wei,
Best regards.

