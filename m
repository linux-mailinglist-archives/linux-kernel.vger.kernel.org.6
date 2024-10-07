Return-Path: <linux-kernel+bounces-353292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D604D992BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0152F1C22D94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225131D2B2A;
	Mon,  7 Oct 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="IdYVVxsY"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8851D27AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303909; cv=none; b=GIsPe2g2H4RTjLMEmXls+/jbyG+yTrhAV5qQa7Bm6pn4xoShdMsmxEHK7THkmUVMrC5DRkWVjcNSL2fLhdfkENV0DBhfF4rmUIENqSWaEOkxcTsvrM8jCTmoqHIUyEbMN3DR461cjGiQ2rfFnzLNaQoeh+2Cdjsd+kc5rxBDdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303909; c=relaxed/simple;
	bh=Yqa0XvNtnjZsPKDcT41xGnEWosRzzxdqRW0lD1BJnpU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=C1Wv8tXMYlw32wkInfQqdNrt7JzIaa/ZEET9+HqGnYIpG1mBuMn69Hnuez9swYXs0VGkq56VG0fxiz5m8ba8f4xjDRSNTWV97ntgY8sLoMDWhLGsSh2yN47030+q40vviNZP41JWC2h1ndFd+8XD0KVnuVsYpmnR+IpAfC5z3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=IdYVVxsY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea03ecf191so1080891a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1728303905; x=1728908705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gM96gy8f618bGBajVDpCaKuepjJ0dpUYbsUw4JQ//R4=;
        b=IdYVVxsYW0MXzv3Pg5jxERbzT0O0NRLhgffIbl0fNzjqG8DUySk/f8oVxbK3InLQMQ
         9/bWLyboKvCW/GCjsCg5h1uFeDPg5f+rBGw4fjYuUrHPvOHZ8H7A0Ud1jpM/0DWt8ZtK
         oRmgA1u/LyPcU+QqNwij0UVNUiB1WxFVGHValOn8cfi+GPVp7xGsPG6b+Pe0P7DvuRAH
         fpuwowQQpa7JD0Dn7usdC4MvnVW+18qZ8a9INISZGfSZjlReXaD7dhLmBx/PsbGkIIuV
         HW2dFhixpoVaTKSc9nnVZHgJ+ebUcBGA8uWJVpZJIrAmm6iji0NILgOuvXjAVz/wb64T
         Bqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303905; x=1728908705;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM96gy8f618bGBajVDpCaKuepjJ0dpUYbsUw4JQ//R4=;
        b=oysQbuOtV9sy08rHvLlvY52Nj3IqzOiXgZhaFsdX6UcObzZS2BbQ+zjWkqszM34smM
         GKcFb6+3W1dHYpsuBXsmbz0umkKMk+Q0NwAOKciSegzf7WY2l19GKZKsCKd1CrluRE0d
         dPvIrKMcf+vg0Laohalf/N2AYn7jCtzjcQd8yat/jnnaYhPsFn9bfq4I8PEBXJNrdiHE
         2AzreGp0+1o3jf0r7MfLFFd9BhPuux2KMCm25rt6eHxIQDen7KBPBXNVsPb66+Q3sRnw
         TkqR3fte3251S56VMv0LMB3ZIESXXuUX61d55Eb/Y2iJ5fZYjR8BeHDLenFiKuM+d2O2
         Qkdw==
X-Forwarded-Encrypted: i=1; AJvYcCWqlIKP0n6aKemCbpI34tuF1q8mOrvaEVVCbRr0whLH4RxR4nDY4YcXohSU5T4pT5zwZlw0U0HASY7ZNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/lDMehpPk2chGT8zMiRq3/d9xaLKzQIXcsipCOVm/z1OFmtH
	b+tbSan3I/CSri3M+wwVQar7wSpUa8/RNef368D44wIy3m1sqAkr7ciUucMhcTs=
