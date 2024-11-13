Return-Path: <linux-kernel+bounces-407395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE89C6CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4F1F23482
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854661FE104;
	Wed, 13 Nov 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqPj4MAf"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685701FBF4D;
	Wed, 13 Nov 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493959; cv=none; b=DSaH7tgdljtnJd69f2ITC4a6GwQBlM0UwN+Kpad0xN22Uc0djismo/fB7KUlpxK9wZuvTPvsFe5Z5tYPjT5WdWqq1kWtfCscpVQqTT9YgMjwnMB33MALkb3hLycPa0rTg0X+8Wbe6t4axhR7pHvYav+2lEa8t1XqLzvZZ1r+v7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493959; c=relaxed/simple;
	bh=52UxRPcNrE8LQynn0nwOgl9x34x+3u2HfP8cj8/NSIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfPO5a8HT5kUE+JNAwaeUDEIc0wh9YfcecSlEdBNu/Z34kWRk3hHmSwG7J/DbelyHeT5VK91TTJRPNbBhKzwly31Og8hfVcYdvsvkYl70K/rpQv5l2YG0PdRIOPuBQLlZ/GD7T8GSFGO81RimBCBkCo1ix+mm3J+UGi5RYV1GEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqPj4MAf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608e389407so85053901cf.2;
        Wed, 13 Nov 2024 02:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731493957; x=1732098757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rk5/rWRPQQsNa/Z0S3DcTsHoBEi32Qxc/SFM2VdEPE=;
        b=RqPj4MAf9zMgSztHM+pug/uDoYPAKRYTcl6uxxC+Juuc4xFP2kdYLKyCvjy0JQ0d3w
         iFpRUursiupVlIOqR2yNO8Ui65VtIiOMCQmI3kAhkjwi4tNF9hGrepRTWrvXNdNdoyrB
         hAGnIYzlaDal5ijeW/JtwtzazdAb6Z5dD85GAqg/5gBiTTO4Uhr9hpnvK0tUyGD9UuLI
         DWlqwI3l40299DufGNTEflQc8SsE3Uza0YAJLVGwfwFTyEywdy0RHXvFPmn8XScgRRAl
         l5hd1vhuwXzML7vKcJxgHtTZiv028CYi5zTCcHj72aWFPjU1kzJz3cXu1K5qbwd6b/x+
         m6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493957; x=1732098757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rk5/rWRPQQsNa/Z0S3DcTsHoBEi32Qxc/SFM2VdEPE=;
        b=oVP3TIG4iAR3UXtl82po80uw5sL/vFQ43kHQ4Rv8clLKX/I8gAHBQR6TbXwydIsjSp
         RS7uO7QLUx8zi3tm3UEDZFKY5orcaYXNUhh7Z9QLXlTgPlIGQSja7nIGOxZR8d0jgr0M
         mU1kQUQOq0qbWehflugm0/kZcpFXC41t/CEzMZ7UHdaAekzxB//dEqOSIyGTLMj3eY0r
         34Liwn+kZdJPe6hfbPORGAqd96kyZeuHsV/lyTFzPAAio4DZNU3ofQJEqBg1XqXnJTDd
         5/AHuEJnmbDEj8OPqgTtVEVmjPE0LnqNwQRGcujZYRI4DSAyNdl/gN4Smty4aVRFF6vc
         82cA==
X-Forwarded-Encrypted: i=1; AJvYcCV1gayM6hFQlYbDIwuKaClT0SligMuVK1Gvu7Bz2ywUr9+ePowO8LCjG//61IO2j1UJgTBh6FJrab6lIpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDcZ40ROxO+qrotKXJNtasypzrQWs/RgGi1UejKpg+JKJN3qp
	nA/Sw+fkqpuKjG4PQupjsTy2bi7rNL28SfYsOyf76KYNUD16ofI8
X-Google-Smtp-Source: AGHT+IG7cHzfWzZFC4glit0Klz3wbbfgPif+JdclhIGyC2EshTYAZQkwsZj4YlWh7M44dvip0PzIog==
X-Received: by 2002:a05:622a:2a0d:b0:458:3a34:b7b5 with SMTP id d75a77b69052e-46309370c73mr246541631cf.26.1731493957263;
        Wed, 13 Nov 2024 02:32:37 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff46d440sm86247761cf.52.2024.11.13.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:32:36 -0800 (PST)
Date: Wed, 13 Nov 2024 18:32:31 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com, 
	sboyd@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32
 parameter and variable
Message-ID: <kzb6ciwjj5u7zf3qnh76odzcq7vwelgwkzyxgxbhmhl7hyrsh3@vde63g6g7slf>
References: <20241113025318.3667350-1-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113025318.3667350-1-ragavendra.bn@gmail.com>

On Tue, Nov 12, 2024 at 06:53:18PM -0800, Ragavendra wrote:
> Updating the detected value to 0 in the ipll_find_rate and removing it from the method parameters as it does not depend on external input. Updating the calls to ipll_find_rate as well and removing the u32 val variable from ipll_determine_rate.
> 

You must break into lines with maximum 74 chars.

You title is weird, a more suitable example is
"clk: sophgo: Remove uninitialized variable for CV1800 PLL"

> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>  drivers/clk/sophgo/clk-cv18xx-pll.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> index 29e24098bf5f..57981a08fd5f 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> @@ -44,15 +44,15 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
>  			      PLL_GET_POST_DIV_SEL(value));
>  }
>  
> +
>  static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> -			  unsigned long prate, unsigned long *rate,
> -			  u32 *value)
> +			  unsigned long prate, unsigned long *rate)

This break the original logic since the value is used in the caller,
and I see nothing improved.

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
> @@ -87,11 +87,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
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
> @@ -134,7 +133,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long flags;
>  	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>  
> -	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
> +	ipll_find_rate(pll->pll_limit, parent_rate, &rate);
>  	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
>  			  ipll_check_mode_ctrl_restrict,
>  			  pll->pll_limit, &detected);
> -- 
> 2.46.1
> 

See the kernel test bot log.

Regards,
Inochi

