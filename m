Return-Path: <linux-kernel+bounces-545019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D047A4E829
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B19164FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB43296D5A;
	Tue,  4 Mar 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ex0v6HYO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCC29AB03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106785; cv=none; b=RbGfo3goRAKwIvAfH84gjG0LsX8h52p50z9C6xB/iAbGJ2ElOuOqXBCbufLmBkxbsISlG+hg2TQFXpNTt9O1c5A8mhSV6uIkcuk4kjWZHywrPSndjNXjLwjaKHuJudtH9OPIsqQM2Es1JCQMUVeYYQeAWH0rNKV5m7co3goAXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106785; c=relaxed/simple;
	bh=Z3R5Pcaqs1+G0Vmv6xCvvwsCj1j/WFqkmCVrvqCYFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIFiwBM216MgD3ZHKwvv3YQk8pwHwKTfjLtCD+D65fO5/3sFvxp5ZF5lCXDA8FrzDM56kPL4Q1POzg95K2UJ9cOdBu9HbuMQLeAJQb3ndKNXZOvkRcIgOqr+9OZCsdq1E2tgQTccVGHik5Tv1fEcJXfhRdNPk1vF6dJLYs2U69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ex0v6HYO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ATmaI017521
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 16:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7brEcXtfbjcqoYB3XEQrIfgtnniuwEzqWd+mi+OW4A=; b=ex0v6HYODe9nYu+h
	fABau/0Xk1AapsRzLSzGrEjXmgpJVW+3+Bo++AAklQOGGVWGk2FfwYZtkM/D3Dp6
	CK6oe0LIFznNuAPFpkR/kTFkf471dAsC66byl2YASvmiJ3VaZfSifhmSU9BsJ2EU
	NDHRFtAdprgeD/3bmEzV65uFRnFPBmcz5OFXBqQNrlLjWsgdHz0EF3umNo8M8KeM
	3B3o30dhCIYfbYri6raIqiSW8x/iMMpnQnJrmQ8ub8VzgJmqmRt40AKzpxPxDx3y
	WiKQcgpT6vV9m/I8u/rFMdrI1RwNe1spPx9/9ceaCnUFgeOqm/4NUL2bzExKev5W
	NpCHwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tjhmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:46:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c253eca4so35866785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106782; x=1741711582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7brEcXtfbjcqoYB3XEQrIfgtnniuwEzqWd+mi+OW4A=;
        b=UPmiQntpPPu/VMWAqAlTIywJdUmCAwqC0oYharm7czjjy8HVX4AlJHj4rP9BZlfo3/
         +b/t3JOsz9tJxVz5APx/2oYiVGGstfNvFJ1b267UkRx7QHbXPggArk645tqlmbKGLzPp
         4lZRT9v2o8RQO8xU3P3Ih0qMXGC0AmZtYmh+zDSXjpA9py3zq89JNQG53VA8fd52U84a
         G0D/pokAaDz/X9IIPoynjL+4hi8IwVxqONXd7e8anKyQKL4HV1RZK3dV80YkvrGzsJN6
         ZeLtD52kgyeei2GiIAfM3iQPN8laE3KdQJAN1swWqSFe47wODcOsOYHkRBOpeMY0U3/F
         4b0A==
X-Forwarded-Encrypted: i=1; AJvYcCVFhBnZPWxPL+6d3oY5D6xak//yWKDclOITf78Lf1pLAj+e7JgRjZmNG0s8b3KFLLJ3Kn7Ch4ZRNXHQKIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+YX8EwiL6F9bo6/OoFB4KcxONjESf9E2LA9wSMdrc4zRKx2M
	R7hh+NH9Jv4i/Uc+dIdj1h9ar2gtXNQ24jZ2XbXPtVFFUZOeCE5jlz4R4092BgOboZMxusRTR7w
	VD4gFGplGDHo30FdRVll3kWa19OhMopKt2Rzc9Q/8lzvyC8b3rV8d4H9y8oXEUVM=
