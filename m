Return-Path: <linux-kernel+bounces-547470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F0A5099B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A4C169042
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF0255E51;
	Wed,  5 Mar 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yM7PyJ8X"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D6255E53
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198713; cv=none; b=gKRuge8XSi9wUvashcAwSvP0Xm9VJwbXfsgzUDwJP4JH2R3V6XVYq4y1QtEMwnGQzcfRqI0e2Cl87hSk/89tPzD9yVLnGrB7zfD1wfittie2Nb49buur93kbj3F3yJHMFhtwxDzxACcLv+UeLGFNRYERWNk4N3M2jefWps+l48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198713; c=relaxed/simple;
	bh=CHVPeNV4aZlMVIMSYfYeSO8Ba+Yk0fM8VLR/eAjSu4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCVBscya434vfX/OAVLI7wkrVbOEnWvuCh4d98wWAlyEV80kIXqinuK+PkmWRq3X3Z+rv4MAt4d3p3oC3911vvp3vNQS/vc/482xFxzLl/redig3/JmZKMdlo8mIqF0vdGTnwPJGWPt3TqSCoxDi2CvG5fRkx6lt9XPA1huP6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yM7PyJ8X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22401f4d35aso12832985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741198710; x=1741803510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqKBFVD7BmtZnDhxGEB2Az6asxUlkas0B0Pi0JaurnM=;
        b=yM7PyJ8X4kk63j4ccy9lJ0gMgtJ5teBQflWki6SSlA+gugv6ZOhbi+XXFQnSP3f1TJ
         Z6U+mpkx5qRk3MRLL/T0XZggZBuCa6Pobkf+NSrBNmiIkDbs6HH10CDpdor79mZdafrf
         SHw8QZHVtJt7ODMkHICpOHoBneG+dhYOCD9o/o2koj8poTkM9QegttakW7r7Q5uS8X+8
         vPULZJ+wCAD1j+yTbCg+0tEIlNNdtPsmDRFpR1uphrFUzVLgVgI02CU1fj62ltwrRYuF
         whdZeqfJOAmdV6DOr92JhLy6vz20mO099Zm+USL434UxpcOjTRiyIgxFwPhq+vcbHIwu
         fqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198710; x=1741803510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqKBFVD7BmtZnDhxGEB2Az6asxUlkas0B0Pi0JaurnM=;
        b=Ua6pLNG8daoc5U8994xwFxhX14w0q2i0zNrMLHLkiErEhTAOcW2WHVr5raazpLYtnq
         ateyh1PGd6iroVyzenwqcbEy7zRug9frjpinSM3HTxHcKLm52s6i78OAwjE0Gnd9zFkP
         8qdYXQapaHc1bhIYbWZWOz1lhjnI9s1dvT2HR3W40D7lg7ugXpR5n49VX3t69tjkW+PL
         HtV0VLyQOr7jTFtP9MpAfFb+PoEYh8XXoxS1SqQj9nHGTenNxOdIWqM29re3OAwBD2bF
         YOb8uzgm74yzZUWHKblh7fQkKgRU7J5wxaHRCj/CGtLI3NJJ0/3MHy5FPjBKWYBci99m
         Djmw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQ2+URGpWwbQXLRvUWDHcpnQR6kDZ67cg96HNMURRPgA61pb12wwPUWW8zRYpfR7rFasEm2xrJI3phEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSfIACVyV5r7EV6qRQtOV6DIZcItIYhlFnM0UaRzQJvHMjRvd
	YHdiFR58uCFlhmM0g9awSlg0tadz7r9llpKBcN5kr0aHP8IpfOAn820uPSMRew==
X-Gm-Gg: ASbGnctEJIED+sM95oSNYa/CLD5LhPXJuC28QAA7rc00oXWbOcixxOCArvutGiNOd5B
	tMnB1tOo8X/RlXEFEJ0FaJB52BOT+Wag9Tsf+uloFJ+o7mfAgQKtaKqX8g3uLQtHd7oKVQtOnke
	Lv2xtZnQG+iQWHCgI7nmjZ+epEhRu2azMsXeWPHqn1b/9wMiw6UHeaMTNbidH5eTyKHLgynByE2
	YNVhD4Bxi8JLsnM9ue073Vzsr28TvZSpomfV+965alnYoG4vbj8UjWzimyiZU/CFN4yYgYQKkl4
	fLKzCydjQWgCO+uzxkALDPtm/E8UUsAnOL8vXORFMyBzBl9WerCVmxzr
X-Google-Smtp-Source: AGHT+IHTeeIhNi/0pb7+gb1R76gjf4Wb38QT5wJFtMtan4n6WS8u6zPjBJy02e3tGW2OydQi15Tvtw==
X-Received: by 2002:a17:903:240a:b0:224:6a7:a5b0 with SMTP id d9443c01a7336-22406a7a82amr15559775ad.2.1741198710127;
        Wed, 05 Mar 2025 10:18:30 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350514239sm116134605ad.219.2025.03.05.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:18:29 -0800 (PST)
Date: Wed, 5 Mar 2025 23:48:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 3/4] PCI: dwc: Reduce DT reads by allocating host
 bridge via DWC glue driver
Message-ID: <20250305181823.ltm54e4yxaj5etw5@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-3-94b5d5ec5017@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ecam_v4-v4-3-94b5d5ec5017@oss.qualcomm.com>

On Fri, Feb 07, 2025 at 04:58:58AM +0530, Krishna Chaitanya Chundru wrote:
> dw_pcie_ecam_supported() needs to read bus-range to find the maximum
> bus range value. The devm_pci_alloc_host_bridge() is already reading
> bus range and storing it in host bridge.If devm_pci_alloc_host_bridge()
> moved to start of the controller probe, the dt reading can be avoided
> and use values stored in the host bridge.
> 
> Allow DWC glue drivers to allocate the host bridge, avoiding redundant
> device tree reads primarily in dw_pcie_ecam_supported().
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 826ff9338646..a18cb1e411e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -484,8 +484,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct pci_host_bridge *bridge = pp->bridge;
>  	struct resource_entry *win;
> -	struct pci_host_bridge *bridge;
>  	struct resource *res;
>  	int ret;
>  
> @@ -527,7 +527,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	pp->bridge = bridge;
> +	if (!pp->bridge) {

'pp->bridge' is getting dereferenced above as I indicated in patch 1.

> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge)
> +			return -ENOMEM;
> +		pp->bridge = bridge;

There is already a previous devm_pci_alloc_host_bridge() call before this and
you are just duplicating the code here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

