Return-Path: <linux-kernel+bounces-433778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A69E5CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4841884BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BA224B19;
	Thu,  5 Dec 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AolqaUjO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA622259A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419187; cv=none; b=IWjW9Aqa1Zfg5MIV4eLWeTjDtxUFPGKDK+i/5wLBOB90U2C2GKL4eOba+k+QZ8bWZPtgfyI5P188M769z4u6iuEjIeBZPZjrA0mYTnmgXJHiVqksWEXLGnt1UUF931miiTNeViB0EVyCxEX0OhHk8XnbcFnM5mhEjof9wZMg51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419187; c=relaxed/simple;
	bh=lYUjWc6zjIdoVN44M09qv+uz55wgl/dR+Cu8fHg5GZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZQ0XW2gJ04Z9WI74ZoYwRJTbLHQv0k9RSH12cxvhUrUTmyPXXOdCIpu64kF1HJe+0E65BqT4qqm6vB8451FJuhxFVU0Zasq4GEvTGg73q4Mrk3nYh5+PHW2/3R118eaYmcf/IOryxmOJV8iOwQgGdfyqUA2jV/0gs8LZhd9wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AolqaUjO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5GmVva006036
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 17:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lm5ndeOU9990FRIjr0qyFHytkSEpGFifKLWwIXMxeEE=; b=AolqaUjOIngK9iOV
	pWktVOg09Db03+kC4HTTv7tj36rXe+nTAdZHethGlEQZEPYleAaszL9/dmvjq0sg
	Gf1CP9QNu2izii7tf4K2e3ggJxwQ8UJwjw36r1JEqgFFKtUQLt/WYwIjLO39sYKJ
	3cULLaqhGFtoE7OYfLSlggiOOmijVpBvbkwekn2cudLwJDxBa/3s5EiUOlAuVbMR
	ZAsDbrZy8o3+JBDPJiJS3LzrW08s2+PwtkLsA10HTLpYSHpFvKD07aQnu1YrP2hw
	5yVs48nom/boGOT1zTEeCWhS7AnPxBpUt8pagPe0K2+4xx1rpu7ajaHs22ObAW1F
	B2q/JA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3ercb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:19:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668c9aa8c7so2992181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419183; x=1734023983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm5ndeOU9990FRIjr0qyFHytkSEpGFifKLWwIXMxeEE=;
        b=M5bN+1ojwUsLqzwO9qAmPDFq7NaEPCQPhQYhvScjLVUNdb6D8gLefOkGbS6u4MM2p3
         igGKBypF4E5MeXKAEgWVJTUPvd8d5osU1xzltCFamn9rwpJazS4gkRpdHko4z/yjFGhP
         uljC7WmJpk4uoUdzVzsyCj0kbT4uMRQ00GfwjAk18ET+HZqsqHlA6kFWIq/hAxbvLeQd
         7xsPyCIBqNEm1cB1XvAzmzH/IrWPhtxMGsg531HKMwwMjzs1fSjws9QVKIl2pNAZwOl1
         V2pUVh8RM8jrYtpndCjWzzYK/pF4FxqLddwnl8YalzdKojPMu/KwnidFmX5th0Iw2M+0
         xReA==
X-Forwarded-Encrypted: i=1; AJvYcCV2YmQNtBgypvHaBlHEWdFYu3rrXGhHTHMD6llX9iHPks8D9+AWsvRGAYK1u8GIevGxWOnKZUcKxNrRgP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7n8LPNdX1dWBa/4iKohGIs+XaI88K1x101DObJ/FW/k79vm0L
	QQFZTl+kJyQMBUwzmDmEq13rGackIqw64DQU7S82dgYCSCHS8WlMOGtAjimGwaXJOUdOQXpRdPi
	j3U0qmMNKCJ+VBd5b3ep5/WiZ4vivrFAB7xEVFLDNxATFvUR+W/mb16IYcAa7yjQ=
X-Gm-Gg: ASbGnctabQavfLOCOEkc/N3eQvni2SXu+xDbA9wJzr6pZwkF/U/K/h4glt44YjOOb25
	relU63015NLCqwXUPfO76YWHtGzC0K7q/849CPEAWqGiUi3riEyad9etfRqEKBKKOQ24EFvuqBR
	Vj8TWvYa27y02Dme3mEWKdbB+Fd6MenO41VQM2hrs8emgZdrrCsJgPXd9p0K+7Y7Fy+BJ2l4hsO
	UsJ1mgvXaEMBik/2hGU/INMZaeOWjKeu7fZ7bbOyE8vGe7E8NzxqECiybXc+XnRUjvDeIBUqwqA
	FlsYGi3SlsfDgopSkZzkegwJpsQPLeQ=
X-Received: by 2002:a05:622a:1811:b0:466:8e17:cd1f with SMTP id d75a77b69052e-4670c071462mr65629421cf.3.1733419183508;
        Thu, 05 Dec 2024 09:19:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJmOBmk5E91zDvi4GqqziQOrLODRZopwm1Xkdm3u7K10bviytIQBZzrpav1hnIkMXbYrY2A==
X-Received: by 2002:a05:622a:1811:b0:466:8e17:cd1f with SMTP id d75a77b69052e-4670c071462mr65629191cf.3.1733419183166;
        Thu, 05 Dec 2024 09:19:43 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e048asm118968866b.175.2024.12.05.09.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:19:42 -0800 (PST)
Message-ID: <02e2640a-22ce-4586-bff1-7f4eaa20cd7e@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/8] arm64: dts: qcom: ipq9574: Remove eMMC node
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
 <20241120091507.1404368-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241120091507.1404368-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nFI0-buTgAPt_kGdMdwptsym3yG9J0aS
X-Proofpoint-ORIG-GUID: nFI0-buTgAPt_kGdMdwptsym3yG9J0aS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=722
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050126

On 20.11.2024 10:15 AM, Md Sadre Alam wrote:
> Remove eMMC node for rdp433, since rdp433
> default boot mode is norplusnand
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

