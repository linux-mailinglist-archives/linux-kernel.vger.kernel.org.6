Return-Path: <linux-kernel+bounces-308458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC4965D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7A51C22AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCB171658;
	Fri, 30 Aug 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHZ4A2rD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2713A261
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010870; cv=none; b=dpEb0VdLYtu6Oj6YjoLr00gkCy42Ww+Wb78+pSxsgXQf3iBzqyYjPuW8LLlWe0A22PZ8cpixZvXufrghd87qHNWYsI6erXl7HVRht8z2YBlBlWFYb+XM5OVCFQIBtHe3mWPxTudRcvLZmEYFGX+fzz3gnXk2jD1ktkMbwEM7MlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010870; c=relaxed/simple;
	bh=COuL6iLBN27aS3GwFVVyjvVjhlNmkAK9/WIujnPqLCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3ntybQStGQCJrQmcjbsbbcigm+HzpuhQoERdjIOY93VgB3JgdqU/tSEXuz6dTgf2nCByhOg+D5a53zvf/En+PguY1PX/ijPQx7oQvu/dpmrfoOH5xz3kv8LCZ7YbihUzn3RTxPtq4dmtagMOg2NYN4mDLWgAPUzIwvjIxXViww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHZ4A2rD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533496017f8so2126459e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725010867; x=1725615667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2wAp3xJfvCQWFeQG2kIUuqsYSHGV2K2UZI9+s5ufnc=;
        b=JHZ4A2rDoL2WwW9fjzFCxx0JTSrmyP/wbKt6Dso3+JRgmBD0sGBcLEr8exXjDc4phL
         8bzBp9aoX/EFpE4uq3lrBYmS7GFtjVL0/XoI21J09LkBLw3IQFyeqlVIlO5HeAt5jSIa
         5PYWw3bycQ2U5+T1l7zjnHjPrBwNdFnHT4xMBQoCBzGiZItxwZjXh99CJBFGdU60V7bZ
         JkgIur5ndZTckUhQIGlYhnaZC4BiLzg0TOiTydLqItWfOKbpdZfc1GvuVip1JX/Unw9x
         i/aRxRUFyi/s+GEyq47l9Hty4vLLdYOIeipJOj7dNdymWNGb4cJrWO0K6eXK1p18mClO
         2ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010867; x=1725615667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2wAp3xJfvCQWFeQG2kIUuqsYSHGV2K2UZI9+s5ufnc=;
        b=M9Z932zMipIdN4aMCQnQZn+m5uo2OqKWg+sOBBrMWyQTJ8/w/KHa7GfuMsW4VUbHNF
         hwKnWHO8NLQ1GCofL718uQtDxleymR+Oeau65o/Mqa+EwaF4J+yv0QmCXbRrjDbD5B9X
         kwBhJ9bfnD/kB9YWxbQx0f2rZYa4QoxFmlzezcfywlmzUDqRIoihZkYICgoiBSpmd2dQ
         TMaMGtdibBE9O2vpcD/+efl2pfjUN0iHqFytXuR7xpEEJRps3YyO9XPNTsYRLbHaiZxc
         vpZm24Tx8BopqytMXc6BxZPN6UbTrZztZNFBvO+TvTZabDy4sRYj82KjxQ0UQHSsOttv
         Fh1w==
X-Forwarded-Encrypted: i=1; AJvYcCXCa9k+rEUyUJmTWkF7toybJ4l/4gdxgg04PMNTuZyUH9tJTXCOFrlNQyksIN9uuyY06QIGPl1MmkSozPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXamkthAF/Tox0muIxZkbjzlFWMebY7b08Tx+84RSE5MKYLBm
	jsPtjs456uZ0s+7qJpgALvpSS5lCaX2BRZUSdErj8bDksE2bNDaI+T4bJJUEa3s=
X-Google-Smtp-Source: AGHT+IGT7LIpysnNQIzwddwIOLZDD+RA8Y+gOPOv5OU4BlFShN6qC8hstT9A24BItY5SGW0e6QECzQ==
X-Received: by 2002:a05:6512:1282:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-53546b69245mr867822e87.38.1725010866552;
        Fri, 30 Aug 2024 02:41:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084cbfesm516128e87.247.2024.08.30.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:41:06 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:41:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sm8650: Don't use shared clk_ops for QUPs
Message-ID: <mweaa33lovczlyc2v46lquuhuwkdtsfnhmqhwgapm7nhvyb5iq@264qcs2z4jem>
References: <20240829-topic-sm8650-upstream-fix-qup-clk-rcg-shared-v1-1-7ecdbc672187@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-topic-sm8650-upstream-fix-qup-clk-rcg-shared-v1-1-7ecdbc672187@linaro.org>

On Thu, Aug 29, 2024 at 10:44:30AM GMT, Neil Armstrong wrote:
> The QUPs aren't shared in a way that requires parking the RCG at an
> always on parent in case some other entity turns on the clk. The
> hardware is capable of setting a new frequency itself with the DFS mode,
> so parking is unnecessary. Furthermore, there aren't any GDSCs for these
> devices, so there isn't a possibility of the GDSC turning on the clks
> for housekeeping purposes.
> 
> Like for the SM8550 GCC QUP clocks at [1], do not use shared clk_ops for QUPs.
> 
> [1] https://lore.kernel.org/all/20240827231237.1014813-3-swboyd@chromium.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sm8650.c | 56 +++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

