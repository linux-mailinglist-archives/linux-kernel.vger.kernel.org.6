Return-Path: <linux-kernel+bounces-409522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA59C8E40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A8BB2EF28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F111547CF;
	Thu, 14 Nov 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLaNurCU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76B1547CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598052; cv=none; b=kDh8svQ24I5XD5UoVPWPEUtKlKWdCNCWyIs0iVN29fYwniqEhGjL1nXlEEZIi1mw8lLh5VnDjnGDYeQE2zQBkDCDUfUHWVlAAWsIKxjBMiZDQypgsHNfXe6doFQh7y4nMrrY/+8z2fDxzR6BzOfCZV8MduDDN0YfepKzb4hmy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598052; c=relaxed/simple;
	bh=pJeivAMUePV1CFYdUIv6PQhv4/I3V647DulnwjsCZLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cykmTVmgSLPdd7gluQ/WfPWaKXZJMYMz2Q4kKdrp7GUa2O7kW+qXKtclKs/GSG2ZEi7eqDzq4HiU4QN1UEp0bIwOrmSmRxWawM4pPbnrqNQZgOEQVA57xH9c7WOn22ZxWl9FbkvUdKd5Jrt5ZmWOZdQuEKwyWceL6yOdftXVT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QLaNurCU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEh4UR026715
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqwK68QV7anZkYzbtQsmbmF65JaW6sNQSHhAt7zMFpk=; b=QLaNurCUlcur9Jdd
	kfj4Le3TFv3IHYqfS+72nDuDb0Vn8O7uf9HCC4ZUEwQ0lWXe80Y/k5JTWYMbxl4b
	7WH/6Sn4DZchxSNXPN06oEub2M2kTfSR5QRhc/BGNpcCrZlVR4OxYbAbMB3dIjqr
	Da088Qb2fHc129+yi2OSA2WZLPRWcqb4IwU7eq1gas/NvylcQTdFdMKpU2fcwyoY
	aZN6AW8pZli2VIBe0MHYN7GqvBXqjQFIhAvKpdAU/gyvsYw8nv1tpHDgL821dz/U
	/6DfmslTL1w0FgnmhC9ldRAsayfR9+wCIcJz1rPKyzyFlc8GL/sUG32Hn/2CUWEh
	D6yZZA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt735a3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:27:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460abcbba38so420691cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598049; x=1732202849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqwK68QV7anZkYzbtQsmbmF65JaW6sNQSHhAt7zMFpk=;
        b=JJ7eyYAefMntns7SfgTyi4fkrJ8blgjefhGKz3PDxTH3feVVA+wL+nwQJRqVbMbHJT
         s2tNsb/cfBv08UzUneY526DHSJuhOE58vUjPf4rNRdBjtM+sgaCeeeinKZzwY3+JpH9D
         9lZemIEyi2JD1In1z5yIzVMisz4yfDOPqkrEJSnrXVqlYC6XQQcIkYK9bQOsk39eGXUB
         vESF0bFI/DwxM+QPHvFvPChzHpmatURLa9dju4DdFCsU3YS6UN+WnYF7JLFvckl93OsU
         E7wbUNrssSiD3uqzmZqe5uFWl5vb2uQqilv6MHTaLVEWlvADdf0PAYuX0PMUDi5htcis
         GeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1h0NbIpwQbzE3eNGriqqvtaB1KZPq3vTulqvUnUtzC8hIpLvrUiyDgAXcd7yOeP05uX4NKjj6KeJOG08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5fpXyULvcCHjNLNrdr2trqk8ryYMY05KiRr/Nwm+tU2fPYY7
	jdzO1RJaTLbR3KisxCqHia78s6OnjrgTllTkINbj+bhjIoRDtlHSSyPIXOS3zcgy9EcZPo9WAHm
	KLQpOJKYyxR63gUSuPjvjHC+zQ15L+VRCWSJIXi7S5ewMqy0wvqxM1BW6dr7rJP8=
X-Received: by 2002:ac8:58ce:0:b0:460:bb96:dd02 with SMTP id d75a77b69052e-46309316034mr164398621cf.2.1731598049393;
        Thu, 14 Nov 2024 07:27:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSfzrBG+lhdGHrTTXrH4knwlu1OmK8TQfwcDQEvioxl9razUvy4nRX1r6cZkneejShWoIBYQ==
X-Received: by 2002:ac8:58ce:0:b0:460:bb96:dd02 with SMTP id d75a77b69052e-46309316034mr164397861cf.2.1731598047583;
        Thu, 14 Nov 2024 07:27:27 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1e3d1sm656722a12.89.2024.11.14.07.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:27:27 -0800 (PST)
Message-ID: <9d690e39-2bda-4f5a-b7a5-2c9cf90a8065@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 16:27:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/adreno: Setup SMMU aparture for
 per-process page table
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20241110-adreno-smmu-aparture-v2-0-9b1fb2ee41d4@oss.qualcomm.com>
 <20241110-adreno-smmu-aparture-v2-2-9b1fb2ee41d4@oss.qualcomm.com>
 <CAF6AEGvD95RyUXDBjgmoefgO6QyeRw3tpa7EG1MLFKdxcoZ-4g@mail.gmail.com>
 <5a959c08-cc90-4a05-88b2-e1ee666561e2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5a959c08-cc90-4a05-88b2-e1ee666561e2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GHs1Tt5yp5Y282x49G5oMfND6aKnOM1P
X-Proofpoint-GUID: GHs1Tt5yp5Y282x49G5oMfND6aKnOM1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140121

On 12.11.2024 10:15 PM, Akhil P Oommen wrote:
> On 11/11/2024 8:38 PM, Rob Clark wrote:
>> On Sun, Nov 10, 2024 at 9:31 AM Bjorn Andersson
>> <bjorn.andersson@oss.qualcomm.com> wrote:
>>>
>>> Support for per-process page tables requires the SMMU aparture to be
>>> setup such that the GPU can make updates with the SMMU. On some targets
>>> this is done statically in firmware, on others it's expected to be
>>> requested in runtime by the driver, through a SCM call.
>>>
>>> One place where configuration is expected to be done dynamically is the
>>> QCS6490 rb3gen2.
>>>
>>> The downstream driver does this unconditioanlly on any A6xx and newer,
>>
>> nit, s/unconditioanlly/unconditionally/
>>
>>> so follow suite and make the call.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>>
>> Reviewed-by: Rob Clark <robdclark@gmail.com>
>>
>>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> index 076be0473eb5..75f5367e73ca 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>>> @@ -572,8 +572,19 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
>>>
>>>  int adreno_hw_init(struct msm_gpu *gpu)
>>>  {
> 
> SCM calls into TZ can block for a very long time (seconds). It depends
> on concurrent activities from other drivers like crypto for eg:. So we
> should not do this in the gpu wake up path.
> 
> Practically, gpu probe is the better place to do this.

Do we only have to do this once?

Do we have to redo it after CXPC?

Konrad

