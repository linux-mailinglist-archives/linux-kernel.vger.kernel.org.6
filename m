Return-Path: <linux-kernel+bounces-443907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998B9EFD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABE2883A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9136DDDC;
	Thu, 12 Dec 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9A/j7Y0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0714B088
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035018; cv=none; b=AdAfkjUVEUzI7jYvhg63628LtdrO8d7lRE635K8vhTM752rtyfGzjloVc2HgvS5zmihwdf9qfHpA1ImcgzIn0r1gBwuIV5TFkhKjJx0DWDj621LKPva04XmUrWk98/Xgl7rE8vcLz8SaDVxzKyd5Spg4Tw+AfLfE+l68+nIEDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035018; c=relaxed/simple;
	bh=58VR6ynHeJBjF2wjvzDJ/0nEnN6Qrr0p4Z+fxi3zYY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUkqnHqaKslfCUCQwpEjFspIFDmZKWNnkTW/XnE074Bl3hwS6zHYBdqEn0Rxhky+WJyitz+kXH5/wlsA72sHpf+31UcfT4t+5SSZJSQI/yDGwBVUMu8eZVkGRrfol99LYBcwYx7urF36NH68LnA+n2OH6pv4Alan1Ezu1rbds7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9A/j7Y0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHmaYp028131
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VNXApAYoczOqOShC9/nuP5LeZOoo0SiKoAlZLTUHdmU=; b=K9A/j7Y030siSI8z
	tTroda5moKcL/HVclNY4TNJcLbkiPIOmImNJs4aAVMwN0yVDeqtuchXxneHr+Q8Q
	TTmclWBOh2GFejy7OEtcDpp69Cbgdnkv6+QJPVyyNA2bXdiGNGagCO60RUadmYjU
	ynCEMYGjHl76UY38l8ue/gP72dupsMreds2htevNpyw4mZJFniCxGT8+KVRWYjoH
	2oTLQOVGGYYVffzSWyUK9Npk74U4ep4mvgyA4f3nRv7WOZG75S/4K32hbhri6C6o
	LSsiwUdYdskgxQl/CSWLKEZWRF1ixK7TOFk6sJAj2ZL7ydXd+F8cKTqSofvtnuFr
	k1HV+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xv596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:23:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679ef4565aso1582251cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035015; x=1734639815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNXApAYoczOqOShC9/nuP5LeZOoo0SiKoAlZLTUHdmU=;
        b=dRKXaZq5O175+r7NOADuxYh2AF0TeHuZXYvFfoj1CYG+DgNC3l0LlFUoS6XDzORqIA
         Ume2nVDgdirpR+OQSrmdhNPgUfbk4OXiylOc4PdlP7Id3yCaBqGF5nzVFNod6CpDDyav
         JXmNxbu44rEr7T7vFaKwQuPyZpo7klqgQWD5xW5InOvO9vl7TnYo0w58bXKkC3po1xpM
         wIIoS5FtKH0laXeuH3JgfTbReFc2VtOMgfRvAQTThJ6zhmyAD2oJYKbieYi/nyTaJqyx
         588qczZwM8flGxCOC37c6UwFcxYuuJleMAoZB6XiklMRxqKb7Efy5oxPN6yOUHmCg5rq
         Hnkg==
X-Forwarded-Encrypted: i=1; AJvYcCXSBnnCUN1yq6nOiIJ9m/xCyEeerQtkk07Bc2EEwXA0ItdRY1fXi+VJF3KqIt9koLGgatn3OEc0nT/kBng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRhazxpAi8D2kAfiEfRN4eh+FHl73YR+d/Dj7N4i+JSWymVns
	P2RWui19snfrUPm1ntBlruRqF5xE4o2vB4AMUtwODt+C/y60RoUmcznJH/kc+JWWfPcgsM/MKUT
	LV5+yWlVTcUY9JtruaI9kzIBNFWQezfdadjLIVCZi0NKXlMMk1ra2lqmF7Uvv+g4=
X-Gm-Gg: ASbGncuF6weoep2Ri6b3bdwBlVOcuAchLHmVhtZlm/Nhq+6LeNt6++GEYgm+MAjcJsj
	5/3UNrf+8nw2S8gzX6G14ly0CSjO3OJTdoVps+3crFEvmwdVjalUE8J4H8NdZPOvu4Eo3cmiPjf
	T4BcBBp67R/u3zgGHcxCva5nxd8xFay1fOrqd0R8k4eoDYltN+Ibsm3dTmSdYQKdFmBtS8VLg/b
	MXSJSwgzWMBkTwcRD/UXzhpxwA90/+07CkbqyVXR7HigLSrJM2hWPnO2XadY0syh95WoCvrEJTy
	cSMJfh1u45WhRlTTRzaLaE1xfOKYOuH5ZRF4KA==
X-Received: by 2002:a05:620a:46a6:b0:7a9:a632:48ad with SMTP id af79cd13be357-7b6f899dee8mr85395085a.11.1734035014942;
        Thu, 12 Dec 2024 12:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExvgte1ZPFoPbfx/Uyj2kPoFMZrbkappIQUOqxNtdLoWEyz3keckd/ZXR+X87+mI4tFu8iRQ==
X-Received: by 2002:a05:620a:46a6:b0:7a9:a632:48ad with SMTP id af79cd13be357-7b6f899dee8mr85393485a.11.1734035014578;
        Thu, 12 Dec 2024 12:23:34 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69ad40b4asm499841666b.33.2024.12.12.12.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:23:34 -0800 (PST)
Message-ID: <ec7b07f8-3fae-4604-88d0-28515c6668c3@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 21:23:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs615: Add CPU capacity and DPC
 properties
To: Lijuan Gao <quic_lijuang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211-add_cpu_capacity_and_dpc_properties-v1-1-03aaee023a77@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-add_cpu_capacity_and_dpc_properties-v1-1-03aaee023a77@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LAR9-SP6KpzyIUzHg2O7Zj-DQMiYT5wY
X-Proofpoint-GUID: LAR9-SP6KpzyIUzHg2O7Zj-DQMiYT5wY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=890 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120148

On 11.12.2024 10:35 AM, Lijuan Gao wrote:
> Add "capacity-dmips-mhz" and "dynamic-power-coefficient" to the QCS615 SoC.
> They are used to build the energy model, which in turn is used by EAS to
> take placement decisions.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

