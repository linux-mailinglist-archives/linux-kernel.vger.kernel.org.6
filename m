Return-Path: <linux-kernel+bounces-532261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B093AA44AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76953423373
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB41A23BD;
	Tue, 25 Feb 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkQI+hrC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED5189F57
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509015; cv=none; b=O8SP/VQNQ8AHinn4CFGTKZgmrIdmduBBrf7twUK+9LylnbqiE1fj3LcUu18hE/sjKT5UrptApqFVGnq63OhswnQ0whG+3XWnSkrwd+kIPhzO9jZW9nTfUpS2/YfL6H0YW/nErWU9sD4TU7UlIxZuBs4tZv/J8i7/3ULFrFuZ6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509015; c=relaxed/simple;
	bh=XH1QK4MYvrur0joPrdgPfpG/wjFKuwKCdVJlP2R312Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGWjTOYbhCo/XTIG2Noin27JJ3oLlzn5SWMg31IhJR4As89g3SRvPkQpKmQbpq+wzeN+VPBZUvqtFo7G5Ob1j4GyXwLH7RfA78bTP8aAZktVLILHi5Ubk1oVAaqQkAj4SQyHCwPT9TaDdYT+WbAUyEs/rjRqKXZwyUQTZtTxyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkQI+hrC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so8094955a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740509012; x=1741113812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki9Q1pgmyFVlVp8WK8N4AQ54y+GaZoiKHJoXK7u/Fv0=;
        b=fkQI+hrCeh2Ri45dUY/7sjt0UNYcM/MKiNXlct+juxBw2nJw09Flzzext8V5kVM8CX
         YyIzY2cQWvdDYiGZEeyAikXqkkDLw08Y4pO5SZJI3mucxkVbyjbfbOZ2EMuOwdvjGoHy
         87GdDa9ReEaUlMVCL/YFlHq6VJ98/cT3lMubIcWtsYBZk11txRkRAXZQNoLBPHKZfleE
         P5OS4QCsEUm49/xFgX12oLvHt2by8WRaY0L4JSxggMNm6tnaCkGNW4Lyi/ayRdcyszSI
         rzZdZ3dpytjjfkyOkIAy1++Pynwg/l5TLAa1HuOkymXVgrpIpqOMmJr9Y9MW8U+kv3Ww
         m34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509012; x=1741113812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki9Q1pgmyFVlVp8WK8N4AQ54y+GaZoiKHJoXK7u/Fv0=;
        b=tlmeU6pOypuEVXKXWxa6LJGQHthvEB+jBn1UItOFAp2YjsUSfyVde+47sdS50xHImn
         gSQzANYn4KLy4LageJ1eOK9tuu0s7bd4X6oa3zasWGeeD9Ui02yuWbxeysaeK6BUlVdO
         XfjUoKAbC3mSOFZrrQAXeWrFtrqRUEHrCYHdfBgqkYffJoVF7gT2ZmLkynMSnrIjelLj
         SB5+ua3tLCdWrfkZ1h3Sv2eZ7elqG0yAO31gJUnfLN0cJr65rU/eDhv/dQ3r3/ny54iM
         ntHzigqwZULCub+TdiGvXyujWAaK3L2rcTVt/ROm6+8zOB4fy4rfvzoEiHE08RwHrR4G
         5zuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVac90Nm+xkZcb/LUV4dRmsR/NXb12huJEFQK7C9+kF5R4yINJKMDumyTqqu2CYAiu7TBA8b5ACFsraYdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXyPjBW9UYpPpGfvFzczTjrivEKpLo9iEpiHXe6w4gKSiLccQ
	t3k2VBGI7+7zRt5lxTd5XwUU6qY6JflOGe4jgNDztR8/k0WysiKUEU5yTPmq3c1JemfE/nW2fLz
	Z0SwU2lP4vKae/Vuadee8NsTjgoqJKV08KCJA
X-Gm-Gg: ASbGnctJFidYoDQULldqClYv2Ge4L3taDEmaFkv7eshTfzyvcrNX7Y/BL9BD2nMvAJX
	QeKPGWOT/SZPitc5Afk70V/Q4uf0jt3aI4LgErUxy9tLv/Spn4hzqLXL8WX/+0JDtiQiBef1JSn
	hVNGtxDAA4
X-Google-Smtp-Source: AGHT+IHGOU+SqBBcSXjD0oD24/wOuQKG1MAXf9EfRlIYyYnWmiQzmYfikU2MFxlqD60+SY/C8Vb5KIAN/mgnycMRBbg=
X-Received: by 2002:a05:6402:40c4:b0:5e1:a37c:7ebe with SMTP id
 4fb4d7f45d1cf-5e4a0bf22cemr742131a12.0.1740509012100; Tue, 25 Feb 2025
 10:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <009e01db4620$f08f42e0$d1adc8a0$@samsung.com> <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
 <Z4nl0h1IZ5R/KDEc@perf> <CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
 <CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
 <Z42WaFf9+oNkoBKJ@perf> <Z6BSXCRw/9Ne1eO1@perf> <CADVnQykpHsN1rPJobKVfFGwtAJ9qwPrwG21HiunHqfykxyPD1g@mail.gmail.com>
 <CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com> <CAK6E8=cB5LW8EtP5Hs6Xb8HP7Hr7TzHSHx--c7yj50RhUraUEQ@mail.gmail.com>
