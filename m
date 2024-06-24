Return-Path: <linux-kernel+bounces-227482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D009151D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D76B1F22FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0919DF52;
	Mon, 24 Jun 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5HhcE4r"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AC19DF4D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242128; cv=none; b=UKxQvNiKwLgItCd/SdtyZeTc32Ehop1EVZr1rvWYMr9Eraadc69ZEECj1Zl+WBwYE6D3mOslobXR/nkbJmND7K5yslpXOgz6it6xxliOnyaL1ZwPgxoMYIbo1+Ga8itu7pjTmdUyRvManLueJ35GiUUGdqcOt0o5wBeVIYSB9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242128; c=relaxed/simple;
	bh=GAsy1hrmvNMsy+al1UKDpEJrsqmugZd4+qdldQYyXSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgRAkBsTbaeVwbYWXb4gGu5255NuINf27LxLzrKCMIepo96F0+thJSBSKfFbN/yoDceXkA0YlBhwDjrCJen0r+8pEK8rU9GnR+iycFcUzw82CDZySGF3oVp+WuBrPqyPR1Hrw6l66XgDOVvcszBnFmYtn+IbamUcPoRUcr/G2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5HhcE4r; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd628f21cso3488291e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719242124; x=1719846924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gDB4H9hEb1ddKk08sFFh7SUVmxRRs8hMx/zYwxqCrw=;
        b=D5HhcE4rUbkgNTrPuWdRxMLlER6URmvc3dLoO6U6qqBUQwnNhdG7kSwtyAt/NQhF1C
         QExawB1ot4Y2idWTFDFCKFGRdFZuJgiuIaE9ztLe4ypsdUIjltLvofV3oCz0uCoacJLF
         ml9Tp0ex1SJJtM7P+KA0N+Kqe7N1OJkwo0WzqDDrUz+0ewnxMvn40QnIAzK1Kqa3+aJL
         M2Ki/dSRqgfgf/0qlhga0fPGrnQCHs1f2ec/omb3UaH1VXN3/Z34uVVvznJAdT3XZ5MR
         wvUGILo5/ZhJhPT8P0eK2jYrwozzp9KjKg7U4GcY/8FFN2t8Hn04QRr2ONMH64VitNtj
         HwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242124; x=1719846924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gDB4H9hEb1ddKk08sFFh7SUVmxRRs8hMx/zYwxqCrw=;
        b=UG6RVHx5K3pC4ZGkb2+ScxMdNC5qRsLBCzmtS2tNv1Z30EMEKbMCcxA6DeXhKpFSWf
         5tQhGlAj6kIFGnWy8Pa+RHQAwZQUpzJwqMP7mwDT2zXCIQSolq7fa3O9DO3Rx/WoY8CF
         qydYmnZZwRk6RPqZ1YreL9P0grs8cLOenyCmnop1XeRT3NUPasRNrxGX89GgHRS8qzDE
         JvPn48wyNy0eiiqaOmxm8CToGM1kcucsZourIUTC9HGg0YpOhZpvRBa5oUHvYMr8tXVU
         wuGkLnVF3ajY4CSqxpvQ33q5hTvL+mbb9nST88G+5QruiSY7UYxo4LZOzuXjxGhhpGJD
         PHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUriL8GWYhDJFx/thVn50JONw715IYVxrN5JmEy8cvOBH+sf89yIC8iwWuqlzt8NEi1ruDYf8zCRw5iCXtmUQnImlrJPAJHBYx/9Smt
X-Gm-Message-State: AOJu0YxPqfxEXPTAsSRZuHLs9nnxkHczAg127gNXWGNBF2CnDxO26Ckh
	18G7XhLm3bR5qfN4VZrEKS0WzWiX8y3shh38yx04K7se4a3N8Lu/FznHI3acvNw=
X-Google-Smtp-Source: AGHT+IGewbbtNYBe9HGO4cnqDGWmxOyzFNvsNZLeojJsAjYmh08AcYDCbzTBurLxo6pTj/6Sf3tmPg==
X-Received: by 2002:a05:6512:55c:b0:52c:d9c6:f934 with SMTP id 2adb3069b0e04-52ce18356e5mr2814162e87.18.1719242124247;
        Mon, 24 Jun 2024 08:15:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b46ecsm1004471e87.10.2024.06.24.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:15:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 18:15:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: x1e80100: Add soundwire
 controller resets
Message-ID: <2lnbogqx2mxgyn47vgnbp4ameydjq6ajuauklgzslmfinpmnk5@ez2sz3nyd3wj>
References: <20240624-x1e-swr-reset-v2-0-8bc677fcfa64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-x1e-swr-reset-v2-0-8bc677fcfa64@linaro.org>

On Mon, Jun 24, 2024 at 02:32:35PM GMT, Srinivas Kandagatla wrote:
> Soundwire resets are missing in the existing dts, add resets for all the 4
> instances of Soundwire controllers (WSA, WSA2, RX, TX).
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes in v2:
> - fixed dt bindings.
> - Link to v1: https://lore.kernel.org/r/20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org

Thanks!

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

