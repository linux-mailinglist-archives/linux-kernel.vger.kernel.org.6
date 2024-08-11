Return-Path: <linux-kernel+bounces-282233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927594E12B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF89AB211E4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593750285;
	Sun, 11 Aug 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiMrsrru"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6243EEBA
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379597; cv=none; b=dtBA7cF18mY2jpwekrhVPBYtODDAT3iplR74JE8hG9g5Qk69N0qmTrHmxgWgOxhXa//bNbe93Gx8EGE7pDqLFO6121NI/kZRE1I+9TObFgYuLOMRDswdIULipr5A5uCndgNR/UpDNn9CmDgPKhbodjAcsex8O2/wAHOqkhXtlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379597; c=relaxed/simple;
	bh=S3fNwvE0TVeaUhR1lSr26rsVw/rdv1BrEWmcfyjA0Ow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O7RpCdM19GjZ2XZNwFJDR6IPN48mak22gcmYe2jxV+I71RuWTaQ/UA43t17q5+MeziT17y7Iy9elM0RzAoqQVqWdFRexQNDIhIW6h68qByH7Drri343bdzymvqa5ietZMKaFnym3NzA7kvWHeDE8H2DRQUaQqICCdb82mpHtDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KiMrsrru; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so23437015e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723379593; x=1723984393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Rnu0VCR5IShg3PF5pHMVjCLb7CLFzjALDVNPy1uEU=;
        b=KiMrsrruOVNfBeLLMKblNBIQ/HLqOgyh6NGxrMvDNCec2momCex1xCFA9VkhEAih5R
         YV5ZN6+Yu3ZHtBjZIc52VZEUl1p7boqMbYiy/HLzh2JQvYVe746fJ6G99IEz/QIEtfOE
         p7ljRsDIrETbmL5juVVLk5kYaqq8WGKqWEuHsrio5/9HbfkudmZlF/2s3NXIwKbGHSz+
         09FlNhi1n/7VkzKxXaXk0SPdiZ0lY2kiC3qHnhH5TX8pm4yBkke7b8QoQIbP2u/lVZOe
         w6QZPV/BFcXIPIuB4xBTh8Otrwv1cXkdiEA4x8ZV6xEe0i0eGPPFe+tTT19+3KSFJnKW
         PB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723379593; x=1723984393;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Rnu0VCR5IShg3PF5pHMVjCLb7CLFzjALDVNPy1uEU=;
        b=m6q5HsdBFLFTxkM/UntCla0Ka5BNAud/OOfshkHaOU7VoeCa31vTVtNRswAuWKMjAU
         ovT/GenoiG8UBS53NahyMGRlnh+XpMYPKDRa2I6e+rxnSxd/APDEk0gZ7V3l4hwEhtl5
         XVuot/rWeZE07YR6DeJI3+6P3XA7+mFO+A5ErfstU52GI6QSr3ui1TXG81l6lNxYjG8B
         vGA4X83XiPZcTX8wb2nkuPr15RVvwcE1oVvdKRZ3syCtlIEasxk0Ltiu8egLpVyUtUdy
         FoE4OHByfa20e6FqPNbJW8FIwzt5oy2pX3Q3Wy4IQRwBvAXeRerkb9icGS/Ie/ZzY0n9
         QZkA==
X-Forwarded-Encrypted: i=1; AJvYcCWWFbJA+HAYo/CtCsmvTzAp3ZFPfZeyKGxk9D37qt1bqMA+epLYNb+jmXtXLfzugjIOQybp5/1uotShoSTEQ3ZxVd/EFcrfYmYeZ59U
X-Gm-Message-State: AOJu0YywQnsSHdEU1f5OmZ6qMo+bqFKaJaJFGOxkCZFspG7PWJY9CZEl
	WkIoYjS24LCLiFC4fvtm9ZevLlJLW97TWYq9emv5OMJ02Xc2WLFwiPFu2b0WOl4=
X-Google-Smtp-Source: AGHT+IEhKZ8qU4PuyOfDJWIZVr3aDV7eO1eH0G9Q1CiZCiy5l4fnT5o4i79tJXzhmOSskN+IDF26EA==
X-Received: by 2002:a05:600c:19cd:b0:426:6688:2421 with SMTP id 5b1f17b1804b1-429c3a227d0mr44200595e9.11.1723379593001;
        Sun, 11 Aug 2024 05:33:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm148055605e9.39.2024.08.11.05.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:33:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Park <chanho61.park@samsung.com>, 
 Tomasz Figa <tomasz.figa@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Kwanghoon Son <k.son@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240809-clk_dpum-v3-1-359decc30fe2@samsung.com>
References: <20240809-clk_dpum-v3-0-359decc30fe2@samsung.com>
 <CGME20240809115500epcas1p32a698c821765e1a0d5fa998e6e08f1cd@epcas1p3.samsung.com>
 <20240809-clk_dpum-v3-1-359decc30fe2@samsung.com>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: clock: exynosautov9: add
 dpum clock
Message-Id: <172337959149.7186.17092334492330898748.b4-ty@linaro.org>
Date: Sun, 11 Aug 2024 14:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 09 Aug 2024 20:54:12 +0900, Kwanghoon Son wrote:
> Add dpum clock definitions and compatibles.
> 
> Also used clock name 'bus' instead of full clock name
> dout_clkcmu_dpum_bus like other board cmu schema (GS101).
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: exynosautov9: add dpum clock
      https://git.kernel.org/krzk/linux/c/ccb41c445a3e9506ef43fe33867a356048e41477

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


