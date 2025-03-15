Return-Path: <linux-kernel+bounces-562593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF7A62D8F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4020D17B161
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48E1FC113;
	Sat, 15 Mar 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBkd3Wnk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C38F5E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742045862; cv=none; b=mK3dxxW2S541eFeyKn/5RfBdjevD/39g2Co3M2nUMSsDN85/2oWPVC0UVdb8Q1i34grUeTPnAwPk+W0iVI3jvJiKyl+F4M6Us7xesvXU6doXjltYEBi8HiskBkRh/LYr/cZAUkU3h3StMSF3tws0VPgd5umBmqt4N7/ZZWBRoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742045862; c=relaxed/simple;
	bh=M7HCNxc6+ULLaGJ60tqlxMwe2/03GnpwEGTUEfOUeSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw9dzHKuAO+Fi+yomT//buMGkPnr9DCxR/nUZ4+tyfEU5yfGaVnyu00zMONmvG2UfQOIDr2hlYHUqYXK9VA6L1AeHPSb9skmm4S1/A8W6JrglQ+x9RAL5gVyxlYfOGR5rBJuAJQ2bJgMppddnhtf/X/yKXxQ6iMlph8IjZYHzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fBkd3Wnk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52FAU0ab002370
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6DWUpv1hI6Be51QFuZOBU9rLiz5KUxl0EDZoZvkV/0s=; b=fBkd3Wnk4IOKpolZ
	HKDSZDkKWvr95ITEgJQ9hmEUVDtop/Y6bkNzvEI7QBYOxbXv4TitOncMlMuUo2If
	fhTn5Tl4YrwN/fbhacLcbP400HpuanLuxsySf59GcbK0ck0RIvievfbRYMkWlZx5
	dw7sRhNQtjJJ9CFtq+lelQce70XMJK03va0getE8PVz4cnYsL+tlG6w1aAeX/aRc
	UgIoDk5lGTGACo8/BlLOOgJjUs8P4oe8VVkZIXvs5mNeFcAxYGN+R72sMddcxdqb
	towvq80/Hwx6+/H1F7JU+DwcOZyOyF41pp2yhcQLKjzEvKEOdt3B7LkzGZuBaxDk
	h9D5Ig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2ah8pg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:37:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54734292aso36462785a.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742045840; x=1742650640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DWUpv1hI6Be51QFuZOBU9rLiz5KUxl0EDZoZvkV/0s=;
        b=be9W9NoKQhBv7RKw60xMfzXtNPr4S3RT9RTmBW4hJiIKwYrwt7Yw8Vym1JLd7Zf9Z2
         h5u0YjjLvsAR6PBLfzQaaeo+J5QY/gVgG5ujPyScCEwDEBkDADzGhJFxBblxnOiXZKVP
         o048wVGrqrX4dAetKQ0BeoAzN9V8ku1wkYTQ/7in1GSEB0tMADZzQd3OBdyQ3eNdjrcb
         zxfrbic2Hc3TPtmF4PCXr6MBDyMxQMZDLSZ5LU6CrwcIImVAxNA6vn92CTRkts2h4Ic0
         /sUkO3kAsbpW7/1De+1bYWlCLECgjdMy4rQsXc/1cDJ7gQEsDJCV6pZZBLuKdwe0EBra
         J2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLd2QJn7hVhyV8qPdN2z+a3HRfHibydZY1pjque5SVRZh2Gkm4WB+fqUoWzi1SaPKBR2dzoy1D5IOwRUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfeI3CsWCaXNNCGegJw7WbKcFLIGxaSF4wubXd0T/4BCbVMz0b
	t6qecPoIzMoNevPFmK6337idjoxiFxiQCy5GzEec3DoyR/VOkYET0m9KXedVjIfVLYrQLb/k6Tb
	5rkiRiRpQLVnyxiLF86j50ZlYw9c8PD7JfqjMPVrQihqV8+LRHsVKb45zD744qoE=
X-Gm-Gg: ASbGncsqBIT3cvt9fAHxvP9YQTokYPrd6w9Urp8BXOhnCwsSynh/F/jCcLE8Sa6QAC4
	H7Db8ajQjxGzM038Sf0JW45E+v4Lx4DnGsIjqmUIkdRAY4VuYQ+vOU72HX4YZ/nNlu3UHDotzPA
	3NxK4ClvfBg/2uHtH+pKGyaWPYJK1tdR7e11i4EsZi2L/tMLxhqTWDiA62BQoLNqNLnpAnJjhga
	AiexSiI4CokhRoU151Zl+utzPeQ6FDeuOdajFoSM6vBGgJEcF2wHLijwWSuiX3G09fvOPAkKoG8
	+eVPCLProgh66RUoUXJLN9mltOctwRHMDN57liApFIeNjl2HHLzbTxktpNcR3N2wNvWyog==
X-Received: by 2002:a05:620a:a10c:b0:7c5:18b7:4f25 with SMTP id af79cd13be357-7c57c80efbfmr243596385a.9.1742045840329;
        Sat, 15 Mar 2025 06:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5IYQOLUaJk0sMyhujqGoj6BeptOau5msBzGVpujPDlMP4SRkuy4eNYMV6ySVlRgZ01YD6SQ==
X-Received: by 2002:a05:620a:a10c:b0:7c5:18b7:4f25 with SMTP id af79cd13be357-7c57c80efbfmr243594185a.9.1742045839950;
        Sat, 15 Mar 2025 06:37:19 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe25fsm3217460a12.78.2025.03.15.06.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 06:37:19 -0700 (PDT)
Message-ID: <a6779d4b-d4b5-41c8-932a-62cd17c9d021@oss.qualcomm.com>
Date: Sat, 15 Mar 2025 14:37:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Fix domain-idle-state for CPU2
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250314-sm8650-cpu2-sleep-v1-1-31d5c7c87a5d@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314-sm8650-cpu2-sleep-v1-1-31d5c7c87a5d@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ySG0xT2kOIYhfScSdyNRHHvljmUChMMf
X-Proofpoint-GUID: ySG0xT2kOIYhfScSdyNRHHvljmUChMMf
X-Authority-Analysis: v=2.4 cv=R7kDGcRX c=1 sm=1 tr=0 ts=67d582a4 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=pUt0LEAnZhKoKCINpSsA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150097

On 3/14/25 9:21 AM, Luca Weiss wrote:
> On SM8650 the CPUs 0-1 are "silver" (Cortex-A520), CPU 2-6 are "gold"
> (Cortex-A720) and CPU 7 is "gold-plus" (Cortex-X4).
> 
> So reference the correct "gold" idle-state for CPU core 2.
> 
> Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

