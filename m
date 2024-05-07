Return-Path: <linux-kernel+bounces-171018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4B8BDED8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FDF284E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC015D5C9;
	Tue,  7 May 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbJ6et/U"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4218821
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075025; cv=none; b=euZUIPK81BQDShAkLSoRBHnr16hjNg9c9j3536BeAqV4NSVN+2ENsLO2j9ekrKRAWYUmYcpeQwzdKGUmYs+4qYGWYUfhPQxQ9wX3Sbh6FY39Hb+cyLQcPrAtxb4efHPu3coJ5z/oNz6Za5yiQ6yM3sS9JohMlGiGzQs00zQG62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075025; c=relaxed/simple;
	bh=TIxu5CXQag5vSF552a9NObD/7GpXLUkpUNqx8KK1M5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcbrk0GlFL+xzSP6DwGoGdUbD5VdWhzJYaC2nAR5vfaqEQFIvy4e7kAqSc88Cf+HFCBA8wYp4ixLHsEPnDv9nTVz/H7/Vk5btzl+VkJa/Cu/1d+zzYSIkV0mmpnxTU7tb8YDJ06LVomhmiPFQloQy+LFFLR/91FspylXkF0RS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbJ6et/U; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2089a8154so941801eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715075021; x=1715679821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WAXawuu5D8QQ2TYYAPKkUCb+rSNneu0ioxRT40xBXrI=;
        b=fbJ6et/U+wc6TnrYH7HV/d2oc2jKp9K1xcbdpOypt0bcip/CRScFoVuuX98CInMHkO
         uitpafeR9ZD0a/+b2jzpe6l/TchfI8hMGwEFib8s/K2NrFUwSsahE303GgB/Spe8gAIO
         /Q87IgDf4Wjtt9ubfcFAXszSvzr6tmY2EW6lvBPopEIOcUDRbnddx8J46+UdkzbxvUql
         DEGmxTIHL65yzLj6/44xW9ukc7lLnu/t+dzAemfTrXufxOa2IsAA3FNDRGTJlZQDF4yJ
         Xn+7dyWjgOIspa7E5FOEKyTq+e2M4XqlitrTJ35q7QjqnoQ8xqjB+WKcbpPZfgabozKH
         tEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715075021; x=1715679821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAXawuu5D8QQ2TYYAPKkUCb+rSNneu0ioxRT40xBXrI=;
        b=kLij8R3jX/Fg8FztQsLHzU1mmKo06LYPnrqk8tngjfvj8JLmsbnjFsNgih5FU0uoi1
         IICm5tKA6nxrTWKJD7rG64oY+SPzhRIG+Y4Vv+IqyszHMP5UJcxZCMkoy8kZACSMM1iQ
         BF9zY+oOnx7ZzMVpgKnyet8wH4eVw3rOP/pmiLNl9EaSDH9Zae8SrP9OhgtFlN+yFAsq
         DW7WJ2oTXyFbQQUBuufjn3V2WJ6oaw6b1I33hKR4st67GKceqi0a84bvQCpH0FubOV+6
         S8Ro4MKIDNJNePkkA4Biha1/dA2Q67iXj03TYE/vwqK5kwj/frhEDa4S1MQQiNxelk4/
         WqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhouBVilQpc+/RMcMW/KU29USIs9ibC4ib44A7HgAFp6bo7tGLWhwXKtH0+2SYL9KAG/scIkQ750/if+Mf8U3oeoMi8mVy/rEtMzWM
X-Gm-Message-State: AOJu0Yxgow4IuQ+TuMUp9zseK/H+Emcg484qpX+tN3zR8zmISvhoBHAo
	uQQeJzY4ap0LvS9r6D5te1KXaAs0Lk56MeN2vEI5Va54z4+vgsnsGYCEtUvO+ZYljUESGeyT8ca
	PqF83X+lNno4W10ZGkxCOChXA8BYcimXNovabeg==
X-Google-Smtp-Source: AGHT+IEP48wfgx6CdP8hMqXLTcM/sINVEeKxbBEY+Ym2IiGsz9vT7W4IRWdx50FNfNNMTo400zHDOCxwnh6BJm9rM78=
X-Received: by 2002:a4a:5ac1:0:b0:5b1:b8a4:bce4 with SMTP id
 v184-20020a4a5ac1000000b005b1b8a4bce4mr11914180ooa.8.1715075021361; Tue, 07
 May 2024 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507055948.34554-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240507055948.34554-1-krzysztof.kozlowski@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 May 2024 10:43:30 +0100
Message-ID: <CADrjBPqp2ZaB0_J-rAZ2+A7BMHjW3o+rYSqMFgpdcbLausqL3g@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: gs101: drop unused HSI2 clock parent data
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 7 May 2024 at 06:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop static const arrays with HSI2 clocks parent data which are not
> referenced by any clock.  This might cause -Werror=unused-const-variable
> warnings.
>
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Closes: https://lore.kernel.org/all/8bf65df598680f0785c3d6db70acfb9a.sboyd@kernel.org/
> Fixes: 093c290084a4 ("clk: samsung: gs101: add support for cmu_hsi2")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks for the fix! These are actually the cmu_top parents and
shouldn't be defined here. They already have their own definitions in
the cmu_top section.

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

Peter

