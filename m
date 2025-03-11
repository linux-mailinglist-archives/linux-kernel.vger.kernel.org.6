Return-Path: <linux-kernel+bounces-555958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C317A5BEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BB53A7ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE35254842;
	Tue, 11 Mar 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZnMDEV2b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9D2505AC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691949; cv=none; b=I9CLbG90lSibLsM8T94vDy8Feq7bbdzzznxkncq0KsA5sGD0a8zHlT6mjSyhbAVaTN7an4VOOxiyuq5PAnwIGhvpSGxjJ2b1Jr+9kM8QfthyMizJ3gAFwNzcFzVQhnxxE5w3TqGgSJwXFwcl4teiUjfmUwtpKaG5Z3/ngWNLvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691949; c=relaxed/simple;
	bh=KG2B2zG131J/s0YjenddE96hvagPtolWZ0k0Q1oZF9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEKTF7rFnEevpbMal7dEs/4DgV37s6cDevbG6+FC8i0fMlgBz2mPk+ct0QDcD0k4I2re/ElF5p279E/Lgvql3dA6sGd5xC9bZy4Hlq++RehbMM0Vx5zUp0zy/xgk6lNbGFPWYIFlrQ++LvPi7/CMuFOgbLWS/AA2egSwVV9l7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZnMDEV2b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7lW2i031503
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/zsrPomSGC1iO5LSmQ+QJBzaniKLt0k5UGEjWJYgjM=; b=ZnMDEV2blLkM1v6j
	yz+sUf2hDI0q+GO8vzhQ4koX6CWHGWxt+USTTF7vdAR8pG5Pun5GL0xLGPYlFpHm
	VCercVTpc2OZNFgq1Sll8rcPHuSEMSkeUXkTWwDIC4JETfBANvLUmqAYvzEXbNb9
	9PXbp6u4k0bNY1+uhh6mTp377KkHSGDJ7g7unANHauZe+W5vIQGOoy9wXbYSKLRB
	fo8rNQvZvA1oRQ97U1Hbp4+soJs1FaqcTKjZIGA5CB1at82gqINh9OYZ9yy/44cZ
	BHksC5VzdSSS0lnRNBQ951k31rSH+lz+RdeKhnGtQakSzCUmmd0fdXHhUehU1Q32
	ygPmEQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah3krp4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:19:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e4546f8c47so16537946d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691946; x=1742296746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/zsrPomSGC1iO5LSmQ+QJBzaniKLt0k5UGEjWJYgjM=;
        b=ZSXITLXuulFlVNd7BKbtwLBr2m03J5YbEjt3inFZ1FkP//eBc/I3KcWc850MHv9eym
         7CB/7rYSJSLeHALKxxalIvzbuYtZy+OoFI2QuI65Rf9NHGkPipPIvQ98NWFFtpe//AZY
         JmKoG0wzypMlDeDbtLZyAEcV/jdpn5rGbuhtXd7Esv2ynVXhBVP3NRz2lzJgbkBoA2tC
         ceaJ2gWuR32YlsxaIUl5ViI5yMwLUyzTE0GQUN1tF1aliUWgJl9kiB3oI0N3Pp73jVkz
         nb1yQJB4+Ph4bw4Z0zlwLsSKlC1YDmRmHcES3YjL2a1XLElVo0T1DEPZTOKERO4Lfonn
         uyUw==
X-Forwarded-Encrypted: i=1; AJvYcCUNZNe0Z5lDCnLrVo4piwnK7rZQwwmx8hguTpBJbXYeTgKtiPuLh/V+4FLiW+cTBqIVtWtvhmQGM4znpmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrfRFXTzjE6ZQ7uA/HDeTw8jIOLm312SYGwFGXqM+rzJknB1Y
	oKYSxDMcxE/EtSmdJKfANMUyAa7TW+J5KewjyOY8lHYCiySr4JeSOLVw892Mt5FufNSuMUwwp3d
	dY3qwRCybqif56VCN4vCp13UkPaVQH3dgQd4Tq+NXcbPGJNQG6fsl8nu9Iz/j264=
X-Gm-Gg: ASbGncuNb4+NJ7ygR1GXIpLNVcvffAQf82JQcHXUKl5qQ52LbHD0dX6evu/dcF33QBJ
	xnfBGaiJ94/z5lDRXxAyPfzgXvSv4PVQOeWpzWopiEaaHM/ticmCqV9PnsebFyHm3yEP9+hgG0y
	zYGoXYROGpt7KduLH7nMeOW4u9IQ703F9Ft+73R8dZWHMbnesIL5RZt2uzinFaIizc6RoaJ+hCs
	TEFg5El/UkuX2fNpbd6Rknr/UxEljq/zFcVIrmzW67sq4q8GZ+Ga0K85f164zTr/80gYgZU4np1
	1YxKVyqjSxAt530Od2fBDHmJiNUeWFHs2FN37OOW/Gega9dx4I7hVjaVz87g3PAUtLkkdw==
X-Received: by 2002:a05:620a:1d03:b0:7c5:18b7:506d with SMTP id af79cd13be357-7c53e05f9c9mr737226885a.9.1741691945868;
        Tue, 11 Mar 2025 04:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMbOo9/SytOGUrUMo2XFyejsZDSP+j5JNs4kPwfKJu5yFVYu9xbBZSRIJg5VV2VeLv97QvVA==
X-Received: by 2002:a05:620a:1d03:b0:7c5:18b7:506d with SMTP id af79cd13be357-7c53e05f9c9mr737225285a.9.1741691945534;
        Tue, 11 Mar 2025 04:19:05 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394fda1asm904961866b.78.2025.03.11.04.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 04:19:05 -0700 (PDT)
Message-ID: <69fa7f33-e957-4dac-93dc-6fd40167873c@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 12:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] phy: qcom: Add M31 based eUSB2 PHY driver
To: Melody Olvera <quic_molvera@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-6-a698a2e68e06@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-sm8750_usb_master-v2-6-a698a2e68e06@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 170GJbUAtKqYKxQF52uEqsvt3AoezeF1
X-Authority-Analysis: v=2.4 cv=MJiamNZl c=1 sm=1 tr=0 ts=67d01c2b cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=obrcSLqBe2MPJ_po3l0A:9 a=QEXdDO2ut3YA:10
 a=T1PIRxOFuHhLvSGs3xkl:22 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 170GJbUAtKqYKxQF52uEqsvt3AoezeF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=859
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110074

On 3/4/25 10:56 PM, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> SM8750 utilizes an eUSB2 PHY from M31.  Add the initialization
> sequences to bring it out of reset and into an operational state.  This
> differs to the M31 USB driver, in that the M31 eUSB2 driver will
> require a connection to an eUSB2 repeater.  This PHY driver will handle
> the initialization of the associated eUSB2 repeater when required.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

[...]

> +static int msm_m31_eusb2_write_readback(void __iomem *base, u32 offset,
> +					const u32 mask, u32 val)
> +{
> +	u32 write_val;
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(base + offset);
> +	tmp &= ~mask;
> +	write_val = tmp | val;
> +
> +	writel_relaxed(write_val, base + offset);
> +
> +	tmp = readl_relaxed(base + offset);
> +	tmp &= mask;
> +
> +	if (tmp != val) {
> +		pr_err("write: %x to offset: %x FAILED\n", val, offset);
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Is there a reason we need to read back every write?

Does this have to do with some funny write buffering?

Konrad

