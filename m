Return-Path: <linux-kernel+bounces-521516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B2A3BE59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F9A169D63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204A1E25EB;
	Wed, 19 Feb 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha4FM+Mt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE01E0B61;
	Wed, 19 Feb 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968955; cv=none; b=KJvtRh87HoQC6vboVt97ReUIpdZ4yYUchKjW0xvW+QkEE/zDUlSujZTTIcT0tA8dYmXFKwkqGJrbcI8JsRy4CSO12Fpk46gPoHz1qzrbpQ3vKofru4E8JZfRtb8TTdglqdhLLyPXzAqxVBw5XkYQ0RnC+nM4reIsXCLjh24C29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968955; c=relaxed/simple;
	bh=pE+n3hF9XW3Ek/Ggngk8vtCwn6fa99/elpOQc2SHUVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahlTK16lOu5UmMCTinR6+ZO0ADvWPvH3utQEwpNR1NEvsSTdUEkgqkYv/gW+8Jkuplf9AaJccLNvWCSvIV2Sxs54+yEEghR+elwh6Kl8RUNfJDWVhB5NbZNxhd1XsJhD4bCHlWUDf3VAKFy56Y1bkzwf6Jl86gzGwuGO8i/RSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha4FM+Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5251BC4CED1;
	Wed, 19 Feb 2025 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739968955;
	bh=pE+n3hF9XW3Ek/Ggngk8vtCwn6fa99/elpOQc2SHUVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ha4FM+Mtw/7PMR99p4Silac6jsb7S5msE4bWT3zvvkinsAe/iHY385zmcuveYr3Yv
	 xgy4DRg5dR95OQfF/1N2olWfUTDddhdQf6YQ+w0Pzmi2bclsOu0blOx5UF7ZVnohjM
	 7J2kXlHyLebRs+ZDz3vxinAL82ubtsLD4YYgxW/VBtLDB67IxWfPd2+C4hkAzI25FP
	 UwU5p6uzI4/s4nwlhCBs5rtvqZAEp4x0pTziwkQ54ETMOtv9Pqd5qj+d1ZTHuqy0UI
	 MQOqGGdQrI67E0ox0ooP4TycR6qofpp5lWh4ZofmtZBRu4bgD4UC9e1sn4Mf2+bHxH
	 1wWwtl/ggKrbA==
Message-ID: <d7df3b86-c3ff-48af-ad72-428e105976b9@kernel.org>
Date: Wed, 19 Feb 2025 06:42:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] clk: socfpga: clk-pll: Optimize local variables
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219104224.1265-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250219104224.1265-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 04:42, Thorsten Blum wrote:
> Since readl() returns a u32, the local variables reg and bypass can also
> have the data type u32. Furthermore, divf and divq are derived from reg
> and can also be a u32.
> 
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of divq to u32 removes the following Coccinelle/coccicheck warning
> reported by do_div.cocci:
> 
>    WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> 
> Compile-tested only.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/clk/socfpga/clk-pll.c | 4 ++--

Applied!

Thanks,
Dinh


