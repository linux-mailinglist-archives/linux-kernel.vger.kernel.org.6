Return-Path: <linux-kernel+bounces-269255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD02942FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228431F2AE30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A141B143A;
	Wed, 31 Jul 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yt8sB5js"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B81B1431
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431566; cv=none; b=cAanksqqapJrIstoB7cgTXi1s0H6x9ZnkCJbVhoznpEHBc48xpR1aZNClKvVySSZ8+Hp3V1w7+0MnkCY8Qa9qcvvXvp/cjyEEt6//L14kXLaNz5YSOOYNHg4A1c5Xqne+UJu/MMcbRYBqhUlXnyQJPPpMAXHZNz0/lQSYyW4en0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431566; c=relaxed/simple;
	bh=qFPHgeIMW1gfQ9EjXLEKz2PkwY5EiqpBjeWefyfIctU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCQElaWSHoDV5IPBYZ/iBQeg/9epuP75hnkFI4lkKMS7JAZaq+p8SWOfg6H0t+8tuh9089KZAyyHTvqX8aignaSjqfsY2gUIK993CYor08j+seVvkBOcNp6f2K2iQHeUdtYj1FZ1b7/gxja2qNU0QK2Oc0uWlb2nVsDP0A4TXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yt8sB5js; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso9075777e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722431563; x=1723036363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3wPO5io9Fiq+8Cz2nYy2B8gHrLGSiZUTaKFQ+l1bhA=;
        b=Yt8sB5jsCdMQ2zGpQUEa9ZffF+2/jwj1xKezLZ6RpaKRZOIUtlX1PFuArG9tuhn2il
         4SAzu5lW0sq7JiaoHLR2+RJOtuFdlYeQRLU7IAX9tGtnGcBw2BVzTx41m7mAk2QQlMLE
         mRhzWfnTZgs31vrR85WtMUM2N1r9rNYkLxLYcNkRnJdSx0MUOZvdf5SOSZaHU786SmQS
         68lWYB9G5thMLzBgK+k/QR2J0wniKX86umPt+GvpHmzRbKbKvB7AESCe/2jrPn957YA/
         PNJAe/5INb1fLtJ8Fle5dJOEoSFr8SA95AQjalijWlT43RpX+XfXpqyBZcm7g3ACtEYF
         /Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431563; x=1723036363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3wPO5io9Fiq+8Cz2nYy2B8gHrLGSiZUTaKFQ+l1bhA=;
        b=XRVu8OmhXLuqWgno6SCOv9+NIdGGlKv1RsDmE8hHfU491G/tOsrcBsKpbhFShbnv7S
         UJPr8qMBCnf2su53trGuMDxnxm96GdbUa5m8V8KF7lBxyaympEwDySdrg+7X3vC3XtcC
         w2y9qea6uLJotRrCGPNIklfgU3JwFBPEqyB0ccO6OfAB0cRkIgfyFHhD74ZKC4I7n/Fp
         c2J+hNDkKDKi4NMwm4/6b5zh8Qwa4QM3KnoiyAzSwRL3HpPCumi1AXCF6iAcW9xXdREM
         myW5+9ge0cEAETHzRSE23h+oKbIsEx+nbdiD7ir8wNkkjqf42Mu6P0kBgVKQcCje56ZI
         Pi7A==
X-Forwarded-Encrypted: i=1; AJvYcCWvdOvogmSVjPPP4PpnNOAtFloWj+gqH7d1TFBZBLQ8SK8WXY1omWOrCaYzDUtSuGilG+1oH7eBTiUmPiUx7rLooYiCkSDXMQRbt89s
X-Gm-Message-State: AOJu0YyuhHX4cX4kR9/omW6CGJn43/+pvdlnccDSS4olPwufucjhpUiu
	Z9cIQP/A9aw+TtyE/UZ8dCxNM+I5Zs8ojyqF2MY8qPp3mUhvDkvmtjyMUIef1cA=
X-Google-Smtp-Source: AGHT+IF8UOb4KQI/0UVDYgflYuJp0DmJs4aWutYRmDvRhXlkI1Lu/RNu43VC91/zjHYdf/h1W/xzPQ==
X-Received: by 2002:ac2:5968:0:b0:52f:d090:6dae with SMTP id 2adb3069b0e04-5309b2ce519mr9332247e87.52.1722431562460;
        Wed, 31 Jul 2024 06:12:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c0839bsm2223322e87.168.2024.07.31.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:12:41 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:12:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH V3 2/8] clk: qcom: clk-alpha-pll: Fix the trion pll
 postdiv set rate API
Message-ID: <uc5imfadtdq4krsht6t4fbzdyglbzhlivdbw5rxgvwjft3qthl@uibz2cbw3x3o>
References: <20240731062916.2680823-1-quic_skakitap@quicinc.com>
 <20240731062916.2680823-3-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-3-quic_skakitap@quicinc.com>

On Wed, Jul 31, 2024 at 11:59:10AM GMT, Satya Priya Kakitapalli wrote:
> Correct the pll postdiv shift used in clk_trion_pll_postdiv_set_rate
> API. The shift value is not same for different types of plls and
> should be taken from the pll's .post_div_shift member.
> 
> Fixes: 548a909597d5 ("clk: qcom: clk-alpha-pll: Add support for Trion PLLs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

