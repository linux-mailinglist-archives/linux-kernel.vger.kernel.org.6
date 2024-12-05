Return-Path: <linux-kernel+bounces-432737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970389E4F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635011673E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278AA1D416B;
	Thu,  5 Dec 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Te7OWJPZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE851B1D65
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386938; cv=none; b=W4xB5gKTkzbYDIngvLmFp4PquA/Le8t9BrCQ26Pba8faYPjjIVFG5nJN6HEXLkq01nJ6R74GPuohaX5d4uDA6HBjcJGiDcn69mFE2UpLAThyhAW4m9UJiEhVOvsZNBe3jzszZ2YfHBrNaUOkV3khHVcwWwAViDVG7QGdytkcI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386938; c=relaxed/simple;
	bh=Z+F2W3hNh45ECvBXWOYNZwLYFFwaeFbyUbIMfbSXiCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clNq7lrvS8Ca7FGV46snSsxI6mDRzALS2rbHUQ7WKgdja6q18NQzlHMBsagof5wASHds6yZjmC7WDHYWXNUIUGIGdMGV28PNxrujKsXXMFL5obK3lXurFRep2WUEnHqRjHJa1t7vtMA23JlE7mDQoJVieRJTbuql/PeLXIe8GgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Te7OWJPZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55Qxmx023234
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 08:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pWaRHTtVbmK4IJGdoyqpW+GmjdnLJECmOOkFb8wysIg=; b=Te7OWJPZinloN6J0
	uRVTa8Cyn12VLWn/rJaYyDjHZcSRZHYD3R5uZHCBxhWEIAZRVwx6D085g5jPJStB
	DW+SV24X82KPLxesBbz6gcBgxYXjvuUa1tG15zHcE9SZG1HPmSvZXNxWlh+4+0sJ
	1h9vNHtIrltdfh/y33g1vHW+M8opxE+fo+3ymnhBKxrfOE0JAdYP11cjpm/HN3qQ
	WQs5Bn0XiYtFnNG+202Gc+28/lp4Jrpvo4siTFej5opdtbTRBd7uKr+KzZ2rmMD6
	UF2R9Fb/XnvxBl3MuVDkFjw+Dco5fVT55G2L6z6UhJYyLy8x2BTaFDYGyKCkDqlX
	AtQRUA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43aj42bhn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:22:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-215ccbcdc7eso9607775ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733386934; x=1733991734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWaRHTtVbmK4IJGdoyqpW+GmjdnLJECmOOkFb8wysIg=;
        b=jjKOPJLY/LTRSM8eouVfohbTVpgKjN013m7vUUhgKLuFfqgZQ6sFodtC/TnN4dgMtP
         JzKuDGs7T0ihNmyqzGJP4iJxhSSu9wunEBYoG/SJMA8OrTAG2iWxYDU/q7sWQORg7jZJ
         sUZNiPEp2E6kNoSJf5n+ITen0VrhFDoeLYH/8/LqUMiwnUppVqlL5pap3E7CzgxEX+Uu
         qt2dw4bNAOlj848VLYAwGZHJfYarxX0n3u5yjAah/3f+1cbSTPgQW2e2HhAQZPrvihZc
         CazXq9SLQKTvdMjyQ8kNK4QFturP48vZVvgHzbIZg4UJxvs7tz3Bho5RM2SG1O8iFGMX
         96gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVerKSoL10Un4mhIya2Ylu2JYlTCWU827nMPqhlOvXCNWaEm9ZJ/SJAzTpuIGHOj4QKT2bUDqc5w02wDpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fiupVhm0/iSF5czLTZclvPVX5Jsaz2ltFKcJTxxR+BSOhq63
	/aVtyvoNkVBDBMVhilqlXalMKrSL/ODe7uHGtVvVZZApZSxvQyBPod6IkTnSoX7IgoJGepvIita
	KJG2CKLwMThNjHOoBBMHV8apiYKFR25XYEAUKyNP27RAXmBXygWv7ly7AIBvNtEU=
X-Gm-Gg: ASbGncvATpGFZ4dZupISMy723TOQrNoLyjL2FtZImc4GXdHrD4b9FH6xJPh6mVcCBjQ
	ICBEZmZziNRSlslOKaJL1sf/cm8gfzUQZIjhTyqHxFRd4WPe9SltTwcZdFOxXz4fBdV1cx+TOFO
	pXbNuut+vTd46ko+Y+rFZfkRlR0kQG7v8EjwywHcCR8kK7jjmerY1vSgdtCDsHGUK1v0j4zwq2q
	wdWAOx4pE0Mc5VLTBfCPBLnPYMjfx5FsgjNbJEY1an3FrIWzpfXHKmhHO52wKL8IowxylFKSVLE
	muFr5w==
