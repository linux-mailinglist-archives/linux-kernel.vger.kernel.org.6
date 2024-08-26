Return-Path: <linux-kernel+bounces-300718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AAB95E792
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7348C281605
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7B7174F;
	Mon, 26 Aug 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVoD8QbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3446F2E0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645554; cv=none; b=pxFyu3o+F3lIL0YGlHHzuSn2pzT6adm/vBkIgaamDgQaFZYO0skl0m3kWgX8KjhWi77+Ad5LbV4nfR7u7x+I28mJzYvNjN5y0hMLeweR+K4pMQOCpx0Zr8gLeO6BCSnP3SIve022Zo0b0Eec7Jwyql2CfynRIekI7tW92xcKdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645554; c=relaxed/simple;
	bh=/lrwtogEFLiUD0yQcwy0DgYm1CyK4KyNMKlNshXlAiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkmFuT+zD59Qg1ycgvJ4J/WP6q8KAAG4leozw+VztP6eWziMssrDX6zi02dRrj4Nhi2AnU0fUCQjTwQBGaY+C3pUIuDTwwVpl+XCS0fm/U8WheQuhrGApeypJIa1JZv7ZE+VroDQ1aDGRIaPtVNB10q2HteSjhIAdp5KtvAng2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVoD8QbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E16C32786;
	Mon, 26 Aug 2024 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645553;
	bh=/lrwtogEFLiUD0yQcwy0DgYm1CyK4KyNMKlNshXlAiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BVoD8QbZnqdjJFV0fXriEuKnNS9Zlhd0JaOmInPzqfB+XNOYZPRLbxbIEh7wAghOS
	 T6R+IuYg1DRf8VC6ahwWj4vF1liHQkHK4oB+9QfTwGPCGyLF+wb1/f6tQpEM94zfed
	 26C3avVddnxIdB9aMT1bmDs8/DB/cicvduVL8U0s+w6OGaBQLScckp11bYOJulgSuO
	 JFWS6KhaUnax6ztB69lkB5DG4yTQ2+bB0wycqndgWAizoXrqg+eE5B4/v9JnzglH2c
	 BNS7WoEOlnefw19SDbbP9ZVuv24Jdbvhbqb/fhLfcgEBhtfP2/g4unnKC7kzIXSjCv
	 d3wz/0JpNewsw==
Message-ID: <d05f7fea-f13e-41e8-8416-3b410431127d@kernel.org>
Date: Mon, 26 Aug 2024 13:12:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] reset: cleanup and simplify with devm and scoped
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/24 11:14 PM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Two simple fixes, which do not cover real scenario (memory allocation
> failure during probe), thus not marking CC-stable. Rest of patchset is
> simplifying of code.

Patches that have a Fixes tag will likely be picked up for stable by Sasha's
bot anyway... Not a problem for these patches I think.

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       reset: berlin: fix OF node leak in probe() error path
>       reset: k210: fix OF node leak in probe() error path
>       reset: simplify locking with guard()
>       reset: lpc18xx: simplify with dev_err_probe()
>       reset: lpc18xx: simplify with devm_clk_get_enabled()
> 
>  drivers/reset/core.c          | 15 ++++-----------
>  drivers/reset/reset-berlin.c  |  3 ++-
>  drivers/reset/reset-k210.c    |  3 ++-
>  drivers/reset/reset-lpc18xx.c | 43 ++++++++++---------------------------------
>  4 files changed, 18 insertions(+), 46 deletions(-)
> ---
> base-commit: e706b1fe2384d38e6e9edfb6d9e11e26873c24c7
> change-id: 20240825-reset-cleanup-scoped-64bb3cb6157f
> 
> Best regards,

-- 
Damien Le Moal
Western Digital Research


