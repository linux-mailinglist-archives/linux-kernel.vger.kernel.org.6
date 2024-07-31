Return-Path: <linux-kernel+bounces-269246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08B942FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED03AB23FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B561B0124;
	Wed, 31 Jul 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQFsD9Zt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F41AE871
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431254; cv=none; b=YuZTYMyl7sd+h0/lmVyNllCHpf8tuHeTdXJPW286lBHltIlETPGZuVzFXFSzOyo67BCmGu7f7ocVi4Gh4flB05DNgMxw3mI0k4NSv2SXHOojO92b7G7DAY6uAlN4kW7JheFnvmoylB5mMXSsqHJ7i0SydpqfiBZhNREa64Rpuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431254; c=relaxed/simple;
	bh=IDvKEAauQ3f3+B7eefwbOL3BPtdB6ke35T+ErE2pzzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIP42Vr2xDy6RFvUc8LQMXP0QJAJpcT3APLrDUcgKzYNJ6I/z/QwUkFc+S78bsOOo2IwvSGOvkjTpF6C1GHS++RJn6abIJXmkHehY/QFQaddUQDnhPm8hp7QkZkyc7l0vuVWGuOT45rPEPXBBQlQmfzirXBcRYB1a/CViHGLj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQFsD9Zt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so67565601fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722431250; x=1723036050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FoiQbEYmhBENH3LXyd3ATBiDIVMApuyh6s4DrTOE6Q=;
        b=RQFsD9Zt1YvBrlmC14yzZ/QbltZbO0diqdOVPreqk6el0P+rrY2L9bctyFnpp2+Bf+
         U43AA5u+7jNIOFrXNy+aodjWR4nUV8U8zE29N/IweUOYg4xNcDhho2lhXljJdEgBWP67
         14wHITVrBCM91Vs0M4a7M7ov43iBg+XtG8GMkyT90Iz9j8f7ew+J85qkmMU4b1dAUNm6
         RtksoVie4tfXMdpLJzJrS/mwKqAgDgkYhWecFpc8MIhBOjnwskb1KBHHJ4iHGlWxBGuG
         8YjgzoX63qROVEDm5wB49fWO58D1M2lvQN+rw1HIFBbKJWju32y1qlX+t/2ocXGLXgDC
         MtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431250; x=1723036050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FoiQbEYmhBENH3LXyd3ATBiDIVMApuyh6s4DrTOE6Q=;
        b=gfrbqQiF/ZpH3STmb0CZpe70/zGewQ/A9r/sefO0+Av+6LmS3GtRzQnDeuQ/lSERJ6
         PPflkUSwVKGZaovp9ij5ruXxuPCWP5n1Iz0WkZt8aI12iv9fIUZM6q/xk5nj3eqsoAzT
         5Y1elihbSoSeTSsIRL5q4l3y09PPQC9zJvmDYFwq/a/R48Ad/oN/hgAlBqeKt7Rn6Qzd
         fCm2LgFzq9NNKk4Ascinq8fdh8YlRRNy3VCSTU/VSXlwWaNsS0xqq0S0w8zhjWDioKNh
         Si2IRt4hL9LTwaVyTdrEILLaShVqhWxwfYesdz/5NIBUmT1PoY/4znRZWD91EXLa0Wem
         vL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdPRnAAkdNsEwzyfWxC4bxoYt/+IgSS8ElQb75qumSnzYEQ/x3H6d0a90LKmR6bom5h75MkaCf1pGVPgeWMLST4RL2F9OhMch/MCrR
X-Gm-Message-State: AOJu0YzbI3iLq1lXI8ChSTtoR5QaY5DLWcEOcbmLiZ8HjENwsoiljy4I
	k0EXibjje86mpVbn7+577p7H5UqrfqOOpod0auxubiavoLZN/esRNNewHdk1yiE=
X-Google-Smtp-Source: AGHT+IHFGuIslHNtb6tITJa8SbCZaWaHCKmfmiJMpdSGO3yjlULlpXbI2CAqFvwKxhAIv4SP8SdgkA==
X-Received: by 2002:a05:6512:2032:b0:52d:b150:b9b3 with SMTP id 2adb3069b0e04-5309b2809c5mr8147947e87.32.1722431250588;
        Wed, 31 Jul 2024 06:07:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530aa08dab1sm649447e87.13.2024.07.31.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:07:30 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:07:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 2/7] clk: qcom: gcc-sc8180x: Add missing USB MP resets
Message-ID: <z4lbpgfjmkslylflolm6nxqye5gsgbzn5yn2lqvqlngyc6y5bt@s6uovsadcxe5>
References: <20240730-sc8180x-usb-mp-v2-0-a7dc4265b553@quicinc.com>
 <20240730-sc8180x-usb-mp-v2-2-a7dc4265b553@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-sc8180x-usb-mp-v2-2-a7dc4265b553@quicinc.com>

On Tue, Jul 30, 2024 at 08:24:39PM GMT, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The USB multiport controller needs a few additional resets, add these to
> the driver.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-sc8180x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

