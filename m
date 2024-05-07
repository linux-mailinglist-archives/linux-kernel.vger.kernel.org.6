Return-Path: <linux-kernel+bounces-171240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A818BE1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1839D1F2308C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBA156F33;
	Tue,  7 May 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ny65wLdZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BF152526
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083756; cv=none; b=Ifh8uGSm43J04IXDNChjN++CcdLnhRrGYV3KNO9605TnvnNqYrv7+MSrEY0lxaCw8k6PK+uovJEfDA07gXgtjXbmDO0d/DqDHeAzfFFnCWmnSpVZgPSrsnlo2s5y1mxLGAEKoBiUCZqviU1aWemK/xPsN76pECmjAaP5GPPsMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083756; c=relaxed/simple;
	bh=nCTjlUzmtoOmhK2cGoJ2k79k+dMAvYg7fw4RMC20he8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txpWSYcE0p3PmNAwJ472J+lLrm42AApzbp8hIOqzoj1ICUfxct1YPICanwnRmgo4U0n6d+sTlP5byC6O4sjGxc0hbt5y+tQ3NSM4C2NN76B2UJj9o6cF0fgKn2XHp+4DC3Vl3jRfGMeEGfZk1Z5ZBVMNvqjLdsxWL4nyMThXoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ny65wLdZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso14877a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715083753; x=1715688553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTjqFCQBhDEh9ASvoTn8Tyz7XDGxyH7/+g9gqGqGy60=;
        b=ny65wLdZG58IEs8UmpBmJVRuQZP/bF6c+kqz9QyDyZSUkY1W0drgh6ntvCntI+Npnr
         Ecc6JoJCq4OU8I1JJkQ5PDNPQjQixJ737JcRO6PFev4kOgssYUn6NuShaMJLrgy0LjEf
         9hsXin7QY8txC/xWRN2pX/uwBDhHSbC9CBJ1mwg53IN8B0wHHCTdIO4/U15SV/0WyIKG
         0cOog5S1w73Ceu1+Sjd6vP/mECuufRDGoi7GN/I0JQ99FoegwsyqIT9a8iEqVtq59YZq
         yvl20Je5cN1rKYGgW50oAf7pNRayk/X2JUdaJJ1puXSom0zic/M2pxB724J+/LFNBqTc
         FYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715083753; x=1715688553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTjqFCQBhDEh9ASvoTn8Tyz7XDGxyH7/+g9gqGqGy60=;
        b=SeIxtGu7pxNNGCij3fVYmTC4zTo5XH/WsaRfptRgFY1FyimDoynv17vrmLSHBXVeZG
         BJ40BkkPs82zcwc7bl8QXGPryPOrJfSj5MKxI7WE79iV6PZwg4keqO1bXMpydd6qJhWG
         NNOO+xuVy7CqCFm2DuJBhlutQQ8X9+eGn7ZompoAKWDACiKiTgau1Vif2M/3x64eYMa9
         U8q5F+KZ6zZKzItDHseH4SB5Tq4pOIGpHs7itBBro1zBH7cGWVBurgmrLDmh1tRRj9rx
         UszwR+8T4Ii9ENk/rzVzi0iF6udapxvveaZVxUt0cUxPeEz5pPodNsFrqaQcloJh0WjK
         Y0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXfNjmLYtJXsiX2NKarEq45wjDaC11GMtcLdGbrSffe4LxWtyyYTfUqdOFKqCSq2/wxhOgZ+cEWUa48zmwujBtLBKb+Rrxe+kYSstlC
X-Gm-Message-State: AOJu0YzQcJ6aQKYj11f3N37Gf3ys8cel5sWSFCRMJiESMOj1cqBQmxLV
	g5HzsaG0OWWciFHNjRucXJ4FsOPY+G9xEJwHPU9KlOZc01tk3l3u5G4FMzU8tbQEePYqyL/o/0+
	fj4I93bTUxG60baXUWuKb2o55Dq23mcM9AsMO
X-Google-Smtp-Source: AGHT+IGgzl+2Z0Ch0dEtdnETwkNx2lRaedYtL0MIFtrAOe+HBYQUxIjeACu5IumeESNcsEAmxvBVxOcyRLD9CkexnEc=
X-Received: by 2002:a05:6402:6d4:b0:572:25e4:26eb with SMTP id
 4fb4d7f45d1cf-573131c667amr137073a12.7.1715083752780; Tue, 07 May 2024
 05:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507094114.67716-1-nbd@nbd.name>
In-Reply-To: <20240507094114.67716-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 14:08:59 +0200
Message-ID: <CANn89i+kjcpuh8ecKkZKkKFGv2nTZxp1BA+BSgyPvSXLX-yfwg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add missing check for TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:41=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> It turns out that the existing checks do not guarantee that the skb can b=
e
> pulled up to the GRO offset. When using the usb r8152 network driver with
> GRO fraglist, the BUG() in __skb_pull is often triggered.

Why is it crashing ? I would expect tcp_gro_pull_header() to perform this e=
arly.

Please include a stack trace.

> Fix the crash by adding the missing check.
>
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index c90704befd7b..a71d2e623f0c 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb,
>                 flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
>                 flush |=3D skb->ip_summed !=3D p->ip_summed;
>                 flush |=3D skb->csum_level !=3D p->csum_level;
> +               flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));
>                 flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
>
>                 if (flush || skb_gro_receive_list(p, skb))
> --
> 2.44.0
>

