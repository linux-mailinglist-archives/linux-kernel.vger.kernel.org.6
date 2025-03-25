Return-Path: <linux-kernel+bounces-575764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F99A706EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03EF7A20E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70F25D530;
	Tue, 25 Mar 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqvdyqPa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50A25A62C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920295; cv=none; b=B1qsvDHhFuMXb32BEi+97As105PW+I9ideIzEMi2fUAUNPtxhtq0gq+CV1toe5KHgahEeckIxCXZcZ9FE8th9m3k2YECpI84ZdfZpT4kGb/Pljyfr5mT5sPI7ckqQDe0mU9j0URAcdWpfkwk7nx9/TtOD9wIbKtpuYvfo4PMjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920295; c=relaxed/simple;
	bh=e6SbQ5AyChnoyji5yq1T4gAtN03kw2CXIfnvOT07c2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3d9F6ghuXaD+DSSrh9Qk458Z0Otu9FNTzLqjprMCoaSrT20dpvsj7B4sTQRrgQSHx2drGB8+OyODYSXD4S75KhkMB9AWK/ZtbGE24nSkcZO7XEaeZrgc3BMUwlTio6/y1/Fu7i9M0NwZS3vuEp9xuniPMt+X8mazBt+dQRtzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqvdyqPa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGV0xe006595
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8sLNzsN930MIaFYNWCrndVcJUG/GpmkS60UUQezFiW0=; b=EqvdyqPa0ep6kIdJ
	hNBhpaAB6vNG2iq7UufsB26FhGU0Lx+M1P/j0NxXZO/M4W8zgOjd9OTWdUUGwDu2
	U/ggeKLYsJQ82FVLq/aKlOCtuvq0IgTZ1uivfhdT0X35/UNK2KfFnDxMBvVVj+DB
	hYOtxrhHrkX7zttEoY+y+yV+iRA/Qqul4KKqPpcb7uu620KDr/jR6pK74WzlEmMU
	iKa/5TA1PKyGvQ5IKDpAuLJRnPG/9F5jt8eoiVzFagnjZU8r/yX/Wpkej5OsWmzI
	+2VhHzMqYOgeqC837ZsQNZhLnU09nk5jeDdXIcFsaIQnzr+ngFK36eNQyJV4x1Kt
	4pRkFg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9g2eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:31:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5af539464so197662785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920292; x=1743525092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sLNzsN930MIaFYNWCrndVcJUG/GpmkS60UUQezFiW0=;
        b=VALnOoCuBWJPsJrQJ7N77zlXzTStMpxNM/u2xS014tIV850ia/Ucc3yJCNDf0fkQCF
         AjNEqDaiVyoUF3m+5T1fOzK6tVcT5v0xJvAxHK210Nyf5VH8S+aR94BeMjjFG2n8uU9e
         oLZXSn3IdOimcaNKnR4fyrR8s1OWSUd4MZ8lQY69e1rQ4ScnMQwajIv0asO1RPJRoIb1
         FTw4h5gvUDYtocdi4FwhtNxDQcWqfSSmkWCw57veasajfmlswGyrdDu2PS6fiVaF7PZc
         yABpsVBFLLLza691bx8Ompe4gwzbV7QXLmFOY/ldc1NVmE6mn+ryPzFNVDyM14hlHpsB
         0b5w==
X-Forwarded-Encrypted: i=1; AJvYcCWvyHnrZ3jJ4qyAf3Vb+ilcwJ3pAsIUL7IwEgU7x56xdSDQ0exft5YHz9AC/k7RfDsrNFLbXxqz4Pn/cj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLn0e+HtbZ/FNjQzT+RHhMCPev0lobuw6jA71Z56/ZnwDeuIK
	1lypy3AaFH5FTeydhXAlmB7rJ2gTmgtAW6weLp21H0+4HAl1WnZd8jropcL/sNyZ/B2qak+ypXL
	pTjgkyjWIEB04uUBBXRjxM4GXzAe3WLHEBZusY+8eascG0wss0kaaVoPjpDLsxUQ=
