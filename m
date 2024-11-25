Return-Path: <linux-kernel+bounces-420993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0609D8559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5C288FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2CC1917EB;
	Mon, 25 Nov 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HtGERbQF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAE18BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537274; cv=none; b=iwBD8MDNa2TH7lz6EKytNDT0hLH3YMeswXYdRunbvqCs52doys5he5DrAYK7Zg8elToD74fn9haU/K7Tcx9BUtotkZmglRYuvZtpcmp0dVd2Ha3Y25ZuhiR6XQtcgypOb3eO02Vhlm/moR02tcEkkplQ64SA20G+CIErT9StrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537274; c=relaxed/simple;
	bh=Xun8L5uQ0SPhaUj4P1wBPJtCieaRpbRBWBM7C6nWscI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WW6EEVfY/vYqU/vCW9eU4PdrMVCq0aJFAiRMaqXsEr892zT6h/9T4eY7Zcj90xwKiyqz/TXuXGQze9U7BrjLsuVJLUvx/4yWcr58/7TcJaCiRWMWfRvb9h41yB06aYvvYKooK8fT2GY6jnq8BOQQAV0LVNg9YCbYYWP3lvtcHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HtGERbQF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAiYml021756
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gDBzRlkGCEyYFmZ5YmtwhBflQYtmhi09NNPtB9yI/i0=; b=HtGERbQFnQFOzFv4
	Uz7ujJTSAXT7EXMgN3uKT3vyXeickcjmAyfD859wdZZAkCUOfG4fV0J3rgMMj4P0
	QsBvxJ29cTZ3hWFR2a1bajVLKJy9rrSGOgCljd+jsG1Gtz78QgokY0zpgyv8xMps
	hXQa2iCeTh77aNDIZAcvX+7q0LSw4IHrwKDbMVk2PvaLOthdAFvx40NhVPRnH7Rd
	r9VMBZQ6gtPmm9dNZ1fT1ztZundGV4EBbblKA7N7igeUw469O5t8/8ACOZG4Cve8
	bc660XCK9qxbONvjxyFTfDrYSKioLzV2NmR+M/FMfDSQ5aw/LllDnMpGOPXpnm2k
	Hr3iPQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334rd4v3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:21:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46698b09335so765221cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537266; x=1733142066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDBzRlkGCEyYFmZ5YmtwhBflQYtmhi09NNPtB9yI/i0=;
        b=Ifv+vLCewZ4qYpes5U3hceUdgFery+Y9a+cUEn789z5bGaQ5DgC9OEkNCFhGaakvYV
         nn1IRsPyupio8Btv197WxEmWlYsK3QAfCFEHw4HBJJf6c2lMCV0NHe36UmWEnUFt1chb
         R8QrLHZLAD5fv5+9Kr4J49BdH/ogGpi/h9kYD1LkMQG39Ydy67A2YqmArj+J8An/E891
         qVMwBBSWBMom93FFeuApv0hwCK2/4vE3m2jP1u6jj/G7+TwpKSjTwpjULd64sv63OmnG
         1q+DTvBTz2J7k+4jecAF8m+kXGrX3KcQw215zHh5bZN8xocOVNBg1YvJzwYMXqGjsdzy
         BPpg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtTSCS8q0noJzdWGc07cpgrJNQAkJwQ2Fmcpvv++OYHAtaaaBlB+0nvbvXZEtpValGMhs2Y6PpnPrYmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgqsc2wPt+Q43ipwwDUwmYyX3J+uNzMDWsQG0J0jlOcvcp/8wt
	W9Db4G5TkJg45kefleie0fkfsCRpskcBDbF3cYP02OyzCPGcWeXrznNQ0474APoMfzSZPdhUtpL
	6wPOGiL/Bd3eamEnAzEsF9aCaxQ6W2Wo7frnhNnQ3MqfFCGY/Xn/hup7puMc4zwDou79e8Gc=
X-Gm-Gg: ASbGnctfH5NtFv10DtZLnMCNS71BuwGo+limWJPlZuXg2derNMJnl+YI7Za1rOa0+T9
	9VUvkNU8VMIU1zx3f9B/7nVBQNXKx3E9+eFbNup7U/RigDv/5mBCy5DYf8Ya75+leR7/3mChXDH
	KWBux7E9Y0HFKqCIjetd8I3Ubs6Hi+1xgqeeKa834eRs3JTVHcM+Q+1up2WAqpIB9UD75K2bg8L
	8ML02KNXNI4qafGJkXkpBUlVdfM8W/0pZD4UnG1Rrem86bWL5Tby1xP9i9kH3ZS5cu0Hw4Gb21N
	E+aLCafd7eKP5NL84e1lozYayCbqt9A=
X-Received: by 2002:a05:622a:2994:b0:466:8c48:7222 with SMTP id d75a77b69052e-4668c488b82mr26078401cf.3.1732537265771;
        Mon, 25 Nov 2024 04:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG897EHQwM/DGNzZZKU4h1dAJu36wkURTvQ3FH3Ph9u3QiO5bPEdDagAHgNEDb2GbIGXUHf9g==
X-Received: by 2002:a05:622a:2994:b0:466:8c48:7222 with SMTP id d75a77b69052e-4668c488b82mr26078101cf.3.1732537265315;
        Mon, 25 Nov 2024 04:21:05 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01f9c2dd2sm3976328a12.18.2024.11.25.04.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:21:04 -0800 (PST)
Message-ID: <af6f4b48-7e9b-4561-818d-150fe954d821@oss.qualcomm.com>
Date: Mon, 25 Nov 2024 13:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: x1e80100-vivobook-s15: Use the
 samsung,atna33xc20 panel driver
To: maud_spierings@hotmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241124-asus_qcom_display-v3-0-002b723b1920@hotmail.com>
 <20241124-asus_qcom_display-v3-2-002b723b1920@hotmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241124-asus_qcom_display-v3-2-002b723b1920@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Bzs0tk4neLJnFJCPPsTYr_8sAv21LglQ
X-Proofpoint-GUID: Bzs0tk4neLJnFJCPPsTYr_8sAv21LglQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=995
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250105

On 24.11.2024 11:00 AM, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> The Asus vivobook s15 uses the ATNA56AC03 panel.
> This panel is controlled by the atna33xc20 driver instead of the generic
> edp-panel driver
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> index f25991b887de3fca0092c5f81c881c5d8bd71aac..dbc85aff50a95bfc2ac11528d1901979ec7b1501 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
> @@ -407,9 +407,13 @@ &mdss_dp3 {
>  
>  	aux-bus {
>  		panel {
> -			compatible = "edp-panel";
> +			compatible = "samsung,atna56ac03", "samsung,atna33xc20";
> +			enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
>  			power-supply = <&vreg_edp_3p3>;
>  
> +			pinctrl-0 = <&edp_bl_en>;
> +			pinctrl-names = "default";
> +
>  			port {
>  				edp_panel_in: endpoint {
>  					remote-endpoint = <&mdss_dp3_out>;
> @@ -475,6 +479,16 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		power-source = <0>;

This is <1> on other boards.. I'm guessing you verified this against
at-boot values?

Konrad

