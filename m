Return-Path: <linux-kernel+bounces-447381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC419F316D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E92216471E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100920550E;
	Mon, 16 Dec 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPW5b/Y/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8582054EE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355484; cv=none; b=hUd7tiB2srLYtzghj9dlS3IjjNDTb+7OCQydmGdJYerGZ6YfgpFpFl0DoUDMUxMTFKbc8A8oyWbxQnTeK06qcE3ltALV05Fz0vLaHADkTiPbwQ7UyfpH9s+F2jXUPt3sqX0aYXGT81ofmNE9V9SIR5TMeeHoD7rfRSc8xwels78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355484; c=relaxed/simple;
	bh=bzqmNQfWCCzPErXOsUzKJkneJr987eONxj/xWuXvctc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heI0yVP3SG5FfZoExFPEgwQwUDyUPPOM5eZLX/YmZkaJjD48jAb2GrWN+809nSNkdaLiSkA0vGogONakh4Vj09txt4STxu57l3NlU3reiq5GaPQ5sj7cp8cadWp1SBpM2UNlM6DPn6Dt/ppMP830AyXMWV5sFjLvvPb6+iqEoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPW5b/Y/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBL4lO025990
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddJJvcV6JfmZR8EvhLTE3jz8GYYGpgaSZHvZTGAa840=; b=CPW5b/Y/DTSNOqWs
	XmRFYsJqRRy2pGwxT4cLmXhW2FS6lj7cQF47Sk2ZY/ZyBn9fXDSJ8YaqyXz4kYny
	SHcQm84TsiaHUvsXKp1N2Oqnh865vXB0346nvCjBpUCofxQMyUzCw9KWtTcYVLoe
	YWZPRvsiXHf4ZOW/l1R/LAE1zK9xGUtrWo2pv+dKkemFswpElhkV38wVoAqaYrEm
	hALn4sOD5dpCyS3fJJWw6jeZ7BVlpJ+sTVCzT/n4uZpZzgxgrOCNBuGJIfxMp6r4
	NKD+Bl9TtEV2xWpNYml1CTijN94TcVEmp2PXi97O7ljR5hfSPTUc/jaQ4qkq1E9p
	V+dfhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jk8grbcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:24:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-46792962c90so6409101cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734355481; x=1734960281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddJJvcV6JfmZR8EvhLTE3jz8GYYGpgaSZHvZTGAa840=;
        b=tms4C8EuQopeK8rIVxNTm6h0gYHv1vfB9grUYWR+G4BJEt47FZN5VvnUKzDyqYsX5D
         YE50neT21zbAEHzn2/X4AcLdL85j9cnjdFGDCcrWguWzXPoq2wTo4PgmFh/0BE2RjTM0
         rqZ6BrMGZjDVHsTK0QJlhJYvVuP4tGa6/S4ONCUjAXtnY1m3pI+yP7/PEAjwoDyuHNGN
         ld5gP0eOcoJnPSs9dHwBRyyh1akPxfxHHp9IthYJA+0RR6DHJkVgI6GgPTouCMIOu4tJ
         wBwfTQ1ZtQ3ja/hsXgPqYGGe9HTXg2tM/0Dt024yPtGAqFi3H9UrpQjwYcCJETfH2Ugi
         FIDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPyHUxfY/oFpswfs1UyRUkMEPbmZ5Bqq1sotUK7PJ88DPHhBgrOqG5R69LsZ9KW6iWGoDSFOt1Ysw5UTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnV0jg2/JistIIqC2+Pq/TgyKe10CZjb76H+9ZofphKcHTcIA2
	ZnbFtNYGpnQG5SswCHFOB+44ezywFnz7WJI+47PWxMFjXq0poYQA7FHkgvq2wG8bLdH0khyGb7U
	vlQgVhX0JA3pUDeWU8ZCLrxb/Z6HQXxbZGVAobG8xTnHhrcUKKjrpM9HpUSD0uTU=
X-Gm-Gg: ASbGnctJnY54CH1G22nu4VJS4RC6WJ/LgF3LiD18nsOgYShDgqfo9rZUPiMn1r7KWEB
	YB7+j3uSWaIwCAcLjMxWLX403WnbYFYB84SHSrbo1/z7D1VI7tB5zXkNZqkfsAx+LCh1PmyRP9H
	0vbtL3llS8eRn8MZ0VAOZq3TX67s234opFljpmkZZkPEz5KBded/Sm3IigSY3ayzK2WwBBwBKI/
	8Mm4GYkjE0FFPqJnENGDb+DS45I8lP6LsIY0JT6tbPi7z9egZmxOQYpRpXHvlHsXDD+fXjcYYlm
	KnTGzldi3aVPkz8Xy0JvwLAscF3b0g4J5oo=
X-Received: by 2002:a05:620a:2a16:b0:7b6:6765:4ca2 with SMTP id af79cd13be357-7b6fbf41a43mr826587485a.13.1734355480839;
        Mon, 16 Dec 2024 05:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETNA10NH7CEL6e1jIBbcYdjpx9fqxYSa/P7akVHgXDcrLHEht2gl2CopgvQyQyU2eyAfemZw==
X-Received: by 2002:a05:620a:2a16:b0:7b6:6765:4ca2 with SMTP id af79cd13be357-7b6fbf41a43mr826585585a.13.1734355480470;
        Mon, 16 Dec 2024 05:24:40 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm333044166b.0.2024.12.16.05.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 05:24:40 -0800 (PST)
Message-ID: <04018ad9-f3ee-45bd-9d4a-be3d52f38b51@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 14:24:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
References: <20241125105747.6595-1-quic_mukhopad@quicinc.com>
 <20241125105747.6595-3-quic_mukhopad@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125105747.6595-3-quic_mukhopad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mxzw_xZLO3dZzaDkZLgiVHiKHAuUhHyB
X-Proofpoint-ORIG-GUID: Mxzw_xZLO3dZzaDkZLgiVHiKHAuUhHyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160113

On 25.11.2024 11:57 AM, Soutrik Mukhopadhyay wrote:
> The Qualcomm SA8775P platform comes with 2 DisplayPort controllers
> for each mdss. edp0 and edp1 correspond to the DP controllers of
> mdss0, whereas edp2 and edp3 correspond to the DP controllers of
> mdss1. This change enables only the DP controllers, DPTX0 and DPTX1
> alongside their corresponding PHYs of mdss0, which have been
> validated.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

