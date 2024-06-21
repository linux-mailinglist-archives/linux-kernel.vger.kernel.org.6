Return-Path: <linux-kernel+bounces-225351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED1912F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB9028342E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371F17C224;
	Fri, 21 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtr8C8Sc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24917BB1F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005055; cv=none; b=B8+b984CrGzPo9FRbuk7nsrXL3eg4CO9F+mQN6ZlyGL/SDCQEXp3jRkSaFB0szsCWGXa5QzVx01e+gi1auzIpdFaFt0n5zfxYijqbygh1sDfXGMh4muvwI9pPrxlyLRlylVH7A8x1hjSKcbkKmEalQX0ClAvkTMg1TXQ4Z2KuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005055; c=relaxed/simple;
	bh=djuSz5mFeJ9nLAAgzN9ybob+36I/5RNb9wb3vaUsk4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvn0sHi6TLAYb9iS4ZIX+dgvSmclv+FFwmAmNunjr/musf9qFn27XCsQbbjAgvlQkEdydb1/whomTmAKl3Tx0AmZEif9aHn51/5mtEnaywRy39kwtrGkhFYhjdKt/hGSJREuhgJ6fd7jszl05PKys5skXihJpkuFoQrvcS4RHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtr8C8Sc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so26714961fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719005052; x=1719609852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7G/EKqKrp2dVyxr+tqg9qnQl8cmiv7vTyvsidd4q/0=;
        b=xtr8C8Sc0mYgc0rY8AkmgJ8MS57UnyDrbxZZG20KjF1S8dFbGl8/1yZx0BZQvC51vq
         F3pNheYncvetlTgGXP3WCGbj02xYfeKmLWBFXeyFCnexWnZOYz8WBBHvSuoQvn7g2ENq
         jtZ3Z9G0FJKD1QoIqJ3ibT3u6h7xQXAwCukBCKcdYWyOfIudD8u+S7VjQe++W+zDIYKF
         9FUIkR4y8kNq+12e6rLhdpile2c/KGU63JkfyVaHl9YqukB8qLZ5uTvbTv2jQhei0chf
         auB76JSU4BoJDbyr4jXHXwBHGWHwJ53u/HWJxJlM8qb/k7yVXN/GTayrqL5RlRWBXa9A
         YgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005052; x=1719609852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7G/EKqKrp2dVyxr+tqg9qnQl8cmiv7vTyvsidd4q/0=;
        b=wUr/ltYqRumPsMJAAoP1XaCr/1olFX2S5qs09b3TOqVD5525z5PygrUytQ3lIMHYbw
         IUkc98uhJCPPDJag27ksR5r9D3mlUYRLQp9AW/qWcX+25knxV///mr765h9IXbohwiZ2
         rXa+VgzBwVccde0bxjoRtO3svbhQayO7MlQVsDBOheC3YPdoSSu2cjk8uHtKdB0MJET9
         bhlyYuCDk0uMzISuZyJNZWbFuZQ5p0a8Htw1WLK2zsDjK5XUDZSsB+1JNksjXexVlCWS
         MJAtb/ev2j+ZWBlsCIPnIYR1NuoF26fUeaWDz1m8rQZwB5bdLVq80OFSGjP+vDO/3toE
         86nw==
X-Forwarded-Encrypted: i=1; AJvYcCUmyrb2wxRM7re58tws3Ij54VDvwxhmQqUPswQ3i1FgExVQevf28wbm6qU+YB8OJkrubN2YySSNXeFjQP3paAsIgrQ4gQ4q0SHFn6qE
X-Gm-Message-State: AOJu0Yw+QEs2kHjvDVMH68U9DUp43cxGzNKvZaBuZdAk+pZcazT+32dE
	R/IQbU7Bb9md99+qx7B8aL/0T+9dEvF2WmqM8xBzetAyOAlwHETJ2+EEar4ipZg=
X-Google-Smtp-Source: AGHT+IF8Z/Z3bLdGw7DYlN4GVLk29Ytc+7dRRyw60VtQPf9tmMYsoq5/am5uEr53+Gxt2n5uAi1Qig==
X-Received: by 2002:a2e:b2d1:0:b0:2ec:5540:4332 with SMTP id 38308e7fff4ca-2ec554043d1mr992491fa.0.1719005052412;
        Fri, 21 Jun 2024 14:24:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d708582sm2926301fa.32.2024.06.21.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:24:12 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:24:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: sboyd@kernel.org, andersson@kernel.org, bjorn.andersson@linaro.org, 
	david.brown@linaro.org, devicetree@vger.kernel.org, jassisinghbrar@gmail.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com, 
	robh@kernel.org, sricharan@codeaurora.org, gokulsri@codeaurora.org
Subject: Re: [PATCH v9 0/8] remoteproc: qcom: q6v5-wcss: Add support for
 secure pil
Message-ID: <62bf3lmbj3gf23x7rgmzhfa7gmpjmwelhspy66j326pudjqlqx@k6owdffe55mz>
References: <20240621114659.2958170-1-quic_gokulsri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621114659.2958170-1-quic_gokulsri@quicinc.com>

On Fri, Jun 21, 2024 at 05:16:51PM GMT, Gokul Sriram Palanisamy wrote:
> IPQ8074 needs support for secure pil as well.
> Also, currently only unified firmware is supported.
> IPQ8074 supports split firmware for q6 and m3, so
> adding support for that.
> 
> changes since v8:
>  - Rebased on top of Linux 6.10-rc4

Why do you have so many dead email addresses in you To/Cc lists?

> 
> Gokul Sriram Palanisamy (8):
>   remoteproc: qcom: Add PRNG proxy clock
>   remoteproc: qcom: Add secure PIL support
>   remoteproc: qcom: Add support for split q6 + m3 wlan firmware
>   remoteproc: qcom: Add ssr subdevice identifier
>   remoteproc: qcom: Update regmap offsets for halt register
>   dt-bindings: clock: qcom: Add reset for WCSSAON
>   clk: qcom: Add WCSSAON reset
>   arm64: dts: qcom: Enable Q6v5 WCSS for ipq8074 SoC
> 
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi        |  80 +++++++++
>  drivers/clk/qcom/gcc-ipq8074.c               |   1 +
>  drivers/remoteproc/qcom_q6v5_wcss.c          | 162 +++++++++++++++----
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h |   1 +
>  4 files changed, 212 insertions(+), 32 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

