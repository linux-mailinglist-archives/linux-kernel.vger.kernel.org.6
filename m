Return-Path: <linux-kernel+bounces-558239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C69A5E33C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4B17A810
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB21D5176;
	Wed, 12 Mar 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHSpzQGT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682222E402
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802310; cv=none; b=e+yl9RidLm2/9gGAFlHyTQba5bVWG3JkJFGo+IRW7//jvbkL2ydIGfd1eZnSyma1DPuWsATZA7YxyNZPtb2FPpHKfguQo9Ek/ESzSp2ho5+c/pMGwEFhA10SCTESvGHSOMp6F1AXnmIeAp8hFiZxVE8/UhHMwKCsIEWkvAGLOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802310; c=relaxed/simple;
	bh=uvYktSUDIlgIfm1VyG/fJfFUevPD/r1/YdI4XOAcXWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAHhoQYvJVKEeM065YQHZzBL6pUs9aroH3ByQV8H/sy4KpTYh7qWV/4vIHo/wZuQ1JbWSDqLeN7MAgJdIpMDd/dOQrTucme2BzRsz7cTRO2PG91CZLTMx3z+AWA5QZPOF9BZAS9B+osAvFheaScxjZnW2tGFiRJyhhRMbW+oQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHSpzQGT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9pXGL027330
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcTeTYG1dmdjENwEPbzmb3bLZjrAYqSsiRBNKAV389s=; b=ZHSpzQGTqka+BmGZ
	vT2pl60wzbrgSxjVyOXc65gNtrirPJolQOO7cBxM4R8fPuLQDUj8t3B2gjVj//DW
	UWoOZTgcrNQzxlNmToRXkJ33wdCUM5lpc0wjKtqxyj/WLZQKfvCuMInHTXG2Bdf0
	o7IJcoZduY/l17xV0QHw7g3F4l6ObO09EsF5iRFODk13sc2eTSgj86Lok5xAM4fL
	xrx1BPVAXnlMkSWKnuLnbFc+f8GtyLc0pqfjqHbAHqr09l9j2yyxXScJAx+i3AVm
	8TO5UhLnosEGtWsiqtU0+WekGH1J9ut2dFeNfmplvHmI9nqYrwucX/+S1ZiU+Uuy
	pocRcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pu87t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:58:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4766ce9a08cso110941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741802305; x=1742407105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcTeTYG1dmdjENwEPbzmb3bLZjrAYqSsiRBNKAV389s=;
        b=UZkB9lK70XWCX7lWMttbt5cxdsfw71xjSOvWdiQOa+tEP70UQB3DBZ/Z2lA7hvRx/M
         kH0rPhu8Fh0u2NOL2zO+41sXgFXGYhQSYaOXVoKWuJItf90zBqWNXOjwzPtJG1Xup+zb
         ZAdd++4qDwmS0Ndlwa1dBn9WaineRoq7UvXLBF5nfOnxT2zm86GeBdbXGfizgYuMO2GZ
         21yrKHrtzB13i6Hnb+CpQLPN/CsUA+ISF0RWjfh7XUUl77OdksidYPsFKeic2Kwr97HS
         ODOms8OdZt0Pznf6nb0dD2EkN6WKa3xUnH/YIgHqaQ9NNvDarzMWJiOLsuGki/TMspCo
         DE8g==
X-Forwarded-Encrypted: i=1; AJvYcCXhY1GfNsmNPkpA7JI4x798FPzz+qCxLNeNat9VOgrRjjc07mI0Lj7YyLhaIjGxVPQuNbTKoPxA63DIHt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATVESnnvlWtKpXh1rQqaPKTo/sTc+abIGT4tfhhMuuJ1Jj+mx
	IFlwmia7WJgH5MYQbmdsNe9F7haKpmmk4WTCZhANtTDEYdACUa/hj37RG52JxRFU5YudCAgkoRw
	MNSmj6lvuOt6R9uCXsz9292gmzo5VMS/Z5dYQ2xr5YyssKF7tz2F64GV6OXsNf7tA4oT4FGc=
X-Gm-Gg: ASbGncsS+WpHmiCiHfzLTvogPmxYQ6vufye6GqZMTXny8Lq+MrvaTFghI2BR54Fl0TF
	xkryeo1R0t/vVBuv0+oMKgfg0IIKtWPxcE/wSFsMrYW8FbzvuUIFGSVicbmpwnjzt+CYg035OIf
	59OvB2tB4H+tA5XgW/ZtqTvbtp0JwyAuMEKEZq7uy7hnJl3mVq5HZnsoGKSVKUmKWieF5Ra11NO
	i+1DXVZmI1dtu0nFDrZfbPn5oZ3w4JHAIUxBCjSdM2w1nEJ0UFIJcELhpI4guUE50QU8p+q6xnO
	1n9b05UtN83OiRj2Hok1S85I94UfUPH/ZBBp1TJSJGXFcn8Le2eyQnaXHLq2ojMBdtqqFQ==
X-Received: by 2002:a05:622a:188f:b0:471:ea1a:d9e with SMTP id d75a77b69052e-476996165cdmr49257191cf.12.1741802305133;
        Wed, 12 Mar 2025 10:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf+FgkDZ8oIXLKhFtYSMaoeFm9wkNACMQAgHhTtOGru/FQSONXO2zQ9boY9KqzBJU1UuHtiQ==
X-Received: by 2002:a05:622a:188f:b0:471:ea1a:d9e with SMTP id d75a77b69052e-476996165cdmr49257041cf.12.1741802304743;
        Wed, 12 Mar 2025 10:58:24 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm656739966b.132.2025.03.12.10.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:58:24 -0700 (PDT)
Message-ID: <59de5023-acf4-4f2d-b011-62ca96c597ed@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 18:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add reserved memory region
 for bootloader
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20250312094948.3376126-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250312094948.3376126-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d1cb42 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9vFMFxKz7TJhonvdC4kA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 46ObFqJD6HRf5f7zn3g8w1tdoq61r8Vd
X-Proofpoint-ORIG-GUID: 46ObFqJD6HRf5f7zn3g8w1tdoq61r8Vd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=623 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120124

On 3/12/25 10:49 AM, Manikanta Mylavarapu wrote:
> In IPQ5424, the bootloader collects the system RAM contents upon a crash
> for post-morterm analysis. If we don't reserve the memory region used by
> the bootloader, linux will consume it. Upon the next boot after a crash,
> the bootloader will be loaded in the same region, which could lead to the
> loss of some data. sometimes, we may miss out critical information.
> Therefore, let's reserve the region used by the bootloader.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

