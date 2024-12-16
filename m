Return-Path: <linux-kernel+bounces-447288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F89F3010
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80277161708
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7A204C1B;
	Mon, 16 Dec 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJJhjJQA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642E204C12
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350750; cv=none; b=qVsVCkUjhPabWs6VVBq1yrNbIxek/JRoZLOcIKAzm1C6J9ChZtIFzhccplwuSLEkOOnp50n5LK2qLgHglqmA09gsMwtEQBvzNtyzOny2XAqMRLHyYidLWRl9xvNyTBLIrgl4/3s9B+Jp2SFVyg4MDhrgVWzcIJ8AQQ5bn+L0k6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350750; c=relaxed/simple;
	bh=br4Inlr1OYwkQ4DcqTTZJifF6KCfFQoqEw3+vLT1824=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J31WVUJq1sDODL6Ebme/LZooK+1/Y9vpHFEwZ3i7udnP/yNOZxMaStHiFwjkPrll6qr/yTpy2TJEG7IZje8xI6fS8gt76YpCEDTAyPLAcFwkrhQno9tJUI4+V0scEE/aoVrnolvnQsGLw7Xn+tWXN7+RJnwHd2YH1WW8dvf+MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJJhjJQA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG86x2s001737
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nozNBImrI0flQxop21C9levd721Nd++WaY3xG3YzRL8=; b=eJJhjJQA5mcOLeLf
	DEXI/VxmbwVAt3hqafOOpQepPggnSHfVc6eHRPGH57MO4Ih6Xgq9ExGYOksNDpz6
	Q8oZzqtc3CxUrXyTU3uP1+r3AUsV141RuhKsyfq9E5n/kSxkXMV2v6zryxI2MMbD
	wCqNRr/N3DVUsyuDBRuBOBtr4u2s5d2J+9wylIBFekAsZr8USm7arBkffJiCu4sG
	yaazRHG+XBMkPwYZAWAjUd2t9+ZDL3BiKNUP5mNrgVcS2ebR4SIaNcHY1N5unmZF
	QJ/zDJqyibSNwM0hpefLL67/f6cstqRIiMGqNDxII8sFVPh5GXxf4u9CpQciQymx
	ly1tEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jgdhgn3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:05:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8a3cb9dbfso9380926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734350746; x=1734955546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nozNBImrI0flQxop21C9levd721Nd++WaY3xG3YzRL8=;
        b=KjZJcFnEGKCnRg9xnEv/QEFuq+u/jxh7gqTlnnmC8gMT3L7sk9y6fOsvhz2ZHEyCvz
         yWPzj4YVjYa5ZgrWCKHh7yGKhWPycFMz1++kVoQVmL6cUU4DKFpuXGXnacYSs2PdJw5N
         W2OMwvu3TjVOl686sOTgXyBBxCjJH5JpD7WN4WqGxRvXPQKPzgGAa+QibcDpdNsb452y
         naZSQegYLI1DkqAaW/qSDs1n5ga8eRIuAy9iSqpFnfG+JYBm18ElNjoZj68ca+n56+/z
         tw/PEAgrHYkfM4nnliLzaM9VAc7sA/PHqfZD9mxyB8zDUUls7sTnG68V/8hHnpr6xkFO
         ItGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYzC8qXLA/uNXcppZHFvxhnarSkpT85D+OHFg3ZLBXPPH5cpDhJzWP6zZu0xack/IKlGHMtp8QdWp/Mv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8cAysqzftM9Zm0L5sFADRTjtx1NcD6wqA4nhpOg1g1Vd5xXq
	vtklFHFplXNcN5dYffvnCzHF+LTg7HU46zzgT3br9x8cO5l+NU5YHPTjW+vwMEK7650amXnfVhQ
	RKnQAQbL1nUwM4hUsD4TF7oaEXe34jfXV/im/ZIwtHQUCwJYajiWXTHipMMJB8RU=
X-Gm-Gg: ASbGncuPxVAQopgi5lYZ51knAtbmRsZ/LQxYO4FRD7DIgTXZomqAZZR1qpdpblAq4Ru
	qI8xeUjNnIeF1SfvzFEhWl7M/vpbYeSFRbPycrndd0/dSIVN/+0FsZMCUbQbxi6DeR/jQ/tgD/A
	loQ0cHgHfKBWmWkSjleZJVvldOUYUk3Q3wHy/XrPHaeR54Q/JIHnGjGzau16Jtqr2b+o75uNLjt
	Eoqsa5AFu1OSjSLdgkbDZUJ8TTW3lmf2hDL5+tpPg1zVFN29daB1MVGB88njtNUwdVuuOwz6pUr
	4hltUdg7Rv24YHzzercyQkT8YyxNJ5Rx6xk=
X-Received: by 2002:a05:6214:27e5:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6dc9684f7camr74570566d6.7.1734350746659;
        Mon, 16 Dec 2024 04:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeXN80xQXmAhwdOx8Qvq8LX1rjnJEvO+IAfXQhj1EJOLdCPH2AIDU5QEJn1/k/Qfvf2stHuA==
X-Received: by 2002:a05:6214:27e5:b0:6d8:a723:6990 with SMTP id 6a1803df08f44-6dc9684f7camr74570366d6.7.1734350746286;
        Mon, 16 Dec 2024 04:05:46 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068928sm322936866b.70.2024.12.16.04.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:05:45 -0800 (PST)
Message-ID: <b17f1675-9ffc-472c-9dc8-50fbae5d18b3@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
 <710aa948-d27f-49f6-a4a8-73f6208502c3@oss.qualcomm.com>
 <Z1/JG+RkTBW9JuMO@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z1/JG+RkTBW9JuMO@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VRKZQJOHumSCI7kJpZCqRg_fhMWt8WUi
X-Proofpoint-ORIG-GUID: VRKZQJOHumSCI7kJpZCqRg_fhMWt8WUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=843 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160101

On 16.12.2024 7:30 AM, Varadarajan Narayanan wrote:
> On Thu, Dec 05, 2024 at 05:40:15PM +0100, Konrad Dybcio wrote:
>> On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
>>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>>
>>> Add Qualcomm PCIe UNIPHY 28LP driver support present
>>> in Qualcomm IPQ5332 SoC and the phy init sequence.
>>>
>>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---

[...]

>>> +MODULE_LICENSE("Dual BSD/GPL");
>>
>> I think this is too vague, there are many BSD variants
> 
> Will change it to "GPL v2"

Checkpatch will ask you to say "GPL" instead.

If you want to preserve the dual licensing, maybe consult with
legal whether MIT/GPL could be used instead

Konrad

