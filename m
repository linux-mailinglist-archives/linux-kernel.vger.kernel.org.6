Return-Path: <linux-kernel+bounces-521208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C327EA3B84F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A1917804C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF91CF284;
	Wed, 19 Feb 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RthxzhI0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E81CEAC3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956321; cv=none; b=lfRcgIyNQRKM7Y7Oyq/+80BiHkLJdEvr7ImMoqjGmA/ZYCSCtFYieq/rKHYTLPZC4MQP3ZeE4WpcjwJOYzrd4NroD4VO42CDxxkfRbqFNW+4IRFLwPI57vLkJY5VQA4zN93UIn/Ku7DiHTfc+HZ1swtYpIWnAyqctshduPJQLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956321; c=relaxed/simple;
	bh=pqdqicKugu6SrprJ2ukWyHWA7wIefRERcYkP49tq4X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RWoXEJC4oBRsMnPDUInNIE2NZiJYxxQ/UZrM5tv/UNATg8WYeLnrLD7tI4+U1ITB8j6WxxF3S+2jJgu7Z8onRf6KwgTPnllWYQn3s6FzHNC6ZzQHAgN7CyipXgWNN7EH3Howw03Vtcyf4WfL7CAKSzQ7QtlS8rUt323N/tO5eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RthxzhI0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8AUEt007937
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RWf3hyFP9qHu3N+TuFQ4QO5891nOTUFYzZallVfx+Hg=; b=RthxzhI0ikeMV5qF
	oRwLSgv0b4EMML3CyFC3/foB8KEMdXDplHcZVyqW8HRNsSyS0bTMWtIyhJDfe7jN
	ktUHCSsr0jguNQnCaBwcg8UhYEQ3GDmfKB9XXei6VLAGakZPlM4ayl0sMDsNyD5l
	cOIy1wOrzWanUHBZHVH3jNujkXW80DscOklkNqNjQAPdhzUyq3jQs15Di6dwIyHN
	gvaD5z5PdF6VCcLc7lErGD3u0IgdlyhIXjtwEkW25krPv9wyXFn0w1R6VwCVKJW9
	Uf8AFultERoKj+aWO3NMIt96qms0SyJ+JDNAQcSyzLJ+hTDFhBviMuhD4C2umA0X
	gNGLog==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2sw6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:11:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e422f1ceadso13562696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956318; x=1740561118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWf3hyFP9qHu3N+TuFQ4QO5891nOTUFYzZallVfx+Hg=;
        b=ulOapCqqKYvHzMk1zZqGadGR8ieCkBT9iKaPTS0N0du7DchnXg9FcyiZ6vk5NH8ttt
         h/iwRBznhBxB6t/0proFxuAqhG0+EtQIEXzkq2xx5+mqhZnu2d6CHUO1LM7q8gClK4jW
         d8b/qUe+Tqlo4dx6zN9yS3cplbpaCpzvrfJt2JEcdwvEsWGObrAnML2WtC5vBHfmSDmO
         EMoW1dyeyGIZ9/aWnv6pHMwF53h9TnIlADjxptVvbQ2LABxg3FqzgnmXaQ5Q4gp1/oYc
         pGc5gLRfenWua7iqEW1SwqSlo0BtaHrPTnUd9/wp976f+TEFV5ueDjNrAFE0uQD4xqG8
         wFjw==
X-Forwarded-Encrypted: i=1; AJvYcCXsZfYnw5YoDE8MAnpfkn/J5ZMCgvktK4yU98vcx8wansEB1fE0djH3jef8rXUWzmGcTghatMZUB6Dp+p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSR3e50uNPsu1ioM0PMCrn++an2lK/9ODcE7xWFjWwqFMLRLke
	+Wo+TggxAsS43MGIDj2MrXFTLfpS5OYoF+xHkicqyC2TExShrQQUQRj811V4v4CSz+DmdY8E0Jn
	q6uDq4T4zN1Wv4N/htZuNTikzgVmzqLp0mIZvmji9YnQOgS55BUPxQ1BBEJI3IOw=
X-Gm-Gg: ASbGncspP+fKR6xdnpeJajoh2Cw0KycwVBdBpb49ZJdv3CRvoYhKgb9NOpG6B6hUUN0
	H6dbqyM0DXV6i9gu9ojigGVvQJjX9Mb7ReXdoH6QoOt55/T0MiAZXWhkXX6FQtojfJW4DM8Hg23
	PISI569VnBjLFMfWlyOO0QKo/8LhZ7j3K3aG+DMaE/FeGTXvivciyaor+CE5qVNjYeV5kezJqua
	gM4wbztk9fYArKD8pXY8oA2X8UWVEnqWXCc+so8Q3tAurNPxS/DTkbwgr75gLakfqLNI7Mm+L2B
	wub6eDzXFkTnzY0MxummhxkiIMCtAlcbu3L8EYFUYKYV6rMOBvZIxJEcDgw=
X-Received: by 2002:ad4:5942:0:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6e66cf43fcemr85064206d6.11.1739956318252;
        Wed, 19 Feb 2025 01:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh9qfRwSyNI6u3E0QX2thSjqiSHPbSUsOa4hdyGF7Wzxw9q2KMY9CN/e7qnLI2UuDgB5hIjA==
X-Received: by 2002:ad4:5942:0:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6e66cf43fcemr85064006d6.11.1739956317671;
        Wed, 19 Feb 2025 01:11:57 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8e0c38absm654189766b.77.2025.02.19.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:11:57 -0800 (PST)
Message-ID: <3e00048d-ffe3-4594-9e54-ccc1b2edbe8c@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 10:11:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8750: Change labels to lower-case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219090751.124267-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250219090751.124267-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Wiq_eUNKutc_aRDjQzNd1Ga5oBA4aw3A
X-Proofpoint-GUID: Wiq_eUNKutc_aRDjQzNd1Ga5oBA4aw3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=900 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190072

On 19.02.2025 10:07 AM, Krzysztof Kozlowski wrote:
> DTS coding style expects labels to be lowercase.  No functional impact.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

