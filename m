Return-Path: <linux-kernel+bounces-558801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAADA5EB65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D41775FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4A5474C;
	Thu, 13 Mar 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwX7igfa"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39F17E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845651; cv=none; b=mH9WwzhLw2qkHFAauqfAV7D27UZz7hq+rdhl0ipU4NOpN41PMv097IB0FtvuK6y+CF2bnVclCQN1J/1mcKhnVi+kU1RuDW4FrHPg53ELj0RaiXlL9fi7fKEYZW66OBKbX0Qp2cdR2Kr37n/BdBmZR59oeLINWw34WOil/QHknl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845651; c=relaxed/simple;
	bh=QW70e1/mfz3TjZGJIpQD+B6tcZSkZLU5rl5INwW+S3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+D/pWhXG++iRpcEGx3+y/Q/241vbLViDn1BQTcJJG0gDaHwC+ZRAZgONs42qz5Kx+1CICXOyYl0hgOTqH+LWdvMB23gfXQwOzSvgbSGv+TrU5B8+oXf+iL/MBAE7X1OoM6BOqwbQj92Rl09GfoS3tsELWwyRZYLvPFfJPaHibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwX7igfa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so1383257a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741845649; x=1742450449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BR/Nog4BFFAbGskl6Y3iDgtMEiZ/gcMqksEKy4uZav4=;
        b=dwX7igfaEgVa/tiCi+qwyafZWrTRBFaNflH3xtIKo5wv5qj5djlA+36KcNQCdgtEW3
         SlCfu7lyMcDc2/1ZX/3REK+05elnamA2XbdbHFuHf8pB5nN1k8uqY+GX+PaZbX9EdwKS
         m/9BhdUNDwOliS7opGV2o+OWXr6kagjjD7Yu3g4xvkcbqJaqaqpWxHL0JUaZ33ptjgPV
         8mM+VhRQA1S0Dwcvq7ioQouQt73CXL4CWZ85GTWOOR+d3vN+fBLFUSIHtyfMKrFv3GCM
         lFw5FVtltHBACsq8hthZ0MG9KgpAJO2UlkrQeq0PIr1Jlq0CsjF8K7Ru3mQdUUIxUqcw
         Al/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741845649; x=1742450449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR/Nog4BFFAbGskl6Y3iDgtMEiZ/gcMqksEKy4uZav4=;
        b=KACvjOU781LgauDXrbzLozKxzEf5k3SIgRG2kG3afUqi/kymCkzvy56pwhX4dBAet8
         /ReG+7ihb2sVnhuvqEXwxSpagVintXZDjCuj+DVQTvxNMiMNuXfssEbzUi/4Ux7bYiqw
         ux8B7eXswaZ2A+K3Gudv57/gWO7T3Md+PnobOl1MYWHbCEGbiT3hfCoQwSe05vEEqn8t
         ZIvhUTEd1t02GPKxIKg2gZ0/elhWMmGpeY+mrqDlfOAtaT8M2rwsKz2/J9KclTQSXTvs
         AeC2UERKiTQYl3J/iSdjh7JSQv1rM0uQ1WJoIaON2GPiiYKsof+K6dnYAcfuUd0VOIf8
         cQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMzDj9NvbK5g/jPk+xfkuNXyFPCPtCB3XTyoMLdIRpr9qQLoDrgjDMuEBf3lwkx8gmA47EhSCOruvwJHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9JTJgrBBJvcubOC6avxUWIjoy6BLviBROhNOBu3DP2yugg6j
	DHfJ7KEkgF2AQMWK1nxZb5yJuqj7UzKaLK9SUvjMyYY0BUIHs9yYoLSJ90Qhyg==
X-Gm-Gg: ASbGncun6iSapTDjmWyNS1TcDcDys20dtYhrplKhxg2XQzTUDMwxWtsh6jqHuSmbYvg
	HTQv6uV0/lBMvBwOvSDiSecNYcSyV7enDhjjgDXH6Tp6M+7aDidJqKAmTu4qg1XSychh3dCkE9O
	ZGztJoWkGZChh91E77PtPOqeqHWf2FvnOeZ7QBL8YBB/PjdDv9Egxs1VfWfmIvjjcW+cGlRDd8B
	f4yiFTuM5Du2IrOhYkttd+T6sToKzUSnggs9kbOorYzbdoO+5xF8pm5bWGK+x3GRBlzFRUarFLq
	ZdZBkFqyy9rhOgk/B2jjDvE5T47dYF+Au+/n3NR1I4lX9yHSC88dIA==
X-Google-Smtp-Source: AGHT+IHd7v3l5gC+ULRc3VvMD4ILgDoSZwbG5Pc5B7gUogOGvMxCnx3dXhAQVvQfzF5QcQ4WhJ3dFQ==
X-Received: by 2002:a05:6a20:85aa:b0:1f5:9961:c29 with SMTP id adf61e73a8af0-1f599612c17mr9615691637.21.1741845649523;
        Wed, 12 Mar 2025 23:00:49 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711578d15sm527696b3a.82.2025.03.12.23.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:00:49 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:30:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
	kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	kw@linux.com, lpieralisi@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 4/6] PCI: qcom: Add support for IPQ5018
Message-ID: <20250313060041.27fdpovo6kerlyft@thinkpad>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883AB310FF217F669FE32939DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR19MB8883AB310FF217F669FE32939DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Wed, Mar 05, 2025 at 05:41:29PM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add IPQ5018 platform with is based on Qcom IP rev. 2.9.0
> and Synopsys IP rev. 5.00a.
> 
> The platform itself has two PCIe Gen2 controllers: one single-lane and
> one dual-lane. So let's add the IPQ5018 compatible and re-use 2_9_0 ops.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e4d3366ead1f..94800c217d1d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1840,6 +1840,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

