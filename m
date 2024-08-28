Return-Path: <linux-kernel+bounces-305209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D3962B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B33BB24028
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671731A08C0;
	Wed, 28 Aug 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="LtBSI2bw"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A8188CD3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857453; cv=none; b=rcBCc9n2w2h2l9p7cg1qMPqhHVclunZe0Ci4yzX1Mr4LRTfNd1+k6u89fa5WkxVbK9kTKvFCbzTnhYdBzDsKwe+887SA/f5hixFjcoU2o3u0lyMb2RYw9lNeIZeHLSJl/kQHD2Edf06ENU4BXAhSn+3lP11nFWnAdBD0qmFvqYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857453; c=relaxed/simple;
	bh=w0E6baZJpxJ6q2kjc375/bSiS/hhrHgHCpIFHjLDhnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKcKWPWQ2R3bODQE5RCzETyNQVQbGp4YB1a/fbsPhoL1nVHzuDQwzakP2Z4e+Wlj15XLDKTu81v/no5oTmClKUreQhf2shLkufpNRFJCrBY3N6WhBLoLtwm9ljaX1HZMG/9gdRp7JMAwLNT3pR/CQ5mKBkyIAI3Q/vIGYvDUuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=LtBSI2bw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44ff6dd158cso37927321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724857451; x=1725462251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL9jfNB54ajh+s9h1yYJWjY7PMUSoEUGMuhE0M075gw=;
        b=LtBSI2bwPoqjzscU0tcOzFdLqzoyaFUUONujHXJy/eEFWt3RqPhE41Klrfb94SzGtr
         kfSCW5skPIwdOw5tWG52E/HW+2V4H2TpbKdB1teLjKMalW5EHg7Y7ciVH4Oozc8SQzq9
         jpDma+ym0xvriC/4M6NfuqVTf1Jv+ynCydGnyeSdyylgn01lZXTIcTRwBifVZVubH+Zn
         RHhIhYhyYmyoes86pU88uc0aeLYmp7TrSbYqFwBAhf5DZ3C4h44NvMq1GsvZxTFmyLg9
         yatESdYMncx4qAQE+YRqoXloeiUBKFBoA20hbLmGYH9EtEWpCWs6mGNUeu0RmVwWsgYk
         x/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857451; x=1725462251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL9jfNB54ajh+s9h1yYJWjY7PMUSoEUGMuhE0M075gw=;
        b=iKQrIWPCdfMaXzua1/xalmMtoRsFTeiVXuzsteVjcEN7zRSC2f27dFxqYhEWTBnw73
         tlex3q41oQML3CceNSfS5KyDOshf7dsEx1lIXwdwTeC2dwIoW5krS3xxkzlIOLHpQ/bW
         wjDYPjf2p8u3eTCFDr1Yxt+03teISJV8zDvFZgOEXMnbHo3+eGo5+aZsPPvlADIZ/4aA
         np7tfkS4poAJJTuUjiuhnhOzrswLdzM5JylC7gOSr8w3gMxaVjhK9P1YWzszczHJ98rL
         z8NkIfpxX30QITY9b88Whp9GvoHIvQPp6kRv84quLlDYprNVfFeR8T4QJNbEpDiOORmt
         yzwg==
X-Forwarded-Encrypted: i=1; AJvYcCWWXUGpPDrHLYhLTSARDRZOLrn2lpAHWynmxyn+7ohNL9UX89F4HCq4mbABdxJHvoELBX7jolqNTbbefbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MVrw5atroIZM8Xf7rqePbO9D81r5+qarMjIpJGX9gtmBM38E
	g7IGtBqIqU/LbZUMNDNYMiD1ICwmPH2SlPhfjuGOXhuOOyzTfqMSSHBuD95dciHkD4WKJKELohn
	NLOzXSbTP3DXYl5omEuSIrxhjqwssrtca3nqNpg==