X-Gm-Gg: ASbGncvXF6XoGzIAZsGhrrCAolPWsLIgo0lM/g/z2Qd11usxpYS+jhBifjeRljLl38n
	6+hE+S+mjAr3AhKLrka1ftHvEIavFnkZPNO4MwfDEVKCxHKSWOgCW7yQDUZEuApiZW/0z+3Wmp+
	iCO4EK5mF7qwCAqRyzDk3FJ7KMWDfv/44a5Hg4khgcubk/q1XelVrlu9Zg/sUfPhGuRAkYFkd00
	//lmqlRvDtPH55hmxC7ZOcb8wNxLndrMrD7VntJj8XD+aPYl/2QQ+qXnGh+Nf++Dy5pyKUTW5ks
	UwLcK+Ax/HDAmw4oCcwEdQ5VFGyrB6pduFUSxtre/XQpGnMlvNkfgGIDiFtrMS3V88SjVw==
X-Received: by 2002:a05:620a:294b:b0:7c3:cccc:8790 with SMTP id af79cd13be357-7c5d9f7524dmr215371285a.5.1742920291558;
        Tue, 25 Mar 2025 09:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBp3BPLP2GGE9R3AphhXGm9rD8lWb6Y5ZCRaW6gr0oiptLbqaKMxd5nx0QUMpsS2fAwz3b/g==
X-Received: by 2002:a05:620a:294b:b0:7c3:cccc:8790 with SMTP id af79cd13be357-7c5d9f7524dmr215368285a.5.1742920290934;
        Tue, 25 Mar 2025 09:31:30 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbd3d3esm877532966b.130.2025.03.25.09.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 09:31:30 -0700 (PDT)
Message-ID: <db0bbc62-ecf2-4f72-a0c9-462fbaadebc4@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 17:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Add snps,dis_u3_susphy_quirk for some QC targets
To: Prashanth K <prashanth.k@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
 <ee0848ea-7a06-4f4e-9115-5e3c0ab8bf95@oss.qualcomm.com>
 <7029a455-47be-475d-b429-98031d227653@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7029a455-47be-475d-b429-98031d227653@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1nyWljzjBCpvpN25Psxjo2rvZ3ry_rLf
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e2da64 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ZqfHA1wz_kCA0izwLYQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1nyWljzjBCpvpN25Psxjo2rvZ3ry_rLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_07,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250116

On 3/25/25 4:01 PM, Prashanth K wrote:
> 
> 
> On 25-03-25 08:11 pm, Konrad Dybcio wrote:
>> On 3/25/25 1:30 PM, Prashanth K wrote:
>>> During device mode initialization on certain QC targets, before the
>>> runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
>>> register write fails. As a result, GEVTADDR registers are still 0x0.
>>> Upon setting runstop bit, DWC3 controller attempts to write the new
>>> events to address 0x0, causing an SMMU fault and system crash. More
>>> info about the crash at [1].
>>>
>>> This was initially observed on SM8450 and later reported on few
>>> other targets as well. As suggested by Qualcomm HW team, clearing
>>> the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
>>> write failures. Address this by setting the snps,dis_u3_susphy_quirk
>>> to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
>>> on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
>>> and hasn't exhibited any side effects.
>>>
>>> [1]: https://lore.kernel.org/all/fa94cbc9-e637-ba9b-8ec8-67c6955eca98@quicinc.com/
>>>
>>> Prashanth K (3):
>>>   arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
>>>   arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
>>>   arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk
>>>
>>> Pratham Pratap (2):
>>>   arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
>>>   arm64: dts: qcom: qdu1000: Add snps,dis_u3_susphy_quirk
>>
>> Are there more targets affected, from the list of the ones currently
>> supported upstream?
>>
>> Konrad
> 
> My initial plan was to add it for all the QC platforms, but wasn't
> confident enough about it. Because we have seen the issue only on these
> targets and hence tested only on these.

Okay, let's proceed with these and in the meantime please query internally
whether it could be applicable to others too

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

