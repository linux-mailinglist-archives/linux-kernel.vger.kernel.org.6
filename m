Return-Path: <linux-kernel+bounces-382420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C49B0D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E25FB23A85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653E20BB47;
	Fri, 25 Oct 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SX9Q9znL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BC185E50
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881140; cv=none; b=pSzbrhpzbZXoY+/Pd2nlkeEZyVleImVw0olKf0HyqqRw1Ts9WJep1t3x+G8fJN2UViz+kiqzEB9rMiesFHhAhD746R4ridLYNP6blKORHK+Y34+FekI+oOzDPMBKvBR9qNpgyoW7HB8fDfGICZY5G4QG+TJBtQOcNI85IRAhyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881140; c=relaxed/simple;
	bh=Vdh5ElZ3A0D8EPEKHD3rE8rywhLH6KQEeXeKrWBPpMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4WYfroSUaPVEORIAzGnbZnhsp2G9M2qCLUpgs/D5sYHnIm2ztpAGKjAWOqkVw7ZyFSq/oR7OABMC+OtoPeI5bHPphmT9FMRJA3UwLVh8Gon1vhu5HH99ZlJdJVaNUis/gqkd1iR2lNN5NGCbTijk8b/Sx3E83u9k4ny2W4NCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SX9Q9znL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBDwUD003659
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hsr6snaiHPDIf/WkGBe89UqfOfj1b3p54wbMJRYPfWs=; b=SX9Q9znLq9AleGLz
	MaWVKNlIygs5SLrG3PI8MOqfKbul0fFG4x/LNK/+QDaMGliA+Gry3xoLCvJCGev5
	iFpjGEcpDcvLqr5rRbCSwIe8CkN8Q4FvkRP0aKBcXU9SW2IHbc1ASgHeCmEotFcZ
	CwasdCC8w9jB/DfnJv1FfFycsWfZasX+m5Z7gZs7TPHF6OlgWuRm1mNZzXae6SUe
	19Fr0Fy/sV2M2wO4uzsVllwUaMWxy6VCQjVOwGRcOi8LSGKRAlz7wAmKn9raSTSb
	3MPT3HBgHkPegYdFUzFBktS0CLcd6kaRg8oAgdi51z/J+qPRsWmgnUWdzR8Y2M8B
	68PmVQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em68a2yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:32:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4a4929a5d59so106864137.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881137; x=1730485937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsr6snaiHPDIf/WkGBe89UqfOfj1b3p54wbMJRYPfWs=;
        b=dFxpwILELU2H7RvVr2exS37LGBfu1VZ7vzvMSWL5OdlgEO8b6lNhjYHJAMDjuEGVcy
         ov+8QldozrMxoCPgQ1rZDaGQp9RWys3sT8Kp4INgKsMVmOMOk0UA2FHq/FfjPYUuOXtA
         rSAIC/UM0tZNFwWKtIAoZCvfqtMXVmkN0YSk/veU7p1cGcWpTFa2jAwgGLArbIzs8RQs
         jQFAATOKEjDe2dm15ysZarxiYFxYK1xyMjVzeliDUk3o7zQAVtKCNlLWVMdAyrQLqdKy
         vEqknaEAASmrVWj5wh4QsTMYlkKbE09xbPeAqO8WwrvKzW3Z/AM63WkFYlBuMIv3abBA
         2vBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC4fw2UN1klRd9JX7OEuLY+B0s4p+UstXdkMaKMscRX+rqvFQFLgQPaC9ofBcu57679aH4do2pjTYSOfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrm2CZKIKh5UO5eKLTLBgRw0ongimV2ZT1fWn3VOozmn8Z0kz
	K/0M1znl6p7eIp7CLMKIwX9hUBZ+LyWaLsE9yEStQqUGdXfNNVGiuemwUVgVHBuFolqomkSe6tC
	9UdI1zlZPHhB5gwVGKrYcMWQDQyRHYMD2s/74F8ZI0O1+lqWDRcex7BoedFpYS88=
X-Received: by 2002:a05:6102:508e:b0:4a4:77ae:675d with SMTP id ada2fe7eead31-4a8cfb3936dmr259506137.2.1729881137029;
        Fri, 25 Oct 2024 11:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuvNrzzqkMcHEp8J1P+Ax7lUv1I+QA6y9x8bJjAxTxYmX/9/QM/V6wJqA3qgJd6yORrm3Gkw==
X-Received: by 2002:a05:6102:508e:b0:4a4:77ae:675d with SMTP id ada2fe7eead31-4a8cfb3936dmr259493137.2.1729881136748;
        Fri, 25 Oct 2024 11:32:16 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb634796fsm864127a12.80.2024.10.25.11.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:32:14 -0700 (PDT)
Message-ID: <65d6cf4c-bbfe-4b39-b2b4-ebc4c81914a7@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] clk: qcom: dispcc-sm8550: enable support for
 SAR2130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
 <20241025-sar2130p-clocks-v3-10-48f1842fd156@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025-sar2130p-clocks-v3-10-48f1842fd156@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PV1Us2v_mrivZHQJ6KnEES_nwXNHvYU1
X-Proofpoint-GUID: PV1Us2v_mrivZHQJ6KnEES_nwXNHvYU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=767 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250141

On 25.10.2024 5:03 PM, Dmitry Baryshkov wrote:
> The display clock controller on SAR2130P is very close to the clock
> controller on SM8550 (and SM8650). Reuse existing driver to add support
> for the controller on SAR2130P.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Everything checks out

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

