Return-Path: <linux-kernel+bounces-511740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB4A32EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93163A66FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C97D261364;
	Wed, 12 Feb 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mojI/bFq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDE260A29
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386549; cv=none; b=MuKtyDoah4G+I1/fKbtjGWFjJ6y53s9RpytPrOgPuPxAGA/H6URbVwImKYg7/Ejw2FD9DYRD9qTb4cqWwrVsO8rSp0bpaTcEVjgIDNTwWqhwb3EVjyPLg/S0TwLhcii2iulr9iPLhcU7VZlEI85Pt4JGtIzxIH54VjRBnfBhwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386549; c=relaxed/simple;
	bh=CVMGdoYDL8T1fr+KrjJAoYlnGkxM8XNvTPZrejVoMJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R11pmYSgkeUdfF8Z5X0//Tp3KmR5QHlMApH51jM3rcBpImzNWlLaRbRWcpSExCOQnBh/ekwX/pWagM3fwPOkI5C0BFQbCoH+HBD9OxoyjJVsYR/LJpv5J3b4aYQPjJHIgWGlyLHEhXGox/XKp1u+fmHFIbOjsCNcm8g0LIK0ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mojI/bFq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so10270292a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739386545; x=1739991345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=mojI/bFq64VDLGVn4okoRdSh1uOirl93u3OgiJu2w/yPT9Sdo+70AwCom7n519LHPY
         Z0P5if1rCC++SzpOWaKjswutjKgD+ZZ0a98JuyVLC6DWC/3bo5RS18kg1U4eVCnasrh7
         R5faWFOj1U3gIzlVDMfAfOAnTy9piqC3MApX6ZfndQd8PuA71d/8i32ILePJ0R+Wnxzc
         Pe21mE1TPgKnFm9UNehLL94eCpZEAM3shNPdDTrhPvI4wnQ2ig61EsWOTz2kBWo5MCBl
         UtV8BT8DzIozU41MBcOv8hrklTQ2ooLuR3psH+d8oiFzAnsFhHXjU2Pew0GcolBViwEt
         lKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386545; x=1739991345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=JQv+QGr1WcSWSg1i75Y/1Lukj1WevYxUVbkT50rjsj9jkGRez7QtiGnCmotEItSH03
         RSbZxQt5iO/irOArBwBYBPFdJ12ghQOQpKdVTxu2NTRBPt25c7VrvXoDW048M1DKlwSv
         4lQfFrqnHrhK02m/sM4yD4p417J6fVtAUj2bdbrGys63cBC9mK3p60lVPTDV+aUdw1WB
         iL5sUD5HUUeq5Kqk9qGUN2Z9gqIFqubZPJ6Eb6vz2/ZibJI6Sqc0dZZGF/l8guC0FoD/
         qLIk5H/iPQpHocgOv9Z4T3GD6xuAHCItUZ24QlSuUCZ4eaUbkuLtRF8z/u3IYbG1iu7B
         Hatw==
X-Forwarded-Encrypted: i=1; AJvYcCVnl6A3YlQj3weUHDJ16qqttGlHhY93LDkBH8KI4SOQtgCrsCWfGwqGTj0VLQTjFdzThFR9ot1HpzwjLi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3ilSZ3VoxkMh+clPRyl/Jq9BNhS/R0PGrUxmYCvJeATx1e+N
	aJSfF39KzOH6hHETNnLNipmaFG3lBPm9Dlgk5Y4feTxfKQ7WmWGVEnIOgDrxtlcSpXycKiOOtDG
	L3PraJBqZ4HzQVW0uugehXwx6RakpF79JYk6D
X-Gm-Gg: ASbGncttkdh4Il/SWbWt+0wKcJALzffcox9TAPW+K7Bs83c2kOf8jG5cLsoZKyOJkqb
	FDCtumBGFSc8Az+3hVW/A2NUKogS8+FtPwlRAJYtXesBNaHxXib6kVD4u1IIjIDCBBN15CIx9Pw
	==
X-Google-Smtp-Source: AGHT+IG55X34wS789mMJieuUREdopLjA3B44FyJjV3/cSlysBfK2oTbNjkWAOTqEn89wiamATCHt8vdoRDXvCYynFHo=
X-Received: by 2002:a05:6402:913:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5deca0122e2mr249031a12.32.1739386544998; Wed, 12 Feb 2025
 10:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
In-Reply-To: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 19:55:32 +0100
X-Gm-Features: AWEUYZleq88KnF_kE4nPNRYzraS7tQ5dHAAtHxK4ii3MnHWveDWf1gwFIVTqsms
Message-ID: <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: disable local BH when scheduling NAPI
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:34=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The netdevsim driver was getting NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
>
> This is showing the following message when running netconsole selftest.
>
>         NOHZ tick-stop error: local softirq work is pending, handler #08!=
!!
>
> Add local_bh_disable()/enable() around the napi_schedule() call to
> prevent softirqs from being handled during this xmit.
>
> Cc: stable@vger.kernel.org
> Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 42f247cbdceecbadf27f7090c030aa5bd240c18a..6aeb081b06da226ab91c49f53=
d08f465570877ae 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         if (unlikely(nsim_forward_skb(peer_dev, skb, rq) =3D=3D NET_RX_DR=
OP))
>                 goto out_drop_cnt;
>
> +       local_bh_disable();
>         napi_schedule(&rq->napi);
> +       local_bh_enable();
>

I thought all ndo_start_xmit() were done under local_bh_disable()

Could you give more details ?

