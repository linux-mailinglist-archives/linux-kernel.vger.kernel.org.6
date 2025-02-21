Return-Path: <linux-kernel+bounces-525283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD27A3ED8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE00F162FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABA1FF603;
	Fri, 21 Feb 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e41D1kQJ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0E1FC7E1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123979; cv=none; b=KSkys4+X6xEYjYKvKq6QTHxICxRGnzWwwnATkQuqWDh6a4qYo+TTT1DScGnGEF96dZQq/Cl0c06F0GGTqPI4BVB8/dkeZi+ggBCpjQwr+oBoiJ+lYnYNY27krF0hcTlBsA15E/wMI2IlfyFjlxFCHvktwPL5cdIQ7ZNCEyF7yVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123979; c=relaxed/simple;
	bh=15kJdrGugNCyBZCd3hkQAU/O9pRiD9fSMU3sdCLXfRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1AjHJ1aev9lTbMRu/vmlLa10PA0twUPh/8s75/uQ6Rx6X523cBuAoflWiAXFo6JBG2i46mO8OFIJdAd+AVkvP1PaH83ivtxee2YcPSEZUFERDA9rpblFmTmtkmfUN96qRdAq1pE+XRUf18TLbDkNoRnVe6P3nBfWrlsBO5aJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e41D1kQJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso3715500a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740123977; x=1740728777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W77LxlS7MD/VYmAj+e6BZAmOfe3ALYLjxOq2cQmMZGE=;
        b=e41D1kQJpt3IMoEEGTIBPMQafmxVTgpYiRsrS0euMSniqRh3v/6aqFEkrReTMAHxqk
         MVYx/WWtJlLRFxF2JuR8SKRngBEW1+T7cz5foagb44qBBOQzzjHtU/+QK0DaW020S82P
         icLaykQoRU23/VjUof18kbyz/v+vAHkeEMsX8NsLKMMxwVefjubsfFQwFXmb4qL8xWKV
         ZWXA3+aRMgYv08eCxf3UiY3nvkrCOKN0BwvZhOWpSI6/ExUvE2/QcQhyYMFMFq5d/fZD
         F1E1ef29ZeisHDoDFk2KX+I8xlkJZfCpgyJ4h7H2qDq/anepM+/UUkz+Njetr2DyMcvc
         1iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123977; x=1740728777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W77LxlS7MD/VYmAj+e6BZAmOfe3ALYLjxOq2cQmMZGE=;
        b=bNLsNsuyvRvJFZIuL6yQhcWc/CDsJxy4LAe7yBWb0vAB3PuKbamDyDBZZX2HOOhrw/
         A8txZ6YWR77Sa2JIPsi7fhV2SGbQJYXpScyaZgbLEST4pHqMr2QhB6N3jP6GWRL660+D
         S19Pq3ehTb6OO+IgQq50GLXNbnjiyHuRncUMGY8LJ8VLrgMDka2H0dfzd/Z/YUK/YMRN
         YLB+wrYxWXhmKBTwg7MVTgpMkzn2OzDNd9LOOTgWUIRYFo/J2M1zV4DN7T2i8Xohxuft
         6Iim/7HnuSsQD9P3ldQTkX30meUXoujUBpcZwHHskhImhlaMuGWSt9+JQg87ROgpTxY9
         3pzg==
X-Forwarded-Encrypted: i=1; AJvYcCUP/hlBUQ5tDTLtQbDfoHTrpABwWKfitNIFr5oTGCn2KRhj8ZbaC0hjsCjhRbMQkFgCp5y3k8oMHAQkHXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DkA7lFPCMNhj5Ysv4/SYJ7e4myIkSRkNTcppOm1773EO31yV
	rJtVmZYP2T1TvCPgU/LGLz4UFr2Z8kA2BC9ncSiGyb/r54Fx/MHyNX1jgVzq1g==
X-Gm-Gg: ASbGncv4JaA9anj8diJ7a6Tsa7GHsyLxtv2ZUYRzi0EpKbNYZSh1DdxwB0LFBqfih7+
	HevDaxptDeF0ygpkKWQUFuz+Q2ecEowHQM3yTOwo0fZbbTbN94/dHVsZo8r3yrt0ftNA2w+hWkj
	X2tRgS6TvXSzw6yMssd5Pg1f2lHBMBwwWobMFQqkwPY6ELmgAaX0wBQvtmUEfugSxsdW7Fz04+0
	SE1xSFhs159wWWeJ4NVcRH/Z6ZAd76SdTElR2E2noh8CZ6OG7l9ptIFCGvtFhe298u6259sC0X6
	u8+xDODJPmq4PsHbf1eFon5ujkraY3FnnLc=
X-Google-Smtp-Source: AGHT+IGloBwjW4bmTnHHzw09joa9kz+Cz6C+RY5wvXaG8H6iqXQF4ygMPtRIByZEiZu/fnr6k86PYA==
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id 98e67ed59e1d1-2fce7b2c06fmr3213561a91.34.1740123976794;
        Thu, 20 Feb 2025 23:46:16 -0800 (PST)
Received: from thinkpad ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d7cfsm750285a91.4.2025.02.20.23.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 23:46:16 -0800 (PST)
Date: Fri, 21 Feb 2025 13:16:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Devendra K Verma <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, michal.simek@amd.com,
	linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] dmaengine: dw-edma: Add simple mode support
Message-ID: <20250221074612.dzbyiqet4jyvrdab@thinkpad>
References: <20250219110847.725628-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219110847.725628-1-devverma@amd.com>

On Wed, Feb 19, 2025 at 04:38:47PM +0530, Devendra K Verma wrote:

+ Niklas (who also looked into the MEMCPY for eDMA)

> Added the simple or non-linked list DMA mode of transfer.
> 

Patch subject and description are also simple :) You completely forgot to
mention that you are adding the DMA_MEMCPY support to this driver. That too only
for HDMA.

> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 38 +++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 59 ++++++++++++++++++++++++++-
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 68236247059d..bd975e6d419a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -595,6 +595,43 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	return dw_edma_device_transfer(&xfer);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +dw_edma_device_prep_dma_memcpy(struct dma_chan *dchan,
> +			       dma_addr_t dst,
> +			       dma_addr_t src, size_t len,
> +			       unsigned long flags)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct dw_edma_chunk *chunk;
> +	struct dw_edma_burst *burst;
> +	struct dw_edma_desc *desc;
> +
> +	desc = dw_edma_alloc_desc(chan);
> +	if (unlikely(!desc))
> +		return NULL;
> +
> +	chunk = dw_edma_alloc_chunk(desc);
> +	if (unlikely(!chunk))
> +		goto err_alloc;
> +
> +	burst = dw_edma_alloc_burst(chunk);
> +	if (unlikely(!burst))
> +		goto err_alloc;
> +
> +	burst->sar = src;
> +	burst->dar = dst;

Niklas looked into adding MEMCPY support but blocked by the fact that the
device_prep_dma_memcpy() assumes that the direction is always MEM_TO_MEM. But
the eDMA driver (HDMA also?) only support transfers between remote and local
DDR. So only MEM_TO_DEV and DEV_TO_MEM are valid directions (assuming that we
call the remote DDR as DEV).

One can also argue that since both are DDR addresses anyway, we could use the
MEM_TO_MEM direction. But that will not help in identifying the unsupported
local to local and remote to remote transfers.

I haven't referred the HDMA spec yet, but does HDMA support the above case also?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

