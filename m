Return-Path: <linux-kernel+bounces-425473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CDB9DC294
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C98B1625AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6F155726;
	Fri, 29 Nov 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0XOp1of"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D6197A67
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878798; cv=none; b=AuXBu9A9EAwSxklWhbJ7StofjfYbwgL+J8N/rQ/9TioMXY3aHO6fX+pmKxes9k/5WisTSLl7We3d1vVb36T4B4AiB0j306C32oDzVJ3JGdh3F3b/oFrjqO0E7GSrSdnoQ7MCjvel1TdFIkQT41VYyC/TL+Opq1rvi1brxD7BGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878798; c=relaxed/simple;
	bh=HkL7o2nQ/6sR1UDkhdrjOF9Zjr+Ofw5rUlktM6LDZpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMeWDuzv2wcPj8BUy7IHT77wE6f1oPpudALTPmKloQE/rXxf+oRWo7GKixTRW7XPTX5Af8ivm/g0eBsPuNIDi7ovI5gmO6pJUecIYmFdMRDwrj0dId67KYFwQ5Fh2BhNYZmfoWRHxN41gj2/R/WgjACZlxZmNEAHt8qIyF+Rng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0XOp1of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT7nk4q020558
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OY4pkio2vbfhYdHY9J7hvsGz2TGfLYArdts+4vo7ErI=; b=V0XOp1ofXWIV9rOO
	/sJqLXWqCpGede2FApbQEr03chYFP5K8UArRUHzIS0LGEUNaeicNVnN0p5iUyvDu
	ayCSmfbWLGvBswRiKGMwzUNHWRGuGfVP5tCnudcyH/llbzCZSvAidIAS4LRsIbfA
	+0n1YrfqelKibulH5NePXEstVviHKiKiTy6fFfqWT+4ZUlL/nAulJFV23Cye1o1S
	cpjVg1jrbvVL5TjNjCvBAllOkjVxj/cCq8WhHgfeaXAD8XXV220Ya0106rE50+/i
	prJpZm6y8FCMh8AXAB1RuQhkoiOLbKK3MtdjQqAS2Lh9KCqK9r2VdniG61yXjEPD
	j4Pp9Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4379jm0hd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:13:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4668f2d0e50so2480601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732878795; x=1733483595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4pkio2vbfhYdHY9J7hvsGz2TGfLYArdts+4vo7ErI=;
        b=ussT7u8W+r5OXHoI7hfLmR86SBBFrIE6B3c+IneiB4huXmyqp9GgmzsJThLqrcVUVh
         F8NApN6KR5X+fO0dhpYOEzZcS7T7UeI31Rpb6sAmPAEMMFB+31MbWl8oIj4SOCan/fpD
         Zsh8LObXSrwkO5gQQcBIuVr12nf47zJpguJVxYmhGc0XSsS0UgOokWMHY48qqXtLGSry
         Q62UIlGMlDNe+LR0qQkrugLTxMgOb6gaabb1infM8VeG7Q4YXJ58gcE9jHLOkFvMRmbV
         MyR7EBO6dixd31FkcaPbBFsl85Pwm3Lmjs/XorZHjYgjFzxWI46VLzkZPfxp6NOkitaO
         7amQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2WlAJll2qGzNMHg8hF1/8dZMNqbHL/gHVubCmCq+tNsltx+j4oC9inPwK4EjrYiWZVyOYV0tDl4SXlkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUj8QAXOtqKARFyL+LHXWJ+0hj9qzPC7eZNfUEKj3VJIb1bSl5
	z7m3cAROhT8p0fwydKAtlvzBanNVsJBL8QbPicMqOVJWGBFJdtXO3qma5TNK8z06aMlx2BLOSm+
	oLMeNA+jmf1gsWzWfccrid+IcLMpgjilUf5QINFrmVCshbQN4pJvUcTQOrp5qd0M=
X-Gm-Gg: ASbGnctS24iFS7sDr5Ib881/bc5y+HP7hkcEN2UTKTS58s338yLykop5aGpnsiUuV1q
	GBUpRY9i4p0FdXdi0rCwRWroMNViQNLi4HNlyHICCQGpRWsdxcgRqeSmwuoiL+qcnRicRgB+WNP
	YvDGIArfyCFsBxk2U3fy9kDEdbnj5T8KNXSrXvbFtxvE75UBylSetVPyoMpO3cm80Q4jBtNOnxa
	hogaX+olqompEb92HqGIntT5Tj5K46kCEkbu7ZZAEWvVMCLUhCSueaGPQkVoD0L4yf6ihxbjLct
	5Yz03m65E4u8VEtLfTMXb5Hjru2wE9o=
X-Received: by 2002:a05:622a:cf:b0:466:8033:7dd2 with SMTP id d75a77b69052e-466b365e8d0mr78296831cf.15.1732878795275;
        Fri, 29 Nov 2024 03:13:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1FcmxiZBl5R2LI+HHAza538VFCS9rbIxuF7ps2Q68Dkn7LnmcHdnjYtcA+C5cS7ywhsIMRA==
X-Received: by 2002:a05:622a:cf:b0:466:8033:7dd2 with SMTP id d75a77b69052e-466b365e8d0mr78296521cf.15.1732878794891;
        Fri, 29 Nov 2024 03:13:14 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55b1sm163426566b.72.2024.11.29.03.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:13:14 -0800 (PST)
Message-ID: <49b3dd66-e1ad-4b23-a405-41a542b52f53@oss.qualcomm.com>
Date: Fri, 29 Nov 2024 12:13:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs8300: Adds SPMI support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, kernel@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-0-28af84cb86f8@quicinc.com>
 <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-1-28af84cb86f8@quicinc.com>
 <wtnsepmoulfhm5ydbu7udtsrexaogaiqjyt737g6a2bhf4drnv@jwmktibj2swd>
 <624393e7-0681-41c3-9008-de50cdf997b5@quicinc.com>
 <vgv4nucgfnrlov4lj33sprytnkbhoj6yxolwrqddbwwkmrevn3@4sacxzyhciyp>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vgv4nucgfnrlov4lj33sprytnkbhoj6yxolwrqddbwwkmrevn3@4sacxzyhciyp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5n26cDt4c0Zrz-9G-9J6k9MRq1Lje45-
X-Proofpoint-ORIG-GUID: 5n26cDt4c0Zrz-9G-9J6k9MRq1Lje45-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=916 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290092

On 28.11.2024 1:56 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 28, 2024 at 03:55:31PM +0800, Tingguo Cheng wrote:
>>
>>
>> On 11/26/2024 7:50 PM, Dmitry Baryshkov wrote:
>>> On Tue, Nov 26, 2024 at 05:35:05PM +0800, Tingguo Cheng wrote:
>>>> Add the SPMI bus arbiter node for QCS8300 SoC which connected
>>>> with PMICs on QCS8300 boards.
>>>
>>> Could you please comment, what is the version of the SPMI controller /
>>> arbiter?
>> Sure, let me add the version information in the commit message.
> 
> Answering here would have been easier to follow.

Computer suggests v5.2.0

Konrad

