Return-Path: <linux-kernel+bounces-300717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940B95E791
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC01F2157C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1EC46450;
	Mon, 26 Aug 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBKqip38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE663C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645503; cv=none; b=j2RNuZcbJTGBzUgW6q2a8hJVe2z+uuDmvDn3Selgk9m/uE1ujZHgwOmcjbL/+PthPB35HhqpfcAdkIf/nJhQPmr6AWscL58uxEZJD/wfjGLcECN6xRZmdH1Eonmb7fGTT2y92mhOua4sEjQoSFjvDu0xA2fVJ1vod6sJOMUntaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645503; c=relaxed/simple;
	bh=q4zLTK6jJh9Ouhg0CWmDF6JpWwLOZqwak5tvcYzeCw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4/qi0T++xOHwgSa0kqPzR/GpWxxHFKWWMdJVlD5l1r1RD7jdX9x8sC16OnTBfzboexnXmCO7rnIJ3YqLcR30FX7CZq2WEBsaIXVq30if5ERFMn+R28jkGYEtCn2JiyvibPROcjLtVbyvocI9nscE3wYMvlp3EjnoXA5SzpzChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBKqip38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D09C4AF0E;
	Mon, 26 Aug 2024 04:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645503;
	bh=q4zLTK6jJh9Ouhg0CWmDF6JpWwLOZqwak5tvcYzeCw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZBKqip38qTcw0FXgIElQ5rApVOMc3yVR19hGtfSxg/a+gSr9Pknu8ADTzd4Xv6Px4
	 dFfaWZS6KMBQODibCxiAQHvv5qS8fNhCnI4bVhrPzBYo9IvV6NzlFMeftnlc2bUndh
	 CdpyDUnG3HFnO4NKRRxqdK/XslOC/p3dM4BuacQfqlJ2aWbj7JsJb/CVHPHFkk4oIA
	 LaPd0iHLwzd7qC68ceSxDEyJDr0dXFr/mwOZi5jkiKkzTrCy2cnI8p3pE3hU2VI4AW
	 bkPHtiWnA4qZKwLJGw238JB0EcCdH5DY7yH8h1e5XjswVasd3NIpLkr8V7+CvhyL0a
	 9eiisAaSxZlsg==
Message-ID: <afad6db5-e33c-4402-adec-d1948300191a@kernel.org>
Date: Mon, 26 Aug 2024 13:11:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] reset: k210: fix OF node leak in probe() error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-2-03f6d834f8c0@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240825-reset-cleanup-scoped-v1-2-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/24 11:14 PM, Krzysztof Kozlowski wrote:
> Driver is leaking OF node reference on memory allocation failure.
> Acquire the OF node reference after memory allocation to fix this and
> keep it simple.
> 
> Fixes: 5a2308da9f60 ("riscv: Add Canaan Kendryte K210 reset controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


