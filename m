Return-Path: <linux-kernel+bounces-394726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAC9BB339
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628831C211DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CA1C0DF0;
	Mon,  4 Nov 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XS5i/5yS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264341B4F24
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719149; cv=none; b=YowvJGj0Iqr9KWUXFyfZ9Ct9xkWOw19z2leAS83RehL9SLMarO8X0eraHb1CSNv3ZAiN8lPkHrE9g1G5R+6qmsnjtRxWGzLYzUBYAazkbbtDz1Gw+MMRtDAZthj8pYPze5uRUrCjNzs5gS5+vxxCMw9T+aLZWHka2PJwuKipnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719149; c=relaxed/simple;
	bh=JgGFqZMz2Caxo/bqJtXtplmuZg+Kq0OfABkegunbOdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnJFZXmxUS8o924y6WLVcRddarb3D0AFf1lcJtyui+DJHd9wGq9dgw8BkxNSQfpwQ6bNHyGVLrMCjaxTh4ieeSfMXa/4KXBKu894XzDqNhp3eLfKYQG7d6BJH3IEYDrv409ULki4YN7JzUzsfoxeoosg4fdWlQ3w3HQtrs7dyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XS5i/5yS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NlkDI027342
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2oqrkGjzA/cLsOTZU66EH16Yp67C8bgxn8gSXmYQkc=; b=XS5i/5ySL9/dX/ot
	PaFTZCwraJhzf8Z8uQxKTavoDl709y+gKABp/+cdX0BjDp01PZ8HSu/opEETfVQc
	yF7f+FZUFbJfG+pDvSLXa0w7zHSPbaXVdW+r0sC9aZLJj/H1dxVRtvWvVMzoGYWF
	5q1a0I3IlN59SHkSQpjT/LTVNYEjLgb6MdK7raUqOeGhUqJal974T6jLZnQz45LW
	y5QMWSQzwWSDYPzIm2b61uTT7RNBCnf1eqAu8OKsjbFKRH6di/SKPosSNwk4XU4H
	DTwJGb6ejJUj3hpKPhDAhkL50vm3n5uoZkd1uVI92SxauoH1eR3kIqyDpL0zthe6
	lYdH7g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxuyae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:19:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b148e9776bso28462585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730719146; x=1731323946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2oqrkGjzA/cLsOTZU66EH16Yp67C8bgxn8gSXmYQkc=;
        b=V9yVzSWGKNw3Q9fdXRyNKut5cgwwmUoMQDpPEPLWPF7XEuYUpEh75LawS9sZKPc4qY
         i6CEXXNT+rx3r2km9FmdzHbZAjk9+0iLtmvuVEPr9FLzyBs4FyANYDUc36L75KmthOVu
         VCVQJGhNMb/1evwSpwmySoo+pBGprjPpHQVDEYI7AToe4IMGt2iKilG24cXL41F4JkSo
         muXBVJRamREEnETJunDC8up4QRY2IkqlsNTrAF1UYdHZqML/CvD75DQo2nZloqmrfCPO
         0n2Jdw3BJWe5vCdC9rnNvojD+lCaQqdaK7mnW++263WmkXCJfYypHQrMeZuARscER61o
         mP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVOzpFeufPEWyteeJJ9T8En9YkCu5gDRpnis2J/wkok1ysG9RBxJWnnCTD7tpjJRWV1aa082/a/vBbkvSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9eMJgyVLO4KiIsaL/GKIdwdeMLZzdTrZLCpLJsVORnOOHTUC
	QQXaBc+RD4bNgEYHrg635CCLMM4bjIM00BfewOcUbtIsdhE617ZVn18d/IHNxt48XseRJ1+mPQc
	u6wTMgg//jLucFBb+OW0Hq5r4+UgGBpq5DW1RpVQ6ktjZD1qJ4pm5eGcaCaOpptc=
X-Received: by 2002:a05:620a:3181:b0:7b1:2242:e3e0 with SMTP id af79cd13be357-7b193ef409amr1999302785a.4.1730719146244;
        Mon, 04 Nov 2024 03:19:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmjI7Jslj3eJ0wFw7ek9WtoDBg7hvIWPiFS3CeTaEvgboxht0RJg92uZc82vxdJNXaDmrMg==
X-Received: by 2002:a05:620a:3181:b0:7b1:2242:e3e0 with SMTP id af79cd13be357-7b193ef409amr1999300485a.4.1730719145792;
        Mon, 04 Nov 2024 03:19:05 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df949sm540724366b.121.2024.11.04.03.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:19:05 -0800 (PST)
Message-ID: <33174321-d81d-472a-b267-ed2cdd691b74@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] ASoC: qcom: sm8250: force single channel via
 RX_1 output
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org,
        konradybcio@kernel.org, konrad.dybcio@oss.qualcomm.com,
        andersson@kernel.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
 <20241101053154.497550-11-alexey.klimov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241101053154.497550-11-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A0hR_DDLAn6p8CPphtQSp3TQTRaEsQgT
X-Proofpoint-GUID: A0hR_DDLAn6p8CPphtQSp3TQTRaEsQgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040100

On 1.11.2024 6:31 AM, Alexey Klimov wrote:
> In case of mono configurations we need to enforce single channel
> output. This is required for audio playback on QRB4210 RB2 board.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  sound/soc/qcom/sm8250.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
> index 45e0c33fc3f3..7994488d7998 100644
> --- a/sound/soc/qcom/sm8250.c
> +++ b/sound/soc/qcom/sm8250.c
> @@ -39,10 +39,20 @@ static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>  					SNDRV_PCM_HW_PARAM_RATE);
>  	struct snd_interval *channels = hw_param_interval(params,
>  					SNDRV_PCM_HW_PARAM_CHANNELS);
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>  
>  	rate->min = rate->max = 48000;
>  	channels->min = channels->max = 2;
>  
> +	/* Maybe should be moved to driver data variant */
> +	switch (cpu_dai->id) {
> +	case RX_CODEC_DMA_RX_1:
> +		channels->min = channels->max = 1;
> +		break;

This doesn't seem to be specific to either 8250 or 6115. It looks like
this is board specific.

Konrad

