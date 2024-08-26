Return-Path: <linux-kernel+bounces-301074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B495EC09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D511C21232
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE6145A0A;
	Mon, 26 Aug 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Tw7hK1p"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27A143886
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661065; cv=none; b=lhNNcTWiRTjnps437HguKGJWd8Xs8NYBLhN33Dv4u2U+muapVm+oxNK1yNClLd/YlqaHaeG2G45erOe9koAkFxSZUo0U2KBuQ1LmujbLpN5/qY/RUbbB4jqrzsDLyF8V1SHXovKDOKbeoTYPrAWaLwxrTH9T2nMIGPnqYKwrWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661065; c=relaxed/simple;
	bh=FmO/rQ8nslR+oKdgtMfAsby3owAA7q7MTjhjMcsASk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnoTMIUoDFWlVMoh1arEMNWb2uPxYhKhJIS3UODZn6spExiwRPwxIzpwqAkjO3wUFYXUnpowlkFnzfvUCmezcWPEQSKpVunHJBLZKbdBPTknLlBOBkm6pqT5VFAZgi1ZMJuXqm4018n1ZDvr91/zuthM7TW6sqUM3x18JmotMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Tw7hK1p; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso49158741fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724661062; x=1725265862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy8xc2n1NiOjlg7WCsliCKVK+AeuZUdbXfZJkxDQ/Fk=;
        b=0Tw7hK1pPWQFWdY+BB7/zK459EQ8BcRNbssRLkCXdZnzlaiKHT11ydOHKwiIWf2Aw+
         NmB80RQ/SY7Z7oFKIpaTOHwldjLajIoiT4X/zv4bSoNkWFzOzV63kBxMMdzArkFSfsAe
         YCTeqqXSm/peRZ+JfJTQo2bpQ8EmSobdp+sKI1uQxot9naHyJqA2Rkd4HUvOlszT3Zg1
         Uol0u+5zZTefFcf5hhXeTawsfV4h9NshjeeXyBl2PPq8l8HgavmJuJkRPq0IhYqoxMTc
         l0Vs8aWmUsr01pKMHaQayudiF3DbHUvup1rQAmDNFT/VM0R7cXvJt6c+d1z4nq4aScN+
         UL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661062; x=1725265862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy8xc2n1NiOjlg7WCsliCKVK+AeuZUdbXfZJkxDQ/Fk=;
        b=e/I/HIGlIIKNKqrFPOjB5EJFPNVOVMIryO30qFVerslacCS0AwAH1/o0ZwGWDTFp3k
         Bi5/0x36jEC2dzfHRjAvxg3OzyYWHYhvW5mvEkSEPj6gpEVG5v+RvwNvGaXolQgtGdCP
         GZg28DBO7BgB6PYbtIBYKtI571i98EHnUXB6vVO/7EBtzJgqx2wbJcg0RhFu+kNzjpox
         93FkXX9crPJbqSgmYGEd5llvrEXd/XSVzBeym8mfYEjMgcwF9RMi78dVzYkkncONL/lM
         UiBKWlJGonOlTgf4awAO/eMVqyWOQghggQKU6BDXchNtIFR4EqzAGT/fq4LbQrJdis5S
         +2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa9cRJd5IKc0PKEyb54/gAgv6R0XlJbwAJ919bLtokL57rM6CdbTh+YWxWjsGAXWTYCkAzKQO6Y/ZYeuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFjFv0ouDHYseFYJTkQo+Ytp5xo+vfgKSkAC6Rh/+rLcqsrXl
	YdFb7kaxc2KySvphzMm+1vMhI5UDuWjZEUOgSwlKe3/oZ9g21E90OgDDS+2GeYV/4pYU4/5nTqY
	QqR7hoMJyamoROctvepuT1GcusprGPRcdpMxP
X-Google-Smtp-Source: AGHT+IGmZksM6iQAi5YQXg9R5d38fvbtn38gX6iCvgAv/dGfJPVgkwD8f4bi3UPxC4a0k4iidLShjs/3BEpMJs5lAp0=
X-Received: by 2002:a2e:b704:0:b0:2ef:2905:f36d with SMTP id
 38308e7fff4ca-2f4f5750715mr63986461fa.16.1724661061021; Mon, 26 Aug 2024
 01:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_155F5603C098FE823F48F8918122C3783107@qq.com>
In-Reply-To: <tencent_155F5603C098FE823F48F8918122C3783107@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 10:30:50 +0200
Message-ID: <CANn89iKWsCTYPzB4wuEWbU5sjABThsTBPtpoEcE4h=AfPQm40w@mail.gmail.com>
Subject: Re: [PATCH] net: Remove a local variable with the same name as the parameter.
To: jiping huang <huangjiping95@qq.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:42=E2=80=AFAM jiping huang <huangjiping95@qq.com>=
 wrote:
>
> There is no need to use an additional local avariable to get rtmsg.flags,
> and this variable has the same name as the function argument.
>
> Signed-off-by: jiping huang <huangjiping95@qq.com>
>
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index f669da98d11d..0d69267c9971 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -1830,12 +1830,10 @@ int fib_dump_info(struct sk_buff *skb, u32 portid=
, u32 seq, int event,
>
>         if (nhs =3D=3D 1) {
>                 const struct fib_nh_common *nhc =3D fib_info_nhc(fi, 0);
> -               unsigned char flags =3D 0;
>
> -               if (fib_nexthop_info(skb, nhc, AF_INET, &flags, false) < =
0)
> +               if (fib_nexthop_info(skb, nhc, AF_INET, &rtm->rtm_flags, =
false) < 0)
>                         goto nla_put_failure;
>
> -               rtm->rtm_flags =3D flags;
>  #ifdef CONFIG_IP_ROUTE_CLASSID
>                 if (nhc->nhc_family =3D=3D AF_INET) {
>                         struct fib_nh *nh;

Wrong patch, please read fib_nexthop_info(), it does not clear *flags at en=
try.

