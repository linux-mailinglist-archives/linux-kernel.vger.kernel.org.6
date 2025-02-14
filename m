Return-Path: <linux-kernel+bounces-514660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37DA359F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB0E3B0239
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A023A9AA;
	Fri, 14 Feb 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZOurBty"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26322D79E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524202; cv=none; b=C/kdmcW9gWBI2a/bsvEixdbvz3p0Qr8IK1z5ctAk4PQ0Q8wiBi54sgxyFCDZNNeuxaYTK7lVE6HO13p6L+uXngeP9y4PwkmoupnHNDmdvgePr+qAse44sJ1EzWyNLbb4FvMObAthQNo+I0N6m87nCS7Y/xMEF44xn/HCP90VFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524202; c=relaxed/simple;
	bh=N4eOnD3GtDmNYGthYNp/L/XmCMrtB0M8KXGq6KPdj5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlOsVRmkwcojvdpuEfqy2iDPcpJLgzoTcqhLqEB/OSNN8kSMu5/gYf9v1b33NhEA3M4v+YS/3WoDlZEi2ek6rliNiuK3XNhv15eHKPvnPlUWZeZmh/U/MFkypLUlNKePfjALhovMYCL+Np7ZceSEnQl6TbtEYXNCfT117JGB8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZOurBty; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f92258aa6so47608655ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524199; x=1740128999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDOwS29r7yjYDHoxE1FdUk9ssB187ur1mILgL3ToPtg=;
        b=LZOurBtyvE0ttfl+FO3la5OzB4xT2tB6t2yvOvsGQNWtwkZBbQgdgbgE3fBiT8M91N
         m1pnWFqNQeCQqt3+9mYKGXHThYOAWU+TRvFZn2TZnTSqaShC/M0RwdY61FB7rcJwTrKP
         /7bJRAjm5Wfbro0aLfxKOJHhyuikjhM0dZe2kHkhMRx54aKhspKuys5QnSAv7N5aJpJf
         WehJ0hQFoq3l6gHIZ3V83ZxnJP1XqM/X8qtw/C3ncKiUK8u9bBniu6Axop1qoVnpZG4K
         HQq4GK17iVHvKryS+IUwtYBaMCqVLMDlghpxINEEIgOvxKiiB/giIKYKjzSqmPtAItcq
         Td8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524199; x=1740128999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDOwS29r7yjYDHoxE1FdUk9ssB187ur1mILgL3ToPtg=;
        b=e+4n6pK9jPc2sr1CnMumcoeTNsmZB+/3V+3KL3ndgDOQstgG7CA+lvBZUELVga35vQ
         l3BtztFKWdkCvphGrnS5Gzy6JP4tajYRkAH2TA7q7/w9xyUYyFlYPItBlE07g9uJl11f
         PqlaouFvdshalQi+grKrL8zxnS408RKRZ5QLNIaUECmWXRsmNxdUIBttMllDAzeZr2d1
         z8Duzs6ZdeEeBqZdA09E4fGOfzc+RTKEsIn/QeiYrKd7NgIHnAy8jjDtaNfgUaE4NRbe
         Lf9oNztAZGnoy0AIyyxkbRwHlOlAU17lfescku7LQjtU5XwsjzLqXBltCO1Yk0L1k9vQ
         axCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5B+kzsRnu+U6xbupnExml+efTmE9uZhrQLSIVDSnbXUkVVz5Z6OthzJ3RpZz1mCr+/OvKqPY29ScU6r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7rN1est7bYsSqrH61RMNp836jxE9NWSB2+UoqbPT5B549/zU
	U6oC0wTFrGuFgFb0DDZ1GjQjO88vVafmt+ifgb0AovE1aBKujDRICLnpzfgVPw==
X-Gm-Gg: ASbGncunud2PtYlUY6XBs6hA0FxPv/iccd9UZOe0oZufPMqihNXjWfbHW7RT/qiFTtu
	2cSuaKdql7xAX8pU2+r19MwmaB7yEAKDsnPtKGforX6Q4tQ6ALquzERkrBpzZvDJg1XSX5o1xCV
	GOaJAjfUey+XAY/CAs7uq3Sbu784kZRHiWJXx0SrGEX+RqBsxWo8OEQBUGfZ5osZGmJPZY8wmfv
	8ApWbYH9R20NMoeQ1go/J1eSodmPMEh7pUAw3WeeKWvIffmJqENGZtcSLIf36/YoWQH5h6z228Z
	/TeOqL+PTaEoR6UKub3oswiJPp9xaks=
X-Google-Smtp-Source: AGHT+IFlsE0prA+QjhIwhNao69ghrMw1gnCuZOgeJcvkopeDHZGF8Z3kfdcoE3q7+SdlJlzTV4hCbg==
X-Received: by 2002:a17:903:46c8:b0:215:b45a:6a5e with SMTP id d9443c01a7336-220bbad9625mr143527125ad.18.1739524199231;
        Fri, 14 Feb 2025 01:09:59 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:a164:8397:3a17:bb49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545dd95sm24653765ad.135.2025.02.14.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:09:58 -0800 (PST)
Date: Fri, 14 Feb 2025 14:39:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Message-ID: <20250214090951.wrjk6miyfq5twqph@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-3-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-preset_v6-v6-3-cbd837d0028d@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 01:00:02PM +0530, Krishna Chaitanya Chundru wrote:
> Currently even if the number of lanes hardware supports is equal to
> the number lanes provided in the devicetree, the driver is trying to
> configure again the maximum number of lanes which is not needed.
> 
> Update number of lanes only when it is not equal to hardware capability.
> 
> And also if the num-lanes property is not present in the devicetree
> update the num_lanes with the maximum hardware supports.
> 
> Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
> width the hardware supports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
>  drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..dd56cc02f4ef 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	if (pci->num_lanes < 1)
> +		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 145e7f579072..967c62cf3db0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,12 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  
>  }
>  
> +int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
> +{
> +	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +
> +	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
> +}
> +
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
> +	int max_lanes = dw_pcie_link_get_max_link_width(pci);
>  	u32 lnkcap, lwsc, plc;
>  	u8 cap;
>  
> -	if (!num_lanes)
> +	if (!num_lanes || max_lanes == num_lanes)

Is the first condition still valid?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

