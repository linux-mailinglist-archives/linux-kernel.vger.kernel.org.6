Return-Path: <linux-kernel+bounces-226924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9479145D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DB3286DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D613048F;
	Mon, 24 Jun 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bfc7Dx6L"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6561FEB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219933; cv=none; b=PET7gd51FZiVCjlpjURzBHCLTMyX/WzqbMaVG2rARyTYC7cbjnG6+XpGCnVWl0h7j4chsE0jSUmOvdwZU6Jv/f1VuUFS4qIWpOIyYMCqk2kj4uPHAziJgfYLwCd99DE5Av/2EXLO+NzRRubkLVqceFN3HQpRUdhica9sVuMAaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219933; c=relaxed/simple;
	bh=y3HVBK/bRtl4XQzsyLB6r9HO/3l+Qjcw4dVPw8dtz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDzXEEr84+gDjVPFPAEsoE/RdHymMbmd9cNPgfbvT1Obwvl5g6gF0XBzf0hQ7gcWRHWccuYyhvk4GDgqZFtD+hMC3y9wgEk/rRsdL/O6VdGYjo9FFPOxQ3t8m+xtgWxnp6Pqg15oHfwUQN2w+u+Wwn9l8rMLSyAt3kjg2seAVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bfc7Dx6L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36226e98370so2472418f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719219930; x=1719824730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7dckm9u+f+lO2ZsVHDkfJuiV4Rz3AqkMPKl5tZVVE=;
        b=Bfc7Dx6LRgvKXjlOpwTz6T9LyJfJPNWUPvyu4Uv/fasKRpyaZg1uv4vup2Xlbq1Tl8
         c/qu3AxC9XA6G7fkPV/pDg+y3qOg65m5v7e4OZr1LRrL4JEPFrKM8EAAV8bbKc1D1K1V
         YlWqsy+ZOzpD1n3T9IgRYui+4XtCXhcSV7cJbKDdB+AMSB3swOk0pRxwZqiqiQ9t9vkV
         y5Co2nzKi8HShxIisRNs3dAO0C3TvLDhxFXpNVpEivSpRxySwwZn1efibqU6HpYAvMvl
         zk1af92qiOdc+AVsPIL176ip9qwiFdu0LeVTmtkeHF8bHLeD6l2jvJ0NHjWK2NpJu4vi
         091Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219930; x=1719824730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX7dckm9u+f+lO2ZsVHDkfJuiV4Rz3AqkMPKl5tZVVE=;
        b=oRZahlGzQzzj2q6UTRGPYJhFcQRZR+rILW0bUmhyQ9Vd4QhaCmpqTGPQYJbAxTXET2
         A0hkrs9Ff1IF5fzEz1cPFi0PLTgfkayBPGKUAAzaTY2Hsm5FwRP4Ydb3QtoMihp7pA8G
         NME8OSLxpYkYWKVur0eApHeAmmLW8tu79Xr1bLvQ2bvr/6sWkDjkwxYMz6RcdaQJHxCa
         IbMCZE7ZzsGVcE4PjBJMPyNoHe6zgWLgqyokE/sb1rzY6xyGnPnmGMicq4ABLdEYZbnj
         ZenqZFrI+JZ+eFYmaAxVGQi0zO+FiAtoIXtTuBCsAllaxccFHtGB7BoWarlinHYbk1yd
         E6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVNhsMWQM7Naq4qO2by5tOSYRKWNYiT72xk3QPQAyDbbF3hrxZ2KU5zKgMLbcW7KMi4blSjz9lDGmpY1SqN1hYXp5379twdDRxzpJhM
X-Gm-Message-State: AOJu0YxXPCLNQmYUl53fYWpMMRLvw4d/kPxTeVVJeuCGkgYp6b12W0kh
	8txJW7RqLLrFL25ZHiRUjb9sQANTI8Ga0mjzLyt33SQLLHs9Fe9rXX5r1+6eUHg=
X-Google-Smtp-Source: AGHT+IFCAyqdfSpwc+KusHgg6PUb11/WZSWULyobNuTMHB2rRr+sqQCcDWWC19uzTo3m9BDnUqC8tA==
X-Received: by 2002:a05:6000:1847:b0:366:ead3:37cd with SMTP id ffacd0b85a97d-366ead33bc6mr3176993f8f.28.1719219930407;
        Mon, 24 Jun 2024 02:05:30 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6da6sm9400270f8f.12.2024.06.24.02.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:30 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:05:28 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: imx: composite-7ulp: Use NULL instead of 0
Message-ID: <Znk22OwMJ7oKDLXo@linaro.org>
References: <20240624024351.488492-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624024351.488492-1-peng.fan@oss.nxp.com>

On 24-06-24 10:43:51, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Address the sparse warnings "
> sparse warnings: (new ones prefixed by >>)
> >> drivers/clk/imx/clk-composite-7ulp.c:85:24: sparse: sparse:
> Using plain integer as NULL pointer
> "
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406220536.JnAncjqz-lkp@intel.com/
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
> V1:
>  Since the orignal patch is still in linux-next tree, so not add fixes tag
> 
>  drivers/clk/imx/clk-composite-7ulp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
> index db7f40b07d1a..8ed2e0ad2769 100644
> --- a/drivers/clk/imx/clk-composite-7ulp.c
> +++ b/drivers/clk/imx/clk-composite-7ulp.c
> @@ -82,7 +82,7 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
>  	val = readl(reg);
>  	if (!(val & PCG_PR_MASK)) {
>  		pr_info("PCC PR is 0 for clk:%s, bypass\n", name);
> -		return 0;
> +		return NULL;
>  	}
>  
>  	if (mux_present) {
> -- 
> 2.37.1
> 

