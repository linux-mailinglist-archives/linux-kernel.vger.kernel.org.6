Return-Path: <linux-kernel+bounces-339439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9C986513
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01587B22732
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A261FDF;
	Wed, 25 Sep 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/uuYsY2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30AA482EB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282667; cv=none; b=m3eaAq+m8gBJDlV0Hod6PSKwU3tibgQq+Vr2lxaGVtPnkesTSQAShZgh1ZRfM6DYclfS1DTHAWF0eYHMbMyiMTbK7HfjjMNSZNW3XRBz6lRlEaKusTs44KMZQHAFE9rWeybWrIsKvgEg1YrGtOzZyLIrKQ7TADK30GzyF/K+btM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282667; c=relaxed/simple;
	bh=TshH7x9zoqiXs2k51eKLvVSOTC5Sb2wJvifrkksRdi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu/eoLag3R7BcmgYUlLSxXqQUEOGLXuYSaAHTnB9ZM5fQEydfLX7l44/J948FcDCni+gRcpybPUL/iYGl8PF+UaiO4qk7V/IoTgLfEdztB+f2MarsetEkj2MnKC8WxGPk5I6c1wUqp4cG6YxVTBNsWYKi0Atvfv9UjBnsxSXJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/uuYsY2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53653ee23adso44482e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727282664; x=1727887464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ul25A0C13KzF8aLZJHoNmg+VKjysDsNktaX7/WFp0nk=;
        b=y/uuYsY2s01/ZZDQggPHpt1J+xhCnDqTDtOQgOEK1Wjz4s13q4YWmXOZ1o/5ZjeAN/
         Bxvdeqh8B9Pg7b/OVGvZ7Z2lvm/2gennGfq3OLOrOrFvti2c8gv+lNrM19Cax4IuCZhb
         WLTM3FNbkBxWzswKn7rUbLyDedHLeIS5JJLG3vozl5myggFVibWECPTbCKhpoNxIRNzw
         qlTjoepXSMyBrZC8dJv5v1YTT0f+8Hk8t4kR+AEdS45kg2PAm8XpiSlCjY//cvw9GPzg
         VyzcFb1ZlkhSdZVSoVQvXiSq0LootM2ENxOFrp00eRu70jTh1X72SsMrPyI/kJLy3s+N
         v4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282664; x=1727887464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ul25A0C13KzF8aLZJHoNmg+VKjysDsNktaX7/WFp0nk=;
        b=fNdY6SPFj9vJz3eozk+9aZ+N+9Ug2tQKdorlEOsEq8k31CW4sz1cJwAvZKp2xzmQZ8
         R+1bXKKiAe2saSIOPGXypNG2Q9hlyXfEdCScSCufybdkQZ/Xa10e+hmtwfVdsgb2uaKJ
         HNqsBIO4j88X2njRoTDn4YvFTzR9U9LcdMrOi5909QXA0NoBXQpp1v5RuaJN62vlCDZ6
         0YM4//pVgfJ1Fr7TN5LVmlgxV3NRzjC3GayRJa5VSUVTeg0tfmIrzzt66D2raJpeHdgg
         Y2p3D3tgnaeh12o/FLq7QB9OrIVC5S/YYPZYrleWCIHuNihKd7d2t/o5VdWdRDNZeR/7
         /XeA==
X-Forwarded-Encrypted: i=1; AJvYcCWgJLBjNzBPe/hH6mSfn7bvkX7971lTsJPMf0fgZK0LNtV7suATx+PbW/3NLiowIYFVSm69tsmU7UIS5pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG1AEFulPljbNp+A8SzEklraqGQwY1e2EGkFL4WWIcoU6v0zN
	1D6MosVsnvVg0pZr7Q02yqQ9ke029y5idohjdKT8J8ardY+1CF73PNJvn0GI9yc=
X-Google-Smtp-Source: AGHT+IEsOyU76YbfaMTTTpyrt+nka0vAi+uaa31hAz3V96wX3k54ZPs/xtWgUFYWtMGEK/sQyKgZtg==
X-Received: by 2002:a05:6512:3981:b0:534:3746:c623 with SMTP id 2adb3069b0e04-53877564ad0mr2258741e87.55.1727282663591;
        Wed, 25 Sep 2024 09:44:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864898asm566022e87.189.2024.09.25.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:44:22 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:44:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Fix pll post div mask when
 width is not set
Message-ID: <jsxbyzdamrgrwob2hqzk2ljgu3o6aoyjd42kzyqbvi64dopicl@y4wgaviudiud>
References: <20240925-fix-postdiv-mask-v1-1-f70ba55f415e@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925-fix-postdiv-mask-v1-1-f70ba55f415e@mainlining.org>

On Wed, Sep 25, 2024 at 06:09:39PM GMT, Barnabás Czémán wrote:
> Many qcom clock drivers do not have .width set. In that case value of
> (p)->width - 1 will be negative which breaks clock tree. Fix this
> by checking if width is zero, and pass 0 to GENMASK if that's the case.
> 
> Fixes: 2c4553e6c485 ("clk: qcom: clk-alpha-pll: Fix the pll post div mask")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index f9105443d7dbb104e3cb091e59f43df25999f8b3..1f914bc0af5449ed1fb545d850607138a06fab1a 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -40,7 +40,7 @@
>  
>  #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
>  # define PLL_POST_DIV_SHIFT	8
> -# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
> +# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width ? (p)->width - 1 : 0, 0)

I think the actual problem is in the different commit. Commit
1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider") made
width required, but didn't document it and we did not follow that for a
significant amount of PLLs.

I think a proper fix should be to return 0xf mask if p->width is 0. In
other words, p->width ? p->width-1 : 3

>  # define PLL_ALPHA_MSB		BIT(15)
>  # define PLL_ALPHA_EN		BIT(24)
>  # define PLL_ALPHA_MODE		BIT(25)
> 
> ---
> base-commit: 62f92d634458a1e308bb699986b9147a6d670457
> change-id: 20240925-fix-postdiv-mask-ba47ecd23ea3
> 
> Best regards,
> -- 
> Barnabás Czémán <barnabas.czeman@mainlining.org>
> 

-- 
With best wishes
Dmitry

