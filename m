Return-Path: <linux-kernel+bounces-513259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C5A3461A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68927A264B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA2143736;
	Thu, 13 Feb 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpTpMGGF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B4146588
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460146; cv=none; b=EVHa3HiIR1k7SNgPHz7OyhHo6umhVC0tDJeqWs3gmXBFv/4RHz/M7cJ4kENMio8aEPuVpTUZ0L2fuvHmEvFKfYI4v0WU/E6VXZYKQyQ9YmfAjU0tyBQNrfysoTqgs+l06BWLslqRciqiSNOs+nf8oCt9eiSH1Z30gbrLOu+mxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460146; c=relaxed/simple;
	bh=fVVtX3HUcTgbiTiZF7li1VO3hMUCMHwjas9kjcWLS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOVpH4vYuKv1vhZVQESvNTXe//KUkSok78BYmJKHPuB2ZNrBObVtWxXyFFHYbAXUB90wAjbgy8Q/rQ3LXVipRqpQ+Fi9uMETzgqrIlmJulaCnaZeS/jUqeXxUKlKa3wxQyv0QuBckOFKGi2LZbSfCKf3QpjMKRCPh9UR3vudsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpTpMGGF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so217496066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739460142; x=1740064942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKv4T9EGZ11sX6un84F2CqVjaIUgrojaEdOl4TjT83I=;
        b=fpTpMGGF9v/6CRS9dZ0G6+D9wxHtLWLlzceMYcrgH6OFJ4NZpDl6Ek/VNlejHu5ShE
         5r/SSd5tQnUCeSxuvbyjTjfqJewvPKmeSBX0vKhuFOeDHJ8ZC6rbJ4R6xcG0+IhcRbT3
         /ppSwT2jpHXMlxUibk/KKDRfqyNKu8gaI7zNhXlTsM5CIDl9LFaQfabgE4JoRebkDzZ+
         Fc1sA/EvVqClZg3MxWfqsWYku8JcX30Aa7hoCm15l4M2DSt50T7QLI3aOEVUTry4mikn
         4DHSnekMbK3B2j/hFJwhj94W25tkE1KW4jIRlzpgox6bGPL4SvUsdm6KNY4i0mA607wT
         RaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460142; x=1740064942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKv4T9EGZ11sX6un84F2CqVjaIUgrojaEdOl4TjT83I=;
        b=A7Ssq/CWDIHGF1NMWs0bsyVY37ceq4yLI39ut7IKXSKlHYxxkJtz/pH8hUc9vtDe/Z
         5EUUZXS0qBA0jUrQTP568pH0FOKzO7dchaYn7s8pxLC0TX6j0GZ7Iwne+HRivJNvXM3Q
         hEIxSdiDjL155w5LYEJQ6ce5zjL145qsMD5EBfelQ2IbS9PAPku+ZnXT6/93OI75suLX
         obp0VSCicDTLXBLM4i+zd/3H66X6QoRbUKP7Yg+DjU8GWshBoxlzFp6vEyr0a4N5YN49
         Zr40OQc0y5XAdM/5aYKskvVrYvo8hYRhwNYHja7hbwGQGWZqpZNEqkHpe4C0X3VSevPd
         HtEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNHmflUUaQczNZl62RVdTzAF+qYRLTKOOzro6g6EKYLY2Ljvb7ErJhzm7OB9kywOOjeEiRfaeYtlE2NYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBt7M3aQL/NItlX3VEKw7tJ2PHYunkgzPG21XJ86wBd2ldxws
	1CR8LXNQ7zoTwUxXkZDrFxUwss+yq2X0Ylw1uF3OTy3+pXJQSkWtI7nGt7Ybee0=
X-Gm-Gg: ASbGncsOsPl1T7YjhPcbRn3pX3SAgBfr4DhsxSuACuBmDXXYghni3YeOsoJ37F74aDv
	O6tObdWdpsknrGXjzu4XS73UwqjpaXHMEygdCCIfXSZCh3l7bLZyTKdlPyT9mnfk9ssVnCNkF9K
	T7mGZCevBVBPjpyTJVngwEOQ6MCNbMDWHi7sHmLP1n1qQRNELMjqR7RPRdQUKCsWMcoLymLTHZW
	T/nFL74/ae1ZPPW7Pwx+c+Kcaq7+RNGGXXezfwgBvkDbry/P9Qb9aa820+0KsWDCFx2d1YmiqgX
	MD4Dp5Dyhmko6G+BcsKULAOMHoI=
X-Google-Smtp-Source: AGHT+IESTpTFEWvOGpKKzQ4gwb1JLkDFCIgEkd3tqqI05AtRvmxPRwsC4nDvvOfqZzoTZCApQ+e5ow==
X-Received: by 2002:a17:907:3da5:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-aba4eba8493mr379957966b.14.1739460141676;
        Thu, 13 Feb 2025 07:22:21 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:e29e:2d52:429a:d097])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5a4f4cb4sm70935366b.118.2025.02.13.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:22:21 -0800 (PST)
Date: Thu, 13 Feb 2025 16:22:17 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 7/8] dt-bindings: dma: qcom: bam-dma: Add missing
 required properties
