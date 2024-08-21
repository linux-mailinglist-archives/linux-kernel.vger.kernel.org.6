Return-Path: <linux-kernel+bounces-295085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561E959674
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44531F21CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD81B2EE3;
	Wed, 21 Aug 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtV5HVDO"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E61B2ECD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227061; cv=none; b=XB45nIMcM3RyVxqVqP+xLd2DZL/IjKmLudGOOAHTVq0I5CcDEhVvBD8jw9LsYLCj1Ry4069EYIFUeo40750ymmQVrTHnpiu0rMj0pIw/rmq81Cs5zKmUCJRIuDJM/pXNN0cNbXCt2x2rBGLOM/PTy2UryTvN7ChGbt//txUtYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227061; c=relaxed/simple;
	bh=BITPLSDnsffwk9DCPr8eRo/3AhaiUWzD3ab2u22BqCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKLf8trU1tVpDVH6faMomJci+RVTr2zb2MD8jEQxow3RIkU7CwpMBcdX9q5Ydsir26IQx/ETuFnp2155JBNQ+yf7pDRPsalFQ6xMJQsQiFBxDMsAChC45riKXb9uVf68MKuGnf8dSJ3YB7vQrBD1Klf+5G9thOMH6WfTUYlPIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtV5HVDO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so816557766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724227058; x=1724831858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m5xUZ5Y//U1jdVGPHwaGi+Tcuhrv+ekScrZy4rJfJU=;
        b=OtV5HVDOIc/VfQTrh8/PHaNTiT62lyk4OJ9I9UlsIoYLuWuvOYb+XFA82XcyxYL81w
         /CD//cchAuX7ebcQN4sgmitSU3fht9hzvJeC9LSVOtjcRTEc80Jw3hKGkmZ56d3FjI3b
         PjKLZEJifiOk9nVY420S6y0pBrr+4o/ItrG97sD/C8gUPnEBxMFa227hosukbK37GhYb
         m0Rs3lXJa8B456B7d1K0FQ2A5pv/TOG4IJC5Pr02g6oXpYwZDNif00PRp+XfpG5jx/9M
         SiSS20jmlsFiQBJUA803brRUPj561+K5F78OZUegngWspsH5TSmTkT/8cN6M404Bpxxv
         0Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227058; x=1724831858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m5xUZ5Y//U1jdVGPHwaGi+Tcuhrv+ekScrZy4rJfJU=;
        b=bWIy5P96cuctgB8dD2SsaxvNEem4owU6YOLNwXYpjDiAymfothfTzWCJHlFO6BUlvf
         9E4U4EnqePTtqjX88cTbYLXkH7EaiXrji18wa6e9LAVR1NznAQwZL+A/ZhkUv18pIURu
         8FHj9yiJBP4rrGq5dkkFGNGLY7wXr0XgM7jBy7iGuY+8GoSp5kKKAEtp5nSGlIsnTerf
         vsFNvl884WlYeJnZCYlPL3eIjGCpOOMZHxWb0aAYQzMdG+gcvVmu2WWcAIjd1Rv6oEPF
         OitDByLjOgw5Uw9t6WWBKr5V3lJ1LvH6qcoOjHOAZ6omHDPySMfoHZ8y4TRvh+fWhUbb
         jkdg==
X-Forwarded-Encrypted: i=1; AJvYcCU00izlexs/KE0mu0HNVHRUgNNu5XT+8Mt00AB0MVAsmgEgfzz3azDoQhXFw184CQpcsuYcQr6DMAQgjiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0BN/tvMKZTa3x73IOObOW040K18JFFvAtoNnzpmyglQVXnrk
	XvhyWDvnXQxfqd0isv0H1h46qa0zTgmDpim8CYDCktQGha9PjGnD48PcW88Ede5mJYfFXE40FZN
	wbGwTseto/HjP0coEJs/JxAttZRl8PUCunAnp
X-Google-Smtp-Source: AGHT+IHrEzX+NOzDPH7HLSILy2yPpS01UdIsJKnZJCuSMxGqZyngkDI8pYUX7VKV7M0SKCK2gjBkA14BD00JtEeRqRE=
X-Received: by 2002:a17:906:d26a:b0:a77:e48d:bae with SMTP id
 a640c23a62f3a-a866f3615cbmr105610266b.28.1724227057721; Wed, 21 Aug 2024
 00:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821060307.46350-1-ende.tan@starfivetech.com>
In-Reply-To: <20240821060307.46350-1-ende.tan@starfivetech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 09:57:23 +0200
Message-ID: <CANn89i+C_BoyG7hu4jH2PcWwKGdDQZ155s3A1B-xQ4fDmnubxw@mail.gmail.com>
Subject: Re: [net-next,v2,1/1] net: stmmac: Add dma_wmb() barrier before
 setting OWN bit in set_rx_owner()
To: ende.tan@starfivetech.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, leyfoon.tan@starfivetech.com, 
	minda.chen@starfivetech.com, endeneer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:03=E2=80=AFAM <ende.tan@starfivetech.com> wrote:
>
> From: Tan En De <ende.tan@starfivetech.com>
>
> Currently, some set_rx_owner() callbacks set interrupt-on-completion bit
> in addition to OWN bit, without inserting a dma_wmb() barrier in
> between. This might cause missed interrupt if the DMA sees the OWN bit
> before the interrupt-on-completion bit is set.
>
> Thus, this patch adds dma_wmb() barrier right before setting OWN bit in
> each of the callbacks. Now that the responsibility of calling dma_wmb()
> is delegated to the callbacks, let's simplify main driver code by
> removing dma_wmb() before stmmac_set_rx_owner().
>
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
> v2:
> - Avoid introducing a new function just to set the interrupt-on-completio=
n
>   bit, as it is wasteful to do so.
> - Delegate the responsibility of calling dma_wmb() from main driver code
>   to set_rx_owner() callbacks (i.e. let callbacks to manage the low-level
>   ordering/barrier rather than cluttering up the main driver code).
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20240814092438.312=
9-1-ende.tan@starfivetech.com/
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 5 ++++-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 5 +++--
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c       | 1 +
>  drivers/net/ethernet/stmicro/stmmac/norm_desc.c      | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 --
>  5 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 1c5802e0d7f4..95aea6ad485b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -186,10 +186,13 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
>
>  static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> -       p->des3 |=3D cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
> +       p->des3 |=3D cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
>
>         if (!disable_rx_ic)
>                 p->des3 |=3D cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);

RDES3_INT_ON_COMPLETION_EN was possibly written after RDES3_OWN

This looks like a bug fix to me, this should target the net tree.

> +
> +       dma_wmb();
> +       p->des3 |=3D cpu_to_le32(RDES3_OWN);
>  }
>
>  static int dwmac4_get_tx_ls(struct dma_desc *p)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index fc82862a612c..d76ae833c840 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -56,10 +56,11 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
>
>  static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> -       p->des3 |=3D cpu_to_le32(XGMAC_RDES3_OWN);
> -
>         if (!disable_rx_ic)
>                 p->des3 |=3D cpu_to_le32(XGMAC_RDES3_IOC);

Same kind of bug here.

> +
> +       dma_wmb();
> +       p->des3 |=3D cpu_to_le32(XGMAC_RDES3_OWN);
>  }

