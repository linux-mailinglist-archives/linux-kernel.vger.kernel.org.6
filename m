Return-Path: <linux-kernel+bounces-342040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CF9889F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B345E1F21F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589091C1AAB;
	Fri, 27 Sep 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX6/8PeW"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA0136E28
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460954; cv=none; b=i9y4EHKuKkCgzQ/1GceRb0zR4GqTWGysazeUeCjYtTrMB1cHwqrsU+IxXXmPBOLKawqKmRfHqAaK6VL50mHlxKgrHI7xbmkSKUmOx7vdP0QHjenhaOoHBNwcXJjhlWPMfQrBw1/7xgXeYUwchnnLFsPb3yFXLH5UiBdYO8QTSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460954; c=relaxed/simple;
	bh=cPGPrshc4QNk/99mTuoYkMhxWsse5tOYaZQsmXQjy6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW3FHxvYdLYbtAIH4883SpY08MZsoTkJelums/8+hBjOUQdC+E0apgSpDMoK0zEYTWi1vQ/bQvgTJCXtHVhEe6FWZGNDgXDL7x6C5eQr8iTigrwtn3F2E8WsfTj7VTHCWYO7+O9/C7Rh6oy10vBgMvfhdtYcLH0XKYlxAQeiTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AX6/8PeW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f759688444so23385851fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727460951; x=1728065751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAXC1jjS+q2JfymL+BkIvB6rw6pd4yUqUxSez452AvA=;
        b=AX6/8PeWqUWh8v/jtp95n1/7OLMWZpTGXw0b7iw/ttzaSEBejRS76SX5KKvja0Sfyz
         0hiltl8dLOzyi7hg/huBhhTlr4ZfFuTWkvInH68IsltNr5HI+5URRaRbidy6ip51Ejaa
         688ZQ+Sqj2n/BnjdZLRgYfnVnHW+zdvVPnuw3voOX/RXBUbjstr7FJbgA9GXz07+nIxC
         qhb6SjgKawUGX/YewVFQ804rUHo5b3Nrs6OsNnELiEJ2JIdyqw6HiI5Y2OujeltCqOoi
         9TpYGlch22p3qgQ6NzWUL4QWNUyDDLCRDQVUnbwPv0C20I6No9J8Llq9Mc8afghYHeMF
         rizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460951; x=1728065751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAXC1jjS+q2JfymL+BkIvB6rw6pd4yUqUxSez452AvA=;
        b=Sk0AOojUFhh6d9CfAaaeIawqH3v20TUbI/tjATODQV1aG9c+Spw8407lTPtxffeHEM
         L8H9w4hM83rQgu0BUxJv3RXPoBRHzj7JdA98F9ASmLeG5t4XW8+2tD2ndLCZWXrdjxsy
         ZwydguXHhg6dtnUd9ms3CioTxqlBtE7Vg8UfzElqyTNL7v5acbMXHM5m5+Etw2XqgjZr
         uWn87qB/6HxjJZYNtM4FRPVbBaxq85ebjPDLsrhXtDIsxh3v7OiZ1k2QcB0PYxvFrsUr
         YLC/SjxyAb6Eamtz1xb5ma6kFdkgSuMa1ClFsEIpNbiPQGp8I3e8e2Dj3ZvJ2MOipZzp
         P+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUFHHheJHgtrpC0Jm6PytMpvA4pQEeHVNSo2nhUmLdJyqDsTrZWgEOo0HIDNOZlI+Ktrz35DSPoSAJh2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycp6JZzzlfgmg9/aJ+vC/5VmDfKHqcOWOx6c1AS3oD26J47OB8
	Pl99X2kx/9EJcz1nbhniTGmNrZqhhQVxVSMgGNLW2V4/LV8WmMVFHHoGLQHyjKA/V+Yg90StvW8
	LCiZk9jQ6pJkXUeACzDLF+a17VXURNh5OBaEZ
X-Google-Smtp-Source: AGHT+IFguB014B6EKl0Q/a5MJW3oPdzwrAqGbr/v6VQraq+wpGBJLmYOKfTJGKUPKSQiOem+2EK4Kwet0VNxh7U+gJ0=
X-Received: by 2002:a05:651c:b0f:b0:2ec:1810:e50a with SMTP id
 38308e7fff4ca-2f9d417a581mr26199411fa.32.1727460951099; Fri, 27 Sep 2024
 11:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926030025.226221-1-jdamato@fastly.com> <20240926030025.226221-3-jdamato@fastly.com>
In-Reply-To: <20240926030025.226221-3-jdamato@fastly.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Fri, 27 Sep 2024 11:15:39 -0700
Message-ID: <CA+f9V1OsZgH37X-zjWqjkjoQwteXg4=n_HyfA_SOWN9YM=GLRg@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] gve: Map NAPI instances to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 661566db68c8..da811e90bdfa 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1875,6 +1875,9 @@ static void gve_turndown(struct gve_priv *priv)
>
>                 if (!gve_tx_was_added_to_block(priv, idx))
>                         continue;
> +
> +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> +                                    NULL);
>                 napi_disable(&block->napi);
>         }
When XDP program is installed, the for loop iterates over both
configured TX queues (idx <  priv->tx_cfg.num_queues) as well as
dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues).
Should add if (idx <  priv->tx_cfg.num_queues) check here.

> @@ -1909,6 +1915,9 @@ static void gve_turnup(struct gve_priv *priv)
>                         continue;
>
>                 napi_enable(&block->napi);
> +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> +                                    &block->napi);
> +
>                 if (gve_is_gqi(priv)) {
>                         iowrite32be(0, gve_irq_doorbell(priv, block));
>                 } else {

Same as above. When XDP program is installed, the for loop iterates
over both configured TX queues (idx <  priv->tx_cfg.num_queues) as
well as dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues)

