Return-Path: <linux-kernel+bounces-571640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC808A6C005
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D4464AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D022B8C4;
	Fri, 21 Mar 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAD96aLz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F913635C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574885; cv=none; b=EqaObEv1lD36KSVL3Sd7R78+hDdh50nPLzFfy3l7EqdSLNsxN99p3At/Qj4RFNP39ksDuu7KSsmh+SZ9gyxhWS6YJhshK3Q0GWw1TXNitmBbaNnq/l2PecxraiHb2Hrx9p9Qjsc9NT8bZEzwJ2ZNtZmACRM5vXDciiNhx0tm7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574885; c=relaxed/simple;
	bh=0b6hF60Knc+sMkvma7g1QOjoquUgb3ux8++hhbe4Ya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjKdyfsojriPhk0g3Ip0A1UCmWYFNRoNIEewrfidCJQ0ZwCQm5Z0vRn/YABH2qMcgkWes0QjB39QdRAO4xhRBjt/dMiSsD0uij9qaWoZp+Fchj+sx6X2hiBkfyWdbi7P/e0izZNHlZKaT/wwRFyHHRa3Og9C94aldyZH7cmpBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KAD96aLz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATh1O003188
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EE388VEZSesC5LctaxpfptMO
	MU2c2Rmck6qRzYYeCuQ=; b=KAD96aLzA3xxCx0Dc3im/mGKqulsZ/H8sgX5+UGi
	bH/xD/KwehkvyRdrj3pczZe1pTmkxradOjczTz5hyN+j6fUsQ1aawG8VbvyaHrIm
	em7kb0QPWDE6MS8ZeezUwSlhL6zArGNL4mMli0n30J4ayxcGMrY87y48BInPgxkD
	1yQ+bgzoMPZxbYLdBwU1xGtW7HNRctaoujqIj6ryLC0mkomTABXwiZuWlfAFThMg
	qEfhGHs1+dXaxURZ//HsFmVOY2B1Z8lGWg+1J5JzdM+mL5mx7Q5TG6zoGTG+zBQy
	Z7dIZFm/6TGKyfFV8g3hCiaBIEgN9v4bZsHheGI6Th6qQQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4p11cdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:34:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6eada773c0eso63427306d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574879; x=1743179679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE388VEZSesC5LctaxpfptMOMU2c2Rmck6qRzYYeCuQ=;
        b=dbEIKKtF67HyKLUJ8JN4CwCMxeLNoypRHwV2C2X0jnbWXMOtBk7edcBiY2Mt4UEIIv
         /UrtgPNlMlW3qVJxNWQY7IYI8sWBcJSXdp2jNeW67RaX4Da7+XiLOjBTav7/860R/QdT
         YWmE+y4ppfXPT7XDrVJuJH1Q+0xbzTcHiDAhp82yLzL/2a3bSNyzn8i4QmvCXlUuEouH
         2fELUFx6LSC1LSlyhuqYSe0ytt6CLvbawsu8ZO//mHv4AWDH7KUjA7q+FLWpKn7d4vya
         i4SO1Ude14R+9pGhlMf3tggKHbOWbs2zfbH5WQSEUSoa4n4llRr2dm3VTGAdHtjuewtA
         9erw==
X-Forwarded-Encrypted: i=1; AJvYcCV6FNpHewnXLaUNX7rtvJ/VQj229ejO76X3W1vXu2e4DKAEC0IjWiPTboonlkA0GUUDeYfoBq3mx8FyjMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYZLv1BYIhFEf2B9DV6MPNFEfTvqe310zTyU++wEw0q5m/l9R
	ZWTXt7EPOi0nzIESQ7mbJD0JWr7o4J5SSdGlVegSplyAIuqHLFFiKg4oIgshfG+11Bt6IJdJ0h1
	n6ZuSn1PgbABq3pbDEKSf3YSM/QOsKPHXBoHr6/REmzlhcEcxCNnivifB+ici5KI=
X-Gm-Gg: ASbGncsGtlAsIQKAapAjTg8o4Fc8W5nmvc4tpDEAw6AZgJRumZIixhJT1WOr1lzx2P3
	9Pv2WV0vwTc0iJNQ2NLblLJNLgi9U6ctmN9ggaq+4yyQ37utoljQCgJb+gcT3eyoQJZ9rw5Jin4
	hpRHhdx/DMkyM5BJzlSn56ZZBtB/l2GGycM9Bc4BLyViZqbCwekguAHI7Is5JydBySWDhBPRcDP
	5hsGBEgFaAjzLHWPtFILE/iFYrdq2fRhp4Sv90W/LJSps/kYTK0p1ClKfhvs59nmj3q1IaCgyn4
	b0yMCKCV1w4KMs2YizjFWGL1TixKINImxbRDuFJ28VtjSN2EYF2hGCwjFMP5vzJX2dSHOTV8QA/
	kIko=
