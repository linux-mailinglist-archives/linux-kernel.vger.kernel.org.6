Return-Path: <linux-kernel+bounces-577047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD4A717AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5926176819
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9531A0BDB;
	Wed, 26 Mar 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R3PccR2g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAB1DE3DE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996388; cv=none; b=hwnhfG3FHrBYxPBHyWEjjJzR+EG3ihZyNPF5rd3vKKev/b8DxzZ0P638dUOFypxq5uclI3sv/m/M2sfV/h3qLVYQkMG2zL8Of6RYU/I6PwPVNcZCIDn/ZeXsrpZv5uEv8mMQLTP8b5XhGOkdkeZpS3chscbV06VOn3Ivh9Mv8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996388; c=relaxed/simple;
	bh=kf/F+jkny4YZ6AMu9z2yztZ4555sxMojDJfUc3bbQ5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAjDM4VrG/UXiJytDRqrT5mJLPw8aajGVVScOT+tbnndRe56/znF4JsxH0G5VdkAMe0KfO3ySUzwb3W38o7pEdF9N+XA+GRzU+fNfk0lCG4WrtFhJ28g5IHMe5dc0ag80hbES0UdbSd2FXM940j+GgVNxozHG/ldDSTzFv9b4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R3PccR2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73ExJ009030
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yY+54IoSFwl5DkXlueEGcXHNH/dGPmMQZUEhf3D4Gz8=; b=R3PccR2g11AvGt3A
	9gd63yRUAp/h48xNAnlloqI0zkkYwDcN9vRC1rqwG562XZU60YcRH6p0475rMSKk
	SdZoSv7CETHygqiAoKYCJWMpBNOzQtnkospRlzx3YiasVCjS6uEXCJ/KQblMa/ZQ
	cFhRr4mGRNuL+KOPWTgCZX/lueI/LjewtiSLsYy8/jjKoxCIAN5zyRU9xunYe7Ob
	sGPhdkYcd6jVLUZd0aOb/v1tYJxHt7w4NB6ENnwrc5Ja/VCTF5Pqz13xzIvYnk54
	71mXSuYGbJGWGXFA7Uwxck1/Z4lOGj+AFoVOY5QNJvD1lbQ5fR6s+OxQoYp+OdUJ
	JP7Uaw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4n4rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:39:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54734292aso166122185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742996385; x=1743601185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY+54IoSFwl5DkXlueEGcXHNH/dGPmMQZUEhf3D4Gz8=;
        b=g0DaJPL5BwUUGJ4OAsxJRSiAfxNrhTcuqN1q6x8zjNkHsF2Y0IhuCqYLGiju1O81c6
         01a8HI/ZHqCay0oWS61JXzP4W5jHAaT2bWpOJTC0OGn8P43oNPU3HWTWwmkGZS3MKAC+
         waGj3VUxwGg7BzTOp0K47ga38m82tzhahdafAQaaYSsx+6PfxgkmeU0aLV2WvA3uykvJ
         BoLGWisos/2cykSBYSpg+1Xlf1/8WQAyKNK4mmqHBC7wnv2TdfLMdb23YGCfBce9456a
         0XFRzOSTG3G/J7tMDHTO2OXJH+Cfvtr5WQgdcyiKd/FXd+VqQBgayl4tqgDxZMr3ZLVG
         cCJA==
X-Forwarded-Encrypted: i=1; AJvYcCXuELPF7G5dCyomR/ytJToxvIJ5Ic/38oG/VvQbzfTDSYTqg76N8hXD9qbuBweZFNsrNdJxAsHNIku51ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXLK67+ewEg/g5t50Uej88qwX44EeFPLqfpHfetmTzKg/Pud6
	rmcEXg6Vj9PxzveyFTk5TnX+m9kI4QqYR+40N6UQqk+skhUb5l5ySefjniOMWNweTI9U6YOJE46
	9Lz2fL9CQTC6KXYb9UgKN+EmMBSH97nH08vQTZN0E0kxYC+uP2Kr9g4ODnHsJFdk=
