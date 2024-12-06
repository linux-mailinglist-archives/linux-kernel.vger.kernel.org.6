Return-Path: <linux-kernel+bounces-435211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13ED9E7478
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FB318880E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08BD20CCC3;
	Fri,  6 Dec 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGZB5uXl"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CF20B206
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499276; cv=none; b=PSWkHkf06GutMmEq65WSN6YfFNveqWzwieQ7pf4jQ8xl00KhKqaSXvUjM9KgBRwrJKppN62UhADSN9/EB5ZwwdK0oef/qkvgDSrfF39ylTtyHBwMp0xz2TAqPe9824Dg6lnRs2ZLgygnVeeBs4NnxkzzEE4Cs4tO51RAeNc1tIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499276; c=relaxed/simple;
	bh=/aZqmN3typIBo+zTsoP67GUsfN5kiwlf/t4IXibQPA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSsNhJq9sGtCgwnYHUD16IpvsOqQ0rVk0XV/g/Do7mohEp0cyKvg/C5eyyfE2EoUDaj8nkohUEqXEfsEC3IyXUuGImt64stwpY3I00QM0CrdOB0tg0HMJLmJaKKam6FLwLkkyMIc7sUlKGUz6bzhI1R5P+YE6paGe68lMxmCs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGZB5uXl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4668194603cso219481cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733499273; x=1734104073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aZqmN3typIBo+zTsoP67GUsfN5kiwlf/t4IXibQPA8=;
        b=vGZB5uXl9/n4dgRXOQRMHuiCn9JLOHmTphxADLJBKpQun/plPJrdPchnmMY1eNkWSE
         HpLDUnvpbe7wR+LwOx/AufuZ916cbgTb6exjH2d6vBhzNmJrgvP6EFqJ5ML4cxBg2TFp
         2A/VCz1higfVO5ixlyFCN2f6bx9fxNO77o37VOFCYFeIvMSrUc8hwRqv7Z9FwS4jV3Fi
         j7kXRMCwKYrTxemb9ysF7yX9Gv1flsUAsjtKG7QTCeSQGoABPUQfTFt7ZfIoBEXO5i7r
         gAjwOcvVNu0cNsfoDWRQZ/Lx9NpwpESKxJTDkVDPMzjSx+mQrTf7BUaq+bIwrcOkfSFR
         huzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499273; x=1734104073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aZqmN3typIBo+zTsoP67GUsfN5kiwlf/t4IXibQPA8=;
        b=GOVs56QTgUsLFUwRqrQ+xdl4aSnDjK1fI1d92pBkvCba6Z2U5Zug/lEgEbM+0Fw4W9
         YkFs9LBzPuBwKHr6v4kfqlQlGxH7YnD6DJS6Ttz3/tGwfjSImge8p/gzQ3MeZyrejz4d
         NyrLZK4E13GsxqKTpI46F8ZINf2/SZe3bIEAXU3D5pW73nHSyBfEHxO8UmsZ7f8ZPi2U
         wPP7kLgNnAAOO3NzmEDRBi/r9/Xlh0DN+4Dsh9cw+Wx8B378Wb8fEYC8jU8mOPZOKj5y
         ckkBmE29mX8WCg5QdW7mo3AMkP2vAqw8NBT/c4D9foDy26mYG7pojxk0WYlWTVo2r2KL
         f2EA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVBMs7RQoE4QSy+LRwsNAGAnDRwczQanGq1YpY/QZ+pYgjr6ngLdC1y3rogsxp5EVfN3tfdsL4ThY4sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TAOvUS2cVNcx/PGtEk9k2fzyMndL08infdj5mWEy7tZAJ4wR
	suv8Xei0vbR+WAYn7VQCWeDJ7rCWpoD/HOeIY44Si8dGtqJjTncr1SQHhBreiT8HV2xGucauG9W
	Q5FDhgywluOeRrU4P9H9l6EtxnocEzfWSzOQm6lOHsVPSV730dYKu
X-Gm-Gg: ASbGncuClrmy52vrCDB4hSdciFuR//nyiQxcod8VJ+//0+Q5UI7oMYHudQaXyav9Dlo
	X5c1q4D/zfFKbIkS/dWX8BVAlBJfjghovQQwTujX5mMGJbnNW6leOOzsJARipZJph
