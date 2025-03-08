Return-Path: <linux-kernel+bounces-552543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA489A57B00
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C653B20C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469661DDC07;
	Sat,  8 Mar 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRaYzBAF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903B13E02A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444211; cv=none; b=pghj4pHcCMiVQbn2sO6dHbPObaGUMcDtAVOoKgYJO4HTwtI1CSvkzyixailKmoUtnaWzczu+Z53L4AvRwVBy1CgZthoxl7+7NX8bz2V+96jeVtdE7h2qhl7hAxEAtdl43mhRP7D+PK/gd/pHuDfXOzWmJuo18D/iWaZXOdxaiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444211; c=relaxed/simple;
	bh=F5qBzGxYOLt9eCgdLnykjzrwTu/UH8kucdR9MrrYK1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSgKlrjV3T+J0PH6YMBYXuKIr33AJEItzFPZtqrLWt2SAkEy4uwPb5QiEBbyAew1OCMstZ2xEXegKuGj89k/XMk6VgUpcmKyCiU7qxyAhYd/alvCNrnOUCMHuKCfUOoz1kq7y34Ai9I2u3guy0RiiK6mv9MBzmwi5aEYhFOD8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRaYzBAF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5285ubM0003692
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 14:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hiRrV2lDctabAYQ6GC4gGrhzwcW37m/6E8TpuE76Wg4=; b=lRaYzBAFRcrmmDJ1
	n2vJHuxWkLU2j2SFdypC+JDu0hAM6tbi6AqKAoQ9nclAaHjVBdWkTzzefGYhwUYD
	IpUdedjqFuJEKQRCnqSDsbJzpJlMLlHo5mA6FQXNRiqG7KMM4vVBm1H3CapLHiu4
	EPHUvqHgNVTzeU01XZDkSyLdovCAmNhl6LnC1CnHZM6QucABksnJWAHcT4qjbQv4
	SlCzx6YwcPwK7Ehnsq/6At8PMV7Xb0tL1/GsAoZLFXoz9MOtFGHNBSaLTUgGg3HG
	UwR2rOJ/Y3UzyMLZbSm7iC1lVjorzShmUyJ1NiNax2jkSfUoOvnbOw5hGs0km9Ry
	EHaR3Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewpgpbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:30:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53d5f85c9so14229585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741444208; x=1742049008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiRrV2lDctabAYQ6GC4gGrhzwcW37m/6E8TpuE76Wg4=;
        b=ctcMuYKLp59u2N9McCSh0Ajlhh7QgLB9ybguuscbgW49ZJb1tfY1/4RrNANq9Msuwa
         KHVz+4j7SQ0xF00NaTQJypvd+es1Tdp8Q+XpZRjbCFg+B04fjf6lrlH+w3A1nzEGqA/g
         KKxBKoOYkmX/Tbe7najFAdmmokntGs7X+dcOIU7Vc8psDCBuO+w5Xqvgy8mSJeZOqO7g
         K0z/Mu6fzBIV2zwtFYRBAr38FDVYcnTS5FFfdYwSJBByIkPEzN2ih2cQXSBl3foPYn2U
         fSmTj4fY57yRad0yPnsOGrxVMbLjD3LW+uF2kldNn/H5DfPsGLVZ/dzD381wYsHIaLOO
         hqRw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGF9DrKm068R26ogpkubE642gwJeNuWr+idBVDxtimgTCIwCsK0Q2khvWL98dpo4yPQmfrLSSsUSOtF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvgJX/hFtUHUk/GAraHAjMqvPAxsBpxE/ov8H0ta2mMsdh4aV
	6d1NI94FibQ4kbch1ASChhzjxCWxF4VBURxHAeenent6/hV7xYBRxly1QRJ9ZZ5O048k7/twaCJ
	9OwD0Z+AqGpxtJQPRYGiFPtDbU1aNekipJyTUPQYOtrcMkUCHZJXicAWFDfr6LBk=
X-Gm-Gg: ASbGncvMXHQkCpLgPE7Xeoh8mdG06jbpzcLNjd6J8TG8p9EL+uKWhs0yWWuf5FaZHYa
	VPp+g4tbbqvwoCDOF8siYcm7r0pWjnbvAk+9sIPDNV76ppu0WpRdvhad5I1ynwmKFf7olj9Xg0r
	T6ly2fVd0sMFe1AI8tI1NTvBsTX1M8fyJnY7rJtaXYuHQGdWHEjCsBMc7UawggavVAjcCG2fQHJ
	TO4dyDKB8lZMxWorrXhKOxZ0mOxnujauybfe6lUkqx77oDWGN+VnciyCPEjpTsE6WNGZDCPs91d
	X1JkAuehbngeNHhdoSsJlH9PM1ckEO/LU6Dmx+CiPo7TgyS4ex0CBmngUaZDjV2igx9otA==
X-Received: by 2002:ad4:4eed:0:b0:6e8:af1b:e70e with SMTP id 6a1803df08f44-6e908dab8d2mr14444866d6.8.1741444208060;
        Sat, 08 Mar 2025 06:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYzTmfYwrmQbqXEPPoiUQdcPwYzdBk1aldTn4ZYyfsbMEMVk0wKBrs3w6LhpEi2xGwz/bX3A==
X-Received: by 2002:ad4:4eed:0:b0:6e8:af1b:e70e with SMTP id 6a1803df08f44-6e908dab8d2mr14444706d6.8.1741444207650;
        Sat, 08 Mar 2025 06:30:07 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac284f76a22sm20376166b.149.2025.03.08.06.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:30:07 -0800 (PST)
Message-ID: <e7347992-acc6-4c0f-a26b-c646668917ed@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcom6490-idp: Add IPA nodes
To: Kaustubh Pandey <quic_kapandey@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_rpavan@quicinc.com, quic_sharathv@quicinc.com,
        quic_sarata@quicinc.com
References: <20250304152133.GA2763820@hu-kapandey-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304152133.GA2763820@hu-kapandey-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mxZxBzvB8lrYUB-mNT9MzUY9yzZaH_hf
X-Proofpoint-ORIG-GUID: mxZxBzvB8lrYUB-mNT9MzUY9yzZaH_hf
X-Authority-Analysis: v=2.4 cv=C5sTyRP+ c=1 sm=1 tr=0 ts=67cc5471 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=oJ5fhsqBAEL7t78JBU0A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=807 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080108

On 4.03.2025 4:21 PM, Kaustubh Pandey wrote:
> Add IPA nodes for Qualcomm qcm6490 board.
> 
> Signed-off-by: Kaustubh Pandey <quic_kapandey@quicinc.com>
> ---

This is a patch to a devicetree of a board that is known not to boot [1].

Were you able to confirm this change works with a relatively unchanged
mainline kernel?

Moreover, is the IDP still used, with a final SoC revision as well?

Konrad

[1] https://lore.kernel.org/linux-arm-msm/20250206-protected_clock_qcm6490-v1-1-5923e8c47ab5@quicinc.com/


