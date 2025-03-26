Return-Path: <linux-kernel+bounces-577607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5469A71F65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FB71896AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D73255E2E;
	Wed, 26 Mar 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SPtI7YW9"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00139255E23
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017920; cv=none; b=Pi0QNVjrwwonlosjQHgXKJF3/SjumZ4A0PdgrDmt5Y5s1pyLYVXHG65tdMds/Qn5Hfn5l0bOwEnwreQSz2kzjhm2gXsXwGZnmLC8/Lji9VJARIoUUbxM0/o5QymqMjquxegzOlNqb1bccARWF3AzNTS+qhCQPsiMnPFVfHD80r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017920; c=relaxed/simple;
	bh=3w4M9U/6KMoXnHUmGA2Lbn4KvHbZmjf8oMnVhzAkMas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Gv99CGcW6dTHN4b6ZpflYkuqcvBEACJfeQE6GM/kHEyXiR/y3NIIV4xBWhRTECpzD2QjUStnZrDxYCmqsBrKuxmlaTvoWGSR2TF3i6MT3cVawbwB7t5P7ZBS9h024NFm1p9w01zdXI4PC8pRI0Zrwi06dhJrwiTlHwrCE4OTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SPtI7YW9; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so277132276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743017917; x=1743622717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37blrJ4dA4pbuNAhm4qoJ4s8JjE8q0/IzkGXMncvmgs=;
        b=SPtI7YW9hruD3jTLpYMd4BOFVnzWvq4gewA/J4It6G89jQ3IB4MYte098qHXDkg6ym
         qCEmscQwUAEPxJO5g7IFw/22q/9NidZYeEmokN6lCtBFBpTS6IIokmpxNhoQsTSERmrD
         UHf/D4hbfUrXezZRp878wok25HJT49imr8fsewED+nJL1ZvMESJzkdBmBb/6wfejUqnB
         4+TG+Sg0L7hEHOhgvEm79R/o8YQN/g5dy1FcCk8LsvYbPfniJ61oUYfCyMiF1s+Xv4D9
         s2PkoN2mI1Q1vv2Fi20x9YO+X+q5cM/ozD2TaU5CvW52KuCYK2nQUEuIfEOMM4ApM04s
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017917; x=1743622717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37blrJ4dA4pbuNAhm4qoJ4s8JjE8q0/IzkGXMncvmgs=;
        b=BQwWzIak6mkVMteoQoO4nIurkJ3EkTJ3HkW1V/UNrfj6lBnEi9CnRwy8WDiFRonf1T
         By+IomiuWYhlPeVR2ngCIsjP5HLIP8LXNO1PjaXYuGKPPwpABUv4HLGkSM8wJbnbKUFP
         nl+CRWnwdm6Q1N4guNP26a/AWA7w2lzNIQb+18CFsTb9ecVzUn2eKVjOBnuvgXa5z2ig
         mBWrHvkeWUHLQ05x3hrvj4xmDmTt/HqadJEPvbVp2RvcYKDVgOHwbJk1vNB53WCCJPGs
         9XYYWxY/Gc5Xgn9HLYX7/j+/CEbDViZHxbPfcNiYRxOUL9sK3ryRtWzIMKmw5szUveyC
         eMeQ==
X-Gm-Message-State: AOJu0YxB7LdFQE7YG+QldsSMieeVDUr32ddP890nfYUIsQX5bN7kmtxl
	sPx2vmYjJEvik7u5KAaxZuGwkGTSMCifAWCG5BksNMaUMm1Tn10QDXcxBe2QukSKdXCKgYmH1Eh
	AR90836mUI3zggZ2vXbvOs7F0EhhP3sYAyABe
X-Gm-Gg: ASbGnctVagpV3NMLZnNt14ErPeCUSFqxvR18tYQ5KphLuxd3nfk2rdl7Jdl2lRwhSR5
	gDma2zUmtK1pmB6puhQvHGbEZ2YRBUslQh5kUHR/eJaJ25R6DQN99Pd/zzf6MAkg4uVHOfFwUss
	JyYdXOKtVFmwlAQwVwIBhxZXm5Aw==
X-Google-Smtp-Source: AGHT+IEKQn/nJM0uTtrV4JZhrCW9IJH+yJidlTMVM2nALH+VjfWmiWTfWqHmGlsegAJ2Tfw9AccjfAhu1hVM+OJq0PI=
X-Received: by 2002:a05:690c:968a:b0:6f6:d01c:af1f with SMTP id
 00721157ae682-70224fbfd87mr11354817b3.16.1743017916900; Wed, 26 Mar 2025
 12:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326074355.24016-1-mowenroot@163.com>
In-Reply-To: <20250326074355.24016-1-mowenroot@163.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 15:38:25 -0400
X-Gm-Features: AQ5f1JpWlU1-iecgrVs8fJXGenKH2jxovnmTGIWOOp81NIsiGDtaZoSu2Wqu7J4
Message-ID: <CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>
Subject: Re: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on
 IPv4 sockets
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Debin Zhu <mowenroot@163.com>, 
	Bitao Ouyang <1985755126@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:44=E2=80=AFAM Debin Zhu <mowenroot@163.com> wrote=
:
>
> Added IPv6 socket checks in `calipso_sock_getattr`, `calipso_sock_setattr=
`,
> and `calipso_sock_delattr` functions.
> Return `-EAFNOSUPPORT` error code if the socket is not of the IPv6 type.
> This fix prevents the IPv6 datagram code from
> incorrectly calling the IPv4 datagram code,
> thereby avoiding a NULL pointer exception.
>
> Signed-off-by: Debin Zhu <mowenroot@163.com>
> Signed-off-by: Bitao Ouyang <1985755126@qq.com>
> ---
>  net/ipv6/calipso.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Adding netdev and Jakub to the To/CC line, original lore link below:

https://lore.kernel.org/all/20250326074355.24016-1-mowenroot@163.com/

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index dbcea9fee..ef55e4176 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
>         struct ipv6_opt_hdr *hop;
>         int opt_len, len, ret_val =3D -ENOMSG, offset;
>         unsigned char *opt;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         if (!txopts || !txopts->hopopt)
>                 goto done;

For all three function, I'd probably add a single blank line between
the local variable declarations and the code below for the sake of
readability.  I'd probably also drop the comment as the code seems
reasonably obvious (inet6_sk() can return NULL, we can't do anything
with a NULL ptr so bail), but neither are reasons for not applying
this patch, if anything they can be fixed up during the merge assuming
the patch author agrees.

Anyway, this looks good to me, Jakub and/or other netdev folks, we
should get this marked for stable and sent up to Linus, do you want to
do that or should I?

Acked-by: Paul Moore <paul@paul-moore.com>

> @@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
>  {
>         int ret_val;
>         struct ipv6_opt_hdr *old, *new;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         old =3D NULL;
>         if (txopts)
>                 old =3D txopts->hopopt;
> @@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
>  static void calipso_sock_delattr(struct sock *sk)
>  {
>         struct ipv6_opt_hdr *new_hop;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         if (!txopts || !txopts->hopopt)
>                 goto done;
>
> --
> 2.34.1

--=20
paul-moore.com

