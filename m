Return-Path: <linux-kernel+bounces-526861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41132A4048B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6719C746E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57B1662F1;
	Sat, 22 Feb 2025 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DyNUL0nT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3915853B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186493; cv=none; b=a57fiJaTi49emcGeOlRdy+2PtY+OIeqVsEnI6R/6fqj6CQcM0zyE1tq7Klu06pijFZn+tiJvHzBQ1jlOJnWXJ/NlVKORoS5A4mbW0Tcz6ATv7yWkPg8odqLOSlZMnkPL8nPyWGIFrwu6VcHGnlfb8XVaVq3RqSjUSF1iDSP0X9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186493; c=relaxed/simple;
	bh=eDoZofir2hrwtDXk4TstUXKmfWtDhK2Qg53ThG5kWVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7T0P+XV4juRNI7KT/FRv2yWcjACr14k0vr9AuvzEaUlogyD7HUZZoEkyc3NpbNc6W9lQnMP3Hg3Rm8D4Q1htbUE16oRT6B4+0RjsPMbvcl8J0jn8EvJ1wp1jj6wtnGc9Ej+OO9V1uVIu0wz2Oa0comKUuDlIkqjnrHCZDRxgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DyNUL0nT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDvsWl018792
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+7uD3mDnAjZ85phjsnwE9FBImVmeY69xngWW0qTBWI=; b=DyNUL0nTJYBVhFf0
	og4j6GIdZLb3sj4Bmbl4A7R+FXV7dUCrKMKOP2gxwnLGhMMA7czoVadbohPvozsp
	2T5x9qGg6kyzPs0K+0Y/PYY/F5FfHthrn+Z17Hhc/YOWMGddgfFsGgyDlWkTxGHq
	pcvHfzgCuSd7fWDPiZJ/itDPOjuCxxcHKmMHoPAM+ysZ0tIunmqW8lJWdD/7/CB1
	t1NtmbLQnUcv4WbTw9LMQzSP9kzwQVFpgklJR/81JOAaK0ALdUB5rpirbuvueHEp
	g4Hsbj8udKfJ29u8OZoMczWmkYHytkSahWAr1IAdgmJ/M4LdC5audl6MpvItfY2y
	QpPCWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rjw86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:08:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c09e78ac63so61472385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740186490; x=1740791290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+7uD3mDnAjZ85phjsnwE9FBImVmeY69xngWW0qTBWI=;
        b=UCPud8Lh57jBVm+F3zWSfid6btu8rwy2Ea4SEcBTDlujOChIX8tkGOSTcEb6BVGvMg
         PJxofv4L5l0RjbWI+64CTDPrTiejH+kLy9SObiuoGnwSmTdayHMfUMwpMyRqNZhsqDhB
         RKS3k0sF612iZccV6HW6HfJ09tKvYH9AMV1N84sjf90VUQsS+E53/RBlCr2yFYjoIPM4
         szSPzHKhgwMguc6EmI7031YEGM8ARc47JHO96SKUZXtOz+7ke/WnPEt9JIG+YAy3yqvD
         9hpF1/jiEeraV9vI2prwMY/fTdrwFaZHuZ2cVEh9VqjvLLJvWOE4bv047yh4EWlUhoeu
         0j7g==
X-Forwarded-Encrypted: i=1; AJvYcCVlq9n08oWgZo+tMClqEydqgZBRA5/ORXH/ZVDimYQ6lZYHtrjUjjeqj/TW8rNzYW+0gfr7NYkk61LNicU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJJHTgc4NGw1FljXQFotDXXlYYjYEQKqG/okZXzpYCxs4Jt91
	EgbQTCsEnzmK61rSjLnsSS6xxlCVBoxvJl9X+LtKM14GBQ72mIJcj/tp7RBa3pK7V8hzjQSD+oN
	3ljsOKV5LLGubNtaW1fy7q+fTqz85rCjgDwUPBB83zCLnWGY4CLkdkMI8vVlqYbw=
X-Gm-Gg: ASbGncueO51u8LAK5dBLUYG+S9D9zvJzM1E8vN8sUlZhYG2070V0cXUMP5v5sK3Jy5t
	9Zg+unaaLwq4NVNyzMsvzz6F1MrBUkaC05J/WcABkXwosE4ba+cMP79WUQwvKB14stqVZN4FtXx
	CDFzuejBKIt79Nm05lON2eTd1s5pBkqRwFRVVajpjZL+zBfab8hzMJurQBeRfQrtVEq6MEEzXOy
	cUGbcda5p1KZGlTGf9vi1ecLvRZLkKpEPaVxk88BvY2pFlC4N8BuUKlVcMNwMXs4XIykJUOEBF7
	9FVhsXu505oSCNAjcyYNm1RhcPAwOnNNFJzhPITlAM0v/+Gih2JAQgcZ1yVTV54kBHmFdg==
X-Received: by 2002:a05:620a:4726:b0:7c0:9dc9:754b with SMTP id af79cd13be357-7c0cede771dmr299453185a.0.1740186489629;
        Fri, 21 Feb 2025 17:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYYxDYScxOyOYt19LdLCGEcGFQfxafa8JYctydRNjUWNq0I7T1fbGD53XYaGYpG7lGZnjSKQ==
X-Received: by 2002:a05:620a:4726:b0:7c0:9dc9:754b with SMTP id af79cd13be357-7c0cede771dmr299450885a.0.1740186488939;
        Fri, 21 Feb 2025 17:08:08 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e8dsm14342801a12.14.2025.02.21.17.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 17:08:08 -0800 (PST)
Message-ID: <20c6b5fd-321e-4165-9c83-3b53a481818d@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 02:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qrb5165-rb5: enable sensors DSP
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
 <20250222-rb3-rb5-slpi-v1-2-6739be1684b6@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250222-rb3-rb5-slpi-v1-2-6739be1684b6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _DxI5pdSplaKcCHj3R2CVtd3BILt2Lhs
X-Proofpoint-GUID: _DxI5pdSplaKcCHj3R2CVtd3BILt2Lhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=740 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220006

On 22.02.2025 1:43 AM, Dmitry Baryshkov wrote:
> Enable SLPI, sensors DSP, on the Qualcomm Robotics RB5 platform. The
> firmware for the DSP is a part of linux-firmware repository.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

