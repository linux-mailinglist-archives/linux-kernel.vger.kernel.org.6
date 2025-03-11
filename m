Return-Path: <linux-kernel+bounces-556500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012CBA5CABF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50869189BDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7E925F990;
	Tue, 11 Mar 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kDKKUUoc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD525F790
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710263; cv=none; b=XsGcl4hqFAx399TrLB+p25UeTQ2Mw9K9W7x1dWPlr3ljbs4myLlXd++HrxMIE4sBlVEh7MrnzvNHGb3L1d26tvJbQC0P1PBaz46NFJKfSYeQpfNFboIeMwkPwOd7p/yvSx4/NCAlgSX5VvyzTkVp9Qa1a7D/Wc8N0Nvw2B+iozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710263; c=relaxed/simple;
	bh=qgrBqQHmYtPZiDw3T63rb/+wAIHYgCe4MJOzvqt9Bak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ1luNHYnT+fp7yl/KDY6QdqQ6Xf4x/ZTqvj0mtXb8Bctwh2T5arzfQEZp09WWHqMHDQbvGXM6mh1COnGrEoroFIviQxeBYKKfjN4DZcN58vNRstq+jrzUzZ+kIi/enLhlJeh8GygYaBt7A3ZZesLwMM7GYvb7bp9Yh0nl3yFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kDKKUUoc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BFkSgT028132
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uxMkImD4XvCHFtK9LMGsOV/QwiwfWxTZdEB/IERfs4I=; b=kDKKUUocqn0ZCwsK
	+k2WIcc2pnWkHDsXwnvD7AK1R5kCHNgGbJD+ytIsxqXDIrg/FwhxBj+JOb8CQEuP
	+3rdO139ZQCiaRMPfe0tm1fP9ykw3zsYcDHTKBq9NJ2S/tK2bZD5RL6qQ03jN005
	gJtP6TXwKiKHn68OljPDUxEnzwKYFguVNVbNRx83LnkdrFHdXG8UdZhB5Ks3TbbW
	FauK++oetBi4RlrON3dLA+DPGkAInhY2akP0szs/t4ikeeNwEFlm141dZahuxrXS
	I07JIFR/lCQvWeY5k5bZOeZ3SyVEcyC18BICyZ07tCvF/We9p1lwzZjEVJJdHToq
	rDNUHg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah529m7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:24:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54be4b03aso59745485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710259; x=1742315059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxMkImD4XvCHFtK9LMGsOV/QwiwfWxTZdEB/IERfs4I=;
        b=vHo5MGjso/MbG1C2IBJwHPFW5Vx3XBqnXfYhz/S9uVjKbcnWpP0TDzE/L2K99Ld5eK
         wkkz8KeHLTyZGkhxsgkBxTHJlLKPm9cEsUeW1qylmCveSFGOvEgo7JGDmKgljHiuDt3U
         tXoNQqNSs4GWlDDQS89K7Xi2L8RIQUY/DDXOy6411LU0i7/RGC2PBjNggGAOgiLHL+yR
         lX9xCoS9nHzHBdzO/CYqV26J1oLak1NOnh3aUod9QiG1GyikbQnbWRuhSRHo+OqOYzHw
         rivC8lY+A5ua9mqoR+zffAtLbJbRvdm3L6QsKDA+9ew8w7pI/oWfhsdQNlt2KZeDUEdo
         G9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUkI0GZJtUXpJtNQRqrTHnmV03Z8/h6GBJKRrrNn9avOnfuU24JBiEbgibKlHM28JJxje+rmuqPsfBlKqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgZwK3SNhBEDIITAfA5DZF2Fr3fx8c5JBX1YnJv5UHm7w2I83
	S348TtBrNBkiJqnXgWcSK4WulEGBYnJZTvhd+RezXdiWENyJkPA3+G5zjMIdNPoS0sVz+xeYZEU
	atlXE09CLdIgRpNU6klwWRaCpKg1wcBGa9SPxc13Rw7Zlf2wfqLWEF4fMwytzdDQ=
X-Gm-Gg: ASbGncv0lEUF6X2hTulelcT6cP8iNSSPUrBOHK+06OYPY2111VwjQP4NTV8H/uH6uUm
	nOIsHMTAGY7XbcIrxUXUMT89sxJVqatNclpW1YFbt/FLIKMfkum03IPak3hVpQKCsM3GP95msgu
	Q+m1IvSuDGNqJbamZlV2Q9jpQW22izkKX/wT+zqJ9W0vakDlNrNA9lSxkBv8rIpLdQRyfejcjd2
	otn8UwsX3XRxugYpvkVoxyYltnRXKfJZURgQUxuYN4RyQMgZTG2cuVbm2P+Upf44df2A2L4kSPW
	LZwr31k66UBQn2VsH8H6Y53VzhcKozyehH8QYvVmRQNqGMLk3fJb9EUwHppQ806lS/umrA==
X-Received: by 2002:a05:620a:1999:b0:7c3:bcb2:f450 with SMTP id af79cd13be357-7c53e1f1620mr660772385a.15.1741710259512;
        Tue, 11 Mar 2025 09:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/06oUsi5cu5h2BkX286HoUPd6spRXGBxkQEsEQoidWXTYp1CgE5/YUcHWXT5T4IA3c6k/g==
X-Received: by 2002:a05:620a:1999:b0:7c3:bcb2:f450 with SMTP id af79cd13be357-7c53e1f1620mr660770685a.15.1741710259107;
        Tue, 11 Mar 2025 09:24:19 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f8aasm8501795a12.5.2025.03.11.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:24:18 -0700 (PDT)
Message-ID: <10564e08-f8fb-4db6-b613-d01bc2a62899@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 17:24:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: media: qcom,sm8550-iris: update power
 domain name
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250311-dtbinding-v1-0-5c807d33f7ae@quicinc.com>
 <20250311-dtbinding-v1-1-5c807d33f7ae@quicinc.com>
 <7yjj2eemvvvnsgv67d7tueid4h3n3onuou6ammx36am4qhfsal@xam3iamk4er3>
 <c0430086-675d-b58c-4ef9-1bd9ee51d3db@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c0430086-675d-b58c-4ef9-1bd9ee51d3db@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W0seU0qqr71hcwbGwAvF-DAUFnro1hsA
X-Proofpoint-ORIG-GUID: W0seU0qqr71hcwbGwAvF-DAUFnro1hsA
X-Authority-Analysis: v=2.4 cv=DfTtqutW c=1 sm=1 tr=0 ts=67d063b4 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=Sbx8LK-abD1ORSsONcEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110103

On 3/11/25 4:11 PM, Vikash Garodia wrote:
> 
> On 3/11/2025 8:37 PM, Dmitry Baryshkov wrote:
>> On Tue, Mar 11, 2025 at 05:33:53PM +0530, Vikash Garodia wrote:
>>> Not all platforms has a collapsible mx, so use the more generic naming
>>> of mx in the binding.
>>
>> I guess, it wasn't even tested...
> Not sure what made you guess so, let me check why my binding checker did not
> catch the bot reported warning.

You probably checked the compiled DTBs (make dtbs_check / CHECK_DTBS=1), but you
also need to test the YAML (make dt_binding_check)

This change can't be accepted as-is, because there are already expectations
about the naming (and order) of the entries.

Because there's a difference, you would normally be expected to add a whole new
list, but maybe the dt-bindings maintainers will agree to Dmitry's solution of
adding a sneaky enum inside the list

Konrad

