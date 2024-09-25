Return-Path: <linux-kernel+bounces-339643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D9986854
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C418DB22055
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1815667B;
	Wed, 25 Sep 2024 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6P9byp+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06F146A63
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299727; cv=none; b=W2EjNgzSo/7SDaEb4GPNWNWftMmiO9qDhbRjLHLfjrHyWtkfmIuLfTBoNr1Mw++Tatr+epY+mJNDTVMvnnv5EWVnYMRnCV+idvHaFWH84C4b+LRyi8A9ObhlZN0tz4GhrF6eoUTDdoDbhEikos1VUnzRbcga2BNq0mEwTiYA7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299727; c=relaxed/simple;
	bh=WucR+djirwpM6STmHdVUy4UR5ERz2gZtg/GRT0C4+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYGvCwM6LwUOZSK5mjYaIwMTsI9XqsQ+QcTv6YE2PviP8VRYmyc40s1yJK6m2pXnFutIq3S0JM92OIT5tS5wdscaBf21OIIG7rV4m4Q8NaW/jFMFYU/cSMRc6H8EqGcGpgm9LpU0ZVzNlfzArLVyb6NddfbItsJ6eN91I+ldfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6P9byp+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so2820871fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727299724; x=1727904524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwTr0ZjzKHD8edFYUSKF8PBtaT++xT7YsKjfFnre+JY=;
        b=M6P9byp+++VgGzj3JjemOtwY976DKBqxqAII/DgM4aNnkiS1sYNXCw+EUwxQTkvLAT
         GG7TQdk5sgipr9UPMLraayYGIG5oki9x9QDgJeuoWeh29mCugfrLacEm05apNh35PD1l
         vvfE0QgUQEOfNwNh28+LSn/BxBGuhIINM55223ygPTzZvEwy6QeM4uC55l4iJB5AGkcV
         xtTW+eH4E6Dvli43X0wilQ/PLPUDEBPkpguG86UC5pyIDb9Mnp/DyGG5jL7TQ6kFzVVZ
         GEPd/g+OQ8TG8j1w3asTDgbMMmHBxkK9QS0glr4yk76+TF3MFli6Oec8clg6+rUdwMaK
         5hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299724; x=1727904524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwTr0ZjzKHD8edFYUSKF8PBtaT++xT7YsKjfFnre+JY=;
        b=kWUkwyuIL+xofMDOR5ICZ1zr7GPGDsf0ci9Nia2rrVj2qpBEKnq0iNH024L6SyaWOy
         vf7BI2KIA531CAV0F5a2yHTEiOKEwen2c2cYxYCZKpDdj2AFQt17rQwQZTjiG4JidSEc
         Ty8TJvLiOeYqomZQ89ulgbNbd/CD0IDpgxXS7ekMfjKMwZHUevzm0YIBBpCJgKxdiXsz
         7MwOqmYu65i2BKZ1QGtlAJhhZ8AeNFJ0wscymOYUufcqpCYA8xtoM/29bUQq1PzKbKsI
         kidAkpdq5AnKE2Q9pw7cO8BowvJAYHio725QY2SAv05U42cfm5eoA2wHmnBp1eQQ7P89
         AALA==
X-Forwarded-Encrypted: i=1; AJvYcCWerRqcQtv1Qq/ymkVz1bEHtEw1JT26BouTs5P+jEFGIDblW9wQQ2qsFsE5DEA5WZ787KlmV9WxugVoeNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJGkgUWHCipRdGenFZbkwWxt3UsyFvNmYaLbwlKyMm8Sx3yG7
	ZhEFc6VfI13NdC4VBZrcTSD7xxUBHtHZjt1vZ4Yv7ZU9iB4cgObrNCpinI10lC4=
X-Google-Smtp-Source: AGHT+IFr4Ny4+GpZtXRbkLD1/XaxRB6oYcW6d6Gw9eijaSV1QXJ3oFhYYiPUQKPns6/AJEWKpEWAAA==
X-Received: by 2002:a05:651c:2117:b0:2f7:4f84:50a2 with SMTP id 38308e7fff4ca-2f91ca426ffmr26443491fa.31.1727299723711;
        Wed, 25 Sep 2024 14:28:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283bfd0sm6173091fa.42.2024.09.25.14.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:28:42 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:28:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: qcom: clk-alpha-pll: Fix pll post div mask when
 width is not set
Message-ID: <jlmnxzkferigmhh5akcr5uumrdychjxyy2flftx5u2sg2w62aa@566u2lqj5od2>
References: <20240925-fix-postdiv-mask-v2-1-b825048b828b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925-fix-postdiv-mask-v2-1-b825048b828b@mainlining.org>

On Wed, Sep 25, 2024 at 08:33:20PM GMT, Barnabás Czémán wrote:
> Many qcom clock drivers do not have .width set. In that case value of
> (p)->width - 1 will be negative which breaks clock tree. Fix this
> by checking if width is zero, and pass 3 to GENMASK if that's the case.
> 
> Fixes: 1c3541145cbf ("clk: qcom: support for 2 bit PLL post divider")
> Fixes: 2c4553e6c485 ("clk: qcom: clk-alpha-pll: Fix the pll post div mask")

I think one Fixes tag should be enough.

Nevertheless,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
> Changes in v2:
> - Pass 3 to GENMASK instead of 0.
> - Add more Fixes tag for reference root cause.
> - Link to v1: https://lore.kernel.org/r/20240925-fix-postdiv-mask-v1-1-f70ba55f415e@mainlining.org
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

