Return-Path: <linux-kernel+bounces-445757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D469F1B33
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E8188358F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CE1F2C40;
	Fri, 13 Dec 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFR9NtIE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13A1F2C48
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134283; cv=none; b=Y7IwbS6fGIUflRDIDybt2vbONEs2rf80X2EPqMCSaXs1ph9toLAbOlfwjVL5s1vMMsNYv/mnzyxI2sucsl9ldg8ZBgAU8CmQB0pHsIkeSc2tqu+EuIZxY9SMtzKKM3e+q6DRQ5zzaIXUE1tm6ltcJKwAvXdcQS85CAKQF5anfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134283; c=relaxed/simple;
	bh=pDRIr3V4Ke+1ZHSEkU0Oe5jdjCVIe9x38Ah/rOfZMZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzsEfQBPT6kBmPtdE4SN9sckM2w3hBz9fFbGlhPOFUgCcOxG9A40zw1SkFN2YY34aP3aiZtSmNst4UfGP/tJv0wSYeB3jVpdnM+Q05JFENxtlY3FKOqtHwPS7xAQdY6IcR6/3wmFehUjmb5YHv5NyamtWaeMjtAiMSlKrFrtQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFR9NtIE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJARD8022842
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgJEpjhUpjinZzXlipmWXNty3sU1HuvMHZaSJG8B6Fw=; b=PFR9NtIEoxfANhHk
	tfYO6r/pVLkvkT73l8ANCIrlgBFzY2R/A21ZXmsP/LXk4rF5Bo3qnJXwkL1kthpf
	DOlUQ9WWquEHIfdFJMwnCjTWOqOgfhRSXT7ZS/bd6HDxOB1KXlHo2E7fzSqqcpTk
	TerEjNrU865ISQ63rPxAdSRPLwyLOSHxZcVtQAb7y1yRvFr+LEv7lW0boFMUDt7t
	GivRtqnRRo7GfEGj+ytpfYlC+dorZGC8XFZw43PBC5mT10GsL4G4l2it5c5x2pf9
	UH6rLSv3y8Iz6H87tih0UwfGSJEr4oy28iC3w8yW02oLh7AydJFhs+fdOejTPO6D
	ITq0pw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnbw88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:58:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4679af4d6b7so4180051cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134280; x=1734739080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgJEpjhUpjinZzXlipmWXNty3sU1HuvMHZaSJG8B6Fw=;
        b=E5d2Fn6QMxTv/rYPPdAv06F/55wmMWw/LWuyj36TA/c07HSSyZ7wuu1oNFHasPP009
         PopTD7vzVS61RCXb53lTVBFEjmwApW7vDE13fFe2Kz2c7pa3mLKoSjiJLIanUFWVTm3r
         fiok7bWefp7t2D+4UndsdRHuOF/8gCu198Z8ZwuzUqJe1rgOPfesoD6rYwYJmC+5oBBO
         OxM8UIE8jEAzu6y70wWb7DTTrqJ1QiYooc9vALIOtZwCaLjT2zh7nXFB7c7r42WSz0sP
         ERbuokQBcylXYiW+zkPfUxYXTRSub7dzuhxPg2Mjb9axyudJ+aA2TC1hR1OAwFwhYvRn
         0+jA==
X-Forwarded-Encrypted: i=1; AJvYcCV0a/5U7t/00+SOJ4qJFOP1xAY80C7/yDKbHLj50yx2qGyY36aw9Kyvf4EG9slabiDMjm8LjRXMahiayMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXa6rNWgRrCouPzDNB0pLH4RZo/sLxXqvUYJuQaAezeT8X8D1j
	T6ogUPCePEX1kenGid7OxPpZoLp4isQiBMxIoo06IPUclUd30Qig4s5O6pRaKKTm0tnQqsAawWr
	5yZkvNU9B76kOjrSjYgs5mrlC6N0dChz/Yst8eZ+BOgs6KgfDIXuLWN4LXP965Ps=
X-Gm-Gg: ASbGncvtxTqU9ZOMM7/sRRzKzG1g5mTXPoYE6hF0fMJhYDs/dzqNaA+3IR3SiqhYHyg
	JQ9z2Nw0j7YVAZPgz5YSvUL3WcHMt/yRZCfZe5plNNSRjl08VirKrqf6KmHQe3hjELumNqs9EGu
	GhRqNksWRs2cBMVnZnTq4xCIfjwiV4bSOlwEvoz+zgQBaXx9U4RBGD42KBJe/STRncwlHaojdhP
	gM3jrbxJ/U9tAoYxUE7t/7oMI3kgUpHAfAeQGieQToorYCKUfYzgQAidtMHtStzl2/qxpgFs8J2
	l99oYCSybd+5QPXPQOpr/deux42kerGDCFA=
X-Received: by 2002:a05:622a:48f:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-467a575541bmr33495461cf.6.1734134279943;
        Fri, 13 Dec 2024 15:57:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcInsrM80zY2XXRjWCmn/lWTNWUgTvmx+vLeVynOrPi+3UZMdf494lm9kqjgSOZLAPl8XB7w==
X-Received: by 2002:a05:622a:48f:b0:467:95c2:d8a3 with SMTP id d75a77b69052e-467a575541bmr33495301cf.6.1734134279626;
        Fri, 13 Dec 2024 15:57:59 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96005f17sm26656566b.17.2024.12.13.15.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:57:58 -0800 (PST)
Message-ID: <abda0d4c-9094-43ee-a6f3-7eb4659d734f@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 00:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/14] arm64: dts: qcom: sdm845-starqltechn: add
 graphics support
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
References: <20241209-starqltechn_integration_upstream-v8-0-ec604481d691@gmail.com>
 <20241209-starqltechn_integration_upstream-v8-13-ec604481d691@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v8-13-ec604481d691@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: grB8b5KOWRSrBx2JAoMxptfBnnWFmwNd
X-Proofpoint-GUID: grB8b5KOWRSrBx2JAoMxptfBnnWFmwNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=825 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130171

On 9.12.2024 1:09 PM, Dzmitry Sankouski wrote:
> Add support for gpu and panel.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

