Return-Path: <linux-kernel+bounces-391018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C2C9B8140
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FAEB23A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC51B3727;
	Thu, 31 Oct 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQpQ/H+j"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6D13D24E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395895; cv=none; b=Q6a6EMcKSnCBegG837vGGaNac4rP62GQuWGuhfA6ISq0YgxTKyHC4EyZfBDVFUvp2sbKi9c7lMo1cnzhm5hawrpcLgzeXAMZLWw3lSiNZI+n6IJR0VYdrrFunJgpjR9R4/WiJ0MNOXGqv9a0DWZDOE9+HzxmqcFPyLDkJiAzJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395895; c=relaxed/simple;
	bh=YUJwsZUfrMySM+3vlPmEDu+Z3Es4dZG8lxvoG9MFcLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg0Bhh/5+6kvNS2HBYORRbSBz6Bn+n6dE6nT3tKfORyC0ieKEuLQI3gZAQQ6Jp7N1cWsetD9clq9FieSRvdYCsqy5kNaPAbAvJdNa7UoQ9ZqmVE7AUT/hB7ARozrT3x+0qtqtaxITor4QkQxqP3e2U/I0PZdT7HnSeN3rRgf1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQpQ/H+j; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so20489531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730395890; x=1731000690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTCMKqDX862JKvIefb6wqPBDi9r52Z0WGiE4eHxFlOI=;
        b=QQpQ/H+jggS218dQc8c6+1DNmwW9WaUW6IZhCd5rr12/ThWUPJMQMXzst019tbxtxp
         JwfD4dgtHA5/e5MQS4KXw628IgZLLWV3TE9RaIwfxWxJ2U+tfEuVEhqM78u6/g+oMlIA
         GdcXdJ6uRRdooLdYZ4JQunC6Kun2f4qM6Tubgiv1kKcZpXz163HrJB87zuQYBu8o3iXa
         tlvAgobib2Gi3CW/cN0nTlidtGN5gdEw3lUkeXmB0LrdTmpCOCCwRUMhUvhOaAf7Bpi+
         gRaQCrEUZqBIT45TuFdqT5hYNvCDpvoZp3L4FdhSuZS2XIZYX5neCACgb2ZIayUGO00R
         Oi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395890; x=1731000690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTCMKqDX862JKvIefb6wqPBDi9r52Z0WGiE4eHxFlOI=;
        b=E7qEfuj8a3YXnUHsbiEQDytKTyG3mmjouFBADzIBgFZy1oIQ7zYobXjvohfUIbM5nP
         ANZ2VcbNzmQk4HP7UY264acyLemY8Gg07MxMMC1BBhcnd/+JQHZkOeFOKI20OXk5Sk4L
         sFTmVkLV0Ng/GekpZzRsscMIDBOpghb+DyX0j4dan+nesTZIW3jm6p0yqoRh3IClY0LN
         OK7F/FecMajpRrhGrtL7QJF5xgjFSztuqhpRKW9OJy75OHSkJ2hYTK3wQ9UUqD2szS4j
         PP/gDf9jVxOsgiqSSmwAQ1s40WrjdOWo/W+8UD3Q83U+tm+s+Cja7Z6sp1pcBAlrHcqW
         mP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXmL8NyU5oXzpRq5sm9es/43193M9wrenBzf6J4KuwBOyLwrh1mkAiJfVTE9kQMpG/sPGMoIEb21uVUqec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinwURRkVECCKO2ZT7UajBcz6r5cLoIxjOSJmdG6i34M1QgM+G
	cD5Wq00IZbDPKinBhuE0QR2aLTjno+gdUq0AeR28iHSPpGKqvow7QEGIGMkETxQ=
X-Google-Smtp-Source: AGHT+IGShhZ+/nEIa9+9orhTu9s2pEivwD3IJg+SgKln+wQA1vTjdlK55q1QgE4C95fqmPAPR065Dg==
X-Received: by 2002:a05:651c:19a7:b0:2fb:6243:321d with SMTP id 38308e7fff4ca-2fdef231473mr10982491fa.5.1730395890232;
        Thu, 31 Oct 2024 10:31:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c3099sm2677191fa.104.2024.10.31.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:31:28 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:31:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Message-ID: <dbwd3eioykfugnmspbkgojxukkb5oafhhq77q3k7tncjkfinqt@xwpzhjscrr3t>
References: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>

On Thu, Oct 17, 2024 at 09:04:47PM +0300, Dmitry Baryshkov wrote:
> On the Qualcomm SAR2130P platform the PCIe host is compatible with the
> DWC controller present on the SM8550 platorm, just using one additional
> clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Gracious ping, the patch has been acked by DT maintainers, but is still
not present in linux-next and got no other reviews.

> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> index 24cb38673581d7391f877d3af5fadd6096c8d5be..2b5498a35dcc1707e6ba7356389c33b3fcce9d0f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> @@ -20,6 +20,7 @@ properties:
>        - const: qcom,pcie-sm8550
>        - items:
>            - enum:
> +              - qcom,sar2130p-pcie
>                - qcom,pcie-sm8650
>            - const: qcom,pcie-sm8550
>  
> @@ -39,7 +40,7 @@ properties:
>  
>    clocks:
>      minItems: 7
> -    maxItems: 8
> +    maxItems: 9
>  
>    clock-names:
>      minItems: 7
> @@ -52,6 +53,7 @@ properties:
>        - const: ddrss_sf_tbu # PCIe SF TBU clock
>        - const: noc_aggr # Aggre NoC PCIe AXI clock
>        - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +      - const: qmip_pcie_ahb # QMIP PCIe AHB clock
>  
>    interrupts:
>      minItems: 8
> 
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-pci-dc0c22bea87e
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

