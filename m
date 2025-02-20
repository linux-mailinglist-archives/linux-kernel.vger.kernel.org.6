Return-Path: <linux-kernel+bounces-523203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB7A3D376
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD217BE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922A1EC019;
	Thu, 20 Feb 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvuDOKZZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611921EB1BA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040882; cv=none; b=sfd76Z14Cb0x4JK4wCR8aLUr9PF+94KkYPU7IZl2ErDRhLtxaE2LnLN/Ig6KF/UtkdgOnMJ/Uosyk/gg+YLq3ypL0Eg0YKN6bcrItZxMaynUaJHGdVuPNIyhhtoFK2z0sn8qYbBwiCPWKRzjt5LZ37kvr8aHC4EUZGcgDKgflL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040882; c=relaxed/simple;
	bh=L664zTQ1YO5UiCR4eV/bv8qw2cOnMXFx6Vdv9gD0gtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG57iD06Pgw1ZKWRa3ixqgtwcIWal6HSK/0of91Oh8gyg7I+woBKBq3e7KgTwAZz/9UWz0WB068t3wiwJ65AGSuxwzqRWW5FmkPyKUcSA2AK1GFMH1tsqpUKLwz9xtDQUOLdE33WKIbZNvrhPdNCGfE34m+73Fnnq2FrVzr95IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvuDOKZZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so1263234a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740040878; x=1740645678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/B0GfEgs5YAFmdnX0UDSsDPd37I3/eSnTdtkRhowSE=;
        b=vvuDOKZZh0edXdFrw517xJlg/fgu3R81X/k0zMZfHKL/xW3ffLlOs3dfx9FLdQ+/Vz
         5mNKg3g/thW4SKnfK1XaPLZ/koeRfrQURAPmFDCYoN+3XxM4ArTgfqtCYWkpedZL1Qw0
         7+tiSX4lj4rLWqtiklMp77JEmE9xnSKuxPeQOaGlUZ7E7A+DHx/4UXEy+/ODimGu2N5O
         /wPx47NerzK5IlqHR7DOTr+EmJcLlemA/nyNU4DYOZjAWpZrgYa/PH+m3D0vCn3uHr3o
         q9rJjom4hsGgwzG2Icrz6m+O09ZVcX1TiXfSwi/o/+NRGLNblLI4L5n0T34HKxPoQKiU
         2QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040878; x=1740645678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/B0GfEgs5YAFmdnX0UDSsDPd37I3/eSnTdtkRhowSE=;
        b=EhrmiictFcVf/Z59yeRgdTMR3YKiVqFAixX8Nk+yfsdC/In/OOVESoPj4DG1xtcn8a
         XI3wcOIYVIjPDWd/T9UL+A+WFT77nI84qMbd+0P3f23qNgQ97vzKVL35frV67OU0Ducw
         Mqv7k0/klofGPSjYwfwi04FmkjwIdoXJ/yI+dTRIQ5jgA0/3Mv6gYUN66x7e/zDKHENq
         I2A4fy0OzJOTkM2CQXtmdCct1yr4JA0ddgwDFvJo3UIOnirFROMqthR5mLWD1JRsRAz9
         DvJbD9JBjwS12HkQC0B6anp4z5EZAw2INM+MNv9+e9RccBi0441Mt3b9IoR7VL4vJPOE
         UNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwOoKf7d6EKURrIMRU4yKrBEPC+DStV2DZJLEzf8zDf1QgUVTwDosP4dmjCfIHxXvbdgYVebkAGZihS7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Koz7JsX5xkqT5nRoksqijAHC93cji3ElK/BjJiwUFFdG3HDs
	20RdN7uA9wXID4ACOr6DkqcRn/Jt6RTXMOcJDJ1iom00J+Y7BKutl+eBzeyC/d77sxQIpa9D0oZ
	0xbdABOuw2YxeIBvnyDOmov7HOXWpVEQtZBeQ
X-Gm-Gg: ASbGnctOlINrptTe7FOrGT0bPYHSisxBMD4vF3+Y37sl2dpb7CdZ/Vf3KfvA8bqKwnj
	tcwxFaTrYcxS28x2r3cwOSWoIGcL6/WmbEKKjVEPJ/CRovuSuzXAA4arPWf1udT75WCu51VGfq3
	LV/rGGd2k3ux9Fh4E1+aNrxUusTfPHQg==
X-Google-Smtp-Source: AGHT+IFXcAFjpaJKujW5+KZDWSQQYXeZUtaOWrv/hWArWKingf+nZ1HYZNj6AugPO4FJR8wHz+Cx53odmSQ5wEFD2SM=
X-Received: by 2002:a05:6402:5246:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5e03604866bmr18955746a12.4.1740040878368; Thu, 20 Feb 2025
 00:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com> <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <4dff834e-f652-447c-a1f0-bfd851449f70@huawei.com>
In-Reply-To: <4dff834e-f652-447c-a1f0-bfd851449f70@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 09:41:07 +0100
X-Gm-Features: AWEUYZlEUz2j68qETDQCnXjzA4LCLg5wCCIyRAG4vH3HmM2uGgUFOuI3cdrgTlw
Message-ID: <CANn89iJGzLBVpOExJyeR3S3oVU2pUp62BpuqD3HgRay5aBK7ag@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: ncardwell@google.com, kuniyu@amazon.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:08=E2=80=AFAM Wang Hai <wanghai38@huawei.com> wro=
te:
>

> Hi Eric,
>
> According to the plan, can we fix it like this?
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..1210d4967b94 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -814,13 +814,6 @@ struct sock *tcp_check_req(struct sock *sk, struct
> sk_buff *skb,
>          }
>
>          /* In sequence, PAWS is OK. */
> -
> -       /* TODO: We probably should defer ts_recent change once
> -        * we take ownership of @req.
> -        */
> -       if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq,
> tcp_rsk(req)->rcv_nxt))
> -               WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
> -
>          if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn) {
>                  /* Truncate SYN, it is out of window starting
>                     at tcp_rsk(req)->rcv_isn + 1. */
> @@ -878,6 +871,9 @@ struct sock *tcp_check_req(struct sock *sk, struct
> sk_buff *skb,
>          sock_rps_save_rxhash(child, skb);
>          tcp_synack_rtt_meas(child, req);
>          *req_stolen =3D !own_req;
> +       if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)-
> seq, tcp_rsk(req)->rcv_nxt))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +
>          return inet_csk_complete_hashdance(sk, child, req, own_req);

Yes, this was the plan ;)

