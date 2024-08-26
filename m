Return-Path: <linux-kernel+bounces-300720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3F95E794
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B80B2814F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F06BB4B;
	Mon, 26 Aug 2024 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMNVTCtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00D61FEA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645638; cv=none; b=KsOWh8GO4HWodq4z79xiDbA301Xq+dbJTYEv2lBXf+YXAIZKmHzGV11E2n4ti//rnTSCH24NX5Tu6rXykJOdloTH5hImgVKWAsFIoGbTEFZs3pIAJUEa8YzJzzQgIDbsY5khN+wnIvx/gBPit6Yr5T28dYTX6ohV6sxNN0S1HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645638; c=relaxed/simple;
	bh=KLcj7LaenBiRjHud3B33rKf203jvAY+27P+VFPykXvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nePkb5zm6gXAolcvnt6az9q1TsDnX8OCtkkEwfmqRX7kYUGWTPMW4oCZ1c15oMGZdwjVANPwIlBr0NSUoIgv0ErlEIQniDdQJ1NKADVPJQkbyZ151ex86eT6BvUtVGonsKoSUNTF6iD6T+BwG3JWvkZ0TRuIRe2YEiYWCvCLfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMNVTCtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA6DC32786;
	Mon, 26 Aug 2024 04:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724645638;
	bh=KLcj7LaenBiRjHud3B33rKf203jvAY+27P+VFPykXvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AMNVTCtfT5vO0PobqPxgiSaImI/PL8/znaroVIEa3brFD5jg35h6Zwhh5TXuLydJV
	 ubwTtyRrVB51e7RNAO72he0aCVccrQbhD4HjdiziIFZJrAsch4qvOqb4vR5oQnyeky
	 ZVeEXXpIUu754em8CB6XB0C7D+zSu6RkKIAxpsj6ZUDRCAUSbPbq/n1GDWghYxPeQX
	 g8dNvhyhlN2DZqw8bLkalY+QPODLQOfYlZodsTlwua59VumQujRfBp+p5yH6Mp4aGB
	 TU5rgWbbOh6kDMAR/TpgKhVTV3CGlcUu7iAFUFOe9RfF3Hn3nHF+AwASM0glKg3/An
	 oV+2xUSslZR5w==
Message-ID: <f1b64eab-5ed8-4c29-9a45-576da80bf86a@kernel.org>
Date: Mon, 26 Aug 2024 13:13:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] reset: lpc18xx: simplify with dev_err_probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Antoine Tenart <atenart@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
 <20240825-reset-cleanup-scoped-v1-4-03f6d834f8c0@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240825-reset-cleanup-scoped-v1-4-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/24 11:14 PM, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to avoid dmesg flood on actual defer.  This makes
> the code also simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


