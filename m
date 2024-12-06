Return-Path: <linux-kernel+bounces-435164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191AE9E7301
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B896164F53
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9E207DFD;
	Fri,  6 Dec 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAZUf5Yi"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723B207DE7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498113; cv=none; b=ezfFBrljePc7u/YkXZXmtcZcNG+m/hCbgVfFmC7SzIu94gGkU94MQar9a/tBzg5N2fo5lLotAGMggHlzJywiSzrXpEHpXtJaygW8uyY1Iu7XlO8zLBHmlp6KZJ8d8GMlJXzGGTCQZaiB7L7uDVRKx4OLmJ50JPeIVNGb2eUd3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498113; c=relaxed/simple;
	bh=Rf6UKchEYwEj7kWnfy7/GJwdbAaaF5fK63RIngHucuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5sVsSNvDO6Gign4yhg1aqUVmNis9I25Gm52ZBrHvmW95vsvLAnc453i7qYGxS6/8IeEkO/mNl2SpVchb37qAzMRDW1svbGiJEfJTtAzfq+Cf+4AshIojwioGLp+tD+UgjQbpwEQxjC3+7hNKMoZnqgcxA3s4tvhbq5WIZG0Z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAZUf5Yi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e399e3310so184837e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498109; x=1734102909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=HAZUf5Yi/x7pPufFqnKzofo90MVN9O20HwDDcDXUJqinTg1DLLfBNSHoDLGB6RdpZb
         gKdcnsOCBmzyIwt0XDOc1RvizVWPgY2njdxP7ePaMi0bKevVWmGHOAgEI+fUkRbH/rmf
         dCF7VzguxJcjmsMUQZF2HrwLDHR9uXVixK3wlFoIoZL/Pw4mQvRv3m/VfIk7aB3d4ShB
         eBv4MItPtKe+DFCEkFbGK65mMDugPmHhSW/Z+4YywDBHMNeriEJH2OjxZePrjO1z7NrG
         P8+ZIJ66HFHhdGGB7ASeWyfZxV3n0hqWSAtk9zA8PtLpGt/Pnw538lpKpC0593QSAaYN
         qIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498109; x=1734102909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=NcsigS2gVqentTeDTu5giYyLLU+EBv2/3uOH0J+7y4gArtkalHrBtP7hmkhQNEArJu
         qttFHLNjndrp6os4P2D1EUVAp2xpq7KfjJ//vAdGj6ZMxHfrzRx9+9hoD1nNqjN499Sp
         QOtTVx2aM+fEktug4EmMffaKoKbdsVLeAYuIQhyITlWNp5QlvACqEtxXCAaSwRFQzweA
         pP+w1icP4cutiDM9qnPyjkK+MSS2OjIjxTS4pocxDIVEGPdWxInEfhy3uppgZzUFSm5T
         JXj/WaBdNIeKEotUhsoysdt2Layo0MhUAgruZs2aPYN7E53R3chwSAxFiEssJy7+UntC
         Jz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0OtYUJggZqVcjykp+ZBnOahdi/lDtLw5GukcPRyRvjyzytx7z0yX/uwJ+DvltiQoAw8g92VWz7QAx+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvPr9d6yKNWF60zgFH8rB1Z5nCFSJNOJ19HBWryUi00EK6Vv+
	1DKO24+/DhtFQv1osbmP0yo0hAEj1qpwO9FikM4DVragWqbYBMrA4m81xOZhO1BYWE7Z9EF+VoC
	knvqoXU/PuFsrcUhYDBCeNARAlkEEz2vinkEU
X-Gm-Gg: ASbGncs/exNYTdP65w4F8y9Qnld3Q3S5LyLmj/esXICFgbmKV4VYwOcSd/DEJ47Uo8F
	DByR7WpR96Bv8wPShtaeHpMwBHLvByC0=
X-Google-Smtp-Source: AGHT+IE1cwLWlIj1GpiqN0fNBxkpgemnySZUfP6KDIPqY4kGmA+U/DT/8PsZJRBrjehxVuks6Jtd7XQt1GDre3GD9fE=
X-Received: by 2002:a05:6512:3b0b:b0:53d:e669:e7d4 with SMTP id
 2adb3069b0e04-53e2c2b8efemr2131796e87.16.1733498109407; Fri, 06 Dec 2024
 07:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
 <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
In-Reply-To: <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 16:14:58 +0100
Message-ID: <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:49=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Jakub, Eric,
>
> On Thu, 5 Dec 2024 at 09:09, Eric Dumazet <edumazet@google.com> wrote:
> > On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > Hi Eric!
> > >
> > > This was posted while you were away -- any thoughts or recommendation=
 on
> > > how to address the required nl message size changing? Or other proble=
ms
> > > pointed out by Dmitry? My suggestion in the subthread is to re-dump
> > > with a fixed, large buffer on EMSGSIZE, but that's not super clean..
> >
> > Hi Jakub
> >
> > inet_diag_dump_one_icsk() could retry, doubling the size until the
> > ~32768 byte limit is reached ?
> >
> > Also, we could make sure inet_sk_attr_size() returns at least
> > NLMSG_DEFAULT_SIZE, there is no
> > point trying to save memory for a single skb in inet_diag_dump_one_icsk=
().
>
> Starting from NLMSG_DEFAULT_SIZE sounds like a really sane idea! :-)

There is a consensus for this one, I will cook a patch with this part only.

>
> [..]
> > @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *=
hashinfo,
> >
> >         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
> >         if (err < 0) {
> > -               WARN_ON(err =3D=3D -EMSGSIZE);
> >                 nlmsg_free(rep);
> > +               if (err =3D=3D -EMSGSIZE) {
> > +                       attr_size <<=3D 1;
> > +                       if (attr_size + NLMSG_HDRLEN <=3D
> > SKB_WITH_OVERHEAD(32768)) {
> > +                               cond_resched();
> > +                               goto retry;
> > +                       }
> > +               }
> >                 goto out;
> >         }
> >         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).p=
ortid);
>
> To my personal taste on larger than 327 md5 keys scale, I'd prefer to
> see "dump may be inconsistent, retry if you need consistency" than
> -EMSGSIZE fail, yet userspace potentially may use the errno as a
> "retry" signal.
>

I do not yet understand this point. I will let you send a patch for
further discussion.

Thanks.

