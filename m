Return-Path: <linux-kernel+bounces-280750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8B94CE99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4992282A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891151922E3;
	Fri,  9 Aug 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NewNTG3K"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6E1922C7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199280; cv=none; b=VXJJ6myK0VGlDawilcKp0FfsXhmzGCksLDcrGrAvSwGHYG89K9FUsZHdL5AB7UFBEWI1A7UjFNaVy/IxQJWY3tA7bbh3YkfFrUMYUxvmXr+QuDV9d/dh52Sv1NFAd8kOx7+IhsU0YyIMSw8vhTIgVmxWyy3548a22m6eoHygb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199280; c=relaxed/simple;
	bh=mciDyR6DAV+t2Evh9AfOB6T8709XeXKN989YLH9vaxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIXs7sSdDzv12g/xyts+MHPy1A4oYljum+m+kXRVBN+ElY1zRkVMQ92RjmeVkPbuwY5pXuoV0JT+TDrtTdFoLDutqbWkNEZLdeBUqHA8rRWww5Es5gjDCWi7N9wHCCmI2+1JtRyNeVsDlM/MIqLtLVSokxbBUDibTDfuNG/6VT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NewNTG3K; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so2561057e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723199277; x=1723804077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq5WuounRhDgOPhDOrEXdyNS99LjTUBlFL3IccwVggc=;
        b=NewNTG3Krd9j1LDsR9r9d7SmqaNP4390FFmBbmQmfIhRmKHCBQXU9SP+ergn4I/K9p
         K74Lrdh1Qexa4cCaYgtAG9u0Ezi3ZWO1zsJBAnnkUA7dTmWu8ZStG4Zc4L910JUC7DjO
         Qv6oexoiLIt8bF1DM0cZd7kQWei08Gx7l2ixl7uMg8M/DoTG56X8/ORbYBxOBlTDSklk
         TvukddLAu6ROfyHkZTv3wjDTNhYQkm6lEVQzn9O2/5rhgD/LbkK+uLnOis2jbUy2oIV4
         6p/H+IOm1d3tCAZ2rcCysGrZ/hHLDro9dHlAG0mXFyK80pxaXPySGdDDhRX3xYU/MIXz
         rDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723199277; x=1723804077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq5WuounRhDgOPhDOrEXdyNS99LjTUBlFL3IccwVggc=;
        b=dqM0+EDLYYimQYasQF2YCwpDU3WWJ7aJV95YpkJ/GydgldDWv+WAjn7DRuIbUPaK1j
         dsqM7UNTlfumWj9eP3W6FDZWpP9t4e3UL3ZbTm2qgIwEIT/rFpXV0xZHTAFElniGRmB5
         AOSBgWeFrx4tS5c/uqvWddOlg1Dhqq1K73Vq2WOyPQVmYOALdf11o39WNDZqpi3Bwaym
         SlXbER82DYGCV0UQOXIihaRDcjubK7fCeLpPrc/4NBROP7EWVfxD4x6B/3SHLaQON3lG
         w3/VEuhyfM3S+e3cL7opI9ni6LZABNlnye8rna4uGWMbu5KRSdwWdjmfKwovleQQ31FF
         72oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKCoo0AzHXBI3dYbY/pSGtjH3Fapc34PZE6zcI+sYBAJaS1VE2lglcxns6VTrzxq6lyWTYiGFCX6e9mwWT/3MPZ5nfeHZLjRnydN38
X-Gm-Message-State: AOJu0YzSAdnGjX9XkeDy1u8PVo9S0JfNYxVVokgcI33YNabbvcEUL3OH
	1IRmC6aDrv/fzadzbeGeXAiO7zi3kcvY6IXgDcDz+kR6rhXoVBO1HGUlBPmullo=
X-Google-Smtp-Source: AGHT+IFBNYCFbmOMoK+gCdRJEXf1i9wJyiJOeN25cq8clrsXLyDyrnuY3aNzE7llXL4REgI4fC8Vwg==
X-Received: by 2002:a05:6512:acc:b0:52e:fd84:cec0 with SMTP id 2adb3069b0e04-530eea5a11emr852782e87.52.1723199276902;
        Fri, 09 Aug 2024 03:27:56 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:8395:bc08:2fce:1f21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf869dsm1418437a12.1.2024.08.09.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 03:27:56 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:27:51 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <quic_kdybcio@quicinc.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add UART2
Message-ID: <ZrXvJ0Ay-2gFWB13@linaro.org>
References: <20240809-topic-sl7-v1-0-2090433d8dfc@quicinc.com>
 <20240809-topic-sl7-v1-3-2090433d8dfc@quicinc.com>
 <ZrXWPQVXfdL-QLnt@linaro.org>
 <b9b02bc4-1abd-4a56-bb6e-ac2c59e8f609@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b02bc4-1abd-4a56-bb6e-ac2c59e8f609@gmail.com>

On Fri, Aug 09, 2024 at 12:24:03PM +0200, Konrad Dybcio wrote:
> On 9.08.2024 10:41 AM, Stephan Gerhold wrote:
> > On Fri, Aug 09, 2024 at 03:43:22AM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> >>
> >> GENI SE2 within QUP0 is used as UART on some devices, describe it.
> >>
> >> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> >> ---
> 
> [...]
> 
> > 
> > Can you combine these into a single entry, i.e.
> > 
> > 				pins = "gpio8", "gpio9", "gpio10", "gpio11";
> > 
> > if they are all the same?
> 
> Keeping it as-is gives us
> 
> a) better hw description
> b) an easier ability to add a label and change e.g. the bias
> 

Ok, but it's inconsistent with what we have for qup_uart21_default right
now. I think you should either change that as well, or follow the same
pattern. :-)

Thanks,
Stephan

