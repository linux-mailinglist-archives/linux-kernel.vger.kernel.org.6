Return-Path: <linux-kernel+bounces-438512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE209EA216
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5CE1888213
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B91A070E;
	Mon,  9 Dec 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HQvkls/g"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6516199FBF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784277; cv=none; b=nNOWPoTxjIhTo+Ou3aevxu86yeA0MFeJowWVVzaFT5Fz00j++7irjAUiRREpvX+bbDOxfCdA8Ubrf3qVThX+1I777a7DZCDiQXgUwA0HwRQ2V4dhAMJ3nE92A16K7cTmSxWlChd3QFMt3cXwbPYtIR6ge097v2iNdqV+JhP/NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784277; c=relaxed/simple;
	bh=HRGqOPCaLbq228ZUiSJ6vJsTPafBSjXQGcZDtnJGJAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfOaQwFd/YzVcCvWKIUymPe21bXP/XKMzYXF0Xo/FkXHX7365lVE6FWMkTfKJx8Pr7M7gDb0jWvczNvU17ixabVX9E8XFG+n/IhJT/O33+4G9T5bk10bBoQnQ3VD4nAmaJP6map14eP4Ht3U6FLmRh3NN3KuaEszxGeffpvNahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HQvkls/g; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ee27e905so1654625b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733784275; x=1734389075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7WLaPjP/6/VqZCsN8r4DgRpNo9GopH9P2vAEBfUq7M=;
        b=HQvkls/gTivPZCrYA+BozcmOYa7eeZjet3w4emvLXOOd1oCW5g3ACKMV/+J+YcfJ8W
         UG4eivKxHo6n6gzf7E1rCQu1R7a/v0D/1n911XNUDObj+c8iLsU5xCCzR8Y/MRDmC2+n
         GZ86N8HV8b9uaOIvGJH0+wCV8P+O3fTwmzETTlQz97mmPyCm7cERfrppCzH2rYEYchxM
         qv5gGP7DHHQih4F2085RiQAYcIvBgIhS5W9lMZhgZ6pTkizsTD8C+lLYHfhEvBQq8Idn
         WDFykLnKlufX9vjnbQU2IgUuRjkaUsoXkuFN3Wz9D0rNSDzRiI5isEYs7C0Dht25oAuu
         bEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784275; x=1734389075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7WLaPjP/6/VqZCsN8r4DgRpNo9GopH9P2vAEBfUq7M=;
        b=lzYw9fQ+4n6rjfHkvLJcWZ5q6LEUD4v39tpA8MXZ5HtjWVZ1XiUUG6hSZcu3/uPgiB
         pppOnUq2jKW91adL7PaqMszz+ANPRiyO545xDwJ4o99InCtccYmudSscRQDuflve1rPT
         gqKswNVfQa04YS/usD3OrhXY037Yy8j2IvPubETjCB4T27rfEjYVsVb0TW+2+tSNTxG4
         ELjs1LdKr7l3Qaw3m4we/WbeP6N+Tek+Ji2bsxq21bFTupDz4qP/qaXmz+6szmekRCjX
         HkWAhN9H7wTU6VlSezG9A7wJLgl3UX342yktDeWhK5B05MiG11bkek/UwgFhkJTjhn1A
         KpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXt7wTyZxgsZYHRaJ8AH40f8y9MbkL+nix9Aa4u+nyyOD/G7k8SMBo+l+ZQxwP7XM6tay0y+J0+QQyWys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWGo99AuRSzrGOHVk0eyotzcgjWcIr2yxPshnJZcnu7+hEm02
	iyNUVzDxFlBy8Q6i+89By8I8nLyqXtKHG4aHnMka7Y5jViEYSm/bGDRBtFp6kFuoBUDRup02ib+
	S8JKs/QwFjoLWOHZJyh52zAdrizGsl9IbDaCd
X-Gm-Gg: ASbGnctSs3mYHnIsnwcQssUwMOGnSd+fBqo3GznQrsWKnw+dfbRJ8fPzpbTwRVqIi+n
	7BZiGPUAgeLRxmoI8SWce3tcxpjC089WSfw==
