Return-Path: <linux-kernel+bounces-335505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414C97E6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362C21C20DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97057482D8;
	Mon, 23 Sep 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlQx42b6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1FE364BC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076978; cv=none; b=j/u/MJhkV3z2m6Rd7Ho0L2L3Og9RY7HRijn/vTnUEdSSk4nJSdBMY9v+VGCARsKS+9Ghxvd+F35EKSb37z9ae/QXL/QZWRi5kA8xajYZ5HOp7p9lFEMUOlN5GPH1JAfiLwhLX9gXzGzFOZzdVidW2FVFOVSy5Cpk6+h183j2FHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076978; c=relaxed/simple;
	bh=kQg/bIxkfShKQ2LpuH9c+oGZ7+UA+asKQty0tzUxO5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqZ8eXgBkCo5ikgv02Y+DnDrU8zoqXjjIJehHkLen9FyVLVJd7+CmdgPK/VtLuDuHCWv21o+3kNcfX2WGEAmbW7ADlm9ZphP40epGsPBIIgYVwc8oTkvdCwOhcbZYVOYu///l+FfAPvIYhpq+FMEzQXg3Dy09xqKtAvNLTzUuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlQx42b6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso5316916a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727076974; x=1727681774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUafDmzTE59pshRj6K2wvxptZ8QfeEvDyUTeHQcSvZE=;
        b=qlQx42b6qwzKmGD8UDpqdu9l3I5F1qN+TsEP3SSiUCmtIziCEqMLYUH1wZeEoGuvHP
         eOA3cBILhhV5A/FolZXlx7djSxhbELAjvrc0re+oWJx6HrQLAGn6og00Gt8iutK4JBYq
         WiwozU6GbEhNrw0Z0dM3FQ0WpqooCv3mjHYxX0Wg4gm8J8QOIGpERwkVWV/r9fFCc3vA
         TY0e5Qrrq8LQfl53XHlLie8tP1Wu9vTO+dud2ZS1ar8pDEclkttCKa5QlgeKObxclzGu
         YJlz4TsKcoPEldO5/mr3maPNIL+MqpW2ix3nstKZhLYF2zSA0onKiwOiFSDbZTlwzDB3
         di3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727076974; x=1727681774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUafDmzTE59pshRj6K2wvxptZ8QfeEvDyUTeHQcSvZE=;
        b=PcSgH/Gae1nEfWvy04ckXvWLTy/rqmiUHBFLSlDvzW+qKTRhIB3G7vv/ng1SH7BHSc
         aVNFOSe1EXyKLva8/+HHQVdJlnHF4vJdkP94QHBagAdK9Cfdhd91hsktShkXRLqaL0T4
         RqYPDsNRWiTjkZ6aekDeEC5kWG3Xa4jeR/G8LL3OtMBO/PmZU/hBVZYcFDfGogVjyHrI
         jjsgIbNxyZjcnQUrL3gScvXpGs5XipSLMlCPpo2PbI8LciOkvkdK1l3SFXU+HEM3uj03
         9xASNBdal7G3U2u8lb2p+WrBf/gXUCV4zjsz/0oZVpkycLWlUmZ4K+qwuMYOh2JlGt0M
         /jVw==
X-Forwarded-Encrypted: i=1; AJvYcCVD2DmK4Ibi4tSxMXVwvuo2Oz0vHS9tYUkDDUZFd+TmxavhE1ftaB0Z0rAdIU3HQrMIQ1BSiZTyX9thv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoX20CCEOxxK/WVIcHv4/2r3u/37d8FxFDsta37cjbLtb33Ijg
	nP2pBwSF98zpiwvDUOAnINjASByQCV9NJKjoUNf1VVOvq5yAh3hVsskijtdDrBTmJDhuhGfQsl+
	01ekx2S7W7cHlCcdjkzEP2SdOg7zqZSBF5Z3CLQKpeDH+Pz34gKBc
