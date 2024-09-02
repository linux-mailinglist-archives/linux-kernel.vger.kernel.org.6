Return-Path: <linux-kernel+bounces-310430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC473967CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979EF2818CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CFC12E7F;
	Mon,  2 Sep 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGE0VhGY"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517110F1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235328; cv=none; b=hBK1orSkGZmSY4CghrS8N6xgRZk6a+x+AZ5/+Cm785IPR79PHeuD/95SFF/KcZs/t69k1QaPbPYiYjVPPBI7x00Lg3uU7qFKzMr25srXOY4EgOBWtvGa6wrolqtmxh+I1byrtEVDnuP6gy7TfoEEWGwcEMJSBURUO1eYLzr8DUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235328; c=relaxed/simple;
	bh=jihjezE4SKxxXHigHPjddOU+sXmPRtYhm5RHPU8ik18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO7cBTHUU/asjgB6uCDEYItVfv7hc3zgwcFVm7UjmR183nwo2lQMaZTtXhpBx0dShgT+gawSl3ilRdKo6fk0Xj0zAh6ZA9P6k6t47GvLbEDs81XqTcy6vYvwjyvIQTYXgCdj2ljgp6BPdBcWy9QDsaJwa5dK1jnfp7exr1BtjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGE0VhGY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533463f6b16so4644808e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725235324; x=1725840124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9++1ZHzcZI4fcRNlptm+zAcB1O/Jr3h7F0QPCUj+I4=;
        b=jGE0VhGYQJc82tG/3vgEFrrGSOpotm5Oegx1utzMh0C5aXnYJerOF4avlKU0FXzShY
         PlVVawlOV0buU3+h28LbgWwrqVE3M/b3X1/uwvTKL2sKVxJFQRoEvqfp7e+ukoI4Icc2
         vqUBMB4Br5Dli6rnL0qs2RqRlWU/sYXRyoKbuZ9ms1pI0YxVqb0NmrpjYhSfI1WR4otq
         S9tRe6CbLovBObbb8KnWXuMVcIhKnYmp/6cgJl/Hy99XzEgbPnaiMabFv3Froy6BCFx3
         6gHxvxFhzICtKLL72sJPPHXCRLpmfULpBxOj9iHK4wS6zSZuAjqVE1rw/0j/wjqWvTdR
         qVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725235324; x=1725840124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9++1ZHzcZI4fcRNlptm+zAcB1O/Jr3h7F0QPCUj+I4=;
        b=tWaICz315HWs0ya782wUvqHj7Eey5aEyfc/SuuhZtTZqSwIr7jbwDGFNB8RUkmvTc9
         nGNw/NwB/SHj0p/oF10/mSE5vMIsgwxPeV9WbxvaMPwSn34eZhJ52dH2TIZSVH0oWY3z
         p/fzrYVR70ca7QwZm+9t2sVFAuojw0CruTQp6xtslEXWc90y88iG5pLJ89JbkrS37WCX
         +utJ0NBvZnEH+wQWj0mjaztpglRrX7X8A1KZ0CBE0boKhJkEAWPR7YJRaXh9DKCC4t1Q
         PlK2aQZ72/eenKCsaM7w4mly4F5H3t3DR0b4q6Nys+BOqbjoheNrR8Gdg2kL1KFUzJ3C
         cAww==
X-Forwarded-Encrypted: i=1; AJvYcCXpcw4jmUndRWDefP1VodsK+n+tu8VBljfyrlFOnYnALCPnqG5/qCJ1uKZk8Tu34NTxSVElvm9T2nBcLPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9EXaQDB6/vgg2hoQIXslgNCFIrLO0yqoGcUUwVF4N3GJE5yN
	0Nib8PGRVeziqXyasiMAjCJQqdLud619nMFgBkwXw3v2CZ6McNVz2spCCEouKos=
X-Google-Smtp-Source: AGHT+IECIQ8duDhzqxT+Vo3df1TEVRNCkaDmJpN6C1Sl4Mk9RAef7hTVdU+HKUJDzazX/Oygc8itYw==
X-Received: by 2002:a05:6512:1598:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-53546a56c49mr5702705e87.0.1725235323524;
        Sun, 01 Sep 2024 17:02:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bd95sm1383884e87.62.2024.09.01.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 17:02:02 -0700 (PDT)
Date: Mon, 2 Sep 2024 03:02:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: quic_dikshita@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vedang Nagar <quic_vnagar@quicinc.com>
Subject: Re: [PATCH v3 00/29] Qualcomm iris video decoder driver
Message-ID: <xwkibtfakensuzrj4ycmyh4nqjr4nwkgqr63og7n6ejiw3hjqo@rvl3hhznfftx>
References: <20240827-iris_v3-v3-0-c5fdbbe65e70@quicinc.com>
 <3a62b4cb-5c41-4c76-a957-af8e594ca8b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a62b4cb-5c41-4c76-a957-af8e594ca8b1@linaro.org>

On Sat, Aug 31, 2024 at 04:18:35PM GMT, Bryan O'Donoghue wrote:
> > The result of v4l2-compliance test on SM8250:
> > 
> > v4l2-compliance 1.29.0-5239, 64 bits, 64-bit time_t
> > v4l2-compliance SHA: a1ebb4dad512 2024-08-08 20:00:17
> > 
> > Compliance test for iris_driver device /dev/video0:
> > 
> > Driver Info:
> >          Driver name      : iris_driver
> >          Card type        : iris_decoder
> 
> Hmm, so this is decoder only ?
> 
> What's the intention here for encoding support ?
> 
> I've verified your results on the test branch but I just noticed that sm8250
> with the iris driver is decoder only - whereas the venus driver does both,
> which strikes me as a bit odd.

I think we all have discussed this during the review of the previous
series: complete driver becomes very huge and complicated to review. So
the recommendation was to submit the limited features driver (decoding,
1 codec) and get more features (more codecs, encoding support, etc)
after getting the Iris driver in. Of course sm8250 support in Venus
driver will stay in until Iris driver reaches feature parity.

> 
> Is your intention to publish more patches to enable the encoder in another
> series ?
> 
> ---
> bod

-- 
With best wishes
Dmitry

