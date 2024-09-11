Return-Path: <linux-kernel+bounces-324717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A63975010
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A8E1F23031
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D9185B6A;
	Wed, 11 Sep 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLj84R4L"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8D14A097
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051793; cv=none; b=QVBhweNHAU9i8PWU8DQ/Nn8H5+tuxF2/2r7qicTWc49kIbou9wTBRmF0HbInD4Y7Oh4ysJHCCbT34J9eELhBXapccd6fMZlhp9vTPt3kQWdCxQPszFKvM5M+DzY0+q2T8x6rjkznM55HYx7P6TSTLj57L9dv1+IV2RuTBZMXPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051793; c=relaxed/simple;
	bh=6jk1T8pPWMOU+46Ik3tfaMzJ8N9cAydR0aEM6Ac55HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+G7yzSR9tWI899WJ9Wvf71lT5mRfpuLDQskKhQvlWkJJ/Q+Twyfmmxd1/5KTEvO1U/T5ntFwxBbkO39tUPJLsVDirKS13mGs1KKd3Yq1aGAq5WYV61BYRaRwJ+oCvquA8eMNzgYAE2T1xOnh+HySEOXXgVAwBgPP/xvsIyxHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLj84R4L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so6240776e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726051790; x=1726656590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcAhImD9Bcs+LwlPVoU6CG8toj/rCqCTWdL8dKrlpTk=;
        b=sLj84R4LetuYtbRPlzhqiT1oHUCtJjMY3LkcK9YwKv2NbYGjrQ6Q5/RPDw/NycFeN5
         FyF5ATeZIsR2/gUvG2zgUt3Esk4MrPTkFWSge2XcYs0yF+nhQZgHZGDgInhpbob4qYpW
         Aj4+OvkOOHnPFDO/dXwrjHtSH3vD3MrK523f7E7daQuUyu+FxvT30SO0s9SSfrhRJGdw
         4k9xutiQnFFXVmpRzYJpGJryLTun91dKmOYw9NZZZalL5j1iRZ6ORFbDzRlg6hH5HqPq
         11zSNLemYVOL6S0WFoiauVz7wooeKA6hxZB+T14fSpG1ZBuj50LJXnXwXb/D3FgsSXmW
         +luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051790; x=1726656590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcAhImD9Bcs+LwlPVoU6CG8toj/rCqCTWdL8dKrlpTk=;
        b=ST0/ZkSlmiyrrml1joTgx9gymfeWKhSmwsFx3eRGJCqABDG9+oSGklBMlNkeKPOznU
         PhBsY2c1JQbRmZjl3ER2tuD5aBgFHXGu9fDZn+uGT//VM/80nZKuk1N8Pppj66nOkT/4
         SPodbyB+jg7BlmTsQPBXAJiaMvXnHHlQK4/sIsYR8pgzTPu6Bx7NH7sgn8gVlfwkeAbR
         XWqllntFhWXrOA9v0aWzjBXut13NoF/lNorAze+EI6YFGsxUbOD0lZaZnKavwFNEr6lo
         q7Gr40YECVmidCD4AZ5Yz4ulk4cMWuC5jF+t3kBLCOyxKLcgZetksPP2IqNmGkavQAej
         xEDg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+F4VIE6DbcjZ3bnNe+qvbLcHxuh1117Of2OuzAZ+wK+JoRAOhAXpA9yZasuUde28foO+z3zm06hK9Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENesD3B9uL9ae1L6a7RFqRCifcf+Wg1uCFAT9mxk3+AcHNEq7
	amJ1D8rm75G2VHqR8Dio9MknFeJ+YmFJCjUuLz7J/YfcbL5nNoCA89itEUG87UU=
X-Google-Smtp-Source: AGHT+IH2LTX3JBcTJKTOzy1HqfGc93h8XxwP33R28x2NFSYb3nCH7X4NA7Rjb2b+14DJebCtmVJNiA==
X-Received: by 2002:ac2:4c4a:0:b0:52e:fefe:49c9 with SMTP id 2adb3069b0e04-536587c5fe5mr11756251e87.36.1726051789849;
        Wed, 11 Sep 2024 03:49:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f868d64sm1502240e87.55.2024.09.11.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:49:49 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:49:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] firmware: qcom: scm: fix a NULL-pointer
 dereference
Message-ID: <kdyt5iwqygr535hhv23pfj5mwntcqteck3bi5573lfauuc3prl@7z4cxll4knsq>
References: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org>
 <20240911-tzmem-null-ptr-v2-1-7c61b1a1b463@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-tzmem-null-ptr-v2-1-7c61b1a1b463@linaro.org>

On Wed, Sep 11, 2024 at 11:07:03AM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some SCM calls can be invoked with __scm being NULL (the driver may not
> have been and will not be probed as there's no SCM entry in device-tree).
> Make sure we don't dereference a NULL pointer.
> 
> Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
> Reported-by: Rudraksha Gupta <guptarud@gmail.com>
> Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/
> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
> Tested-by: Rudraksha Gupta <guptarud@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

