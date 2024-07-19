Return-Path: <linux-kernel+bounces-257617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779AC937CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022BD1F21A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3D147C87;
	Fri, 19 Jul 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duoWER4E"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B261474A8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414906; cv=none; b=TCXfqIaOUIrGYRrY9vEKMZE7yVr5Q0BnG2iugIA39G1WWdsTWnaVp3uD3PadEfwg97Zaw7Q7155sSxS3ApQZsc5OoWD/cE86dx3bxffjvsFCAZme5dBpO4rDAAYGuG42aS2maFyQrTpiBffhy9CDDiJCpylbKPso2ecCq2KTeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414906; c=relaxed/simple;
	bh=KSP3qFQimIB/KWgpWhEu0lTlpGLv27AIGOdpzPyZz9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cb6efg3dzTmQTJvG5+52ITYQ2fX1rv6D9ELADM0Ci/y9CAnLMCuMuDJZ262Nbsa2WiS1UCkpes5FSOHIRhGjbmhy7ueWlLupGKt9As9Vo9tTvhIyMQ611sdkzxsYPFZzTlUJ1WbbQ9mc8RR4FVYZ8aHXogRQjQ/gKO9uw/cg7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duoWER4E; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d96365dc34so1283381b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721414904; x=1722019704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukG7Uje2tjlYAEnwiivgrAC4JGlADujKudhRv8xZLpk=;
        b=duoWER4ETLyOtzvtx3pESFee5UbZGzZdZ4QNrp8o8xPVJ010+G3kbX96zMFLVBfCKD
         xPlo9rfLmvlrhv2GoHc+HM9vYiwdWeGQbgQFXwudCThREFbmOvODa9n/3J3+CZUk6GYM
         80yWo/Xclr2mqRGOcmC6/18yBNBXArzpd5UpRlzI8CGjh0Vj9dzeZyC8r7tqIBXXVMF7
         yRtIGVBF21ZByypqjLGaUlKLKa5XLOYqBb0/g6lLsUqP1P37gCzXQliA21HwPQfnGZxy
         L1fsNTbc8Y9Rh7gaswpvOEqAWmtoF7hW4bS0qpMF9ZXZ4jIFd2II6Q9fn5pEVc00Ap4T
         3oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414904; x=1722019704;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukG7Uje2tjlYAEnwiivgrAC4JGlADujKudhRv8xZLpk=;
        b=Z57L45jvu+RAVVM+5k5CSVOPOyAS/WFeRRMtzJ21EjCdw5cdeAzh8uUAUcUL8dFait
         6lQo//NiPkuqCQ2yf982zdIqJ/Yagq5r87RNF/yNZ8f5p+6FpSrHN7Bl2ixYinkP6gyk
         6ogzjth4E7Q07Wbap+g72ANJjjBZmzXh919OaLcLX4Gi5JjP8/OYht+2gE1Zc+N5N8i1
         jxesycXi32VBRROtmA7I9QdWEW0dImA1Ta1x+U2Et3TO4vD9V7CKo6RBEDo5cgagHfjh
         9AcxiyhlYnX4nQ22Oot07HlqhbbXai8ipUSWjPSDigBQMJYPk8/rg/A3gUBuQF4/d1oc
         wKXg==
X-Forwarded-Encrypted: i=1; AJvYcCUPo2wks1gAN1ar0Q8TSRnF0iB8wRLoKsSYM0lHLe5qNYNfGRq/jO60c2gKfzO2M+oqZTiRbU5IlsaiJzjwMsflcNF7J7CuKvZ4IYfI
X-Gm-Message-State: AOJu0YzM7LRJd3TpP8zrT7gZwuropSFQJ7/ugDwPYIQ8mST1/rkAziXZ
	mSn4s8+1kYjs6UNpb4QMb+VUXMiproQ1QihmFUwDRCxEgS2n/A/AegnQMF+f7T4=
