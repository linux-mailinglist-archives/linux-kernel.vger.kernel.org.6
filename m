Return-Path: <linux-kernel+bounces-269257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53570942FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77B9B26D15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D7F1B1400;
	Wed, 31 Jul 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wajVT+5T"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D11AE871
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431645; cv=none; b=gyUkCXKM6hzyqdG5TuwO8p6sBIuPhsUkosnYPlMU6vBe4SpRURo4HtxNA6aJAVHy13w8k9dU3i6gQWl6n477x5GtsFYQEIc6CLcNf+/TNXqPfhKxX3cY4NCrNASFILd8ChUpGLP82jzn+zjEGY917djX0tlj9ILf0qoLr58A17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431645; c=relaxed/simple;
	bh=dRUl5uO2/1w2AkZ6UsxlBKx5HK2elVKj2ZXm6+VDf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIeWU+q1MoHj2xFBRzNWYXwk+4ojMtMvoKxCAusWWtZxjRNOCDmVyOOkl7idpFO5FxjaX2ZP+K9XFIOOi23eVKUc5PpD7lVUk2AEtrS6xOUYwinMDhDanY/1Tiy86t6N+1D3BgBprlV+Mg77xfEX+IKO14IRQ6WfKq3AEsQjoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wajVT+5T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca797fso32544615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722431642; x=1723036442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj5Jtjusxp7Zt+Ae/Nq1thR0rw87CuLNCK2IcHdr3Uo=;
        b=wajVT+5TXV0E7emE5d59vtD5Rhl6FReKntrFjykdVUePrHb/s1UqvIgaM2fKPqVO8E
         PTlJnnsfBXVRPxJFJjigmrta0CmaIXD5WdL69Y/VDAccY1WxeV8NFBJqr+g63OswXP8v
         hNhVjs1mE2UQLAnmRO0bmwZR/sUaCYoQXCi3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431642; x=1723036442;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj5Jtjusxp7Zt+Ae/Nq1thR0rw87CuLNCK2IcHdr3Uo=;
        b=P4eQEEJP+D3NtX7uXzVZK5zE714ryBNn0pFMuAfRhAR/ySR0K+ORClG8SIftj43Ruw
         c/Wpnex5dTpbifcT9EohN/RZi2A5ntASZOxAKLMBPALSx3cO6umKOZkH3VcdrUVelTi7
         i82SaQ1OdbeyJlEF47821gZo4LL4QPCVVDwmzdk42X86qZAdC3XCQwoOamq/SqvETA7c
         S42PCjYTFjVPnwb2siBD1c0IAT1gaka7NBU4RObjuwVjh6dEbqmP955sSKQ4PlXdw48q
         KVv8i0rvpphy61T/CmVFirnKX1zMVbs2YNbxCwnTDfEQV4QQ912FMFq9N56qgnNt5Wl3
         /Clg==
X-Forwarded-Encrypted: i=1; AJvYcCUxUcRDAaxUPF1QrPKBnoUprUoFqPGn30Po+Is/75NQiHUFVvBXq155lbipVj546TJoILKpxSfWb4xJ5BzabpMr/DbP5LLnh7xpgfkL
X-Gm-Message-State: AOJu0Yy/cY8yOqfuRKRbjGjQm+loc1q1F9+EETHVbCy+ukBx0cRS59JC
	s89hbS3JYU7b3Cf8nc9kaAbydJgkzEep6e7h481Bpls0ENGBkFoIaTCZv6k/19U=
X-Google-Smtp-Source: AGHT+IGQC6tx/MC7EYcFI4vcnmNoGD0rWPlisuiwk0XIMVJTZY/hSMJAQaLCHm1jOPqmt73OCmxsSw==
X-Received: by 2002:a05:600c:4f0f:b0:426:54c9:dfe5 with SMTP id 5b1f17b1804b1-42811d8c567mr100069335e9.10.1722431642409;
        Wed, 31 Jul 2024 06:14:02 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862516sm16960019f8f.104.2024.07.31.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:14:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:14:00 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <Zqo4mGq88BajjLk_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-5-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:39PM +0800, Jijie Shao wrote:
> The driver supports four interrupts: TX interrupt, RX interrupt,
> mdio interrupt, and error interrupt.
> 
> Actually, the driver does not use the mdio interrupt.
> Therefore, the driver does not request the mdio interrupt.

I might be reading this wrong, but the commit message seems a bit
confusing? If it's not used then why allocate it?

[...]

> ---
>  .../ethernet/hisilicon/hibmcge/hbg_common.h   |  20 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  59 ++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   8 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 189 ++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_irq.h  |  13 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   9 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  34 ++++
>  .../hisilicon/hibmcge/hbg_reg_union.h         |  60 ++++++
>  8 files changed, 392 insertions(+)
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.h
 
[...]

> +
> +static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx", "err", "mdio" };
> +
> +int hbg_irq_init(struct hbg_priv *priv)
> +{
> +	struct hbg_vector *vectors = &priv->vectors;
> +	struct hbg_irq *irq;
> +	int ret;
> +	int i;
> +
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI);

No MSI-X ?

This seems to request HBG_VECTOR_NUM (4) IRQs and errors out if ret
!= HBG_VECTOR_NUM, but ...

> +	if (ret < 0) {
> +		dev_err(&priv->pdev->dev,
> +			"failed to allocate MSI vectors, vectors = %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != HBG_VECTOR_NUM) {
> +		dev_err(&priv->pdev->dev,
> +			"requested %u MSI, but allocated %d MSI\n",
> +			HBG_VECTOR_NUM, ret);
> +		ret = -EINVAL;
> +		goto free_vectors;
> +	}
> +
> +	vectors->irqs = devm_kcalloc(&priv->pdev->dev, HBG_VECTOR_NUM,
> +				     sizeof(struct hbg_irq), GFP_KERNEL);
> +	if (!vectors->irqs) {
> +		ret = -ENOMEM;
> +		goto free_vectors;
> +	}
> +
> +	/* mdio irq not request */
> +	vectors->irq_count = HBG_VECTOR_NUM - 1;

Here the comment says mdio is not requested? But it does seem like
the IRQ is allocated above, it's just unused?

Maybe above you should remove mdio completely if its not in use?

Or is it used later in some other patch or something?

> +	for (i = 0; i < vectors->irq_count; i++) {
> +		irq = &vectors->irqs[i];
> +		snprintf(irq->name, sizeof(irq->name) - 1, "%s-%s-%s",
> +			 HBG_DEV_NAME, pci_name(priv->pdev), irq_names_map[i]);
> +
> +		irq->id = pci_irq_vector(priv->pdev, i);
> +		irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
> +		ret = request_irq(irq->id, hbg_irq_handle,
> +				  0, irq->name, priv);
> +		if (ret) {
> +			dev_err(&priv->pdev->dev,
> +				"failed to requset irq(%d), ret = %d\n",
> +				irq->id, ret);
> +			goto free_vectors;
> +		}
> +	}
> +
> +	vectors->info_array = hbg_irqs;
> +	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
> +	return 0;
> +
> +free_vectors:
> +	hbg_irq_uninit(priv);
> +	return ret;
> +}

[...]


