Return-Path: <linux-kernel+bounces-318876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735B96F482
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27DE1F26791
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544E1C9DF9;
	Fri,  6 Sep 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGWH9N5z"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732325760
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626782; cv=none; b=FDtVmrTlv+osI5eV8icDC44hgx1kvyiNrSEbA6Ssl5JdP4D8s6bJaWYh4Xd+BLtYlMf5018l2/VOfdF/zUVfVhrGb0Enc4nhtgDLsPPRV26rExkovzYreaHdU5ePZRl0sG+Mx0KJG+p0MysJNv9Y54c4QVAnQBEZSicjGu2IkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626782; c=relaxed/simple;
	bh=hC/tGF8cSl4flBiWeSmMpIIt69LufoFugG+Yk1h7n3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+g4qBA48oYA4ooR43KHdvKdKgV5kUCqHp4mej0xTIAZqjiyEOzXpSFAUQenGJ06MZMi/Po/aCHOP/g2fdSwvNf/Bh5ct1OC2NrZcslrjxzsadzCgNB9f6l0bWGyXffzZRrKHnaIXFpM6CBJ82B0nA9SLp9H41/bKBHq4M3WRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fGWH9N5z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f922ad1eso2137781fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725626777; x=1726231577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIRBLYQ4+mKh3KvEse9INuFPvpdgYruUAOkgTL5XFS0=;
        b=fGWH9N5zfA2Dtwt5RuDLJNA5dsPA1GjBwVyhWIHFKCBb7e0878kF+TWDgefsmrk9V/
         M4KXwBYqDNqKUxn1r5nVmOLnArUe4hxENAoKKI5n7Gj8N6RHLLxq1CRH/W/sjnDDCY3/
         RXRZg7ceFu3UvosIdPJeKz1LAaXy6R05QB3mJ/X/lrqMqbGjo0mOU9joj7nXReBPwiCM
         DG7bzsLtrtmHOVnTJKX3skkDoeJdXT8vZNRaNjClNYdUIoOAEd3okAv+Y+HmErhxbKYG
         7V9RHRKJlH/UnQJyqcAG3hZ6phwTaF7g6ViXAbS619Uv61en5ox+W8RuFzyYIF/xnlSX
         8VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626777; x=1726231577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIRBLYQ4+mKh3KvEse9INuFPvpdgYruUAOkgTL5XFS0=;
        b=E1dpmNV7/1G09T7BuBqvaWqeixkUNY/jhJuy1poBWqEqEuRlDdP56LXWt8793HI2DJ
         p1rtUwUmfNLtvKtgy9XolraVZYvRcQ36xj4lns9KH5lLmQ13TDZ8I4qb1UX/pEqQuSlu
         T3Yq/uKbpUv6fALhzL9h3FlvQiaH5QsvGEG3VREsItt9Oxas4XpiOShj1pCQEw0Ky3et
         Xni51rgcFWNRGR4bbYJY+McHwWDINBAhARCKladEhkDT4sgs5a6rrQM+XHuHab/Se1tI
         ASihp+36puF6+wy6/LlHwWoq9Qm+zd9Ag9iz/BkeIO2NFqtcvOcW1udWMrxkjQCR10EG
         nAew==
X-Forwarded-Encrypted: i=1; AJvYcCVjGXk5z5VmuSgrIAkB8itL3vznanzPTv/eo+W+WAWpg3nlB6wAczea3WFjGECurvoOB4Q0RvHU0j4Rw8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuU86a7Ne3kRRsNsrrp31I6o5iskB6QQZ5mzGP8pns4kFNTPfu
	w86eUdbSSEg/BaosBaEuoTgxmQkfiZ1ODFY/LoBlKXw4TRCq1KCt3zov3EDfK34=
X-Google-Smtp-Source: AGHT+IH7TcjPOhUnSCOztxx0ezKCT+YBhSK1/HnVI58kj/H9R25mEbT+/4axuFgUNssPy7mS67UILQ==
X-Received: by 2002:a05:651c:541:b0:2ef:27fa:1fc4 with SMTP id 38308e7fff4ca-2f751ea5828mr10045711fa.1.1725626776719;
        Fri, 06 Sep 2024 05:46:16 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615171f9dsm30793331fa.97.2024.09.06.05.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 05:46:16 -0700 (PDT)
Message-ID: <3ebb955d-ca25-4bbc-bf55-1b3cf2e20525@linaro.org>
Date: Fri, 6 Sep 2024 15:46:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] clk: qcom: clk-alpha-pll: Simplify the
 zonda_pll_adjust_l_val()
Content-Language: en-US
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Taniya Das <quic_tdas@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
 kernel test robot <lkp@intel.com>
References: <20240906113905.641336-1-quic_skakitap@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240906113905.641336-1-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Satya Priya,

On 9/6/24 14:39, Satya Priya Kakitapalli wrote:
> In zonda_pll_adjust_l_val() replace the divide operator with comparison
> operator to fix below build error and smatch warning.
> 
> drivers/clk/qcom/clk-alpha-pll.o: In function `clk_zonda_pll_set_rate':
> clk-alpha-pll.c:(.text+0x45dc): undefined reference to `__aeabi_uldivmod'
> 
> smatch warnings:
> drivers/clk/qcom/clk-alpha-pll.c:2129 zonda_pll_adjust_l_val() warn: replace
> divide condition '(remainder * 2) / prate' with '(remainder * 2) >= prate'
> 
> Fixes: f4973130d255 ("clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202408110724.8pqbpDiD-lkp@intel.com/
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

thank you for the updates.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

> ---
>   drivers/clk/qcom/clk-alpha-pll.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 019713c38f25..f9105443d7db 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2176,10 +2176,8 @@ static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate, u32
>   
>   	quotient = rate;
>   	remainder = do_div(quotient, prate);
> -	*l = quotient;
>   
> -	if ((remainder * 2) / prate)
> -		*l = *l + 1;
> +	*l = rate + (u32)(remainder * 2 >= prate);
>   }
>   
>   static int clk_zonda_pll_set_rate(struct clk_hw *hw, unsigned long rate,

--
Best wishes,
Vladimir

