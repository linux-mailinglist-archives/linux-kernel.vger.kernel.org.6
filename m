Return-Path: <linux-kernel+bounces-324522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31592974DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A7DB23F76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3E52F9E;
	Wed, 11 Sep 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brrVM2Lp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5765154BE3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045151; cv=none; b=GTB1lu4f4hkjuxO+f6jXBPR3OEQc2FVaqHqIH+dAQytl7tvhvz4aqxOFSOAa7IuLCG/d9eAWYE/7GrHLlBZmdhQeC5fXmnj37RHtsBuFOo8KyYIMlnRxdLubZ1o07F/5Toxsgh9WCI7B/MtzXCzmVaxPGmDvm58TfY8FqX9MWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045151; c=relaxed/simple;
	bh=RXcUU9kvB/0Lyk/xqe7Tia35vTzjcbYYrmrNIZh3fNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWTsdZqPjW8enHeS2nfE/tu9Ecqa8XX8JmRgaRhZMzHAyU2/4TImu36J3f9Mdwzmok85drCkIOefkgg86Ib8uJfF7dnVWxNxAGITy7Agw/dsnPVp04GjkuGI+BqIAIqUDzZ8mhn/XfF0MV55CKykrBR244seVpw14rhfivdfvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brrVM2Lp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365b6bd901so5838521e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726045148; x=1726649948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBnIbKIrzLr2LRaTxm32XswuLSx/2Q2zvIDfhd4W5ss=;
        b=brrVM2Lpz6dLkz8rpr4Hl0y8iNW2JW1VF6uDvhsDgzTeKg2Ynt7GklrQO3k075J/FN
         MNzLmiQKDfOr9bjbOJqIi/jC4ieMMbC2LlaVuAlg0SHJK016tmT0PcMiDmgadwOq0HJc
         aNGLOPaRGa6XV3NjSBCl0KNBO6pvXEnzvcJaQSU0J6maMvHVNpESrMlfq/kPU27XsRX4
         KVhIs1DDsxzVgP3oAaWQA0wLb57UJTA2qVNtpwpTL/hbJCPxtsIfbZLGXb+FCWIEggh1
         uQV/ZdBF7Qunm0cxo7FhgdFcKhIEDYqY2oxnabD6U0j3Ypp2tpyPvj0CMtfJ/b7fIira
         Uxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045148; x=1726649948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBnIbKIrzLr2LRaTxm32XswuLSx/2Q2zvIDfhd4W5ss=;
        b=pOTV68OTnKirYN7PgJAUB0UxWa+64Qd7izsKy4zXkDjnuAnmvCL0dwwCbAcOKUnbj4
         uCn1NyRieM3uWXrc3QKWxy7v2mUfA51FRJO+4tXCrmlzIG/5MXKvXRjKX04GDFQQJKfT
         25ZUHi/Sr0lZy/YgzYXZoo3nFk/V1ZqMb6J2EsIsrW43m4V5ai0StAEzmcD21bNgyrLr
         Ix3U8cr5zlqLuUupWEaA6+vRnbEYun4c01klLUXm6zuvL5Q/kkOI7Ssl1Ccb+vk2rdQV
         Q8jU+b3tkoaaT/p5TmHs8yztGugm5bDcZtPtd76YWTpxjbogxm9/mI+npPQeaflbu2BP
         V/QA==
X-Forwarded-Encrypted: i=1; AJvYcCXViPE7gA65JFPFbmdnAiIFwHa34BFGKe/EKTo47fleqONz97x+mFOyKw+xd4lp5fs9vLkY128nP4DYXqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GNJE3c6yEU+4fgpzYFXEQCYRDwVIP6gf44Z0YT2z1WmxtvR4
	f7ANBGN1iOwsk67KW7SY1RGl/e6bLdWLyf4Vnbft1I9Q7p4d7ASsqhpEsu+WYCo=
X-Google-Smtp-Source: AGHT+IHp+NhjW4PX/mPJqKBq2KEi3a8zecCL6S3kVYpsYCxT3jOueJVqY771ut2JA1TGcENNWw+qOg==
X-Received: by 2002:a05:6512:230f:b0:530:c212:4a5a with SMTP id 2adb3069b0e04-536587b424bmr9836628e87.22.1726045147412;
        Wed, 11 Sep 2024 01:59:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903b10sm1547415e87.189.2024.09.11.01.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:59:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:59:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>
Subject: Re: [PATCH RFC v2] soc: qcom: llcc: Use designated initializers for
 LLC settings
Message-ID: <6zxji5toy6mfqvjkq5qyj5m6znmjve6wxh74dxeetj3ragr5r3@dycjj3ihcw22>
References: <20240910-topic-llcc_unwrap-v2-1-f0487c983373@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-topic-llcc_unwrap-v2-1-f0487c983373@quicinc.com>

On Tue, Sep 10, 2024 at 05:01:39PM GMT, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> The current way of storing the configuration is very much
> unmaintainable. Convert the data to use designated initializers to make
> it easier both to understand and add/update the slice configuration
> data.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
> I put this as RFC, since this makes the file gia-nor-mous.. However, I
> don't think it's feasible to try and update these values based on
> available information if the developer needs to count commas in the C89
> notation..
> ---
> Changes in v2:
> - Drop parameters that default to = 0 / = false (except .cache_mode, TBD)
> - Fix up 8150 GPUHTW being out of style
> - Trim leading zeroes in hex, make all hex uniformly lowercase
> - Link to v1: https://lore.kernel.org/r/20240907-topic-llcc_unwrap-v1-1-cc6479a15ac3@quicinc.com
> ---
>  drivers/soc/qcom/llcc-qcom.c | 2644 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 2375 insertions(+), 269 deletions(-)
> 

Manually checked several, but not all table entries.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

