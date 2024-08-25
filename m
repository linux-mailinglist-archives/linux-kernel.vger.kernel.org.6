Return-Path: <linux-kernel+bounces-300556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B895E50B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D3F1F224E4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FD664C6;
	Sun, 25 Aug 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="XqaApIbP";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="XqaApIbP"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A18801
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724616973; cv=none; b=nTtKY+DLyyv0eQJzU8puO8g08Ajr9qdkMZE+XTPk6grD/NoUEXCmzxWBKgOLC5oqcaa+qXJ4erVParLndkHbgOSB56GaE7s1qj54bNTfHxr/osxejeVFadhj7R6TsqxDCfXYThr+mFXmr/OutxHf5D+AASBpBHIKjx3tDMf4vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724616973; c=relaxed/simple;
	bh=5lyLtuK442hALGuwG8Tt3Yh0ybt3qVKtb7SW/dSDUEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozTnxGMwz6R6aj/JpV6SjuY9lN7SCTfIL4vVZjseCRHFapHaimrQx3e6vLdYLVK7D3+dHlJ7Rg/juQdrmzohOxGRMA24UkSptvypKkPF3SKBCJrdJcpyX2l89pC7MVWfCKc1DZRwMLdNuRF2dK4aF1hwVe7Cqy4DjA6GEWj2+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=XqaApIbP; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=XqaApIbP; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724616963; bh=5lyLtuK442hALGuwG8Tt3Yh0ybt3qVKtb7SW/dSDUEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqaApIbPi8gbYOJgm3Cx0J5MKtuEoFyJS6qK+OJfVdHhe4WUPDbIQfEHl5ed8vvVr
	 hXhAp0RRNjCJ7CsnB0oB+GPMKHvQ6dAGQjfcDFtidDDwaFUtkB6Cyk5sJJ9jOaKkaS
	 Swtv0rgUVNxMHzwWCpz2CTRG6500aafIsJvLu6a1nwruSzKu3ooDn2MzivE1Ekewcw
	 t4X7qjLExMqf1xNaXEndubAQICaby9hhF5nxMZCGTB/Pu+2ewMoGyplYKpl3cOMPrO
	 sGVXZDWImFrdKPmKyADZQFJwO35W3uYbKqBNCye+msFpTMINFyKe4BKqyzuyI/YeoA
	 oUGxVevfi+Jtw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id A107516C9;
	Sun, 25 Aug 2024 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724616963; bh=5lyLtuK442hALGuwG8Tt3Yh0ybt3qVKtb7SW/dSDUEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqaApIbPi8gbYOJgm3Cx0J5MKtuEoFyJS6qK+OJfVdHhe4WUPDbIQfEHl5ed8vvVr
	 hXhAp0RRNjCJ7CsnB0oB+GPMKHvQ6dAGQjfcDFtidDDwaFUtkB6Cyk5sJJ9jOaKkaS
	 Swtv0rgUVNxMHzwWCpz2CTRG6500aafIsJvLu6a1nwruSzKu3ooDn2MzivE1Ekewcw
	 t4X7qjLExMqf1xNaXEndubAQICaby9hhF5nxMZCGTB/Pu+2ewMoGyplYKpl3cOMPrO
	 sGVXZDWImFrdKPmKyADZQFJwO35W3uYbKqBNCye+msFpTMINFyKe4BKqyzuyI/YeoA
	 oUGxVevfi+Jtw==
Message-ID: <6964ae1f-bffc-4506-8395-8450c54289b3@mleia.com>
Date: Sun, 25 Aug 2024 23:16:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] reset: lpc18xx: simplify with dev_err_probe()
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-4-03f6d834f8c0@linaro.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-4-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240825_201603_690675_DE4F0632 
X-CRM114-Status: UNSURE (   4.48  )
X-CRM114-Notice: Please train this message. 

On 8/25/24 17:14, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to avoid dmesg flood on actual defer.  This makes
> the code also simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

