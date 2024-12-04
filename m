Return-Path: <linux-kernel+bounces-431278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6829E3B73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE611608C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946251E0E16;
	Wed,  4 Dec 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqqzEq5E"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7F1DE4E0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319602; cv=none; b=gN6KSssGE7Lrbt+bmLUWPsCyL8BfBraXJVG3Z9nFgXFag4h3lauzl3z33VQfu9+jx4uOsmLA2FSNdX2YhvVxGTujuj6QPHBGYiPfCCMt4ZdqNhLfGU/KCX/7D+n6JSd7H63OEWwn3ia/a6edKfeoXZtzGirT3xT0uC1jDijPAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319602; c=relaxed/simple;
	bh=dXR/hQxy6alqtubsk2QTUtiJW3+TFICSXnIhbptppC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCWYCNEPHP/VldKNbfk1K7zsFGmWJdIx4aLxah2xpfOwUFPFT68TrYq0ml/zZ0CCr2Ea08JzzYT9eqQHdOmX2prVZg7imhLT6SD8TptYpPWvOClTGTwy/gLuFWrUw1KrHTRdXggmd0ng407a6cLcLhip62NZZnghDt4x4yiDoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VqqzEq5E; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39779a268bso792847276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733319599; x=1733924399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA975cv/VjNdMzrH6rk9INU4ce1m1noL+JfQkgCeIxA=;
        b=VqqzEq5EwtYYFVMYNehtTyVGR+3E1bR8mMtSLGF47kXGueJyHkco2AtSr10TdQ5VxW
         otjw60Ps2d2T4RN0KreDYwfkCERmifbhzwAb27dDeI4yk5y8YoefOIDaP7p2Cqk46907
         2m//amDyTsr/5obcKWcYFsD5YZ5HcByZagwvwg6lMtj6AgCmhRyX42IGM+GTxLaVe4S1
         Q+qXjIucbGpGsOqLmpkXCjGgwjQfqyj22FqpKCzlf2vlddk+UlWronURwh8zhNH0tu1c
         7uEAvtbjX7k2xUbTytPKIBKgr7LUKRQY1/YP99ykyaz8dYfsZ+WZAP435nzfg3aaNxzZ
         li5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319599; x=1733924399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA975cv/VjNdMzrH6rk9INU4ce1m1noL+JfQkgCeIxA=;
        b=pnvdSwStrhjVGrSnrAwG2n82VX9WyS5YESSIQx3rwyy2xb5gN9a6ILEify9BzjW7iW
         vFu5JYBMDcT+PV7UQ9NJv83+7wcis66/rufTfPeA/zir2a1j5u/tTDXFdkTLKzJ03q2G
         ISCPIEafoQK1qS1UTtKDP+XY5TENCJzZnE+5R5hCfD5UuK6nAqK+eT4XTgd081EbQOTM
         MA8Z+V3+1lUzCL3Fuvn33frLyMfarYxRC49FkHSD3qRL+yb7gI+rYLkJvpQrCu7PaI++
         4MPf2a/eoCiEG2N7WUAJoTDzFu2W9iR3Zn9+SyRxhsmeGchYjfryluulp+BKeGsFT28d
         UyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd27R2L2jSLkxQS9Zl515og+N3Px2ajJD+64jZgv7Pg2tc0F/GECuraq5sNMgA6wlhBaHGcaOuk79tb0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqye0hZ5jJ/XbTHKU7maiO7EoLbHgzzfIDjpWN+rebh5Ha2r6+
	DBj6d1CwjqMM9EaBq0n8rjibceNp+ERoHH+gMUYZE1jWyja1l8dBXSyTa/0AssFPkP7qMIT/23C
	yTej0rq/Mlmeavq1jSzGhR3kO+FKOP4CHylYDVg==
X-Gm-Gg: ASbGnctvpUm0Cj62gjeCX9QWF/XIoHrFgMcHhXoKePLj6yw+blSxl5YZ0VwELLgZrVy
	Tr122F0M0ggBjPaycKOIOhqurRt9dDQ==
X-Google-Smtp-Source: AGHT+IHjLCC3ZI6GMy2ysLoHvvgMYW5kv3TIjIoX2VB4eMvHzXE/1pMkunSST1tpmplgwNIZ0BeYOZybXpNKgrzQpUs=
X-Received: by 2002:a25:d846:0:b0:e38:2551:d79b with SMTP id
 3f1490d57ef6-e397199ca75mr23007626276.15.1733319598695; Wed, 04 Dec 2024
 05:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
 <higpzg6b4e66zpykuu3wlcmaxzplzz3qasoycfytidunp7yqbn@nunjmucxkjbe> <052c98ab-1ba4-4665-8b45-3e5ad4fa553b@quicinc.com>