X-Google-Smtp-Source: AGHT+IHyH40yDBwr3/tp4UxKTv5DxHxaEclVdR22FyUDDq3qG3ECWu1DqFPK3/KLnTp+1XnrAUHEC3oXogQBaZU+p54=
X-Received: by 2002:a05:622a:1c10:b0:466:91fd:74c0 with SMTP id
 d75a77b69052e-4673535dd73mr4060791cf.0.1733499272923; Fri, 06 Dec 2024
 07:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <Z1KRaD78T3FMffuX@perf> <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
 <Z1K9WVykZbo6u7uG@perf> <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
In-Reply-To: <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 6 Dec 2024 10:34:16 -0500
Message-ID: <CADVnQykZhXO_k5vKpaQBi+9JnuFt1C5E=20mt=mb-bzXrzfXLw@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Eric Dumazet <edumazet@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joonki.min@samsung.com, 
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 6, 2024 at 9:58=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung=
.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 09:35:32AM +0100, Eric Dumazet wrote:
> > > On Fri, Dec 6, 2024 at 6:50=E2=80=AFAM Youngmin Nam <youngmin.nam@sam=
sung.com> wrote:
> > > >
> > > > On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > > > > On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM Youngmin Nam <youngmin.nam=
@samsung.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > > > > I have not seen these warnings firing. Neal, have you see=
n this in the past ?
> > > > > > > >
> > > > > > > > I can't recall seeing these warnings over the past 5 years =
or so, and
> > > > > > > > (from checking our monitoring) they don't seem to be firing=
 in our
> > > > > > > > fleet recently.
> > > > > > >
> > > > > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > > > > Could be that one of our workloads is pinned to 5.12.
> > > > > > > Youngmin, what's the newest kernel you can repro this on?
> > > > > > >
> > > > > > Hi Jakub.
> > > > > > Thank you for taking an interest in this issue.
> > > > > >
> > > > > > We've seen this issue since 5.15 kernel.
> > > > > > Now, we can see this on 6.6 kernel which is the newest kernel w=
e are running.
> > > > >
> > > > > The fact that we are processing ACK packets after the write queue=
 has
> > > > > been purged would be a serious bug.
> > > > >
> > > > > Thus the WARN() makes sense to us.
> > > > >
> > > > > It would be easy to build a packetdrill test. Please do so, then =
we
> > > > > can fix the root cause.
> > > > >
> > > > > Thank you !
> > > > >
> > > >
> > > > Hi Eric.
> > > >
> > > > Unfortunately, we are not familiar with the Packetdrill test.
> > > > Refering to the official website on Github, I tried to install it o=
n my device.
> > > >
> > > > Here is what I did on my local machine.
> > > >
> > > > $ mkdir packetdrill
> > > > $ cd packetdrill
> > > > $ git clone https://protect2.fireeye.com/v1/url?k=3D746d28f3-15e63d=
d6-746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=3D1&e=3Dca164227-d8ec-4d3c-bd27=
-af2d38964105&u=3Dhttps%3A%2F%2Fgithub.com%2Fgoogle%2Fpacketdrill.git .
> > > > $ cd gtests/net/packetdrill/
> > > > $./configure
> > > > $ make CC=3D/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x8=
6_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
> > > >
> > > > $ adb root
> > > > $ adb push packetdrill /data/
> > > > $ adb shell
> > > >
> > > > And here is what I did on my device
> > > >
> > > > erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S =
-v -L -l tcp/
> > > > /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
> > > >
> > > > I'm not sure if this procedure is correct.
> > > > Could you help us run the Packetdrill on an Android device ?

BTW, Youngmin, do you have a packet trace (e.g., tcpdump .pcap file)
of the workload that causes this warning?

If not, in order to construct a packetdrill test to reproduce this
issue, you may need to:

(1) add code to the warning to print the local and remote IP address
and port number when the warning fires (see DBGUNDO() for an example)

(2) take a tcpdump .pcap trace of the workload

Then you can use the {local_ip:local_port, remote_ip:remote_port} info
from (1) to find the packet trace in (2) that can be used to construct
a packetdrill test to reproduce this issue.

thanks,
neal