X-Received: by 2002:a05:6214:19cd:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6eb3f2ba60fmr59080206d6.7.1742574879263;
        Fri, 21 Mar 2025 09:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp3DOhzM+XReSZ3mycd+S6hNB8v4/e/R/YvL8uoVVb2w9+7h2Gtkt/guRDgFNGXHv5VmsTXA==
X-Received: by 2002:a05:6214:19cd:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6eb3f2ba60fmr59079896d6.7.1742574878954;
        Fri, 21 Mar 2025 09:34:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647cb44sm216887e87.86.2025.03.21.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:34:36 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:34:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
        krzk+dt@kernel.org, ivprusov@salutedevices.com,
        luca.ceresoli@bootlin.com, zhoubinbin@loongson.cn,
        paulha@opensource.cirrus.com, lgirdwood@gmail.com, robh@kernel.org,
        conor+dt@kernel.org, konradybcio@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 4/5] ASoC: codecs: wcd938x: add mux control support
 for hp audio mux
Message-ID: <cxnmq66gww5mopwwbnw34gx4ynoocf63c76lwwn6h7eklzxhap@whjsxav7nggf>
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-5-srinivas.kandagatla@linaro.org>
 <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
 <b1aed195-b2e6-4f48-ba10-3049d74085a9@linaro.org>
 <CAO9ioeWLRfzUOwjnFsi_yztdJo2Q25bhvjddh6D3naV_K5eShA@mail.gmail.com>
 <1d93f731-66c1-47b2-a249-9bdb25205525@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d93f731-66c1-47b2-a249-9bdb25205525@linaro.org>
X-Proofpoint-GUID: KlNQTnWCbai4zMVVzn8pyXIh5rQ_-bzP
X-Proofpoint-ORIG-GUID: KlNQTnWCbai4zMVVzn8pyXIh5rQ_-bzP
X-Authority-Analysis: v=2.4 cv=NZjm13D4 c=1 sm=1 tr=0 ts=67dd9520 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=cFvnhfngp7Wf6xZ2y_AA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=763
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210121

On Fri, Mar 21, 2025 at 01:26:44PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 21/03/2025 13:16, Dmitry Baryshkov wrote:
> > On Fri, 21 Mar 2025 at 14:35, Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> > > 
> > > 
> > > 
> > > On 20/03/2025 14:03, Dmitry Baryshkov wrote:
> > > > On Thu, Mar 20, 2025 at 11:56:32AM +0000, srinivas.kandagatla@linaro.org wrote:
> > > > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > > 
> > > > > On some platforms to minimise pop and click during switching between
> > > > > CTIA and OMTP headset an additional HiFi mux is used. Most common
> > > > > case is that this switch is switched on by default, but on some
> > > > > platforms this needs a regulator enable.
> > > > > 
> > > > > move to using mux control to enable both regulator and handle gpios,
> > > > > deprecate the usage of gpio.
> > > > > 
> > > > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > > ---
> > > > >    sound/soc/codecs/Kconfig   |  2 ++
> > > > >    sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
> > > > >    2 files changed, 32 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > > > > index ee35f3aa5521..b04076282c8b 100644
> > > > > --- a/sound/soc/codecs/Kconfig
> > > > > +++ b/sound/soc/codecs/Kconfig
> > > > > @@ -2226,6 +2226,8 @@ config SND_SOC_WCD938X
> > > > >       tristate
> > > > >       depends on SOUNDWIRE || !SOUNDWIRE
> > > > >       select SND_SOC_WCD_CLASSH
> > > > > +    select MULTIPLEXER
> > > > > +    imply MUX_GPIO
> > > > 
> > > > Why? This is true for a particular platform, isn't it?
> > > 
> > > We want to move the codec to use gpio mux instead of using gpios directly
> > > 
> > > So this become codec specific, rather than platform.
> > 
> > Not quite. "select MULTIPLEXER" is correct and is not questionable.
> > I'm asking about the MUX_GPIO. The codec itself has nothing to do with
> > the board using _GPIO_ to switch 4-pin modes. It is a board-level
> > decision. A board can use an I2C-controlled MUX instead. I'd say, that
> > at least you should describe rationale for this `imply` clause in the
> > commit message.
> 
> I agree to you point, but historically in this case us/euro selection is
> only driven by gpio. But I see no harm in moving the MUX_GPIO dependency to
> machine driver KConfigs.

Machine driver also doesn't depend on it. MUX_GPIO is selectedable item,
so please handle it via the usual way - defconfig.

-- 
With best wishes
Dmitry