X-Google-Smtp-Source: AGHT+IEtIJUhlSkKB2RvXZp1kGxF1wVOBlcQMg4Z+wCtFQMPliqeYYfdX1kBGSeN8VFK1FKhAt0a3GBQnVLtGI3mltw=
X-Received: by 2002:ac8:5a87:0:b0:455:14f1:a64d with SMTP id
 d75a77b69052e-4551500eb84mr176438801cf.24.1724857450707; Wed, 28 Aug 2024
 08:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <Zs3EB+p+Qq1nYObX@gmail.com>
In-Reply-To: <Zs3EB+p+Qq1nYObX@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 11:04:00 -0400
Message-ID: <CAO6EAnU91bgDnWuih1BchpvcDhScDTviQKjf=sKamVwhvFmZcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,
thanks for looking at it again :)


On Tue, Aug 27, 2024 at 8:18=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Sat, Aug 24, 2024 at 02:50:24PM -0700, Maksym Kutsevol wrote:
> > Enhance observability of netconsole. UDP sends can fail. Start tracking=
 at
> > least two failure possibilities: ENOMEM and NET_XMIT_DROP for every tar=
get.
> > Stats are exposed via an additional attribute in CONFIGFS.
> >
> > The exposed statistics allows easier debugging of cases when netconsole
> > messages were not seen by receivers, eliminating the guesswork if the
> > sender thinks that messages in question were sent out.
> >
> > Stats are not reset on enable/disable/change remote ip/etc, they
> > belong to the netcons target itself.
> >
> > Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
>
> Would you mind adding a "Reported-by" me in this case?
>
> https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/

Absolutely!

> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 9c09293b5258..45c07ec7842d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -82,6 +82,13 @@ static DEFINE_SPINLOCK(target_list_lock);
> >   */
> >  static struct console netconsole_ext;
> >
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +struct netconsole_target_stats  {
> > +     size_t xmit_drop_count;
> > +     size_t enomem_count;
>
> I am looking at other drivers, and they use a specific type for these
> counters, u64_stats_sync.
> if it is possible to use this format, then you can leverage the
> `__u64_stats_update` helpers, and not worry about locking/overflow!?
>
Do you think that these counters really need more than an int?
Switching them to unsigned int instead might be better?
I'd argue that at the point when an external system collection
interval is not short enough
to see the unsigned counter going to a lesser value (counters are
unsigned, they go to 0 at UINT_MAX+1).
I need advice/pointer on locking - I'm looking at it and it looks to
me as if there's no locking needed when
updating a member of nt there. Tell me if I'm wrong.

> > @@ -1015,6 +1035,25 @@ static struct notifier_block netconsole_netdev_n=
otifier =3D {
> >       .notifier_call  =3D netconsole_netdev_event,
> >  };
> >
> > +/**
> > + * count_udp_send_stats - Classify netpoll_send_udp result and count e=
rrors.
> > + * @nt: target that was sent to
> > + * @result: result of netpoll_send_udp
> > + *
> > + * Takes the result of netpoll_send_udp and classifies the type of err=
or that
> > + * occurred. Increments statistics in nt->stats accordingly.
> > + */
> > +static void count_udp_send_stats(struct netconsole_target *nt, int res=
ult)
> > +{
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +     if (result =3D=3D NET_XMIT_DROP) {
> > +             nt->stats.xmit_drop_count++;
>
> If you change the type, you can use the `u64_stats_inc` helper here.
ok

> > @@ -1126,7 +1167,11 @@ static void send_ext_msg_udp(struct netconsole_t=
arget *nt, const char *msg,
> >                       this_offset +=3D this_chunk;
> >               }
> >
> > -             netpoll_send_udp(&nt->np, buf, this_header + this_offset)=
;
> > +             count_udp_send_stats(nt,
> > +                                  netpoll_send_udp(&nt->np,
> > +                                                   buf,
> > +                                                   this_header + this_=
offset)
> > +             );
>
> as Jakub said, this is not a format that is common in the Linux kenrel.
ok

