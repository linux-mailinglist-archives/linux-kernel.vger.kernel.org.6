Return-Path: <linux-kernel+bounces-340567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32798755D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378DB1C23395
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BF136347;
	Thu, 26 Sep 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0Cck2Zn"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F362AF1C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360522; cv=none; b=mz3BdkU1ZULzFNy9g+mINvEtzbvryKSfplJON7udgsfKOTGeGPsHi1TM38+RklxOEJ0pp1lvXp7hrj84H2cLOLaeouKwTc34vpVaQ0XWmRQplaD464t7/3G7tzPeGxxFrCJledx3nljWcS988WsC1mcomFzsJEczkW9bJ5Pcrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360522; c=relaxed/simple;
	bh=+y24IVUxor/kyNBm91ljRSRvsQRxdlhSxfQWOvqLT1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khl5iYuehsL+vv8VfzJJSLX2zw1qphy2De0wEAOSW+A6Nsul7346eJLQ4mzlpUfL+HyOf/GLULs9jnQPKODArlfgMDHFuqaCzUsh+7bCNtiNCmEiO/r2w3V3Et/TEKWVVOfkmHG3vRZnn7kMrTGcb2dnycLLbcwDgAqzQeFojsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0Cck2Zn; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce603d8daso37759139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727360520; x=1727965320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfFiyiH6kgWbgMXEmTeBEyoYGBSUVUt9KtKUrpIaXN4=;
        b=A0Cck2ZnZPgLFGJEkwcQlZYujALVQfeZ2J+lRM4seQ8SIZWDONkLY0VNKnmEEgvCgO
         2YRf4vffb4XL43m0AD+sxCHh74WVZHMdf+ByT4rJR0rxRLCK91XB8U5ZL6u8m9euWGqr
         LT50XV4ttmedigC7WYkEPwCL/zD06/r4Rn2ZhmvTHdITJODpggqSie6u1LqsGSHO0Azr
         EoR0lLk5NAmH6nWl7Az77o7Vu8VGVduLfMaOQV10bImTce4SlI6+T+I01lhb3gpaEcGv
         C7dkLrlnXmSnlWhppN0rwJKGGZyCMQevRiGmZMKr1TFs3+MzX/Nh97DtkAd4VFoSsaBx
         cOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360520; x=1727965320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfFiyiH6kgWbgMXEmTeBEyoYGBSUVUt9KtKUrpIaXN4=;
        b=auw0iE5b2eUBHa88uzg3cvo6TKQ5pZfdoHda/v3FdWkPT6AsCkkXh5m9gXXTtqDhta
         6rDcyEUO4SsyWmwOFEgE6vLxUQdd73Neq5c/AuG1GrFSEUri991nSj6Orip8KCRBRXu5
         wFScDrGDvuRk1quXFmytYpYgIGD+JIIqL+Ef7D5C3fgG8FP+6y+PqbJq9r19f5bZ+Mxe
         giPDHussjE1961bLhv1U1Ax0hmcCr8OkX7CIxgIKplB1zUgtmMaIsPaVQglMQpCr/ASO
         4YGAnEhHPWiLxfwSYOl7aGFbapZr/o0nfY8ljYsPRegafeRu8G771p1Au1GffYc23UEM
         Nr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1FEnCHRjcTG9qIK8Ndsp2dbwTA763MZ/4zOBX4QRQpQTMhpIse99KoaxDX6Xk7O1Vcbf1Ltby/MpFxiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYycEefiZTQ1Dvlpf1qs6l7xQp6VOocKIr1dgDIPja/yRl1M6
	zS6uTgqwd5ncB0LGOAQkFQIrxJxH0y16IEZzS9zcQkpOxNNSGjMsxSG5ZtdE4uRmHEFP1kwlI7c
	ji88+DedeEu8Y4QjBwdcan2XO6lQgUsybf9BP
X-Google-Smtp-Source: AGHT+IEhYTwkcQOydX6/mPTb/HEwIxwSttcZQgsPb/3Rz68DWYmoZ9QWBU7Za8W38ZpoYqE1eYTtCFXbKkq0PRx3s64=
X-Received: by 2002:a05:6602:2dd2:b0:81f:8f5d:6e19 with SMTP id
 ca18e2360f4ac-83247ced469mr543953839f.2.1727360519577; Thu, 26 Sep 2024
 07:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075646.15592-1-lena.wang@mediatek.com>
 <CANn89iKt-0LCJaJS8udObGOKz530seK67ieUgvmxr5woos+hyQ@mail.gmail.com> <28c0330f1d1827fb61eee26a697cc7cf4735fb15.camel@mediatek.com>
In-Reply-To: <28c0330f1d1827fb61eee26a697cc7cf4735fb15.camel@mediatek.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 16:21:43 +0200
Message-ID: <CANn89i+ZGWunObbYkemKE-ZYS3dGqWF0y8MQ8kEn1=fEwbztxw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:05=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> On Thu, 2024-09-26 at 11:07 +0200, Eric Dumazet wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Sep 26, 2024 at 9:55=E2=80=AFAM Lena Wang <lena.wang@mediatek.=
com>
> > wrote:
> > >
> > > A kernel NULL pointer dereference reported.
> > > Backtrace:
> > > vmlinux tcp_can_coalesce_send_queue_head(sk=3D0xFFFFFF80316D9400,
> > len=3D755)
> > > + 28 </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2315>
> > > vmlinux  tcp_mtu_probe(sk=3D0xFFFFFF80316D9400) + 3196
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2452>
> > > vmlinux  tcp_write_xmit(sk=3D0xFFFFFF80316D9400, mss_now=3D128,
> > > nonagle=3D-2145862684, push_one=3D0, gfp=3D2080) + 3296
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:2689>
> > > vmlinux  tcp_tsq_write() + 172
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:1033>
> > > vmlinux  tcp_tsq_handler() + 104
> > > </alps/OfficialRelease/Of/alps/kernel-
> > 6.6/net/ipv4/tcp_output.c:1042>
> > > vmlinux  tcp_tasklet_func() + 208
> > >
> > > When there is no pending skb in sk->sk_write_queue, tcp_send_head
> > > returns NULL. Directly dereference of skb->len will result crash.
> > > So it is necessary to evaluate the skb to be true here.
> > >
> > > Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
> > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > ---
> >
> > I am not sure why tcp_send_head() can return NULL.
> >
> > Before tcp_can_coalesce_send_queue_head() is called, we have this
> > code :
> >
> > size_needed =3D probe_size + (tp->reordering + 1) * tp->mss_cache;
> >
> > /* Have enough data in the send queue to probe? */
> > if (tp->write_seq - tp->snd_nxt < size_needed)
> >     return -1;
> >
> >
> >
> > Do you have a repro ?
> Hi Eric,
> It just happens once in monkey test. I can't reproduce it.
>
> from the dump log, it can see these values:
> (gdb) p tp->reordering
> $16 =3D 4
> (gdb) p tp->mss_cache
> $17 =3D 128
> probe_size =3D 755
> size_needed =3D 755 + (4+1)*128 =3D 1395
>
> (gdb) p tp->write_seq
> $18 =3D 1571343838
> (gdb) p tp->snd_nxt
> $19 =3D 1571336917
> tp->write_seq - tp->snd_nxt =3D 1571343838 - 1571336917 =3D 6921 > 1395

OK thanks.

Next question is : with 6921 bytes in the write queue, how
tcp_send_head could possibly be NULL ?

This would hint at a more serious bug breaking a fundamental invariant.

