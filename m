Return-Path: <linux-kernel+bounces-299228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F27E95D1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B591C22433
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC27188CDA;
	Fri, 23 Aug 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBHi8NBK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D83188A31
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427616; cv=none; b=L3uPkcMtZhK0YkCpw9IWnNzx/6QoEd+fBxJNgEQ5svXMFFOFiHehANvh/8oPtB/eWqG3elcUSBYnqipzEVX3tp0kJI5D6A2N9XmxALaZMtPhMC4vB4lGF3+hUWTO8fblS9o1uwHSjqkzxbDWP0dU8kvVzdnYys/DvWwMG3JGjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427616; c=relaxed/simple;
	bh=GaP3IZrd5RcE9Ge4dIzx32rmwqF5NAyUSCzfoCvnFqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e08cRu+AY/0O6qr6yde/8quWRJMjYECI1ZVWLKmvgY94bamTlL/BUPbVQQStoRcKZGzgv0KmlxJqM5fd/KHnaiauKUJlyHOe3KaGS9n6s1V2C3ktRraOz4r+8twIFE+CRdRBjNg8ZtNYhBnE2strPyAIxjGbOZt/gxISGmeiCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBHi8NBK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20223b5c1c0so20382265ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427613; x=1725032413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PswcGyJCTUDaExiPb+cp181Qy+ul9NVt4xbxRyvgH4=;
        b=CBHi8NBK50ce1ZSLXcvgXuFRyvK3+rzQXgSny7GMaTBigXH6bgnAbnvH84FKCD55mv
         3EHyp40zA5RFx+5qXqCPRpgFo0YlORHzAgJuB5QbsdvY+wHkqekT2gstx/ksKOHpUrXt
         bajZAMYUR6CCtn2I/5musaR3pCM/ZttOsKdWQgfm8msehHm9xZkkWvZ0QAQ5lcMGsmZ+
         XBEPAa+kFE0tEQg1YJOrpYRHUXIA4NwwFyGrPG5ncaxf0nedAcfWjbvp+8DImEam9ma7
         DfyQm1/sYphsmSdVZOCC2TgHKJHYbHYnQWbdRDY+tGBIGWAmGMnom9u6lCjCk+qA5NR0
         7hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427613; x=1725032413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PswcGyJCTUDaExiPb+cp181Qy+ul9NVt4xbxRyvgH4=;
        b=X2NnAuCiyDI4RWHlEd+WGUghWL/c7ERzs7ZurwO7CvQnpu5czb6nC9f5Wkjvt325Hh
         x/4Gqymyjc7rBpHcfIrwqSCEvpEpwfFizJxRWPUfZwGbh+Rj866RfIwu3K+9WQdU84k+
         3xN2CuIShqmYhW/Se6EehSDI+LYDgqd6tylbqb2im4SxzPAVBwfCyYNrOUj4Atszw2iO
         s9aCnsO8jUxkbwKioQ7/m0PpY+cbHnt/RAWIYBaaZcBBEbhcJpC1voWkmJ3G7EHKC1LE
         rDXlXMx7Rmc+EQ1HffO6nE0MNmXBBvhIpntc9RmXoOnMEk19GaUYpS3wB98GAMYWbJye
         z5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX27Ukhg0hE4lCNF0S1w0Vv2K7c4NulpYzLDkpJN/O404dHEDAEgJUtRtzdbXT0H1HpHItpcW1T22g2e+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEywNwHVTCNFceIoEAtEdCxFyvM92p99b3HtjBQrwdTDWqqLw
	LJPrQ9bGT0CkhPJPQaL57Ejqh/nrVjkcTcFt+ZABgXTil7BMZW6mdJ5fbPdkiA==
X-Google-Smtp-Source: AGHT+IF74dSdz3Lddcc4Y1HpHeUo4j1K1gSy0t0eup/KCqO1Hsm3KR379cw9PEgNYC8BJ6xrSdPAcA==
X-Received: by 2002:a17:902:e5ce:b0:1fd:67c2:f97f with SMTP id d9443c01a7336-2039e4e7cf1mr23598545ad.28.1724427612976;
        Fri, 23 Aug 2024 08:40:12 -0700 (PDT)
Received: from thinkpad ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556686asm29835955ad.40.2024.08.23.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:40:12 -0700 (PDT)
Date: Fri, 23 Aug 2024 21:09:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, gustavoars@kernel.org,
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, quic_srichara@quicinc.com,
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
Message-ID: <20240823153958.vk4naz34vgkqzhrb@thinkpad>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815085725.2740390-2-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:10PM +0530, Md Sadre Alam wrote:
> BAM having pipe locking mechanism. The Lock and Un-Lock bit
> should be set on CMD descriptor only. Upon encountering a
> descriptor with Lock bit set, the BAM will lock all other
> pipes not related to the current pipe group, and keep
> handling the current pipe only until it sees the Un-Lock
> set.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v2]
> 
> * Added initial support for dt-binding
> 
> Change in [v1]
> 
> * This patch was not included in [v1]
> 
>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index 3ad0d9b1fbc5..91cc2942aa62 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -77,6 +77,12 @@ properties:
>        Indicates that the bam is powered up by a remote processor but must be
>        initialized by the local processor.
>  
> +  qcom,bam_pipe_lock:
> +    type: boolean
> +    description:
> +      Indicates that the bam pipe needs locking or not based on client driver
> +      sending the LOCK or UNLOK bit set on command descriptor.
> +

This looks like a pure driver implementation and doesn't belong to the DT at
all. Why can't you add a logic in the driver to use the lock based on some
detection mechanism?

- Mani

>    reg:
>      maxItems: 1
>  
> @@ -92,6 +98,8 @@ anyOf:
>        - qcom,powered-remotely
>    - required:
>        - qcom,controlled-remotely
> +  - required:
> +      - qcom,bam_pipe_lock
>    - required:
>        - clocks
>        - clock-names
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

