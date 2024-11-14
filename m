Return-Path: <linux-kernel+bounces-409920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8269C9362
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B51F22B29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63771AA7BE;
	Thu, 14 Nov 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al0zjHfo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD502905;
	Thu, 14 Nov 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617169; cv=none; b=sMpIAyvVWUEuqnVwDSYm4dqai5DrYgP56JSIa71FqLtbMLo2IMsjbWwKPX+T3meAZrZpKehr8ti93AYYO9Kc2eyaV/CE1mbLeHGtkRpGN4Muf1vsN6tP5XPFcfKWovnCxBbhWIkn+6Ql/RrBWbarwzUtUoZ0J4ElJ1G5Wr7jylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617169; c=relaxed/simple;
	bh=7t0ebqwKHW1Si6jhGQiE7FPoIVHjiATBoVIQinCJimY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqWmoiy+11v+Hlj/idDay2wJeA0+h1KFZULrh+sE0hrg0OO77+m/K3Fh/AumMxmqNS/4m5veIaFwtSvg0rGUZnBvgEjLhKYU50j2xCLEKfXoyJmOCBz8AlMrre3UKXU6E66FFx8IKBAO/2DIyiJZsWPiVIP0/NMQDEPZHE2wOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al0zjHfo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2114214c63eso9982225ad.3;
        Thu, 14 Nov 2024 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617167; x=1732221967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwZoS4T8GJY7GbtFvkuJDAF7ALLi08sPi0S0gS8G38A=;
        b=al0zjHfohvGjEsNqPp9VwmuaLVQ3k0jsW36D9kGHl0AjPG8HQS4PYliP5vmiIAY2v9
         2b0XvL+vliWv9W/X+qo62B041KiWnFCX6ACkFWeTksnfDV0tM0gexqk2WRTtqTGGzV/i
         uuxfOEe+0jtdK+qdIpDacMQ1aXdurN05gRwn06zAk2qJPnHry1AVsh569TCtUaJ5VjwV
         j1WCvBj7TFGAbf9/Sx3pEOxEpyud5zKzUoGUoLCenMuifJ6OElTUIo2Aij8T9mNmvrFi
         /ce6nBpsViwFl+3/8pNmszALo2Sv7pB6d6OWeJMIhXySAAzaWbyZl0fcZOA5PcM8V3Uq
         xN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617167; x=1732221967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwZoS4T8GJY7GbtFvkuJDAF7ALLi08sPi0S0gS8G38A=;
        b=gGhkwLy4+HnMaINXL81V9dBBzJAOLvmEoxhhvs1yRZpMwSXAW+xp3Q98eQKYx/Sp3P
         AuGqcK77CZkVy0hdOiTZ/x95ODh96GnGi5UG9ueuSA3I/7+Nz+FIZuZKD9wpqS2nzcvJ
         VY8IIIUWcR8ntuKNrAfMxp0AaY5MGyZ5jIy8yUo4l/3Skkjdgdb1VD7fbtfZz8NfECKw
         Qn1AJdMEnNg1kgZ9y2IbW2TVxvwZiIY+EWTBQSwCSYXy9He/WFSMEzN9SHAKX1Ypo4vp
         J88+YYSzyNK8akKONToGLftn7D9Ck1ezVIUNNX3mHKFJtn81ZdIYsUssRSY6ndcgpb9u
         Z6nw==
X-Forwarded-Encrypted: i=1; AJvYcCXDBLdc0PxgKzKYJLqv17r9KRmQxPL4xRL7RpvxnwNjrNcQPAwvIqN059Mwgj2368N7KfUbaamXahI=@vger.kernel.org, AJvYcCXcPH0bcMCAreOm65V0tTwzfyQluy/5Q3LnpIdAHgjGF9DwbPvpHMp1ITR0UZjLv2OAvxYD3q+dD0Ux+TKz@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwTqEouDFvit2Bh0fVYdfnUp80SFBjuEEpRotWop9dvykbIwb
	jXPq6zmH+gdCj5vWlCHHLLxzRlrFKJkzCgXyRy1u4fQzj2aOPhWj
X-Google-Smtp-Source: AGHT+IHPAs995/2emGnJWhm165Fh2LLGd5nNTXmDozgDJXIvVJxKv166sUSge9G1ro/2t0dnzTQypw==
X-Received: by 2002:a17:903:84f:b0:211:a6d:85e8 with SMTP id d9443c01a7336-211d0ebf430mr2261615ad.39.1731617166766;
        Thu, 14 Nov 2024 12:46:06 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc3109sm528495ad.52.2024.11.14.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:46:06 -0800 (PST)
Date: Thu, 14 Nov 2024 12:46:02 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, inochiama@outlook.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk:sophgo: Remove uninitialized variable for CV1800 PLL
Message-ID: <ZzZhit48lLt3zPlJ@desktop>
References: <20241113184617.3745423-1-ragavendra.bn@gmail.com>
 <MA0P287MB28229437858DBCD00CB05757FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB28229437858DBCD00CB05757FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Thu, Nov 14, 2024 at 07:44:21AM +0800, Chen Wang wrote:
> Hi, Ragavendra,
> 
> This patch should be revision for another https://lore.kernel.org/linux-clk/20241113025947.3670504-1-ragavendra.bn@gmail.com,
> right? If so you need add version info in the patch title and changelogs
> etc. Please read https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> carefully and re-post the patch.
> 
> Kindly reminder, better declare dropping of this patch email and repost v2.
> 
> Thanks,
> 
> Chen
> 
> On 2024/11/14 2:46, Ragavendra wrote:
> > Updating the detected value to 0 in the ipll_find_rate and removing it
> > from the method parameters as it does not depend on external input.
> > Updating the calls to ipll_find_rate as well and removing the u32 val
> > variable from ipll_determine_rate.
> > 
> > Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> > Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> > ---
> >   drivers/clk/sophgo/clk-cv18xx-pll.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > index 29e24098bf5f..350195d4ac46 100644
> > --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> > +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > @@ -45,14 +45,13 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
> >   }
> >   static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> > -			  unsigned long prate, unsigned long *rate,
> > -			  u32 *value)
> > +			  unsigned long prate, unsigned long *rate)
> >   {
> >   	unsigned long best_rate = 0;
> >   	unsigned long trate = *rate;
> >   	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
> >   	unsigned long pre, div, post;
> > -	u32 detected = *value;
> > +	u32 detected = 0;
> >   	unsigned long tmp;
> >   	for_each_pll_limit_range(pre, &limit->pre_div) {
> > @@ -77,7 +76,6 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> >   		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
> >   		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
> >   		detected = PLL_SET_DIV_SEL(detected, div_sel);
> > -		*value = detected;
> >   		*rate = best_rate;
> >   		return 0;
> >   	}
> > @@ -87,11 +85,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> >   static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> >   {
> > -	u32 val;
> >   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
> >   	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
> > -			      &req->rate, &val);
> > +			      &req->rate);
> >   }
> >   static void pll_get_mode_ctrl(unsigned long div_sel,
> > @@ -134,7 +131,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
> >   	unsigned long flags;
> >   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
> > -	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
> > +	ipll_find_rate(pll->pll_limit, parent_rate, &rate);
> >   	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
> >   			  ipll_check_mode_ctrl_restrict,
> >   			  pll->pll_limit, &detected);
hi Chen,

This patch is the revision for the https://lore.kernel.org/linux-clk/20241113025947.3670504-1-ragavendra.bn@gmail.com .
I will update the version info and all and send in another email.

Please feel free to drop this patch email. I will shortly send v2 with the suggested updates.

--
Thanks,
Ragavendra N

