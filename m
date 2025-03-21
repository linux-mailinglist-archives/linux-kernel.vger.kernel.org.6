Return-Path: <linux-kernel+bounces-571311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5BA6BB99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460EC3AF435
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF31CAA81;
	Fri, 21 Mar 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbU3lTRs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF751F03FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563013; cv=none; b=TLshzL8AnHMonEvTtRQWWm6mOMTXw+tKQHq0pYIRlUQBx2R2ZulwGGHLIsAiZ/FDNQVOid/xU2bFQBi8n/hZAdAgNIdoIaWmjZLRpLbt4ce5SkbgJozsinK6bfRqcFVgMuGlxVObXWGzKB4rZvE89GG7oKHkfNwvtv2ZeK6b78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563013; c=relaxed/simple;
	bh=5v0eCXSJKnOzt1bK7YTndfKX6eAKPgqOyM0NGeGssOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSlDYxMxiyR50eiZxUF1/zs/fPVt9CmfIy6JOX/Ybg4CxmbQjpyzniZUKpzBax1UROvMk2RImMQWAvCGalr6f/PLi9J6FMVHdyd54XZ+6G9mGK/zvK77Ow0koWzYRD2sKw6KM+v/jJq0sdmV8p8ku5eF7Smk8HHE+A0YwoS6EGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbU3lTRs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LAThQ1013634
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rKDADviDBRmij4wqF3bNF8yg
	rPd+aXcSkF8NWGkccV8=; b=CbU3lTRsUR+71/EMi+TdzS6oaA2BNI0uOMCfeHmb
	3aionmkhue1FdweCXCzRZ2LNrmaPclCaL8r4OJszkaQTW6NDiGNfgkgUrTVybKNE
	ZgCA4eDgmTeKfOBk7DDpw3JHBWc2auF5yU+/wMrGm9B4oI6nvq4jbGTojTKBu5Ny
	lsjuLn44esjbrcBJnmrtgZmUIoPE6X5z2QL22JkN5U71qEG8HOyXjlCn2RvmuFdE
	ErZ2BkF9gnHumRby7WS1Gkizi3LvifoW5xge1GDoZMmGLGmIY3hr48SsPm1Pm2Wz
	7qd9YXuem7LacPPzJRz349PQ6s/6SitXU8KRnZoFgLTj1w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g4t45yhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:16:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so3196302a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742563010; x=1743167810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKDADviDBRmij4wqF3bNF8ygrPd+aXcSkF8NWGkccV8=;
        b=brNuVe+TDGGGaUsiMF87wneJrjnmVAQQf9DKjiRuMVgQw1KJDG60DGAx3S1SPeZ/eE
         WtJoFtLxZMYxvyRIkwBnS4NRXYU3fbzTi5F/1b/wS8iZq6A32HtSKcWg0D9SRG/PmNCE
         vgIA9Iaz3mnC7CdSvVOk3FweDPxcfV6LZhBv38yklfUxnRFA9tsUWjmN9a1xYM+ezfVp
         2sAd4i5+G6Tceb0hp99bZeykzEp3fjxepddT9pSsm21F4IWY17uoNElj6wRCN96QpWe+
         ieRzWxoONex5sV5ft/Q+k1yGCm0VFPJibdhlZYGVy98fWLMWCvkha+nNh1gbmXlGVL1w
         B6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZvXtUr0w+SDLv5v1Z95ITpC9DEEahc0ohBkEzGEweCdD+ZGsGmuHCPbjqKe/VbsNoCI/dTLp9AsCURY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOn13a+ZLzbjbYy3CMRU/Qbpfis2A6YbHjK6vbuZ4OYNv//+5
	SG5DomO/UBGxwNItkjBgIfO7i2ZgBBIWCj+sb+ePvnQWf2k/DIKFcwGQcM9eEuOLwJG4Os0Ndoy
	CUnY3noyIiI3Tpuv8uBb+NTMklK5DD0Twb3zzaNUvc+iiBE4Wj1djDSbNXrv3AE5DSM2YPG62uw
	soDeoiiIgU5OYiYpaXaIg3HZdMSBQEMlN4bR5Lvw==
