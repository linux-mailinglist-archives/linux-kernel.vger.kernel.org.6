Return-Path: <linux-kernel+bounces-409884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32369C92DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB3DB290E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E2B1A9B3A;
	Thu, 14 Nov 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzyaNeLS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2D1A7AC7;
	Thu, 14 Nov 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614671; cv=none; b=ifpIeEU1AQT1pCB45mFGxLMWLun0j1GU+aYQYXfkFAKnEDu53MdjAMdTBzUxwdGCoFO/xEzIa8zodLiXzkRBUhyd5G6G4io+YUZ41NEvdNh3ArI67iZVFJGNsRavSfUf4OCYO+vEiel/fNazf9ZrOxBu1G0uQc13VphHyCI6D9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614671; c=relaxed/simple;
	bh=cIomomwT4Q5yeHvXN/5o1K71h/bXKh4TfBN74dSw+GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI0qGfIW88S0urnd/FiO4h8YCA3sBeNcV5a27z1v0jXUH75t1gpLAHBMe3pO2XNQOhCfRx51IXJUNldoB4ADBjMvtjrhDAzY5ZbY6GRVrJnUNW4Zm8BE2n98lgG9ffayBJH48yHENwnQttcvwm45C/z/eUe1C1Yyu6iqTe2UxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzyaNeLS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf3e36a76so11902865ad.0;
        Thu, 14 Nov 2024 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731614669; x=1732219469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnoyKzG6x6aX9EkLOKI78/O3bdwWNSThDDftvDsLSqE=;
        b=CzyaNeLSeElVVFz6TC8N37wQfES7sPdMtf29uXBmlAA/RbzbGByFsejTaKB4pD+BIR
         O9H5U2NWn+TKdt/ram6jpx/XN2WKd0+cjW8bEx5hwsZzn0H2NLXik1RhKZ6QcLBsetPd
         Cm6vlfl7IUAzfWsWHUAP7NquX1rhazGRblP9i+K8dm7LNRbOX4l+DADy8+GibdPuzOxJ
         fpISsthSCpWZ4QnOaKUWfQk1bmtvRMUNoCIYcu5nrr8xNbMzreRWO4YEyGcq7aUlXjpw
         J6K7WxKfVFC2Yx2+W+pGTkUtBwQ2bsmFOiNtJ2mrLTRGE6duEWHI2UDKhvjdMYsIcu4l
         Xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614669; x=1732219469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnoyKzG6x6aX9EkLOKI78/O3bdwWNSThDDftvDsLSqE=;
        b=PA1izgjEr4fXFmj6lPQAWLBrbIdsRd9/hNmqhs9h4A5vc/irMkvxhbJDP4Z5kemn0i
         b412mSr8Ri2h6bp2qkdn8kmmyagdKUOutSOt/5JID5+TJ2tTPjxEJ3l6oan4zDHxR9mS
         ZGGim0B3li/m+brXcBkvESz+vRhhTx3bCaWSg6D9hA2FC7F2n9hHrpbTNpN5Ai2qYx90
         xnxBDqADhehuq7AgoDnQdNcJ2sks6tM2ZQpJfFAPAi9UE9ILAyQuLFp1qfiC3u6MTlUQ
         GHO10g67vWxGXOLtvvykJ7s3PjQdeE+CNnWU1sGo7IWt9hJmWR/kEnJ6CmuY0I1e/BjY
         2jnw==
X-Forwarded-Encrypted: i=1; AJvYcCXUSAsp9lIDHThwXdV8tLPVWkre9wzmPKy4TKL0DeTZkxkeYK8lmNd2FwpToNcMxJa73tKNjJD5QZASf10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4luCHm89DjTmdcgpxROlLVodxJJ/ysnlj4Yw4VS5CrAIRp2q
	C7OdlukcyOFvZZIB0iZpndQsz+iY4GSxget8vYCDgz07i2a2gYGG
X-Google-Smtp-Source: AGHT+IFh8R8qy9qiaTIZS9tEkBObDZQyzbupCqaPuLLzAjw6XDmBK53O3mrqBXQD9FF3Pm6PMxAHvA==
X-Received: by 2002:a05:6a21:7795:b0:1db:de11:adb8 with SMTP id adf61e73a8af0-1dc70497e48mr10473403637.37.1731614669375;
        Thu, 14 Nov 2024 12:04:29 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c644b1sm21242a12.42.2024.11.14.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:04:28 -0800 (PST)
Date: Thu, 14 Nov 2024 12:04:23 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, mturquette@baylibre.com,
	sboyd@kernel.org, inochiama@outlook.com, ragavendra.bn@gmail.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll: fix unitialized u32 variable
Message-ID: <ZzZXxxSghLGy_mZf@desktop>
References: <20241113020233.3646527-1-ragavendra.bn@gmail.com>
 <MA0P287MB2822D976E1A3379DEAC28666FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822D976E1A3379DEAC28666FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Thu, Nov 14, 2024 at 07:36:21AM +0800, Chen Wang wrote:
> Hi, Ragavendra,
> 
> This patch should be dropped, right? I see a new patch https://lore.kernel.org/linux-clk/20241113184617.3745423-1-ragavendra.bn@gmail.com/
> should have covered this.
> 
> Suggest you reply this patch email and declare the dropping to avoid
> confusion.
> 
> On 2024/11/13 10:02, Ragavendra wrote:
> > Initializing the val variable of type u32 as it was not initialized.
> > 
> > Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> > Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> > ---
> >   drivers/clk/sophgo/clk-cv18xx-pll.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > index 29e24098bf5f..04a0419cab4e 100644
> > --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> > +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> > @@ -87,7 +87,7 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> >   static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> >   {
> > -	u32 val;
> > +	u32 val = 0;
> >   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
> >   	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
hi Chen,
  You are correct, please drop this patch email.

--
Yours sincerely,
Ragavendra N

