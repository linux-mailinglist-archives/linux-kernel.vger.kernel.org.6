Return-Path: <linux-kernel+bounces-394717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B407C9BB320
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456A61F20FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E751BA86C;
	Mon,  4 Nov 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oA1POmll"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7C1ABEC1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718930; cv=none; b=DxxidJQODIshKBLYvb5rO7nZvciIzaltyfKuP7E2obzwi0oIXN/b3lnYkuR2yFkCKIUx02s3P5snkmWN8/bS4d/OSuKNZTSVZaSqXVkMEy/gkjxQr1mY3hrW5I+0TxR2HrIpP+Ovxdy9RwnBDUmHXoJx+4xTQWtqshmkJIqOn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718930; c=relaxed/simple;
	bh=d6QO4QYGlvPGTr3r5FY1HMjPPe70qv93K1mDlNdwVkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJEAwG/TLsCFo+nhV9FlZvsps0BZVYR0pgHVNNwwIImJQXo6QdPzdkcXahNjUW4IeoQvVSkAjGSPm7VVjCstmDR0o6L1Ke/Ulj6tr+NhKglfGBZTwzAAgj0DtTVXUpPSSsythZQ6dInAEDYYzcl+pSjZ0WF6yuU1zrPjP/GLqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oA1POmll; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NurxJ021787
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jPm7hWUkTfuXs3mmy+IMG+HxOet17xzog7upRSLJQWI=; b=oA1POmll81HyLt/k
	S79/7kfcPtAq4IAVwPIC3XFeTx6gut752f9caP4jI7qZObi9tyeBIvAkCE8oDPFy
	jDfSSZR+zjYTaZVc2jX8RGRN4mGkOl6JROGsIGk2DrVhhOjD+ET514NDsnlyOmug
	fnfWLRc/LfEd8QV8wY5tswsqv9j3rE4uefLiaqEni2duOvIQO1WRFiUul2J3hGKP
	hKBh6shaBsauPoUdK8RdXF4Hv8xxdcg5lAAuYGS+qhO7iwMUQCT00bFXs5PvQo5u
	fJ67c7cKTNktDtTlPDlndwpqiF3vvqg3Nhgm15E4DWQJYw5L0qnq4EA43etMOZt4
	LkS9FQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd28405e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:15:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd0a3f253so12741376d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718927; x=1731323727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPm7hWUkTfuXs3mmy+IMG+HxOet17xzog7upRSLJQWI=;
        b=pCq9Skg6cpr5cH4MSh6vWIBrlrEXpYuTvsnlFNC6Mfwz9GwH1ACN3O9Hz4V0PfwQqu
         Nk7M0hsw9RXi+e/EFQGBQgILU3I2FyARkt9FhNAd5VwNOAQsliZLLAFaZk1QEseO8dx4
         cdKTelUcwTMIgZbaClidHmE+aMhHntHt6i9RelcOXGnkAerv2Atw2UwYt6f9yMCb2kqE
         c1MvPJpXOxZLDPdT99LtwcpyqbGi3/zbX4Dtzt0mRjZA0hwRJC8t/rTJc94i0Q56azY2
         x2duX3ixX++uSdV64U2DQc2E4T4dDdVaCicvVuxx8Hdz6vxnU7Sm67m4OJk8iApGOmJ+
         tWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCCtqxXlO7TX7+bAONxV+rSBfj66GqlbUyyTTpZrLBLTAV6haWS4e2GyJ6e+JIEzpDZTHMea+Lh7+3umw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2JKacIwIQ1XaSM0MqzwD2CAgVOYklieoxn5/uW5uERq9Pz9T
	sogz5agaAxkQeNu30Jbj/8e9PRw2hnxW/jqJ/K3YUTmiv7iniTy1frK2sEj8S1aXDLTfujqeGDf
	uclYEYdxFoCIkl+Ugmqjyv7i+9T/Ya03w6eO6FhtVl+BPf9BfkPdMI7kLprg/juc=
X-Received: by 2002:a05:620a:1a02:b0:7af:cdd7:d6d8 with SMTP id af79cd13be357-7b193edb1aamr2141058185a.2.1730718927565;
        Mon, 04 Nov 2024 03:15:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEEocoupBY994SVKYmDQBEraVYB+dHfuiTwu9QnqVdzOdt1qQkKGFmvRV/Wq0sw8U7MpaTMA==
X-Received: by 2002:a05:620a:1a02:b0:7af:cdd7:d6d8 with SMTP id af79cd13be357-7b193edb1aamr2141056885a.2.1730718927195;
        Mon, 04 Nov 2024 03:15:27 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494470sm537633666b.2.2024.11.04.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:15:26 -0800 (PST)
Message-ID: <731413b1-b660-47d5-96e0-719afb786865@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: qrb4210-rb2: add HDMI audio
 playback support
To: Alexey Klimov <alexey.klimov@linaro.org>, linux-sound@vger.kernel.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski@linaro.org, caleb.connolly@linaro.org,
        linux-kernel@vger.kernel.org, a39.skl@gmail.com
References: <20241101005925.186696-1-alexey.klimov@linaro.org>
 <20241101005925.186696-6-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241101005925.186696-6-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p21LFQDJpZ_sYZCN4Gi-CQxflv2ryoYj
X-Proofpoint-GUID: p21LFQDJpZ_sYZCN4Gi-CQxflv2ryoYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=940
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040099

On 1.11.2024 1:59 AM, Alexey Klimov wrote:
> Add sound node and dsp-related piece to enable HDMI audio
> playback support on Qualcomm QRB4210 RB2 board. That is the
> only sound output supported for now.
> 
> The audio playback is verified using the following commands:
> 
> amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia1' 1
> aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