X-Gm-Gg: ASbGncs8ksevDnrjjhTKZ2z0JjXp8e8V92/BDklnSX3lHpN5x8cDvujN6q/nBSxobhw
	tvPHLIk0PTM02WGxEpNPJn7vzZNar7QcY5kwReV9omOLM0NpEQuClzSgDmSXJARZV/mJcC1kkzI
	AhllEHcMj6OKea3lQX8ht2H6M3WR1s
X-Received: by 2002:a17:90b:2ed0:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-3030ff108a6mr5526830a91.25.1742563009898;
        Fri, 21 Mar 2025 06:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2mutO+YUR5/PARS6/TKZO8Ev2O8vO6eT7KZPndPdr3Py5PTyw8qRv2gkQufsIZf3sd6sgOq3hu/uvvAaFgw=
X-Received: by 2002:a17:90b:2ed0:b0:2ff:5e4e:864 with SMTP id
 98e67ed59e1d1-3030ff108a6mr5526785a91.25.1742563009246; Fri, 21 Mar 2025
 06:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-5-srinivas.kandagatla@linaro.org> <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
 <b1aed195-b2e6-4f48-ba10-3049d74085a9@linaro.org>
In-Reply-To: <b1aed195-b2e6-4f48-ba10-3049d74085a9@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 15:16:36 +0200
X-Gm-Features: AQ5f1JpCRwMtkjJDn9oo-cBhrY2GuyMxCFMeKp_-hQaIAlV_kqtTNCxsu0Mojn4
Message-ID: <CAO9ioeWLRfzUOwjnFsi_yztdJo2Q25bhvjddh6D3naV_K5eShA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
        krzk+dt@kernel.org, ivprusov@salutedevices.com,
        luca.ceresoli@bootlin.com, zhoubinbin@loongson.cn,
        paulha@opensource.cirrus.com, lgirdwood@gmail.com, robh@kernel.org,
        conor+dt@kernel.org, konradybcio@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=HMPDFptv c=1 sm=1 tr=0 ts=67dd66c2 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=2awXsTXn6f5pcYlzz10A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YIxiMJQR6v5Yf1I1zfx_yBDJwq4qRWlg
X-Proofpoint-ORIG-GUID: YIxiMJQR6v5Yf1I1zfx_yBDJwq4qRWlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=839 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210098

On Fri, 21 Mar 2025 at 14:35, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 20/03/2025 14:03, Dmitry Baryshkov wrote:
> > On Thu, Mar 20, 2025 at 11:56:32AM +0000, srinivas.kandagatla@linaro.org wrote:
> >> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>
> >> On some platforms to minimise pop and click during switching between
> >> CTIA and OMTP headset an additional HiFi mux is used. Most common
> >> case is that this switch is switched on by default, but on some
> >> platforms this needs a regulator enable.
> >>
> >> move to using mux control to enable both regulator and handle gpios,
> >> deprecate the usage of gpio.
> >>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   sound/soc/codecs/Kconfig   |  2 ++
> >>   sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
> >>   2 files changed, 32 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> >> index ee35f3aa5521..b04076282c8b 100644
> >> --- a/sound/soc/codecs/Kconfig
> >> +++ b/sound/soc/codecs/Kconfig
> >> @@ -2226,6 +2226,8 @@ config SND_SOC_WCD938X
> >>      tristate
> >>      depends on SOUNDWIRE || !SOUNDWIRE
> >>      select SND_SOC_WCD_CLASSH
> >> +    select MULTIPLEXER
> >> +    imply MUX_GPIO
> >
> > Why? This is true for a particular platform, isn't it?
>
> We want to move the codec to use gpio mux instead of using gpios directly
>
> So this become codec specific, rather than platform.

Not quite. "select MULTIPLEXER" is correct and is not questionable.
I'm asking about the MUX_GPIO. The codec itself has nothing to do with
the board using _GPIO_ to switch 4-pin modes. It is a board-level
decision. A board can use an I2C-controlled MUX instead. I'd say, that
at least you should describe rationale for this `imply` clause in the
commit message.

-- 
With best wishes
Dmitry

