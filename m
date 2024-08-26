Return-Path: <linux-kernel+bounces-300721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F149795E795
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95D01F21928
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44529D1C;
	Mon, 26 Aug 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/LlJsKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F12282F4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645725; cv=none; b=drf1owy1Xd1XX4rJ97tMpK/XuEnCFM9BMS0aLc+oBolUK22Wt6nEgkgnwIw7HQILrWdSM5yj9PYEurpQ+rDxAbFninkVXdpK9AIuS9xrivSJFKjgeIUJgXWlHh95aBxC/GkKb0MtChjawmUhjK8gGNbuek7DUHTChS8ZV8xe5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645725; c=relaxed/simple;
	bh=qPyOuK3WKJKf/LHhCGY6w3y9hfA/xo4Ff/I3pICqgik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRLF5HEGFvgZDdv4sQRtUzppwQz897WNMDHG8nBpmOlpcjfXPqqOmJ7cZv8/UigklMG6voRmjmzvhdNV+xsd0V5lTc+V/NTznjcNZl4jbOdjUUT7wv73HAxSACn/BNWe67a7LI2BjgtW9/lFyp9kaOpta09louaekdVI6ejmknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/LlJsKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1234DC4AF13;
	Mon, 26 Aug 2024 04:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645724;
	bh=qPyOuK3WKJKf/LHhCGY6w3y9hfA/xo4Ff/I3pICqgik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u/LlJsKf3EjoRE1UIG3qpHbW4LgYIiYyH3shH8J3Ylh+GTF+6TrFEoz/1BRi493lK
	 Ioxs6AsSwyYN66D8kybrHhPUTcNz0XLRCYPDfg7dD/Y2tsRAGvWwQKDvpidn6ep4m2
	 v57k4JNGu1tQQ//5LFo30twO2Uee/JA5jkgdAg7RjgVnvckGZ11Cixa1LI8ggWDi9s
	 aXz2X6elWLKKsNbrPtvCE6IERUxfURAZo/ignx75y6Lymm2TZG0xqUcO6aFLwiFOVo
	 p4sa2EYIj/kQq4fAX5Y6txjAUb8m98wufEOFS7t82JV9fVXn78qkVq3XK0OlYznitX
	 LIvSuLhzqCpug==
Message-ID: <6a87416d-e6ba-4f4b-8c1e-bed622eb60bd@kernel.org>
Date: Mon, 26 Aug 2024 13:15:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] reset: lpc18xx: simplify with devm_clk_get_enabled()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-5-03f6d834f8c0@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240825-reset-cleanup-scoped-v1-5-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/24 11:14 PM, Krzysztof Kozlowski wrote:
> Use devm_clk_get_enabled() to drop clock prepare/unprepare parts and
> make code simpler.  Change to dev_err_probe() in handling

s/code/the code

> reset_controller_register() error to make it even simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Other than this nit, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


