Return-Path: <linux-kernel+bounces-306475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F7963F81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22231F2585F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596EC18CC00;
	Thu, 29 Aug 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVn5v+lC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B218C91E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922431; cv=none; b=lLfVmTRTwqPAj50onarIhe6pZFXEmh9E5onjWNZyOziNRIqIvsN5uTEox1ew1FswlEQywdDLayea/K75Er3vlkhL/8DJ7FUQieC+iJF1ilVSwfzC8sN/aTTaKwOTQuLW24OOQ7Wn9YZBK8s8kfuh7L0g/kwBq7FmxpsC/lDjBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922431; c=relaxed/simple;
	bh=XeuJeG4GlP5VP7OfWamaC3athmVgy5BaQ8VsmnFI3V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB67Vpb8IumW4y0bCtJ0H5UB4e52pLbMtoFDmGxjdMCDkIy9cdpEbhgFFHDUl2MA/0jaRN74TUm3cIwFbMEVFop3zqo4JiQwfSi6oDLYZ4hkWpDeQrp+g5eUkJLE+VpDtuuj6RPtZ6SvzileUq7YZg1nRe0MJaKyAgUm+8fdyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVn5v+lC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f4f505118fso5034631fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922428; x=1725527228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFv9jZc3rIyBzw1D2zjDZIlm2tpMb3xxpVsMhW3WMK0=;
        b=sVn5v+lCZ0f07zAldEv5EUS3QtpXBCwvMOb7KYim1FZoxOHpVlqu96w9AwuKsoW5cf
         VuwMe1hAGsfL/BMUTdFtxvKx5hnpSOkhiDRed33hYdAasgWcgas9WGP8cQBXzkACYbNw
         /qZV2bK6c1A+9DlA9dxpSE7An95bKEsPfrK8PhlyST/KYKe2f0SYjR5y9tEDaf5Gx4Hd
         VY7wSCLdbezKlB9nrO0ThSdid6n52XqVK+qYQbsv7j+lS0vlOhvOYThQQc3X6qVdO1w4
         v/OWTcSHIKZd+QKIUd56Ez67+evTv5ee2zqhPQKqxwpj8Z/NR8cpZZSNT5/GZG/6qZ6j
         SFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922428; x=1725527228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFv9jZc3rIyBzw1D2zjDZIlm2tpMb3xxpVsMhW3WMK0=;
        b=agb/F23S35+XwGLb19dCYidsNE/TXTFDZLexwq6axWYSBXJYPOT9HqzbYE8Q8bAYad
         HwiPPGfRYvEFAvrKap2aieLZCxE1Mvh2zjxMQjLd3xYXhTL32K2IKlWwG5f4Tir123rC
         qu3/A5S/bqv6c1IdHh31uzYuZdqdX6hoROQGvEzxXpsndsDQB2fRtOylL2HyV65Ja0N7
         mX/2K5+WT/oFpT8giOjldLzdxBxzEZrYg1iSb/0OhMuDji88j2FwqA/WlMZ3ttEoqFhr
         rtSTL/a+li+kmfW3xnJ3+n+iOqsO9SMv3wDwpBs+JcmtY9i1Sg8tkxZJrFI7IRziArfL
         4J2g==
X-Forwarded-Encrypted: i=1; AJvYcCWNx1yh/KSLKwM7JbtAbbVajJvmHo79jnWRtdLQjyuzmm4KWXPUntrRLvsN+BL8+tX3XxO8CCQ2A+mwr1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXQYyGDEBCGRtbi7XuJ3SkVWwvH287j1/4sOHHrYnG5iOy6AV
	5EuB+Nkhf/QJKIVRZ74ZKM4AbvHn7Dk32auIJg8FRi948OKIl+byZNmbv/a8HwQ=
X-Google-Smtp-Source: AGHT+IHvicgGOXiLh4BxZRbXWuqG3WKsUO/eEDWbzWD3twdUlFJJw8V09nxfGE7Fzv8O9RiAkSJDRw==
X-Received: by 2002:a2e:f09:0:b0:2f3:f7cf:2f01 with SMTP id 38308e7fff4ca-2f610552f84mr16934711fa.41.1724922427679;
        Thu, 29 Aug 2024 02:07:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed17f2sm1253091fa.17.2024.08.29.02.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:07:07 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:07:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3] clk: qcom: Fix error checking for
 devm_clk_hw_get_clk()
Message-ID: <mp7lrhoz64wg46u2lxlr73r2hcwpurnwqha53q6cyxtgfu56ae@dmoqbtu2fnsc>
References: <20240827025252.3512746-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025252.3512746-1-yanzhen@vivo.com>

On Tue, Aug 27, 2024 at 10:52:52AM GMT, Yan Zhen wrote:
> The devm_clk_hw_get_clk() function returns error pointers.
> It never returns NULL.  Update the check accordingly.
> 
> Fixes: 8737ec830ee3 ("clk: qcom: common: Add interconnect clocks support")'
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
> 
> Changes in v3:
> - Providing a "fixes" tag blaming the commit.
> 
>  drivers/clk/qcom/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

