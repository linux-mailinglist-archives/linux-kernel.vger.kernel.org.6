Return-Path: <linux-kernel+bounces-404055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF089C3E93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D0D1F223FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D919CD0E;
	Mon, 11 Nov 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eofYajba"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E414B962
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328873; cv=none; b=cTmYDdic1vVGnZKbnho2VEjlG3kSF0UvTJw8SlBACF8L9lQk1nuAnRo+EB76Z+k9tmbFN7G/Ud/amZwcuDpG3n/H4UMaHDaxm5BDkeNoL8hFO8gSCngUMFoZmsonr8/5Q1WbG7ppu4oXV/yxcSNpRlEfQ90QXbu+jQHu6o1Yhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328873; c=relaxed/simple;
	bh=oZtApR3Nvo8c5QYGJJ2/iy40iqXBsN8XPrQDDZjb0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hywk3wMtCRPoOI/K4rChdHV2hxYxHcLYfIxl9ailRm1xLzjU1Y/4+Bl2skwfdwBhMUt0wR/Fv1iiwv/od0J+j7f/yA48M82H+G1I77z23tr7OYJv/Wj8CS7QbG7506kHHKHLq/XsCB68r21N8znJ1hQvdr8JpmewFbxobtR2HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eofYajba; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso57839871fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731328868; x=1731933668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4HfV0PqO8tzYHX6VGeaFbi66mw59nhOAbviLCfOiqI=;
        b=eofYajbacxO7Qc2Sefc5ff8v5uoVgpoZNxq27Ktw8YmcH8oMadqUJn0/6ocTUXIPEn
         nPEvgJvnpRJaooLJio91VyK0DQQLvoNezQJEIL7ZufctLtKcT+rZJ325eFThD5/Ag1wb
         tLqYsevvjOX3GGcV9gGnHR8qKXYHRm0WZ/3hytwc3UR4g3KIBeISFrSMGXfNnfgzp1iy
         jfaGqQPRUfr8hyjmu2g36Y78JVypEp+7pZHJxZSehouIY2orloHWX2rLbetpLUDinaJw
         hgeJu7Ld5Q7cx/Gkj90NlvGTZ7GuZFAC0nBCRm3DKWSsvAFvLjTukFSxhFP0d0LOvD3k
         RCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731328868; x=1731933668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4HfV0PqO8tzYHX6VGeaFbi66mw59nhOAbviLCfOiqI=;
        b=vjOyvEDDidZ9BuDJD5kCw+IhkpK4sIwZ/kjqWEMtAffPq7+AVdfxjX3FuOHMk5DShr
         2aVPH9fVXNqcuxEFeaezfOLQwWzIv49jmbhtFUoFM0ZCOkJjUjepQch0yDcldJCrbtni
         Itmd3KydYcsn4zcdqgmcuIB783TMfAFwXnhNM2l3YKXsX5cYyAVdTEzYySh3MWGeWaSA
         1ankjXb6CwvRBEap/5XF0vrsXkxBAEdJMrh3UGGgpSSUfh8611nDt/dCov7I/FU9Z5Pg
         wYrZXr4nx1qCmtiRwrQm8zL2etdE0OlsegmAqLazQUauznwjxmJp2VjEEWccyEZ3KQCz
         g6gg==
X-Forwarded-Encrypted: i=1; AJvYcCXfTQVh1uOuZU5IIQhreErOf7Yn9IJniUXLbZTYUExheLL3CCApsV+L9BWzN94BbvkGpml6BtwzBOMB+Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZisSWaPFPbAmO05EM7bEy5OwL4noT1OiVsZwkzGeEP4MEtwHv
	NVvFR0J288ypoS+aWvw289RAnosq3X76Yf0fl56JD4d8h4vEJO2Xs483VfNaheA=
X-Google-Smtp-Source: AGHT+IFDMxq8JQgZ3yOqv+TOrWdr8ZF25uS3cMX5x65ZUfZh/LXbHYlIqPk6dU3NKQ7IV2xJigL9fQ==
X-Received: by 2002:a05:651c:1143:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2ff2020794bmr90292661fa.22.1731328868289;
        Mon, 11 Nov 2024 04:41:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff1790262fsm16754411fa.63.2024.11.11.04.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:41:07 -0800 (PST)
Date: Mon, 11 Nov 2024 14:41:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: remove unused data from gcc-ipq5424.c
Message-ID: <r2se3v53h7pnx527bgsswpkjhkqx2csrwlxpzai7l6lanbjjty@e4nljcvgors3>
References: <20241111103258.3336183-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111103258.3336183-1-arnd@kernel.org>

On Mon, Nov 11, 2024 at 11:32:51AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver causes a warnings when enabling -Wunused-const-variables:
> 
> drivers/clk/qcom/gcc-ipq5424.c:1064:30: error: 'ftbl_gcc_q6_axi_clk_src' defined but not used [-Werror=unused-const-variable=]
>  1064 | static const struct freq_tbl ftbl_gcc_q6_axi_clk_src[] = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-ipq5424.c:957:30: error: 'ftbl_gcc_qpic_clk_src' defined but not used [-Werror=unused-const-variable=]
>   957 | static const struct freq_tbl ftbl_gcc_qpic_clk_src[] = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-ipq5424.c:497:30: error: 'ftbl_gcc_qupv3_2x_core_clk_src' defined but not used [-Werror=unused-const-variable=]
>   497 | static const struct freq_tbl ftbl_gcc_qupv3_2x_core_clk_src[] = {
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In order to hopefully enable this warning by default in the future,
> remove the data for now. If it gets used in the future, it can
> trivially get added back.
> 
> Fixes: 21b5d5a4a311 ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5424 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

