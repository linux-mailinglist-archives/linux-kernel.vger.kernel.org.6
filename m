Return-Path: <linux-kernel+bounces-410065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B89C9616
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6E92832BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86F1B21A4;
	Thu, 14 Nov 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObqjKuxV"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EA1AC428;
	Thu, 14 Nov 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626987; cv=none; b=G+XHL46AZCXzZaQa8K8YoiwmrRi7wWYqMD1zBL+IadzHE4ZsyNwql/RD6iL4h981BA4iJeML2jwgqzX6pDO++WgLvbtoNa6kxVQRAxxEH3ZA92KmdyiyUoxAf4Rp2Ev2lSV+xph5Wd/ovMJ5eRUt/h/VEhZZgwlOdwpusUWwsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626987; c=relaxed/simple;
	bh=pKLRaSxaONbmL45vOqmcxWRIA6nXfdyhWf14p2Tb+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbr0PCZvPvfUVnapg368oNksBfkd8c3QBGZoH/C9VYs7EVmiwKIVDURGx9ki2pfvMznltWFJvF6oss2z0KwGsTEK3ZGRRtJ22ui7RZRb94JNXz3Gk9Qj1kORyFMvNLdZHJYLDaEfYRg9vu5GfSm4TuFNpf3kD0qnkeQjxyaf3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObqjKuxV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b154f71885so76133685a.0;
        Thu, 14 Nov 2024 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731626985; x=1732231785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiQkiZgzW+58bngcliKx41njiz5MtLbQoXDSfwxNgiQ=;
        b=ObqjKuxVwCfWBXdV3rpIyt8zK2kbDmevEhLFXFb4uPUSRQU3SLQCiArtbuv53m3lSd
         9kpFoFieCWHzPgiHlSySSx9zavrir7otTnDPVW8Vve5fnYrqWnHFy4XYPLgurQUeGi46
         L7vToyCEbn48hTyuCNm+IXU79h3ljiZcar9lCfgZp6aXIOxT0ynirP5LPstElwtp57Td
         MhJm8HRnn7q1hu2ixPXabZ/Vw91OEXds8Xhp30DGTw2PyE1PDeaDXZOMDkA2+gr03HRy
         rYFQnQZFkQf8a6yYjeiHd7PTmutNBo5P6bnMVvSIpczL60mIRVirTeZtcSdct29rIVFP
         FlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626985; x=1732231785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiQkiZgzW+58bngcliKx41njiz5MtLbQoXDSfwxNgiQ=;
        b=SHvn0ySL3pXgTDDxwDaNCrZKakyEEIfminqniY9tfSNcU/UtPIV2DU9Ah46ugKTw0Y
         0uGXuhgJMqd2HyaD2edytzFInwmQkcsT1kETMGwZmNaJE7FPYJmF4XrI403v2TTymIWE
         fOQtrj+FIqio/AdjGv4LrZB8MCfpyBI5z/PZm2LMo94KBOuVQNVQJKYdjQnEPToeclOB
         Wsv3L37JUNE4dg5cu2okM9DKlPWfwUv8LNcq2Nkz36pl7b/H1yIRWj+IPDSMVGlt/vrM
         oBlPCCKsr9U+w83xtC7QWmZLrDJQxuPqcx3BX1DyEtFDPHonvjFDzEiTSxJHh6TU1Emv
         L6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy64wFLo69UMCSSZwMoc3roLHsYodrKXJKXZak7h+KfA95tnMzeFNMCcOECfMt3TyNpdWSHsivA1XCL9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjO6lLz7Pp9gSNAzJgpYc+D/KcNxc3KGB1ODgKZ6o5g2kphn0
	ZAuqLMVYxSCvk3eSJqYCXq0yOjtTzLWK3Moaq5bDwSTQM56J90KD
X-Google-Smtp-Source: AGHT+IHzMx8vkvg7GvLTlNcx5cHgsCtjsbKTELbV6QeFLYkn2uWFGP9dCRaS6jDPuLkGCurEojIOYQ==
X-Received: by 2002:a05:620a:1a91:b0:7b1:572a:cd27 with SMTP id af79cd13be357-7b3622cef0dmr93130685a.18.1731626984809;
        Thu, 14 Nov 2024 15:29:44 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984557sm100517185a.10.2024.11.14.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:29:44 -0800 (PST)
Date: Fri, 15 Nov 2024 07:29:38 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ragavendra <ragavendra.bn@gmail.com>, unicorn_wang@outlook.com, 
	mturquette@baylibre.com, sboyd@kernel.org, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk:sophgo: Remove uninitialized variable for CV1800
 PLL
Message-ID: <shbsc7lxtn3fbiq4vixdjprbpxdsgwxgsd2bfziqlsunwvqj3z@tecit4ibpblk>
References: <20241114210115.29766-1-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114210115.29766-1-ragavendra.bn@gmail.com>

On Thu, Nov 14, 2024 at 01:01:15PM -0800, Ragavendra wrote:
> Updating the detected value to 0 in the ipll_find_rate and removing it
> from the method parameters as it does not depend on external input.
> Updating the calls to ipll_find_rate as well and removing the u32 val
> variable from ipll_determine_rate.
> 
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
> V1 -> V2: Updated commit log, title and addressed review comments
> ---
>  drivers/clk/sophgo/clk-cv18xx-pll.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> index 29e24098bf5f..350195d4ac46 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> @@ -45,14 +45,13 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
>  }
>  
>  static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> -			  unsigned long prate, unsigned long *rate,
> -			  u32 *value)
> +			  unsigned long prate, unsigned long *rate)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long trate = *rate;
>  	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
>  	unsigned long pre, div, post;
> -	u32 detected = *value;
> +	u32 detected = 0;
>  	unsigned long tmp;
>  
>  	for_each_pll_limit_range(pre, &limit->pre_div) {
> @@ -77,7 +76,6 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
>  		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
>  		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
>  		detected = PLL_SET_DIV_SEL(detected, div_sel);
> -		*value = detected;
>  		*rate = best_rate;
>  		return 0;
>  	}
> @@ -87,11 +85,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
>  
>  static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  {
> -	u32 val;
>  	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>  
>  	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
> -			      &req->rate, &val);
> +			      &req->rate);
>  }
>  
>  static void pll_get_mode_ctrl(unsigned long div_sel,
> @@ -134,7 +131,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long flags;
>  	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>  
> -	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
> +	ipll_find_rate(pll->pll_limit, parent_rate, &rate);

If you remove this, how can the function get the right configuration?
And why you want to remove this? I suspend you did not take my advice
and change nothing. You must check the code logic and do a meaningful
change.

Regards,
Inochi

>  	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
>  			  ipll_check_mode_ctrl_restrict,
>  			  pll->pll_limit, &detected);
> 
> base-commit: 2e1b3cc9d7f790145a80cb705b168f05dab65df2
> -- 
> 2.46.1
> 