X-Google-Smtp-Source: AGHT+IHzmdeyk7BcbsepBbIRiOyd9bViCdVFyVoSqlIqtw/HHX0y/avV8U1WcrVmd8PF5MvJp7Tjrg==
X-Received: by 2002:a05:6a20:d492:b0:1d6:5054:a02 with SMTP id adf61e73a8af0-1d6dfa24d0amr16925290637.2.1728303905288;
        Mon, 07 Oct 2024 05:25:05 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66695sm4409586b3a.174.2024.10.07.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:25:04 -0700 (PDT)
Date: Mon, 07 Oct 2024 05:25:04 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2024 05:25:03 PDT (-0700)
Subject:     Re: [PATCH v1] dma: fix typo in the comment
In-Reply-To: <20240918034114.860132-1-yanzhen@vivo.com>
CC: vkoul@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  samuel.holland@sifive.com, michal.simek@amd.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com,
  yanzhen@vivo.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: yanzhen@vivo.com
Message-ID: <mhng-8b05e8aa-ec7d-4ccf-883f-5e88cd86ad4f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 20:41:14 PDT (-0700), yanzhen@vivo.com wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
>
> Replace 'enngine' with 'engine' in the comment &
> replace 'trascatioin' with 'transaction' in the comment &
> replace 'descripter' with 'descriptor' in the comment &
> replace 'descritpor' with 'descriptor' in the comment &
> replace 'rgisters' with 'registers' in the comment.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/dma/mv_xor_v2.c         | 2 +-
>  drivers/dma/sf-pdma/sf-pdma.c   | 2 +-

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

for the SiFive stuff.  I'm happy to pick this up via the RISC-V tree if 
people want, but it's mostly for other stuff so I'm going to leave it 
alone for now.

Thanks!

>  drivers/dma/sh/shdma-base.c     | 2 +-
>  drivers/dma/sh/usb-dmac.c       | 2 +-
>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index c8c67f4d982c..c6c9702dcca0 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -635,7 +635,7 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
>  	writel(MV_XOR_V2_DESC_NUM,
>  	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_SIZE_OFF);
>
> -	/* write the DESQ address to the DMA enngine*/
> +	/* write the DESQ address to the DMA engine*/
>  	writel(lower_32_bits(xor_dev->hw_desq),
>  	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BALR_OFF);
>  	writel(upper_32_bits(xor_dev->hw_desq),
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 428473611115..538a7bc58108 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -354,7 +354,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
>  	if (!residue) {
>  		tasklet_hi_schedule(&chan->done_tasklet);
>  	} else {
> -		/* submit next trascatioin if possible */
> +		/* submit next transaction if possible */
>  		struct sf_pdma_desc *desc = chan->desc;
>
>  		desc->src_addr += desc->xfer_size - residue;
> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index 588c5f409a80..fdd41e1c2263 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -961,7 +961,7 @@ void shdma_chan_probe(struct shdma_dev *sdev,
>
>  	spin_lock_init(&schan->chan_lock);
>
> -	/* Init descripter manage list */
> +	/* Init descriptor manage list */
>  	INIT_LIST_HEAD(&schan->ld_queue);
>  	INIT_LIST_HEAD(&schan->ld_free);
>
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index f7cd0cad056c..cc7f7ee7f74a 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -301,7 +301,7 @@ static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan,
>  	struct usb_dmac_desc *desc = NULL;
>  	unsigned long flags;
>
> -	/* Get a freed descritpor */
> +	/* Get a freed descriptor */
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	list_for_each_entry(desc, &chan->desc_freed, node) {
>  		if (sg_len <= desc->sg_allocated_len) {
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 9ae46f1198fe..18a407975e14 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -366,7 +366,7 @@ static void zynqmp_dma_init(struct zynqmp_dma_chan *chan)
>  	}
>  	writel(val, chan->regs + ZYNQMP_DMA_DATA_ATTR);
>
> -	/* Clearing the interrupt account rgisters */
> +	/* Clearing the interrupt account registers */
>  	val = readl(chan->regs + ZYNQMP_DMA_IRQ_SRC_ACCT);
>  	val = readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);

