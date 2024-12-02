Return-Path: <linux-kernel+bounces-427653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77339E0449
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A7E283314
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF62040A7;
	Mon,  2 Dec 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPbXcQEp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C220408A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148134; cv=none; b=S8ZS8Uxo7nLf/4RW/RjZGo2vTpP74pa1glWCgfaK04u8ZppM8enuNu+lywpVfnOY6kyIcXKJmLT7xRpe6iFJTMhQQw1sr3VYJAdqgIAWsw7E5qkXX+Xp6fVXeoT0gKSobVFZhSqucSZTZvnVbnhKMqbNUxTC7d8MfOz8PRdrd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148134; c=relaxed/simple;
	bh=jJxlcqRxB873knVtlY401xtr37Z90jDtvx8oMXlNiPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=muNX8YAV5EqPtcyfPHrQ4QI7dB5K9hJHMKfhld7nNsZDl33QwqCP7dkuGN9N/Bq3vTezixbyMBSKRKf+tOKMDfDEHs4j1kMR/VmIPiI8rjMpNkvgfI5IRY/RotHytEwKRGdb18mKD3bsHaIPWYmU/Ht4xtl3b/CHJVz1OUrcw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPbXcQEp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e40aa2e6so126776f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733148130; x=1733752930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt9rbvg88W4Mm9rufdW2t6Ewrnb3f/HKBLkJJoL/hiY=;
        b=cPbXcQEpR+v+1F0ESx/yn6K016tyOZ90xmHzKs9eFufHLPd/Htwmp6RwU0C88/Gxgm
         SOjGNkibqUK+/0kg7uqcxYkq8iEUCgylj/kGHOf7+7x4W1H3xbQGUuFwMzbSYoZCmV3p
         V4cisD/L7bMH0glRxcu544Upj48fQeUjQK9V+PY+oT5sMgyIlSt25+HUOPaNpuxKr33L
         babHjzUafvf3OZPDDVmaqD4q0etRFuepSxM4MgzPDUvpJU3x58GfwiZNTq4d8DPAeaPl
         C1UVFquvJ8iul0YnjxNr0ghq3wNX+h7BBpnCD9yGQkvciChcKhrUaJr5fLKtlhNP1E2Q
         VF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148130; x=1733752930;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt9rbvg88W4Mm9rufdW2t6Ewrnb3f/HKBLkJJoL/hiY=;
        b=SCpPhvzWJS4LjYwi3xYUuS3nzzDjdZQ7U3t5r7bq5l+v3ztcCEZjRk+magSFuxMbfP
         7o0kj5KvElkSIN+49XE/VGJiE4mM4czip7hJT5RFp+bskCxN+AV4vnqVe5f9wXYH//9B
         vgNWL8XaQRwe9kTvc1obvZvZz6Amukdp1PUSjoPurd9HjGkU7KE2ikXGBlBLCysV/JMJ
         NEaIkRLNQmTpIfvfQYPbG2KHjmgHjpzj8Oa6ScZ7RjLJR8SVpw/RW2MeBeggnPFmkvcX
         3xfr14/8EiH4VdbVR6QNMFfOSIT6ebv77EPzLGdnmcshQ2lwuBhHE1PeAObPiLMCOoZe
         YSig==
X-Gm-Message-State: AOJu0Yxte5oWC7/rcVGlb0qxx6QtnT99sSwF+2ESfZTPaTV4D1NROHq8
	FpcFYTkh6YTp/VGoQf7jPmEL3lDehMHqrIbMbZhww4oKPGBZLSMHmuY7B6E2xUQ=
X-Gm-Gg: ASbGncs+9gomN7rip6Bz3+IAoLHWhvNQsvp2PnKH6QQH1TbUP/LfDrmkaEQOmSIRLfx
	N7Ox9bdNnWUau/PdyU50l9+Q30obhkBQsQ+hnW1KupTML2wpwofNZZkmk8M1g1LgsWaNYGV2BYv
	qKJcg9lc3pcXh+aL1nNb0umCvJhVSIs0iFkDmCtz4DVT9H6HKKV8vaUFGiL5+i3u+pC6qbslxBn
	XPUXSe6PqTdQp6m67bJOkeEWbCgJxCQCemKcJu1fEN2olDMzVai6gBGtrqmiTsP
X-Google-Smtp-Source: AGHT+IFbpzvvcbBvcWNOUYta+EWWguWeH07ZXYUdJCdTYkzN3I9OEgPah3/QG+sVL8wvnjrRt4H4Kw==
X-Received: by 2002:a5d:6487:0:b0:385:e9ba:acea with SMTP id ffacd0b85a97d-385e9baadf7mr2382448f8f.10.1733148128320;
        Mon, 02 Dec 2024 06:02:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eed2510esm4232260f8f.69.2024.12.02.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:02:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
In-Reply-To: <f148d823acfb3326a115bd49a0eed60f2345f909.1731844995.git.christophe.jaillet@wanadoo.fr>
References: <f148d823acfb3326a115bd49a0eed60f2345f909.1731844995.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] pinctrl: samsung: Fix irq handling if an error occurs
 in exynos_irq_demux_eint16_31()
Message-Id: <173314812685.47615.16378245073169097611.b4-ty@linaro.org>
Date: Mon, 02 Dec 2024 15:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 17 Nov 2024 13:03:32 +0100, Christophe JAILLET wrote:
> chained_irq_enter(() should be paired with a corresponding
> chained_irq_exit().
> 
> Here, if clk_enable() fails, a early return occurs and chained_irq_exit()
> is not called.
> 
> Add a new label and a goto for fix it.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: Fix irq handling if an error occurs in exynos_irq_demux_eint16_31()
      https://git.kernel.org/pinctrl/samsung/c/f686a2b52e9d78cf401f1b7f446bf0c3a81ebcc0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


