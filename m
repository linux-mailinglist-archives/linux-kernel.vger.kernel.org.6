Return-Path: <linux-kernel+bounces-405738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E630A9C5836
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5347B25426
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450D217471;
	Tue, 12 Nov 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDVYOCMl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289421745E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409885; cv=none; b=IDpfM31Ve/1JEK0PApXlwDSZcs4j3qkGd9qumUUm9OLCsqNX/6Rg/1TFVtSV98Ds7EpygeQn3hAQr091VA63OUq+sxUEY47oMNZ2P+XRrfHEB9NHj5fxzvKN2H2U/8PxFiGZe3Q0dpHchX3XEtH3SvtLWfnUH0gr63aLshIIIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409885; c=relaxed/simple;
	bh=ywR85OiWuzWlgWAd2eNOPKgqgkUU3b/hcNQah1GT2Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNOJ28SZ3CSGWAilxaSQFG20L7hac5whZcyN/XRQKMvy7I0889rB9/yuDYKYGguBJnr2pBKVH34RvoA0GVgSUMfUqg10YdG9qPMr6T+bZqtHtAfYVWNN/HnjDqzlUH1P3s73aSJRQ6z4povyJxg9JWVhPpf6MydNvsxXH0S0gZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDVYOCMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2ih4g030287
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5t7dc7G/jjBr8WlAlwPdc9LxkWltx2aKpkt9Hv6dQE=; b=hDVYOCMljcutU6aD
	8Gb/mUCrLbmjZiCK842u2yTxArjKNi46LwoR9896VHV3ouz8NuH0ywr116Yj+w/E
	8L1lAzvMd/qUNEJWFAY/ryzqU5X61MkrQRRnKHfMTyzFeXTOcsLIxJO5PEiTqhe4
	4YeFX7B+enlqVqUZgzIrBBTiKiTWSwEScXAplLJfwVOGk+RrkP7Nj37H8dbxLrwA
	lE7N27biVnwatQZPY1HM2oO6xDtk8MyE1o02DLpI5lHGFPeSY+GfUNV53vxum6sK
	piMKpWMB9mQxQZRdHl881BBuNyFdirgyKyTdnksfOAFPebxKZHHY5hg4nvywq5h+
	GDD6Rw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxpqf50s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:11:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbf4770c18so1665626d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409881; x=1732014681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5t7dc7G/jjBr8WlAlwPdc9LxkWltx2aKpkt9Hv6dQE=;
        b=wqPQDmHzCl2MAh39/4ISY300j5z56TlQCoAkPwd+gK9DI6SSxb6qB9nSssDSiIrLwt
         ufdg8P0KaVGewSo4A7T1Q1AoRgfsabnQNdoDQWKws/Kln7Uxl8Dd7JRuQEPeakyOJ5qV
         5i/0PFQapfQADUSOBvg8x7o5dsxKhydQa1e7yH2WmC9jX6uSivKSTMtnqM8Y658Bc1Dq
         Zth9CyZ/qEG++r8FNIRZHz4DYVTHEdgdvFxw2Jx3Z1D+QVIkYXp5IdUwu8sKtmoGYULA
         2SIZaV74GQAITXpks0KkbzBNXwz67fEliCwrUARh5fgQWR4bm7cOOAE8b46q1PJy1d+x
         1qBg==
X-Gm-Message-State: AOJu0Yyvy3AjJ614p1M8st4PFLb+nSnBJDiPh2PF7deyuL5kTofD+bC/
	t7nTX/XdT3K7xDS7nJnANyOR9gdROptduuS8roE8Tt5Kk864uGY9OaXPCU6z42Ctl3mNd321lzU
	VbtiCNFBdwZPxV09ggvuceQKFggYnyht6Tk/U/sq8VvGOaHIxslrnFF9wXH3G1uU=
X-Received: by 2002:a05:620a:24c5:b0:7a9:a632:3fdf with SMTP id af79cd13be357-7b331e616abmr930878185a.13.1731409881285;
        Tue, 12 Nov 2024 03:11:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECna4oHPwSQGVlcKMRTsp1CXWFFwVbPJfw844hm3cc6KdClilnMMxBnVcLsnfGr7SMHpmrpA==
X-Received: by 2002:a05:620a:24c5:b0:7a9:a632:3fdf with SMTP id af79cd13be357-7b331e616abmr930875985a.13.1731409880912;
        Tue, 12 Nov 2024 03:11:20 -0800 (PST)
Received: from [192.168.123.190] (public-gprs527294.centertel.pl. [31.61.178.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def4b5sm710246366b.146.2024.11.12.03.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:11:20 -0800 (PST)
Message-ID: <a10193c1-a89f-45ed-afbf-ab75b3a4ba43@oss.qualcomm.com>
Date: Tue, 12 Nov 2024 12:11:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-qmp: Fix register name in RX Lane config of
 SC8280XP
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mantas Pucka <mantas@8devices.com>, Abel Vesa <abel.vesa@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, stable@vger.kernel.org
References: <20241112092831.4110942-1-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112092831.4110942-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eRz0VHPpxDOn7GyZs1P_Nr1S2oUyS45z
X-Proofpoint-ORIG-GUID: eRz0VHPpxDOn7GyZs1P_Nr1S2oUyS45z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=609 phishscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120091



On 12-Nov-24 10:28, Krishna Kurapati wrote:
> In RX Lane configuration sequence of SC8280XP, the register
> V5_RX_UCDR_FO_GAIN is incorrectly spelled as RX_UCDR_SO_GAIN and
> hence the programming sequence is wrong. Fix the register sequence
> accordingly to avoid any compliance failures. This has been tested
> on SA8775P by checking device mode enumeration in SuperSpeed.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---

Good catch!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

