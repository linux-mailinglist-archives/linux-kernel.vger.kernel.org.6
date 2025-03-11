Return-Path: <linux-kernel+bounces-555942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9AA5BE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9D51889664
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009C253322;
	Tue, 11 Mar 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKi00e/s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA253331
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691599; cv=none; b=BOfOVqawDZZor7fBwuaUfMSYBZF/hAUoeb+VSsft5zPiFqq8GWWIh/sEXPogrn7B5tTmlN30N2sMjFP5gAChzNQVrGTPbd/aN1xQbXW0eaGygoAEhMTIMnAJUmm1jtqab+FMCGr3vygIP3t+TkFkCTsY0r5nzfip9BqeQmy/Ggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691599; c=relaxed/simple;
	bh=Ra6+7lJrUIPevP7noIKenkar5W1k++Vb9ESz2RdB9PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu0X5v/afWLA5i+sbixJa96rvS96IlHP1TP62lejlOFSYXfiA0xsR0KbaOiDJQsOMYMEUm54juS918RmEbeDqTF4bwGBAnYki8aYvhzBPvEeeZb2IzOZhrKi5xnUXKeEWEX+dp3sEKG1tlWgtIzB3I9keEsHc7YFZsPUVU9zbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKi00e/s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7lU1V031498
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V/N286/YyBPtB8/Oipndi0mCxpCa8oeflWDE7Iwumw0=; b=IKi00e/sEKm99vla
	iyYsYHGAHHTPDpKbjQPGFee7KyLGWkisG49lxJpAG2FHNg4KOPBFhEVyc7S8usnL
	HvKwSTEfJjuLQrdLlsoEI2NG1ReYqjmj3PHJiCkeEsa4VSHJ8tMZavWTGSjvw3Mz
	zB852qAeCJTvUqWXsMFGU+shoe7+txXuIcufBswqbEcZxM8Dg6eYLUfHAOpanqcR
	7DddfGpXo/hZtzhPAZzCYBaGJoSWwDQNVJwWTiyWgfDt2CwMLXhqsEfJyMzW77pY
	Tc5wjaehZnjdf8bXHeLKjZm/KQNxJSc4xtxbzNMukI0aVdNLnWhAGRATM+9ItD4D
	o0BFMg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah3krnj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5466ca3e9so45583785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691596; x=1742296396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/N286/YyBPtB8/Oipndi0mCxpCa8oeflWDE7Iwumw0=;
        b=lUX/yfWF7p+fvQd7xf+aTA+SDyajJaJPQWNMqBpnPRJ7KvAImXqFkedBogV/dQP2IQ
         Q2PXZNwpaZYBFDs9GndDiVH6RRzBXj6GUBWDTzIhU0hUUad72JD+9fSbTi6L3iyJIUnP
         2Q2j3ZysLgS41vkxU82hqWVTCo8B22gXc1pIjjXUQ1zdFqOpNtqOIoDz4L7HdD/FXZWr
         tbMDs5WWHDryIVSuBohS6M1qWn/nb1dfqIJV7aLinAWmWH75/0xJMR+n6sqTl2UVlrEM
         2GeaaJJhAajHeYIt27QzhJxb6JITAinI/ngkkyW/sDwzL49jf81SVFDcp0IJeYwJs/CR
         V18Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcLq0zzu16g5nFA72/QvcHvlHOxSp76n8V5FUvcteqV2F7Rs7mLqnhjCd6mOC9KYhPLqjAfRemzu1f5vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1M6YR9gJpuT8SL5ntP8O+7AjpA8CRLrdYYj/ncKQvgKdsptg
	hCzXEJyTYaQcYhUQp498YiOPt4Eq6XEFR0AV4OKrx3cwiPSdtGbNvoNwy2Iq9B48dnQ7MtCn2yL
	XeVURwzAhkoax2Zb2dspNf5Kaz2YS8tsxmI14lSF1WsMnDYpOwTVPX9SNHAlHq/U=
X-Gm-Gg: ASbGncuXhxIsUAevmnPC6Buq7mlCDrGItmeEtaSmoWqZKrf8aDXQYKqEEl9Afu0SS5y
	py/w12SABuBE8vFwoU0Cuz5bAkVa9m0FkLtTLpKsNqxkz/x2G/j+Dhw6Kv417nyvXtvZ+eeO4HB
	Nkrq96xkDX5UEGt1gVlWv9qDG9mB0p4Q3YYjGYWQkDN0isEAP/QMACyzDnB+H4cIW6sPqO9jbEg
	ugl1s3OfqncLpNzOh/D9AElgAUlEOVBjjS0KNu3Vb12TKDgEt265qr39PjY1cca4avt+rldlGOm
	yj8NpWCO813I1tXEuPcXAFkAO+wdXzNG20Prj7S8AJybUKQs5eLopbefzvuZCxs3RBjiVw==
X-Received: by 2002:a05:620a:2681:b0:7c3:dd6d:54e4 with SMTP id af79cd13be357-7c55e90cf5cmr174343085a.10.1741691595835;
        Tue, 11 Mar 2025 04:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1jOQ3Fr9/vIuI0mJfYp+Lr0Hm4fdkmWnfp4OkO2xn0v01ZBJ5KvygN9gwxqSMZC9qQqoHkg==
X-Received: by 2002:a05:620a:2681:b0:7c3:dd6d:54e4 with SMTP id af79cd13be357-7c55e90cf5cmr174341285a.10.1741691595503;
        Tue, 11 Mar 2025 04:13:15 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2811e5b32sm507919166b.159.2025.03.11.04.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 04:13:15 -0700 (PDT)
Message-ID: <3332fe69-dddb-439d-884f-2b97845c14e1@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 12:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I8U_eZ9RvYng4eP9td3u31oOCWGomV2K
X-Authority-Analysis: v=2.4 cv=MJiamNZl c=1 sm=1 tr=0 ts=67d01acd cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=lN5UOK94kOf-3Ws_NdwA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: I8U_eZ9RvYng4eP9td3u31oOCWGomV2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=732
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110074

On 3/9/25 6:45 AM, Krishna Chaitanya Chundru wrote:
> PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
> maximum of 256MB configuration space.
> 
> To enable this feature increase configuration space size to 256MB. If
> the config space is increased, the BAR space needs to be truncated as
> it resides in the same location. To avoid the bar space truncation move
> config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
> iregion entirely for BAR region.
> 
> This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
> of DBI and iATU register space in BAR region")'
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

