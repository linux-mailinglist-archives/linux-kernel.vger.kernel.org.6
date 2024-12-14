Return-Path: <linux-kernel+bounces-446221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70269F214C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3063F1885EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045819D07C;
	Sat, 14 Dec 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGwVLHAx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7A1AA78B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734215687; cv=none; b=T8dhJrVWgQgNdgcP6FPFd3Brj6r5cLe6lnHv8ZaOdLmHLLQdC1ESyoeHTLvWapCouwWVqXjxA5rWgz9ZatJD3G2p70pHfWLTG5t41O3YrBc1XJg5qqfV0BN5msjTg0Ie79nCTZQvrQXF4/isjCSlRAMvjac4s3Jm19IEsLZoyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734215687; c=relaxed/simple;
	bh=eoKXfq6Hj5SW8j+wkA/iHI2/OaarWoeU1Zy5vKlID1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPc+7WmW8Qz/FV7F2kpxkC+bPZZcnXZJ3v9qMt847GtuoxDLjf/5y2KoaWFiiAGl/+cG9antaZIjymrRmrvOz9ud2taOhefUeC2L9ewdSjP991SOXPhFsCv7+9KDD9O08ZaTy3x/BRkybmEcTxNp5Rl/Nkb92gwKP6rYdAVQOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGwVLHAx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BELRvT4023027
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zoT/6Ve4wQjNE7DzpC+6ucI6/tFmHxfuNE9Av90lsj4=; b=FGwVLHAxwHE79fiU
	fJiTlSRTOOwPetAh1rhqbQ48tydFNGPNY74nlVFhlrBtQPAMR8Ve4DscBZznadiT
	wlW/PdJXylbs1Q4w9h0eQYAMBXqCgm9aGCcukHH3AOfxGL6IF2q7VDCcQw72TZtr
	FNUIZc2WN/wXwRuJGvhxb4bT9J9bk3NNMCH5o8fMXjjXA7UIzF30vGxG1PTSsDaH
	lE80w5jryLvPeeoOp5fB4fDsEmHKLMWjN2ykYiEnB7033kKcenrZRZFsdttfndcM
	WRZcgKKr+AlPcndUrXcTgK9ugCyZpRMf2ltD26pNvcLDmPQGuZXT0BGrlbOY/25F
	nwk4KQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43h342h3qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:34:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679ef4565aso6422391cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734215684; x=1734820484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoT/6Ve4wQjNE7DzpC+6ucI6/tFmHxfuNE9Av90lsj4=;
        b=Np6K3ApJIof0+HLJWCOTGqIuaGLHC0THipp88tcwWfw4uYTG8CZU8KRPOzwNANx4uo
         oSjznyZXh1G22T0hyWOprJKPeDpa6NTMbV0DU9oUO69RZP4bF8GwKJq7DvKcofMzTw9A
         rt4sGwduf7EgsvtxNMJSuS0mcqTddLx0La3PNbIXp/B96s9lr1kgSehMwNposd+m1JAB
         R31Vi9jUL8zg2hdk0YMYg7wBXPl6fjbIcCkTXTneaM2TFeQiPftJcKacMRpvfcDxt1hN
         9zc7RV6j/2cobz1wehvyu0JzU46trHwfXp4uScakOKv2acxhGkVBAZ5n9ig8kd1vCq6N
         6xCA==
X-Forwarded-Encrypted: i=1; AJvYcCWbi1IDM5ZawfW6CJDc3bbf6vH2VitARKF8VJ1VL42qlTZ9k4hT5YHe1NbLztnI9zoWEQ8tpISAdH7gazk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpT+pKHGhZiMevcy6vh2596by0jvhxQ+nx3TcGmhLxiE0boMj
	Ol+m5FlQf11p0KwuJRKGmt8U5bMdjaCZntPWVI4ZiEIYS5W/Ez6GwKIa7cIdxSUH59O4zm+gym6
	5No4I0mwzR3HEaDFc8pznGgK9jLU9aTxcU3/zexP1HZs8addDjjMysbO+dIl2Qt4=
X-Gm-Gg: ASbGncthUjkAdgwL6BkplVjcBPOAhbUvaNyl6Txh22elcFCHq3LmO/xzMo4llMO+8BB
	eDeApL2bQ5TxypewghhhXzLxAknOjebsgAey5hDhM2nQYvlUQTqL92BEuWnsEElmTWJqFkU92Uf
	tPYU8iegZKd9zsVtP+XEz4KR9rgpS2nr5Lp+OZ0FWwQoES+nCnAkEcZCFTdAxMgysIT9EiamJce
	N7LKR0Ya/cV1y3nMl6dtMt0JHtQYdo28VE1BrH8puNbMM+8j/ugS1LQV28dcSulvBQ5QYFMfHR3
	iEo1fLlZdxBKV0WxEzXrZ8ohC3qIYrbWdtg=
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51306771cf.9.1734215684480;
        Sat, 14 Dec 2024 14:34:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGQIFK1+HGT44yFDj67IL1tLQqfEsu3uldzYeFqe8AIQ8wuuDnknJYfqn8obcdvMjeSrZ+OA==
X-Received: by 2002:a05:622a:606:b0:460:9026:6861 with SMTP id d75a77b69052e-467a578e2cemr51306641cf.9.1734215684091;
        Sat, 14 Dec 2024 14:34:44 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad17d7sm1396571a12.25.2024.12.14.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 14:34:43 -0800 (PST)
Message-ID: <cf9e3fcd-052c-4ccf-b3fe-a63a95bb2a2c@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 23:34:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com,
        quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
References: <20241114095500.18616-1-quic_mukhopad@quicinc.com>
 <20241114095500.18616-3-quic_mukhopad@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114095500.18616-3-quic_mukhopad@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: efm8iFVSbUU6JwZknNoMbA0dShb_6XMr
X-Proofpoint-GUID: efm8iFVSbUU6JwZknNoMbA0dShb_6XMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=947
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412140186

On 14.11.2024 10:55 AM, Soutrik Mukhopadhyay wrote:
> Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> sa8775p-ride platform.
> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