Message-ID: <Z64OKcj9Ns1NkUea@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
 <22ce4c8d-1f3b-42c9-b588-b7d74812f7b0@oss.qualcomm.com>
 <Z6231bBqNhA2M4Ap@linaro.org>
 <d674d626-e6a3-4683-8f45-81b09200849f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d674d626-e6a3-4683-8f45-81b09200849f@oss.qualcomm.com>

On Thu, Feb 13, 2025 at 03:00:00PM +0100, Konrad Dybcio wrote:
> On 13.02.2025 10:13 AM, Stephan Gerhold wrote:
> > On Wed, Feb 12, 2025 at 10:01:59PM +0100, Konrad Dybcio wrote:
> >> On 12.02.2025 6:03 PM, Stephan Gerhold wrote:
> >>> num-channels and qcom,num-ees are required when there are no clocks
> >>> specified in the device tree, because we have no reliable way to read them
> >>> from the hardware registers if we cannot ensure the BAM hardware is up when
> >>> the device is being probed.
> >>>
> >>> This has often been forgotten when adding new SoC device trees, so make
> >>> this clear by describing this requirement in the schema.
> >>>
> >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> >>> index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
> >>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> >>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> >>> @@ -90,8 +90,12 @@ required:
> >>>  anyOf:
> >>>    - required:
> >>>        - qcom,powered-remotely
> >>> +      - num-channels
> >>> +      - qcom,num-ees
> >>>    - required:
> >>>        - qcom,controlled-remotely
> >>> +      - num-channels
> >>> +      - qcom,num-ees
> >>
> >> I think I'd rather see these deprecated and add the clock everywhere..
> >> Do we know which one we need to add on newer platforms? Or maybe it's
> >> been transformed into an icc path?
> > 
> > This isn't feasible, there are too many different setups. Also often the
> > BAM power management is tightly integrated into the consumer interface.
> > To give a short excerpt (I'm sure there are even more obscure uses):
> > 
> >  - BLSP BAM (UART, I2C, SPI on older SoCs):
> >     1. Enable GCC_BLSP_AHB_CLK
> >     -> This is what the bam_dma driver supports currently.
> > 
> >  - Crypto BAM: Either
> >     OR 1. Vote for single RPM clock
> >     OR 1. Enable 3 separate clocks (CE, CE_AHB, CE_AXI)
> >     OR 1. Vote dummy bandwidth for interconnect
> > 
> >  - BAM DMUX (WWAN on older SoCs):
> >     1. Start modem firmware
> >     2. Wait for BAM DMUX service to be up
> >     3. Vote for power up via the BAM-DMUX-specific SMEM state
> >     4. Hope the firmware agrees and brings up the BAM
> > 
> >  - SLIMbus BAM (audio on some SoCs):
> >     1. Start ADSP firmware
> >     2. Wait for QMI SLIMBUS service to be up via QRTR
> >     3. Vote for power up via SLIMbus-specific QMI messages
> >     4. Hope the firmware agrees and brings up the BAM
> > 
> > Especially for the last two, we can't implement support for those
> > consumer-specific interfaces in the BAM driver. Implementing support for
> > the 3 variants of the Crypto BAM would be possible, but it's honestly
> > the least interesting use case of all these. It's not really clear why
> > we are bothing with the crypto engine on newer SoCs at all, see e.g. [1].
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20250118080604.GA721573@sol.localdomain/
> > 
> >> Reading back things from this piece of HW only to add it to DT to avoid
> >> reading it later is a really messy solution.
> > 
> > In retrospect, it could have been cleaner to avoid describing the BAM as
> > device node independent of the consumer. We wouldn't have this problem
> > if the BAM driver would only probe when the consumer is already ready.
> > 
> > But I think specifying num-channels in the device tree is the cleanest
> > way out of this mess. I have a second patch series ready that drops
> > qcom,num-ees and validates the num-channels once it's safe reading from
> > the BAM registers. That way, you just need one boot test to ensure the
> > device tree description is really correct.
> 
> Thanks for the detailed explanation!
> 
> Do you think it could maybe make sense to expose a clock/power-domain
> from the modem/adsp rproc and feed it to the DMUX / SLIM instances when
> an appropriate ping arrives? This way we'd also defer probing the drivers
> until the device is actually accessible.
> 

Maybe, but that would result in a cyclic dependency between the DMA
provider and consumer. E.g.

	bam_dmux_dma: dma-controller@ {
		#dma-cells = <1>;
		power-domains = <&bam_dmux>;
	};

	remoteproc@ {
		/* ... */

		bam_dmux: bam-dmux {
			dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
			dma-names = "tx", "rx";
		};
	};

fw_devlink will likely get confused by that.

At the end my thought process here is the following:

 1. BAM-DMA is a legacy block at this point, it doesn't look like there
    are any new use cases being added on new SoCs
 2. We need to preserve compatibility with the old bindings anyway
 3. I trimmed it down to having to specify just "num-channels"
 4. Everything else is read from the hardware registers, and
    num-channels gets validated when the first DMA channel is requested

I think it's the best we can do here at this point.

Thanks,
Stephan

