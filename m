Return-Path: <linux-kernel+bounces-427762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA19E063E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01E016DCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187D20A5EB;
	Mon,  2 Dec 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1MTDluf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E6207A06
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150350; cv=none; b=p9fLxYZK7uyHn9QmjF7MQHssOT3QgQS2yf7XMYytJ9HQf/mgCXFy5tCovu7Hpb93nvd7VnxYG1IAlNzwabmA8sdsOo8oE4fKHIRx5JZpbqqGmPvgSKGlgkAoIoKnSfnof0UqWMI7N4Nk6Lp8wx9KpN4PaUYpnz8+gLw8ajFB8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150350; c=relaxed/simple;
	bh=+NEcIZJgE7LLyCMgGbIR/QVszr+XGpIZ7fL//kOnjnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpdhkERE/orHj/b9Jjwddv8LxKGYhJqg1eP1uUoCoructgky4FLisI6jTKVDYq/Xfp8A8I1C/t2zqn4IFWzaLjdgd/GEyfHd3O+BCLf8VVTXmIbFriPU7nSw433/fsKY/s6W+Bk9DLJbJoyvtOgTE1Sbibolc0oUn7/vELbOU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1MTDluf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28I3vO015719
	for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2024 14:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g6AHa+2hrNPXyHkYqMwv/F89CPs7fpLf/SFfF1BRFFI=; b=K1MTDlufvtvpJQmr
	OimYmvMcwTVI4zv5B+SND0p/IMTank1OPXf498JGJbQBrQ7Gne8DOSz0P4u39mCy
	Pv9tWOjALOS1a76F6HrM/7AJvOGrcOTcy7Jthl5qYlcVUshUyYcTzK2ZddmKnKt3
	Sbk5zWfCRDAS4RdDLXYPfNkIq7v1CwjObQluZIPrbo1JhjjNB2vNdxC8Gdur5n2J
	i7jts3cbkgEo9f2WmjP7+v9Pm9KYFgZZFRAur8dQ6yZrURcjhIP4ZB7MQmXFjUyM
	MlJS+1xS0U+x3U/5nwiNDpWTvfgIv6v584s1TeZ54vHAl4dDLxmfKeJpHw8u+mQx
	ZL7JlQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437snqw544-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:39:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466d3ec228bso4312781cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150347; x=1733755147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6AHa+2hrNPXyHkYqMwv/F89CPs7fpLf/SFfF1BRFFI=;
        b=o9/8in5hbmYdkUpQ44c0S6ZEyX6JPP6oFxrrEjt1OObuuWxl+jBEiarGLe4cLvbUAk
         Npu7x12gIcswPP/NpzQk9YQ+konr41jW8aETp952aOw6C68rTo1yy2af/hqYovAlgOja
         OXlKpTfRQz14u4oELYzH0BXHaeDCpym0I4ggr62pmvxWT7m0/bHdppeTka5H/3zxrYnD
         r2pDQwDJzwXU7b81BnIkKd4myHUv94/AHKmwNgb2lCq3a7Jx/KLxccZtEh1qqZC11p6K
         /c2b/IxPZgXSE4EjnWdrv/UhG5CMzfYnC0CsSJPET0PKvbRw7CEcBdkPptKj4E8DHGCQ
         eyrA==
X-Forwarded-Encrypted: i=1; AJvYcCXMpM6duaN706xoBTbl92WlTKk+nkU/2vRizOG4RlxezCbFAHbtuYPnUbt4E5QUHP360+SAO1aFTovaNnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNj1UQYnO34386FVkecURlDB3FFADAkQ45yU5O8hMJYYWNEqA
	sBdfABjD5aW6UHnPafy/H7CKN2sRjRgbYpGDFhiRl32MtF/mpFHVfMQr29i3R1wlNFj2z6/I7wc
	SDRXC8r9yy169wZgeFrWjgu5nCEvJ9ksAulAJek5/tzuhE/kkX6uJe6t4hBrw2uw=
X-Gm-Gg: ASbGnctYd1t4T1UzBKjQI66d7cu8I5cMWhxzRjppqvZrbtkqTRQs3NAyWNmJcYAYn2y
	BHXdwrtCpjpS+jm7gCWh6m8x6Yscq431IsPekcla0l4Mjrbu4iKRUR8exrKB4CZPoJWuoxPO/Db
	+xKy5L4QqO7C2ioA3ogaQ6WdShXfem7VLNYo+yFqR6IxMTE6IaaCnZbo+/y/TuuqPj9xnC5kpFh
	uxCs0TiGoaooa91Lo5bg0MXJEkOLrRSkZ1WBrnJTUMxgCjjW6KJETkpmZWaixn5tiXzRcJTwzaN
	6wqUBRQ8RjTvsPRvRWKkqMNcFqn4r78=
X-Received: by 2002:a05:622a:cf:b0:466:8033:7dd2 with SMTP id d75a77b69052e-466b365e8d0mr166007391cf.15.1733150347066;
        Mon, 02 Dec 2024 06:39:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRWwFbKz7t/fucB4yBe2bX2YgC+0oLMQnDi8dNTq6P8UMCq+YzXzq+ExBumA4HfzOz/BTPFQ==
X-Received: by 2002:a05:622a:cf:b0:466:8033:7dd2 with SMTP id d75a77b69052e-466b365e8d0mr166007091cf.15.1733150346436;
        Mon, 02 Dec 2024 06:39:06 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de7fdsm514344466b.54.2024.12.02.06.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:39:06 -0800 (PST)
Message-ID: <d8e1c1d0-a375-4944-aada-2bbd6a4739ff@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 15:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8550: correct MDSS
 interconnects
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        stable@kernel.org
References: <20241026-fix-sm8x50-mdp-icc-v2-0-fd8ddf755acc@linaro.org>
 <20241026-fix-sm8x50-mdp-icc-v2-1-fd8ddf755acc@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241026-fix-sm8x50-mdp-icc-v2-1-fd8ddf755acc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qESD_GoJW-9zR4S7pr6Kut0yVdFlYa1_
X-Proofpoint-GUID: qESD_GoJW-9zR4S7pr6Kut0yVdFlYa1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=756 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412020126

On 26.10.2024 7:59 PM, Dmitry Baryshkov wrote:
> SM8550 lists two interconnects for the display subsystem, mdp0-mem
> (between MDP and LLCC) and mdp1-mem (between LLCC and EBI, memory).
> The second interconnect is a misuse. mdpN-mem paths should be used for
> several outboud MDP interconnects rather than the path between LLCC and
> memory. This kind of misuse can result in bandwidth underflows, possibly
> degrading picture quality as the required memory bandwidth is divided
> between all mdpN-mem paths (and LLCC-EBI should not be a part of such
> division).
> 
> Drop the second path and use direct MDP-EBI path for mdp0-mem until we
> support separate MDP-LLCC and LLCC-EBI paths.
> 
> Fixes: d7da51db5b81 ("arm64: dts: qcom: sm8550: add display hardware devices")
> Cc: stable@kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Feel free to use QCOM_ICC_TAG_ALWAYS, for both patches:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

