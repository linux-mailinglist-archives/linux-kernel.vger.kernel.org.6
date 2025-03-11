Return-Path: <linux-kernel+bounces-556595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9CA5CC16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9271774F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AC25D8EF;
	Tue, 11 Mar 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFGv5oWf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BE260A54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714021; cv=none; b=MAe8T+raOuosmEo+agAJxZJZXes+sLzWBNldt3I+K3jmM2tNG5C+h+gxCBq6wjbvIP0DZAcG1DMpo9dPZglF0/sSRUaK5yfJwOdKluRB3/QgI6fSiyZdi7/fmhgNrtos+z85vAzjAdMzrYrZlg2FVyvVseJ6ZHFAYwEhPBFZ4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714021; c=relaxed/simple;
	bh=XTIRAgPmD28skDvfDwDGIOCVy8D0GYqUCBr9UNVDX0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+GhW1cwE5cNyz/AYccS7e7hfjn0z8CKEoDbzS0g1RHcWqXVtAo96oEEzG0QHHlWcBmtVDNUK06PHUmgwqBQI5hFsIf417fIgYQmAs+s/y7iATushrXa6+7hI5s3EE0JWn3cXMd5+DVWPtyf1xE9OlK88kg5L/cth/P2Xhazjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFGv5oWf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGieDF018337
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	modCKFlPbohmYS2UCFV6htda6LZj2dmGCzj/GUvT+OE=; b=VFGv5oWfJIvhnUAl
	4zvjCI66xOiOuk/ivNSRQm07MmqeMg0RKuuir9Gfx20xH7YnLHvEXwKdjB7l+EQy
	5NsrJ/bm1qYO8xpq+JUoMQ8NkLBCazzhYSuqr/PBP9Qh+a0mEujKayl+YCQ8fObq
	eUcFtM4ScROXfzvsfotudNdFUz2xfGpda84fKGCdaxqVqBjXCvtJDXV4Z7ouliIf
	0OFAuTyQeRoICh8vVWd5jx9kOv/CiR23vvcM+1NUMJZ7Hh7QQj4c0rRZWVeZkyT0
	OeSROwoWmQ15OiU8VAfgksx8oeVbpLxsBRdzIYQyu4lC/Z7HEpH6AQ1l7kLDYorH
	lfd0gw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0q1d6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:26:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54788bdf7so32088885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714018; x=1742318818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=modCKFlPbohmYS2UCFV6htda6LZj2dmGCzj/GUvT+OE=;
        b=wDdT6jV+6fWXuyx5z6RAdgEWajkoc4iv0ny+huzfgkmfCuDYzPpnvvNidOLglqma2b
         NMrJ9aVHfiwKaDFRR1UW8bdMC4FI+AVxe1w1C4Z3t/c9uDDZa7qG59nwlMGaZTIYA+Qk
         ufINZ5MfDA/Xl6WI7AeaD8ykjgknm65yfubh8n1/DkW3rRpjXwFTn6ZVDYnj1TtweNum
         4RJRbfbVEvG98j7LSrKEBq20tKZDNUoLW74OVmIg3f1DDPPc0yLh38GclHBm4HEm6P1C
         C0Gu4npv1J3U5eo4i72/19xa6TTf+KbazLekvbeO74bm8uRby6eCxLIA9IJNBwNUUfoq
         ywhA==
X-Forwarded-Encrypted: i=1; AJvYcCXHyU3V8ElYuwM1V3N0+9jrVoPSi88SbB8IgYpWMH9NO6qY6uZ8P2BasBxIwTiwh9/Z4qSARuGLMKVCICg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKPUBAxemYCtEsm20qCRXbB7W0tA3pcb7Targbd1wx7m291Bm
	A/f0MFWc7E7W4TyPqXrAAiUnGBy8sWkocKsesq/HvMt0AuoQ2LVsTBQ/uHJmyQtn/Osl4HiNyYF
	IwPAUmpFwXDytJPOILzoA8FR32+aO9xr3+6louTVIxrDQLQGGtxwXLT/OPoCd7lo=
X-Gm-Gg: ASbGncuJAPbbguu/P/oXHQKH4zWXNPwNgmNFipvE7lv6UQxhoZsEnjrmqLBXpClSPDS
	ai/bn13rUxX87NRbiEo/ohMMJ+N9qlflDKZMz6IEauRoKsfEqpf/IXXR/RUVXlELkd4Nz7o74yV
	GobpjUw8zvbh2IBf2MGGt4at+HIDkdaSKI4Jym41l1d8ce6C5j4OYBB+COVAbwgCI2Gy48bJ9Ih
	e7hbA9s56Epi50YjJVI6SyIkXKYMDWE95rUxxCLx32G1qW0GNhr483coam+wu2Ix/p6B39YjvS3
	Fel0C5WFVh20qoj5ejx+2pZ92o4QxHjHnpFxKOrLtAP6G2GhEf/g6Rsz0ebBnFRsY1ZoZw==
X-Received: by 2002:a05:620a:2989:b0:7c0:b588:992 with SMTP id af79cd13be357-7c55e883133mr250949285a.9.1741714018098;
        Tue, 11 Mar 2025 10:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4PwZSzygwJpbbK5qOQtPXbubl94YgeE3+YlE6YRMOV6fyG+MXaxjRZxgCRgDfKWP75HKduw==
X-Received: by 2002:a05:620a:2989:b0:7c0:b588:992 with SMTP id af79cd13be357-7c55e883133mr250948085a.9.1741714017691;
        Tue, 11 Mar 2025 10:26:57 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac291796eccsm453035566b.25.2025.03.11.10.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:26:56 -0700 (PDT)
Message-ID: <f93baac4-7415-4d31-8000-74f42340a933@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 18:26:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: add support for volume-up
 key
To: Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307171036.7276-1-johan+linaro@kernel.org>
 <2aac1aff-694f-41f6-8849-f1dfe802a1f4@oss.qualcomm.com>
 <Z87Yi6IQEIhqu27O@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z87Yi6IQEIhqu27O@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JHaUmk_h_lO5_p1oFFHVirt5hyUSw-3s
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67d07262 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=n2lFrQNbv3neQDgrPP4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: JHaUmk_h_lO5_p1oFFHVirt5hyUSw-3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110111

On 3/10/25 1:18 PM, Johan Hovold wrote:
> On Sat, Mar 08, 2025 at 05:26:26PM +0100, Konrad Dybcio wrote:
>> On 7.03.2025 6:10 PM, Johan Hovold wrote:
>>> Add support for the keypad volume-up key on the debug extension board.
>>>
>>> This is useful to have when testing PMIC interrupt handling, and the key
>>> can also be used to wake up from deep suspend states (CX shutdown).
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>
>> I'm lukewarm about this since there is no "actual" button for that.
> 
> There is certainly a physical button on the debug board. And the UEFI
> firmware also supports it (e.g. it can be used in GRUB).
> 
>> Does the power button not work here?
> 
> For wake up, yes, but not for testing PMIC GPIO interrupts.
> 
>> If systemd induces a shutdown, try setting
>>
>> HandlePowerKey=ignore
>>
>> in /etc/systemd/logind.conf
> 
> I'm aware of that, but the volume key can be used without updating user
> space (possibly also for CI testing if that signal can be controlled
> remotely like the power button).

Alright, I see

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

