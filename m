Return-Path: <linux-kernel+bounces-417589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AD9D564B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854411F239B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500311DE3A0;
	Thu, 21 Nov 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQrHwhKI"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E214A0AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232489; cv=none; b=NxRe8///8mro0q/AwSxxHF9FsS7Fj+XDwAOF47+TsBalK7OfVwqYI7XVFvVF9bMzPSbfz+wlQ6ZUyQRtyke8ikp69zXOok7JDgbo13cOif9A9heH2wSTX13M3X0vyETB5rlMUsquDB59xD2dv9e67oy+mt0B7xy2UxEKPhcnjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232489; c=relaxed/simple;
	bh=GAGeyjma0OWUpCJKAEmxTSrxd63qptg5iQmg60r4GK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4pFMLDRNtfcusWQt6Tx6a2DQaIVJCLDMZeR3+hiCHysFFT4Mqn5xXoVxbqBQGoY3Qu0oOFk1gWHsRXU4JgXBsHIa/fa5/b5xLRbWK9onRJb59eOZjLAdKQ7Ntdl89lTTt1xNorGPYXq1AjlGdqgDeGZ/LzDJ6NR4r8XpeUDBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQrHwhKI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e44654ae3so221254266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732232486; x=1732837286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlAQqiwr0hpJ5m3KUjmdkaUC+r6lTZsKjn0oTMkEf38=;
        b=WQrHwhKIBLiC48iRc0O8ceFzC1zqrUJZR4JMSu2RCInsJFBmzMz6LQ6C1duvxkz8Bq
         HyUuJVEkZU8pMKRqNRWhIFszJdG3ChIqbD09TCwtprv8AMR2cnguyC6CuTgd5t9T5RYg
         ScoA7jdgEIa0z8qStvCNiNNt6IQ14mnA76HoXPu0jd5KUzUr6YBqYVTshh4J5Ag9PhwU
         G5zofLkobjylFbBK4fODhR+ouEdYTFowLID48wwNeBwmlkPv//6wif6iymoB07/oPhyJ
         u/OD2hM+mlmHh/r1Biq6yPEgLAkx4nAdUgtuA9nrhkK/dUvKgdt3+RfrrVWwbJw15rGI
         djAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732232486; x=1732837286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlAQqiwr0hpJ5m3KUjmdkaUC+r6lTZsKjn0oTMkEf38=;
        b=vXJzScUdecHAJCpIE+ullihPHZM3AvvG273eswaK02gkaqOy7R7m31DUCgNv7XmX4v
         YfBDNdwr5MpUOqP+Hafb9VoRlgH78NmvTZjc2Lo36dVy9Vl1yX9IcJ3mrYtnPQup24a0
         al7b+qv8UnZKfNoi4pDWRWWkljUGoHuMEmsm0RHz6ylx58ygzRclMlkHrsRMQWr/mGca
         DDLVvESPcIEkKN2LS0jdDFQjeBwHph9mCYI46bl4CtLHkwg+3XKAl3hWvTb61Gs7bpuX
         8Httzu+08HHwvzc5mZCNjpLBT8+zDU96XG0OU6QPb4cGF3BmGbVlgfBn7ZD82nqgdgbd
         T6zA==
X-Forwarded-Encrypted: i=1; AJvYcCW8nkHeCWiyw/wznPkDjQrDJjGQrUGxeHiRT6Byye22GaEvNBycABPkXlD8AogpW3jn3/OZEDSJL90IW94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyqAb99jToxrR+c9qK5tOORzsjcW3RZePU+9AGy7yA5aaFKVW
	cQTfIpANPlXCA/99IpPv24gXwfM3prUOwl62h0UG9KSQg8d7oPuTsWMyYjwCdlaSgXeHqSvKZ6C
	fDvta0eCYTYnWD9PIUPhbU4JTVsdMzHHkd1Zn
X-Gm-Gg: ASbGncusBHLUm0Pe+1fRbMSaX8eoqomQLm76UrrieKfysoS3VhlwjiktNEftb4fP5/v
	YgkswbWxrA+EyDWjAQ98vnPCM4JjXbYU=
X-Google-Smtp-Source: AGHT+IGJvaJ/i6VCaIJHuXI/HpHCK+qSKmdKr4D5RhIxTUZeEtMiU1BmNJMv4pbZIXB872udvoA+/9Ck+Rw6FSIUNXk=
X-Received: by 2002:a17:906:32d1:b0:a99:cedd:4612 with SMTP id
 a640c23a62f3a-aa50997e1fdmr72575066b.22.1732232486100; Thu, 21 Nov 2024
 15:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
In-Reply-To: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 00:41:14 +0100
Message-ID: <CANn89iJeaaVhXU0VHZ0QF5-juS+xXRjk2rXfY2W+_GsJL_yXbA@mail.gmail.com>
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer access
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 3:59=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu.
>
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
>
> The replacement ensures correct pointer access while maintaining
> the existing locking and RCU semantics of the netpoll subsystem.
>
> Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer =
access")

This seems wrong. This sha1 does not exist, and the title is this patch.

We do not send a patch saying it is fixing itself.

I would suggest instead :

Fixes: c69c5e10adb9 ("netpoll: Use rcu_access_pointer() in __netpoll_setup"=
)

> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 45fb60bc4803958eb07d4038028269fc0c19622e..30152811e0903a369ccca3050=
0e11e696be158fd 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -626,7 +626,8 @@ int __netpoll_setup(struct netpoll *np, struct net_de=
vice *ndev)
>                 goto out;
>         }
>
> -       if (!rcu_access_pointer(ndev->npinfo)) {
> +       npinfo =3D rtnl_dereference(ndev->npinfo);
> +       if (!npinfo) {
>                 npinfo =3D kmalloc(sizeof(*npinfo), GFP_KERNEL);
>                 if (!npinfo) {
>                         err =3D -ENOMEM;
> @@ -646,7 +647,6 @@ int __netpoll_setup(struct netpoll *np, struct net_de=
vice *ndev)
>                                 goto free_npinfo;
>                 }
>         } else {
> -               npinfo =3D rtnl_dereference(ndev->npinfo);
>                 refcount_inc(&npinfo->refcnt);
>         }
>
>
> ---
> base-commit: 66418447d27b7f4c027587582a133dd0bc0a663b
> change-id: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

