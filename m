Return-Path: <linux-kernel+bounces-534535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E1DA46832
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840C13AD7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE47225402;
	Wed, 26 Feb 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdNZnwvP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3C2253E4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591414; cv=none; b=R5jhYRKXM7zOb/88ybCDbjqKRKkI2i+/QD3nlfYi9j+urLfLdfYMjHHv3Z9bdiuuElFbU1yIQmW9po7Q04C5TzVRCCT6prjQVoHb5p8FU1EVzoMqhWxwy5vYoqSRUiyxfuJRSB5gN5P3rMWUGvTevB0GP361J+A+9jzarVvip8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591414; c=relaxed/simple;
	bh=iKrBE8YXHqxKwWS/VKbfRuC81Q3gfZ2jZsZgbYf9j74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Flduiuh0NlMZnk2FWvaVvn2nlgrbti4RoZr4e4Vy6Aed30uTRN1rdPoqO3/Nzq+6RSwFW6AElWk4hkjXS5D8HRlwBj9nHvd/UO4BJAWbVeoXpknTqXr+ODKC/OLKWN322ekSTfqIGmnw/9u2aNWieQLNwJJnQKC9RHFaomTjXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdNZnwvP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAHZ0u021393
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vAlFBNXTCAS0/SdDMb8XLAtCY8C+/iNcJ4PHLsBUW8=; b=EdNZnwvPSfBlNAU9
	X/suYF0Y0yVI3EdAJ1LYooz/HBwQqOdH/fKrXYgUfVchCpTsuQLtAoJIsG5XyFjI
	3rEwKn3RLeNpAB2z/bOArYiBuHouVUVzLGsSB8s7trKaYORfb8/SV2E8PwGqwh/K
	gFvay+fmLqKtQkqu0QADMlE60Hogfe3U5jlP0yPLjUkS2fmMyBM1s0+Xq5Aa12EL
	kJlpHSsBCDSqYH/R/1nW6ANEQwd4y1/OgnRwM5kZtmZ+sGY4lderl8Q2n1k9ohwZ
	a/Xrw5B79dkhz9qJuzbqrYpJVXEQpcX1hRZEli2s0l07BEol6rhx9gUrf8KmLiGv
	iJ7yHw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkjsga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:36:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e88eea1af5so178836d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591409; x=1741196209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vAlFBNXTCAS0/SdDMb8XLAtCY8C+/iNcJ4PHLsBUW8=;
        b=LQdzrCebPWewMHG95L39OAXAYacq6I+E3eF+AwW35em6FO5a+HHCgAM97+tEEL8stF
         D6sJmBbKNq6o2nntq3yQsYsZyVc+Iu/gYzoTP9J3iqY2QB+WcCHPBLtE9mpzX6Q+PzYR
         +e3bBHYe9oIX4zZ6hiJyYBdYzSpt1AvWPgJA1GkJl3foXR1nA6ngWx4g2B1kTbyg2ph4
         mMVw8ZHM9NRIV/E9SSfrpNBFVlpgIZlW3RXmgbN0w7YdS5AzjJHsaJT8I3VVduPL3dut
         7qTnKxMxv6/6JZN/M9r9uOQdOioCoYxAMzvnfPPWgyHEljBPUN123hrMV2DnNNN0ob74
         5JHA==
X-Forwarded-Encrypted: i=1; AJvYcCUj61mMAHITXT0lEOe3d4S69bmoF+sTAum1nUJ+sZ4CCZBFsSWoiz71MiS0CibcG4X4KMdHDmZdT2khTZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTObnOAanTwqdIwk9O0RFp3bbynIo1Wmv2LRPtn5OGHUYyrmX
	p3l7AHJwKyZzSujSbdaVJVezGITEt4le7reENoszFTIKYxv55zzFMfBzJymXaLABozQQT1GeSPJ
	LMdleoB+Xvz08CuJdm0x/Yw1g4fxIAh7Sv+8ADWf0DXRYXgRLkpPUM5y/k+icy6s=
X-Gm-Gg: ASbGncvoP05af9b464jw+xEbEPthU+Z6ipR6PT8fJ3IeTHEUN4OA3j/Ff7y+kdRTcmI
	H4VCKPH/v7ky1DL8MhgZkSweyBP5MS4pg6xBLjz23/NxcjY1Cs9tKfr7yvQVl5FT3uP1n/CZAir
	ifQpQs7zHDXifOq5GSZ42IAWsPQKTRWNMWdUJkkO9BKcAcZ3rIOnQeTzAdO355iELjfuXjfLor1
	HCO376Y2OerQpqXgaGN1DomDqe6GeT/nUBTpDArosYiIMXnjeZeUaBkRup9bqCM4+a+Aq0Kt/tv
	jogE39Ti10IJjIlvmby3TJp+Z9rflYoIidKBxKYD9sZk4BeAmVktHyhZC+rHSYSvYsTyHg==
X-Received: by 2002:a05:6214:20ea:b0:6e6:6081:34ed with SMTP id 6a1803df08f44-6e6ae9d5df9mr99922756d6.9.1740591409145;
        Wed, 26 Feb 2025 09:36:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE9yjKiCO0PPVVHKLN1SK6jQTYG+qFIB3DXGCQMIW92FMkg1aRScPbwLzZ0IUF/Fm78vPClg==
X-Received: by 2002:a05:6214:20ea:b0:6e6:6081:34ed with SMTP id 6a1803df08f44-6e6ae9d5df9mr99922576d6.9.1740591408738;
        Wed, 26 Feb 2025 09:36:48 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2046462sm362913166b.130.2025.02.26.09.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:36:48 -0800 (PST)
Message-ID: <abe67db8-5dc8-4af8-af2c-c6bd72204a70@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: remoteproc: qcom,sm6115-pas: Use
 recommended MBN firmware format in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250226145103.10839-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226145103.10839-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4-rFzhBCaCrH1giSAjKZogRQO_hjAXrr
X-Proofpoint-ORIG-GUID: 4-rFzhBCaCrH1giSAjKZogRQO_hjAXrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=857 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260138

On 26.02.2025 3:51 PM, Krzysztof Kozlowski wrote:
> All Qualcomm firmwares uploaded to linux-firmware are in MBN format,
> instead of split MDT.  No functional changes, just correct the DTS
> example so people will not rely on unaccepted files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