X-Google-Smtp-Source: AGHT+IEgP6rIYwWx2fF62aAs7gDYhI5tl3KxoKfvMp4XkKMmhIH53d2SgbjXP/UiXP5p4RDmYWlBqsXP6z0KWFb1W48=
X-Received: by 2002:a05:6a00:a17:b0:725:e015:909d with SMTP id
 d2e1a72fcca58-725e01593b7mr11196856b3a.21.1733784275161; Mon, 09 Dec 2024
 14:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202191312.3d3c8097@kernel.org> <20241204122929.3492005-1-martin.ottens@fau.de>
 <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com>
 <b4f59f1c-b368-49ae-a0c4-cf6bf071c693@fau.de> <CAM0EoM=sHOh+aXg9abq6_7QLCaqH28Ve1rjSjnHNkZTsE7CuMQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=sHOh+aXg9abq6_7QLCaqH28Ve1rjSjnHNkZTsE7CuMQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Dec 2024 17:44:24 -0500
Message-ID: <CAM0EoMm1Qv3_0ak2vtRjSmuW4+zZ7izzBVjDMawfnKm3dLcjyA@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: netem: account for backlog updates from
 child qdisc
To: Martin Ottens <martin.ottens@fau.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:13=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sat, Dec 7, 2024 at 11:37=E2=80=AFAM Martin Ottens <martin.ottens@fau.=
de> wrote:
> >
> > On 05.12.24 13:40, Jamal Hadi Salim wrote:
> > > Would be nice to see the before and after (your change) output of the
> > > stats to illustrate
> >
> > Setup is as described in my patch. I used a larger limit of
> > 1000 for netem so that the overshoot of the qlen becomes more
> > visible. Kernel is from the current net-next tree (the patch to
> > sch_tbf referenced in my patch is already applied (1596a135e318)).
> >
>
> Ok, wasnt aware of this one..
>
> >
> > TCP before the fix (qlen is 1150p, exceeding the maximum of 1000p,
> > netem qdisc becomes "locked" and stops accepting packets):
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 2760196 bytes 1843 pkt (dropped 389, overlimits 0 requeues 0)
> >  backlog 4294560030b 1150p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 2760196 bytes 1843 pkt (dropped 327, overlimits 7356 requeues 0)
> >  backlog 0b 0p requeues 0
> >
> > UDP (iperf3 sends 50Mbit/s) before the fix, no issues here:
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 0 requeues 0)
> >  backlog 643680b 432p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 341057 requeue=
s 0)
> >  backlog 311410b 209p requeues 0
> >
> > TCP after the fix (UDP is not affected by the fix):
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 94859934 bytes 62676 pkt (dropped 15, overlimits 0 requeues 0)
> >  backlog 573806b 130p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 94859934 bytes 62676 pkt (dropped 324, overlimits 248442 requeues=
 0)
> >  backlog 4542b 3p requeues 0
> >
>
> backlog being > 0 is a problem, unless your results are captured mid
> test (instead of end of test)
> I will validate on net-next and with your patch.
>

Ok, so seems sane to me - but can you please put output on the commit
reflecting after the test is completed?
Something like, before patch (highlighting stuck backlog on netem):

qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 17105543349430145291
 Sent 35220 bytes 43 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 4294958212b 0p requeues 0
qdisc tbf 8003: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 35220 bytes 43 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 0b 0p requeues 0

And after your patch:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 11503045766577034723
 Sent 42864 bytes 49 pkt (dropped 5, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8001: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 42864 bytes 49 pkt (dropped 16, overlimits 5 requeues 0)
 backlog 0b 0p requeues 0

backlog is now shown as cleared.

Coincidentally, removing your tbf patch (which is already in net-next)
and rerunning the test it didnt seem to matter whether GSO was on or
off (as you can see below backlog is stuck on tbf):


GSO off:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 12925321237200695918
 Sent 26284 bytes 39 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8001: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 26284 bytes 39 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 4294959726b 0p requeues 0

GSO on:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 18236003995023052493
 Sent 35224 bytes 43 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8002: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 35224 bytes 43 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 4294958212b 0p requeues 0

Please resubmit the patch - add my acked-by and put the proper
before/after stats.
Fixes is likely: Linux-2.6.12-rc2

cheers,
jamal

