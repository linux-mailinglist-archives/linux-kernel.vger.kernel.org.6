Return-Path: <linux-kernel+bounces-300719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20ED95E793
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11341B20E40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4846450;
	Mon, 26 Aug 2024 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmAb9OPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038B2F34
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645590; cv=none; b=rw9pB4kqVbzPy9uxxwLHaKPqNR6dVZ+qoFvtgFmlwsDMDHmA5rGXOIqHJkx6Jd2MO2HkMw/8YBXZ2Bt62kZwshaL4ok6jUSHSgwXgCxtmEbTrfYmxdj/2TKt08K/VEyYo/O4kqh+jzUkuKCnu2oDFpFi4r5o/MPAofQCk2JCvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645590; c=relaxed/simple;
	bh=UW2nMlUeZn7NKIHJHCFR+luWnGF8nXJk9IcGAsYxwKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9b+kjai6PTUy6cq3d7/e6da3uaQf6f9B4CermlSbfwUUesFLQzhDqypKIxsikNu/qrT5wD5CAzzR3ipm8bSJJcI7kNbEyXO4VY8S4MmQF0FoIGLvAGPM0qs2EZtwrOCJPacVmOxz2OuGbery7dWS35G/368qWPAYraFPBVXWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmAb9OPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA755C32786;
	Mon, 26 Aug 2024 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645590;
	bh=UW2nMlUeZn7NKIHJHCFR+luWnGF8nXJk9IcGAsYxwKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qmAb9OPWYPlsjXt9AzutjVNlWEtO/AKOcThneJ6dSKewohKucMFIe4kWaqyXtE/60
	 pgynvz6ZEcgPdxHc5jAoH110z1BYTa7iSwjISpZI9MZ28shD6r1hNgMa6naazcmpvk
	 3fqohd2Hynx/SO/UH8tJzqexxMKd/3BNkOnif7ibqD2QRkqJ2EXSAnGHy87MnBCAjr
	 YlwSNKfEvVzjofNRedSPjuVGpbbzRqRvgPTStu2LPlxgadnA9v0vbrRH7DJRDsmg4L
	 lL1nIkAjojgvjR8lSH9TqZeD9IEYaqN9mJrDuZX/IQ310SBbsww/HjVVayX6v20B1U
	 OmebFfxLUPnOA==
Message-ID: <54a74f38-6b11-4b84-a9b1-709564f735a7@kernel.org>
Date: Mon, 26 Aug 2024 13:13:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] reset: berlin: fix OF node leak in probe() error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-1-03f6d834f8c0@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240825-reset-cleanup-scoped-v1-1-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/24 11:14 PM, Krzysztof Kozlowski wrote:
> Driver is leaking OF node reference on memory allocation failure.
> Acquire the OF node reference after memory allocation to fix this and
> keep it simple.
> 
> Fixes: aed6f3cadc86 ("reset: berlin: convert to a platform driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


