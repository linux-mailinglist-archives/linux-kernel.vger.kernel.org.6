Return-Path: <linux-kernel+bounces-352605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1899215C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981CFB210CB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8BF18B46C;
	Sun,  6 Oct 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLHYNCf0"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52851482E2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247625; cv=none; b=Eb+lGJuIpd2cjEiLNs3Snqa0j5+pSKi3NjqTWK496dMXJlRGBP/Y8H9VA86KscRiGZExlNf+z/Hhtf+sN60t1BVJmjNIZRcHuKMhdzMxOPoS/zivDv1k8RJbSyKeLF4MN22d+0+R3IMjTEx4UK0Wm4yHsPjIwmGQ9bZKEw60VlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247625; c=relaxed/simple;
	bh=qOCnT/Ya1jNomZvlIwFzbJ6tPZQxzq8D0fUT+rIip18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7iFXWgGlSVtRAlILwf1lB/7CsWocRLL0kbUrcTUQdg65JPsSxcGXSfMmmpAomJakFH0laqGrFF4c+sf6b702NX3O9XHT8h2Pema8yGnC94LpaQWX0zSfRcJVzxwddqa+50up8hzakTlCxV1iHdu7+Djwsqn2VqD9XxziR7PPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLHYNCf0; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2facf48166bso42631521fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728247622; x=1728852422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELm2L1HPpE5ypl6LlzrRt90wm4RKfaebBSz09tts3O8=;
        b=PLHYNCf0PsEU2fUgC5jpxb5+oZb+H7GrQtjilicQGI3vL8fPkQ7H+x86s40aJC5XGC
         QNiOtqjrV4FgLQJ9KLGNK7bEQPDkQsGti9o1An3+ONqWwbN5Bk7As6+OkgN59p613sN7
         habYUQWs13lfLlEGR+t4Hvhz25icWsnZq+S1yMC1c+NOfS9bdtsDjY7fvx4OWNBH/ciR
         ZJE36m4cVd2LA1SaEnrQufQ0o8etbK7yYQcK9VymifXFsXafwCWNaBFrbU5nPStiM7mb
         Psue89cud5NdpmDJu7XfhI8miZL8nkPiorYW3QvCDLuoE17/zTYbJnkqMfrTkWATmL63
         9pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728247622; x=1728852422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELm2L1HPpE5ypl6LlzrRt90wm4RKfaebBSz09tts3O8=;
        b=JMDlLomZ3lMf3OPtcfgKijum4KZl17gsPm9m+tWUlem8q1c8gZcGvVoJdF534oAcDo
         wurAsVvZzEbWjFJzLIxn4YcUUmwXjb6YYhOlGoYGJMTNUNwh6y/8CPDJlS3RA5rLFDAL
         Gt8YQtd1llqy43BAc8y6Af10pwFInZmqeY0BgzeLdLPLWAe09ZjEv1xYCSISQFuBq3n1
         p+/sL9g3opQtW/oymKhE4io0w65ISJPyqRNGbiVU0piKLlFkPcfS+g5AFw1WGzgITjZk
         VCzS2WMyO0+EkFAoX5iEklEp+hOmMNl5tcf5dgkf/klAOu8Nbe/3yx27bpr8z+lHDRGF
         LTsw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSsqfEvkjv1eRz4EogPbtxEd8FZOp3zTHaLVyAc1uNLxPDsONlWX5rNdRr1QS23n2BA4sj3mnuM44Phg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa76q2QYhW1BurlrmsR3hZgP9ki99fOIgvhqqoy13UWStV+Pv
	q/1dsOHiy28Nv+eRdp9Pp88AIMWHldgBrAHYa/DiUEd1z8VtGh4BtFWEfP7e4fY=
X-Google-Smtp-Source: AGHT+IFizL0+yw3wWnoLC/qC2QKl4scr8PrjAX1mGGjyOahajrbJr2qi2cByCq3VzO0DrQt7mwAcDg==
X-Received: by 2002:a05:651c:2119:b0:2fa:cc12:67de with SMTP id 38308e7fff4ca-2faf3d7084amr37219431fa.32.1728247622006;
        Sun, 06 Oct 2024 13:47:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab12e2sm6570341fa.8.2024.10.06.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:47:00 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:46:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: quic_mahap@quicinc.com
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kalyan Thota <quic_kalyant@quicinc.com>, Jayaprakash Madisetty <quic_jmadiset@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sa8775p: add display dt nodes
 for MDSS0 and DPU
Message-ID: <bwqrqamudbonslvmhmgdkb33e7464zywff7bvvklbcecdlxpxc@ir3r4mkb6srl>
References: <20241001-patchv3_1-v3-0-d23284f45977@quicinc.com>
 <20241001-patchv3_1-v3-5-d23284f45977@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-patchv3_1-v3-5-d23284f45977@quicinc.com>

On Tue, Oct 01, 2024 at 12:11:40PM GMT, Mahadevan via B4 Relay wrote:
> From: Mahadevan <quic_mahap@quicinc.com>
> 
> Add devicetree changes to enable MDSS0 display-subsystem its
> display-controller(DPU) for Qualcomm SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 89 +++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

