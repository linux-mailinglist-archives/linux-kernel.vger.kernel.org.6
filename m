Return-Path: <linux-kernel+bounces-523116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094BA3D22E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70583BDDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704C1E5B66;
	Thu, 20 Feb 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agtM5qoz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7C15A85E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036203; cv=none; b=olOOhcrUZXgQKPCRB2AQx9iKoSWcVT/P09OHBZqtqFteLcRUeCxKePHMF4xYDyFAD0JboibA7W0c2AQrsCWyTa3O1KcGDkDVBfz0JmQrh6Ck7sPYmoKqlCbkORxkKVMCpavcGGyRkTs8lxFXgsIYSXfngKsXQOCi62Tif5hcThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036203; c=relaxed/simple;
	bh=K9ZzoyM+1e7NO7J3zZUXwBhWI7XOqAzjHQnjtaar3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph4Bs8W0C7/eLgLtIPQKWQ3faT/Yotz0BpE+8HcyMXNdWu1mftIy7U5x0lkV2fvspHO6bX2PzQOlMHR1vauXOGW4TCsv+WSNWPgPcRHJt0aBp1SRz8qaybDZx/gASaNVZmdVURgkrwNNgf+YXdPIOPyF1PbOkrWIUWZDTlEc2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agtM5qoz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22114b800f7so9651455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740036201; x=1740641001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MBR10xYOtbIjIrHbSQCuv8sZHXeBgnoMVNUybGZJ2DI=;
        b=agtM5qozeRV1lBkKO8JEekz8289DS0m1DLp0uFYMR9rAJOJw3bZB5H1vYUcZ0OOyqd
         YX/5aPXLMgwb/JTmZ9PB+dDjUQa6f1MO3a7ST7jCUvHF+SqcBEWykwqtLpsyHILyxg2K
         wE+cgorKR7jMmQGHOnPM2rGHp7BrqyVAJb3mKVLzRkbvonI/xIz9YKsN3lgghMxe8hd9
         Wty+AixQLkbAg019zbSleNakrQwFaiN8fGswDJJbwA212EDCMAkzQ1C1aIDTXwScAD9B
         3uPESW7AvdDE5sMBBW/3HoMBefDngooH2bMoL1XyTpGnyEXB94fP8FVpHmvrgnC49owt
         80fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036201; x=1740641001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBR10xYOtbIjIrHbSQCuv8sZHXeBgnoMVNUybGZJ2DI=;
        b=rhv9RlHrqjOS1CjvTuq98HI72m/sC9BPIoAzLD5+VeEaS3RjVEVmKHGmz12roWdstZ
         +ne8JgugWDuTUaaJWKlaP3pJAIjh3xxw3SNhoM0gofH5H8Km5IZ6ALi/rpGZArbls4CU
         o8G6ty3JJ6bOVOnlCij6mpV+kcgdu3NpwRK1E66OaaP8UKVvV4Uw6mITilJAMLU8XR5M
         8CPBfPzdOD9gdjWrxereklNMKiF3q71SXjWFdfZSu4tI+OlcIqThlTPV8+21tFNhnzxj
         5mtC2XEuD5w1rhyiSXaDlxfz/8AmPj8UA2vc+atwsrmm7fzpenOuBNwjgSb/obFdn1Yo
         rbdA==
X-Forwarded-Encrypted: i=1; AJvYcCWTLjebgzMQfQ5GdTZtAq3TqoGl0P8d7AX5MO+joAk7vXQNEvJuVfrAcEA9/bLjTTcNmdkliDqdCHf/oBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++EVfEo2ayp2P2ewpu3htAZRPHJDxyvvw9+mvpPcylycpCdeU
	1/5dBR0+HtM5RBsYZ8DSbn8DVZYSBE/iTHAbN97jb5ovfRbLE3vAEZCXwaVK/w==
X-Gm-Gg: ASbGncvOTElvzZ+3CGAal5ouInyNprudxeqocYJlc7y2vuky1wTHbNECIi6TifG8fC3
	5AdBQ9LSUf9fKFoS/5xBgVsZowgupYuk6ncagrXNhfRtfibIBQKeu21qwfb9ieaMbvEp21mi8oX
	Zadg8iAO/wHJ/x3uEGw5r7pM761uw5uQjN6G6QO9F7BtyY6ffAvOb9jjMQ3/p+pjTDcYc2rMg7x
	AZDjQllswZIlsgJUoyfzqSgwwe8eblOez/LttHviQYuacVYyDiWOEvB2IxuiCtij4qjVWun/tgJ
	5KuqQpnE4zgvaRaZmyigcq7Hcw==
X-Google-Smtp-Source: AGHT+IH9J0UpkJyiDrwNycJp/VSjSgTQ57aAkzHJRzuBfh3r1oEjseg2xJjXQ71AdNSHN8VrWOQlLw==
X-Received: by 2002:a17:903:1d0:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-22170773856mr86334165ad.13.1740036200747;
        Wed, 19 Feb 2025 23:23:20 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f1esm115522325ad.51.2025.02.19.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:23:20 -0800 (PST)
Date: Thu, 20 Feb 2025 12:53:10 +0530
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
Subject: Re: [PATCH 4/6] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Message-ID: <20250220072310.kahf4w4u43slbwke@thinkpad>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-4-94b20ec70a14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-sar2130p-pci-v1-4-94b20ec70a14@linaro.org>

On Mon, Feb 17, 2025 at 08:56:16PM +0200, Dmitry Baryshkov wrote:
> Enable PCIe endpoint support for the Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
> +	{ .compatible = "qcom,sar2130p-pcie-ep", },

Could you please use a fallback? I'd prefer to not add compatible to the driver
unless it requires special config.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

