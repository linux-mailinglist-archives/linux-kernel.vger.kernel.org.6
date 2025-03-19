Return-Path: <linux-kernel+bounces-567685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A70A688FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75DC165F45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829F1F8BC5;
	Wed, 19 Mar 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvWuU1Da"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD61E1DF1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378504; cv=none; b=jFypeZbr6a0m8atkbmuvgu/5PK72rC9ylW3WKQ8viZNq4JUy7gaF0xqQhNt8jrIlvR9t0BQZd81Jp09OpS9cyVSw8Qbit18t6dp7KKA47DEXU72oBzybOJMEU2kE5gDrZ3VV3IDX2KP+4eqxsh9w+QObNFex2WqbZtLE5YCGN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378504; c=relaxed/simple;
	bh=XUe+jsxf6CToNNlzFKXj0FuOYSurMgVx9HLYqUtrkAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2xCVhKo3HPMh5Q15WyPl2I5RYX13NodlgdKs/1zskNRVdEs5HqZtambpou5j97dHX26pihuqSFbFb5zy4kQUVziWlfugslR0eQSTnIy40ZMsq30ENNSJ/jPBC9PWHM+TyZ/6uTgt7+RQz7gTqQXN4+DmXxbu1SZkmVMSjP/uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvWuU1Da; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4limi011985
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6ar7fCbKOyGZpKMOTQA5T0v9
	4HfMi68v9XDsZNUCZ7Q=; b=FvWuU1Daaxee/BDGkLvLgqqvZWHnpWs/fPlhMvUp
	CQ5/POZUPHyvQl4f9sl2XyT9xOAPHlE+EEskQZPL8bNPpVEOeNNdLlk02SUFDCs1
	coOw1ypM/a1jqILUU88yc4gY47LhEUdVLnTmLrRlKguqtI8z0auolSsl+Cunh3Ld
	GFCyMEulA4h/35pSI610co/Zvl38EsMXhCeuKN9OuEVO2aK6y4sC7YedaPzgJEh3
	DHYMboN689VPlZJlrQar9CV5Px/ZOmQmo2mF0Qng/A0kyXwnkLV05p1AdYBkDlnh
	7lU5RMvnudsC+V1orFMKWProvBhXIiPKYYu4Wj8/pd67yQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010mqr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:01:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476b2179079so131042391cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378500; x=1742983300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ar7fCbKOyGZpKMOTQA5T0v94HfMi68v9XDsZNUCZ7Q=;
        b=bkqLc97VLlroeECLJ8unzI6huw++1ElyIjCg/ffGVvu3OD/cpq+QIqL+ZYG2AvWwUP
         kdmtKKM5MrXdfgeqrzJ72+Nnmg8vntFJvhkxkJWw6pxasbqKiFqB2toYFpR6GyFSCKMf
         dRgO4IMUyA17YsbNXOXDpybJP2vxrXT1AtYx/UdtfAnhTsGY+2RqMoaIB4JT+MRZvnBF
         5An/2xTDLMxdO3h0050gAoYCeCY2PpA6JQegJtfYNS9OS4pViBnVQ/zEAj7cLDz+/5R+
         MTPZm3aYqqfK6R6dmmo47Bh6Q0+KdVtcbL3vg7ToGn+CZIu3mSFe9mK6n2zdF1cuc9fQ
         vlLA==
X-Forwarded-Encrypted: i=1; AJvYcCWgJAQoWekLIJX04sBRGmW56uBn5jkjlRqJp+p+btPx8XTTcu9IpKj/eUCW7wmaE14jz6lZyFL9zX9YQBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUFC1w4x5M2wZUyPGcQOhixk38M4UVQTbeidYJGhEYYHufDlC
	d3HPghIHismQU5s9317oPxHO+un6zX72Sa9563BI/R0DezQ6/+0kvq3l640D1pg40Hy+K7/Kzsg
	lURryyNNj48tdkN50qL7vlaqmQ7lkIit3Lb7VSk7xfosf3iR1gTNpR96/26neI1U=
X-Gm-Gg: ASbGncupp9+/019Vian9cKprdndckn5UNrHIrEHFxDcqxuqepbYz2T6JhbOZB0Eyljo
	o7T1vdEKTMrQPk/ARpJDGkIw0Yv4xEoWLT6lQffbZTLrmRIj2XCRPTXzB48M3myZkyq7YjESMSM
	kobpwsrCYLyMZZMDaFfbmvmZeKAItF7G5vdGe5fg59tG0W3SodPrK5jnGcQZhAJuO4j6y+RVodj
	PWu3NQJlZIZQ5C2MobK1oQUXNMWc+0vAUZaUgHnQxF+4PBAnjbY3kPa9oFOkU3FkzPjn4Sqbfh2
	3wFYdWIi2Y9jrw63ZnBhHrlrlsFf4atUS+vZmZb4CinJTbOSI6+B0o4j/lOkDKzCi9SuomOkPLP
	T7zw=
X-Received: by 2002:a05:622a:198f:b0:476:9e28:ce49 with SMTP id d75a77b69052e-477083fa83fmr36529481cf.43.1742378500198;
        Wed, 19 Mar 2025 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/8jRnkAWhCa8HlPDdGVL0sr7qdZWUT3wVBvjOrwpblEM6Qa/FT2Y56cp1uYZGIz0DEa7Vg==
X-Received: by 2002:a05:622a:198f:b0:476:9e28:ce49 with SMTP id d75a77b69052e-477083fa83fmr36528881cf.43.1742378499705;
        Wed, 19 Mar 2025 03:01:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8352sm1962602e87.7.2025.03.19.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:01:38 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:01:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, perex@perex.cz, tiwai@suse.com,
        dmitry.baryshkov@linaro.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: wcd93xx: add bindings for audio
 switch controlling hp
Message-ID: <4ie22uuz5tpg77jto3c3hec6lhonr44hrjda7jk655axlaxvba@u3atd4gcyghn>
References: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
 <20250319091637.4505-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319091637.4505-2-srinivas.kandagatla@linaro.org>
X-Proofpoint-ORIG-GUID: CXcGaZz4QdXTbFuYRWxFugqV8cSK-JC6
X-Proofpoint-GUID: CXcGaZz4QdXTbFuYRWxFugqV8cSK-JC6
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67da9605 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=BBAQEGfUMlneDKUuzf4A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=726 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190069

On Wed, Mar 19, 2025 at 09:16:35AM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On some platforms to minimise pop and click during switching between
> CTIA and OMTP headset an additional HiFi Switch is used. Most common
> case is that this switch is switched on by default, but on some
> platforms this needs a regulator enable.

Is this regulator supplying the codec or some external component? In the
latter case it's likely that it should not be a part of WCD bindings.

> This patch adds required bindings to add such regulator.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wcd93xx-common.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
> index f78ba148ad25..fa00570caf24 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
> @@ -26,6 +26,10 @@ properties:
>    vdd-mic-bias-supply:
>      description: A reference to the 3.8V mic bias supply
>  
> +  vdd-hp-switch-supply:
> +    description: A reference to the audio switch supply
> +      for switching CTIA/OMTP Headset
> +
>    qcom,tx-device:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: A reference to Soundwire tx device phandle
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

