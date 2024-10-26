Return-Path: <linux-kernel+bounces-383171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75F9B180C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A971F22BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273071CCEE6;
	Sat, 26 Oct 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gF7gRGUw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B0217F54
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945651; cv=none; b=FcqOjB8xfoMhRg9IXYlZ9EJMwiHuAzeeQWJUckbLOfKjz2Qq2ikVt1UgnChGj6VQwnhqwgaKid+Hj5EF/AFpUB6DKZRxjA491eS1CiTMydvWzesrr+CsABoZ2kgpGjBsWKitwKMGqDlRpa7KTti5q3sbJCV5AoDYlnV+WfypouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945651; c=relaxed/simple;
	bh=702JN7pAfqkVYRsnpi0mJr/m7gxW179p9/vLjJNcYCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPzfku5hnUwzSQPiFPjQAhHor0xaues6GSsDuvMqG4BKFIiTr9hLhoo3xgg0dl6PT/r6gyyj+mBisepFDp2l3gMQdTB9piUEEI+a3Won5RFWykDdvxnY7PTOpPzjCjyWVgLHyxN/VDgvoYzDnO/hwsPg3leuSiCDFN+juF4cM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gF7gRGUw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49QAqawK008432
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7C+jusYMP9l2ovctvkegowcN5UZCP1PXuUDJ7cZsPAI=; b=gF7gRGUwL6d1wrei
	nphyLDCxNPRC0MFnnG/dCzar7EwK9H3I/eAvZsa0R/rGRTaE67UVtlcGr++RXey4
	qeZgS+z+IJrK+bqPUJ4PDkqlqY2ELfOM1oyCKmasiB8jXIO0cQX3gyYdqP6nU7QC
	TGEXWXVIV1T0I2odv0AQkaejQ8LpzNHt9J5q/d154ZWKu/yNN6hXUYd2T5hYTisD
	qCAdaP5LhQFWefGvAFXRX8OJfZ/3gxqkzJ0iiKEjmpESm3C4iF52AVp3yU/7yhDg
	UiFI+CxaTrkFBIIa6/LWmzSCMAUUC6QO/NnC7kscYrWnoSyLfhYemzXig5s0B3/C
	BjSrNQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4ds3rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:27:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe40565feso8043396d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945648; x=1730550448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C+jusYMP9l2ovctvkegowcN5UZCP1PXuUDJ7cZsPAI=;
        b=tx7m7Q0woIeX1u7fWDB5A8SKZSI5tkjL8ewq6Um+30krpoMBxngwoH22mgiBypidKc
         vdNkfPJuKVbI30BkGL5222zmPFylsicSsqGATTN9THK0mSvLy+/f83BxK/XJE/8pArot
         42aphPkJqPMbjLH52Y/xfgzC8Xeb5mMpUi4MVSwYF65zxfplAk9smddxfB/m2iCa+epD
         or1cnhzgPJDkFKyQGBVu7QEzuawNMTdkin2jOP8NTD7j0+POuvBfyKPOn9kvdTJKrp4o
         cL5DbnkpdhKWgNL8LB2ysM3VwH5IMElNBIFkpjZJTXzJHBwo3e4IEJOBo0P75ZEJ7pxD
         qDbA==
X-Forwarded-Encrypted: i=1; AJvYcCVHigR9VYvUc6FcwnLgJzfGqoNhK6iQPk72oBJSsopuRduBJJ+ASCztdB0dugw9ee978450tSZHOiSbXVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBD0xa6mOMI/j6vMDp3JoxVa+Xpv3Zdsr5sLv+0w58FPX7fn8
	rZqifPZEbKinJ30nGRRKu7J+6kzAqcc5l00fgXnC3qsthXSasWiDBOCPweMFDyuwPCrYXmWQETd
	xyPauBOJpfqwpSSGEubgJe9s+plmla+tJ5nLr/CKtsb0mtOscTJzqAE5LU3jq8mY=
X-Received: by 2002:ad4:5bc1:0:b0:6c3:6d25:2578 with SMTP id 6a1803df08f44-6d185816bf1mr17294276d6.8.1729945647906;
        Sat, 26 Oct 2024 05:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhCxGpkbXKCThgV2fdbLGNEh2KUbgm+xT5fM59Y95IjBWAay8GEY8zPnkVeu5Rd/0A5d1E6w==
X-Received: by 2002:ad4:5bc1:0:b0:6c3:6d25:2578 with SMTP id 6a1803df08f44-6d185816bf1mr17294046d6.8.1729945647540;
        Sat, 26 Oct 2024 05:27:27 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e1a6bc5sm169669766b.24.2024.10.26.05.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 05:27:27 -0700 (PDT)
Message-ID: <de2561cf-4aa8-4b7c-889b-4c3737857bdb@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 14:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add LMH interrupts support
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-0-074e0fb80b33@quicinc.com>
 <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-3-074e0fb80b33@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-3-074e0fb80b33@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: H_hsQGYzPwL3A-gah5MR_1siWbdhiIkC
X-Proofpoint-GUID: H_hsQGYzPwL3A-gah5MR_1siWbdhiIkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=739 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260105

On 17.10.2024 11:28 AM, Jagadeesh Kona wrote:
> Add LMH interrupts support to indicate if there is any
> thermal throttle.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---

'support' doesn't fit here, you're describing the interrupts, passing
them to the cpufreq node. 

Adding support for interrupts would be fitting if you e.g. added code
in the driver that would start consuming them.

The code itself looks in line with the docs

Konrad