X-Gm-Gg: ASbGncsS4N7LIix0Uxp2/u9t64Xs+/O7TojyjGNnfAaGVz9Uh1s6pYKkza/wOH7NkO+
	j+HFAnqWmOIeL+IydEef7Dw5XXYE8p4k9NUUkD3GD7H6VC4PHyjVd7C8pT2sxa+B5gp8qO5J/B4
	6d/We4UL7NrCvSP5osZ1NpPuyNb18PTlhuZYwjrsm0fQjzEqeAxOLMBO50liXibNn1OkvQdw08I
	4n3Ajp0+tLylePAXUHbVf/3TvmQ13gqqgRrOsx5j/eV+VDsc/t055Ekdx9ctKpT5KwTKBmxw9iw
	KOiD+oVIHpct3ZgnpiuS42Sfr/lOkY1Bs2Mj31FD6Tt3Y3VG/SOjrYUaAVlDKNsM3f9+Jg==
X-Received: by 2002:a05:620a:390a:b0:7c3:c4ba:d8a6 with SMTP id af79cd13be357-7c5ba1e9ba0mr1272912185a.14.1742996384575;
        Wed, 26 Mar 2025 06:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE30qP9JMblwOKR3SHMweTnCiZ7e3Na7JTC5GCduH+gUlOFCJ52ha4yHx4d11pPVez2ptf/w==
X-Received: by 2002:a05:620a:390a:b0:7c3:c4ba:d8a6 with SMTP id af79cd13be357-7c5ba1e9ba0mr1272909685a.14.1742996384033;
        Wed, 26 Mar 2025 06:39:44 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm9514631a12.40.2025.03.26.06.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:39:43 -0700 (PDT)
Message-ID: <0ca929c6-6ff5-4ab0-8ebf-aed3cc5f350b@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 14:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] soc: qcom: llcc-qcom: Add support for LLCC V6
To: Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250324-sm8750_llcc_master-v3-0-2afd5c0fdbde@quicinc.com>
 <20250324-sm8750_llcc_master-v3-2-2afd5c0fdbde@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250324-sm8750_llcc_master-v3-2-2afd5c0fdbde@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WRmIXzYS90z-AvYHai39TDkTuLGU10sR
X-Proofpoint-GUID: WRmIXzYS90z-AvYHai39TDkTuLGU10sR
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e403a2 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=cgwDF5ybabLtFIHcvScA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260083

On 3/24/25 9:29 PM, Melody Olvera wrote:
> Add support for LLCC V6. V6 adds several additional usecase IDs,
> rearrages several registers and offsets, and supports slice IDs
> over 31, so add a new function for programming LLCC V6.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

[...]

> +
> +	if (config->parent_slice_id && config->fixed_size) {
> +		attr2_val |= FIELD_PREP(ATTR2_PARENT_SCID_MASK, config->parent_slice_id);
> +		attr2_val |= ATTR2_IN_A_GROUP_MASK;
> +	}

This is fragile if parent_slice_id == 0, but let's say this is not an issue
for now..

> +
> +	attr3_val = MAX_CAP_TO_BYTES(config->max_cap);
> +	attr3_val /= drv_data->num_banks;
> +	attr3_val >>= CACHE_LINE_SIZE_SHIFT;
> +
> +	ret = regmap_write(drv_data->bcast_regmap, attr0_cfg, attr0_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(drv_data->bcast_regmap, attr1_cfg, attr1_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(drv_data->bcast_regmap, attr2_cfg, attr2_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(drv_data->bcast_regmap, attr3_cfg, attr3_val);
> +	if (ret)
> +		return ret;
> +
> +	slice_offset = config->slice_id % 32;
> +	reg_offset = (config->slice_id / 32) * 4;
> +
> +	wren = config->write_scid_en << slice_offset;If I'm reading the wrappers right, you should be able to drop both the
shifting and intermediate variables with regmap_assign_bits()

Looks good otherwise

Konrad

