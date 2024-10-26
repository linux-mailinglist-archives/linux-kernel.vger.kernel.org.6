Return-Path: <linux-kernel+bounces-383070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751E9B170D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7701C2199B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96BB1AB536;
	Sat, 26 Oct 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6IQstbD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADA1CC894
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938555; cv=none; b=e1MtH/ZlXOJhQaaoUr3f8eImtxwrpk/zGmp0ZmPwmn9hp25yEJMmflkdVQqgvOa5HyddSJkmkegCZdpyUuw4tchIo2mN1HHdv1imqQW4nmu7DofjTPKVQgk2ce0TCQMvzUopkpDWNSlLkNbHXKsiIHt8W2XdNERrM5UZh4gcNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938555; c=relaxed/simple;
	bh=nICN+wGw0Zlnk7XBJCykqu2YHS88K05117fzsx5U0Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvImFxSs5ks+xtZuixBI0s/5O3tBol54v5VfxR99MOXRogHysm75q7ADKeiPGnQ7/RRmbCSD3MiDOQJYcUzXBOpGXk9Q6iOfPlUZUrRWJ0MIfvhu+kq1rDFvUWedFKCRR0G3Us8GkNys193JW3OT7fY1tbpfysmMlUFFR9qUL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6IQstbD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4q6wp011894
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	drvjg+RX6Oe25bBTeyk4k7Mz7Zh4OVvPYWEd3+8U/qM=; b=p6IQstbDYCTF2vu3
	YdZj0f64Go2DP3zfQ/r279BJOaXViIw6bvi0IGJ5XwNS1kJ2Wny3nlibn2J1h/B7
	eeC346SZbaXcMXb4LR8Tj8neDzvkQBnWAAFViHMRhCV0bMy2tK9uic7WBTnvOvnY
	BS/+Ns0FRyYm8+r9iaO7GlDI9c828EjJDT3FrIUIf0FC7VO9+gxfZOMlwS+zkbge
	4iTWRNWcy91OjrGUR8wWFborAEUuqIoOaPrHYHc4kwAvugiCBtRHdljk12ikDSCb
	MIZYeRvuAtMyvQbBqYojuFBjDH9kIbz243lzggR/Y7LwMRwx6yngZiCL35YMHpNw
	GaJm2w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn4rqey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:29:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbe40565feso7857866d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938551; x=1730543351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drvjg+RX6Oe25bBTeyk4k7Mz7Zh4OVvPYWEd3+8U/qM=;
        b=UbErlgM3Ug6gUa5AFJ7Rz5zXPvJwuL+MwzYuDPM+dnhlIJj3+Z6qa9CGcz0F+1t3xd
         6kMMsTxDuZub46OnPDBMGFqxnd2IWgUCD9VQvDhkBQF/3nlC+bzcGpbOtANmEPNR7rxE
         LKvDaXORqnn3LjwoCKC+HXLMwQ9HuKJWYJ6LGMl5s5DFW0bZvD2R03Wk0YttBRSWLpOF
         FS7Ys5jKqC2Z1Dooahm+KttnHZqsy+hgebTMQMzTsFaOW8kg+cfG9m+IuRvn4zQm0Ndj
         y7VuDQoerUHCDnTibULa9dMYBEyrXZMPMoTb+Rj6gPsAPdKFilW6PirMNE8HL9tlSbIM
         5tAg==
X-Forwarded-Encrypted: i=1; AJvYcCVQaHHuJ9KoS8VmPRvlPx4qVzcHJDZIc2IztH43sqFEZBII5qYP8i22c+PIOOth7fFZ2ezqzvq7eZqO2qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkzK8DQyKzWXKnrkxKZ8lLOkAIREtKFDv8F7ws9eZd0NDAUIY
	nZQ8abj2Eg/iMh62E6mNEyQCQs2Agy3CRtUzhKVn4/SanKS9RUwG8frVeWtGjBJN3HDLR4jDY1z
	LovtvOKAcSMfGeVRJQ4QdYPr9dpUkYz68TjmvcO1HtF/EWTPnQ2lJVwfQY6hrnlA=
X-Received: by 2002:a05:6214:1310:b0:6c3:67a8:dd48 with SMTP id 6a1803df08f44-6d185682ebamr16341946d6.6.1729938551703;
        Sat, 26 Oct 2024 03:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ7pz+xlCS3swsXKEbLqQvosFijw/dvXVXUM6BjXWJOg7X4GFjj3TA+mHbRBN3TH2OP3ieyg==
X-Received: by 2002:a05:6214:1310:b0:6c3:67a8:dd48 with SMTP id 6a1803df08f44-6d185682ebamr16341856d6.6.1729938551355;
        Sat, 26 Oct 2024 03:29:11 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e1a66dbsm163308166b.12.2024.10.26.03.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:29:11 -0700 (PDT)
Message-ID: <a743fd1b-c6c5-47ec-9ac8-1e4481180ddd@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:29:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] arm64: dts: qcom: sdm845-starqltechn: add modem
 support
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-12-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-12-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k0Wu_3XyfOEejNqwph1MJGE3OmDN7IBO
X-Proofpoint-ORIG-GUID: k0Wu_3XyfOEejNqwph1MJGE3OmDN7IBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=855
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260087

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Add support for modem and ipa(IP Accelerator).
> Add spss reserved memory node.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

