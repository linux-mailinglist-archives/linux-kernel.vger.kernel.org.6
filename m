Return-Path: <linux-kernel+bounces-566697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A3A67B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C63ADF46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF8212D96;
	Tue, 18 Mar 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXZXw4vl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CB13D52F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320561; cv=none; b=gixBdjAxEiRdiDhZLwblOOPmokYtus5F3PkgqkKOO5bG6CRPHyijiLovZFwLIs9FuB1SvKmPj0R/591q9rPhal36ZhonwtndEf6ye2Z17OZKu5a5JSKmOS96qD4W9Bp33CBBfRvt/0SsO/V1hzxqx7onOkg3d466dT1DWM2p8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320561; c=relaxed/simple;
	bh=bVnws3x12+ykG1+kW3kLGujQaQdP727SU3Bb5cuBhDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhctLRbqB6NNY6VM9sskvEz5KFiYa09OkQ/EW8ijxDzungopIdk9m4lyY7MQGcp6vav/G64gjKzrFCGZR0EqIBjVV/+Mg3ymZXG0kSX2OY6nyNhw10ljv2D1T10JupiARQI+R+q00Xvz6Ce4qj7xXZeMjT4QC4AQwI/LpVKmcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXZXw4vl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAcTBb028635
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WYwU73RjEVKjZaZgWeYEmk1TjixaNfci3cjOuf+0t8k=; b=GXZXw4vl9ahAl03S
	iNlo76xpfrnR24EiBGW5dQW3oTW7j7w8lJvhPRs/OhlkN3vYAnXtQ5vjSDvDDtS9
	9UAqXf2tGwYj2TYYWd6JwcGBkVrzwFiGXnqKgA/nbgcBmkN22eSnNdGvfcqiwHk0
	2jdXLArh4/sSI8ZPXoSIQxQ92ShZqmepDg2SvKjFJ0AVbTH5jwCSZR5SzrkN2oko
	UBIl473EognT4n9yernmPfGvG7fKNZzRmb9Xu+uWUPt/7cAyWCKcdqQ+aHfcy5XS
	v3Gx0kllQHE2qZQKBeDk0HDFzWRvkuel7N1DBIuPmLvnrzKE+tmF7QZzi3uTHHf+
	YV7bNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtjubg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:55:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223f3357064so87668325ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320552; x=1742925352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYwU73RjEVKjZaZgWeYEmk1TjixaNfci3cjOuf+0t8k=;
        b=bXaz2V7wehK8eGV+hcy18QXUJOQ9q+IANxCizlpd2eYyueiwORkNbwHX+96Cu2+rFe
         9wVnvQkfXjky706IeZt6ww/lNa2aPkWZ14DapETB5rUPAFhUMKvIiMvUd0z5GQ6rgi/A
         qrb/5eBjOFijTXRTSRnIE0jgPAHgq9cSqDJzROtDOxpFh13VLoehjHpcVjoOIwSJINlR
         vrGRkeqO+xEgvZh+XQoS0+9qybsdgWhmQ3xCCC7h/RoiFCCwsEzz9y0pZlSmHVv/E90g
         u1hjtPmHidcSILAcIhguIlB+7aRuNwNuIwhm4F5yUAXXs3TCbi4bcqwycaGQ+xc37GJ5
         Fd2w==
X-Forwarded-Encrypted: i=1; AJvYcCUW2GQLWtCYZg1wnUvhEVGfBSigYQUDyE//Hy2hPCKtp2cgiDjpKCE+9UTbiSZXFCbbo5rwGaGvs7TMEbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqFvkiwvBfEWqCC27BQmtuZGBHQPN+OvFuEWiabohue2LzXJv
	Jrp3j+3Sp1PL23SCmVurEmXOHcY6uBtO51q/9eNeTrqdKcU6IhoIPiko/ykEkPiLiUajFSMcla1
	k588j/BZeZcEZG6aGIIKmJ3ePXgsu8Zk+Vv5yCZsO9AdxwedC/yFGd8GeaGSsKxs=
X-Gm-Gg: ASbGnctxZg/8l9329wEcUgGk1aWV6RQ3ubiEHiuadDK91AerRg4AmMRBBzn/4IFbrFY
	ZZHXUmT7kbJhyNMP77JoGtH2wQ4NfEoyNuAAIn3UkpLXpfIfr12ROb+hqsSsW1Ko9ulwV2Nvz/e
	D2QMoyjaq6chAJetGL2ta92kn1/MrvZSe5GTtJUoeetfdoCnwrKW5GWh4wsSpKdUZ3wBsSRUuTj
	lQcTYP0j5lB33GsPbn/OSz9y9sQSmzY9T6wFemc5xPwv4OC5KWVf98otjZZTWJOytfdCdTAkQdt
	O+FGEI45/urZ1CM+9UzN/wrdgz2gnrdQfe6qGQqgFbsRNuqCk6oD16ofYXsirAIqKu60Ro8=
X-Received: by 2002:a17:902:f545:b0:223:635d:3e2a with SMTP id d9443c01a7336-225e0a8f4a7mr210952905ad.23.1742320552111;
        Tue, 18 Mar 2025 10:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGQnb8IgzE4FIqsuGJu4IQxqgtuk/CstYaDph2XbU45sLrIAtach8WeFzSOU2ydIq8Q1MRIg==
X-Received: by 2002:a17:902:f545:b0:223:635d:3e2a with SMTP id d9443c01a7336-225e0a8f4a7mr210952535ad.23.1742320551638;
        Tue, 18 Mar 2025 10:55:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa616sm98018595ad.93.2025.03.18.10.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:55:51 -0700 (PDT)
Message-ID: <f35a6080-8dbd-45ca-8fb4-d6b01a5bb007@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 10:55:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QEZCNRXaaWBBGiad-XBGfvk_dWeem-sE
X-Proofpoint-ORIG-GUID: QEZCNRXaaWBBGiad-XBGfvk_dWeem-sE
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67d9b3a9 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=PCo5qUFWOPHZosJy6w4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180130

On 3/18/2025 8:50 AM, Krzysztof Kozlowski wrote:
> On 18/03/2025 16:44, Jeff Johnson wrote:
>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>
>> kernel test robot warns:
>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>
>> looks like others have fixed this by first casting to (uintptr_t)
>> a few examples:
>>
> Cast via (kernel_ulong_t)
> 
> But another point is that this patch at stage v11 should not have
> compiler warnings and it's not our tools who should point it out. Except
> W=1, all standard static analyzers (sparse, smatch and coccinelle) are
> expected to be run.

I ran what I thought was a reasonable cross-section of builds and did not see
this issue. Seems this issue is only flagged with config: um-allmodconfig ??

Guess I need to add that configuration to my builds...

/jeff