In-Reply-To: <052c98ab-1ba4-4665-8b45-3e5ad4fa553b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 4 Dec 2024 15:39:47 +0200
Message-ID: <CAA8EJppynecscUbUW7Ue=+oYyhFzftiYVgTc6rEuXbUhpxF7iQ@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 15:25, Jyothi Kumar Seerapu
<quic_jseerapu@quicinc.com> wrote:
>
>
>
> On 12/4/2024 6:15 PM, Dmitry Baryshkov wrote:
> > On Wed, Dec 04, 2024 at 05:50:59PM +0530, Jyothi Kumar Seerapu wrote:
> >> The DMA TRE(Transfer ring element) buffer contains the DMA
> >> buffer address. Accessing data from this address can cause
> >> significant delays in SPI transfers, which can be mitigated to
> >> some extent by utilizing immediate DMA support.
> >>
> >> QCOM GPI DMA hardware supports an immediate DMA feature for data
> >> up to 8 bytes, storing the data directly in the DMA TRE buffer
> >> instead of the DMA buffer address. This enhancement enables faster
> >> SPI data transfers.
> >>
> >> This optimization reduces the average transfer time from 25 us to
> >> 16 us for a single SPI transfer of 8 bytes length, with a clock
> >> frequency of 50 MHz.
> >>
> >> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> >> ---
> >>
> >> v2-> v3:
> >>     - When to enable Immediate DMA support, control is moved to GPI driver
> >>       from SPI driver.
> >>     - Optimizations are done in GPI driver related to immediate dma changes.
> >>     - Removed the immediate dma supported changes in qcom-gpi-dma.h file
> >>       and handled in GPI driver.
> >>
> >>     Link to v2:
> >>      https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
> >>      https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
> >>
> >> v1 -> v2:
> >>     - Separated the patches to dmaengine and spi subsystems
> >>     - Removed the changes which are not required for this feature from
> >>       qcom-gpi-dma.h file.
> >>     - Removed the type conversions used in gpi_create_spi_tre.
> >>
> >>     Link to v1:
> >>      https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
> >>
> >>   drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
> >>   1 file changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> >> index 52a7c8f2498f..35451d5a81f7 100644
> >> --- a/drivers/dma/qcom/gpi.c
> >> +++ b/drivers/dma/qcom/gpi.c
> >> @@ -27,6 +27,7 @@
> >>   #define TRE_FLAGS_IEOT             BIT(9)
> >>   #define TRE_FLAGS_BEI              BIT(10)
> >>   #define TRE_FLAGS_LINK             BIT(11)
> >> +#define TRE_FLAGS_IMMEDIATE_DMA     BIT(16)
> >>   #define TRE_FLAGS_TYPE             GENMASK(23, 16)
> >>
> >>   /* SPI CONFIG0 WD0 */
> >> @@ -64,6 +65,7 @@
> >>
> >>   /* DMA TRE */
> >>   #define TRE_DMA_LEN                GENMASK(23, 0)
> >> +#define TRE_DMA_IMMEDIATE_LEN       GENMASK(3, 0)
> >>
> >>   /* Register offsets from gpi-top */
> >>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)     (0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> >> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
> >>      dma_addr_t address;
> >>      struct gpi_tre *tre;
> >>      unsigned int i;
> >> +    int len;
> >> +    u8 immediate_dma;
> >>
> >>      /* first create config tre if applicable */
> >>      if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> >> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
> >>      tre_idx++;
> >>
> >>      address = sg_dma_address(sgl);
> >> -    tre->dword[0] = lower_32_bits(address);
> >> -    tre->dword[1] = upper_32_bits(address);
> >> +    len = sg_dma_len(sgl);
> >>
> >> -    tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> >> +    immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);
> >
> > inline this condition, remove extra brackets and split the line after &&.
> Hi Dmitry Baryshkov, thanks for the review.
> Sure, i will make the changes mentioned below. Please let me know otherwise.
>
> immediate_dma = direction == DMA_MEM_TO_DEV &&
>                  len <= 2 * sizeof(tre->dword[0]);>

I was suggesting to _inline_ this condition rather than having a
separate variable for it.

> >> +
> >> +    /* Support Immediate dma for write transfers for data length up to 8 bytes */
> >> +    if (immediate_dma) {
> >> +            /*
> >> +             * For Immediate dma, data length may not always be length of 8 bytes,
> >> +             * it can be length less than 8, hence initialize both dword's with 0
> >> +             */
> >> +            tre->dword[0] = 0;
> >> +            tre->dword[1] = 0;
> >> +            memcpy(&tre->dword[0], sg_virt(sgl), len);
> >> +
> >> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> >> +    } else {
> >> +            tre->dword[0] = lower_32_bits(address);
> >> +            tre->dword[1] = upper_32_bits(address);
> >> +
> >> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> >> +    }
> >>
> >>      tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> >> -    if (direction == DMA_MEM_TO_DEV)
> >> -            tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> >> +    tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
> >> +    tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
> >> +                                     TRE_FLAGS_IEOT);
> >>
> >>      for (i = 0; i < tre_idx; i++)
> >>              dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> >> --
> >> 2.17.1
> >>
> >



-- 
With best wishes
Dmitry

