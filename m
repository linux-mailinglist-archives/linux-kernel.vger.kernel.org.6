Return-Path: <linux-kernel+bounces-443574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FEC9EF783
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655D428D9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E66223E69;
	Thu, 12 Dec 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPyxdVlU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B29223C65
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024883; cv=none; b=jcyisdCgoJSwBItk89zNaQDYq4jjG7WM8Ho8K65/lqZ7cvp9A69kevL3FLeyicclD/l0UFpo8jaSOEHqo8ui5JNmBMOoFWcFHWtbUVmLOQuUzurm/8LvsnYvT91hKtOQCNmw+Qanf0gUVUlQkAEExEavt5HFvhIzqkz4hZYToVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024883; c=relaxed/simple;
	bh=1ApeRTFz6odk1XghaSyjjzbGUVxHPQM6AiMitJnG81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQd62clZqf8SvNQC4MLdkZ+hzZbRLBHU73yXAOXOno3u6uwr1fs5HX7ug8Z35pw/G37qNo6qia5O7M7yK/Jrd01paDMNOGqbxui2cTuLqd30Cux9MvkwZU3GFUZlCzZK9OUX+uimgRb/GI5pBFOv4rERb7R+1JiWOTTOF08TkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPyxdVlU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCG9WXD030098
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ix2yViUlfOnI3Jp/l53HkxumLGnFyx45XHeGOYs+gnQ=; b=IPyxdVlUvNmHefHg
	axdYOSCzpKgyMhouH/3h37eg41lkiQzZvQ5iRHIeKEJuS622s10rueZLzMicai40
	Nbl19dXid2zJvKhCdgz+RC2my79fZr/zRnxr1VIIucoPAWYJFEUyyLqxQqmyudca
	6YE0VyGJiaLIm8FghYyrrBR6fy2t2D31PA2aVUHgIjZ2+kudqTPR86+U6QUGArAD
	aHdUDR7coTOIwzUZ/eYyLkylAP1tuVxCW6zk1kZ7mepaFG42UbL4FO8MU/3GTizg
	wUR9lEnI8igp21U3wSw0ilgTt4lviQIzttnuhhw/2y3C4VQoNb8MmWKEEFjVrul/
	isGFsA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4c5qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:34:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4679fb949e8so1035441cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024880; x=1734629680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix2yViUlfOnI3Jp/l53HkxumLGnFyx45XHeGOYs+gnQ=;
        b=lOW2vniQt9/cUZYeb+RO62ETjExEfM8PJ9Gc5tWCp8+ZWsuYl0EIYkcPefhQOwft/2
         t7A9r5pkc5UWgNsqt+U5Xw0cnv79j1DRxI2e6YaZNo6q13pXf3uBM4fWqJ8e7QP5RPQY
         sA92k3cW6c8DUXfAQTT6j4KkvdPaT3Zngtd+eDxj8n11/29/ayL186BPra9xi1+ScNkF
         kP+jAFtHcEp3yY5JV5dc5nyFv5nomA+HZkKN2aXDrQzuRa5MFjbURU8hThbdVsoT44+i
         x6UxBVqdiu7CL3dG8/FD3t21I139phfclnO9JuvjyIYcdUnoSWp/gF3XJoNIt4mb04at
         SS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWphyYd7xqnv9hgxVotvooKZn8pdJaFc2INVLsGpXZVag67rPO2chn5LZHp+qaDNjn47oxgduIgdB8qTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5hviSyeG9Th8V6ywK3rDls9BHTTJDyD3I1iQ6oENkR7QvKo2
	KDuGuy5x34X6gqZMM5pjTg1jf7Ts1IFw9SX71LLe/WgLCUN/P0YBKxG69TdaNbgILP86G8jBNN4
	7U7SSD7dlvShK+FEk1C6vmvIHTopxkik6iU4Wicsyi4hx6GIQ3wWsmwxgxPcatzQ=
X-Gm-Gg: ASbGncuKCIpvlq08PlsLmJeyWpWQNV/A50DnDbi7VAwU4CJH30GkCKk1kriBHMe4eoQ
	KO7c2hGT79NMtpIksywjgx6Ix5F4r9OVXrGmMVxCdwuioJDDmbPb2K6N60/azrrEIIW1cZwxORi
	qgCnllzNWDoM0oQmgQGJl7eUkXnzotiVljWqMDISY9962KYM4FiOd6tkJwXy2VUG7VQ71IaDAQg
	x9eVGZiycMrv5FOD3fZA9ZaLK/VPd3lMm0xvwDLoog18W9QyG1i9brBJMQI3omGSJ2XrtoIv2iq
	UfPqq+1WWeU2HYRT7HSaxLBJrQ/H8h+bok/VzA==
X-Received: by 2002:a05:622a:60d:b0:460:3a41:a9e5 with SMTP id d75a77b69052e-467a16dd1cdmr7790801cf.13.1734024879990;
        Thu, 12 Dec 2024 09:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFljHM2Bl24f+BNJ4dG+QO5z/PRp3ZrX7hNKu4Z2XRUq2UO2aq8AUxd+Qp7DJXsYZxCRcCYIw==
X-Received: by 2002:a05:622a:60d:b0:460:3a41:a9e5 with SMTP id d75a77b69052e-467a16dd1cdmr7790611cf.13.1734024879612;
        Thu, 12 Dec 2024 09:34:39 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67d63f867sm679690666b.133.2024.12.12.09.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 09:34:39 -0800 (PST)
Message-ID: <f2964623-63e9-44cd-b328-d502b5fddcd2@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 18:34:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
To: Abel Vesa <abel.vesa@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
 <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GedEjl_CIFGiacqQzTldw8dsDY9pzc5e
X-Proofpoint-GUID: GedEjl_CIFGiacqQzTldw8dsDY9pzc5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120126

On 12.12.2024 5:50 PM, Abel Vesa wrote:
> The X Elite platform features two SDHC v5 controllers.
> 
> Describe the controllers along with the pin configuration in TLMM
> for the SDC2, since they are hardwired and cannot be muxed to any
> other function. The SDC4 pin configuration can be muxed to different
> functions, so leave those to board specific dts.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 142 +++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index c18b99765c25c901b3d0a3fbaddc320c0a8c1716..1584df66ea915230995f0cf662cde813f4ae02a1 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4094,6 +4094,108 @@ lpass_lpicx_noc: interconnect@7430000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x520 0>;
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;

The comment regarding ICC defines from v3 still stands

the rest of the patch looks good

Konrad

