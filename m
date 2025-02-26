Return-Path: <linux-kernel+bounces-534564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C72A46889
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DA1888D69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413722A7E1;
	Wed, 26 Feb 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8V5yw0I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC322A4E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592464; cv=none; b=TI5ClnqtduqNgjZ1uBhGLR8aVeFtkc3NQKFT82oHP51NsOsZeMw7mftWQu7dB42wHqS0fgjMJ7PtjMfFEfW5s1VgSNbOiGJt+Gj+Gv5SPQTQqov6sKjAhfx5Qa6Oy9btEJN91IpACY1b3cltR4Z4djkciVDYs7I6L/4SBV0/fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592464; c=relaxed/simple;
	bh=XCF9u8Z1rw6dikTB5uUuGFpoZde8WX8im3OQZS20lBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2sc4tqtzvvPzE+tXvj4ywTkJvEV//ot+FVYOSrYurRj+6FKdArqSaI0Ilxc116ITYuK9uZWnOnnUASB43x/4gBjI34dQij4NnEM4xARWCUdxUzrJBh+OiiGoRzJhbht4arkUabt1WV9KGRcTUEp9PqurAOKVulXny4jRpZMo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8V5yw0I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9Ev92015904
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1UOTAeEYAiBnkyZpz44d78r5B7uBb0CODxrcfWD1kk=; b=l8V5yw0ILAnulhx6
	Udo4ZbASizJpDYsHqtpefcgGGV54J1PtaIwrnE/BaIuM4cwhH14lPz+98KiHeV3f
	4GgWcRUDnHJKtTHFPFcqz84Hve19eaxPrkmyMWQ0CAhtEkJm1C9j44V5HuGYwZzA
	ZG8wJQqYMnfpkHN+EkAoNaGnlE98wB/xnqzWpQwoM6npvGS8E9Vd7pFetyXtTl11
	/Nr9MzXO0klRoFdEDBMgwMzgbcgMF5MQiAv/offMvUwhzsSq+x1tLRm/HLMT9bxV
	WCZcekBdaiMKCZpQwwFPFFmE9zXBFNEt1EaF5ejGKAu/0wNF8HL/467F+X6Ict6W
	FT5nCg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnjutq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:54:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e19bfc2025so308416d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592460; x=1741197260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1UOTAeEYAiBnkyZpz44d78r5B7uBb0CODxrcfWD1kk=;
        b=A0Mc/gTp5x4hoJq/+5tE6owZ8PV+V4rTSgSvXacKLJgdfaI5l+4khRzC4XuQRbcPEB
         Y7rB0eTsLMx+O2cQau25n8PTZYJF8lK9OppTP9/7k+LxsbaGl6HezLlQ6PAufYZoP5Xr
         bisLCW1i161WI8q9J3iAbCufv7U87SU1+AhH71fopg7fmWou+JUWz7mCgPbUNIRdqKZK
         SVG5LgSFehkzLG/OwBPjZO9CCcA3j2MqbfVjwhBryV5uOQ9wGB7Y+m5E0yeGl1y76RhN
         iiobFLKVWRWqP7pr8K2SC8SZSIIrVPy9gTkg5GH0WffOcpu28P9CXrXiQq5yPprZg5zd
         yNaw==
X-Forwarded-Encrypted: i=1; AJvYcCXbHBb4Syo+X2cQHTchMDfYSgbXdfZ//jZ9SOFbYIko9nTMGTLbQm/LvmWhrY4qU/JfSlNkRPll4In21HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lkkrGF+qDXdVLSGu1rEM8zB9WyO/+Upk84V8E4mQ6c/t6wsy
	h8CQ3WoJppOYqnhOwG1UnRZOQ5a4eBygprKliqEUxeWrNTnrKdAmrZo4vTVZcMjmdrDtUIBehFy
	YUJHL/oBKM+UKqE8GpfMYoZvtO38umBr31kC1hY4taGIYN9EpfP8Ctq0hYsqcwwQ=
X-Gm-Gg: ASbGncuspIwwt8CMz1VauJZI/QZ/03vEdZd1FR+5agPHj8MlV0Axrg0IbqU6FKaS63Y
	QfrslwSZs8vecWsffEHC6nuCnNDOenwvzc55a65xV7R+9y3DB9GKhK+ApeTL9iaFWfbloZmByHY
	Jv6z+JBLCjuR2XJxMhrqYC5wMCR7iBJGJXtiBpAhi+w2JLmIrQTLyEQhV8PQxbYYg1MGB2Zey0K
	GHcRzKZh65ntBXUe7aNqH9JBi0/cR2vvRBKgDfVt1NMObgZaBEKEtT8nFcE+FxovavJFiYHqtxu
	XsHBBEVGI70ryLy/FlQuuc65Q4+7d4+iDj9a9mYBzsdrUqfb9//JBUGf2lKD+92hAGH+Qw==
X-Received: by 2002:a05:6214:21ac:b0:6e6:9c39:ae44 with SMTP id 6a1803df08f44-6e6ae9e22a8mr111525306d6.10.1740592460279;
        Wed, 26 Feb 2025 09:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7syWcS42OEo1xDcdvQ08ZhO/oF+3o+Ak0wcAu1DA2U5JLIbwlLDHrfoMof7nVe568CRcIPA==
X-Received: by 2002:a05:6214:21ac:b0:6e6:9c39:ae44 with SMTP id 6a1803df08f44-6e6ae9e22a8mr111524966d6.10.1740592459862;
        Wed, 26 Feb 2025 09:54:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121dcsm370471266b.100.2025.02.26.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:54:19 -0800 (PST)
Message-ID: <e3b2678a-9e4c-4f56-a5ea-5ae46acd5e4b@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: ipq9574: Add nsscc node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_tdas@quicinc.com, biju.das.jz@bp.renesas.com, ebiggers@google.com,
        ross.burton@arm.com, elinor.montmasson@savoirfairelinux.com,
        quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250226075449.136544-1-quic_mmanikan@quicinc.com>
 <20250226075449.136544-6-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226075449.136544-6-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N5Z6KO6JdrhdckY625BFtNl9kxOoh4Do
X-Proofpoint-ORIG-GUID: N5Z6KO6JdrhdckY625BFtNl9kxOoh4Do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=624 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260141

On 26.02.2025 8:54 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add a node for the nss clock controller found on ipq9574 based devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

