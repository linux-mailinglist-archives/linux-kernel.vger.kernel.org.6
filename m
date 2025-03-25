Return-Path: <linux-kernel+bounces-575482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0FBA7032D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4943A4B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659C257ACF;
	Tue, 25 Mar 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwgfOe93"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C02566DE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911010; cv=none; b=ZoabP0TIrHj8yaAtQ06EVibgcSTbvPpqnNu/uA/l/RFDsMx0/EsarnDdhzpQCkfe2JiMXk4ugYUEmMDJ5S1NDxtY9uXhINIPR5r5siU1gngDtBYMclHICnPOmRwL3jQjiRmiU5woFycAC6M2mbJYZUBO6OkG2/T04neyAhX6CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911010; c=relaxed/simple;
	bh=9IaDry6fuUbenQllqTlT5gYi5cOj1Q3ja/I4EJIT8z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXWzRv8DHfIaMwThk0w5Nmwu+wkjmL7/arcKhWwFatXO5MxgH8Dyzey2mJ5+JCVVOl1wcChNMCdTWHLt7KlPAlURuph8m80Fq/7Xp3zTPEbSp+SFAlxtZJVp7RSOhRV7piHeG6zpVtcIjlYcwFlZAEEx+c3cT36nLtG4Sa7K/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bwgfOe93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PD0VeJ018765
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0sLDZktwhqsG1wOZKxLglmBiOdJLLONIkvu2uYKb5xE=; b=bwgfOe93NgXIrhvF
	iy2HZAAvfKWT42nzdJgEpzmXlWXWSGymuWBRuz1x71ybDi0vo6sYN2C1H1su3imx
	BuQfU1UOemDBpZ5YbLCBT3aQmaSF3yxook1e/SnKD4ek5vgiJwaSuElQ5DYyYK+f
	DFG3OnMesGr/CYRFxqTo+lKbfuteauAb6Crv+r9YP/YVZGWkf6n7W58RYVSuBqwB
	4viRSJhtD6wp7hqFBcu9QFMhIPw9j7fVRc7aVyDVHt4zR9aRz9TzJpuFuLvMq4EO
	WR+zx4HbyztXPMB6ZVYYJnM8T8tDU2d6o71QVgO+8uLlRM7OQ7zJCE8zv/1JvEu1
	c97pLg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnrasn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:56:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-475127bacd0so5507511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911005; x=1743515805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sLDZktwhqsG1wOZKxLglmBiOdJLLONIkvu2uYKb5xE=;
        b=cEOwG5P6cILZQQiWm5Klny6gnchvI5c+lkZ0InDs8esBN5ofRShPGymdFEFiN312DE
         Dyf5EReybLtnOcVhNlttcY9ED/UowmaetFu8zrqxqe3xvUESQ1p4n3FXyvtctJ8JJlK0
         +cokvw13ZnC9TNd2tAnb9XKy98XhlG52vHZNEpH/NzbCr0o3fHGVzvCQDE2/1oh330RT
         sbitVB0U6j1gv/hyTmZ7gb9u86/3ca1kWhZbcAUYNyawtxXu1vEms1v3txefInLYYzF7
         6C/gAtKuBNht8ayoiq3BoAk6wo6pRntn4j/EyRemT3JqWESMik08yjoWjvIl1+5Sm+E3
         /mLw==
X-Forwarded-Encrypted: i=1; AJvYcCX/F90LmV4r7rIzAP6EuqDEZ3RYFSFa8XfwkwTMrUcPWup56QjLHSFm5uICCwux6XBFPIh1icLJu3IhiPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMvwXJ1+q2qyRCakgyIQ636lGgWyND6q6fQT9vaoC1mAjGLWj
	xTYSzisj8338JsLSju2QXykItZISRYY1d4tAhJ6LW6vd21GtIMLSEmQCITKLy6ZW5FNl+4RqZJ+
	olui12+tAOFGaSuu+tjtn2sFO3RKGEkczk2oN44dPC2PV2CeyfV8Gk/lGQI6KScE=
X-Gm-Gg: ASbGncsARljUUX2e2YsV5hMhdDExxGGJmES7CwHytNhcED1XT3seODe+ux2cxSuhMyp
	GyfnEpD/VszwytYNdx1aTeeo5fGAUwVnY9W8LmEszWtZ9jfI6wIjDBpPgLicRlvZV+CIOYFJjRb
	VKTUaULUZ0TS5rStujtiPwSYk0w+YQCZs8hb50G7+vAi7wO9nD143Qfo6qyepC2jeiAYD0dxYA5
	32tiP1Sykw8QkgYnl4k1NywvWQiDRIgB5lQovRgqWX7aFSpJIcI3/x6b2LBJBGsgxQRXaCEoW1e
	asqBXCzgywr/d/21FKW8XCOobBL+QOxgn2OJERgK+tFkpjNIV/5e+SLny/0o7Itfa6WjMw==
X-Received: by 2002:a05:622a:1883:b0:473:884e:dcff with SMTP id d75a77b69052e-4771de13f51mr88067311cf.13.1742911005334;
        Tue, 25 Mar 2025 06:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+bjrW3qy1jJkHXha130pv0V5DkYmNYCdBX0USZFkxoEZBO3/5NEu0ewfyB/epISxwClUwg==
X-Received: by 2002:a05:622a:1883:b0:473:884e:dcff with SMTP id d75a77b69052e-4771de13f51mr88067141cf.13.1742911004890;
        Tue, 25 Mar 2025 06:56:44 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf665dcsm7788319a12.13.2025.03.25.06.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 06:56:44 -0700 (PDT)
Message-ID: <8e301a7b-c475-4642-bf91-7a5176a00d1f@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 14:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e2b61e cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gGbnW7COpTo7U3-rSK8A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nF6MKdN6YgjpZgsWFAIo4hlJ1LVWD32J
X-Proofpoint-GUID: nF6MKdN6YgjpZgsWFAIo4hlJ1LVWD32J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250098

On 2/26/25 8:30 AM, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>> downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Drop, file was named entirely different. I see other changes, altough
> comparing with b4 is impossible.
> 
> Why b4 does not work for this patch?
> 
>   b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>   Checking for older revisions
>   Grabbing search results from lore.kernel.org
>   Nothing matching that query.
> 
> Looks like you use b4 but decide to not use b4 changesets/versions. Why
> making it difficult for reviewers and for yourself?
> 
> 
>> ---
>>  .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>  1 file changed, 178 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>> new file mode 100644
>> index 000000000000..ffed23004f0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
> 
> What is "x" here? Wildcard?

Yes, an overly broad one. Let's use the actual name going forward.

Konrad

