Return-Path: <linux-kernel+bounces-332639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27F97BC57
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB71D1C22C99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8D189B8D;
	Wed, 18 Sep 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMWYFbLg"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658A4409
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663050; cv=none; b=i1jjHBeB1fMQy7M47HdTssi4OBgK1pqfZgY1uPEZRvX18iNGSSoUG6uxpwRPMcxTLLserT9WTiczFpFD1FpGWS/9YHB7y9HBx3SEABaqKp4hDcyPo9lSfrMJGXLr0Jsy4/wfbmIMs/HjT8kheQsndFsMsb+u32CB7se6vt6nRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663050; c=relaxed/simple;
	bh=qeQMM8Wd0V3o1iMH4h/+ztFrJIMFY1Yml1czY+r0VCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVUHp65ZL7bC8R5bTBE0PnI4zvb+k48z3PD2cALxUF5x7AV1hTpoGuDgWSFC9MRYPM8+svJkF8emymrFEPnfn6KrZ5M0I6pp0jhSArcs33yxuIYrIJLlThmu60L2HAa5Z0knNKn3xhHF30YPriw3VIc/tLd0kVXHVaUIvsT+JgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMWYFbLg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5356ab89665so7697282e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726663046; x=1727267846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDqNM7mHosRcM8zPnL70V2acHsNvApt7iBMKoxePkgw=;
        b=EMWYFbLg3EhmbTm7s8QI3+2T/5Qocf7dlaC5I4BaJfiz/WO9R2Ymp9wm/kX35vFZC8
         pSZpDHLSN+gqQwYCdsTY9bEFcJa2OgKhgYVJl1N0ussnFS4ejSZ4az3wrcEKlmZocHW3
         9CZUuv2VFq/9lweeGFo4YKtso/4uzDfcRXuKR1bqt49jFW/rY6ysfFttGl/AL1I5HH5F
         YSwKo0jnYvXJVqyaN9yQj8CfpTAfd42vHxfD3+zFPbelA2lmrwKZ0Hll1yzIZyQgTd4U
         rTnFW2ZVrx//3W3CIdCyIa+0difv+uqN63p60O9zxn1OEUa5AtxKQTbnqNpp3LpMeY4h
         OYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663046; x=1727267846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDqNM7mHosRcM8zPnL70V2acHsNvApt7iBMKoxePkgw=;
        b=iGSKHeqxIG6E21ax6L/9/GOjU3Y73zSDTVq9Xdl8AU8TUO5XZAJ24YaDu3kyET+KzJ
         eyYCnairL1VhGBwLR6z6t0tLzOZLOevDK8UeG5tuthNvnzt95ghuz7iJ5nwVLcw29j1z
         /Zj8oblHFwab0D3Me8dsYBi8j41gTEwSg22hNOd7B62n1fNBGV3LJBxYtdNCmzsItS5Y
         kVUtPqCW5Pfkq3x5VGwRlwq3N1Cu7s2Wl7cjXMRkH9U2H0WT7+bRRlDTT4NJi+ye2jbs
         eCn9AnuKYaQ4yegBPxtug0rF+j9DKNHPiIZlnygnOmmvjtcbrYLf09MSzpUL6KSAq/l8
         lhWA==
X-Forwarded-Encrypted: i=1; AJvYcCUbMG5F0wrurTtUxK8ws4OSen/m7W+rjxx/hKEdL8CaV3Nd9gH/zVfJmP8Cb1f6cW1se9Qj4Yi/OWx/PiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tHCZpOHWEtpr6MMK4nd3ckW7EuVFpZnsaGFkqpGhS3u01T6r
	c1CsF+0Tb0NSiG7wiNP7lK69tOKoAF2aiyWEfLwEBUMRAr8pIToMA1/D1WiYUq8=
X-Google-Smtp-Source: AGHT+IFC2Zdmm09y5YnIjyMsIvLGZyaR2o8tST0ToEXrXSsy5qSuhFwc3Wp8ycruRRTus8dd2YhjOw==
X-Received: by 2002:a05:6512:10ce:b0:533:3fc8:43ee with SMTP id 2adb3069b0e04-53678fba1f0mr12239024e87.13.1726663046217;
        Wed, 18 Sep 2024 05:37:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704da94sm1508218e87.89.2024.09.18.05.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:37:25 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:37:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Adam Skladowski <a39.skl@gmail.com>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Mike Tipton <quic_mdtipton@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] interconnect: qcom: add QCS8300 interconnect
 provider driver
Message-ID: <iebfjkoxcbnh3akw2dev7kwj4ae2yazrlhdpw657z53p6exx2f@tj7ol6gix2dy>
References: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
 <20240910101013.3020-3-quic_rlaggysh@quicinc.com>
 <3xjvx2kwrlruhhxw4aald26qjf5fzikay2ypzr3mwv75mlmf5q@lmn2o64npfg2>
 <40dd23e7-9ea5-4eb3-bb6b-e1952d746958@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40dd23e7-9ea5-4eb3-bb6b-e1952d746958@quicinc.com>

On Wed, Sep 18, 2024 at 03:10:34PM GMT, Raviteja Laggyshetty wrote:
> 
> 
> On 9/11/2024 4:18 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 10, 2024 at 10:10:13AM GMT, Raviteja Laggyshetty wrote:
> >> Add driver for the Qualcomm interconnect buses found in QCS8300
> >> based platforms. The topology consists of several NoCs that are
> >> controlled by a remote processor that collects the aggregated
> >> bandwidth for each master-slave pairs.
> >>
> >> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >> ---
> >>  drivers/interconnect/qcom/Kconfig   |   11 +
> >>  drivers/interconnect/qcom/Makefile  |    2 +
> >>  drivers/interconnect/qcom/qcs8300.c | 2088 +++++++++++++++++++++++++++
> >>  drivers/interconnect/qcom/qcs8300.h |  177 +++
> >>  4 files changed, 2278 insertions(+)
> >>  create mode 100644 drivers/interconnect/qcom/qcs8300.c
> >>  create mode 100644 drivers/interconnect/qcom/qcs8300.h
> > 
> > The driver looks pretty close to sa8775p one. Would it make sense to
> > have a single driver instead? Or would it complicate things
> > significantly?
> > 
> 
> Yes, the target is close to sa8775p. but there are differences in the topology and same driver cannot be used for both targets.

Ack

-- 
With best wishes
Dmitry

