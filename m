Return-Path: <linux-kernel+bounces-531069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D695FA43BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6514B3A9D81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8BF266573;
	Tue, 25 Feb 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mce3Anb9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8B2641C7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479372; cv=none; b=esdnVBOL/L1uMPaPP5YpAT6r5jYPwLp597GJLjeGXGuzMFiwLABGJJrDaMTz9BBnQrHGG+D+kiLenEA4j64uvIrwkvKiNBU9n55DRP41jvMQq42oXqOi1wU+F6mRS+tOVK378uIO1lvAB6RmQaLrwljGs1w8IHHHbqOVyrsjHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479372; c=relaxed/simple;
	bh=ZdNm0AMIfwc917iQdW2Rl2zXJ5BDonFSHY32W1L5r4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTnnLgWlW14K4k6/kBiIuqFIHzbgc5KHqIzKvJA486V9KpH4fNh0Xqn5sQrLvgxb+vpduLP124pQE1EkIBLPWAgshPtv6oGkIWUJo4XC4vaAHyXQUkK8dPEPaX2Ap5dIwZBMkJHuNrL3KZnMlVq1kvuv28bnGyCiBSGHgPevXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mce3Anb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8Ihfw003773
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GequlyylXnIqG4LtGD84B3VsVCx7KNiPZUld/TTZp8E=; b=mce3Anb9rvwWfev4
	HB80HiedQmNlC24nEJXU3b4s6phbsqDnfsk91jfq0SUQMoodrT5lgGqK7OW8tLXN
	OE7rUHnif0PRQJXyl8ezdU1jzxM6gcFEXffO6GeTbRcGr1+pDeciwjvt1X4OvhRk
	LcYeyZCJQVbb9VcbSUc1ezMTXwoIaK+bKo+qTZtxxh5KIl2YPa/owByu9YXDYLzF
	QYKjbG5m6dxM5A9q5uzhXD/s8xaiivbJ8YIoHeqlBOo1JBO2y3bU9OifYVrjbhqJ
	Bu4WcQGYo4kLyQ7B592uVpcN1H6d3WhUF0U1qomygrnco4dLtNVqq23nrUPgcZf8
	+YmIiA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450m3dcj27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:29:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e662a02f30so16064256d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479368; x=1741084168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GequlyylXnIqG4LtGD84B3VsVCx7KNiPZUld/TTZp8E=;
        b=cMw9Fm2f4oNQbAOud7fUVtOlDbGKCy18ipTTndevdep9q17OOIllVsnfGAbaRqJItg
         zQjOP8Hv2Ea4XKyMpqa8sVUk7MVeyAEihUoLxtOtKG5raxMERvR+mpQIi8nQONDyQ+n9
         ebOXyBD7l56lesGe2HIH9VKcje4Cj2q9LeQVawzltRGHMlZLiPtvRf0bY98D3fEguvKQ
         MFGBinJ9gboBrnukPzRzodY0MfNhrZZduIaX3ain9zCB9uAjYyHyT3ZiN/RhEqY7Sg8p
         vOTFzJGmm0HOxaMzfVSNz/jOM3H4LpIT08ykMBVQduVWYgwfngCDc7S4RtA+eoPmbHKz
         TsDA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJyzK8nG3ABGCSsiyshubJ+vjCZVfAkf4kX5+SONwoJIA/5rbmg5NqoioD4oZWHEcicUS3GoF/JiOoNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ds0IX28gzrlM2Cp3q+Tt3Hfef6Y2jg45KdJ74Bf6Kn9MRVkw
	noVHGhp/v35WjYTval7CxwoXPJxhQb6ijpcJfSxtTKWehdr0VNDBDFRh/5bgC1rcUACEjHeO01O
	UMW9GcyGAGQVMj4vJEgyw6jGkkY7Ue5ykayu+uzUsSsKC5Ow4qkuvpB1bW5uvSEJpKNRsh0A=
X-Gm-Gg: ASbGncvz7NXb1fExaGsH8YEgNBAgKTHLlcQ6v5CzbJlUKKtsLDZEDEhcGTD/TFbXxMD
	65wxeZ06O9s1HOqDTOBUz1gwBRULrt+sYoKxKzoixTABrMdc7qAWOq6Z3qVRHBzpewb29LhQ3S5
	viaJUCsUm5TXwo5Usq4YL1ZSAKMvzkQ/tjYA1rfXiTHp9VlBrSFjKNLvDgVCMez8CRre3EVMj70
	esDON04wCcvbBSb4cVrEA5wEyBSCrrQdDKb6vm5QlRfQF2/vW9eTNIUlTmVDLOkCivql+TwQqqk
	hZCSRZyscF4ZwQ5uFQla4i8XDO45S/lbXsI5V56Yl9Q5FuFyJqWeyloCyl/TgWug39BQjQ==
X-Received: by 2002:a05:6214:4105:b0:6e6:68df:6052 with SMTP id 6a1803df08f44-6e6ae84f58fmr81439706d6.5.1740479368423;
        Tue, 25 Feb 2025 02:29:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn3RkTQaD2JXSuUMFzGjX6e1+EnlYdi9qDfqQpXuA2RsXKEk2lOILqYaECeRfVX82dBJcTAg==
X-Received: by 2002:a05:6214:4105:b0:6e6:68df:6052 with SMTP id 6a1803df08f44-6e6ae84f58fmr81439636d6.5.1740479368132;
        Tue, 25 Feb 2025 02:29:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e460d1bcdcsm1009166a12.61.2025.02.25.02.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:29:26 -0800 (PST)
Message-ID: <466134a8-439a-4029-af2f-023a8349f048@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 11:29:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable Qualcomm IRIS & VIDEOCC_8550 as
 module
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250225-topic-sm8x50-upstream-iris-defconfig-v1-1-8a17e2e193d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250225-topic-sm8x50-upstream-iris-defconfig-v1-1-8a17e2e193d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z5gw-UrzUS1CMv6VnDcYjo9wdJjKxuxG
X-Proofpoint-ORIG-GUID: z5gw-UrzUS1CMv6VnDcYjo9wdJjKxuxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=862
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250073

On 25.02.2025 10:10 AM, Neil Armstrong wrote:
> In order to support the Qualcomm IRIS driver on the Qualcomm SM8550
> platform, enable the IRIS and the VIDEOCC_8550 dependency as modules.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

