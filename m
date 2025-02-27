Return-Path: <linux-kernel+bounces-535857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03107A4782B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E35216AF87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEA22617F;
	Thu, 27 Feb 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnmlJ1iS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF2221F08
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646043; cv=none; b=klnG3llMjiakfBH/QkkOEaImWibCCylSRc8NphQ+6QRIDb3J+QP00tDnP6ZK/bEaFLpAtm1gvLOQ79dhses32OPTEUY3GfPSivkk6+ut0OnLR4gw16OoN6XXXAkpvjPNsuYAeD5knL6UQj641j/oj0nClZZtw0c6oOH/nnb6iGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646043; c=relaxed/simple;
	bh=i3wWe6ahx0nNYsdmrz7shy89KbnD0dzmfCNsWOogpJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhNbR0pd2yrGAD5DKDAueLedIri6MnPsMxyfw5EZt9cR7oS0hRLfiKZFC05m7Pb4ynPDHZT6igJBKQ0d94hSd93mX3XtQiTfU5Tryh58LtECLAUP1iKE+dh/Mt90uBTCspTNqbI6gkvLk8L6jzwLAhDCv2fKri7mSfSzkbTdOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnmlJ1iS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QL0kQf017857
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=; b=FnmlJ1iSkppGX0of
	ovRe4Ynm5u+lnllk/9EYxSLSoy5jw/rtxW6hgpujapVHFpO7gL8PYstwfRPrZU/E
	ywHXl3xx5kIhSa3ssL5P7Z3aZ8o5g5o9QJn/j0eT8izlIW+rERR1j/ZmZZ8m6uL3
	o8azSsZY95zhzayRxKGlr/CdPhFCQQroHpGWOIyVTUgWoDgO6GIQyfDackQy9pcP
	Flz0HFH3hyTaqaGu3mZsB+JkRKAMAEMdElmCSXPQ1HlLXe87IGX783fi0pvFrI1+
	pObFeQzXldj25dDniAfi/CG1ze0Msv3fABikgyRo1B+Nbh3tdXaECCD6ZXVZYGFH
	Fn9S9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn4y8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c098c6c0caso19008185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646040; x=1741250840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGYRnAFE9J8dyYPOqeyvQzfEJJ9gyHSuD8SyRueTGg8=;
        b=NHSLmrDPSvjdsWV541fsa3it3pxWasXedEefzHlRV0mlvhOgoUQeLdU3fgYIIgJFnT
         3QrhxDjwnUh2298RfCMBCQ2/LvyPSPRBKdWqulcj08oPIG4jL+hVELmHndAWUWlxDvK3
         bEs9IOqsIZo125xp8Udmbl6N2OHYCZzgP939eRodrDFyt39j/OhvECvVTKChAdsG1p7t
         joUufueUjkjIOl6RlCS5j0qcCDJ0XfPDBdK5MFyLpZ/13dWz3WJCpQmZRd1GNYhrHf4S
         fkXNrkCQ0O691q50Sn8FPSkyU8RdXN3/aZ7yEmruDiiwpBJdW+Smg5UBlAXT2TEc3Yrn
         unFg==
X-Forwarded-Encrypted: i=1; AJvYcCVry9gl588HjgkksEzrG6TtXxH2ZnJE6ATxWC/WvgEBSPqG8PBlbPunjlkNjHsgv/wcD220Mai7sptJcmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFSLjT62lgljGB4LbV1ihKBS6tS5e/HLuva245fHpB9wdOpde
	1d46bnH7AB8J7dwa4gY0J4Exw9exo3J0UhqzNLHCfOfILWe2oO6n0Vl9iKaFi1i3Z4kxkgISbDo
	4nbbRg+OKXV5ThTaKv06Mzh5ljggGZAXZYyIKdGEz252ip2D3Z7bnK3E6x+VOjOA=
X-Gm-Gg: ASbGnct6z4BYrpmT02iGG6Wy4PT7WoMJIbLSAqJa9DMR6QiFdXRD0xoWAjwZ2BMj0fi
	WZl28VDGo0gToo0ApAM+j1dGsNm1I/bzQddH9pQn8npvN+YuMKqKK8FVRwArOu88lS/5dQxy8Dv
	nWw4AKnE5Y0kPYahucR+TH2/aOVTrmuhCtmGE/T8YPSGkAosOz9ZmIx/fImB+Znwul3udxZlU1e
	wZ+GrIy5KkewAPyUJ+6dArjEFQXUN7vGTbzti/JBScNhu6nPciaMkB4p0zMwkpKAsgEEYE83rva
	zwNeU4IlRSVkQqTvrPtTsLCpOCd3j3y22DEdRLgmAXLH7BJg1mb7vEDp8PImdKtPR4APyA==
X-Received: by 2002:a05:6214:5851:b0:6e8:9a89:b248 with SMTP id 6a1803df08f44-6e89a89b5ddmr3406856d6.1.1740646039596;
        Thu, 27 Feb 2025 00:47:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGBKDa5jKaMrMFMUtLLimq7Kv7aKbeI1R4WnniZsF+zqBRHKHZRtVkdq92ChRGiaRoWmBWBg==
X-Received: by 2002:a05:6214:5851:b0:6e8:9a89:b248 with SMTP id 6a1803df08f44-6e89a89b5ddmr3406786d6.1.1740646039230;
        Thu, 27 Feb 2025 00:47:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ed7ccsm87625666b.96.2025.02.27.00.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:47:18 -0800 (PST)
Message-ID: <38a66de7-db0e-4c9d-8cef-48fb64a80f34@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:47:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: x1e80100-qcp: Enable HBR3 on
 external DPs
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, laurentiu.tudor1@dell.com,
        abel.vesa@linaro.org
References: <20250226231436.16138-1-alex.vinarskis@gmail.com>
 <20250226231436.16138-5-alex.vinarskis@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226231436.16138-5-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e289Cyiv_nn_BBOOxPouLaQvLxeD0T7R
X-Proofpoint-GUID: e289Cyiv_nn_BBOOxPouLaQvLxeD0T7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=816
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270066

On 27.02.2025 12:12 AM, Aleksandrs Vinarskis wrote:
> When no link frequencies are set, msm/dp driver defaults to HBR2 speed.
> Explicitly list supported frequencies including HBR3/8.1Gbps for all
> external DisplayPort(s).
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

