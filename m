Return-Path: <linux-kernel+bounces-433684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258559E5BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5461885637
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DB22147D;
	Thu,  5 Dec 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTv9MVdt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E3221466
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416926; cv=none; b=JYpQy3cBZk9M9yaJGfSV9RjQ5N5rj/wyk7RFD7xeKbt5mWniqqN6xpUuPTWIZPBOuwLDvHa3Piv501+dw1kA6+FKmePXLYdTbTvL+ACdxL19/qPRy3nGmlHiCz/72P6V8Pom+6vOKQSnPzW79xFcHl1xx1INDiuVHw5Z/tlRrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416926; c=relaxed/simple;
	bh=jFEMWbR0VhaeTPkf5GJbzyeCa7aECzmYDLLXPPu74Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKqGw52SSw3nBYGTBxoh/qFD7mjeA9wx07ndeYFcpoLZFOcqRsM4Sf7uAkuTx1MoavNsyU2Hjx9nniCl8a802SsLtvkZVOZrwkqiWsAs3eeeo4yIF0kU5Vt5tGbLxBredwO7kLFqBZs9KloS9a1EjYfMQ7aEPO1OrafbWfnKnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JTv9MVdt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Bt3hP026672
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Go+snB4FH6pFEZCnjdkBfOyMv+1g0HKMFcvMCjUYGfo=; b=JTv9MVdttvaQVmrD
	JMX7FLwLipdKJvDwMWvd89CnYL6Ogjtal2GPGOBv4CkdCI3D+xQ8G4ZIQdEdJ4Fi
	nvNxabMb/GUlLej4Nt+cE9i4mJhx/n1BTBIPmYQjrTWRE89L85LA6XJpCYmuKkIH
	VafpGfilJsNoeDVbFobjfYC6V0MGrYc237emc81sRQgnEC43EU8g4q3w59adLRhX
	qKq6XpCvZnhIaTMErgSZy6WE+y/SgXABgb8Ghg0T8b1vlrv4MkkTCdOa/F3z38NK
	Dr8b46lZHoYnbfgzi40nlVfsCI8JSDyVULinfYad6+DH1MLuH3iBJqHPEWB7WOPU
	C5KxwA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbqm0s9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:42:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46692fb862bso2289931cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416921; x=1734021721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go+snB4FH6pFEZCnjdkBfOyMv+1g0HKMFcvMCjUYGfo=;
        b=rvjqC1YpGNb5rxNEF2Gp/yWLT+TqXjMT7z86Zk8e+cmyfV3WS+XSPQrHinkmQhrJea
         C0P9h7B80cPuRGKS6NQH6/919KGtPaatmpGZNoi6bk3QZBPIbuN+5f10eJUwajjorILE
         rjFrcLVeMSq00zJRAdXleCT4HoY3TeXh45MhMGs1LAsaJi45pUCHbTrYOpxvHMWyPYf8
         4x9c4R7Jc0kI2kz1QzHSyiBuLSPxPI4VyD8ZyDhjDKsLiDRNkVj3HwvMXoYTQCpOYJOP
         V58gNz56KsylHe9Ml0VKqwtfVmdIehaK9CYx40Ds6B4JTq7Aie7mychSRA1aBNrXWV1k
         cDsg==
X-Forwarded-Encrypted: i=1; AJvYcCVspALOBL1qe+ZUpTwelVdp9/3m6E+xb2b53VvHUX/OOztAQHFaF7Iq+3nkoVLWwv4MopXE8gzqJAtDUtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljaOiH4Xi/VV9lwPw4ZVM4pOV+REawpV7S+6mW5JkPIJ4VrXY
	71R6QAuihGD6X7zfG7nFeXCKJSowLwohPcpIHctqU2hAhMhBxtnfKG9h1cSVHBPhuVvhx/GWXg8
	qhH3nF6d99XztMYs7VLeW8OOIICxYlfqoY3vjZV7G/CvtVFpiZ9m8NNwyeoFtu2E=
X-Gm-Gg: ASbGncvXz9CKNvmfkxuG/P0xERSJZ1ZAhUSKwOCIjIYHLwPumcnThpdGSoF7xcxOLVx
	MN1t7rIqeBm9uIWapXWLKbCd1nbmnVtGeJWPPWldvsg2O5aPaGvQJAN1nKEWtLvh0vsOj4JnRS3
	NoNcajVcaO+pGGfMJ+MAEah4uQUxKxIxsZOqDKvD+3giS5NFgzNfRibKpP6DddW5W5zMtGYIsdi
	Z54+QySp4rXBg0aLpT/D0emNbii11FtagbIRC0tlCCyo2lFoMdQDrC/rp9obNQldpoYwdmZrFEN
	uphSc327kPFKizwTMrJixy31cStxCPo=
X-Received: by 2002:ac8:5a11:0:b0:460:fe2a:2311 with SMTP id d75a77b69052e-4670c372ba9mr71128591cf.7.1733416921283;
        Thu, 05 Dec 2024 08:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV7SRkAtz3D9vcQvS/ksz/bMCqXlEy7cy7fYGtzD2n6lH/UZBtIGm4GJI6vdwH4FYNiyJTMg==
X-Received: by 2002:ac8:5a11:0:b0:460:fe2a:2311 with SMTP id d75a77b69052e-4670c372ba9mr71128411cf.7.1733416920949;
        Thu, 05 Dec 2024 08:42:00 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa3besm984232a12.75.2024.12.05.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:42:00 -0800 (PST)
Message-ID: <0aee7d2e-37b3-4130-a090-a40773638871@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/14] arm64: dts: qcom: sdm845-starqltechn: fix usb
 regulator mistake
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20241205-starqltechn_integration_upstream-v7-0-84f9a3547803@gmail.com>
 <20241205-starqltechn_integration_upstream-v7-5-84f9a3547803@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241205-starqltechn_integration_upstream-v7-5-84f9a3547803@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZrnUN00SMnDpEc4AMtx-0KnT-6MiE7yk
X-Proofpoint-ORIG-GUID: ZrnUN00SMnDpEc4AMtx-0KnT-6MiE7yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=622 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050121

On 4.12.2024 10:34 PM, Dzmitry Sankouski wrote:
> Usb regulator was wrongly pointed to vreg_l1a_0p875.
> However, on starqltechn it's powered from vreg_l5a_0p8.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

