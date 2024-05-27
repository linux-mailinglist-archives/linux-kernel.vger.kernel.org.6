Return-Path: <linux-kernel+bounces-190327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B10A8CFCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA11C21B08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB013A41E;
	Mon, 27 May 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4shJbXl"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374513A3FC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802313; cv=none; b=jvBKyl2BPlnA5C+CDCbYIDFmc+yBO08SBaFmhUt9lu7r3viuKs6kMsKLfKYmt86vIOXIcvctN1KgELi8wcjQsuG5pnhxFJy9Qy73MECRf8D1PFuxBfK0p81JqqlI4vDOe6L3Ev1CWQoGCxLJx6HSUEoPhTW22BSBu8onMftq4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802313; c=relaxed/simple;
	bh=yQdJN/Dk3owFDIxvxJx2sG5wCVgCZ5ezvplI+HnF96Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq0B9oxtTWK+7upFO/qyK0y8mD6ewiKV+vK83wUFyk5sTPsh7IUgletswsQgZhDvsAIRW/J3cQ7i3eXnlwRlgtDks0bZ+FYJpiSrIhlzXzC8Y3nbPJrrRe+3J/PMDmyZ1PH2LM6y0yJm/l2JSViy1YouZgCU88dCo7PsFQLTrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4shJbXl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so37345631fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716802310; x=1717407110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lOIEDapMQMFTempzCjLBBiczi+5oN0ctNRlc+fPjUE=;
        b=P4shJbXlTtVD0XhrOvdcbHq8YBMoQGynttpg+41T55COJNyPdNKbnB7/JGhL3gwRlx
         NASHH9tV3Ky4LQR4q//o9nnTZzrZJSkEOvMk4zKXZ/exqa+KfZmRZHdXdrYZM0K4Rtva
         I+H3NCs+ZeMVVDbfczg66EBpMN6aI/Kcfrser5bQHU4Kzgobi8Zt0/XmSGDZN52q8cI3
         FnpHTKfNzLG4Y0v6UZpOnUuSBiUwF1edsj7Nkax/t3DmR+GLDUbQbE6GK93IZe6PfPEn
         Khyop9llaPkuxm//l7gJmgDLdYJPFteUGZ3U9v6AKcRn4NZfgLNeBhaM/P5LVgjoPRkM
         0lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802310; x=1717407110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lOIEDapMQMFTempzCjLBBiczi+5oN0ctNRlc+fPjUE=;
        b=LaRGVY3M5UrVQt9fwZQ06lfKAhistnNaw4XHbMXMA+PG5HJW3qnZifmsO7F/NAv9tA
         hL9FZBcjdLc8SJMgf1EXEMoLWO4DHV/9tAtcyRhoM64JQzd26F6oKw+nqSBO7EXHu3AL
         dM49PklV8i4S+l0CUPu3P5ppipFkbqqJd6ibaOMkFhdVGvHFL8j0bOAqqs+FkOLvW3Kv
         OWG2JPbIsEgWih6RbDI2mS3R/LFngC0rSMAdk2NIARIvisC3wxjrjEnc4eDV0J25D5uK
         3Y1dYbfupcD1JQShhNDOdY1HCXY+FhQQF7yz4npkDv9kdq3URas5OCkVbRqu5agC2VZk
         cIww==
X-Forwarded-Encrypted: i=1; AJvYcCXhBONrlUgtRmBNeRC8chlxwqkexDRHFeTl3bWqIlzPZJhryh2R9xTfbvBIFfA/t38ErwlzLGu6Bq0QyT2ipVvI0FHIv0LGctnsYE1i
X-Gm-Message-State: AOJu0YxnDwsAjCNFlO4V3kccRB8qtkWa9g/JX73jJNbGGAYckNX0itvo
	lXFVkm8jwPXrMPKeePNBb7adMJETL2HfWmepQ1H6m/xwle99mXpdz/mM2Cj8aEA=
X-Google-Smtp-Source: AGHT+IEPv7EDp4kePquA7op/6dhZT+drl8Ylsz2niLA2tU/NQtJi/aGWxOm0a7bFtOI7nvkBSVJRJA==
X-Received: by 2002:a2e:3a05:0:b0:2d8:da4c:5909 with SMTP id 38308e7fff4ca-2e95b2cb370mr46039831fa.51.1716802310053;
        Mon, 27 May 2024 02:31:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdd14c7sm18590791fa.97.2024.05.27.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:31:49 -0700 (PDT)
Date: Mon, 27 May 2024 12:31:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Alex Elder <elder@kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sa8775p-ride: enable remoteprocs
Message-ID: <sgrflejmt5btqgruqot3epcs6zdl7wozru66ddqcqgm73gspqy@hjqoo4yqmrdd>
References: <20240527-topic-lemans-iot-remoteproc-v2-0-8d24e3409daf@linaro.org>
 <20240527-topic-lemans-iot-remoteproc-v2-5-8d24e3409daf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-topic-lemans-iot-remoteproc-v2-5-8d24e3409daf@linaro.org>

On Mon, May 27, 2024 at 10:43:52AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable all remoteproc nodes on the sa8775p-ride board and point to the
> appropriate firmware files.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

