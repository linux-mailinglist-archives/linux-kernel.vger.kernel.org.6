Return-Path: <linux-kernel+bounces-527359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1FA40A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706CA420DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0787207A2D;
	Sat, 22 Feb 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfUqTW/H"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1313C81B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242728; cv=none; b=JBMXL+NXsDTnOmYraYDOZkRVCUzaimRx5riMG3JdM0oOkdzmvHY3MFeBUdbqtp505PkxIwaKlCQ1nap1/Lg/rTEECbiB/6RcvfieJLg8dvZTxmEDF6qnRGFaAmReq24ZiOFQ+YfqUCtZrUlqx6WPJEtHy1Nhn4JEMQXV7StJXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242728; c=relaxed/simple;
	bh=JXFsezySFMvH6dWTeipk0QmL7JcopcvOM6ol/N+7mjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK/Lc6YIZOlEAxoGhmHo/YErS6D8jCxeFA8ZAAN9da5OHqvD2yfuTnbRQT1Up6t933q2uIWvKOZm5wVVH9eoOzLBjVx+j4TBgJBDI41C/7UOaAK6UxsKNRbkvo3Lq93VyPWFwzVzc7y5CbPRUJFNJsP/CcL8DbhDyv/yHEl50Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfUqTW/H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so6299662a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242726; x=1740847526; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZEW2F8jhxjQK9Q9oSPPUZJG+m/4ROcwe0KKWOIKsKM=;
        b=kfUqTW/H8msq+2eH3LjTGu2tcmY+s3vp0m3rAX/IBWSsrPTVCaPf+6aOJ8UhY6nnvH
         +K5zfLAZoIRl8uyIfjNMoTTU7AZJJ0PmUjvAoysdSheT3GDZmnPLZtuI31iwxp/XFEp2
         P0/VMRdyeElF+n414RIOnM7Gh7S9r1xcNqKbNj+HjULJ6z0ScibGXTo/yzeS791PiRqS
         k3qyfUNsPbd3em7xvPFpT36NzvPf9wFWc3NdGdkAusSvHCQHsdm8ms5OLz6QS0GB5iSx
         UZ7JBqA1mllcNJY1++hdlibqCPtGCjlozIu10YTGXKG4lMyZ0Lr7oXFRBNXbgRE9XbrT
         yXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242726; x=1740847526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZEW2F8jhxjQK9Q9oSPPUZJG+m/4ROcwe0KKWOIKsKM=;
        b=QdNuewwgo03xDkLdwXdKQyRD9tpOLgs1kg52Cz1+dqTPMGFReeql3uSOVlG7DAZh5u
         AeeHKxAX+apF8y8QIKUdQ11PP1s0a79J0JIAGrzkJpiCBzCZ4s/3gPkukJGHE140DaYd
         Kh3OwluB7TBBBBCLwWjqsvD13SYigzNaCgaQsbR3s0tsAKn5d9JMpWMUxvc+t5HbPBYO
         zWTqa0ht2LAHiPuLpvus1KIEVr3pyLVWOCDMi2sEjPNFpMtG4JA4A5WDULjANPwiNv6U
         RxMzqr26MAgIYZh/HyjpNiXZkdbMu/jYM05peJByKkWIHfAIPItTxKmOGnXhz4Di1YsP
         xj6w==
X-Forwarded-Encrypted: i=1; AJvYcCX9HATXuAwm+Ixo/YYoz68GIGsypqcsQjOkiXelk6rrcB9fsPRKRFAGFRqXTtIfp8USIYSBa6vSuoiaJLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCgXtzjSOycGUPgQOMWvungPdzwA/OsKpblQlBokbFmN/7xyx
	0sgqs6PGjL7sPEfWyXuSU7UTik5MaiunwQMsthdNmTSZCm4iJdA4xoSGwff7dw==
X-Gm-Gg: ASbGncs4/y3nI8xOXRjYlnhNsCxozt0YsL017o7cnJpUqvzdMThD7V0oMryO5gnmapD
	AFPkCHA+AEhW441KySywksxg1G4TvhJYFAqq6bcR+4gOynQKr/lA7IZZ1PxAbiP9qjJAfEiBApl
	EeiuO/60wPe3g/RY2QD4FEfKXy/ExMZGoGdydfxE8XwfWgWWC3Ve6YHta18NG8K1ha4nsp+/xsE
	d+HTLvn6gmQ0W1nIka0rWToYZa6+8pZ8q6nn4NMijc+skLtyB4QiGv7/NjkF+13mYxx/vVR5q7s
	uqjPcMHYE4MC2l3ysULcTA5YquLSZrBZCMeVMg==
X-Google-Smtp-Source: AGHT+IFefW7NdAtgrUtX0UD5D5oBiGvpdHU/yEEJULTisRJfCVMuYZyWxzWgJKzrin6iK0N9uqtPOg==
X-Received: by 2002:a05:6a21:394c:b0:1ee:c8e7:2032 with SMTP id adf61e73a8af0-1eef52f8796mr10968813637.19.1740242726067;
        Sat, 22 Feb 2025 08:45:26 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73440ea9381sm1325845b3a.157.2025.02.22.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:45:25 -0800 (PST)
Date: Sat, 22 Feb 2025 22:15:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: qcom-ep: describe optional
 dma-coherent property
Message-ID: <20250222164517.2qkzdwofgjdb4yk5@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-1-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-1-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:51:59PM +0200, Dmitry Baryshkov wrote:
> Qualcomm SA8775P supports cache coherency on the PCIe EP controller.
> Allow 'dma-coherent' property to be used for this device. This fixes
> a part of the following error (the second part is fixed in the next
> commit):
> 
> pcie-ep@1c10000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)
> 
> Fixes: 4b220c6fa9f3 ("arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 1226ee5d08d1ae909b07b0d78014618c4c74e9a8..0c2ca4cfa3b190b3fb204f0d7142370734fb3534 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -91,6 +91,8 @@ properties:
>        - const: pcie-mem
>        - const: cpu-pcie
>  
> +  dma-coherent: true
> +
>    resets:
>      maxItems: 1
>  
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

