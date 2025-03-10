Return-Path: <linux-kernel+bounces-554129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C8A59350
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E97C7A6175
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C422171B;
	Mon, 10 Mar 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XxFhFW0v"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46022257E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607954; cv=none; b=WdJqAXFUS3rM+VX4XJUYta7brnC0EPjc0TAmYT/rQej5BYfU5p7Tt0TYhY4IirTY9H56+RRADOJotXre/4fwa128U4nv165pyiCHWoWERCNKU2kmCTKRZo8aCLdpJ/RmQjhqZPRbUGru7bq5lW2lO+Uh19NLGjtJ2HC+UIvS6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607954; c=relaxed/simple;
	bh=vZZ4vyDwh4ny5i1Bv0bpfWfGLBspHIiStvxiORTJRRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvSqVffNbQ39/Z6YPqcqm5lOp5Ow8jag4OQquRbvTL3npiGAYm3KQ/jYU3u6LkP4WMw6vZj5SSDZvWqZ8W1Kwp+5UDWFt1HsZ1ALUFCyZqcqt251gxHpn08mAXL+R4xCfFX5yBe998Ajq0/HLBwXcc32InWXJabRQU1qYbQ8XqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XxFhFW0v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9eiRu029201
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wZYqEqO7y6IEW6xhayczjh6S+v5v683/p7g1JEP0aCU=; b=XxFhFW0vNsnc/ir3
	2av0KwyB+HzN5+TOhSuWWH0c4sCfHHVTTbNtuoLAFrlrooTb2nD1D6BXYR+wajGT
	vueamw10zipsEvogC1ZWzUKFPS6fZGHBEirxWukSVUGCrPGyiVKGDFCjyZrnu2sl
	IxzzI9lJ1PhPtYabKHYIrGcyKESr6DsBujkLefRsK3gUD+5XbVUYAtrnfXW9IX3W
	Qakjs8FolphfmnYS1iqVRqbFkgcHhWWzOzfY5wwa7rGmEA2n/dPW+VUk18k2I7Th
	CgMMk8g6/6Pb8P4mqr2LDKWsrZTYJwuC0iQ1Akh47ba4oO6jlF79JhzZDhERMxAg
	aYfW9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0w4qvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:59:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fb83e15fso13466706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741607950; x=1742212750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZYqEqO7y6IEW6xhayczjh6S+v5v683/p7g1JEP0aCU=;
        b=qu1gljeufKH8jm7Zl1C7fSQx1nsWLvSZ3h4MszS6l4Usvwu6zRMTXad9u4YZnvDZXU
         8NLn/whn4K03H1AfzmDJLTarWW/LXdQWMuBzPjnsnM0KZpo7ONexRgYE0bQbBNcMVgDt
         DGrfj9ilmEXAdJSGaC1c7BS2XnySRaLh27N0DeRsgjMURSZjqiMZFuzmjNPowiN1XE87
         XIy3Pvm54SPo9VQxgSHO2Q3Qgn7UpJ+P0n+zaqHnBIeKOyTtvxUTMO0aNf77ZUxWxSht
         dv6K0Oq+Pd2tvYPwOw5JO3OyTQkM3J2LOWzlMbrHvS1ktXspF3XjVvCzX741Vw/CkT97
         vsgw==
X-Gm-Message-State: AOJu0YzJdw9s+hUzzxFC4avrysV0PqmFpHTU6Zp+45Q6xYAQlfm4BG3P
	WLsn5CWX8zRL/J+n/S3+sgsKxsJRmmsHSaRNiDwf+VGvKTLQVymo85fhSOKwvqGYzA43eoaB/XK
	h6bkAG+K7saQ3OkQnorG0dSdBATLz/r9xfhzJfnM3xzqyXXc89pq8KXuMSa78d68=
X-Gm-Gg: ASbGnctR6U23ExGFmqYw/Uj79mrLIzzHgwg6xM9ZN4WYpLezzoEVTuDDb63sfACj3zE
	YW/l436vgVihAYJbaodw0IqSIDckoXlI255+XGjj04yJX2Z2y31ZGfARg4fysrzB4qUr+uopIJp
	VtJJvTjDoPdTowJN3MDBVCqzysF7UxqII4M3c4i8D/+8eLaOBt/ha5LSuu8V51PrT05X5SFDy2k
	AHZwCU/7ITBh7eFJStmPRbN8oF+bM5ryQoFZLZ0lJ3qhU7W+zDMOwsBgo5HGcddCfVVKAC2jR74
	kJPrUZHKgoPqnK93irowPSstYTjq+CBNsGhhohXnnV5Ux1HPXZd/y7nDgrO4Bwk77W127g==
X-Received: by 2002:a05:6214:cca:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6e908c7af1dmr53814376d6.2.1741607950497;
        Mon, 10 Mar 2025 04:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+dc62Lb7cFI5B+K44MJO8WyhCF9aelMEmIDlnu0VNMly7eoQPTcUOinmH7PMZ6O8UBsYDSw==
X-Received: by 2002:a05:6214:cca:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6e908c7af1dmr53814226d6.2.1741607950102;
        Mon, 10 Mar 2025 04:59:10 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27e11c457sm378242766b.126.2025.03.10.04.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:59:09 -0700 (PDT)
Message-ID: <9c64c23f-7e0f-4795-9747-a48f857e8947@oss.qualcomm.com>
Date: Mon, 10 Mar 2025 12:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300-ride: Enable second USB
 controller on QCS8300 Ride
To: Manish Nagar <quic_mnagar@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
References: <20250310104743.976265-1-quic_mnagar@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250310104743.976265-1-quic_mnagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kfBlfFilAGjLv9XXd40wCDe-6HXnsQ1m
X-Proofpoint-GUID: kfBlfFilAGjLv9XXd40wCDe-6HXnsQ1m
X-Authority-Analysis: v=2.4 cv=MICamNZl c=1 sm=1 tr=0 ts=67ced40f cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=T_qEUXwVCjydKuttoeoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=850 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100095

On 10.03.2025 11:47 AM, Manish Nagar wrote:
> Enable secondary USB controller on QCS8300 Ride platform. Since it is a
> Type-A port, the dr_mode has been set to "host". The VBUS to connected
> peripherals is provided by TPS2559QWDRCTQ1 regulator connected to the
> port. The regulator has an enable pin controlled by PMM8650. Model it as
> fixed regulator and keep it Always-On at boot, since the regulator is
> GPIO controlled regulator.
> 
> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Manish Nagar <quic_mnagar@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

