Return-Path: <linux-kernel+bounces-365262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E099DFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A8B22658
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240A1A76D0;
	Tue, 15 Oct 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTCcg14r"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CC18B48A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978566; cv=none; b=IN9vvlfIuLmBVlSaq9Oq65LE1oD8ESMXkG33Lpailc6cqgnd9XXFIilPjXwuCkGg46q++nLJWFaTSwYG/pcizJcLO25Ukil3C4dbpKfNAhdj6/fvgau92j9/ZcoolllhZbzBELMFuOG7GkspEDd8EdrnEPWbwg5s1Wyb486O1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978566; c=relaxed/simple;
	bh=1gbWcAskLtuIcyihhu9c+7AfMGCc9qrTqDcakMl2d+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9rgPlp8A5MVxXrg63Or4ewCo0o9M2M/obH3RjM2DZ0DomKZ/DKhanSn2IdMSLzaTNE/GFFflE13y82ASXfi8cKTvQu7ian9MvG2Uzj8mFL23HXn15wQaOs7A8hYzXWN72B4YyzKQZuJ2LqSgCTQYp1eey35F90b7ZT3/93YD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTCcg14r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso2299863a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728978563; x=1729583363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0icc/AUQ8WVT9pXXaqfsQ+O84Dh7jPoXBxzIImpUACo=;
        b=GTCcg14rHhLxuY0wtwMLls1VHqF8SEfFaSDJanyI/VaANG99hlebvaY61UVYWK1+rk
         CC90qtqs0TUPOlRl4cvNgwXXVBcOQTTB7Sp8oekhfAr3uHWCPqbXl6tCP4hU3OzuUMI+
         EmtZbXFmkx9/QkTWf03H+FY1WqAClHR6HF6XJQeMe39205yYtOHat+Hel63w6WiyT5OY
         ZLKM6ci2sqrPW4S6/MCNK0VPtgSOzor4lBuqDgqGfUqFqtf+f3n7cX6iCQmth4MUe1jf
         A09IJpuLKqzu96hL9B0MPVCDaILmGdPjmFTdFuuxheCZ41alamsHzt7FS/Pz0TrQiB7f
         SJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978563; x=1729583363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0icc/AUQ8WVT9pXXaqfsQ+O84Dh7jPoXBxzIImpUACo=;
        b=EeziANBGzKKUzaLbEvh2Q7fonf7aO+8XxLLJ8RT9tX2z7TH29H291pPgh9Muhs6fRL
         dNaAh/eH0Mh2CXl3DaSG+AcRz53BVSDDfn6gEMom4UXvxXWsJBxSC4LCE3NVuQA/iGXS
         AO/fqqmcbXvqFeAmZ5s39F6WqzGPmY0XG8YquJSX/JfY1BFR/ChnR9WceTi5Wa1hp30h
         saiAw4MKA8XJDMOl4yqJ0WyMCZGxBjMSZH7xaiW1bAkn4mC3eYEOMtwGpyxz8W/zznZM
         Oy8rUuet55uHW6qhLkniRIqJCzSNLfxWV427jZ4tU8vzlKLyNL7W9ZHskoozzl7AaYXy
         FTPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYr+fNcfhiuJt5fqY+ATbD3rbT3+Trme6vDOkqLdvCxvv8pNdurXdYDnJRSE87ZnmPSQaoViT1C0c01oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTC2P9CUgcrlfWSgehhavT3LPv4PJ571zkoqsD7hDxlN/u6xV
	TMNEdOqK28u7BJognZrc0CRsqpbmF9suYfGhJsn0OXaK67TMLv50O/NAt6LApNBZZV6HHJaaWMz
	i26D1QwZG1Y5ONrQFKJEuT8qj0jwP3aogWSI9
X-Google-Smtp-Source: AGHT+IEUPCLq2fMi1HPzgRwWyYlbPVHtF7hRqZjN4RQ4wB4rew35OMAVkyEDQ/mvrIfOIMfqQ0lMowiG4CPB+1QSuyw=
X-Received: by 2002:aa7:d38c:0:b0:5c8:8cf5:e97a with SMTP id
 4fb4d7f45d1cf-5c95ac6353bmr13764361a12.33.1728978562972; Tue, 15 Oct 2024
 00:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014144250.38802-1-wanghai38@huawei.com>
In-Reply-To: <20241014144250.38802-1-wanghai38@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 09:49:11 +0200
Message-ID: <CANn89i+LwDrV4km4iymw4yXU+kVMAvhmLUk2x_bmKXD_Bphi5w@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: rtsn: fix potential memory leak in rtsn_start_xmit()
To: Wang Hai <wanghai38@huawei.com>
Cc: niklas.soderlund@ragnatech.se, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew@lunn.ch, zhangxiaoxu5@huawei.com, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:43=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wro=
te:
>
> The rtsn_start_xmit() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb_any() to fix it.
>
> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethern=
et-TSN")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/renesas/rtsn.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/r=
enesas/rtsn.c
> index f9f63c61d792..6b3f7fca8d15 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -1057,6 +1057,7 @@ static netdev_tx_t rtsn_start_xmit(struct sk_buff *=
skb, struct net_device *ndev)
>         if (skb->len >=3D TX_DS) {
>                 priv->stats.tx_dropped++;
>                 priv->stats.tx_errors++;
> +               dev_kfree_skb_any(skb);
>                 goto out;
>         }
>

Note this is dead code for this driver. This condition should never be
hit with checks in upper layers,
because TX_DS is bigger than device max mtu.

Reviewed-by: Eric Dumazet <edumazet@google.com>