X-Gm-Gg: ASbGncuYHbKZxT+KNP2Wk+hwDpKsd0ed5QvXCV3SwwMsN6N/tKqRGZQzXEL7WNg1Xsd
	561eglK+eHUT5aOoBAfAEuEUkbqiXRsF9sMRhz6ST1zZwExp0vQTweSxubWdYWbjbun+JCWYdvY
	pH7tN+oEUA2iJphP4avu/WvtmbN4k/BPhP3yInyslWW4BZ2QhFeMUlGJkrVvA4dQ8bwE0yM0iNw
	no3K7qH/iF7SvOhOOM2q0dZe8U0rQyPSokI/S4X7MDqrhc1EOWk85+Hj4lxpVtEDowcNA+Cbv5H
	ZTKCe0l1YFIebYYXZNYEGpqcouz/V6njQ5r9AZvx8rVPN2QGPYiowHT34FR19r+QYuhqBQ==
X-Received: by 2002:a05:620a:1721:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c3d3a05813mr100265685a.14.1741106782081;
        Tue, 04 Mar 2025 08:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7EoTqVks4QCeBflC74F5I6vZviIdM8z0vuE9z7wp5fUI+aWIRcwJklBDc/2TUsnKYZjW+4A==
X-Received: by 2002:a05:620a:1721:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c3d3a05813mr100262585a.14.1741106781753;
        Tue, 04 Mar 2025 08:46:21 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fb09be0dsm97722866b.5.2025.03.04.08.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:46:21 -0800 (PST)
Message-ID: <f8efc961-2fbe-496b-93d2-55f9072bd08c@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 17:46:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] mailbox: tmelite-qmp: Introduce TMEL QMP mailbox
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        manivannan.sadhasivam@linaro.org
References: <20250228045356.3527662-1-quic_srichara@quicinc.com>
 <20250228045356.3527662-3-quic_srichara@quicinc.com>
 <lakoxihaqlu3vq42eoqtlip23ggdieizotyzax5up5n6ndbwsi@ddqyzvsdtmkv>
 <1359984c-2ace-450b-a3ff-bac0b9fb5cc9@quicinc.com>
 <2xpu26pu4ovnchumwx7xzlp2gldpfgsurnhuqaioygb4a6xmsp@ygmpk6furqs6>
 <3e326578-ab46-4d7e-ad1e-3d572613498b@quicinc.com>
 <CAA8EJppXHXafwx+GPh0UhFLRLW5DNj8RwXdO4+fDdXp=SE13Uw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAA8EJppXHXafwx+GPh0UhFLRLW5DNj8RwXdO4+fDdXp=SE13Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c72e5f cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=AQ-p2TLc_isDrXhQJ_kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ii4gVaycMjJd51P71LTgOfm5C8WnviF-
X-Proofpoint-GUID: ii4gVaycMjJd51P71LTgOfm5C8WnviF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=760
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040134

On 4.03.2025 10:46 AM, Dmitry Baryshkov wrote:
> On Tue, 4 Mar 2025 at 10:33, Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>>
>>
>>
>> On 3/3/2025 6:34 PM, Dmitry Baryshkov wrote:
>>> On Mon, Mar 03, 2025 at 03:58:42PM +0530, Sricharan Ramabadhran wrote:
>>>>
>>>>
>>>> On 2/28/2025 12:03 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, Feb 28, 2025 at 10:23:56AM +0530, Sricharan R wrote:
>>>
>>>>>> +          dev_err(dev, "Failed with status: %d\n", msg.resp.status);
>>>>>> +          ret = msg.resp.status;
>>>>>
>>>>> return msg.resp.status (is it really errno?)
>>>>>
>>>> ok, yes error.
>>>
>>> The question was if it is an errno, not if it is an error.
>> status != 0 is an error always.
> 
> Is it an _errno_ ?

Dmitry's asking whether the status conforms to the Linux's errno.h
ABI. If not, add something like:

ret = msg.resp.status ? -EINVAL : 0

Konrad

