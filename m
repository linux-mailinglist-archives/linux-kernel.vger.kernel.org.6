Return-Path: <linux-kernel+bounces-293994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2041C958756
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A4E1F22ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7B18FDD8;
	Tue, 20 Aug 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SogOe8+b"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE918E039
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158153; cv=none; b=PZU3Ijde1W+pGumX1RfWaLpwyaevp8aYCJwOspxiJjKoRplbyidBGetx+olH+dDFKAeVMJUiMiyjA+GHyScPaEx9QJAtcrxklqAcvKM5aMocDS1Ux8CbxfSUrEkHR4Un5q86RUXoJzaEocSnprVxu5j0wFhWlMwrr7C6JmvyV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158153; c=relaxed/simple;
	bh=1Sbs6eQl2iCqdSwxfE6pIQkD2Iw+7sq2JAkoE4cztJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmiKckTkh2rqDWembT3POSAq0V0LaKmcaSRM+z0Gv9xAqN4Jt1fA4F/0zaCvLV91pMveBGyNGfQVwuwJvlTr0U4Lp8LAUBTOqPpPNjPVaTAU9NptdxWVFqpRaUkANCLVL24fZW7r//cM027KGjrhKzopZaVE4E8uRaSrIX2cQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SogOe8+b; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so8276751a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724158150; x=1724762950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkcpd9YjkBve1E3v11AvpsRGi8t+U6b6eWmy9I0Lke0=;
        b=SogOe8+bUgDZTYf9BvUKa7KPTiSa+CztO1ubgqTeWKggAI9HcT5HH24Jj6VGa8tfk1
         meE3T0odp8D2A8UsnXOG6npQnK65nOVMERdHYOTLHHHAXQWLPP6Vss7vUeqhwFn5ywYf
         hnOyC0OUmdBVDzEkbm1NgUxSRsiL48o9dAIOLeciZEpyPi+W0uTyGTGTATuEJXTE8Kii
         dpadUT49x/Oj4i2IFMQvOHZ5ccqanfjuuqfDtogqRRnG6r7HSAb4gHfi6k447CeDjnPS
         mggIzUxpr2WSpDi/S/dGYwi5eIkhBXvSzvW0O1+cwFz2OF4XrPU529hI4vUwllol4HRQ
         yEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158150; x=1724762950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkcpd9YjkBve1E3v11AvpsRGi8t+U6b6eWmy9I0Lke0=;
        b=jdpQekKY1Hs4AqCQi8188u8K1Jf6Ht9bWYuxQBttisU9aANcaYpYQEFGKj6BdBdBLy
         9KyoSevbgtKzwGLY6oGM1vtcaQNIPSKzD/5GfXlKkbztvRF0qT2KWOt/YA/rS/cGxQj0
         MmgW6FuLuPmEsuBwMtrX0IMasZy2BJ/YAMu/tUZqbYmDA/1QINx7sQDpA3JaIfrJzD7V
         fjHHSpwWCKnETOcKxlVoTBaXNHQSK029UlSUP1fpCZ1s4Vc+Tj6NKABm7s4DlyJurCco
         p39Um5U1TfvaFoEtbDVzmuJA6oe9y/ojAVLf9drSzwAtJ96/A9Z/HvAurwMddi4RzV1y
         MnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxwtHLvpl8OG0lbydOhTruy31FnC8xmT5ULf2RoVvR/EXiwukuaDEexX0X0wGHFZZ/DJfCv+YwWiuhHTKs4o5RIxYJ9IqD33jP8kix
X-Gm-Message-State: AOJu0YwKWXqs1GX1Vsfe6Gyd1+C9I4tpFRRWtrCeVdZVsRyyjbBT3GYW
	8mWS6Og4kjAj9XVEuk040pJQfDqxL09N+bWQwsHsRGyR5YR2sAkAG/8y6WCySoli8Q4loBUDp1x
	5VNWGDp2TjEr5OZfjNBnlhznjx1A7ki0+l8Ys
X-Google-Smtp-Source: AGHT+IEn9KaHhvgLkNx4C288H1MOvSj4VDl4aH4ZGXp6/aFM03ti3t2cri37LJzMl5DrhmRSLeoPKHKdyfVfGRIQBSo=
X-Received: by 2002:a17:907:9285:b0:a7a:8284:c8d6 with SMTP id
 a640c23a62f3a-a8643fd84a0mr361818166b.24.1724158149039; Tue, 20 Aug 2024
 05:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820121312.380126-1-aha310510@gmail.com> <20240820121526.380245-1-aha310510@gmail.com>
In-Reply-To: <20240820121526.380245-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 14:48:58 +0200
Message-ID: <CANn89iJrPpmHvidEdd7G7oPrm1+VWsdprvrzQiN4OwTKjU3KsQ@mail.gmail.com>
Subject: Re: [PATCH net,v6,1/2] net/smc: modify smc_sock structure
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, utz.bacher@de.ibm.com, 
	dust.li@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:15=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this, we need to modify the smc_sock structure.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: ac7138746e14 ("smc: establish new socket family")

Are you sure this Fixes: tag is correct ?

Hint : This commit is from 2017, but IPPROTO_SMC was added in 2024.


> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  net/smc/smc.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..f23f76e94a66 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,7 +283,10 @@ struct smc_connection {
>  };
>
>  struct smc_sock {                              /* smc sock container */
> -       struct sock             sk;
> +       union {
> +               struct sock             sk;     /* for AF_SMC */
> +               struct inet_sock        inet;   /* for IPPROTO_SMC */
> +       };
>         struct socket           *clcsock;       /* internal tcp socket */
>         void                    (*clcsk_state_change)(struct sock *sk);
>                                                 /* original stat_change f=
ct. */
> --

