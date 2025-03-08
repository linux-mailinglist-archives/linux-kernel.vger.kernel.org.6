Return-Path: <linux-kernel+bounces-552574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7232A57B85
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A63E188FC75
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06119DF9A;
	Sat,  8 Mar 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LesB243q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E7BA49
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447038; cv=none; b=gujHloRaBCZBfq8OfeifzNG4o2wIp4I31FXYi2kr31Jbg6xhhwxJl5Vjla77EzSOa9FMXFmYoTdcT/Ytnwj+w29Y2syv7x4EwQpkIId1B4TEqffqslXSuGWNgwRvElxVacQEMXLq2tDTm2gr5bECQtlmwfiMclmjsruqfvAmJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447038; c=relaxed/simple;
	bh=eHD1UOflqnibS+rNcgWGWII/4Eeo/dKZHtQqL98tyoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhsUsf+gwIFx+fWtQ+bNUZaumINjg2mPle/7iZmMJI3vBA4eSA2Cv7QVxqCrW342yHLTLlVut9lcrgXgVJS/PGINya+4zK357L1HFcRYJGrFciCTvRoUsl3rzrb7/0o/jVTRJH9cWQPKI1dBX2GiUXDYosH6+ChZd2VHxuBudE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LesB243q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528DXNw6030421
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	re5UzEZ5K6uVdro9hKWQbaz4oQpEoaV0Io0NxF4iFsE=; b=LesB243qK1RsT5R4
	qtOpimO+KyBkph3WmQMTmzJm5TbTR9+OibF+k3U0vlCO7/lYGdK7sArDnvMuOX1F
	chf3D2u3lQpgSco5/qniT6N9hskJm362Hf3IYxb2JrLMjO9qM0Mk2y8FZfzkJCVx
	3JgnYwXpd3njrVtqnSpyoSYjhgMPN3B0HXOZlMvcZj1M0vFyuNvK/oAFQHzDmG1j
	VEjhU3KdpWPQB8j874vNBYAhmX5SHihBFicDSOsB8Pl+6Z48l5Wmt/PYfGriVhUI
	i7hv5YwSNvC8ujULTkCvNH4RilaHDuY16md4xiSSKPcBFs9vVai3ikXfty6qirmw
	wSn8OA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2m8qvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 15:17:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c638248bso55997185a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 07:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447035; x=1742051835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re5UzEZ5K6uVdro9hKWQbaz4oQpEoaV0Io0NxF4iFsE=;
        b=KQ5RiNh7WGNx/Rvw6vLSc1jeP9u70/aSH/B6mGeDR4uJgLvSn3lHdmrvQAA/WdZMNI
         CdjaafOW3f+ReZFknxNTCLMAcQTL7nPIW5wacxJjZhuZ/i7Pru1ngizU4Uh9v+o+kIJa
         DM3QuX9s4aaVEHVQe+V9kXEyMJHjHFinJQlaDhi7K0WcuYhibDbS440R5DeDfthZhGWf
         FpuYrVxKvXPZ17CI0YXIWhqF+DLTiCA4D80tzSi84wJ/F50P9ztmv1XYcv/t7+a5rjED
         1KcknFE/GnKbCAoc3bOO+tvPOFiJRfYxxR9SEzYekJ/ULvXtu0GtnIxxvCDf+/RyVtXN
         W0TA==
X-Forwarded-Encrypted: i=1; AJvYcCVFbDsp3h4ZU+0swW4QbSW34x27/0fb9vM1JDAiHX6eceGU/+lJj/ocPg6qJyK8JNapsaSlVN4zb4Olymg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0mJzj1pNulXVxhAScg2NM4lHNRMOn6M+yNW1MsEXojv9y54b
	yJf/ibkuiVvIirS2FrfEgx+VHPkqLzo/XQUljZqPJnG0pkbnv0SyNaoENv8NbxDghwC0duWeHv8
	bdsDmHu0UoB0E5b/jlAIhqiaNXNpkQI82szbduPV9muwauIk3dHrStCAefdHXr1Q=
X-Gm-Gg: ASbGncvDkuUdBFKQBOqB7epR8k3vPs+9Ur9OjqFAx2cZa5FE2iu45ZHphGo2/sICJlc
	h4o3ZeWSCswQ6CrkZaHhb3QlbWk3qyOaG16nDHDP7VKHMuS3KBNhgexFdCilyt8BoTC7ijPszbk
	ftqI7u3h+pnpzi/R194DAXDJdymY0XcDVmKiRhope/dCJ4wFf9ITpQ+JZSAAD8TfR5BioKx/GY8
	KqrU0as5pUgOKa586aBE+Dgd/4IBiY1RXMO2Mf0Bq+8l0zgVUgEkIZ7u6Y26OAoItmajVM1jIza
	ja57Z3LO0D5MsVMinyhxxqK4BivcBnevwPxMAM8Q2ggwhf7ftdVeK9JU2zVRuwDq0nS0Iw==
X-Received: by 2002:a05:6214:5289:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e908ca7100mr16888496d6.3.1741447035355;
        Sat, 08 Mar 2025 07:17:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXqvQTdLBkyJnbcjsyepOHJUD5AVaMnkEXC3SHRcGgUUebagk/n8W0aVAJDr231t/iWfulzA==
X-Received: by 2002:a05:6214:5289:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e908ca7100mr16888306d6.3.1741447035019;
        Sat, 08 Mar 2025 07:17:15 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2390fe76csm447136266b.0.2025.03.08.07.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:17:14 -0800 (PST)
Message-ID: <a366082d-419f-4bdd-bbd3-5771f6ea86c8@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Fix CPU7 opp table
To: wuxilin123@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250308-fix-sm8250-cpufreq-v1-1-8a0226721399@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250308-fix-sm8250-cpufreq-v1-1-8a0226721399@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PS4gt6kliydolVYjyXb2xBFFDhho1Q9q
X-Proofpoint-ORIG-GUID: PS4gt6kliydolVYjyXb2xBFFDhho1Q9q
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67cc5f7c cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VArMjV_vRDmCgQX4rEwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=968 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080115

On 8.03.2025 11:27 AM, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> There is a typo in cpu7_opp9. Fix it to get rid of the following
> errors.
> 
> [    0.198043] cpu cpu7: Voltage update failed freq=1747200
> [    0.198052] cpu cpu7: failed to update OPP for freq=1747200
> 
> Fixes: 8e0e8016cb79 ("arm64: dts: qcom: sm8250: Add CPU opp tables")
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


