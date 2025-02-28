Return-Path: <linux-kernel+bounces-539582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB3A4A60F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86F5189C220
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE901DE3C2;
	Fri, 28 Feb 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XO/Y1l1p"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8E1DC05F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782336; cv=none; b=Afn/d9u3hsAP3PJooTdlwrKE/xEjsVz2yp6cbguLd6Bos+pbt5MDKTsLWi3PV3Dg5d+/xw1Ln5BBhClLITO31CKUZMd3iKNLEhEqyroyCrbpeBJvgxNkcYmFy9iqtP9voFyc+ylioJYunfn9HLo6nCS042k8ghP/+aLLvjPZoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782336; c=relaxed/simple;
	bh=qxmpwgVoph1AElRgemrOMCNkM0UQR+WMiPiIC7BqPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnMQpfeXm8n2pIK74zuiBqQgjPKmIS1pqVSifBgNFQnK6NFUQsKvEuubWkiUQa1w/LVXrKK+B7JSBag6VB56zwajz0R8AJiHwfvYafCBVGC9ASCNFgkhnwiSqTnzQkctPclxHlK7PEEiS7IoWHXmlOMfoMv23gXZm5+VV0l3wcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XO/Y1l1p; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30b909f0629so15176411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740782331; x=1741387131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVLtEZWmEyfafXYzQagUTDqOcJoOxE4zFmdp+hx7MFI=;
        b=XO/Y1l1px9lPYSETYZ0dht9OL8qhdlVxau0kP6KT0GhMKh83TytQeVT5xvM8R5Jb6u
         SWjfhD9XmY+W0rFy2kZgd3KJbHJe/1gcRshO1fae8ajFJrAImeN9rt5KyMR/Fw5UmSMm
         Unu5u6aJdDV9qBB9s/MeVFAkEmRNbF7VcJZc3Bb10NNAkZpET1xgl5isg9uB9gz0QiXf
         lUv57wxZ1+j53BSaRN7W37/1/7mUUcL9HoSoQB3KvyxRDGY6Odk5aEdRhHOSftCRNkXd
         6IXf1qtw9wpqZMOKNjx7i9aVo/QCWPxvPJHsg9TPlZZDGd4WpvGc14+joUEy0ySM0+rz
         5PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782331; x=1741387131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVLtEZWmEyfafXYzQagUTDqOcJoOxE4zFmdp+hx7MFI=;
        b=p+BQf1LFRPjd3OJ8EUDN6/tO8+S2tsXOAAtzgUjQRj+IMNVCl0YdbF4m1pvIENOcmQ
         BZ+lXLfRxtvSBdIuhi7WxxPkuPqFeCZTGSHlttklKGAsgoEHJIiZratdW1p7Bfx63J67
         b0JQbjA4y2CveJ/XVON4UkaoR5e5YHmMpHU8VrlN9boI3Dpt0lNKZFEu4COVGZrQYmD+
         uWAzP9gEiiniVYfxO8Eh4lGA97RQWiURkVRMxH0u6kqa5z64pbgIQ5AEXrn69ihyKtTo
         fpTsjGlNDpDc5StunaADdC/ubsCsdY0ikH5gPZbu7KQR13LdcsyGetqwn9G8lmygo2FW
         QOEw==
X-Forwarded-Encrypted: i=1; AJvYcCXVqDaaECxkqAiQPd/19Q1XJ08jFmwv8LjRpIUe7eawHgUwR7V7RZli0iqh3vEPHUIPq5VeCv0oJ/y9hqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiMpAXfq2ZeEkGjrTXDI9an27FWrnrMjesWQkWza7ewaUyIDu
	2U/BWdbnRLjdW2U0IpoDAm6RkXOINAcB/GNnXZdIcbBq9yBqb5fKrGmFaIDVKG0=
