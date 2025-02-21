Return-Path: <linux-kernel+bounces-526695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12613A4021C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4114260C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB0253B73;
	Fri, 21 Feb 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VnJ3Vlxs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA22500BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173917; cv=none; b=CMu7ZH7KwRqTqZRj/h1J9rn9WYVZj6srsRNCS2SUMg6sWD4Rfj96cwH0qom/8ptDHExgQpWJ5GZUJrCg0B+d5juG5x2tD4P4uVzY8TQ+gZnBzdY+GVcVnAingfXvMUTYfrK/Qr2phasYre8UZvLbu6bBx1LbGaCs6vBtEIqh45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173917; c=relaxed/simple;
	bh=IBkOH1tAujIMIld5Y0K6nJEIXF1q0yB8Wrv8ujg0wiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcKKZVIkTkBAtsiFVbj3CK/5JdV6TZe8GUhsFNpJdWUOnHgFMwIsrqlsz1Chmq2PCD86MPaRt69/Vfk/fSjVscmZokaynKFy56ekoWOmh2tzBjwybpG4LNeiPFYR8pJE2c1K9lpfsjM84DNR/xGckC7IPSRlBtDbjZaA+b6jfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VnJ3Vlxs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCVAG8015948
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GEGqIXErPMXc8VdTd0Xo8EVD7trao539YyYrYV1kddk=; b=VnJ3VlxsPP5SAuja
	84F786enzzLmtqgh6IwPcgwyLXUSuvIixqaPTzVxU4Yy6jye64J9Ynv/wU7xNxK+
	SQa8lJjwmSSHaZD87/gHzaY8hZwEsd6CayZqGS4uZlxJlOPhZvFa0Z6iZNKfFulX
	178+jugqEsE85Jbat9ISeyLYRcMWm+mz6ht8EwYf4HXaeP7Q3SLarBTento34dWR
	+k6SLaXRdkul+4m7nVRazvykUqYjPEaZcfGgiCqhXsPh4TcpLa2FHcjj7wJJKyGv
	g6pXkUYO+9APyfugjaoXzKZldklTkfo08CC93Vu+nI7R5MOCpnnN/bmUJJhLvrz2
	LP+QQg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4kaaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e66c7e5348so3089056d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173914; x=1740778714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEGqIXErPMXc8VdTd0Xo8EVD7trao539YyYrYV1kddk=;
        b=OAihZi3nv8sABZcXfiAKScie2t7+ykXJZI8nA3fJdyId1L0eTERahYXvtDqPV6kKo3
         95pVs6C5phVCfVd2kAIwQB3lmYKVYfz3u8ngLG6Nq3KHeCNRI3oWDAmeeyCjfVQ+RPCr
         ngd69WCa1bs3AqL0Mx0tKvKaxBnOo1jggY6nQ8gzic3pZ09W+aFkohD+JoEJ+z9LeSs2
         X5ZmDKQM8y+8k1lVez6QIcGHvX82/4JPjhz29lJoW78foI4E/ATezcgsxA670BxL2BAw
         M+7SqcngiDXH4dvrFDUpVGszfHER6djmRU1FAycj58DM56zH4rmMh5//T7ECukK35olI
         kddQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJlom5AZFyn7770wq07A4tzLwTUZ58s2XTH48vj0wRtY2roJPfCaf728OCiDGCOhcHcF8nRP7P+ix/Ue8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjyml06EWVQh+ARNJ5vDAubgTzlGLZ3IfFgzcVNosehw4VJK3V
	a5g9GVcl0bvKJ5Jz1H7hcTFh/9krLsaaSmGbkfA5uGSsJJ8VpD/89b/HTPwKQdug9WkDIjW6zXY
	gTQiSlPTYtv8xpHwdqCaNfQ5KFnPoFZY8sMLQnSwFApCrwFg+o+O0iYmBzz5KZWI=
X-Gm-Gg: ASbGncuPRXP9y3dHOz0z4pwhngRSQGz/suET0uUERQiZ5OTH776/isZufEWMLiSpfCY
	A+EURw/RZdO8NwsLwnkKN95ysD2EFIuKPmkWrtSul0zuUkEfiN2DYyEbDSp18Lhbj9fHj5W1h3L
	mUh5uVr2k4DzVKxn8JuAXikRllHOe33nMlgwoHwSH3Fz/6sXeo/s+nJXHkTZDe5mTjSBuDLiVbF
	SyhHv1kjunaKVcQ/Wqs+tEbFpZDoxqLCeXzilytoBipOZ2m2OWImcrFVx+MMDZHKuXRoEGpU+c+
	FPLoqpJ8ZEExSLnMpwYeAwkGZxoRpL6MA+RBZ87dpgbP65o4mealwMbQsOBZ2mDa2SwxIA==
X-Received: by 2002:a05:6214:21a6:b0:6e1:a79c:4cb8 with SMTP id 6a1803df08f44-6e6ae7c5824mr24980086d6.2.1740173914368;
        Fri, 21 Feb 2025 13:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEkBIHDw/lt993IkXFaOsT/W0kUYMHTX3ghqlaAwXsDraeaclttfOGzvb1ylLr5/jMIBmC+Q==
X-Received: by 2002:a05:6214:21a6:b0:6e1:a79c:4cb8 with SMTP id 6a1803df08f44-6e6ae7c5824mr24979986d6.2.1740173913944;
        Fri, 21 Feb 2025 13:38:33 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbeb38e05dsm434092166b.90.2025.02.21.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:38:33 -0800 (PST)
Message-ID: <4ae230e9-021e-411d-add4-e7e1bfb2dfff@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 22:38:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8750: Add LPASS macro codecs
 and pinctrl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
 <20250220-sm8750-audio-v2-2-fbe243c4afc3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-sm8750-audio-v2-2-fbe243c4afc3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Pzmgs_M_1a6_QIWeK2H34MgAtDRs-w_V
X-Proofpoint-ORIG-GUID: Pzmgs_M_1a6_QIWeK2H34MgAtDRs-w_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=799 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210147

On 20.02.2025 9:49 AM, Krzysztof Kozlowski wrote:
> Add LPASS macro codecs and LPASS TLMM pin controller on Qualcomm SM8750
> for proper sound support.  These are fully compatible with earlier SM8550.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> +		lpass_vamacro: codec@7660000 {
> +			compatible = "qcom,sm8750-lpass-va-macro", "qcom,sm8550-lpass-va-macro";
> +			reg = <0x0 0x07660000 0x0 0x1000>;

The VA macro is 0x2000-long instead

> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "mclk",
> +				      "macro",
> +				      "dcodec";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "fsgen";
> +			#sound-dai-cells = <1>;
> +		};
> +

Looks reasonable otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

