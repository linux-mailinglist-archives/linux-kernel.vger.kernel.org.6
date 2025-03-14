Return-Path: <linux-kernel+bounces-561792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F053A6164B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B945189DF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648C202F9E;
	Fri, 14 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxhYj3ng"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BA802
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969893; cv=none; b=WezBnWRL2ftTCefj8V5PuOJsdnjzKI2AdP3bGqORQ0mNkbc9lu5BTQfvmBkX9aiGZFGV95c55heLwBtPU1xpyPlbdQZ8h46dHXfOAxRtqkInrews/GQODyP/VgHPxS+LmAs4FVjkfYyj1vKUYIL2vYL6uL8fpCckvvrPu+b5rIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969893; c=relaxed/simple;
	bh=qPY4EN7Af6bi9uHdodXn5eQbRgpjfJXW3bXuBSWyEU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkz6jgg2LSQKavXONxGnOHk7S3wJYuwWn6ulXOHZI8pBEDyppSW7cIaPRs3oVkV3m3FnO8/ETCPK0LCte5OJ8a7MoY3b4pcOVU+U6ULw344I0n4emuxNRaP808WhZ39oKfedDLa09X9Fxcn/5GqqhZMbCGA+wcW7BYUNofaq+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxhYj3ng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBTkqq009124
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nAXFePP0RbZzwbI0EAHZFL/N
	CowD6Nmqb6dIEWImErg=; b=RxhYj3ng91kdTOl5XwMSLsGAcdRqP8p3BePpYI0V
	bnYvgxR5Y8UwcELrNVfBo3lSfK2rNBPTanTFBJaw/by43r/1tJZBH5kIMm12duic
	7liDuiLtl5oQDTLVPBOqRLpZdkSjuX4mHhcsLlUSQYla9F+IRQuxXRBydGijtS6w
	wZQabBLQ/MCOJj6TfDOhSbk+1io0HvjaVH7YDhCr6rZXPUrthwkgEFTPn3CKlmzH
	byQY4xBAzZ1nmOdxn20/UWiEraA2D3heoKpLlmN54YnW/K9y+waKP5Qhi/a+jPWK
	rNHj7v7RP2cdXzRkLktBhlC4qUfTy/xdyGi21zi/fdM9Wg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2rhseu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:31:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e6bb677312so35871636d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741969888; x=1742574688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAXFePP0RbZzwbI0EAHZFL/NCowD6Nmqb6dIEWImErg=;
        b=dhaGlcwE1csgd9H9dB0sp0Y03vp7EywZctCuga4/S04vz19ousTag2GnUBATuFjwUF
         3/z0B5EqADtv+sBTizC/VLKk8854AKz4h0N7emOfnzZn8pB1Cuguz1SK2JYMnpivXLHC
         ElSATiaETm7xkO+1pWE8zwO7dP+lZBsI8mOO+Vq0bnjnybcSqq3eB6YJiy0Y/OEP+HvN
         ZEI4ztQNz0V6hoKp8HbVCUui0yQuFNCzm3nSZYhrcy8zOazAL8W0/fzZh5T2ANBQ4seZ
         qEtnIIqyBvHX7H3WuWEgJ5C80K63ESYYq5IhyJJNlJRB96+fKyIqoQ9Dk2nwL7AGD+qz
         AraQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQj649yyaE9dbQb9hjDssmr0njIIqNHMvrCM+TfI9aDAZIzUJagH+xK3DiFpPUwb91ltxvX8Do242Yy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWq05Fh07D2xi3wE59+Pam6n4gBbHtQPfsAyxKgPFWyPN2m9g
	woqJNYQL32UJmbiOIE/OGGCbhil0qep+FhV4C+hCcdo4QbbQ1ZyN83EgZTRGrvwpvtqAdzwAE3o
	rkykTUsVK6mDw/O9ZMUREkkU2unXz8kmMLArpITi6UbdKEZOd4zq6wgWDxGIlL1o=
X-Gm-Gg: ASbGncvw/0EE4Rw+P8/ueeQM72zj4QExNUAzLsUKj0LmTN2QB+VkZOxKp6VBaM2RWxQ
	SBj7pGYwBWZ6EdZDdelmCuJ0eZagJoZgjKMd6+k5+XhLCac4RFER9f18EiOjdrgjmDu3aHZgDEi
	6qg5D09tclsLNS8XPYrrxOPZBGnWrBZuOiYVjlGnHfOSxX+0wUVhGOxDcg4a4/UxrQjXTL+skAm
	TNK0EFVZLkeWoBgvzfGlmFGgV6fNB+BL/pBXy3XqrMv506htQJdx6FXd7ABennExeG4SyQdQAIm
	CpFgBYMSvsNjQ/Mi9BGdzoRIWvqZiXBwUEVfcwLL0ifelHHW9b2yRf+txr0sdEPlzKhwo8ffaSU
	hzHk=
X-Received: by 2002:a05:6214:1c08:b0:6e8:fec9:87ff with SMTP id 6a1803df08f44-6eaeaa68e04mr43230766d6.23.1741969888326;
        Fri, 14 Mar 2025 09:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtuaStWmz1o7nqkvqYgpWeef0Emh0DysLoQE7JRy9U4dzIkitCXsXSIo7FtqLbc+UHyWVpSw==
X-Received: by 2002:a05:6214:1c08:b0:6e8:fec9:87ff with SMTP id 6a1803df08f44-6eaeaa68e04mr43230446d6.23.1741969887995;
        Fri, 14 Mar 2025 09:31:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a951asm552080e87.252.2025.03.14.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:31:25 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:31:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: uniphy-28lp: add COMMON_CLK dependency
Message-ID: <p3opci3q32xtxryfo7id67dxx2bhygpqjptbldr7a7cdjm3tdo@25smzojqguo3>
References: <20250314154915.4074980-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314154915.4074980-1-arnd@kernel.org>
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d459e1 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=JRMrfg_3uorDYgpOfGEA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 30sb_dQAsecvdYNjDMSIXQBLi5qoDo5l
X-Proofpoint-ORIG-GUID: 30sb_dQAsecvdYNjDMSIXQBLi5qoDo5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=777 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140129

On Fri, Mar 14, 2025 at 04:49:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In configurations without CONFIG_COMMON_CLK, the driver fails to build:
> 
> aarch64-linux-ld: drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.o: in function `qcom_uniphy_pcie_probe':
> phy-qcom-uniphy-pcie-28lp.c:(.text+0x200): undefined reference to `__clk_hw_register_fixed_rate'
> aarch64-linux-ld: phy-qcom-uniphy-pcie-28lp.c:(.text+0x238): undefined reference to `of_clk_hw_simple_get'
> phy-qcom-uniphy-pcie-28lp.c:(.text+0x238): dangerous relocation: unsupported relocation
> aarch64-linux-ld: phy-qcom-uniphy-pcie-28lp.c:(.text+0x240): undefined reference to `of_clk_hw_simple_get'
> aarch64-linux-ld: phy-qcom-uniphy-pcie-28lp.c:(.text+0x248): undefined reference to `devm_of_clk_add_hw_provider'
> 
> Add that as a Kconfig dependencies.
> 
> Fixes: 74badb8b0b14 ("phy: qcom: Introduce PCIe UNIPHY 28LP driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/phy/qualcomm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