In-Reply-To: <CAK6E8=cB5LW8EtP5Hs6Xb8HP7Hr7TzHSHx--c7yj50RhUraUEQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 19:43:19 +0100
X-Gm-Features: AQ5f1Jqkih8z157S2DscxY0jLd3ZjLkK2PdY1feRijhp1GGNYP-Uy9oW-uoVlnQ
Message-ID: <CANn89iK6q2r99UOMbrhpCWHZF+FshSs1dpVKttsOnHidVVvTkQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Youngmin Nam <youngmin.nam@samsung.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com, 
	yiwang.cai@samsung.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com, 
	sw.ju@samsung.com, "Dujeong.lee" <dujeong.lee@samsung.com>, Kevin Yang <yyd@google.com>, 
	Xueming Feng <kuro@kuroa.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:28=E2=80=AFPM Yuchung Cheng <ycheng@google.com> w=
rote:
>
> On Tue, Feb 25, 2025 at 9:25=E2=80=AFAM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Mon, Feb 24, 2025 at 4:13=E2=80=AFPM Neal Cardwell <ncardwell@google=
.com> wrote:
> > >
> > > On Mon, Feb 3, 2025 at 12:17=E2=80=AFAM Youngmin Nam <youngmin.nam@sa=
msung.com> wrote:
> > > >
> > > > > Hi Neal,
> > > > > Thank you for looking into this issue.
> > > > > When we first encountered this issue, we also suspected that tcp_=
write_queue_purge() was being called.
> > > > > We can provide any information you would like to inspect.
> > >
> > > Thanks again for raising this issue, and providing all that data!
> > >
> > > I've come up with a reproducer for this issue, and an explanation for
> > > why this has only been seen on Android so far, and a theory about a
> > > related socket leak issue, and a proposed fix for the WARN and the
> > > socket leak.
> > >
> > > Here is the scenario:
> > >
> > > + user process A has a socket in TCP_ESTABLISHED
> > >
> > > + user process A calls close(fd)
> > >
> > > + socket calls __tcp_close() and tcp_close_state() decides to enter
> > > TCP_FIN_WAIT1 and send a FIN
> > >
> > > + FIN is lost and retransmitted, making the state:
> > > ---
> > >  tp->packets_out =3D 1
> > >  tp->sacked_out =3D 0
> > >  tp->lost_out =3D 1
> > >  tp->retrans_out =3D 1
> > > ---
> > >
> > > + someone invokes "ss" to --kill the socket using the functionality i=
n
> > > (1e64e298b8 "net: diag: Support destroying TCP sockets")
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dc1e64e298b8cad309091b95d8436a0255c84f54a
> > >
> > >  (note: this was added for Android, so would not be surprising to hav=
e
> > > this inet_diag --kill run on Android)
> > >
> > > + the ss --kill causes a call to tcp_abort()
> > >
> > > + tcp_abort() calls tcp_write_queue_purge()
> > >
> > > + tcp_write_queue_purge() sets packets_out=3D0 but leaves lost_out=3D=
1,
> > > retrans_out=3D1
> > >
> > > + tcp_sock still exists in TCP_FIN_WAIT1 but now with an inconsistent=
 state
> > >
> > > + ACK arrives and causes a WARN_ON from tcp_verify_left_out():
> > >
> > > #define tcp_verify_left_out(tp) WARN_ON(tcp_left_out(tp) > tp->packet=
s_out)
> > >
> > > because the state has:
> > >
> > >  ---
> > >  tcp_left_out(tp) =3D sacked_out + lost_out =3D 1
> > >   tp->packets_out =3D 0
> > > ---
> > >
> > > because the state is:
> > >
> > > ---
> > >  tp->packets_out =3D 0
> > >  tp->sacked_out =3D 0
> > >  tp->lost_out =3D 1
> > >  tp->retrans_out =3D 1
> > > ---
> > >
> > > I guess perhaps one fix would be to just have tcp_write_queue_purge()
> > > zero out those other fields:
> > >
> > > ---
> > >  tp->sacked_out =3D 0
> > >  tp->lost_out =3D 0
> > >  tp->retrans_out =3D 0
> > > ---
> > >
> > > However, there is a related and worse problem. Because this killed
> > > socket has tp->packets_out, the next time the RTO timer fires,
> Zeroing all inflights stats in tcp_write_queue_purge still makes sense
> to me. Why will the RTO timer still fire if packets_out is zeroed?

By definition, tcp_write_queue_purge() must only happen when the
socket reaches a final state.

No further transmit is possible, since this broke a  major TCP
principle (stream mode, no sendmsg() can be zapped)

tcp_write_timer_handler() immediately returns if the final state is reached=
.

if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ..
    return;

Also look at INET_CSK_CLEAR_TIMERS, if you want to know why the
retransmit timer can fire.