X-Google-Smtp-Source: AGHT+IG1qWhmqvdo54rXWyaLb0rt1Uj8mGUFvgvYK7yEBLPcKqPlZf1Gr2FTl8POfwioIPSDcX1uCOBBYTtCl8nyMPg=
X-Received: by 2002:a05:6402:28c7:b0:5c2:6e51:9d11 with SMTP id
 4fb4d7f45d1cf-5c464a586f8mr9471007a12.27.1727076973748; Mon, 23 Sep 2024
 00:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+E4RP+gJghHZujmKUJbCgYY_L20ssVmvmRUT4a8FvunQ@mail.gmail.com>
 <tencent_AB92549E869AAA1F1E5EF653439554675109@qq.com>
In-Reply-To: <tencent_AB92549E869AAA1F1E5EF653439554675109@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 09:36:00 +0200
Message-ID: <CANn89iLMVTgM4+GWfYO8ue2aV34qVx=p-uGQVQY4yQV6fv_rLg@mail.gmail.com>
Subject: Re: [PATCH] net: Fix potential RCU dereference issue in tcp_assign_congestion_control
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, fw@strlen.de, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 5:16=E2=80=AFAM Jiawei Ye <jiawei.ye@foxmail.com> w=
rote:
>
> Thank you very much for your feedback, Florian Westphal and Eric Dumazet.
>
> On 9/20/24 22:11, Eric Dumazet wrote
> >
> > On Fri, Sep 20, 2024 at 11:35=E2=80=AFAM Florian Westphal <fw@strlen.de=
> wrote:
> > >
> > > Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> > > > In the `tcp_assign_congestion_control` function, the `ca->flags` is
> > > > accessed after the RCU read-side critical section is unlocked. Acco=
rding
> > > > to RCU usage rules, this is illegal. Reusing this pointer can lead =
to
> > > > unpredictable behavior, including accessing memory that has been up=
dated
> > > > or causing use-after-free issues.
> > > >
> > > > This possible bug was identified using a static analysis tool devel=
oped
> > > > by myself, specifically designed to detect RCU-related issues.
> > > >
> > > > To resolve this issue, the `rcu_read_unlock` call has been moved to=
 the
> > > > end of the function.
> > > >
> > > > Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> > > > ---
> > > > In another part of the file, `tcp_set_congestion_control` calls
> > > > `tcp_reinit_congestion_control`, ensuring that the congestion contr=
ol
> > > > reinitialization process is protected by RCU. The
> > > > `tcp_reinit_congestion_control` function contains operations almost
> > > > identical to those in `tcp_assign_congestion_control`, but the form=
er
> > > > operates under full RCU protection, whereas the latter is only part=
ially
> > > > protected. The differing protection strategies between the two may
> > > > warrant further unification.
> > > > ---
> > > >  net/ipv4/tcp_cong.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > > > index 0306d257fa64..356a59d316e3 100644
> > > > --- a/net/ipv4/tcp_cong.c
> > > > +++ b/net/ipv4/tcp_cong.c
> > > > @@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct soc=
k *sk)
> > > >       if (unlikely(!bpf_try_module_get(ca, ca->owner)))
> > > >               ca =3D &tcp_reno;
> > >
> > > After this, ca either has module refcount incremented, so it can't
> > > go away anymore, or reno fallback was enabled (always bultin).
> > >
> > > >       icsk->icsk_ca_ops =3D ca;
> > > > -     rcu_read_unlock();
> > >
> > > Therefore its ok to rcu unlock here.
> >
> > I agree, there is no bug here.
> >
> > Jiawei Ye, I guess your static analysis tool is not ready yet.
>
> Yes, the static analysis tool is still under development and debugging.
>
> While I've collected and analyzed some relevant RCU commits from
> associated repositories, designing an effective static detection tool
> remains challenging.
>
> It's quite difficult without the assistance of experienced developers. If
> you have any suggestions or examples, I would greatly appreciate your
> help.
>

This case is explained in Documentation/RCU/rcuref.rst

line 61 : search_and_reference()

For congestion control modules, we call try_module_get() which calls
atomic_inc_not_zero(&module->refcnt)

