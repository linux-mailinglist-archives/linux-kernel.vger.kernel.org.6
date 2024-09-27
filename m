Return-Path: <linux-kernel+bounces-342051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F4988A11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA855B226A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6041C1AC5;
	Fri, 27 Sep 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="j0x2MVlR"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DE1C0DDC
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461517; cv=none; b=dOvNzIQRZNDWvyZ3VhztSAp4PQZsT1b9SkIwIg4hxBn0r3rF6RM9XNfJUcgYjQL/tT985evPNODXY5CYWTm3VA6/cIsbAaip3nY/sevwpQuARjny6v+OJ+DMnYKfXamV8sUfwuSTxOujVZLWCc4d8AWKMqay16uwug61XLcKR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461517; c=relaxed/simple;
	bh=WTom9d4P3DTj5urOnbDKSuJDfB3lentN3oqWXTDx41M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3Z9LEv12cDxm++Oudi2XZOD3EJoUzFQyFe2JLL1zFfjETDcz/H7C46mHULdwtWe7+a7tg/KrBsj0R/m34cSZLUAzSdrGpqXgtNm5fJPadRbUS23leNUWpXqs8/KNh5czIPeAHk30VAdXtukeLYXn9LIu6INYQiAvdT565uduR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=j0x2MVlR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso1027887a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727461515; x=1728066315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbLiVDeu7cPLJ5tOpijYLiBAYihmkJtTqVbrieWuCxs=;
        b=j0x2MVlRAqoIOFinMAdMYttuRQg1vZXQ+xtJLEJgNGTkze5olgrEOrdvC3wGiUIeyR
         z4ZH3jOrgonlorE84YbOLSgZ6pqE4hH2aGKgnv6RfAY5pFbtgUBBtL5b4fZSgu0nASrT
         sfcFvHiL/J9e/9SxdKJH2ozsM4wxFKtotllpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727461515; x=1728066315;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbLiVDeu7cPLJ5tOpijYLiBAYihmkJtTqVbrieWuCxs=;
        b=iuQioFNIdVnSzc2IGDlzMFKh1u6m+XnsKQ4pZ5laxIE1JBhvhezvjiatoc0J1LmM/l
         hukR+CEOZV/W/f9dbPUV4lTuGIwEQobx2Z6oZfDj4LyS5Z4ktboENUZGD9Q4L/QfQxjm
         zhFkHD2ZYmfzGB0ZwRhpFDgUVTQxXEcp0X7N7XxMLf204J79JFZIXHVJYfjMA061ARIn
         0Wgi6G52mR5egdxRLXhSpTbvKtWqFR7/hkPQw5CMWp06TXS82KZPDm861zd88U+MMRtA
         QpFgrhorbnW6cTCL1cSrWtn2qq6xJs2h+SL8A3R2CfmRGX8fAMRZhw7sEz8y3/L8czcx
         sfyw==
X-Forwarded-Encrypted: i=1; AJvYcCXT00DLosH3sbo9/JRFRTN7DCsIAIp8uaTeXysMBz0xU0ffFxRddj39Z/TxMVahROLHvvUh0M94dfp5iEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyt9sQr+kxvcF1MtZTFidtzd+P9GQ3hzttqg3L+prZgqx56IA
	Xr9v4gtQMW6ldujnrWe0rQwVKaFIeBzupqmOzYvfK3N9sUjc5E+bIInozFADW+I=
X-Google-Smtp-Source: AGHT+IGfGEZYEO8uIlPHjzt0vYr6USHZBi1rNrfNVVivW46Jiz95XGsukSNzhAlzcCmvwQUsrhFUcQ==
X-Received: by 2002:a17:90b:f90:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e09113c9d2mr12209507a91.11.1727461515191;
        Fri, 27 Sep 2024 11:25:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0d4af744bsm1372398a91.23.2024.09.27.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:25:14 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:25:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] gve: Map NAPI instances to queues
Message-ID: <Zvb4h7gZvrCErJsi@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240926030025.226221-1-jdamato@fastly.com>
 <20240926030025.226221-3-jdamato@fastly.com>
 <CA+f9V1OsZgH37X-zjWqjkjoQwteXg4=n_HyfA_SOWN9YM=GLRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+f9V1OsZgH37X-zjWqjkjoQwteXg4=n_HyfA_SOWN9YM=GLRg@mail.gmail.com>

On Fri, Sep 27, 2024 at 11:15:39AM -0700, Praveen Kaligineedi wrote:
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > index 661566db68c8..da811e90bdfa 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1875,6 +1875,9 @@ static void gve_turndown(struct gve_priv *priv)
> >
> >                 if (!gve_tx_was_added_to_block(priv, idx))
> >                         continue;
> > +
> > +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> > +                                    NULL);
> >                 napi_disable(&block->napi);
> >         }
> When XDP program is installed, the for loop iterates over both
> configured TX queues (idx <  priv->tx_cfg.num_queues) as well as
> dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues).
> Should add if (idx <  priv->tx_cfg.num_queues) check here.
> 
> > @@ -1909,6 +1915,9 @@ static void gve_turnup(struct gve_priv *priv)
> >                         continue;
> >
> >                 napi_enable(&block->napi);
> > +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> > +                                    &block->napi);
> > +
> >                 if (gve_is_gqi(priv)) {
> >                         iowrite32be(0, gve_irq_doorbell(priv, block));
> >                 } else {
> 
> Same as above. When XDP program is installed, the for loop iterates
> over both configured TX queues (idx <  priv->tx_cfg.num_queues) as
> well as dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues)

Ah, OK. Thanks for the review. I'll make that change and retest it
on my GCP instance.

Since net-next is (I think) likely to reopen soon, I'll include that
change in the submission I send next week and mention it in the
changelog.