X-Google-Smtp-Source: AGHT+IFUGjfozpT7NMN/T1JZs9styGTo80iaJ/5feWyL+K6jzfZXUSsuGczjQ3mCsZm/CiHApe701Q==
X-Received: by 2002:a05:6808:1b20:b0:3d2:1fdd:286f with SMTP id 5614622812f47-3dad1f7c310mr8527058b6e.49.1721414904156;
        Fri, 19 Jul 2024 11:48:24 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:4528:a9e:1eaf:80c5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09cf1ffsm386578b6e.36.2024.07.19.11.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:48:23 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:48:21 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Sunyeal Hong <sunyeal.hong@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sunyeal Hong <sunyeal.hong@samsung.com>
Subject: Re: [PATCH v2 3/4] clk: samsung: clk-pll: Add support for pll_531x
Message-ID: <a82340ab-a1db-4089-a804-acf9882782f4@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707231331.3433340-4-sunyeal.hong@samsung.com>

Hi Sunyeal,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sunyeal-Hong/dt-bindings-clock-add-Exynos-Auto-v920-SoC-CMU-bindings/20240708-072150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20240707231331.3433340-4-sunyeal.hong%40samsung.com
patch subject: [PATCH v2 3/4] clk: samsung: clk-pll: Add support for pll_531x
config: arc-randconfig-r071-20240719 (https://download.01.org/0day-ci/archive/20240720/202407200028.5AADGhmj-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202407200028.5AADGhmj-lkp@intel.com/

smatch warnings:
drivers/clk/samsung/clk-pll.c:1292 samsung_pll531x_recalc_rate() warn: mask and shift to zero: expr='fdiv >> 31'

vim +1292 drivers/clk/samsung/clk-pll.c

5c788df7a25de7 Sunyeal Hong 2024-07-08  1277  static unsigned long samsung_pll531x_recalc_rate(struct clk_hw *hw,
5c788df7a25de7 Sunyeal Hong 2024-07-08  1278  						 unsigned long parent_rate)
5c788df7a25de7 Sunyeal Hong 2024-07-08  1279  {
5c788df7a25de7 Sunyeal Hong 2024-07-08  1280  	struct samsung_clk_pll *pll = to_clk_pll(hw);
5c788df7a25de7 Sunyeal Hong 2024-07-08  1281  	u32 mdiv, pdiv, sdiv, pll_con0, pll_con8;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1282  	s32 fdiv;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1283  	u64 fout = parent_rate;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1284  
5c788df7a25de7 Sunyeal Hong 2024-07-08  1285  	pll_con0 = readl_relaxed(pll->con_reg);
5c788df7a25de7 Sunyeal Hong 2024-07-08  1286  	pll_con8 = readl_relaxed(pll->con_reg + 20);
5c788df7a25de7 Sunyeal Hong 2024-07-08  1287  	mdiv = (pll_con0 >> PLL531X_MDIV_SHIFT) & PLL531X_MDIV_MASK;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1288  	pdiv = (pll_con0 >> PLL531X_PDIV_SHIFT) & PLL531X_PDIV_MASK;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1289  	sdiv = (pll_con0 >> PLL531X_SDIV_SHIFT) & PLL531X_SDIV_MASK;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1290  	fdiv = (s32)(pll_con8 & PLL531X_FDIV_MASK);

PLL531X_FDIV_MASK is 0xffff.  Was this supposed to be a cast to s16
instead of s32?  Why is fdiv signed?  Shifting negative values is
undefined in C.

5c788df7a25de7 Sunyeal Hong 2024-07-08  1291  
5c788df7a25de7 Sunyeal Hong 2024-07-08 @1292  	if (fdiv >> 31)

It's really unclear what's happening here.  If I had to guess, I'd say
that this was testing to see if fdiv was negative.

5c788df7a25de7 Sunyeal Hong 2024-07-08  1293  		mdiv--;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1294  
5c788df7a25de7 Sunyeal Hong 2024-07-08  1295  	fout *= ((u64)mdiv << 24) + (fdiv >> 8);
                                                                             ^^^^^^^^^
More shifting.

5c788df7a25de7 Sunyeal Hong 2024-07-08  1296  	do_div(fout, (pdiv << sdiv));
5c788df7a25de7 Sunyeal Hong 2024-07-08  1297  	fout >>= 24;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1298  
5c788df7a25de7 Sunyeal Hong 2024-07-08  1299  	return (unsigned long)fout;
5c788df7a25de7 Sunyeal Hong 2024-07-08  1300  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