X-Gm-Gg: ASbGncu+thzLuHIwFsKEmTe6rKdjD14nhtbfjl2ZthbEJ5dbaecQ521TAopD67qHhG+
	kziiHdIRu1VdYZ1Nlrh2q/W0IsrlISGOoQbUzL+2rqk4Wv1WvmEFZtkYjcTWffYIfC3nfEUbC5a
	lbyfSVyHUwOuw7eMG5UBOFtpt9OSCcWFQjN3M0fzOig2he/AgGa63EcsunTst1/Th2taj3gZfBa
	tZEXm2yyBjJjNYUW2IXAp9LYGNgLVtoxmyHGdPKuV426hCevxm52hNnosYLqmDZ/mgL/Aat3Uyj
	zry8ILslesh89ab8iflXqjwuIheg96iuwzJzjnOCHbRww/IZoZ33+2N47evVIsOPIhQmz99ZR1w
	J12RlEg==
X-Google-Smtp-Source: AGHT+IG9mAgP7zVwIktUs/UBARKaqjA/kl0Vs6vq5xs6d+5Gc5O4KLLVSbymtcmIIJXCsZL/fle75A==
X-Received: by 2002:a05:6512:128e:b0:545:2474:2c9b with SMTP id 2adb3069b0e04-5494c35e0camr2328617e87.22.1740782331571;
        Fri, 28 Feb 2025 14:38:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b1286sm630135e87.158.2025.02.28.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:38:50 -0800 (PST)
Date: Sat, 1 Mar 2025 00:38:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: qcom: Constify 'struct qcom_cc_desc'
Message-ID: <jzqxj6b5brslayz6crvgenjiynlkagszdve3w5ablm5yyimmtv@pf3slvisucbv>
References: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>

On Fri, Feb 28, 2025 at 03:59:37PM +0100, Krzysztof Kozlowski wrote:
> Make static 'struct qcom_cc_desc' const.

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (4):
>       clk: qcom: camcc: Constify 'struct qcom_cc_desc'
>       clk: qcom: dispcc: Constify 'struct qcom_cc_desc'
>       clk: qcom: gpucc: Constify 'struct qcom_cc_desc'
>       clk: qcom: videocc: Constify 'struct qcom_cc_desc'
> 
>  drivers/clk/qcom/camcc-sa8775p.c   | 2 +-
>  drivers/clk/qcom/camcc-sc8280xp.c  | 2 +-
>  drivers/clk/qcom/camcc-sm4450.c    | 2 +-
>  drivers/clk/qcom/camcc-sm8150.c    | 2 +-
>  drivers/clk/qcom/camcc-sm8550.c    | 2 +-
>  drivers/clk/qcom/camcc-sm8650.c    | 2 +-
>  drivers/clk/qcom/dispcc-sc8280xp.c | 4 ++--
>  drivers/clk/qcom/dispcc-sm4450.c   | 2 +-
>  drivers/clk/qcom/dispcc-sm8450.c   | 2 +-
>  drivers/clk/qcom/dispcc-sm8550.c   | 2 +-
>  drivers/clk/qcom/dispcc-sm8750.c   | 2 +-
>  drivers/clk/qcom/dispcc0-sa8775p.c | 2 +-
>  drivers/clk/qcom/dispcc1-sa8775p.c | 2 +-
>  drivers/clk/qcom/gpucc-sc8280xp.c  | 2 +-
>  drivers/clk/qcom/gpucc-x1p42100.c  | 2 +-
>  drivers/clk/qcom/videocc-sa8775p.c | 2 +-
>  drivers/clk/qcom/videocc-sm8350.c  | 2 +-
>  drivers/clk/qcom/videocc-sm8450.c  | 2 +-
>  drivers/clk/qcom/videocc-sm8550.c  | 2 +-
>  19 files changed, 20 insertions(+), 20 deletions(-)
> ---
> base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
> change-id: 20250228-clk-qcom-const-4218c42710a9
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

-- 
With best wishes
Dmitry