X-Received: by 2002:a17:902:ecca:b0:215:63a0:b58c with SMTP id d9443c01a7336-215bd24bb6fmr127418165ad.46.1733386934492;
        Thu, 05 Dec 2024 00:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcRbCkAcP5idjPLoolO7JpL2Ap2RjFZcB3DOTS1QrZrQiXx+rK9bxRV3fLK3OocETika1fcw==
X-Received: by 2002:a17:902:ecca:b0:215:63a0:b58c with SMTP id d9443c01a7336-215bd24bb6fmr127417835ad.46.1733386934119;
        Thu, 05 Dec 2024 00:22:14 -0800 (PST)
Received: from [10.92.169.167] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9ea6sm7453955ad.141.2024.12.05.00.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:22:13 -0800 (PST)
Message-ID: <e6f60ca6-a4d2-4539-ab9b-dabe95dd2d21@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 13:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint reader
To: Johan Hovold <johan@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org
References: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
 <20241118-x1e80100-crd-fp-v1-1-ec6b553a2e53@linaro.org>
 <Z07bgH5vVk44zuEH@hovoldconsulting.com>
 <d095ae2a-3f9d-464c-9dc8-a3e73eac6598@oss.qualcomm.com>
 <98b2b88b-9690-44a7-9b22-2f23e6606e82@oss.qualcomm.com>
 <Z1FhQ3OUI0t3k1_q@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <Z1FhQ3OUI0t3k1_q@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 67jPwshcqRxnA-LKEKBakBZKk4IbjMBs
X-Proofpoint-ORIG-GUID: 67jPwshcqRxnA-LKEKBakBZKk4IbjMBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=638 lowpriorityscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050061



On 12/5/2024 1:46 PM, Johan Hovold wrote:
> On Thu, Dec 05, 2024 at 01:32:29PM +0530, Krishna Kurapati wrote:
>> On 12/3/2024 6:45 PM, Krishna Kurapati wrote:
>>> On 12/3/2024 3:50 PM, Johan Hovold wrote:
>>>> On Mon, Nov 18, 2024 at 11:34:29AM +0100, Stephan Gerhold wrote:
> 
>>>>> +&usb_mp_dwc3 {
>>>>> +    /* Limit to USB 2.0 and single port */
>>>>> +    maximum-speed = "high-speed";
>>>>> +    phys = <&usb_mp_hsphy1>;
>>>>> +    phy-names = "usb2-1";
>>>>> +};
>>>>
>>>> The dwc3 driver determines (and acts on) the number of ports based on
>>>> the port interrupts in DT and controller capabilities.
>>>>
>>>> I'm not sure we can (should) just drop the other HS PHY and the SS PHYs
>>>> that would still be there in the SoC (possibly initialised by the boot
>>>> firmware).
>>>
>>> The DWC3 core driver identifies number of ports based on xHCI registers.
>>> The QC Wrapper reads this number via interrupts. But these two values
>>> are independent of each other. The core driver uses these values to
>>> identify and manipulate phys. Even if only one HS is given in multiport
>>> it would be sufficient if the name is "usb2-1". If the others are
>>> missing, those phys would be read by driver as NULL and any ops to phys
>>> would be NOP.
> 
> No, the core driver still acts on these ports (to some extent) even if
> there is no PHY specified (e.g. updates DWC3_GUSB2PHYCFG on suspend).
> 

Yes, since the port count is obtained from xHCI registers, the 
GUSB2PHYCFG/ GUSB3PIPECTL regs are modified regardless we use the PHYs 
or not but this is still fine. It can be considered a NOP AFAIK.

> And IIRC I even had to specify more than just the fingerprint reader PHY
> on the X13s to get it to enumerate. I never had time to fully determine
> why this was the case though.
> 

This might need to be checked. Did you attempt adding each phy 
individually ? Just incase the first PHY is not the one corresponding to 
the fingerprint reader.

Regards,
Krishna,

>> However do we need to reduce the number of interrupts used in DTS ?
>> We don't need to give all interrupts as there is only one port present.
>> We don't want to enable all interrupts when ports are not exposed.
> 
> No, the interrupts are still there, wired up in the SoC, so we should
> not change that.
> 
> With runtime PM eventually enabled and working as it should, the OS
> should be able to power down any unused ports. And we could also
> consider marking some ports as not physically accessible and not
> connected as a further hint to the OS that they can be disabled even
> sooner.
> 
> Johan

